
Connection = require('./connect')

addAnewPayCompany=async(company)=>{
    return new Promise((resolve,reject)=>{
        Connection.query(`INSERT INTO companypayments(company_companyId) 
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
        Connection.query(`UPDATE companypayments SET companyPaymentsCredit='${credit}',companyPaymentsDebit='${debit}' 
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
        Connection.query(`SELECT * FROM companypayments WHERE company_companyId='${company}'`,(err,results)=>{
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