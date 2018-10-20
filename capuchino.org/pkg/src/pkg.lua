#!/usr/bin/env luajit
--
-- Spawn multi-dimensional nodes of monkey daemons — all operations run using the pkg command.
--
local argparse = require("argparse")
local socket = require("socket")
local uuid = require("uuid")
-- init random seed
uuid.randomseed(socket.gettime()*10000)
-- Session UUID
local session_uuid = uuid()
-- Erlang/OTP release
local release = "/_rel/daemons_release/bin/daemons_release"
-- Parse CLI arguments
local parser = argparse() {
   name = "pkg",
   description = "pkg command line toolkit.",
   epilog = "Remember, as your units grow in number, you must spawn more nodes to control them."
}
-- spawning daemons at location
parser:option("-s --spawn", "spawn daemons on location", "/opt/daemons")
parser:option("-u --unit", "unit name, uuid or hash", false)
-- pkg command
parser:command_target("command")
parser:command("spawn")
parser:command("search")
parser:command("install")
parser:command("remove")
parser:command("start")
parser:command("repair")
parser:command("status")
parser:command("run")
-- local system variables
local build = "singularity build ~/.pkgs/"
local runsc = "singularity run --writable ~/.pkgs/"
local daemons = "git clone https://github.com/spacebeam/daemons"
-- error messages
local errors = {
  'Can I take your order?',
  'Go ahead HQ.',
  'container unit?',
  'Input unit.',
  'When removing your overhead luggage, please be careful.',
  'In case of a water landing, you may be used as a flotation device.',
  'To hurl chunks, please use the vomit bag in front of you.',
  'Please keep your arms and legs inside until this ride comes to a full and complete stop.',
}
-- responses
local messages = {
  'In the pipe, five by five.',
  'In transit HQ.',
  'Buckle up.',
  'Strap yourselves in, boys.',
  'I copy that.',
}
-- parse arguments
local args = parser:parse()
-- until more complete implementation print args on exec time.
print(args)
-- rage against the finite state machine
if args['command'] == 'install' then
    if args['unit'] then
        print( messages[ math.random( #messages ) ] )
        print('Installing unit '.. args['unit'])
    else
        print( errors[ math.random( #errors ) ] )
    end
    -- install some singularity container/unit
elseif args['command'] == 'start' then
    os.execute(args['spawn'] .. release .. " start")
elseif args['command'] == 'status' then
    os.execute(args['spawn'] .. release .. " ping")
elseif args['command'] == 'run' then
    os.execute(execute .. args['unit'] .. ".img")
elseif args['command'] == 'repair' then
    print(messages[math.random(#messages)])
elseif args['command'] == 'remove' then
    os.execute("rm -Rf ~/.pkgs/" .. args['unit'] .. ".img")
elseif args['command'] == 'search' then
    print('search')
elseif args['command'] == 'spawn' then
    os.execute(daemons .. " " .. args['spawn'])
    os.execute("curl -O https://erlang.mk/erlang.mk")
    os.execute("mv erlang.mk " .. args['spawn'])
    -- if crash remove erlang.mk from current directory.
    os.execute("rm erlang.mk")
    os.execute("cd " .. args['spawn'] .." && make all")
else
    print('do something else')
end
