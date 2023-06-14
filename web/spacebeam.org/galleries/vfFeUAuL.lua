--[=[ Thread library.

Using like this:

Thread = require'thread'

local audiothread = {}
audiothread.func = [[
	require'love.sound'
	require'love.audio'
	require'love.timer'
	local sound = love.audio.newSource('sound.ogg')
	while true do
		data = thread:pop()	-- threads has access to special object
		if data == 'play' then 
			sound:play()
			thread:push('Yea!')
		end
		love.timer.sleep(.01)
	end
]]

function audiothread.receive(msg)
	print(msg)
end

-- name, thread function and set of callbacks {receive, finish}
music = Thread('Music', audiothread.func, {receive = audiothread.receive})

music:send('play')
function love.update()
	music:update()
end

]=]
if not love or not love.filesystem or not love.thread then 
	error('This plugin for LOVE2D framework, and not works with other lua-builds'..
				'Also it requires love.filesystem and love.thread modules', 2)
end


if _VERSION == "Lua 5.1" then
	local rg = assert(rawget)
	local proxy_key = rg(_G, "__GC_PROXY") or "__gc_proxy"
	local rs = assert(rawset)
	local gmt = assert(debug.getmetatable)
	local smt = assert(setmetatable)
	local np = assert(newproxy)

	setmetatable = function(t, mt)
		if mt ~= nil and rg(mt, "__gc") and not rg(t,"__gc_proxy") then
			local p = np(true)
			rs(t, proxy_key, p)
			gmt(p).__gc = function()
				rs(t, proxy_key, nil)
				local nmt = gmt(t)
				if not nmt then return end
				local fin = rg(nmt, "__gc")
				if fin then return fin(t) end
			end
		end
		return smt(t,mt)
	end
end

local namelist = {}

function namelist:checkName(name)
	for i, v in ipairs(self) do
		if name == v then return true end
	end
end

function namelist:removeName(name)
	for i, v in ipairs(namelist) do
		if name == v then 
			table.remove(namelist, i)
			break
		end
	end
end

function namelist:getThreads()
	local s = ''
	for i, v in ipairs(namelist) do
		s = s..v..'\n'
	end
	return s
end

--class with set of thread functions

local ThreadClass = [[
	do
		arg = {...}
		local t = {}
		
		t.name = "TREAD_NAME"
		t.inner = love.thread.getChannel(t.name.."_i")
		t.outer = love.thread.getChannel(t.name.."_o")

		local link = {}
		function link:new(inner, outer)
			return setmetatable({inner = inner, outer = outer}, {__index = link})
		end

		function link:clear()
			self.inner:clear()
			self.outer:clear()
		end

		function link:push(data)
			local succ, err = pcall(self.outer.push, self.outer, data)
			err = err and error(err, 2)
		end

		function link:pop()
			local succ, v = pcall(self.inner.pop, self.inner)
			if not succ then error(v, 2) end
			return v
		end

		thread = {}
		function thread:newLink(name)
			local nameA, nameB = self:getName(), name
			if nameA > nameB then
				return link:new(
					love.thread.getChannel(nameA..nameB..'_blue'),
					love.thread.getChannel(nameA..nameB..'_red')
				)
			else
				return link:new(
					love.thread.getChannel(nameB..nameA..'_red'),
					love.thread.getChannel(nameB..nameA..'_blue')
				)
			end
		end
		
		function thread:clear() t.inner:clear(); t.outer:clear() end

		function thread:push(data) 
			succ, err = pcall(t.outer.pop, t.outer)
			if err then error(err, 2) end
		end

		function thread:pop()
			succ, v = pcall(t.inner.pop, t.inner)
			if not succ then error(v, 3) end
			return v
		end

		function thread:getName() return t.name end

		function thread:getCount() return t.inner:getCount() end

		function thread:popAll()
			local o = {}
			local data = thread:pop()
			while data do
				table.insert(o, data)
				data = thread:pop()
			end
			return o
		end
	end
]]

--remove comments
ThreadClass = ThreadClass:gsub('%-%-.-[\n\r]', '')

--[[Replaceing all newline characters for make code-oneliner.
	Errors returns number of line with error, but a lot lines of code before user
	function make finding line with error too difficult. Oneliners avoid it.]]
ThreadClass = ThreadClass:gsub('[\n\r$]+', ' ')

--remove all tab characters because i want to remove it (pretty style)
ThreadClass = ThreadClass:gsub('[	]+', '')
--i love gsub so much!

--main thread class
local thread = {}
setmetatable(thread, {__call =
	function(self, name, userfunction, callbackList)
	--name - name of thread for named channels and links
	--userfunction - string or path to file with thread code
	--callbackList - table like this: {receive = function()...end, finish = function()...end, ...}

		--assertions
		name = type(name) == 'string' and name
			or error('Thread: arg#1 name as string expected, got '..type(name), 2)
		userfunction = type(userfunction) == 'string' and userfunction
			or error('Thread: arg#2 thread function as string expected, got '..type(userfunction), 2)
		--check name
		if namelist:checkName(name) then error('Thread "'..name..'" already exists', 2)
		else table.insert(namelist, name) end
		--check callbacks as functions
		if callbackList then
			for k, v in pairs(callbackList) do
				if type(v) ~= 'function' then v = nil end
			end
		end
		--if function is path to file - load it
		if love.filesystem.isFile(userfunction) then
			userfunction = love.filesystem.read(userfunction)
		end

		local class = ThreadClass:gsub('TREAD_NAME', name)
		--set name of thread

		local o = {}
		o.name = name
		o.thread = love.thread.newThread(class..userfunction); class = nil
		o.callback = callbackList or {}
		o.channel = {}
		o.channel.i = love.thread.getChannel(o.name.."_i")  --main --in channel--> thread
		o.channel.o = love.thread.getChannel(o.name.."_o")  --main <-out channel-- thread
		o.dbg = true
		self.__index = self
		self.__gc = function(self)
			self:clear()
			namelist:removeName(self.name)
			print('thread '..self.name..' collected')
		end
		return setmetatable(o, self)
	end,})

local callbackNames = {'receive', 'finish', 'error', 'kill'}
local function checkCallback(name)
	if not name or type(name) ~= 'string' then error('Thread:setCallback(name, func) arg#1 string expected got '..type(name), 3) end
	for i, v in ipairs(callbackNames) do
		if v == name:lower() then return true end
	end
end

function thread:setCallback(name, f)
	if not checkCallback(name) then error('Thread:setCallback(name, func) arg#1 name must be "receive" or "finish" or "error" or "kill" ', 2) end
	--List of name:
	---receive: function(self, msg) Calls if thread send the message to parent program.
	---finish:  function(self, ...) Calls if thread finish self work. '...' contain all unreaded messages
	---error:   function(self, err) Calls if thread got error.
	---kill:    function(self)    Calls if parent program kill the thread.
	self.callback[name:lower()] = f
end

function thread:start(...)
	self.thread:start(...)
	self.state = 'run'
end

function thread:kill()
	local res = self.callback.kill and {self.callback.kill(self, self:receiveAll())}
	self = nil
	collectgarbage()
	return unpack(res)
end

function thread:wait()
	self.state = 'wait'
	self.thread:wait()
end

function thread:isRunning()
	return self.thread:isRunning()
end

function thread:getError()
	return self.thread:getError()
end

function thread:send(data)
	self.channel.i:push(data)
end

function thread:supply(data)
	self.channel.i:supply(data)
end

function thread:receive()
	return self.channel.o:pop()
end

function thread:receiveAll()
	local o = {}
	for i = 1, self.channel.o:getCount() do
		table.insert(o, self:receive())
	end
	return o
end

function thread:clear()
	self.channel.i:clear()
	self.channel.o:clear()
end

function thread:getCount()
	return self.channel.o:getCount()
end

function thread:getChannel(name)
	return  love.thread.getChannel(name)
end

function thread:debug(v)
	self.dbg = not not v
end

function thread:getThreads()
	return namelist:getThreads()
end

function thread:update()
	if self.state == 'run' then
		if not self.thread:isRunning() then
			self.state = 'finish'
			if self.callback.finish then
				self.callback.finish(self, self:receiveAll())
				self:clear()
			end
		end
		
		local err = self.thread:getError()
		if err and self.dbg then print('Thread "'..self.name..'" err: '..tostring(err)) end
		if err and self.callback.error then
			self.callback.error(self, err)
		end

	end
	if self.callback.receive then
		for _, data in ipairs(self:receiveAll()) do
			self.callback.receive(self, data)
			if self.dbg then
				print('Thread send msg: '..tostring(data))
			end
		end
	end
	collectgarbage()
end

return thread