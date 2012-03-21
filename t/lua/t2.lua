-- try Test::Nginx::Socket

local http = require "resty.http"
local curl = http.curl
local _URL = "http://sina.com"
local opt,res = curl{url=_URL}
ngx.say(opt,res)