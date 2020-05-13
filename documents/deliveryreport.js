getDailyDeliveryRp=(Deliveries,startDate,endDate)=>{
    var deli=JSON.stringify(Deliveries);
    var total=0;
    var val=0;
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
        min-width: 30px;
        
    }
    th {
        font-weight:bold;
        width : 50px;
    }
    </style>
</head>
<body>
<h6 class="topic2">Delivery Report</h6>
<p class="from">From : ${startDate}   To : ${endDate}</p>
<p id="showData" class="table" ></p>
<p class="from">Total Deliveries : ${Deliveries.length}</p>



<script>

    function CreateTableFromJSON() {
        var deliveries = ${deli}

        // EXTRACT VALUE FOR HTML HEADER. 
        
        var col = ['Delivery Note', 'Delivery Date', 'Lorry', 'Unloading Place','Company','Driver','Status'];
        var col2=['deliveryNoteNO','deliveryDate','vehicle_vehicleNumber','uploadingPlaceAddress','companyName','driverName','deliveryAcceptance'];


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
        for (var i = 0; i < deliveries.length; i++) {
            tr = table.insertRow(-1);

            for (var j = 0; j < col2.length; j++) {
                var tabCell = tr.insertCell(-1);
                if(!col2[j].toString().localeCompare('deliveryDate')){
                    tabCell.innerHTML=deliveries[i][col2[j]].toString().substring(0,10);
                }
                else if(!col2[j].toString().localeCompare('deliveryDistance')){
                    tabCell.innerHTML=deliveries[i][col2[j]].toString()+"(km)";
                }
                else{
                tabCell.innerHTML = deliveries[i][col2[j]];
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
getDeliveryReportOfLorry=(deliveries,startDate,endDate,lorry,deliTotal)=>{
    var deli=JSON.stringify(deliveries)
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
        min-width: 60px;
        
    }
    th {
        font-weight:bold;
        width : 50px;
    }
    </style>
</head>
<body>
<h6 class="topic2">Delivery Report Of ${lorry.vehicleNumber}</h6>
<p class="from">From : ${startDate}   To : ${endDate}</p>
<p id="showData" class="table" ></p>
<p class="from">Number of Deliveries : ${deliveries.length}</p>
<p class="from"> Total Delivery Price : ${deliTotal}</p>



<script>

    function CreateTableFromJSON() {
        var deliveries = ${deli}

        // EXTRACT VALUE FOR HTML HEADER. 
        
        var col = ['Delivery Note', 'Delivery Date', 'Unloading Place','Distance','Driver','Payment'];
        var col2=['deliveryNoteNO','deliveryDate','uploadingPlaceAddress','deliveryDistance','driverName','deliveryPayment'];


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
        for (var i = 0; i < deliveries.length; i++) {
            tr = table.insertRow(-1);

            for (var j = 0; j < col2.length; j++) {
                var tabCell = tr.insertCell(-1);
                if(!col2[j].toString().localeCompare('deliveryDate')){
                    tabCell.innerHTML=deliveries[i][col2[j]].toString().substring(0,10);
                }
                else if(!col2[j].toString().localeCompare('deliveryDistance')){
                    tabCell.innerHTML=deliveries[i][col2[j]].toString()+"(km)";
                }
                else{
                tabCell.innerHTML = deliveries[i][col2[j]];
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
    getDailyDeliveryRp,
    getDeliveryReportOfLorry
}