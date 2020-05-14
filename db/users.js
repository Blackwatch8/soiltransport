
Connection = require('./connect')
 all = async() =>{
    return new Promise((resolve, reject) => {
        Connection.query('select * from user',(err,results) => {
            if(err){
                return reject(err);
            }
            else{
            resolve(results);
            
            }
        });

    });
}
 findUser= async searchId  => {
    return new Promise((resolve,reject) => {
        Connection.query(`select * from user where email='${searchId}' AND Status='Active'`,(err,results) => {
            if(err){
                return reject(err);
            }
            else{
            resolve(results);
            
            }
        });
    });
}
addUser = async (first_name,last_name,email,password) => {
    return new Promise((resolve,reject) => {
        var tempDate = new Date();
        var created = tempDate.getFullYear() + '-' + (tempDate.getMonth()+1) + '-' + tempDate.getDate();
        Connection.query(`INSERT into user (first_name,last_name,email,password,created) VALUES
         ('${first_name}','${last_name}','${email}','${password}','${created}')`,(err,results) => {
            if(err){
                return reject(err)
            }
            else{
                
                return resolve('successfully aded')
            }
         })
    })
} 
deleteUser=async(id)=>{
    return new Promise((resolve,reject) => {
    Connection.query(`DELETE FROM user WHERE userID='${id}'`,(err,results)=>{
        if(err){
            reject(err);
        }
        else{
            resolve(results)
        }
    })
})
}
updateUser=async(email)=>{
    return new Promise((resolve,reject) => {
    Connection.query(`UPDATE user SET Status='Active' WHERE email='${email}'`,(err,results)=>{
        if(err){
            reject(err)
        }
        else{
            resolve(results)
        }
    })
})
}
updateUserRole=async(role,email)=>{
    return new Promise((resolve,reject) => {
    Connection.query(`UPDATE user SET role='${role}' WHERE email='${email}'`,(err,results)=>{
        if(err){
            reject(err)
        }
        else{
            resolve(results)
        }
    })
})
}

module.exports={
    all,
    findUser,
    addUser,
    deleteUser,
    updateUser,
    updateUserRole
}
