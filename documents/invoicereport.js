global.window = {document: {createElementNS: () => {return {}} }};
global.navigator = {};
global.html2pdf = {};
global.btoa = () => {};

const fs = require('fs')
const jsPDF = require('jspdf');
const autoTable=require ('jspdf-autotable');

getInvoice=(invoice,company,range,deliTotal)=>{

    var doc = new jsPDF();

    doc.text('Reliable Group Sri Lanka(Pvt) Ltd', 60,10);
    doc.text('Invoice Report', 80,18);
    doc.setFontSize(12);
    doc.text(`Company : ${company}`,20,22);
    doc.text(`From : ${range}`,20,28);
    doc.autoTable({
    startY: 29,
    theme : 'grid',
    headStyles: { fillColor: [128,128,128] }, 
    columnStyles: { unloadingPlaceIncomeRate: { halign: 'right' } }, 
    head: headRows(),
    body: bodyRows(invoice.length,invoice),
    })
    doc.text(`Total Amount (Rs):${deliTotal.toFixed(2)}`,20,doc.previousAutoTable.finalY + 10);

fs.writeFileSync('output.pdf', doc.output(),{encoding:'utf8',flag:'w'}, (err) => {
  if (err) throw err;
  console.log('The file has been saved!');
})
}

// heades and body for invoice
function headRows() {
  return [
    {deliveryNoteNO :'Delivery Note',deliveryDate : 'Date', vehicle_vehicleNumber : 'Lorry',uploadingPlaceAddress : 'Unloading Place',vehicleCapacity :'Cubes',unloadingPlaceIncomeRate : 'Rate'},
  ]
}

function bodyRows(rowCount,data) {
  rowCount = rowCount || 10
    let body = data.reduce((accumulator, currentValue) => {
  accumulator.push({
    deliveryNoteNO : currentValue.deliveryNoteNO,
    deliveryDate :currentValue.deliveryDate.substring(0,10),
    vehicle_vehicleNumber : currentValue.vehicle_vehicleNumber,
    uploadingPlaceAddress : currentValue.uploadingPlaceAddress,
    vehicleCapacity : currentValue.vehicleCapacity,
    unloadingPlaceIncomeRate : currentValue.unloadingPlaceIncomeRate.toFixed(2)

  });
  return accumulator;
},[]);
  return body
}

delete global.window;
delete global.navigator;
delete global.btoa;

module.exports={
    getInvoice
}