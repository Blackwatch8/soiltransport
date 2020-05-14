
Connection = require('./connect')

getDrivers= async()=>{
    return new Promise((resolve,reject) =>{
        Connection.query('select * from driver order by created',(err,results) => {
            if(err){
                reject(err)
            }
            else{
                resolve(results)
            }
        })
    })
}
addDriver= async (driverLicenseNo, driverName, driverContact) =>{
    return new Promise((resolve,reject) =>{
        var today = new Date(),
        date = today.getFullYear() + '-' + (today.getMonth() + 1) + '-' + today.getDate();
        Connection.query(`INSERT INTO driver (driverLicenseNo, driverName, driverContact, driverRegDate) 
        VALUES ('${driverLicenseNo}','${driverName}','${driverContact}','${date}')`,(err,results)=>{
            if(err){
                reject(err);
            }
            else{
                resolve(results);
            }
        })
    })
}

deleteDriver = async (driverLicenseNo) => {
    return new Promise((resolve,reject) => {
        Connection.query(`DELETE from driver where driverLicenseNo='${driverLicenseNo}'`,(err,results) =>{
            if(err){
                reject(err);
            }
            else{
                resolve(reject);
            }
        })
    })
}

updateDriver= async (driverLicenseNo, driverName, driverContact) =>{
    return new Promise((resolve,reject) =>{
        Connection.query(`UPDATE driver SET driverName='${driverName}', driverContact='${driverContact}'
        WHERE driverLicenseNo='${driverLicenseNo}'`,(err,results)=>{
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
    getDrivers,
    addDriver,
    deleteDriver,
    updateDriver
}