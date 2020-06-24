global.window = {document: {createElementNS: () => {return {}} }};
global.navigator = {};
global.html2pdf = {};
global.btoa = () => {};

const fs = require('fs')
const jsPDF = require('jspdf');
const autoTable=require ('jspdf-autotable');

  //formate date 
  dateFormater=(cell)=>{
    var stDate = new Date(cell);
    var date = stDate.getFullYear() + '-' + (stDate.getMonth() + 1) + '-' + stDate.getDate();
     return `${date}`
   }

//Daily Delivery Report
getDailyDeliveryRp=(Deliveries,startDate,endDate)=>{

    var doc = new jsPDF();

    doc.text('Reliable Group Sri Lanka(Pvt) Ltd', 60,10);
    doc.text('Delivery Report', 80,18);
    doc.setFontSize(12);
    doc.text(`From : ${startDate} To : ${endDate}`,20,22);
    doc.autoTable({
    startY: 25,
    theme : 'grid',
    headStyles: { fillColor: [128,128,128] }, 
    head: headRows(),
    body: bodyRows(Deliveries.length,Deliveries),
    })
    doc.text(`Total Deliveries:${Deliveries.length}`,20,doc.previousAutoTable.finalY + 10);

fs.writeFileSync('output.pdf', doc.output(),{encoding:'utf8',flag:'w'}, (err) => {
  if (err) throw err;
  console.log('The file has been saved!');
})
}

//Delivery Report of Lorry
getDeliveryReportOfLorry=(deliveries,startDate,endDate,lorry,deliTotal)=>{
    var doc = new jsPDF();

    doc.text('Reliable Group Sri Lanka(Pvt) Ltd', 60,10);
    doc.text('Delivery Report', 80,18);
    doc.setFontSize(12);
    doc.text(`Lorry : ${lorry.vehicleNumber}`,20,22);
    doc.text(`From : ${startDate} To : ${endDate}`,20,26);
    doc.autoTable({
    startY: 28,
    theme : 'grid',
    headStyles: { fillColor: [128,128,128] }, 
    columnStyles: { deliveryPayment: { halign: 'right' } }, 
    head: headRowsLorry(),
    body: bodyRowsLorry(deliveries.length,deliveries),
    })
    doc.text(`Total Deliveries : ${deliveries.length}`,20,doc.previousAutoTable.finalY + 10);
    doc.text(`Total Delivery Payments : ${deliTotal.toFixed(2)}`,20,doc.previousAutoTable.finalY + 15)

fs.writeFileSync('output.pdf', doc.output(),{encoding:'utf8',flag:'w'}, (err) => {
  if (err) throw err;
  console.log('The file has been saved!');
})
}

// heades and body for daily Deliveries
function headRows() {
  return [
    {deliveryNoteNO:'Delivery Note',deliveryDate :'Date', vehicle_vehicleNumber :'Lorry',uploadingPlaceAddress : 'Unloading Place', companyName :'Company', driverName : 'Driver', deliveryAcceptance :'Status'},
  ]
}

function bodyRows(rowCount,data) {
  rowCount = rowCount || 10
    let body = data.reduce((accumulator, currentValue) => {
  accumulator.push({
    deliveryNoteNO: currentValue.deliveryNoteNO,
    deliveryDate:dateFormater(currentValue.deliveryDate) ,
    vehicle_vehicleNumber: currentValue.vehicle_vehicleNumber,
    uploadingPlaceAddress: currentValue.uploadingPlaceAddress,
    companyName : currentValue.companyName,
    driverName : currentValue.driverName,
    deliveryAcceptance : currentValue.deliveryAcceptance,
  });
  return accumulator;
},[]);
  return body
}

//heads and body for deliveries done by lorry
function headRowsLorry() {
  return [
    {deliveryNoteNO:'Delivery Note',deliveryDate :'Date',uploadingPlaceAddress : 'Unloading Place', driverName : 'Driver', deliveryDistace :'Distance',deliveryPayment:'Payment'},
  ]
}

function bodyRowsLorry(rowCount,data) {
  rowCount = rowCount || 10
    let body = data.reduce((accumulator, currentValue) => {
  accumulator.push({
    deliveryNoteNO: currentValue.deliveryNoteNO,
    deliveryDate: dateFormater(currentValue.deliveryDate),
    uploadingPlaceAddress: currentValue.uploadingPlaceAddress,
    driverName : currentValue.driverName,
    deliveryDistace : currentValue.deliveryDistance,
    deliveryPayment : currentValue.deliveryPayment.toFixed(2),
  });
  return accumulator;
},[]);
  return body
}

delete global.window;
delete global.navigator;
delete global.btoa
module.exports={
    getDailyDeliveryRp,
    getDeliveryReportOfLorry
}