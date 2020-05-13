const mysql= require('mysql');
const config= require('../config');
Connection = mysql.createConnection(config.mysql);

getRates = async () => {
    return new Promise((resolve,reject) => {
        Connection.query('select * from rate',(err,results) => {
            if(err){
                reject(err)
            }
            else{
                resolve(results)
            }
        })
    })
}

module.exports={
    getRates
}