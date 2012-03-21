-- Copyright (C) 2012 Zoom.Quiet 

module("resty.http", package.seeall)

_VERSION = '12.03.20'


--local len = string.len
local null = ngx.null
local insert = table.insert
local tcp = ngx.socket.tcp

function curl(self, options )
    if type(options.url) ~= "string" then
        error("no url")
    end

    -- everything else is optional
    _curl(options.url
       ,options.method or ngx.HTTP_GET
       ,options.settimeout or 1000
       ,options.port or 80
       ,options.path or "/"
       ,options.body
    )
end
-- realy doing
function _curl(self, options )
    local result = { }
    result['status'] = nil
    result['head'] = nil
    result['body'] = nil
    result['error'] = nil
    local sock = slef.tcp()
    sock:settimeout(1000)
    local ok, err = sock:connect("www.baidu.com", 80)
    if not ok then
        ngx.say("failed to connect to baidu: ", err)
        return
    end
    local req = "GET /s?wd=openresty HTTP/1.0\\r\\nHost: www.baidu.com\\r\\n\\r\\n"
    sock:send(req)
    local read_headers = sock:receiveuntil("\\r\\n\\r\\n")
    headers, err = read_headers()
    if not headers then
        ngx.say("failed to read response headers: ", err)
        return
    end
    local body, err = sock:receive("*a")
    if not body then
        ngx.say("failed to read response body: ", err)
        return
    end

    return options,result
end



function get_reused_times(self)
    local sock = self.sock
    if not sock then
        return nil, "not initialized"
    end

    return sock:getreusedtimes()
end


function close(self)
    local sock = self.sock
    if not sock then
        return nil, "not initialized"
    end

    return sock:close()
end

--[[
local mt = { __index = resty.http }
function new(self)
    return setmetatable({ sock = tcp() }, mt)
end


function set_timeout(self, timeout)
    local sock = self.sock
    if not sock then
        return nil, "not initialized"
    end

    return sock:settimeout(timeout)
end


function connect(self, ...)
    local sock = self.sock
    if not sock then
        return nil, "not initialized"
    end

    return sock:connect(...)
end


]]

-- to prevent use of casual module global variables
getmetatable(resty.http).__newindex = function (table, key, val)
    error('attempt to write to undeclared variable "' .. key .. '": '
            .. debug.traceback())
end

