
Connection = require('./connect');

updatePayment = async(paymentsAmount,paymentTypeId,paymentsDescription,vehicleNo,paymentsDate) =>{
    return new Promise((resolve,reject) => {
        Connection.query(`INSERT INTO LorryPayments (paymentsAmount, paymentsDate , paymentsDescription,
            paymentType_paymentTypeId, vehicle_vehicleNumber) VALUES
          ('${paymentsAmount}','${paymentsDate}','${paymentsDescription}','${paymentTypeId}','${vehicleNo}')`,(err,results) => {
              if(err){
                  reject(err);
              }
              else{
                  resolve(results)
              }
          })
    })
}

updateDieseFee =async(dieselFeeId,dieselFeeLiters)=>{
    return new Promise((resolve,reject) =>{
        var today = new Date(),
            date = today.getFullYear() + '-' + (today.getMonth() + 1) + '-' + today.getDate();
            Connection.query(`INSERT INTO dieselFee (dieselFeeId,dieselFeeLiters) VALUES ('${dieselFeeId}','${dieselFeeLiters}')`,(err,results)=>{
                     if(err){
                         reject(err);
                     }
                     else{
                         resolve(results)
                     }
                 })
    })
}
getDieselDetailsOfLorry= async(startDate,endDate,vehicleNumber)=>{
    
    return new Promise((resolve,reject) =>{
            Connection.query(`SELECT dieselFeeId, dieselFeeLiters,LorryPayments.paymentsDate,LorryPayments.paymentsAmount,LorryPayments.paymentsDescription 
            FROM dieselFee,LorryPayments WHERE LorryPayments.paymentsId=dieselFee.dieselFeeId AND 
            LorryPayments.vehicle_vehicleNumber='${vehicleNumber}'
             AND LorryPayments.paymentsDate BETWEEN '${startDate}' AND '${endDate}' group by  dieselFeeId`,(err,results) =>{
                 if(err){
                     reject(err);
                 }
                 else{
                     resolve(results);
                     
                 }
             })
    })
}

getDailyPayments = async (startDate,endDate) => {

    return new Promise((resolve,reject)=>{
        Connection.query(`SELECT LorryPayments.paymentsId,LorryPayments.paymentsDate,LorryPayments.paymentsDescription,LorryPayments.paymentsAmount,paymentType.paymentTypeType,
        LorryPayments.vehicle_vehicleNumber FROM LorryPayments,paymentType
        where LorryPayments.paymentType_paymentTypeId=paymentType.paymentTypeId and paymentsDate BETWEEN '${startDate}' AND '${endDate}' order by created`,(err,result) => {
            if(err){
                return reject(err);
            }
            else{
                resolve(result);
            }
        })
    })
}

getDailyPaymentsByLorry = async (vehicleNo) => {
    var today = new Date(),
            date = today.getFullYear() + '-' + (today.getMonth() + 1) + '-' + today.getDate();
    return new Promise((resolve,reject)=>{
        Connection.query(`SELECT LorryPayments.paymentsId,LorryPayments.paymentsDate,LorryPayments.paymentsAmount,paymentType.paymentTypeType
         FROM LorryPayments,paymentType
        where LorryPayments.paymentType_paymentTypeId=paymentType.paymentTypeId and LorryPayments.paymentsDate='${date}'
        AND LorryPayments.vehicle_vehicleNumber='${vehicleNo}' AND paymentType_paymentTypeId='3'`,(err,result) => {
            if(err){
                return reject(err);
            }
            else{
                resolve(result);
            }
        })
    })
}
getMonthlyPaymentsByLorry = async (startDate,endDate,vehicleNo,paymentType) => {

    return new Promise((resolve,reject)=>{
        Connection.query(`SELECT LorryPayments.paymentsId,LorryPayments.paymentsDate,LorryPayments.paymentsDescription,LorryPayments.paymentsAmount,paymentType.paymentTypeType
         FROM LorryPayments,paymentType
        where LorryPayments.paymentType_paymentTypeId=paymentType.paymentTypeId
        AND LorryPayments.vehicle_vehicleNumber='${vehicleNo}' AND paymentType_paymentTypeId='${paymentType}' AND LorryPayments.paymentsDate
        BETWEEN '${startDate}' AND '${endDate}' ORDER BY LorryPayments.paymentsId`,(err,result) => {
            if(err){
                return reject(err);
            }
            else{
                resolve(result);
            }
        })
    })
}
getAllPaymentsByLorry = async (startDate,endDate,vehicleNo) => {

    return new Promise((resolve,reject)=>{
        Connection.query(`SELECT LorryPayments.paymentsId,LorryPayments.paymentsDate,LorryPayments.paymentsDescription,LorryPayments.paymentsAmount,paymentType.paymentTypeType
         FROM LorryPayments,paymentType
        where LorryPayments.paymentType_paymentTypeId=paymentType.paymentTypeId
        AND LorryPayments.vehicle_vehicleNumber='${vehicleNo}' AND LorryPayments.paymentsDate
        BETWEEN '${startDate}' AND '${endDate}' ORDER BY LorryPayments.paymentsId`,(err,result) => {
            if(err){
                return reject(err);
            }
            else{
                resolve(result);
            }
        })
    })
}

addPettyCash= async (paymentId,pettyDate) =>{
    return new Promise((resolve,reject) =>{
        Connection.query(`INSERT INTO pettyCashBook(LorryPayments_paymentsId,pettyDate) VALUES ('${paymentId}','${pettyDate}')`,(err,results)=>{
            if(err){
                reject(err);
            }
            else{
                resolve(results);
            }
        })
    })

}
getLastPaymentId=async () =>{
    return new Promise((resolve,reject) =>{
        Connection.query(`SELECT paymentsId FROM LorryPayments ORDER BY paymentsId DESC LIMIT 1 `,(err,results)=>{
            if(err){
                reject(err);
            }
            else{
                resolve(results);
            }
        })
    })
}
getPettyCashBook= async(date)=>{
    return new Promise((resolve,reject)=>{
        Connection.query(`SELECT pettyCashBook.pettyId, LorryPayments.paymentsAmount,LorryPayments.paymentsDescription,paymentType.paymentTypeType ,LorryPayments.vehicle_vehicleNumber
        from pettyCashBook,LorryPayments,paymentType WHERE 
        pettyCashBook.LorryPayments_paymentsId=LorryPayments.paymentsId
        AND LorryPayments.paymentType_paymentTypeId=paymentType.paymentTypeId AND pettyCashBook.pettyDate='${date}'`,(err,results)=>{
            if(err){
                reject(err);
            }
            else{
                resolve(results);
            }
        })
    })
}
deletePayment=async(payId)=>{
    return new Promise((resolve,reject)=>{
        Connection.query(`DELETE FROM LorryPayments WHERE paymentsId='${payId}'`,(err,results)=>{
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
    updatePayment,
    updateDieseFee,
    getDailyPayments,
    getDailyPaymentsByLorry,
    addPettyCash,
    getLastPaymentId,
    getPettyCashBook,
    getMonthlyPaymentsByLorry,
    getDieselDetailsOfLorry,
    getAllPaymentsByLorry,
    deletePayment
}