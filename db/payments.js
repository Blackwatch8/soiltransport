
Connection = require('./connect');

updatePayment = async(paymentsAmount,paymentTypeId,paymentsDescription,vehicleNo,paymentsDate) =>{
    return new Promise((resolve,reject) => {
        Connection.query(`INSERT INTO lorrypayments (paymentsAmount, paymentsDate , paymentsDescription,
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
            Connection.query(`INSERT INTO dieselfee (dieselFeeId,dieselFeeLiters) VALUES ('${dieselFeeId}','${dieselFeeLiters}')`,(err,results)=>{
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
            Connection.query(`SELECT dieselFeeId, dieselFeeLiters,lorrypayments.paymentsDate,lorrypayments.paymentsAmount,lorrypayments.paymentsDescription 
            FROM dieselfee,lorrypayments WHERE lorrypayments.paymentsId=dieselfee.dieselFeeId AND 
            lorrypayments.vehicle_vehicleNumber='${vehicleNumber}'
             AND lorrypayments.paymentsDate BETWEEN '${startDate}' AND '${endDate}' group by  dieselFeeId`,(err,results) =>{
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
        Connection.query(`SELECT lorrypayments.paymentsId,lorrypayments.paymentsDate,lorrypayments.paymentsDescription,lorrypayments.paymentsAmount,paymenttype.paymentTypeType,
        lorrypayments.vehicle_vehicleNumber FROM lorrypayments,paymenttype
        where lorrypayments.paymentType_paymentTypeId=paymenttype.paymentTypeId and paymentsDate BETWEEN '${startDate}' AND '${endDate}' order by created`,(err,result) => {
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
        Connection.query(`SELECT lorrypayments.paymentsId,lorrypayments.paymentsDate,lorrypayments.paymentsAmount,paymenttype.paymentTypeType
         FROM lorrypayments,paymenttype
        where lorrypayments.paymentType_paymentTypeId=paymenttype.paymentTypeId and lorrypayments.paymentsDate='${date}'
        AND lorrypayments.vehicle_vehicleNumber='${vehicleNo}' AND paymentType_paymentTypeId='3'`,(err,result) => {
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
        Connection.query(`SELECT lorrypayments.paymentsId,lorrypayments.paymentsDate,lorrypayments.paymentsDescription,lorrypayments.paymentsAmount,paymenttype.paymentTypeType
         FROM lorrypayments,paymenttype
        where lorrypayments.paymentType_paymentTypeId=paymenttype.paymentTypeId
        AND lorrypayments.vehicle_vehicleNumber='${vehicleNo}' AND paymentType_paymentTypeId='${paymentType}' AND lorrypayments.paymentsDate
        BETWEEN '${startDate}' AND '${endDate}' ORDER BY lorrypayments.paymentsId`,(err,result) => {
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
        Connection.query(`SELECT lorrypayments.paymentsId,lorrypayments.paymentsDate,lorrypayments.paymentsDescription,lorrypayments.paymentsAmount,paymenttype.paymentTypeType
         FROM lorrypayments,paymenttype
        where lorrypayments.paymentType_paymentTypeId=paymenttype.paymentTypeId
        AND lorrypayments.vehicle_vehicleNumber='${vehicleNo}' AND lorrypayments.paymentsDate
        BETWEEN '${startDate}' AND '${endDate}' ORDER BY lorrypayments.paymentsId`,(err,result) => {
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
        Connection.query(`INSERT INTO pettycashbook(LorryPayments_paymentsId,pettyDate) VALUES ('${paymentId}','${pettyDate}')`,(err,results)=>{
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
        Connection.query(`SELECT paymentsId FROM lorrypayments ORDER BY paymentsId DESC LIMIT 1 `,(err,results)=>{
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
        Connection.query(`SELECT pettycashbook.pettyId, lorrypayments.paymentsAmount,lorrypayments.paymentsDescription,paymenttype.paymentTypeType ,lorrypayments.vehicle_vehicleNumber
        from pettycashbook,lorrypayments,paymenttype WHERE 
        pettycashbook.LorryPayments_paymentsId=lorrypayments.paymentsId
        AND lorrypayments.paymentType_paymentTypeId=paymenttype.paymentTypeId AND pettycashbook.pettyDate='${date}'`,(err,results)=>{
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
        Connection.query(`DELETE FROM lorrypayments WHERE paymentsId='${payId}'`,(err,results)=>{
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