const mysql= require('mysql');
const config= require('../config');
Connection = mysql.createConnection(config.mysql);

module.exports={
    Connection
}