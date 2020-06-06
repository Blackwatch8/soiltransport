const mysql= require('mysql');
const config= require('../config');
const Users= require('./users');
const Companies=require('./company');
const Lorries=require('./lorry')
const UnloadingPlaces=require('./unloading-place')
const Drivers=require('./driver')
const Delivery=require('./delivery')
const DbBack=require('./dbback')
const Payments= require('./payments')
const Cheques=require('./cheque')
const Invoice=require('./invoice')
const Bal=require('./companypays')

module.exports= Connection = mysql.createPool(config.mysql);



module.exports={
    Users,
    Companies,
    Lorries,
    UnloadingPlaces,
    Drivers,
    Delivery,
    DbBack,
    Payments,
    Cheques,
    Invoice,
    Bal
}