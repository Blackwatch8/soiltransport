const mysql= require('mysql');
const Sequelize=require("sequelize")

var dbConfig = {
    connectionLimit : 10,
    host            : 'us-cdbr-east-05.cleardb.net',
    user            : 'bb845d734a4f04',
    password        : '71160976',
    database        : 'heroku_c09fd48e58d7734'
  };
  
 /*var dbConfig = {
    connectionLimit : 10,
    host            : 'localhost',
    user            : 'root',
    password        : '',
    database        : 'SoilTransportSystem'
  };*/
  var Connection =mysql.createPool(dbConfig);

//const Connection=mysql.createPool(config.mysql);
module.exports={
    Connection
}