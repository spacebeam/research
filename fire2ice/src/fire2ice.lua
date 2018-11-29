-- Turn it up, turn it up, turn it up, fucked up loud
local uuid = require("uuid")
local turbo = require("turbo")
local argparse = require("argparse")
local ini = require("inifile")

local parser = argparse("server.lua", "handles the creation of ice accounts")
    parser:option("-c --config", "configuration file.", "fire2ice.conf")
-- parse resource arguments
local args = parser:parse()
-- get options from config file
function get_options(conf_file)
    local options = ini.parse(conf_file)
    return options
end
-- get config file from cli
local options = get_options(args['config'])

-- System UUID
local system_uuid = uuid()

-- start things up, get the system uuid and shits
turbo.log.warning("Fire2ice system " .. system_uuid .." ")
turbo.log.warning("Fire2ice port: " .. options['server']['port'] .." ")
turbo.log.warning("Postgres server: " .. options['server']['dbhost'] .." ")
turbo.log.warning("Domain: " .. options['server']['domain'] .." ")
turbo.log.warning("Postgres port: " .. options['server']['dbport'] .." ")
turbo.log.warning("Postgres user: " .. options['server']['dbuser'] .." ")

-- Handler that creates the coturn account
local CoTurnHandler = class("CoTurnHandler", turbo.web.RequestHandler)

function CoTurnHandler:post()
    -- get a table from the raw json data
    local data = self:get_json(true)
    -- this is the fucking command
    local command = "turnadmin -a -e 'host=" .. options['server']['dbhost'] ..
                    " dbname=turndb user=" ..options['server']['dbuser'] .."password= ' -u " .. data['username'] ..
                    " -r " .. options['server']['domain'] .. " -p " .. data['password']
    os.execute(command)
end

local application = turbo.web.Application:new({
    {"/fire/", CoTurnHandler}
})
-- i/o application start listen on TCP port.
application:listen(options['server']['port'])
turbo.ioloop.instance():start()
