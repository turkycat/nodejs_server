http = require "https"
jsdom = require "jsdom"

options = {
    protocol:   "https:"   #this is the default, and not necessary
    hostname:   "www.reddit.com"
    path:       "/"         #this is the default, and not necessary
    port:       443         #this is the default, and not necessary
    method:     "GET"       #this is the default, and not necessary
    #family:    4           #IP address family to use when resolving host and hostname. Valid values are 4 or 6. When unspecified, both IP v4 and v6 will be used.
}

body = ""

process_body = ->    
    jsdom.env body, (err, window) ->
        if err
            console.error err
            return

        #get the necessary elements using jquery
        $ = require("jquery")(window)
        titles = $("p.title")
        atitles = $("a.title")
        dtitles = $("div.\\ thing")     #note the double backslash here to escape the space
        console.log "found #{titles.length} <p> with the title class, #{atitles.length} <a>, #{dtitles.length} <div>"
        
        atitles.each (index) ->
            console.log $(this).text()
        


req = http.request options, (res) ->
    console.log "status: #{res.statusCode}"
    #console.log "headers: #{JSON.stringify res.headers}"
    res.setEncoding "utf8"
    res.on "data", (chunk) ->
        body += chunk
    res.on "end", process_body

req.on "error", (e) ->
    console.log "error: #{error}"

#req.write()
req.end()