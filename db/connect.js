const mysql= require('mysql');
const Sequelize=require("sequelize")
//Connection = mysql.createConnection(config.mysql);
/*const Connection= new Sequelize("heroku_56236b0149670d1","bcf5aad9fc6b4b","6f0a84a4",{
    host:"us-cdbr-east-06.cleardb.net",
    dialect:"mysql",
    operaorsAliases: false,

    pool:{
        max:10,
        min:0,
        aquire:30000,
        idle: 10000
    }
}) */


var dbConfig = {
    connectionLimit : 10,
    host            : 'us-cdbr-east-05.cleardb.net',
    user            : 'bb845d734a4f04',
    password        : '71160976',
    database        : 'heroku_c09fd48e58d7734'
  };
  var Connection =mysql.createPool(dbConfig);

//const Connection=mysql.createPool(config.mysql);
module.exports={
    Connection
}