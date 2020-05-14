const mysql= require('mysql');
const config= require('../config');
const Sequelize=require("sequelize")
//Connection = mysql.createConnection(config.mysql);
const Connection= new Sequelize("heroku_56236b0149670d1","bcf5aad9fc6b4b","",{
    host:"us-cdbr-east-06.cleardb.net",
    dialect:"mysql",
    operaorsAliases: false,

    pool:{
        max:10,
        min:0,
        aquire:30000,
        idle: 10000
    }
}) 
module.exports={
    Connection
}