#!/usr/bin/env luajit
--
-- Handles the creation of system hashes
--
local socket = require("socket")
local uuid = require("uuid")
local sha2 = require("sha2")
local turbo = require("turbo")
local argparse = require("argparse")
local pgmoon = require("pgmoon")
local ini = require("inifile")
-- init random seed
uuid.randomseed(socket.gettime()*10000)
-- define service arguments
local parser = argparse("hashes.lua", "handles the creation of system hashes")
    parser:option("-c --config", "configuration file.", "hashes.conf")
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
    database = "units",
    user = options['server']['dbuser']
})
local system_uuid = uuid()
turbo.log.warning("Starting hashes resource uuid: " .. system_uuid)
-- postgres connect
assert(pg:connect())
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
    local query = "INSERT INTO hashes(uuid, name, md5, sha) VALUES" ..
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
    {"/hashes/", HashHandler},
})
-- i/o application start listen on TCP port.
application:listen(options['server']['port'])
turbo.ioloop.instance():start()
