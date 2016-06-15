express = require('express')
exphbs = require('express3-handlebars')
logfmt = require('logfmt')
rando = require('./rando.js')

app = express()
app.use(logfmt.requestLogger())
app.use(express.static(__dirname + '/../public'))
app.engine('handlebars', exphbs())
app.set('view engine', 'handlebars')

nsfwBank = require('./banks/nsfw.js')
sfwBank = require('./banks/sfw.js')
mjBank = require('./banks/mj.js')

banks =
  sfw: sfwBank
  nsfw: nsfwBank
  mj: mjBank

app.get '/', (req, res) =>
  bankName = req.query.bank || 'sfw'
  bank = banks[bankName] || sfwBank

  generator = rando()
  sprintName = generator.randomSprintName(bank, req.query.pattern)

  if req.query.format is 'json'
    res.json(sprintName: sprintName)
  else
    res.render('index',
      sprintName: sprintName
      nsfw:       bankName is 'nsfw'
    )

port = process.env.PORT or 5000
app.listen port, ->
  console.log('Listening on ' + port)
