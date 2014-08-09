lua-rest-http
====================================================================
~ 为 ngx_lua 基于 LuaJIT 建立的基本 HTTP 协议请求工具

- 140808 明确放弃折腾
- 推荐大家使用已经完成的: **[pintsized/lua-resty-http](https://github.com/pintsized/lua-resty-http)**

原先的目标:替代 [Lua-cURL by msva](http://msva.github.io/lua-curl/#installation)
使用 [OpenRest](http://openresty.org) 的 *[cosocket](http://agentzh.org/misc/slides/ngx-openresty-ecosystem/index.html#58)* 技术,支持高并发非阻塞的远程 HTTP 访问!

状态 Status
====================================================================

开发中,接口并未稳定!

This library is considered experimental and still under active development.

The API is still in flux and may change without notice.

描述 Description
====================================================================

依赖 编译时包含 OpenSSL,
[ngx_lua module](http://wiki.nginx.org/HttpLuaModule), 
[LuaJIT 2.0](http://luajit.org/luajit.html)
的最新版本 Nginx

示例 Synopsis
====================================================================


    # nginx.conf:

    lua_package_path "/path/to/lua-resty-http/lib/?.lua;;"

    server {
        location = /test {
            content_by_lua conf/test.lua;
        }
    }

    -- conf/test.lua:
    local http = require "resty.http"
    local curl = http.curl
    local _URL = "http://sina.com"
    local res = curl(url=_URL)
    -- or
    local res = curl(url=_URL,method=ngx.HTTP_PUT,body = 'hello, world')
    -- or
    local res = curl(url=_URL,method=ngx.HTTP_POST,body = 'hello, world')
    -- or
    local res = curl(url=_URL,method=ngx.HTTP_POST,body = 'user=zq&passwd=123456')
    -- or
    local res = curl(url=_URL,method=ngx.HTTP_DELETE,path = '/blog/2012/1/1')
    -- or
    local res = curl(url=_URL,method=ngx.HTTP_OPTIONS,path = '/blog/2012/1/1')
    -- or
    local res = curl(url=_URL,method=ngx.HTTP_HEAD,path = '/blog/2012/1/1')

    local ok = curl:perform()
    if res.status ~= 200 then
        ngx.say(res.header)
        ngx.say(res.body)
        return
    else
        ngx.say(res.status)
        ngx.say(res.header)
        ngx.say(res.body)
    end



作者 Author
====================================================================

Zoom.Quiet <zoomquiet+lua@gmail.com>


Copyright and License
====================================================================

This module is licensed under the BSD license.

Copyright (C) 2012, by Zoom.Quiet <zoomquiet+lua@gmail.com>.

All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

See Also
====================================================================
* the ngx_lua module: http://wiki.nginx.org/HttpLuaModule

