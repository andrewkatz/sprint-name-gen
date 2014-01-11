express = require("express")
exphbs = require("express3-handlebars")
logfmt = require("logfmt")
rando = require("./rando.js")

app = express()
app.use(logfmt.requestLogger())
app.use(express.static(__dirname + "/../public"))
app.engine("handlebars", exphbs())
app.set("view engine", "handlebars")

app.get "/", (req, res) =>
  sprintName = rando.randomSprintName(req.query.pattern)

  if req.query.format is "json"
    res.json(sprintName: sprintName)
  else
    res.render("index", sprintName: sprintName)

port = process.env.PORT or 5000
app.listen port, ->
  console.log("Listening on " + port)
