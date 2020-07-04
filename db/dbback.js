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

// database is dumpded every hour
const job=cron1.job('5 * * * *', () => {
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
            host            : 'us-cdbr-east-05.cleardb.net',
            user            : 'bd34339b6e64dd',
            password        : 'fe97918e',
            database        : 'heroku_1741df78b945ba2'
        },
        dumpToFile: `dbBackups/SoilTransport.dump.sql`,
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
    zip = spawn('zip',['-P', 'reliablesoils2020' , `${dir}/archive.zip`,'-r', dir]);
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
