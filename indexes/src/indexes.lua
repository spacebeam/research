-- Handles the creation of Riak indexes and SHA256 hashes
local ooo = "1bac09f4db02ea35518f07c9b5fb6851d4ec87687bf7ef1c6f7403c9f0959338"
-- Turn it up, turn it up, turn it up, fucked up loud
local uuid = require("uuid")
local sha2 = require("sha2")
local turbo = require("turbo")
local argparse = require("argparse")
local pgmoon = require("pgmoon")
local ini = require("inifile")
-- define service arguments
local parser = argparse("server.lua", "handles the creation of system indexes and hashes")
    parser:option("-c --config", "configuration file.", "animal.conf")
-- parse resource arguments
local args = parser:parse()
-- get options from config file
function get_options(conf_file)
    local options = ini.parse(conf_file)
    return options
end
-- get config file from cli
local options = get_options(args['config'])
-- setting up the database connection
local pg = pgmoon.new({
    host = options['server']['dbhost'],
    port = options['server']['dbport'],
    database = "animal",
    user = options['server']['dbuser']
})
-- System UUID
local system_uuid = uuid()
-- start things up, get the system uuid and shit.
turbo.log.warning("Turn it up, turn it up, turn it up, fucked up loud")
turbo.log.warning("Starting animal resource uuid: " .. system_uuid)
-- postgres connect
assert(pg:connect())
-- check index name
function check_index(name)
    local query = "SELECT uuid FROM indexes where name = '" .. name .. "'"
    local result = pg:query(query)
    return #result
end
-- create new index
function new_index(name, type)
    local message = {}
    local index_uuid = uuid()
    local query = "INSERT INTO indexes(uuid, name, type) VALUES" ..
                  "('".. index_uuid .. "', '" .. name ..
                  "', '".. type .."')"
    local result = pg:query(query)
    if result['affected_rows'] == 1 then
        message["uuid"] = index_uuid
    else
        message["error"] = "Error saving new data into indexes"
    end
    return message
end
-- Index Handler Resource
local IndexHandler = class("IndexHandler", turbo.web.RequestHandler)
-- HTTP POST handler
function IndexHandler:post()
    -- get a table from the raw json data
    local data = self:get_json(true)
    local message = {}
    local check = check_index(data['name'])
    if check == 0 then
        message = new_index(data['name'], data['index_type'])
    else
        print('check index name ' .. data['name'] .. 'it appears to exist.')
    end
    self:write(message)
end
-- all trim strings
function all_trim(s)
   return s:match( "^%s*(.-)%s*$" )
end
-- check value
function check_value(value)
    local query = "SELECT uuid FROM hashes where value = '" .. value .. "'"
    local result = pg:query(query)
    return #result
end
-- md5sum
function md5sum(value)
    local command = "echo -n '" .. value .. "' | md5sum | cut -f1 -d' ' "
    local handle = io.popen(command)
    local result = handle:read("*a")
    handle:close()
    return all_trim(result)
end
-- create new hash
function new_hash(value)
    local message = {}
    local hash_uuid = uuid()
    local md5_hash = md5sum(value)
    local sha_hash = sha2.sha256hex(value)
    local query = "INSERT INTO hashes(uuid, value, md5, sha) VALUES" ..
                  "('" .. hash_uuid .. "', '" .. value .. "', '" ..
                  md5_hash .. "', '" .. sha_hash .."')"
    local result = pg:query(query)
    if result['affected_rows'] == 1 then
        message["uuid"] = hash_uuid
    else
        message["error"] = "Error saving new data into hashes"
    end
    return message
end
-- Hash Handler Resource
local HashHandler = class("HashHandler", turbo.web.RequestHandler)
-- HTTP POST handler
function HashHandler:post()
    -- get a table from the raw json data
    local data = self:get_json(true)
    local message = {}
    local check = check_value(data['value'])
    if check == 0 then
        message = new_hash(data['value'])
    else
        print('check hash value ' .. data['value'] .. ' appears to exist.')
    end
    self:write(message)
end
-- application resource
local application = turbo.web.Application:new({
    {"/indexes/", IndexHandler},
    {"/hashes/", HashHandler}
})
-- i/o application start listen on TCP port.
application:listen(options['server']['port'])
turbo.ioloop.instance():start()
