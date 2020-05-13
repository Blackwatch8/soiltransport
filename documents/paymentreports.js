
getPaymentReport=(Payments,startDate,endDate,payTotal)=>{
    var pays=JSON.stringify(Payments);
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
                min-width:50px;
                
            }
            td{
                border: solid 1px #DDD;
                border-collapse: collapse;
                padding: 3px 8px;
                text-align: right; 
            }
        th {
            font-weight:bold;
            width : 50px;
        }
    </style>
</head>
<body>
<h6 class="topic2">Payment Report</h6>
<p class="from">From : ${startDate}   To : ${endDate}</p>
<p id="showData" class="table" ></p>
<p class="from">Total (Rs) :${payTotal}</p>


<script>

    function CreateTableFromJSON() {
        var payments = ${pays}

        // EXTRACT VALUE FOR HTML HEADER. 
        
        var col = ['Pay No','Date', 'Lorry', 'Charge (Rs)', 'Pay Type','Description'];
        var col2=['paymentsId','paymentsDate','vehicle_vehicleNumber','paymentsAmount','paymentTypeType','paymentsDescription'];


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
                if(!col2[j].toString().localeCompare('paymentsDate')){
                    tabCell.innerHTML=payments[i][col2[j]].toString().substring(0,10);
                }
                else if(!col2[j].toString().localeCompare('paymentsAmount')){
                    tabCell.innerHTML=payments[i][col2[j]].toFixed(2);
                }
                else{
                tabCell.innerHTML = payments[i][col2[j]];
                }
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
    pays=JSON.stringify(payments);
    return  `
    <!DOCTYPE html>
<html>
<head>
    
    <style>
        th, td, p, input {
            font:10px Times-new-roman;
        }
        .topic{
            padding : 0px 100px;
        }

        .topic2{
                padding : 0px 130px;
            }

        .from{
            padding:0px 10px 0px
            font:8px Times-new-roman;
            }
        table, th, td 
        {
            table-layout: auto;
            border: solid 1px #DDD;
            border-collapse: collapse;
            padding: 2px 3px;
            text-align: center;
            min-width:60px;
            
        }
        td{
            border: solid 1px #DDD;
            border-collapse: collapse;
            padding: 3px 8px;
            text-align: right; 
        }
        th {
            font-weight:bold;
            width : 50px;
        }
    </style>
</head>
<body>
<h6 class="topic">Payment Report Of ${lorry.vehicleNumber}</h6>
<p class="from">${range}</p>
<p id="showData" class="table" ></p>
<p class="from">Total Payments : ${payTotal.toFixed(2)}</p>



<script>

    function CreateTableFromJSON() {
        var payments = ${pays}

        // EXTRACT VALUE FOR HTML HEADER. 
        
        var col = ['Pay No','Date', 'Charge (Rs)', 'Pay Type','Description'];
        var col2=['paymentsId','paymentsDate','paymentsAmount','paymentTypeType','paymentsDescription'];


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
                if(!col2[j].toString().localeCompare('paymentsDate')){
                    tabCell.innerHTML=payments[i][col2[j]].toString().substring(0,10);
                }
                else if(!col2[j].toString().localeCompare('paymentsAmount')){
                    tabCell.innerHTML=payments[i][col2[j]].toFixed(2);
                }
                else{
                tabCell.innerHTML = payments[i][col2[j]];
                }
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
//Get Day Adanced Report
getFiteredReport=(Payments,range,lorry,payType,payTotal)=>{
    var pays=JSON.stringify(Payments);
    return `
    <!DOCTYPE html>
<html>
<head>
    
    <style>
        th, td, p, input {
            font:9px Times-new-roman;
        }

        .topic2{
                padding : 0px 100px;
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
            min-width: 90px;
            
        }
        border: solid 1px #DDD;
        border-collapse: collapse;
        padding: 3px 8px;
        text-align: right; 
    }
        th {
            font-weight:bold;
            width : 50px;
        }
    </style>
</head>
<body>
<h6 class="topic2">${payType} Report Of ${lorry.vehicleNumber}</h6>
<p class="from">${range}</p>
<p id="showData" class="table" ></p>
<p class="from">Total Payments : ${payTotal.toFixed(2)}</p>


<script>

    function CreateTableFromJSON() {
        var payments = ${pays}

        // EXTRACT VALUE FOR HTML HEADER. 
        
        var col = ['Pay No','Date', 'Charge (Rs)','Description'];
        var col2=['paymentsId','paymentsDate','paymentsAmount','paymentsDescription'];


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
                if(!col2[j].toString().localeCompare('paymentsDate')){
                    tabCell.innerHTML=payments[i][col2[j]].toString().substring(0,10);
                }
                else if(!col2[j].toString().localeCompare('paymentsAmount')){
                    tabCell.innerHTML=payments[i][col2[j]].toFixed(2);
                }
                else{
                tabCell.innerHTML = payments[i][col2[j]];
                }
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

//Diesel Report
getDieselReport=(diesel,range,payTotal,lorry)=>{
    var die=JSON.stringify(diesel);
    console.log(die)
    return `
    <!DOCTYPE html>
<html>
<head>
    
    <style>
        th, td, p, input {
            font:9px Times-new-roman;
        }

        .topic2{
                padding : 0px 100px;
            }

        .from{
            padding:0px 10px 0px
            }
        table, th
        {
            table-layout: auto;
            border: solid 1px #DDD;
            border-collapse: collapse;
            padding: 2px 3px;
            text-align: center;
            min-width: 120px;
            
        }
        th {
            font-weight:bold;
            width : 50px;
        }
        td{
            text-align: right;
            border: solid 1px #DDD;
            border-collapse: collapse;
            padding: 2px px;
        }
    </style>
</head>
<body>
<h6 class="topic2">Diesel Fee Report Of ${lorry.vehicleNumber}</h6>
<p class="from">${range}</p>
<p id="showData" class="table" ></p>
<p class="from">Total Payments : ${payTotal.toFixed(2)}</p>


<script>

    function CreateTableFromJSON() {
        var payments = ${die}

        // EXTRACT VALUE FOR HTML HEADER. 
        
        var col = ['Date','Liters', 'Price (Rs)'];
        var col2=['paymentsDate','dieselFeeLiters','paymentsAmount'];


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
                if(!col2[j].toString().localeCompare('paymentsDate')){
                    tabCell.innerHTML=payments[i][col2[j]].toString().substring(0,10);
                }
                else if(!col2[j].toString().localeCompare('paymentsAmount')){
                    tabCell.innerHTML=payments[i][col2[j]].toFixed(2);
                }
                else{
                tabCell.innerHTML = payments[i][col2[j]];
                }
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
    getPaymentReport,
    getIncomeReport,
    getPaymentReportOfLorry,
    getFiteredReport,
    getDieselReport
}