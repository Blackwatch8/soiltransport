
Connection = require('./connect')

addDelivery= async (DeliNote,Distance,deliveryDate,deliveryTime,payment,vehicleNo,driverLiscence,unloadingPlace) => {
    console.log(DeliNote)
    return new Promise((resolve,reject) => {
        Connection.query(`insert into delivery (deliveryNoteNo,deliveryDistance, deliveryDate,
            deliveryPayment, deliveryDepartureTime, vehicle_vehicleNumber,
             uploadingPlace_uploadingPlaceId, driver_driverLicenseNo)
             values ('${DeliNote}','${Distance}','${deliveryDate}','${payment}','${deliveryTime}',
             '${vehicleNo}','${unloadingPlace}','${driverLiscence}')`,(err,results) => {
                 if(err){
                    reject(err)
                 }
                 else{
                     resolve(results)
                 }
             })
    })
    
}
getDeliveries = async () => {
    return new Promise((resolve,reject) => {
        Connection.query(`select * from delivery` ,(err,results) =>{
            if(err){
                reject(err)
            }
            else{
                resolve(results)
            }
        })
    })
    
}

updateDelivery= async (deliveryAcceptance,deliveryNoteNo) => {
    return new Promise((resolve,reject) => {
        Connection.query(`update delivery set deliveryAcceptance='${deliveryAcceptance}' where deliveryNoteNO='${deliveryNoteNo}'`,(err,results) => {
            if(err){
                reject(err);
            }
            else{
                resolve(results);
            }
        })
    })
}

updateDeliTable= async(startDate,endDate) =>{
    var today = new Date(),
            date = today.getFullYear() + '-' + (today.getMonth() + 1) + '-' + today.getDate();
    return new Promise((resolve,reject)=>{
        Connection.query(`SELECT delivery.deliveryNoteNO,delivery.deliveryDistance, delivery.deliveryAcceptance,deliveryDate,delivery.vehicle_vehicleNumber, 
        delivery.deliveryDepartureTime,driver.driverName,unloadingPlace.uploadingPlaceAddress ,company.companyName FROM delivery,driver,unloadingPlace ,company
         WHERE delivery.driver_driverLicenseNo=driver.driverLicenseNo AND 
         delivery.uploadingPlace_uploadingPlaceId=unloadingPlace.uploadingPlaceId AND 
         unloadingPlace.company_companyId=company.companyId  
        AND delivery.deliveryDate BETWEEN '${startDate}' AND '${endDate}'  ORDER BY deliveryNoteNO`,(err,results)=>{
            if(err){
                reject(err);
            }
            else{
                resolve(results);
            }
        });
        
    }
    );
}
getDailyDeliveryByLorry= async (vehicleNo) => {
    var today = new Date(),
            date = today.getFullYear() + '-' + (today.getMonth() + 1) + '-' + today.getDate();
    return new Promise((resolve,reject) => {
        Connection.query(`SELECT delivery.deliveryNoteNO,delivery.deliveryPayment,
        unloadingPlace.uploadingPlaceAddress 
        FROM delivery,unloadingPlace 
        WHERE delivery.uploadingPlace_uploadingPlaceId=unloadingPlace.uploadingPlaceId 
        AND delivery.deliveryDate = '${date}' AND delivery.vehicle_vehicleNumber='${vehicleNo}'
        AND delivery.deliveryAcceptance='Accepted' ORDER BY deliveryNoteNO`,(err,results)=>{
            if(err){
                reject(err);
            }
            else{
                resolve(results);
            }
        })
    })
}
getDeliveriesInRange=(startDate,endDate,companyId)=>{
    return new Promise((resolve,reject) => {
        Connection.query(`SELECT delivery.deliveryNoteNO,delivery.deliveryDate,delivery.vehicle_vehicleNumber,delivery.deliveryPayment,
        unloadingPlace.uploadingPlaceAddress,vehicle.vehicleCapacity,unloadingPlace.unloadingPlaceIncomeRate ,vehicle.vehicleCapacity * unloadingPlace.unloadingPlaceIncomeRate as totalrate
        FROM delivery,unloadingPlace,vehicle WHERE 
        delivery.uploadingPlace_uploadingPlaceId=unloadingPlace.uploadingPlaceId AND 
        delivery.vehicle_vehicleNumber=vehicle.vehicleNumber AND delivery.deliveryAcceptance='Accepted' AND
         unloadingPlace.company_companyId='${companyId}' AND deliveryDate BETWEEN '${startDate}' AND '${endDate}' ORDER BY 
         delivery.deliveryNoteNO  ` ,(err,results) =>{
            if(err){
                reject(err)
            }
            else{
                resolve(results)
            }
        })
    })    
}
getDeliveriesInRangeByLorry=(startDate,endDate,vehicleNo)=>{
    return new Promise((resolve,reject) => {
        Connection.query(`SELECT delivery.deliveryNoteNO,delivery.deliveryDate,delivery.deliveryDistance,delivery.deliveryPayment,
        unloadingPlace.uploadingPlaceAddress,vehicle.vehicleCapacity , driver.driverName
        FROM delivery,unloadingPlace,vehicle, driver WHERE delivery.driver_driverLicenseNo=driver.driverLicenseNo AND
        delivery.uploadingPlace_uploadingPlaceId=unloadingPlace.uploadingPlaceId AND 
        delivery.vehicle_vehicleNumber=vehicle.vehicleNumber AND NOT delivery.deliveryAcceptance='Pending..' AND
        delivery.vehicle_vehicleNumber='${vehicleNo}' AND deliveryDate BETWEEN '${startDate}' AND '${endDate}' ORDER BY 
         delivery.deliveryNoteNO  ` ,(err,results) =>{
            if(err){
                reject(err)
            }
            else{
                resolve(results)
            }
        })
    })    
}
deleteDelivery=(deliveryNoteNO)=>{
    return new Promise((resolve,reject)=>{
        Connection.query(`DELETE FROM delivery WHERE deliveryNoteNO='${deliveryNoteNO}'`,(err,results)=>{
            if(err){
                reject(err);
            }
            else{
                resolve(results);
            }
        });
    })
}
getLastDeliId=async () =>{
    return new Promise((resolve,reject) =>{
        Connection.query(`SELECT deliveryNoteNo FROM delivery ORDER BY deliveryNoteNo DESC LIMIT 1 `,(err,results)=>{
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
    addDelivery,
    getDeliveries,
    updateDelivery,
    updateDeliTable,
    getDailyDeliveryByLorry,
    getDeliveriesInRange,
    getDeliveriesInRangeByLorry,
    deleteDelivery,
    getLastDeliId
}