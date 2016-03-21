http = require "http"

options = {
    protocol:   "http:"   #this is the default, and not necessary
    hostname:   "www.google.com"
    path:       "/"         #this is the default, and not necessary
    port:       80          #this is the default, and not necessary
    method:     "GET"       #this is the default, and not necessary
    #family:    4           #IP address family to use when resolving host and hostname. Valid values are 4 or 6. When unspecified, both IP v4 and v6 will be used.
}

req = http.request options, (res) ->
    console.log "status: #{res.statusCode}"
    console.log "headers: #{JSON.stringify res.headers}"
    res.setEncoding "utf8"
    res.on 'data', (chunk) ->
        console.log "body: #{chunk}"
    
req.on "error", (e) ->
    console.log "error: #{error}"
    
#req.write()
req.end()