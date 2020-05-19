module.exports= ({
    mysql:{
        host:'us-cdbr-east-06.cleardb.net',
        user:'bcf5aad9fc6b4b',
        password:'6f0a84a4',
        database:'heroku_56236b0149670d1'
    },
    pool:{
        max:10,
        min:0,
        aquire:30000,
        idle: 10000
    }
})
/*module.exports= ({
    mysql:{
        host:'localhost',
        user:'root',
        password:'',
        database:'SoilTransportSystem'
    },
    pool:{
        max:10,
        min:0,
        aquire:30000,
        idle: 10000
    }
})*/