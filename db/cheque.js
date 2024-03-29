
Connection = require('./connect')

addChequeDetails=async(chequeNo,realiseDate,issueDate,amount,company,bank,date)=>{
    return new Promise((resolve , reject) =>{
        Connection.query(`INSERT INTO cheques(chequesNumber, chequesRealiseDate,
             chequesIssueDate,chequesBank, chequesAmount,cheque_companyId,chequesCreated) VALUES (
                 '${chequeNo}','${realiseDate}','${issueDate}','${bank}','${amount}','${company}','${date}')`,(err,results)=>{
                     if(err){
                         reject(err);
                     }
                     else{
                         resolve(results);
                     }
                 })
    })
}

getChequeDetails=async (startDate,endDate)=>{
    return new Promise((resolve,reject)=>{
        Connection.query(`SELECT chequesId,chequesNumber, chequesRealiseDate, chequesIssueDate,chequesBank, chequesAmount, company.companyName,company.companyId
         FROM cheques,company WHERE cheque_companyId=company.companyId AND chequesCreated BETWEEN 
         '${startDate}' AND '${endDate}'`,(err,results)=>{
            if(err){
                reject(err);
            }
            else{
                resolve(results);
            }
         })
    })
}
getChequeDetailsOfCompany=async (startDate,endDate,company)=>{
    return new Promise((resolve,reject)=>{
        Connection.query(`SELECT chequesNumber, chequesRealiseDate, chequesIssueDate,chequesBank, chequesAmount, company.companyName,company.companyId
         FROM cheques,company WHERE cheque_companyId=company.companyId  AND chequesCreated BETWEEN 
         '${startDate}' AND '${endDate}' AND companyId='${company}'`,(err,results)=>{
            if(err){
                reject(err);
            }
            else{
                resolve(results);
            }
         })
    })
}
deleteCheque=async(chequeNo)=>{
    return new Promise((resolve,reject)=>{
        Connection.query(`DELETE FROM cheques WHERE chequesId='${chequeNo}'`,(err,results)=>{
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
    addChequeDetails,
    getChequeDetails,
    deleteCheque,
    getChequeDetailsOfCompany
}