const express =require('express');
const cors= require('cors');
const mysql=require('mysql')
var bodyParser = require('body-parser')
var apiRouer=require('./routes')
var reportApiRouter=require('./reportRoutes')
var port = process.env.PORT || 4000

const app=express();


const connection=mysql.createConnection({
    host:'localhost',
    user:'root',
    password:'',
    database:'react_login'
});

connection.connect(err =>{
    if(err){
        return err;
    }
});

app.use(cors());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
app.use(apiRouer);
app.use(reportApiRouter);

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

app.listen(port, function() {
  console.log('Server is running on port: ' + port)
})
