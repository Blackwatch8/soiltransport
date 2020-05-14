
Connection = require('./connect')

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