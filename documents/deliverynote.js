global.window = {document: {createElementNS: () => {return {}} }};
global.navigator = {};
global.html2pdf = {};
global.btoa = () => {};

const fs = require('fs')
const jsPDF = require('jspdf');

getDeliveryNote=(company,lorry,driver,unloadingPlace,capacity,distance,time)=>{
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

    var doc = new jsPDF();
	doc.text('Reliable Group Sri Lanka(Pvt) Ltd', 70,25);
	doc.setFontSize(13);
	doc.text('Delivery Note',95,35);
	doc.text('N0.524, Lot 7, Hadungamuwa, Matale',75,40);
	doc.text('Tel:0765 505 252/ 0717 615 911',80,45);
	doc.setFontSize(12);
	doc.text('Date ',70,50);
	doc.text(`: ${date}`,120,50)
	doc.text('Comapny ',70,55);
	doc.text(`: ${company}`,120,55);
	doc.text('Lorry Name ',70,60);
	doc.text(`: ${lorry}`,120,60)
	doc.text(`Driver's Name `,70,65);
	doc.text(`: ${driver}`,120,65);
	doc.text('Load Capacity ',70,70);
	doc.text(`: ${capacity} cube(s)`,120,70);
	doc.text('Unloading Place',70,75);
	doc.text(`: ${unloadingPlace}`,120,75)
	doc.text('Distance ',70,80);
	doc.text(`: ${distance} km`,120,80);
	doc.text('Departure Time ',70,85);
	doc.text(`: ${time} ${t}`,120,85)

	doc.text('Acceptance ',95,95);

	doc.text('Accepted By ',70,105);
	doc.text(': ........................',120,105);
	doc.text('Accepted Time ',70,110);
	doc.text(': ........................',120,110);
	doc.text('Signature ',70,115);
	doc.text(': ........................',120,115);
	doc.rect(40, 20, doc.internal.pageSize.width - 60, doc.internal.pageSize.height - 180, 'S');
	doc.autoPrint();
	fs.writeFileSync('output.pdf', doc.output(),{encoding:'utf8',flag:'w'}, (err) => {
		if (err) throw err;
		console.log('The file has been saved!');
	  })
	  
}
getPettyCashBook=(pettyCash,date)=>{
	var petty =JSON.stringify(pettyCash)
	var total=0;
	for(var i=0; i<pettyCash.length; i++){
		total += pettyCash[i].paymentsAmount;
	}
    return `
    <!DOCTYPE html>
<html>
<head>
    
    <style>
        th, td, p, input {
            font:9px Times-new-roman;
        }

        .topic2{
                padding : 0px 130px;
            }

        .from{
            padding:0px 10px 0px
            }
        table, th, td 
        {
            table-layout: auto;
            border: solid 1px #DDD;
            border-collapse: collapse;
            padding: 2px 3px;
			text-align: center;
			min-width : 90px;
            
        }
        th {
            font-weight:bold;
            width : 50px;
        }
    </style>
</head>
<body>
<h6 class="topic2">PettyCash Book</h6>
<p class="from">Date : ${date}</p>
<p id="showData" class="table" ></p>
<p class="from">Total Payments : ${total}</p>



<script>

    function CreateTableFromJSON() {
        var payments = ${petty}

        // EXTRACT VALUE FOR HTML HEADER. 
        
        var col = ['Lorry','Pay Type', 'Description', 'Amount (Rs)',];
        var col2=['vehicle_vehicleNumber','paymentTypeType','paymentsDescription','paymentsAmount'];


        // CREATE DYNAMIC TABLE.
        var table = document.createElement("table");

        // CREATE HTML TABLE HEADER ROW USING THE EXTRACTED HEADERS ABOVE.

        var tr = table.insertRow(-1);                   // TABLE ROW.

        for (var i = 0; i < col.length; i++) {
            var th = document.createElement("th");      // TABLE HEADER.
            th.innerHTML = col[i];
            tr.appendChild(th);
        }
		
        // ADD JSON DATA TO THE TABLE AS ROWS.
        for (var i = 0; i < payments.length; i++) {
            tr = table.insertRow(-1);

            for (var j = 0; j < col2.length; j++) {
                var tabCell = tr.insertCell(-1);
                tabCell.innerHTML = payments[i][col2[j]];
            }
        }

        // FINALLY ADD THE NEWLY CREATED TABLE WITH JSON DATA TO A CONTAINER.
        var divContainer = document.getElementById("showData");
        divContainer.innerHTML = "";
        divContainer.appendChild(table);
    }
CreateTableFromJSON();

</script>
</body>


</html>
    `
}
delete global.window;
delete global.navigator;
delete global.btoa;

module.exports={
	getDeliveryNote,
	getPettyCashBook
}