const express = require('express');
const bodyParser = require('body-parser');
const cron = require("node-cron");
const app = express();
const MongoClient = require('mongodb').MongoClient;
var calculateFullAge = require('full-age-calculator');

const getAge = require("findage");

//app.use(bodyParser.json());
//app.use(bodyParser.urlencoded({ extended: true }));

const NEXMO_API_KEY = process.env.NEXMO_API_KEY
const NEXMO_API_SECRET = process.env.NEXMO_API_SECRET
const TO_NUMBER = process.env.NEXMO_TO_NUMBER
const FROM_NUMBER = process.env.NEXMO_FROM_NUMBER

const Nexmo = require('nexmo')

const nexmo = new Nexmo({
    apiKey: '200df79f',
    apiSecret: '4VQDMlBBJcjDEcoG'
});

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

    
var today = new Date();
    var date = today.getFullYear() + '-' + (today.getMonth() + 1) + '-' + today.getDate();
    var time = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
    var dateTime = date + ' ' + time;
    console.log(dateTime);

    // Per 10 seconds
    //cron.schedule("*/10 * * * * *", function () {

    // Per Minutes
    cron.schedule("*/1 * * * *", function () {

        db.collection('childrenname').find({}).toArray((err, result) => {
            if (err) {
                res.send(err);
            }
            else {
                result.forEach(element => {
                    console.log("---------------------");
                    console.log("Running Cron Job");
                    today = new Date();
                    date = today.getFullYear() + '-' + (today.getMonth() + 1) + '-' + today.getDate();
                    time = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
                    dateTime = date + ' ' + time;
                    console.log(dateTime);
                    var getfullAge = calculateFullAge.getFullAge(element.birthdate); // In yyyy-mm-dd format. example: 1998-12-25
                    db.collection('injectionname').find({}).toArray((err, result1) => {
                        if (err) {
                            res.send(err);
                        }
                        else {
                            result1.forEach(element1 => {
                                var count1 = 0;
                                var months = ((getfullAge.years * 12) + getfullAge.months);
                                if (months >= element1.start && months <= element1.end) {
                                    count1 = parseInt(element1.count);
                                    var count2 = 0;
                                    db.collection('injectionupdates').find({ injectionname: element1.injectionname, childid: element.childid }).toArray((err, result2) => {
                                        if (err) {
                                            res.send(err);
                                        }
                                        else {
                                            count2 = result2.length;
                                            if (count1 != count2) {
                                                var from = 919891397798; // Only this number in from
                                                var to = parseInt(element.phoneno); // Only this number in TO

                                                // Change below text with your message
                                                var text = "The child is eligible for " + "(" + element1.injectionname + ")" + " vaccination . Kindly vist the nearest clinic or hospital and get it done as soon as possible.";

                                                nexmo.message.sendSms(from, to, text, (err, responseData) => {
                                                    if (err) {
                                                        console.log(err);
                                                    } else {
                                                        if (responseData.messages[0]['status'] === "0") {
                                                            console.log("Message sent successfully.");
                                                        } else {
                                                            console.log(`Message failed with error: ${responseData.messages[0]['error-text']}`);
                                                        }
                                                    }
                                                });
                                                console.log("running a task every minute");
                                            }
                                        }
                                    });

                                    return element;
                                }
                            })

                        }
                    });
                })
            }  // Put your code here to read data from database
        })
    });
});