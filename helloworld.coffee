util = require "util"
my_http = require "http"

my_http.createServer (request, response) ->
    console.log "I got kicked"
    response.writeHeader 200, {"Content-Type": "text/plain"}
    response.write "Hello World"
    response.end()
.listen 8080
    
#server.listen 8080
console.log("Server Running on 8080"); 


#(function(request,response){
#    console.log("I got kicked");
#    response.writeHeader(200, {"Content-Type": "text/plain"});
#    response.write("Hello World");
#    response.end();
#}).listen(8080);
#console.log("Server Running on 8080"); 