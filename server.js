var express = require('express')
var cors = require('cors')
var bodyParser = require('body-parser')
var app = express()
var port = process.env.PORT || 5000


app.use(cors())
app.use(
  bodyParser.urlencoded({
    extended: false
  })
)
app.use(bodyParser.json())

var Users = require('./routes/Users')

app.use('/users', Users)

app.listen(port, function() {
  console.log('Server is running on port: ' + port)
})