global.window = {document: {createElementNS: () => {return {}} }};
global.navigator = {};
global.html2pdf = {};
global.btoa = () => {};

const fs = require('fs')
const jsPDF = require('jspdf');
const autoTable=require ('jspdf-autotable');

getPaymentReport=(Payments,startDate,endDate,payTotal)=>{
    var doc = new jsPDF();

    doc.text('Reliable Group Sri Lanka(Pvt) Ltd', 60,10);
    doc.text('Payments Report', 80,18);
    doc.setFontSize(12);
    doc.text(`From : ${startDate} To :${endDate}`,20,25);
    doc.autoTable({
    startY: 26,
    theme : 'grid',
    headStyles: { fillColor: [128,128,128] }, 
    columnStyles: { paymentsAmount: { halign: 'right' } }, 
    head: headRowsPayment(),
    body: bodyRowsPayment(Payments.length,Payments),
    })
    doc.text(`Total Amount (Rs):${payTotal}`,20,doc.previousAutoTable.finalY + 10);

fs.writeFileSync('output.pdf', doc.output(),{encoding:'utf8',flag:'w'}, (err) => {
  if (err) throw err;
  console.log('The file has been saved!');
})
     
}
getIncomeReport=(dayAdvance,maintain,deliveryFee,deliTotal,Diesel,delinums,lorry,range)=>{
    return `
    <!DOCTYPE html>
<html>
<head>
    <title>Convert JSON Data to HTML Table</title>
    <style>
        th, td, p, input {
            font:14px Verdana;
        }
.topic{
padding : 0px 110px;
}
.table{
padding: 3px 70px ;
}
.from{
padding:0px 100px 0px
}

        table, th 
        {
            table-layout: auto;
            
            border-collapse: collapse;
            padding: 2px 3px;
            text-align: left;
        }
        th {
            font-weight:bold;
        }
        td {
            text-align: right;
        }
        .t1 {
            text-align: left;
        }
        .date{
            padding: 3px 70px 0px;
            font:9px Times-New-Roman
        }
    </style>
</head>
<body>
<h6 class="topic">Transport Income Report</h6>
<p class="date">${range}</p>
<div class="table">
<table >
    <tr>
        <td class="t1">Lorry </td>
        <td> : </td>
        <td>${lorry.vehicleNumber}</td> 
    </tr>
    <tr>
        <td class="t1">Total Deliveries  </td>
        <td> : </td>
        <td>${delinums}</td>
    </tr>
    <tr>
        <td class="t1"><h5>Incomes</h5></td>
    </tr>
    <tr>
        <td class="t1">Total Delivery Price </td>
        <td> : Rs </td>
        <td>${deliTotal.toFixed(2)}</td>
    </tr>
    <tr>
    <td class="t1"><h5>Expenses</h5></td>
</tr>
    <tr>
        <td class="t1">Total Day Advance </td>
        <td> : Rs </td>
        <td>${dayAdvance.toFixed(2)}</td>
    </tr>
    <tr>
        <td class="t1">Total Repair Fee </td>
        <td> : Rs </td>
        <td>${maintain.toFixed(2)}</td>
    </tr>
    <tr>
        <td class="t1">Total Cash Payments </td>
        <td> : Rs </td>
        <td>${deliveryFee.toFixed(2)}</td>
    </tr>

    <tr>
        <td class="t1">Total Diesel Fee  </td>
        <td> : Rs </td>
        <td>${Diesel.toFixed(2)}</td>
    </tr>
    <tr><td><td></tr>
    <tr><td><td></tr>
    <tr>
        <td class="t1"><strong>Total Expenses</strong>  </td>
        <td> : Rs </td>
        <td id="total"></td>
    </tr>
    <tr>
        <td class="t1"><h6>Net Income</h6></td>
        <td> : Rs </td>
        <td id="balance"></td>
    </tr>
</table>
</div>
<script>
        function clcBalance(){
            return (${deliTotal}-(${dayAdvance}+${maintain}+${Diesel}+${deliveryFee})).toFixed(2);
        }
        document.getElementById("balance").innerHTML = clcBalance();

        function clcTotal(){
            return (${dayAdvance}+${maintain}+${Diesel}+${deliveryFee}).toFixed(2);
        }
        document.getElementById("total").innerHTML = clcTotal();
        
</script>

</body>


</html>
`
}
getPaymentReportOfLorry=(payments,payTotal,lorry,range)=>{
    var doc = new jsPDF();

    doc.text('Reliable Group Sri Lanka(Pvt) Ltd', 60,10);
    doc.text('Payments Report', 80,18);
    doc.setFontSize(12);
    doc.text(`Lorry : ${lorry.vehicleNumber}`,20,22)
    doc.text(`${range}`,20,26);
    doc.autoTable({
    startY: 28,
    theme : 'grid',
    headStyles: { fillColor: [128,128,128] }, 
    columnStyles: { paymentsAmount: { halign: 'right' } }, 
    head: headRowsLorryPayment(),
    body: bodyRowsLorryPayment(payments.length,payments),
    })
    doc.text(`Total Amount (Rs):${payTotal.toFixed(2)}`,20,doc.previousAutoTable.finalY + 10);

fs.writeFileSync('output.pdf', doc.output(),{encoding:'utf8',flag:'w'}, (err) => {
  if (err) throw err;
  console.log('The file has been saved!');
})
}
//Get Day Adanced Report
getFiteredReport=(Payments,range,lorry,payType,payTotal)=>{
        var doc = new jsPDF();

    doc.text('Reliable Group Sri Lanka(Pvt) Ltd', 60,10);
    doc.text(`${payType} Report`, 70,18);
    doc.setFontSize(12);
    doc.text(`Lorry : ${lorry.vehicleNumber}`,20,22)
    doc.text(`${range}`,20,26);
    doc.autoTable({
    startY: 28,
    theme : 'grid',
    headStyles: { fillColor: [128,128,128] }, 
    columnStyles: { paymentsAmount: { halign: 'right' } }, 
    head: headRowsFilteredPayment(),
    body: bodyRowsFilteredPayment(Payments.length,Payments),
    })
    doc.text(`Total Amount (Rs):${payTotal.toFixed(2)}`,20,doc.previousAutoTable.finalY + 10);

fs.writeFileSync('output.pdf', doc.output(),{encoding:'utf8',flag:'w'}, (err) => {
  if (err) throw err;
  console.log('The file has been saved!');
})
}

//Diesel Report
getDieselReport=(diesel,range,payTotal,lorry)=>{
    var doc = new jsPDF();

    doc.text('Reliable Group Sri Lanka(Pvt) Ltd', 60,10);
    doc.text(`Diesel Report`, 80,18);
    doc.setFontSize(12);
    doc.text(`Lorry : ${lorry.vehicleNumber}`,20,22)
    doc.text(`${range}`,20,26);
    doc.autoTable({
    startY: 28,
    theme : 'grid',
    headStyles: { fillColor: [128,128,128] }, 
    columnStyles: { paymentsAmount: { halign: 'right' } }, 
    head: headRowsDiesel(),
    body: bodyRowsDiesel(diesel.length,diesel),
    })
    doc.text(`Total Amount (Rs):${payTotal.toFixed(2)}`,20,doc.previousAutoTable.finalY + 10);

fs.writeFileSync('output.pdf', doc.output(),{encoding:'utf8',flag:'w'}, (err) => {
  if (err) throw err;
  console.log('The file has been saved!');
})
}

//heads for payment report
function headRowsPayment() {
  return [
    {paymentsId : 'Payment No',paymentsDate : 'Date',vehicle_vehicleNumber : 'Lorry',paymentsAmount : 'Amount', paymentTypeType : 'Payment Type',paymentsDescription :'Description'},
  ]
}

//heads for payment report of lorry
function headRowsLorryPayment() {
  return [
    {paymentsId : 'Payment No',paymentsDate : 'Date',paymentsAmount : 'Amount', paymentTypeType : 'Payment Type',paymentsDescription :'Description'},
  ]
}


//heads for filtered report
function headRowsFilteredPayment() {
  return [
    {paymentsId : 'Payment No',paymentsDate : 'Date',paymentsAmount : 'Amount',paymentsDescription :'Description'},
  ]
}

//heads for Diesel report
function headRowsDiesel() {
  return [
    {paymentsDate : 'Date',dieselFeeLiters :'Diesel Liters',paymentsAmount : 'Amount'},
  ]
}

//Bodies for reports

//Body for payment report
function bodyRowsPayment(rowCount,data) {
  rowCount = rowCount || 10
    let body = data.reduce((accumulator, currentValue) => {
  accumulator.push({
    paymentsId : currentValue.paymentsId,
    paymentsDate :currentValue.paymentsDate.substring(0,10),
    vehicle_vehicleNumber : currentValue.vehicle_vehicleNumber,
    paymentsAmount : currentValue.paymentsAmount.toFixed(2),
    paymentTypeType : currentValue.paymentTypeType,
    paymentsDescription : currentValue.paymentsDescription,
  });
  return accumulator;
},[]);
  return body
}

//Body for Lorry payment report
function bodyRowsLorryPayment(rowCount,data) {
    console.log(data)
  rowCount = rowCount || 10
    let body = data.reduce((accumulator, currentValue) => {
  accumulator.push({
    paymentsId : currentValue.paymentsId,
    paymentsDate :currentValue.paymentsDate.substring(0,10),
    paymentsAmount : currentValue.paymentsAmount.toFixed(2),
    paymentTypeType : currentValue.paymentTypeType,
    paymentsDescription : currentValue.paymentsDescription,
  });
  return accumulator;
},[]);
  return body
}

//Body for filtered report
function bodyRowsFilteredPayment(rowCount,data) {
  rowCount = rowCount || 10
    let body = data.reduce((accumulator, currentValue) => {
  accumulator.push({
    paymentsId : currentValue.paymentsId,
    paymentsDate :currentValue.paymentsDate.substring(0,10),
    paymentsAmount : currentValue.paymentsAmount.toFixed(2),
    paymentsDescription : currentValue.paymentsDescription,
  });
  return accumulator;
},[]);
  return body
}

//Body for diesel report
function bodyRowsDiesel(rowCount,data) {
  rowCount = rowCount || 10
    let body = data.reduce((accumulator, currentValue) => {
  accumulator.push({
    paymentsDate :currentValue.paymentsDate.substring(0,10),
    dieselFeeLiters :currentValue.dieselFeeLiters,
    paymentsAmount : currentValue.paymentsAmount.toFixed(2),

  });
  return accumulator;
},[]);
  return body
}

delete global.window;
delete global.navigator;
delete global.btoa;

module.exports={
    getPaymentReport,
    getIncomeReport,
    getPaymentReportOfLorry,
    getFiteredReport,
    getDieselReport
}