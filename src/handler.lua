local cjson = require "cjson"
local BasePlugin = require "kong.plugins.base_plugin"
local serializer = require "kong.plugins.argonath-kenny-loggins.serializer"
local ngx_log = ngx.log
local ngx_timer_at = ngx.timer.at
local string_upper = string.upper


local ArgonathKennyLogginsHandler = BasePlugin:extend()

ArgonathKennyLogginsHandler.PRIORITY = 1

local SENDER_NAME = "kong"

local LOG_LEVELS = {
  debug = 7,
  info = 6,
  notice = 5,
  warning = 4,
  err = 3,
  crit = 2,
  alert = 1,
  emerg = 0
}

local function send_to_stdout(log_level, severity, message)
  if LOG_LEVELS[severity] <= LOG_LEVELS[log_level] then
    print(string_upper(severity) .. " CE_AUDIT " .. cjson.encode(message))
  end
end

local function log(premature, conf, message)
  if premature then return end

  if message.response.status >= 500 then
    send_to_stdout(conf.log_level, conf.server_errors_severity, message)
  elseif message.response.status >= 400 then
    send_to_stdout(conf.log_level, conf.client_errors_severity, message)
  else
    send_to_stdout(conf.log_level, conf.successful_severity, message)
  end
end

function ArgonathKennyLogginsHandler:new()
  ArgonathKennyLogginsHandler.super.new(self, "argonath-kenny-loggins")
end

function ArgonathKennyLogginsHandler:log(conf)
  ArgonathKennyLogginsHandler.super.log(self)

  local message = serializer.serialize(ngx)
  local ok, err = ngx_timer_at(0, log, conf, message)
  if not ok then
    ngx_log(ngx.ERR, "failed to create timer: ", err)
  end
end

return ArgonathKennyLogginsHandler