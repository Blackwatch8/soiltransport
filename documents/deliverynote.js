global.window = {document: {createElementNS: () => {return {}} }};
global.navigator = {};
global.html2pdf = {};
global.btoa = () => {};

const fs = require('fs')
const jsPDF = require('jspdf');

getDeliveryNote=(company,lorry,driver,unloadingPlace,capacity,distance,time,delinote)=>{
	var today=new Date();
	var date = today.getFullYear() + '-' + (today.getMonth() + 1) + '-' + today.getDate();
	 date=date.substring(0,11);
	var t='';

	 if(time.toString().substring(0,2)<12){
		t="am";

	 }
	 else{
		 t="pm";

	 }
// document of 120 mm with and 150mm height
/*	var doc = new jsPDF('l', 'mm', [120, 150]);
	doc.setFontSize(5);
	doc.text('Reliable Group Sri Lanka(Pvt) Ltd', 13,5);
	doc.setFontSize(4);
	doc.text(`Delivery Note : ${get3D(delinote)}`,20,7);
	doc.text('N0.524, Lot 7, Hadungamuwa, Matale',15,8.5);
	doc.text('Tel:0765 505 252/ 0717 615 911',16,10);
	doc.setFontSize(3);
	doc.text('Date ',15,12);
	doc.text(`: ${date}`,30,12)
	doc.text('Comapny ',15,14);
	doc.text(`: ${company}`,30,14);
	doc.text('Lorry Name ',15,16);
	doc.text(`: ${lorry}`,30,16)
	doc.text(`Driver's Name `,15,18);
	doc.text(`: ${driver}`,30,18);
	doc.text('Load Capacity ',15,20);
	doc.text(`: ${capacity} cube(s)`,30,20);
	doc.text('Unloading Place',15,22);
	doc.text(`: ${unloadingPlace}`,30,22)
	doc.text('Distance ',15,24);
	doc.text(`: ${distance} km`,30,24);
	doc.text('Departure Time ',15,26);
    doc.text(`: ${time} ${t}`,30,26);
    doc.text(`Acceptance`,25,29);
    doc.text('Accepted by',15,32);
    doc.text(': ..................',30,32);
    doc.text('Accepted Time',15,34);
    doc.text(': ..................',30,34);
    doc.text('Signature',15,36);
    doc.text(': ..................',30,36);

	doc.rect(1, 1, doc.internal.pageSize.width - 2, doc.internal.pageSize.height - 2, 'S');
	doc.autoPrint();
	fs.writeFileSync('output.pdf', doc.output(),{encoding:'utf8',flag:'w'}, (err) => {
		if (err) throw err;
		console.log('The file has been saved!');
    })
    
	  */
   var doc = new jsPDF();
   doc.setFontSize(18);
   doc.text('Reliable Group Sri Lanka(Pvt) Ltd', 60,15);
   doc.setFontSize(14);
   doc.text(`Delivery Note : ${get3D(delinote)}`,85,22);
   doc.text('N0.524, Lot 7, Hadungamuwa, Matale',65,30);
   doc.text('Tel:0765 505 252/ 0717 615 911',70,37);
   doc.setFontSize(12);
   doc.text('Date ',65,45);
   doc.text(`: ${date}`,115,45)
   doc.text('Comapny ',65,52);
   doc.text(`: ${company}`,115,52);
   doc.text('Lorry Name ',65,59);
   doc.text(`: ${lorry}`,115,59)
   doc.text(`Driver's Name `,65,66);
   doc.text(`: ${driver}`,115,66);
   doc.text('Load Capacity ',65,73);
   doc.text(`: ${capacity} cube(s)`,115,73);
   doc.text('Unloading Place',65,80);
   doc.text(`: ${unloadingPlace}`,115,80)
   doc.text('Distance ',65,87);
   doc.text(`: ${distance} km`,115,87);
   doc.text('Departure Time ',65,94);
     doc.text(`: ${time} ${t}`,115,94);
     doc.text(`Acceptance`,90,102);
     doc.text('Accepted by',65,110);
     doc.text(': ..................',115,110);
     doc.text('Accepted Time',65,117);
     doc.text(': ..................',115,117);
     doc.text('Signature',65,124);
     doc.text(': ..................',115,124);
 
   doc.rect(1, 1, doc.internal.pageSize.width - 2, doc.internal.pageSize.height - 2, 'S');
   doc.autoPrint();
   fs.writeFileSync('output.pdf', doc.output(),{encoding:'utf8',flag:'w'}, (err) => {
     if (err) throw err;
     console.log('The file has been saved!');
     })
}
getPettyCashBook=(pettyCash,date,total)=>{
    var doc = new jsPDF();

    doc.text('Reliable Group Sri Lanka(Pvt) Ltd', 60,10);
    doc.text(`Petty Cash Book`, 80,18);
    doc.setFontSize(12);
    doc.text(`Date : ${date}`,20,25);
    doc.autoTable({
    startY: 26,
    theme : 'grid',
    headStyles: { fillColor: [128,128,128] }, 
    columnStyles: { paymentsAmount: { halign: 'right' } }, 
    head: headRowsPetty(),
    body: bodyRowsPetty(pettyCash.length,pettyCash),
    })
    doc.text(`Total Amount (Rs):${total.toFixed(2)}`,20,doc.previousAutoTable.finalY + 10);

   fs.writeFileSync('output.pdf', doc.output(),{encoding:'utf8',flag:'w'}, (err) => {
    if (err) throw err;
    console.log('The file has been saved!');
  })

}

//heads for Diesel report
function headRowsPetty() {
    return [
      {vehicle_vehicleNumber : 'Lorry',paymentTypeType :'Payment Type',paymentsDescription:'Description',paymentsAmount : 'Amount'},
    ]
  }
//Body for pettycash book
function bodyRowsPetty(rowCount,data) {
    rowCount = rowCount || 10
      let body = data.reduce((accumulator, currentValue) => {
    accumulator.push({
        vehicle_vehicleNumber :currentValue.vehicle_vehicleNumber,
        paymentTypeType : currentValue.paymentTypeType,
        paymentsDescription : currentValue.paymentsDescription,
        paymentsAmount : currentValue.paymentsAmount.toFixed(2),
  
    });
    return accumulator;
  },[]);
    return body
  }
  function get3D( num ) {
    if( num.toString().length < 1 ){ // Integer of less than 1 digit
        return "00" + num; // Prepend a zero!
    }
    else if( num.toString().length < 2 ){ // Integer of less than two digits
      return "00" + num; // Prepend a zero!
  }
    return num.toString(); // return string for consistency
}
delete global.window;
delete global.navigator;
delete global.btoa;

module.exports={
	getDeliveryNote,
	getPettyCashBook
}