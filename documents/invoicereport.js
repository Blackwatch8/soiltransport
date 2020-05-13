getInvoice=(invoice,company,range,deliTotal)=>{
    var inv=JSON.stringify(invoice);
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
        min-width: 60px;
        
    }
    th {
        font-weight:bold;
        width : 50px;
    }
    .t1{

        border: 0px;
        padding: 2px 3px;
        text-align: left;

    }
    </style>
</head>
<body>
<h6 class="topic2">Invoice Of ${company}</h6>
<p class="from">${range}</p>
<p id="showData" class="table" ></p>

  <p>Total Number Of Deliveries  : ${invoice.length}</p>
    <p>Total Invoice Amount      : Rs.<b> ${deliTotal.toFixed(2)}</b></p>



<script>

    function CreateTableFromJSON() {
        var invoices = ${inv}
        // EXTRACT VALUE FOR HTML HEADER. 
        
        var col = ['Delivery Note', 'Delivery Date', 'Lorry', 'Unloading Place','Cubes','Rate'];
        var col2=['deliveryNoteNO','deliveryDate','vehicle_vehicleNumber','uploadingPlaceAddress','vehicleCapacity','unloadingPlaceIncomeRate'];


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

        for (var i = 0; i < 29; i++) {
            tr = table.insertRow(-1);


            for (var j = 0; j < col2.length; j++) {
                var tabCell = tr.insertCell(-1);
                if(!col2[j].toString().localeCompare('deliveryDate')){
                    tabCell.innerHTML=invoices[i][col2[j]].toString().substring(0,10);
                }
                else if(!col2[j].toString().localeCompare('unloadingPlaceIncomeRate')){
                    tabCell.innerHTML=invoices[i][col2[j]].toFixed(2);
                }
                else{
                tabCell.innerHTML = invoices[i][col2[j]];
                }
            }
             
        }

        // CREATE HTML TABLE HEADER ROW USING THE EXTRACTED HEADERS ABOVE.
        var count=29;

        for(var c=0; count<invoices.length;c++){


        var tr = table.insertRow(-1);                   // TABLE ROW.



        for (var i = 0; i < col.length; i++) {
            var th = document.createElement("th");      // TABLE HEADER.
            th.innerHTML = col[i];
            tr.appendChild(th);
        }

        
        // ADD JSON DATA TO THE TABLE AS ROWS.
		var loops=0;
        for(var i=count;i<invoices.length; i++) {
        	
	        tr = table.insertRow(-1);
	        
            
            for (var j = 0; j < col2.length; j++) {
                var tabCell = tr.insertCell(-1);
                if(!col2[j].toString().localeCompare('deliveryDate')){
                    tabCell.innerHTML=invoices[count][col2[j]].toString().substring(0,10);
                }
                else if(!col2[j].toString().localeCompare('unloadingPlaceIncomeRate')){
                    tabCell.innerHTML=invoices[count][col2[j]].toFixed(2);
                }
                else{
                tabCell.innerHTML = invoices[count][col2[j]];
                }
                
            }
            console.log(count)
			           if(loops==33){
			           	count=count+1;
			           	break;
			           }
			loops++;
           count=count+1
           


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
    getInvoice
}