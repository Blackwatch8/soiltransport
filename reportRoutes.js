const express = require('express');
const bodyParser = require('body-parser');
const pdf = require('html-pdf');
const cors = require('cors');

const pdfTemplate = require('./documents');

const reportRouter = express.Router();


reportRouter.use(cors());
reportRouter.use(bodyParser.urlencoded({extended: true}));
reportRouter.use(bodyParser.json());

var options={

    "format": "Letter",        // allowed units: A3, A4, A5, Legal, Letter, Tabloid
    "orientation": "portrait", // portrait or landscape
  
    "border": {
      "top": "0.75in",            // default is 0, units: mm, cm, in, px
      "right": "1in",
      "bottom": "1in",
      "left": "1.5in",
      "width": "2px"
    },
  
    paginationOffset: 1,       // Override the initial pagination number
    "header": {
        "height": "15mm",
        "contents": '<div style="text-align: center;"><u>Reliable Group Sri Lanka (Pvt) Ltd</u></div>'
      },
      "footer": {
        "height": "2mm",
        "contents": {
          default: '<span style="text-align: center;">{{page}}</span>', // fallback value
        }
      },
}
var options2={

    "format": "Letter",        // allowed units: A3, A4, A5, Legal, Letter, Tabloid
    "orientation": "portrait", // portrait or landscape
  
    "border": {
      "top": "0.75in",            // default is 0, units: mm, cm, in, px
      "right": "1in",
      "bottom": "1in",
      "left": "1.5in"
    },
  
    paginationOffset: 1,       // Override the initial pagination number
    "header": {
        "height": "15mm",
        "contents": `<div id="PageHeader-1" style="text-align: center;"><u>Reliable Group Sri Lanka (Pvt) Ltd</u></div>
        `
      },
      "footer": {
        "height": "2mm",
        "contents": {
          default: '<span style="text-align: center;">{{page}}</span>', // fallback value
        }
      },
}
//Daily delivery report
reportRouter.post('/getDailyDeliveryReport', (req, res) => {
    try{
    const {deliveries,startDate,endDate}=req.body;
    pdfTemplate.DeliveryRp.getDailyDeliveryRp(deliveries,startDate,endDate);
    res.send(Promise.resolve());
}catch(e){
    res.send(Promise.reject());
}
});
//Delivery Report Of the lorry
reportRouter.post('/getdeliveryreportoflorry', (req, res) => {
    try{
    const {deliveries,startDate,endDate,lorry,deliTotal}=req.body;
    pdfTemplate.DeliveryRp.getDeliveryReportOfLorry(deliveries,startDate,endDate,lorry,deliTotal)
    res.send(Promise.resolve());
    }catch(e){
    res.send(Promise.reject());
}
  
});
//Daily Payment Report
reportRouter.post('/getDailyPaymentReport', (req, res) => {
    try{
    const {payments,startDate,endDate,payTotal}=req.body;
    pdfTemplate.PaymentRp.getPaymentReport(payments,startDate,endDate,payTotal)
      res.send(Promise.resolve());
  }
      catch(e){
    res.send(Promise.reject());
}
    
});
//Payment Report For Lorry
reportRouter.post('/getDailyPaymentReportOfLorry', (req, res) => {
    try{
    const {payments,payTotal,lorry,range}=req.body;
    pdfTemplate.PaymentRp.getPaymentReportOfLorry(payments,payTotal,lorry,range);
    res.send(Promise.resolve());
    }catch(e){
    res.send(Promise.reject());
}
   
});
//filterd reports
reportRouter.post('/getfilteredreportoflorry', (req, res) => {
    try{
    const {payments,range,lorry,payType,payTotal}=req.body;
    pdfTemplate.PaymentRp.getFiteredReport(payments,range,lorry,payType,payTotal)
      res.send(Promise.resolve());
      }catch(e){
    res.send(Promise.reject());
}
  
});
//Income Report
reportRouter.post('/getincomereport',(req,res) => {
    const {dayAdvance,maintain,deliveryFee,deliTotal,Diesel,delinums,lorry,range}=req.body;
    pdf.create(pdfTemplate.PaymentRp.getIncomeReport(dayAdvance,maintain,deliveryFee,deliTotal,Diesel,delinums,lorry,range),options).toFile('output.pdf', (err) => {
        if(err) {
            res.send(Promise.reject());
        }

        res.send(Promise.resolve());
    });
})
reportRouter.post('/getdieselreport',(req,res) => {
    try{
    const {diesel,range,payTotal,lorry}=req.body;
    pdfTemplate.PaymentRp.getDieselReport(diesel,range,payTotal,lorry)
    res.send(Promise.resolve());
    }catch(e){
    res.send(Promise.reject());
}
})

//get delivery Note
reportRouter.post('/getdeliverynote',(req,res) => {

    try{
    const {company,lorry,driver,unloadingPlace,capacity,distance,time}=req.body;
    pdfTemplate.DeliNote.getDeliveryNote(company,lorry,driver,unloadingPlace,capacity,distance,time)
    res.send(Promise.resolve());
        }
    catch(e){
        res.send(Promise.reject());
    }
})
//get petty cash book
reportRouter.post('/getpettycashbookRp',(req,res) => {
    const {pettyCash,date}=req.body;
    pdf.create(pdfTemplate.DeliNote.getPettyCashBook(pettyCash,date),options).toFile('output.pdf', (err) => {
        if(err) {
            res.send(Promise.reject());
        }

        res.send(Promise.resolve());
    });
})
//get invoice
reportRouter.post('/getinvoiceRp',(req,res) => {

    try{
    const {invoice,company,range,deliTotal}=req.body;
    pdfTemplate.Invoice.getInvoice(invoice,company,range,deliTotal)

    res.send(Promise.resolve());
    }catch(e){
    res.send(Promise.reject());
}
   
})


//get cheques report

reportRouter.post('/getchequeRp',(req,res) => {

    const {range,cheques,total}=req.body;
    pdfTemplate.Cheque.chequeReport(range,cheques,total)
    res.send(Promise.resolve());
})

reportRouter.get('/fetch-pdf', (req, res) => {
    res.sendFile(`${__dirname}/output.pdf`)
})

reportRouter.post('/getchequebycpmRp',(req,res) => {

    const {range,company,cheques,total}=req.body;
    pdfTemplate.Cheque.chequeReportCmp(range,company,cheques,total)
    res.send(Promise.resolve());
})



module.exports=reportRouter

