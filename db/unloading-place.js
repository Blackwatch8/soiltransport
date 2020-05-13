const mysql= require('mysql');
const config= require('../config');
Connection = mysql.createConnection(config.mysql);

getUnloadingPlaces= async =>{
    return new Promise((resolve,reject)=>{
        Connection.query(`SELECT  unloadingPlace.uploadingPlaceId, unloadingPlace.uploadingPlaceAddress,unloadingPlace.unloadingPlaceIncomeRate,company.companyName from unloadingPlace,company 
        WHERE unloadingPlace.company_companyId=company.companyId`,(err,results)=>{
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
        Connection.query(`select * from unloadingPlace where company_companyId ='${SearchId}'`,(err,results) =>{
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
        Connection.query(`INSERT INTO unloadingPlace (uploadingPlaceAddress, unloadingPlaceIncomeRate, company_companyId)
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
        Connection.query(`DELETE from unloadingPlace where uploadingPlaceId ='${place}'`,(err,results)=>{
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
        Connection.query(`UPDATE unloadingPlace SET uploadingPlaceAddress='${unloadingPlace}', 
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