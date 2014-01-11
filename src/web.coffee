# set up app
express = require("express")
exphbs = require("express3-handlebars")
logfmt = require("logfmt")
rando = require("./rando.js")

app = express()
app.use(logfmt.requestLogger())
app.use(express.static(__dirname + "/../public"))
app.engine("handlebars", exphbs())
app.set("view engine", "handlebars")

# load banks
nsfwBank = require("./banks/nsfw.js")
sfwBank = require("./banks/sfw.js")

# create route
app.get "/", (req, res) =>
  nsfw = req.query.nsfw is "yes"
  bank = if nsfw then nsfwBank else sfwBank
  sprintName = rando.randomSprintName(bank, req.query.pattern)

  if req.query.format is "json"
    res.json(sprintName: sprintName)
  else
    res.render("index",
      sprintName: sprintName
      nsfw:       nsfw
    )

port = process.env.PORT or 5000
app.listen port, ->
  console.log("Listening on " + port)
