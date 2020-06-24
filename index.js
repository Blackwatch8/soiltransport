const express =require('express');
const cors= require('cors');
const mysql=require('mysql')
var path = require('path');
var bodyParser = require('body-parser')
var apiRouer=require('./routes')
var reportApiRouter=require('./reportRoutes')
var mailSender =require('./emailserver')
var port = process.env.PORT || 4000

const app=express();



app.use(cors());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
app.use(apiRouer);
app.use(reportApiRouter);
app.use(mailSender);

/*app.post('/adduser',(req,res) => {
    const {first_name,last_name,email} = req.body;
    var password=req.body.password;
    console.log(req);
    var tempDate = new Date();
    var created = tempDate.getFullYear() + '-' + (tempDate.getMonth()+1) + '-' + tempDate.getDate();
    bcrypt.hash(req.body.password, 10, (err, hash) => {
        password = hash
    const INSERT_USERS_QUERY=`INSERT into users (first_name,last_name,email,password,created) VALUES ('${first_name}','${last_name}','${email}','${password}','${created}')`
    connection.query(INSERT_USERS_QUERY,(err,result) => {
        if(err){
            return res.send(err)
        }
        else{
            
            return res.send('successfully aded')
        }
    })

})
})*/
app.use(express.static(path.join(__dirname, 'build')));


app.get('/*', (req, res) => {
  res.sendFile(path.join(__dirname, 'build', 'index.html'));
});

app.listen(port, function() {
  console.log('Server is running on port: ' + port)
})
// 145.121.88.49
