
Connection = require('./connect')

getLorry = async () => {
    return new Promise((resolve,reject)=>{
        Connection.query(`SELECT vehicleNumber, vehicleCapacity, vehicleDeliRate, DATE_FORMAT(vehicleRegDate,'%Y-%m-%d') from vehicle order by vehicleCreated`,(err,result) => {
            if(err){
                return reject(err);
            }
            else{
                resolve(result);
            }
        })
    })
}

addLorry = async (vehicleNumber,vehicleCapacity,vehicleDeliRate) => {
    return new Promise((resolve,reject) => {
        var today = new Date(),
            date = today.getFullYear() + '-' + (today.getMonth() + 1) + '-' + today.getDate();
        Connection.query(`insert into vehicle (vehicleNumber,vehicleCapacity,vehicleDeliRate,vehicleRegDate) values ('${vehicleNumber}','${vehicleCapacity
        }','${vehicleDeliRate}','${date}')`, (err,result)=>{
            if(err){
                reject(err);
            }
            else{
                resolve('Successfully Added')
            }
        })
    })
}
updateLorry = async (vehicleNumber,vehicleCapacity,vehicleDeliRate) =>{
    return new Promise((resolve,reject) => {
        Connection.query(`UPDATE vehicle SET vehicleCapacity='${vehicleCapacity}',vehicleDeliRate='${vehicleDeliRate}' WHERE
        vehicleNumber='${vehicleNumber}'`,(err,results) => {
            if(err){
                reject(err);
            }
            else{
                resolve(results)
            }
        })
    })
}
deleteLorry = async (vehicleNumber) =>{
    return new Promise((resolve,reject) =>{
        Connection.query(`DELETE from vehicle where vehicleNumber ='${vehicleNumber}'`,(err,results)=>{
            if(err){
                reject(err);
            }
            else{
                resolve(results);
            }
        })
    })
}
module.exports={
    getLorry,
    addLorry,
    updateLorry,
    deleteLorry
}