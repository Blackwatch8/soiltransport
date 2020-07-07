const express =require('express');
const cors= require('cors');
var bodyParser = require('body-parser');
const DB=require('./db');
const bcrypt = require('bcrypt');

const router = express.Router();
router.use(cors());
router .use(bodyParser.urlencoded({ extended: false }));
router .use(bodyParser.json());


router.all('*', function(req, res, next) {
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Headers", "X-Requested-With");
  res.header("Access-Control-Allow-Methods", "PUT, GET,POST");
  next();
 });

//Routes for users
router.get('/getusers' , async (req , res ) =>{
  try{
    let users = await DB.Users.all();
    res.json(users);
  }catch (e){
    console.log(e);
    res.sendStatus(500);
  }
})
router.post('/finduser',async (req,res) => {
  try{
  var searchID = req.body.searchID;
  var password;
  let user = await DB.Users.findUser(searchID);
  if(user.length>0){
  
  if (bcrypt.compareSync(req.body.password, user[0].password)) {
    console.log('match')
    let token =  {
      status: 'AllowToProceed',
      users:user
    }
    res.json(token)
  }
  else{
    let token =  {
      status: 'DoNotAllowToProceed'
    }
    res.json(token)
  }
  }
  else{
    let token =  {
      status: 'UserDoNotExsist'
    }
    res.json(token)
  }
}catch (e){
  console.log(e);
  res.sendStatus(500);
}
 
});


router.post('/adduser',(req,res) => {
  try{
  const {first_name,last_name,email} = req.body;
    var password=req.body.password;
    bcrypt.hash(req.body.password, 10, async (err, hash) => {
        password = hash
        let user = await DB.Users.addUser(first_name,last_name,email,password);
        res.json(user);
    })
  }catch (e){
    console.log(e);
    res.sendStatus(500);
  }
});
router.post('/updateuser', async (req,res) => {
  try{
  const{email}=req.body;
  await DB.Users.updateUser(email);
  
  let token =  {
    status: 'Successfull'
  }
  res.json(token)
  }catch (e){
    console.log(e);
    let token =  {
      status: 'Unsuccessfull'
    }
    res.json(token)
  }
})
router.post('/updateuserrole', async (req,res) => {
  try{
  const{role,email}=req.body;
  await DB.Users.updateUserRole(role,email);
  
  let token =  {
    status: 'Successfull'
  }
  res.json(token)
  }catch (e){
    console.log(e);
    let token =  {
      status: 'Unsuccessfull'
    }
    res.json(token)
  }
})
router.post('/deleteuser', async (req,res) => {
  try{
  const{id}=req.body;
  await DB.Users.deleteUser(id);
  
  let token =  {
    status: 'Successfull'
  }
  res.json(token)
  }catch (e){
    console.log(e);
    let token =  {
      status: 'Unsuccessfull'
    }
    res.json(token)
  }
})

//routes for companies
router.get('/getcompanies',async (req,res) => {
  try{
  let company= await DB.Companies.getCompanies();
  res.json(company);
  }catch (e){
    console.log(e);
    res.sendStatus(500);
  }
})

router.post('/addcompany', async (req,res) => {
  try{
  const{companyRegNo,companyName,companyAddress,companyEmail,companyContact}=req.body;
  await DB.Companies.addCompany(companyRegNo,companyName,companyAddress,companyEmail,companyContact);
  
  let token =  {
    status: 'SuccessfullyAdded'
  }
  res.json(token)
  }catch (e){
    console.log(e);
    let token =  {
      status: 'Unsuccessfull'
    }
    res.json(token)
  }
})

router.post('/updatecompany', async (req,res) => {
  try{
  const{companyRegNo,companyName,companyAddress,companyEmail,companyContact}=req.body;
  await DB.Companies.updateCompany(companyRegNo,companyName,companyAddress,companyEmail,companyContact);
  
  let token =  {
    status: 'SuccessfullyAdded'
  }
  res.json(token)
  }catch (e){
    console.log(e);
    let token =  {
      status: 'Unsuccessfull'
    }
    res.json(token)
  }
})

router.post('/deletecompany',async (req,res)=>{
  try{
  const {companyRegNo}=req.body;
  await DB.Companies.deleteCompany(companyRegNo);
  let token =  {
    status: 'SuccessfullyAdded'
  }
  res.send(token)
  }catch(e){
    console.log(e);
    let token ={
      status:'Unsuccessfull'
    }
    res.json(token);
  }
})
//get last company id
router.get('/getlastcompany', async (req,res) => {
  try{
    let cmp= await DB.Companies.getLastCompany();
    res.json(cmp);
  }catch(e){
    console.log(e);
    res.sendStatus(500);
  }
})

//Routes for lorries
router.get('/getlorries', async (req,res) =>{
  try{
  let lorry= await DB.Lorries.getLorry();
  res.json(lorry);
  }catch (e){
    console.log(e);
    res.sendStatus(500);
  }
})

router.post('/addlorry', async (req,res) =>{
  try{
    const {vehicleNumber,vehicleCapacity,vehicleDeliRate}=req.body;
    await DB.Lorries.addLorry(vehicleNumber,vehicleCapacity,vehicleDeliRate);

    let token ={
        status:'SuccessfullyAdded'
    }

    res.json(token);
  }catch (e){
    console.log(e);
    let token =  {
      status: 'Unsuccessfull'
    }
    res.json(token)
  }
})

router.post('/updatelorry',async (req,res) =>{
  try{
    const {vehicleNumber,vehicleCapacity,vehicleDeliRate}=req.body;
    await DB.Lorries.updateLorry(vehicleNumber,vehicleCapacity,vehicleDeliRate);
    let token ={
      status:'SuccessfullyAdded'
  }

  res.json(token);
}catch (e){
  console.log(e);
  let token =  {
    status: 'Unsuccessfull'
  }
  res.json(token)
}
})

router.post('/deleteLorry', async (req,res) =>{
  try{
    const {vehicleNumber}=req.body;
    await DB.Lorries.deleteLorry(vehicleNumber);
    let token={
      status :'SuccessfullyAdded'
    }
    res.send(token)
  }catch (e){
    console.log(e);
    let token =  {
      status: 'Unsuccessfull'
    }
    res.json(token)
  }
})

//Routes for unloading places begins here
router.get('/getunloadingplaces', async (req,res) => {
  try{
    
    let place= await DB.UnloadingPlaces.getUnloadingPlaces();
    res.json(place)
  }catch(e){
    console.log(e);
    res.sendStatus(500);
  }
})

router.post('/findunloadingplaces', async (req,res) => {
  try{
    const {SearchId}=req.body
    let place= await DB.UnloadingPlaces.findUnloadingPlaces(SearchId);
    res.json(place)
  }catch(e){
    console.log(e);
    res.sendStatus(500);
  }
})
router.post('/addplace', async (req,res) =>{
  try{
    const {unloadingPlace,unloadingRate,company}=req.body;
    await DB.UnloadingPlaces.addUnloadingPlace(unloadingPlace,unloadingRate,company);
    let token={
      status :'SuccessfullyAdded'
    }
    res.send(token)
  }catch (e){
    console.log(e);
    let token =  {
      status: 'Unsuccessfull'
    }
    res.json(token)
  }
})
router.post('/updateplace', async (req,res) =>{
  try{
    const {unloadingPlace,unloadingRate,company}=req.body;
    await DB.UnloadingPlaces.updateUnloadingPlace(unloadingPlace,unloadingRate,company);
    let token={
      status :'SuccessfullyAdded'
    }
    res.send(token)
  }catch (e){
    console.log(e);
    let token =  {
      status: 'Unsuccessfull'
    }
    res.json(token)
  }
})
router.post('/deleteplace',async (req,res) =>{
  try{
    const {company}=req.body;
    await DB.UnloadingPlaces.deleteUnloadingPlace(company);
    let token={
      status :'SuccessfullyAdded'
    }
    res.send(token)
  }catch (e){
    console.log(e);
    let token =  {
      status: 'Unsuccessfull'
    }
    res.json(token)
  }
})

//Routes for Drivers begins here
router.get('/getdrivers', async (req,res) =>{
  try{
  let driver= await DB.Drivers.getDrivers();
  res.json(driver);
  }catch (e){
    console.log(e);
    res.sendStatus(500);
  }
})
router.post('/adddriver', async (req,res) => {
  try{
    const {driverLicenseNo, driverName , driverContact}=req.body;
    await DB.Drivers.addDriver(driverLicenseNo, driverName , driverContact);
    let token={
      status:'Successfull'
    }
    res.send(token);
  }catch(e){
    console.log(e);
    let token={
      status:'Unsuccessfull'
    }
    res.send(token);
  }
})
router.post('/deletedriver', async (req,res) =>{
  try{
    const {driverLicenseNo}=req.body;
    await DB.Drivers.deleteDriver(driverLicenseNo);
    let token={
      status : 'Successfull'
    }
    res.send(token);
  }catch(e){
    console.log(e);
    let token={
      status : 'Unsuccessfull'
    }
    res.send(token)
  }
})
router.post('/updatedriver', async (req,res) => {
  try{
    const {driverLicenseNo, driverName , driverContact}=req.body;
    await DB.Drivers.updateDriver(driverLicenseNo, driverName , driverContact);
    let token={
      status:'Successfull'
    }
    res.send(token);
  }catch(e){
    console.log(e);
    let token={
      status:'Unsuccessfull'
    }
    res.send(token);
  } 
})

//Routes for deliveries begins here
router.post('/adddelivery', async(req,res) => {
  try{
    const {DeliNote,Distance,deliveryDate,deliveryTime,payment,vehicleNo,driverLiscence,unloadingPlace}=req.body;
    await DB.Delivery.addDelivery(DeliNote,Distance,deliveryDate,deliveryTime,payment,vehicleNo,driverLiscence,unloadingPlace);

    let token={
      status: 'SuccessfullyAdded'
    }
    res.send(token);
  }catch(e){
    console.log(e);
    let token ={
      status:'UnsuccessFull'
    }
    res.send(token);
  }
})
router.get('/getdeliveries', async (req,res) => {
  try{
    let delivery=await DB.Delivery.getDeliveries();
    res.json(delivery)
  }catch(e){
    console.log(e);
    res.sendStatus(500)
  }
})

router.post('/updateacceptance', async (req,res) => {
  try{
    const{deliveryAcceptance,deliveryNoteNO}=req.body;
    await DB.Delivery.updateDelivery(deliveryAcceptance,deliveryNoteNO);
    let token={
      status: 'SuccessfullyAdded'
    }
    res.send(token);
  }catch(e){
    console.log(e);
    let token ={
      status:'UnsuccessFull'
    }
    res.send(token);
  }
})

router.post('/updatedelitable', async (req,res)=>{
  try{
    const {startDate,endDate}=req.body;
    let delivery=await DB.Delivery.updateDeliTable(startDate,endDate);
    res.json(delivery);
  }catch(e){
    console.log(e);
    res.sendStatus(500);
  }
})

router.post('/getdailydeliverybylorry', async(req,res)=>{
  try{
    const {vehicleNo}=req.body;
    let delivery= await DB.Delivery.getDailyDeliveryByLorry(vehicleNo);
    res.send(delivery)
  }catch(e){
    console.log(e);
    res.sendStatus(500)
  }
})
router.post('/getdeliveriesbyrange', async (req,res) => {
  try{
    const{startDate,endDate,companyId}=req.body;
    let delivery=await DB.Delivery.getDeliveriesInRange(startDate,endDate,companyId);
    res.send(delivery);
  }catch(e){
    console.log(e);
    res.sendStatus(500);
  }
})
router.post('/getdeliveriesbyrangebylorry', async (req,res) => {
  try{
    const{startDate,endDate,vehicleNo}=req.body;
    let delivery=await DB.Delivery.getDeliveriesInRangeByLorry(startDate,endDate,vehicleNo);
    res.send(delivery);
  }catch(e){
    console.log(e);
    res.sendStatus(500);
  }
})
//delete a delivery
router.post('/deletedelivery', async (req,res)=>{
  try{
    const{deliveryNoteNO}=req.body;
    await DB.Delivery.deleteDelivery(deliveryNoteNO);
    let token={
      status: 'Successfull'
    }
    res.send(token);
  }catch(e){
    console.log(e);
    let token ={
      status:'UnsuccessFull'
    }
    res.send(token);
  }
})

//Routes for get dtabase backup begins here
router.get('/getDb', async (req,res) => {
  try{
    if(DB.DbBack.zipDir()==1){
      res.sendFile(`${__dirname}/dbBackups/archive.zip`)
    }
    
  }catch(e){
    console.log(e);
  }
})

//Routes for payments begins here

router.post('/addpayment', async (req,res) => {
    try{
      const{paymentsAmount,paymentTypeId,vehicleNo,paymentsDescription,paymentsDate}=req.body;
      await DB.Payments.updatePayment(paymentsAmount,paymentTypeId,paymentsDescription,vehicleNo,paymentsDate);
      let token={
        status: 'SuccessfullyAdded'
      }
      res.send(token);
    }catch(e){
      console.log(e);
      let token ={
        status:'UnsuccessFull'
      }
      res.send(token);
    }
})

router.post('/adddieselfee', async (req,res) => {
  try{
    const{dieselFeeId,dieselFeeLiters}=req.body;
    await DB.Payments.updateDieseFee(dieselFeeId,dieselFeeLiters);
    let token={
      status: 'SuccessfullyAdded'
    }
    res.send(token);
  }catch(e){
    console.log(e);
    let token ={
      status:'UnsuccessFull'
    }
    res.send(token);
  }
})

router.post('/getdailypayments',async (req,res) =>{
  try{
    const {startDate,endDate}=req.body;
    let payment= await DB.Payments.getDailyPayments(startDate,endDate);
    res.send(payment);
  }catch(e){
    console.log(e);
    res.sendStatus(500);
  }
})

router.post('/getdailypaymentsbylorry',async (req,res) =>{
  try{
    const {vehicleNumber}=req.body;
    let payment= await DB.Payments.getDailyPaymentsByLorry(vehicleNumber);
    res.send(payment);
  }catch(e){
    console.log(e);
    res.sendStatus(500);
  }
})
router.post('/getmonthlypaymentsbylorry',async (req,res) =>{
  try{
    const {startDate,endDate,vehicleNumber,paymentType}=req.body;
    let payment= await DB.Payments.getMonthlyPaymentsByLorry(startDate,endDate,vehicleNumber,paymentType);
    res.send(payment);
  }catch(e){
    console.log(e);
    res.sendStatus(500);
  }
})

router.post('/getallpaymentsbylorry',async (req,res) =>{
  try{
    const {startDate,endDate,vehicleNumber}=req.body;
    let payment= await DB.Payments.getAllPaymentsByLorry(startDate,endDate,vehicleNumber);
    res.send(payment);
  }catch(e){
    console.log(e);
    res.sendStatus(500);
  }
})
router.post('/addpettycash', async (req,res) =>{
  try{
    const{paymentsId,pettyDate}=req.body;
    await DB.Payments.addPettyCash(paymentsId,pettyDate);
    let token={
      status:'Successfull'
    }
    res.send(token)
  }catch(e){
    console.log(e);
    let token={
      status:'Unsuccessfull'
    }
    res.send(token)
  }
})
//get last payment id
router.get('/getlastpayid',async (req,res) =>{
  try{
    let payment= await DB.Payments.getLastPaymentId();
    res.send(payment);
  }catch(e){
    console.log(e);
    res.sendStatus(500);
  }

})
//get last delivery note
router.get('/getlastdeliid',async (req,res) =>{
  try{
    let deli= await DB.Delivery.getLastDeliId();
    res.send(deli);
  }catch(e){
    console.log(e);
    res.sendStatus(500);
  }

})
router.post('/getpettycashbook',async (req,res) =>{
  try{
    const {date}=req.body;
    let payment= await DB.Payments.getPettyCashBook(date);
    res.send(payment);
  }catch(e){
    console.log(e);
    res.sendStatus(500);
  }
  
})

//delete a payment 

router.post('/deletepayment',async(req,res)=>{
  try{
    const {payId}=req.body;
    await DB.Payments.deletePayment(payId);
    let token={
      status:'Successfull'
    }
    res.send(token)
  }catch(e){
    console.log(e);
    let token={
      status:'Unsuccessfull'
    }
    res.send(token)
  }
})

// Route for getting diesel fee
router.post('/getDieselDetails', async (req,res)=>{
  try{
    const {startDate,endDate,vehicleNumber}=req.body;
    let diesel = await DB.Payments.getDieselDetailsOfLorry(startDate,endDate,vehicleNumber);
    res.send(diesel);
  }catch(e){
    console.log(e);
    res.send(500);
  }
})
//route for add cheque details
router.post('/addcheque', async (req,res)=>{
  try{
    const {chequeNo,realiseDate,issueDate,amount,company,bank,date}=req.body;
    await DB.Cheques.addChequeDetails(chequeNo,realiseDate,issueDate,amount,company,bank,date);
    let token={
      status:'Successfull'
    }
    res.send(token)
  }catch(e){
    console.log(e);
    let token={
      status:'UnSuccessfull'
    }
    res.send(token)
  }
})
//Routes for getting cheque details
router.post('/getcheque',async (req,res) =>{
  try{
    const {startDate,endDate}=req.body;
    let cheque= await DB.Cheques.getChequeDetails(startDate,endDate);
    res.send(cheque);
  }catch(e){
    console.log(e);
    res.sendStatus(500);
  }
})
//Routes for getting cheque details of a company
router.post('/getchequebycmp',async (req,res) =>{
  try{
    const {startDate,endDate,company}=req.body;
    let cheque= await DB.Cheques.getChequeDetailsOfCompany(startDate,endDate,company);
    res.send(cheque);
  }catch(e){
    console.log(e);
    res.sendStatus(500);
  }
})
//Delete a cheque
router.post('/deletecheque',async (req,res) =>{
  try{
    const {chequeNo}=req.body;
    await DB.Cheques.deleteCheque(chequeNo);
    let token={
      status:'Successfull'
    }
    res.send(token)
  }catch(e){
    console.log(e);
    let token={
      status:'UnSuccessfull'
    }
    res.send(token)
  }
})

//adding invoice
router.post('/addinvoice',async(req,res)=>{
  try{
    const{company,range,amount}=req.body;
    await DB.Invoice.addInvoice(company,range,amount);
    let token={
      status:'Successfull'
    }
    res.send(token)
  }catch(e){
    console.log(e);
    let token={
      status:'UnSuccessfull'
    }
    res.send(token)
  }
})
//getting invoices
router.get('/getinvoice',async(req,res)=>{
  try{
    let invoice= await DB.Invoice.getInvoice();
    res.send(invoice);
  }catch(e){
    console.log(e);
    res.sendStatus(500);
  }
})
//deleting invoice
router.post('/deleteinvoice',async(req,res)=>{
  try{
    const{invoiceId}=req.body;
    await DB.Invoice.deleteInvoice(invoiceId);
    let token={
      status:'Successfull'
    }
    res.send(token)
  }catch(e){
    console.log(e);
    let token={
      status:'UnSuccessfull'
    }
    res.send(token)
  }
})
//add a new pay tracking for company 
router.post('/addpay', async (req,res)=>{
  try{
    const{company}=req.body;
    await DB.Bal.addAnewPayCompany(company);
    let token={
      status:'Successfull'
    }
    res.send(token)
  }catch(e){
    console.log(e);
    let token={
      status:'UnSuccessfull'
    }
    res.send(token)
  }
})
//update a new payment
router.post('/updatepay', async (req,res)=>{
  try{
    const{company,credit,debit}=req.body;
    await DB.Bal.updateTransactions(company,credit,debit);
    let token={
      status:'Successfull'
    }
    res.send(token)
  }catch(e){
    console.log(e);
    let token={
      status:'UnSuccessfull'
    }
    res.send(token)
  }
})
//get transactions

router.post('/getpay',async(req,res)=>{
  try{
    const {company}=req.body    
    let pay= await DB.Bal.getTransactions(company);
    res.send(pay);
  }catch(e){
    console.log(e);
    res.sendStatus(500);
  }
})
module.exports=router
