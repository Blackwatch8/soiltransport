getDeliveryNote=(company,lorry,driver,unloadingPlace,capacity,distance,time)=>{
	var today=new Date();
	var date = today.getFullYear() + '-' + (today.getMonth() + 1) + '-' + today.getDate();
	 date=date.substring(0,11);

    return `
    <!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
    <style>
    th, td, p, input {
        font:12px Times-new-roman;
    }
		.topic{
			padding: 5px 130px
		}
		.address{
			padding: 5px 70px;
		}
		.table{
			padding: 10px 20px;
			min-width: 440px;
		}
	</style>
</head>
<body>
                <strong class="topic">Delivery Note</strong><br><br>
                <small class="address">N0.524, Lot 7, Hadungamuwa, Matale</small><br>
                <small class="address">Tel:0765 505 252/ 0717 615 911</small><br>
                <small class="address">෧බාරළු, වැලි,ගල් සැපයුම්කරු</small><br>

                <table class="table" >
                	<tr>
                		<td>Date </td>
                		<td>:</td>
                		<td>${date}</td>
                	</tr>
                	<tr>
                		<td>Comapany </td>
                		<td>:</td>
                		<td>${company}</td>
                	</tr>
                	<tr>
                		<td>Lorry Number</td>
                		<td>:</td>
                		<td>${lorry}</td>
                	</tr>
                	<tr>
                		<td>Driver's Name</td>
                		<td>:</td>
                		<td>${driver}</td>
                	</tr>
                	<tr>
                		<td>Load Capacity</td>
                		<td>:</td>
                		<td>${capacity} cubes</td>
                	</tr>
                	<tr>
                		<td>Unloading Place</td>
                		<td>:</td>
                		<td>${unloadingPlace}</td>
                	</tr>
                	<tr>
                		<td>Distance</td>
                		<td>:</td>
                		<td> ${distance}</td>
					</tr>
					<tr>
					<td>Departure Time</td>
					<td>:</td>
					<td> ${time}</td>
				</tr>
                	<tr></tr>
                	<tr></tr>
                	<tr>
                		<td style="text-align: right"><strong>Acceptace</strong></td>
                	</tr>
                	<tr></tr>
                	<tr>
                		<td>Accepted By</td>
                		<td>:</td>
                		<td>.............................</td>
					</tr>
					<tr>
					<td>Accepted Time</td>
					<td>:</td>
					<td>.............................</td>
				</tr>
                	<tr>
                		<td>Signature</td>
                		<td>:</td>
                		<td>.............................</td>
                	</tr>
                	</tr>
                </table>
</body>
</html>
    `
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
module.exports={
	getDeliveryNote,
	getPettyCashBook
}