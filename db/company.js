
Connection = require('./connect')

getCompanies= async => {
    return new Promise((resolve, reject) => {
        Connection.query(`select * from company`,(err,reults) =>{
            if(err)
            {
                return reject(err)
            }
            else{
                resolve(reults);
            }
        })
    })
}
addCompany = async(companyRegNo,companyName,companyAddress,companyEmail,companyContact) => {
    return new Promise((resolve,reject) => {
        var today = new Date(),
            date = today.getFullYear() + '-' + (today.getMonth() + 1) + '-' + today.getDate();

        Connection.query(`insert into company (companyRegNo,companyName,companyAddress,companyEmail,companyContact,companyRegDate)
         values ('${companyRegNo}','${companyName}','${companyAddress}','${companyEmail}','${companyContact}','${date}') `,(err,results) =>{
             if(err){
                 return reject(err);
             }
             else{
                 resolve ('successfully added')
             }
         })
    })
}
deleteCompany= async (companyRegNo)=>{
    return new Promise((resolve,reject) =>{
        Connection.query(`DELETE from company where companyRegNo='${companyRegNo}'`,(err,results)=>{
            if(err){
                reject(err);
            }
            else{
                resolve(results);
            }
        })
    })
}
updateCompany=async (companyRegNo,companyName,companyAddress,companyEmail,companyContact)=>{
    return new Promise((resolve,reject)=>{
        Connection.query(`UPDATE company SET companyName='${companyName}', companyAddress='${companyAddress}', 
        companyEmail='${companyEmail}', companyContact='${companyContact}'
        WHERE companyRegNo='${companyRegNo}'`,(err,results)=>{
            if(err){
                reject(err);
            }
            else{
                resolve(results);
            }
        })
    })
}
getLastCompany=async()=>{
    return new Promise((resolve,reject)=>{
        Connection.query(`SELECT companyId From company ORDER BY companyId DESC LIMIT 1 `,(err,results)=>{
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
    getCompanies,
    addCompany,
    deleteCompany,
    updateCompany,
    getLastCompany
}