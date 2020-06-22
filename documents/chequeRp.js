global.window = {document: {createElementNS: () => {return {}} }};
global.navigator = {};
global.html2pdf = {};
global.btoa = () => {};

const fs = require('fs')
const jsPDF = require('jspdf');
const autoTable=require ('jspdf-autotable');


//All the cheque Report
chequeReport=(range, cheque,total)=>{

    var doc = new jsPDF();

    doc.text('Reliable Group Sri Lanka(Pvt) Ltd', 60,10);
    doc.text('Cheques Report', 80,18);
    doc.setFontSize(12);
    doc.text(`${range}`,20,22);
    doc.autoTable({
    startY: 25,
    theme : 'grid',
    headStyles: { fillColor: [128,128,128] }, 
    columnStyles: { chequesAmount: { halign: 'right' } }, 
    head: headRows(),
    body: bodyRows(cheque.length,cheque),
    })
    doc.text(`Total Amount (Rs):${total.toFixed(2)}`,20,doc.previousAutoTable.finalY + 10);
//fs.writeFileSync('./output.pdf', doc.output())
fs.writeFileSync('output.pdf', doc.output(),{encoding:'utf8',flag:'w'}, (err) => {
  if (err) throw err;
  console.log('The file has been saved!');
})
}

//cheque Report by a company
chequeReportCmp=(range,company, cheque,total)=>{

    var doc = new jsPDF();

    doc.text('Reliable Group Sri Lanka(Pvt) Ltd', 60,10);
    doc.text('Cheques Report', 80,18);
    doc.setFontSize(12);
    doc.text(`Company : ${company}`,20,22);
    doc.text(`${range}`,20,26);
    doc.autoTable({
    startY: 28,
    theme : 'grid',
    headStyles: { fillColor: [128,128,128] }, 
    columnStyles: { chequesAmount: { halign: 'right' } }, 
    head: headRowsCmp(),
    body: bodyRowsCmp(cheque.length,cheque),
    })
    doc.text(`Total Amount (Rs):${total.toFixed(2)}`,20,doc.previousAutoTable.finalY + 10);
//fs.writeFileSync('./output.pdf', doc.output())
fs.writeFileSync('output.pdf', doc.output(),{encoding:'utf8',flag:'w'}, (err) => {
  if (err) throw err;
  console.log('The file has been saved!');
})
}

// heades and body for all companies
function headRows() {
  return [
    {chequesNumber :'Cheque No/Decs',chequesIssueDate :'Issue Date',chequesRealiseDate : 'Realise Date',companyName : 'Company',chequesBank : 'Bank',chequesAmount : 'Amount'},
  ]
}

function bodyRows(rowCount,data) {
var data1=JSON.stringify(data)
    console.log(data[0].chequesNumber)
  rowCount = rowCount || 10
    let body = data.reduce((accumulator, currentValue) => {
  accumulator.push({
    chequesNumber: currentValue.chequesNumber,
    chequesIssueDate: currentValue.chequesIssueDate.substring(0,10),
    chequesRealiseDate: currentValue.chequesRealiseDate.substring(0,10),
    companyName: currentValue.companyName,
    chequesBank: currentValue.chequesBank,
    chequesAmount: currentValue.chequesAmount.toFixed(2),  
  });
  return accumulator;
},[]);
  return body
}

//heads and body for a single company
function headRowsCmp() {
  return [
    {chequesNumber :'Cheque No/Decs',chequesIssueDate :'Issue Date',chequesRealiseDate : 'Realise Date',chequesBank : 'Bank',chequesAmount : 'Amount'},
  ]
}

function bodyRowsCmp(rowCount,data) {
var data1=JSON.stringify(data)
    console.log(data[0].chequesNumber)
  rowCount = rowCount || 10
    let body = data.reduce((accumulator, currentValue) => {
  accumulator.push({
    chequesNumber: currentValue.chequesNumber,
    chequesIssueDate: currentValue.chequesIssueDate.substring(0,10),
    chequesRealiseDate: currentValue.chequesRealiseDate.substring(0,10),
    chequesBank: currentValue.chequesBank,
    chequesAmount: currentValue.chequesAmount.toFixed(2),  
  });
  return accumulator;
},[]);
  return body
}

delete global.window;
delete global.navigator;
delete global.btoa;

module.exports={
    chequeReport,
    chequeReportCmp,
}