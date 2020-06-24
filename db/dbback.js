var path = require("path");
Connection = require('./connect')
const cron = require('node-cron')
const cron1 = require('cron')
const moment = require('moment')
var fs = require('fs');
var spawn = require('child_process').spawn;

const mysqldump = require('mysqldump')

var nodeJsZip = require("nodeJs-zip");

var dir = path.join(__dirname,"../dbBackups");

// database is dumpded every day 4.30 pm
const job=cron1.job('00 11 * * *', () => {
    console.log("task running")
    fs.readdir(dir, (err, files) => {
        if (err) throw err;
      
        for (const file of files) {
          fs.unlink(path.join(dir, file), err => {
            if (err) throw err;
          });
        }
      });
      console.log("backing up");
      mysqldump({
        connection: {
            host: 'us-cdbr-east-05.cleardb.net',
            user: 'bb845d734a4f04',
            password: '71160976',
            database: 'heroku_c09fd48e58d7734',
        },
        dumpToFile: `dbBackups/SoilTransport${moment().format('YYYY_MM_DD')}.dump.sql`,
    });

})
    //Zipping database
    /*const job2= cron1.job('28 * * * *', () => {
        console.log("Zipping")
        nodeJsZip.zip([dir],{
            name : "dbbackup",
            dir : dir,
            filter : false
        });
    })*/
zipDir=()=>{
    zip = spawn('zip',['-P', '687687' , `${dir}/archive.zip`,'-r', dir]);
    zip .on('exit', function(code) {
        console.log("done");
    });
    return 1;
}

job.start();
//job2.start()

module.exports={

    zipDir
}