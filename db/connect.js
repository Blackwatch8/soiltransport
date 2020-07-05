const mysql= require('mysql');
const Sequelize=require("sequelize")

/*var dbConfig = {
  connectionLimit : 10,
  host            : 'us-cdbr-east-05.cleardb.net',
  user            : 'bd34339b6e64dd',
  password        : 'fe97918e',
  database        : 'heroku_1741df78b945ba2'
  };*/
  
 var dbConfig = {
    connectionLimit : 10,
    host            : 'localhost',
    user            : 'root',
    password        : '',
    database        : 'SoilTransportSystem'
  };
  var Connection =mysql.createPool(dbConfig);

//const Connection=mysql.createPool(config.mysql);
module.exports={
    Connection
}