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
Connection = require('./connect');
let options = {shell: true};
// database is dumpded every hour
const job=cron1.job('57 * * * *', () => {
        Connection.query(`SELECT userId from user LIMIT 1 `,(err,results) => {
              if(err){
                  console.log("Database connection error")
              }
              else if(results.length>0){
                console.log("backing up");
                mysqldump({
                  connection: {
                    host            : 'localhost',
                    user            : 'ish',
                    password        : 'myhiru',
                    database        : 'SoilTransportSystem'
                  },
                  dumpToFile: `dbBackups/SoilTransport.dump.sql`,
              });
              }
          })
})
    //Zipping database
    const job2= cron1.job('6 * * * *', () => {
        console.log("Zipping")
    try{
        zip = spawn('zip',['-P', 'reliablesoils2020' , `${dir}/archive.zip`,'-r', dir],options);
        zip .on('exit', function(code) {
            console.log("done");
            done=true;
        });
        
    }catch(err){
    console.log(err);
    }
});

/*zipDir=()=>{
    var done=false;
    try{
        zip = spawn('zip',['-P', 'reliablesoils2020' , `${dir}/archive.zip`,'-r', dir],options);
        zip .on('exit', function(code) {
            console.log("done");
            done=true;
        });
        
}catch(err){
    console.log(err);
}
return done;
}*/

job.start();
job2.start()

module.exports={

}
