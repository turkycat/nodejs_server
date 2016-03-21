// Generated by CoffeeScript 1.10.0
(function() {
  var body, http, jsdom, options, process_body, req;

  http = require("https");

  jsdom = require("jsdom");

  options = {
    protocol: "https:",
    hostname: "www.reddit.com",
    path: "/",
    port: 443,
    method: "GET"
  };

  body = "";

  process_body = function() {
    return jsdom.env(body, function(err, window) {
      var $, atitles, dtitles, titles;
      if (err) {
        console.error(err);
        return;
      }
      $ = require("jquery")(window);
      titles = $("p.title");
      atitles = $("a.title");
      dtitles = $("div.\\ thing");
      console.log("found " + titles.length + " <p> with the title class, " + atitles.length + " <a>, " + dtitles.length + " <div>");
      return atitles.each(function(index) {
        return console.log($(this).text());
      });
    });
  };

  req = http.request(options, function(res) {
    console.log("status: " + res.statusCode);
    res.setEncoding("utf8");
    res.on("data", function(chunk) {
      return body += chunk;
    });
    return res.on("end", process_body);
  });

  req.on("error", function(e) {
    return console.log("error: " + error);
  });

  req.end();

}).call(this);
