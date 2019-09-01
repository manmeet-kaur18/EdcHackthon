console.log('Server-side code running');


const express = require('express');
const MongoClient = require('mongodb').MongoClient;
var async = require("async");

const app = express();
var nodemailer = require('nodemailer');
var distance = require('google-distance');
distance.apiKey = 'AIzaSyBl_MwSYokMdYuIQq6PPAoVgJFMdelLF0k';
var calculateFullAge = require('full-age-calculator');
 
// serve files from the public directory
app.use(express.static('public'));

var bodyParser = require('body-parser');
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// connect to the db and start the express server
let db;
// var username;mongodb://<dbuser>:<dbpassword>@

// ***Replace the URL below with the URL for your database***
const url = 'mongodb://ThaparUser:Pass#123@ds253713.mlab.com:53713/teekaproject';
// E.g. for option 2) above this will be:
// const url =  'mongodb://localhost:21017/databaseName';

MongoClient.connect(url, (err, database) => {
    if (err) {
        return console.log(err);
    }
    db = database;
    // start the express web server listening on 8080
    app.listen((process.env.PORT||8080), () => {
        console.log('listening on deployed server');
    });
});


app.get('/gethospitals', (req, res) => {
    db.collection('injectionstock').find({}).toArray((err, result) => {
        if (err) {
            res.send(err);
        }
        else {
            res.send(result);
        }
    })
});


app.get('/children', (req, res) => {
    db.collection('childrenname').find({}).toArray((err, result) => {
        if (err) {
            res.send(err);
        }
        else {
            res.send(result);
        }
    })
});
app.get('/getupdates', (req, res) => {
    db.collection('injectionupdates').find({}).toArray((err, result) => {
        if (err) {
            res.send(err);
        }
        else {
            res.send(result);
        }
    })
});

var childid;

app.post('/sendclientid', (req, res) => {
    clientiddetail=req.body;
    childid = clientiddetail.clientid;
});


app.get('/getrecents',(req,res)=>{
    db.collection('childrenname').find({childid:childid}).toArray((err, result) => {
        if (err) {
            res.send(err);
        }
        else {
            console.log(result);
        // var getfullAge = calculateFullAge.getAge(result[0].birthdate); 
        var getfullAge = calculateFullAge.getFullAge(result[0].birthdate);// In yyyy-mm-dd format. example: 1998-12-25
        console.log(getfullAge);
        db.collection('injectionname').find({}).toArray((err, result) => {
            if (err) {
                res.send(err);
            }
            else {
                result.forEach(element => {
                    var count1=0;
                    var months=getfullAge.years*12+getfullAge.months;
                    if(months>element.start && months<element.end)
                    {
                        count1= element.count;
                        var count2=0;
                        db.collection('injectionupdates').find({injectionname:element.injectionname,childid:childid}).toArray((err, result1) => {
                            if (err) {
                                res.send(err);
                            }
                            else {
                                count2=result1.length;

                            }
                        })
                        if(count1!=count2)
                        {
                            res.send(element);
                        }
                    }    
                });
            }
        })
        }
    })
    
})



app.get('/getinjectionlist', (req, res) => {
    db.collection('injectionname').find({}).toArray((err, result) => {
        if (err) {
            res.send(err);
        }
        else {
            res.send(result);
        }
    })
});


app.get('/getaefi', (req, res) => {
    db.collection('aefi').find({}).toArray((err, result) => {
        if (err) {
            res.send(err);
        }
        else {
            res.send(result);
        }
    })
});


app.get('/doctorsearch', (req, res) => {
    db.collection('doctordes').find({}).toArray((err, result) => {
        if (err) {
            res.send(err);
        }
        else {
            res.send(result);
        }
    })
});

let transporter = nodemailer.createTransport({
    service: 'gmail',
    secure: false,
    port: 25,
    auth: {
        user: 'GBM918211@gmail.com',
        pass: 'Pass#123!'
    },
    tls: {
        rejectUnauthorized: true
    }
});
app.post('/registerchild', (req, res) => {
    console.log(req.body);
    var child = req.body;
 
    db.collection('childrenname').find().sort({childname:-1,parentname:-1}).limit(-1).toArray((err, result) => {
        if (err) {
            res.send(err);
        }
        var childid = 0;
        var password=0; 

        if (result.length > 0) {
            childid = parseInt(result[0].childid) + 1;
            password= parseInt(result[0].password) + 1;
        }

        lastchildid = childid.toString();
        lastpassword = password.toString();
        var savechild = {
            childname: child.childname,
            childid:childid,
            parentname: child.parentname,
            birthdate: child.birthdate,
            age:child.age,
            password:lastpassword,
            phoneno: child.phoneno,
            emailid: child.emailid,
        };

        db.collection('childrenname').save(savechild, (err, result) => {
            if (err) {
                return console.log(err);
            }
            console.log('click added to db');

            let HelperOptions = {
                from: 'GBM918211@gmail.com',
                to: savechild.emailid,
                subject: "Details about your child health app",
                text: "Your password is: " + savechild.password,

            };
            transporter.sendMail(HelperOptions, (error, info) => {
                if (error) {
                    console.log(error);
                }
                else {
                    console.log("message sent");
                }
            });

            res.sendStatus(201);
        });
    });
});



app.post('/placeappointment', (req, res) => {
    console.log(req.body);
    var appointment = req.body;

    var lastappointmentnumber;

    var doctorappointmentDB = db.collection('appointmentdetailes');

    doctorappointmentDB.find().sort({ idno: -1, doctorname: -1, appointmentno: -1 }).limit(1).toArray((err, result) => {
        if (err) {
            res.send(err);
        }
        var count = 1;

        if (result.length > 0) {
            count = parseInt(result[0].appointmentno) + 1;
        }

        lastappointmentnumber = count.toString();

        var saveappointment = {
            doctorname: appointment.doctorname,
            idno: appointment.idno,
            childname: appointment.childname,
            appointmentno: lastappointmentnumber,
            timeslot: appointment.timeslot,
            contactno: appointment.contactno,
            patientemail: appointment.patientemail,
        };

        doctorappointmentDB.save(saveappointment, (err, result) => {
            if (err) {
                return console.log(err);
            }
            console.log('click added to db');

            let HelperOptions = {
                from: 'GBM918211@gmail.com',
                to: saveappointment.patientemail,
                subject: "Details anout your appointment",
                text: "Your appointment number for the timeslot " + saveappointment.timeslot + " is " + saveappointment.appointmentno + ". For further updates please check your email incase of any cancelation of appointment",

            };
            transporter.sendMail(HelperOptions, (error, info) => {
                if (error) {
                    console.log(error);
                }
                else {
                    console.log("message sent");
                }
            });

            res.sendStatus(201);
        });
    });
});
