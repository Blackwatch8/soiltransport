const mysql= require('mysql');
const config= require('../config');
const Users= require('./users');
const Companies=require('./company');
const Lorries=require('./lorry')
const UnloadingPlaces=require('./unloading-place')
const Drivers=require('./driver')
const Delivery=require('./delivery')
const Rate=require('./rates')
const Payments= require('./payments')
const Cheques=require('./cheque')
const Invoice=require('./invoice')
const Bal=require('./companypays')

module.exports= Connection = mysql.createConnection(config.mysql);

Connection.connect(err =>{
    if(err) console.groupCollapsed(err);
});

module.exports={
    Users,
    Companies,
    Lorries,
    UnloadingPlaces,
    Drivers,
    Delivery,
    Rate,
    Payments,
    Cheques,
    Invoice,
    Bal
}