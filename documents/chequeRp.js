chequeReport=(range, cheque,total)=>{
   var ch=JSON.stringify(cheque);
    return `
    <!DOCTYPE html>
<html>
<head>
    
    <style>
        th, td, p, input {
            font:8px Times-new-roman;
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
                min-width :50px;
                
                
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
<h6 class="topic2">Cheques Report</h6>
<p class="from">${range}</p>
<p id="showData" class="table" ></p>
<p class="from">Total (Rs) :${total.toFixed(2)}</p>


<script>

    function CreateTableFromJSON() {
        var payments = ${ch}

        // EXTRACT VALUE FOR HTML HEADER. 

        

        
        var col = ['Cheque Number','Issue Date', 'Realise Date', 'Company', 'Bank','Amount'];
        var col2=['chequesNumber','chequesIssueDate','chequesRealiseDate','companyName','chequesBank','chequesAmount'];

        // CREATE DYNAMIC TABLE.
        var table = document.createElement("table");

        // CREATE HTML TABLE HEADER ROW USING THE EXTRACTED HEADERS ABOVE.

        var tr = table.insertRow(-1);                   // TABLE ROW.

        for (var i = 0; i < col.length; i++) {
            var th = document.createElement("th");      // TABLE HEADER.
            th.innerHTML = col[i];
            tr.appendChild(th);
        }
        var t=0;
        // ADD JSON DATA TO THE TABLE AS ROWS.
        for (var i = 0; i < payments.length; i++) {
            tr = table.insertRow(-1);

            for (var j = 0; j < col2.length; j++) {
                var tabCell = tr.insertCell(-1);
                if(!col2[j].toString().localeCompare('chequesIssueDate')){
                    tabCell.innerHTML=payments[i][col2[j]].toString().substring(0,10);
                }
                else if(!col2[j].toString().localeCompare('chequesRealiseDate')){
                    tabCell.innerHTML=payments[i][col2[j]].toString().substring(0,10);
                }
                else if(!col2[j].toString().localeCompare('chequesAmount')){
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
chequeReportByCmp=(range,company, cheque,total)=>{
    var ch=JSON.stringify(cheque);
     return `
     <!DOCTYPE html>
 <html>
 <head>
     
     <style>
         th, td, p, input {
             font:8px Times-new-roman;
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
                 min-width :50px;
                 
                 
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
 <h6 class="topic2">Cheques Report</h6>
 <p class="from"><b>${company}</b></p>
 <p class="from">${range}</p>
 <p id="showData" class="table" ></p>
 <p class="from">Total (Rs) :${total.toFixed(2)}</p>
 
 
 <script>
 
     function CreateTableFromJSON() {
         var payments = ${ch}
 
         // EXTRACT VALUE FOR HTML HEADER. 
 
         
 
         
         var col = ['Cheque Number','Issue Date', 'Realise Date', 'Company', 'Bank','Amount'];
         var col2=['chequesNumber','chequesIssueDate','chequesRealiseDate','companyName','chequesBank','chequesAmount'];
 
         // CREATE DYNAMIC TABLE.
         var table = document.createElement("table");
 
         // CREATE HTML TABLE HEADER ROW USING THE EXTRACTED HEADERS ABOVE.
 
         var tr = table.insertRow(-1);                   // TABLE ROW.
 
         for (var i = 0; i < col.length; i++) {
             var th = document.createElement("th");      // TABLE HEADER.
             th.innerHTML = col[i];
             tr.appendChild(th);
         }
         var t=0;
         // ADD JSON DATA TO THE TABLE AS ROWS.
         for (var i = 0; i < payments.length; i++) {
             tr = table.insertRow(-1);
 
             for (var j = 0; j < col2.length; j++) {
                 var tabCell = tr.insertCell(-1);
                 if(!col2[j].toString().localeCompare('chequesIssueDate')){
                     tabCell.innerHTML=payments[i][col2[j]].toString().substring(0,10);
                 }
                 else if(!col2[j].toString().localeCompare('chequesRealiseDate')){
                     tabCell.innerHTML=payments[i][col2[j]].toString().substring(0,10);
                 }
                 else if(!col2[j].toString().localeCompare('chequesAmount')){
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
    chequeReport,
    chequeReportByCmp
}