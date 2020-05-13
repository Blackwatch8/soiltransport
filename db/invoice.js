const mysql= require('mysql');
const config= require('../config');
Connection = mysql.createConnection(config.mysql);

addInvoice=(company,range,amount)=>{
    return new Promise((resolve,reject)=>{
        Connection.query(`INSERT INTO invoice (invoiceCompanyId, invoiceRange, invoiceAmount)
        VALUES ('${company}','${range}','${amount}')`,(err,results)=>{
            if(err){
                reject(err);
            }
            else{
                resolve(results)
            }
        })
    })
}
getInvoice=()=>{
    return new Promise((resolve,reject)=>{
        Connection.query(`SELECT invoiceId, invoiceCompanyId, invoiceRange, 
        invoiceAmount, invoiceCreated,company.companyName FROM 
        invoice, company WHERE invoiceCompanyId=company.companyId ORDER BY invoiceId DESC`,(err,results)=>{
            if(err){
                reject(err);
            }
            else{
                resolve(results);
            }
        })
    })
}
deleteInvoice=(invoiceId)=>{
    return new Promise((resolve,reject)=>{
        Connection.query(`DELETE FROM invoice WHERE invoiceId='${invoiceId}' `,(err,results)=>{
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
    addInvoice,
    getInvoice,
    deleteInvoice
}