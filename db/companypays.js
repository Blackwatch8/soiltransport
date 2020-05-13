const mysql= require('mysql');
const config= require('../config');
Connection = mysql.createConnection(config.mysql);

addAnewPayCompany=async(company)=>{
    return new Promise((resolve,reject)=>{
        Connection.query(`INSERT INTO CompanyPayments(company_companyId) 
        VALUES ('${company}')`,(err,results)=>{
            if(err){
                reject(err);
            }
            else{
                resolve(results);
            }
        })
    })
}

updateTransactions= async(company,credit,debit)=>{
    return new Promise((resolve,reject)=>{
        Connection.query(`UPDATE CompanyPayments SET companyPaymentsCredit='${credit}',companyPaymentsDebit='${debit}' 
    WHERE company_companyId='${company}' `,(err,results)=>{
        if(err){
            reject(err);
        }
        else{
            resolve(results);
        }
    })
    })
}
getTransactions= async(company)=>{
    return new Promise((resolve,reject)=>{
        Connection.query(`SELECT * FROM CompanyPayments WHERE company_companyId='${company}'`,(err,results)=>{
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
    addAnewPayCompany,
    updateTransactions,
    getTransactions
}