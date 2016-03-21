// Generated by CoffeeScript 1.10.0
(function() {
  var $, body, chunks, http, jsdom, options, process_body, req;

  http = require("https");

  jsdom = require("jsdom");

  options = {
    protocol: "https:",
    hostname: "www.reddit.com",
    path: "/",
    port: 443,
    method: "GET"
  };

  chunks = 0;

  body = "";

  $ = "";

  process_body = function() {
    console.log("got " + chunks + " chunks.");
    return jsdom.env(body, function(err, window) {
      var matches, titles;
      if (err) {
        console.error(err);
        return;
      }
      $ = require("jquery")(window);
      matches = body.match(/\<p class=\"title\"\>/gi);
      titles = $(".title");
      console.log("found " + titles.length + " objects with the title class");
      return console.log("found " + matches.length + " matches");
    });
  };

  req = http.request(options, function(res) {
    console.log("status: " + res.statusCode);
    console.log("headers: " + (JSON.stringify(res.headers)));
    res.setEncoding("utf8");
    res.on("data", function(chunk) {
      chunks++;
      return body += chunk;
    });
    return res.on("end", process_body);
  });

  req.on("error", function(e) {
    return console.log("error: " + error);
  });

  req.end();

}).call(this);