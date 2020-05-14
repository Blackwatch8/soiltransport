const Sequelize=require("sequelize")
const db={}
//mysql://bcf5aad9fc6b4b:6f0a84a4@us-cdbr-east-06.cleardb.net/heroku_56236b0149670d1?reconnect=true
const sequelize= new Sequelize("heroku_56236b0149670d1","bcf5aad9fc6b4b","",{
    host:"us-cdbr-east-06.cleardb.net",
    dialect:"mysql",
    operaorsAliases: false,

    pool:{
        max:5,
        min:0,
        aquire:30000,
        idle: 10000
    }
}) 

db.sequelize=sequelize
db.Sequelize=Sequelize
module.exports=db