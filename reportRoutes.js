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
    const {deliveries,startDate,endDate}=req.body;
    pdf.create(pdfTemplate.DeliveryRp.getDailyDeliveryRp(deliveries,startDate,endDate), options).toFile('result.pdf', (err) => {
        if(err) {
            res.send(Promise.reject());
        }

        res.send(Promise.resolve());
    });
});
//Delivery Report Of the lorry
reportRouter.post('/getdeliveryreportoflorry', (req, res) => {
    const {deliveries,startDate,endDate,lorry,deliTotal}=req.body;
    pdf.create(pdfTemplate.DeliveryRp.getDeliveryReportOfLorry(deliveries,startDate,endDate,lorry,deliTotal), options).toFile('result.pdf', (err) => {
        if(err) {
            res.send(Promise.reject());
        }

        res.send(Promise.resolve());
    });
});
//Daily Payment Report
reportRouter.post('/getDailyPaymentReport', (req, res) => {
    const {payments,startDate,endDate,payTotal}=req.body;
    pdf.create(pdfTemplate.PaymentRp.getPaymentReport(payments,startDate,endDate,payTotal),options).toFile('result.pdf', (err) => {
        if(err) {
            res.send(Promise.reject());
        }

        res.send(Promise.resolve());
    });
});
//Payment Report For Lorry
reportRouter.post('/getDailyPaymentReportOfLorry', (req, res) => {
    const {payments,payTotal,lorry,range}=req.body;
    pdf.create(pdfTemplate.PaymentRp.getPaymentReportOfLorry(payments,payTotal,lorry,range),options).toFile('result.pdf', (err) => {
        if(err) {
            res.send(Promise.reject());
        }

        res.send(Promise.resolve());
    });
});
//filterd reports
reportRouter.post('/getfilteredreportoflorry', (req, res) => {
    const {payments,range,lorry,payType,payTotal}=req.body;
    pdf.create(pdfTemplate.PaymentRp.getFiteredReport(payments,range,lorry,payType,payTotal),options).toFile('result.pdf', (err) => {
        if(err) {
            res.send(Promise.reject());
        }

        res.send(Promise.resolve());
    });
});
//Income Report
reportRouter.post('/getincomereport',(req,res) => {
    const {dayAdvance,maintain,deliveryFee,deliTotal,Diesel,delinums,lorry,range}=req.body;
    pdf.create(pdfTemplate.PaymentRp.getIncomeReport(dayAdvance,maintain,deliveryFee,deliTotal,Diesel,delinums,lorry,range),options).toFile('result.pdf', (err) => {
        if(err) {
            res.send(Promise.reject());
        }

        res.send(Promise.resolve());
    });
})
reportRouter.post('/getdieselreport',(req,res) => {
    const {diesel,range,payTotal,lorry}=req.body;
    pdf.create(pdfTemplate.PaymentRp.getDieselReport(diesel,range,payTotal,lorry),options).toFile('result.pdf', (err) => {
        if(err) {
            res.send(Promise.reject());
        }

        res.send(Promise.resolve());
    });
})

//get delivery Note
reportRouter.post('/getdeliverynote',(req,res) => {

    const {company,lorry,driver,unloadingPlace,capacity,distance,time}=req.body;
    pdf.create(pdfTemplate.DeliNote.getDeliveryNote(company,lorry,driver,unloadingPlace,capacity,distance,time),options).toFile('result.pdf', (err) => {
        if(err) {
            res.send(Promise.reject());
        }

        res.send(Promise.resolve());
    });
})
//get petty cash book
reportRouter.post('/getpettycashbookRp',(req,res) => {

    const {pettyCash,date}=req.body;
    pdf.create(pdfTemplate.DeliNote.getPettyCashBook(pettyCash,date),options).toFile('result.pdf', (err) => {
        if(err) {
            res.send(Promise.reject());
        }

        res.send(Promise.resolve());
    });
})
//get invoice
reportRouter.post('/getinvoiceRp',(req,res) => {

    const {invoice,company,range,deliTotal}=req.body;
    pdf.create(pdfTemplate.Invoice.getInvoice(invoice,company,range,deliTotal),options2).toFile('result.pdf', (err) => {
        if(err) {
            res.send(Promise.reject());
        }

        res.send(Promise.resolve());
    });
})
reportRouter.get('/fetch-pdf', (req, res) => {
    res.sendFile(`${__dirname}/result.pdf`)
})

//get cheques report

reportRouter.post('/getchequeRp',(req,res) => {

    const {range,cheques,total}=req.body;
    pdf.create(pdfTemplate.Cheque.chequeReport(range,cheques,total),options).toFile('result.pdf', (err) => {
        if(err) {
            res.send(Promise.reject());
        }

        res.send(Promise.resolve());
    });
})
reportRouter.get('/fetch-pdf', (req, res) => {
    res.sendFile(`${__dirname}/result.pdf`)
})

reportRouter.post('/getchequebycpmRp',(req,res) => {

    const {range,company,cheques,total}=req.body;
    pdf.create(pdfTemplate.Cheque.chequeReportByCmp(range,company,cheques,total),options).toFile('result.pdf', (err) => {
        if(err) {
            res.send(Promise.reject());
        }

        res.send(Promise.resolve());
    });
})
reportRouter.get('/fetch-pdf', (req, res) => {
    res.sendFile(`${__dirname}/result.pdf`)
})


module.exports=reportRouter

