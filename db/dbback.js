var path = require("path");
Connection = require('./connect')
const cron = require('node-cron')
const moment = require('moment')
var fs = require('fs');
var spawn = require('child_process').spawn;

var nodeJsZip = require("nodeJs-zip");

var dir = path.join(__dirname,"../dbBackups");

// database is dumpded every day 4.30 pm
cron.schedule('30 16 * * *', dumpDb=() => {
    fs.readdir(dir, (err, files) => {
        if (err) throw err;
      
        for (const file of files) {
          fs.unlink(path.join(dir, file), err => {
            if (err) throw err;
          });
        }
      });
    var wstream = fs.createWriteStream(`dbBackups/SoilTransport${moment().format('YYYY_MM_DD')}.dump.sql`);
    console.log("backing up")
    var mysqldump = spawn('mysqldump', [
        '-u',
        'bb845d734a4f04',
        '-p71160976',
        '-h',
        'us-cdbr-east-05.cleardb.net',
        'heroku_c09fd48e58d7734',
    ]);


mysqldump
    .stdout
    .pipe(wstream)
    .on('finish', function () {
        console.log('Completed');
        
    })
    .on('error', function (err) {
        console.log(err)
    });

})
    //Zipping database
    cron.schedule('32 16 * * *', dumpDb=() => {
        console.log("Zipping")
        nodeJsZip.zip([dir],{
            name : "dbbackup",
            dir : dir,
            filter : false
        });
    })
zipDir=()=>{
    zip = spawn('zip',['-P', '687687' , `${dir}/archive.zip`,'-r', dir]);
    zip .on('exit', function(code) {
        console.log("done");
    });
}
module.exports={
    dumpDb,
    zipDir
}