
Connection = require('./connect')

getUnloadingPlaces= async =>{
    return new Promise((resolve,reject)=>{
        Connection.query(`SELECT  unloadingplace.uploadingPlaceId, unloadingplace.uploadingPlaceAddress,unloadingplace.unloadingPlaceIncomeRate,company.companyName from unloadingplace,company 
        WHERE unloadingplace.company_companyId=company.companyId`,(err,results)=>{
            if(err){
                reject(err);
            }
            else{
                resolve(results)
            }
        })
    })
}

findUnloadingPlaces= async (SearchId) =>{
    return new Promise((resolve,reject)=>{
        Connection.query(`select * from unloadingplace where company_companyId ='${SearchId}'`,(err,results) =>{
            if(err){
                reject(err);
            }
            else{
                resolve(results);
            }
        })
    })
}
addUnloadingPlace = async (unloadingPlace,unloadingRate,company)=>{
    return new Promise((resolve,reject) => {
        Connection.query(`INSERT INTO unloadingplace (uploadingPlaceAddress, unloadingPlaceIncomeRate, company_companyId)
         VALUES ('${unloadingPlace}','${unloadingRate}','${company}')`,(err,results) =>{
                if(err){
                    reject(err);
                }
                else{
                    resolve(results);
                }
         })
    })
}
deleteUnloadingPlace= async (place)=>{
    return new Promise((resolve,reject) =>{
        Connection.query(`DELETE from unloadingplace where uploadingPlaceId ='${place}'`,(err,results)=>{
            if(err){
                reject(err);
            }
            else{
                resolve(results);
            }
        })
    })
}
updateUnloadingPlace = async (unloadingPlace,unloadingRate,company)=>{
    return new Promise((resolve,reject) => {
        Connection.query(`UPDATE unloadingplace SET uploadingPlaceAddress='${unloadingPlace}', 
        unloadingPlaceIncomeRate='${unloadingRate}' WHERE uploadingPlaceId='${company}' `,(err,results) =>{
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
    getUnloadingPlaces,
    findUnloadingPlaces,
    addUnloadingPlace,
    deleteUnloadingPlace,
    updateUnloadingPlace
}