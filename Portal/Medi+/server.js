console.log('Server-side code running');

const express = require('express');
const MongoClient = require('mongodb').MongoClient;
const app = express();
const client = require('socket.io').listen(4000).sockets;
const clientappoint = require('socket.io').listen(4020).sockets;
const clientmedalert = require('socket.io').listen(4040).sockets;

const clientdetail = require('socket.io').listen(4080).sockets;
const clientfeedback = require('socket.io').listen(4100).sockets;
const clientpatientpres = require('socket.io').listen(4140).sockets;

var nodemailer = require('nodemailer');
// serve files from the public directory
app.use(express.static('public'));

var bodyParser = require('body-parser');
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

var hospitalnamemain;
// connect to the db and start the express server
let db;
// var username;

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
    app.listen(8080, () => {
        console.log('listening on 8080');
    });
});
// Clent for the medicines page starts up

var idnumber;

var childidnumber;
client.on('connection', function (socket) {
    console.log('Client Socket connected');

    let vaccines = db.collection('injectionstock');

    // create function to send status//whenever we want to side something from servere side to client side we use emit to do so to show it in html file
    sendStatus = function (s) {
        socket.emit('status', s);
    };

    db.collection('vaccines', function (err, collection) {
        if (err) return console.log('error opening users collection, err = ', err);

        //get chats from mongo collection
        // limit(100).sort({ _id: 1, hospitalname: 1, medicinename: 1 ,docotorname:username}).
        vaccines.find({hospitalname:hospitalnamemain}).toArray(function (err, res) {
            if (err) {
                throw errs;
            }
            // emit the messages
            socket.emit('output', res);
            console.log(res);
        });
    });
});

// client of medicine ends here 

//client for the doctors begins
clientappoint.on('connection', function (socket) {
    console.log('Client Socket connected');

    let doctorsapp = db.collection('appointmentdetailes');

    // create function to send status//whenever we want to side something from servere side to client side we use emit to do so to show it in html file
    sendStatus = function (s) {
        socket.emit('status', s);
    };

    doctorsapp.find({ idno: idnumber }).limit(100).sort({ _id: 1, appointmentno: 1, timeslot: 1 }).toArray(function (err, res) {
        if (err) {
            throw err;
        }
        // emit the messages
        console.log(res);
        socket.emit('output', res);

    });
});

//client for the doctors ends

//medicine alert client starts

clientmedalert.on('connection', function (socket) {
    console.log('Client Socket connected');

    let vaccines = db.collection('injectionstock');

    // create function to send status//whenever we want to side something from servere side to client side we use emit to do so to show it in html file
    sendStatus = function (s) {
        socket.emit('status', s);
    };

    vaccines.find({hospitalname:hospitalnamemain}).limit(100).sort({ _id: 1, medicinename: 1, stock: 1 }).toArray(function (err, res) {
        if (err) {
            throw err;
        }
        // emit the messages
        console.log(res);
        socket.emit('output', res);

    });
});


//medicine alert ends here

// //ambulance alert client begins here

// clientambalert.on('connection', function (socket) {
//     console.log('Client Socket connected');

//     let alertambulance = db.collection('alertambulance');

//     // create function to send status//whenever we want to side something from servere side to client side we use emit to do so to show it in html file
//     sendStatus = function (s) {
//         socket.emit('status', s);
//     };

//     alertambulance.find({hospitalname:hospitalnamemain}).limit(100).sort({ _id: 1, location: 1, time: 1 }).toArray(function (err, res) {
//         if (err) {
//             throw err;
//         }
//         // emit the messages
//         console.log(res);
//         socket.emit('output', res);

//     });
// });

// //ambulance alert client ends here

//doctors details client starts
clientdetail.on('connection', function (socket) {
    console.log('Client Socket connected');

    let doctorsdes = db.collection('doctordes');

    // create function to send status//whenever we want to side something from servere side to client side we use emit to do so to show it in html file
    sendStatus = function (s) {
        socket.emit('status', s);
    };

    doctorsdes.find({hospitalname:hospitalnamemain}).limit(100).sort({ _id: 1, doctorname: 1 }).toArray(function (err, res) {
        if (err) {
            throw err;
        }
        // emit the messages
        console.log(res);
        socket.emit('output', res);

    });
});
//doctors details client ends here

//feedback client starts here
clientfeedback.on('connection', function (socket) {
    console.log('Client Socket connected');

    let feedback = db.collection('feedbacks');

    // create function to send status//whenever we want to side something from servere side to client side we use emit to do so to show it in html file
    sendStatus = function (s) {
        socket.emit('status', s);
    };

    feedback.find({hospitalname:hospitalnamemain}).limit(100).sort({ _id: 1, feedback: 1 }).toArray(function (err, res) {
        if (err) {
            throw err;
        }
        // emit the messages

        socket.emit('output', res);

    });
});

clientpatientpres.on('connection', function (socket) {
    console.log('Client Socket connected');

    let patientdoc = db.collection('injectionupdates');

    // create function to send status//whenever we want to side something from servere side to client side we use emit to do so to show it in html file
    sendStatus = function (s) {
        socket.emit('status', s);
    };

    patientdoc.find({ childid: childidnumber }).limit(100).sort({ _id: 1,injectionname: 1 }).toArray(function (err, res) {
        if (err) {
            throw err;
        }
        // emit the messages
        console.log(res);
        socket.emit('output', res);

    });
});


//feedback client ends here

// serve the homepage
app.get('/main', (req, res) => {
    res.sendFile(__dirname + '/index.html');
});

app.get('/appointments/:id', (req, res) => {
    idnumber = req.params.id;
    res.sendFile(__dirname + '/appointments.html');
});

app.get('/appointments', (req, res) => {
    //idnumber=req.params.id; 
    res.sendFile(__dirname + '/appointments.html');
});

app.get('/medicines', (req, res) => {
    res.sendFile(__dirname + '/medicine.html');
});

app.get('/bloodbank', (req, res) => {
    res.sendFile(__dirname + '/bloodbank.html');
});

app.get('/options', (req, res) => {
    res.sendFile(__dirname + '/services.html');
});

app.get('/infodeliver', (req, res) => {
    res.sendFile(__dirname + '/infodeliver.html');
});

app.get('/bloodbank', (req, res) => {
    res.sendFile(__dirname + '/bloodbank.html');
});

app.get('/', (req, res) => {
    res.sendFile(__dirname + '/login.html');
});

app.get('/adddoctor', (req, res) => {
    res.sendFile(__dirname + '/newdoctors.html');
});

app.get('/updatevaccinedetail', (req, res) => {
    res.sendFile(__dirname + '/updatevaccinedetail.html');
});

app.get('/patientprescriptions/:id', (req, res) => {
    childidnumber=req.params.id; 
    res.sendFile(__dirname + '/doctorprespersonal.html');
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
//message to be delivered begins here
app.post('/deliver', (req, res) => {
    console.log(req.body);
    var message = req.body;

    db.collection('appointmentdetailes').find(
        {
            hospitalname:hospitalnamemain,
            doctorname: message.doctorname,
            timeslot: message.timeslot
        }).toArray((err, result) => {
            if (err) {
                res.send(err);
            }
            else {
                result.forEach(element => {

                    let HelperOptions = {
                        from: 'GBM918211@gmail.com',
                        to: element.patientemail,
                        subject: "hello!",
                        text: 'wow',

                    };
                    transporter.sendMail(HelperOptions, (error, info) => {
                        if (error) {
                            console.log(error);
                        }
                        else {
                            console.log("message sent");
                        }
                    });

                    res.send([{
                        message: 'Request successfully logged',
                        status: true
                    }]);
                });

            }
        });
});

// add a document to the DB collection recording the click event
app.post('/savedetail', (req, res) => {
    console.log(req.body);
    var doctorsdes = req.body;
    // var hospitalname = "AIMS"
    var lastIdNumber;
    db.collection('doctordes').find({hospitalname:hospitalnamemain}).sort({ idno: -1, doctorname: -1 }).limit(1).toArray((err, result) => {
        if (err) {
            res.send(err);
        }
        count = parseInt(result[0].idno) + 1;
        lastIdNumber = count.toString();

        var saveDoctor = {
            hospitalname: hospitalnamemain,
            doctorname: doctorsdes.doctorname,
            doctorspeciality: doctorsdes.doctorspeciality,
            idno: lastIdNumber,
            doctordescription: doctorsdes.doctordescription
        };

        db.collection('doctordes').save(saveDoctor, (err, result) => {
            if (err) {
                return console.log(err);
            }
            console.log('click added to db');
            res.send([{
                message: 'Request successfully logged',
                status: true
            }]);
        });
    });

});




// add a document to the DB collection recording the click event
app.post('/savefeedback', (req, res) => {
    console.log(req.body);
    var feedbacks1 = req.body;
    var feedbacks={
        comments:feedbacks1.comments,
        hospitalname:hospitalnamemain
    }

        db.collection('feedbacks').save(feedbacks, (err, result) => {
            if (err) {
                return console.log(err);
            }
            console.log('click added to db');
            res.send([{
                message: 'Request successfully logged',
                status: true
            }]);
        });
});


// // add a document to the DB collection recording the click event
// app.post('/testreport', (req, res) => {
//     console.log(req.body);
//     var reportdetail = req.body;
//     // var hospitalname = "AIMS"
//     // var lastIdNumber;
//     db.collection('Patientdetailes').find({patientname:reportdetail.patientname}).sort({ patientname : 1 }).limit(1).toArray((err, result) => {
//         if (err) {
//             res.send(err);
//         }
       
//         var patientIdNumber = result[0].patientid;
//         var today = new Date();
//         var datetoday = today.getDate()+'-'+(today.getMonth()+1)+'-'+today.getFullYear();
//         var savereport = {
//             hospitalname: hospitalnamemain,
//             doctorname: reportdetail.doctorname,
//             medicine: reportdetail.detail,
//             idno: patientIdNumber,
//             reportname: reportdetail.reportname,
//             date:datetoday
//         };

//         db.collection('reportdetailes').save(savereport, (err, result) => {
//             if (err) {
//                 return console.log(err);
//             }
//             console.log('click added to db');
//             res.send([{
//                 message: 'Request successfully logged',
//                 status: true
//             }]);
//         });
//     });

// });
// add a document to the DB collection recording the click event
app.post('/doctorprescription', (req, res) => {
    console.log(req.body);
    var presdetail = req.body;
    // var hospitalname = "AIMS"
    // var lastIdNumber;
    db.collection('childrenname').find({childname:presdetail.patientname}).sort({ childname : 1 }).limit(1).toArray((err, result) => {
        if (err) {
            res.send(err);
        }
       
        var patientIdNumber = result[0].childid;
        var today1 = new Date();
        var datetoday1 = today1.getDate()+'-'+(today1.getMonth()+1)+'-'+today1.getFullYear();
        var savepres = {
            hospitalname: hospitalnamemain,
            childid:patientIdNumber,
            injectionname: presdetail.medicine,
            idno: patientIdNumber,
            day:datetoday1
        };

        db.collection('injectionupdate').save(savepres, (err, result) => {
            if (err) {
                return console.log(err);
            }
            console.log('click added to db');
            res.send([{
                message: 'Request successfully logged',
                status: true
            }]);
        });
    });

});
var patientIdNumber;
app.post('/updateinjection', (req, res) => {
    console.log(req.body);
    var injection = req.body;
    // var hospitalname = "AIMS"
    // var lastIdNumber;
    db.collection('childrenname').find({childname:injection.childname}).sort({ childname : 1 }).limit(1).toArray((err, result) => {
        if (err) {
            res.send(err);
        }
        if(result.length>0){
            patientIdNumber=result[0].childid;
        }
        var today1 = new Date();
        var datetoday1 = today1.getDate()+'-'+(today1.getMonth()+1)+'-'+today1.getFullYear();
        var savepres = {
            childname:injection.childname,
            hospitalname: hospitalnamemain,
            childid:patientIdNumber,
            injectionname: injection.injectionname,
            day:datetoday1
        };

        db.collection('injectionupdates').save(savepres, (err, result1) => {
            if (err) {
                return console.log(err);
            }
            
            console.log('click added to db');
            res.send([{
                message: 'Request successfully logged',
                status: true
            }]);
         });
         db.collection('injectionstock').find({injection:injection.injectionname,hospitalname:hospitalnamemain}).sort({ childname : 1 }).limit(1).toArray((err, result) => {
            if (err) {
                res.send(err);
            }
            if(result.length>0){
                result[0].stock=(parseInt(result[0].stock)-1).toString();
            }
        });
    });

});



app.get('/getinjectionliststock', (req, res) => {
    var arr = [];
    
db.collection('injectionname').find({}).toArray()
        .then(function (result) {
            var promisesAll = [];
            result.forEach(element => {
                promisesAll.push(new Promise(resolve => {
                    db.collection('injectionupdates').find({ hospitalname: hospitalnamemain, injectionname: element.injectionname }).count()
                        .then(function (result1) {
                            arr.push(result1);
                            resolve();
                        });
                }));
            });
            Promise.all(promisesAll)
                .then(function () {
                    res.send(arr);
                })
                .catch(console.error);
        })
        .catch(function (error) {
            console.log(error);
        });
});



app.post('/login', (req, res) => {
    console.log(req.body);
    var hospitaladmin = req.body;
  hospitalnamemain=hospitaladmin.hospitalname;
    db.collection('hospitalname').find(
        {
          hospitalname: hospitaladmin.hospitalname,
          password: hospitaladmin.password,
        }).toArray((err, result) => {
      if (err)
      { 
        res.send(err);
      }
      else
      {
        res.send([{
            message: 'Request successfully logged',
            status: true
          }]);
      }
    });
  });