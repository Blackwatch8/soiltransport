const Sequelize=require("sequelize")
const db={}
const sequelize= new Sequelize("react_login","root","",{
    host:"localhost",
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