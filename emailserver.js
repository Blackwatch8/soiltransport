const express = require('express'),
   nodeMailer = require('nodemailer'),
   bodyParser = require('body-parser');
   const cors = require('cors');

    const mail = express();
    mail.set('view engine', 'ejs');
    mail.use(cors());
    mail.use(bodyParser.urlencoded({extended: true}));
    mail.use(bodyParser.json());

    mail.post('/send-email', function (req, res) {
        console.log(req.body)
      let transporter = nodeMailer.createTransport({
          host: 'smtp.gmail.com',
          port: 465,
          secure: true,
          auth: {
              user: 'soiltransport2020@gmail.com',
              pass: 'reliablesoils'
          }
      });
      let mailOptions = {
          from: '"soiltransport2020" <soiltransport2020@gmail.com>', // sender address
          to: 'ishanhherath12@gmail.com', // list of receivers
          subject: req.body.subject, // Subject line
          text: `A message from ${req.body.userName}`, // plain text body
          html: `<b>Email : ${req.body.email}</b> <br>
                <b>Contact: ${req.body.contact}</b><br>
                <b>Name : ${req.body.userName}</b><br>
                <b>Message : ${req.body.message}</b>
            `
           // html body
      };

      transporter.sendMail(mailOptions, (error, info) => {
          if (error) {
              return console.log(error);
          }
          console.log('Message %s sent: %s', info.messageId, info.response);
          let token =  {
            status: 'Sent'
          }
          res.json(token)
          });
      });

module.exports=mail