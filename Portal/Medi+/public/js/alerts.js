// $(document).ready(function () {
//     var element = function (id) {
//         return document.getElementById(id);
//     }
//     var status = element('status');
//     var contains = element('medicinealert');

//     //set default status
//     var statusDefault = status.textCount;
//     var setStatus = function (s) {
//         //set staus
//         status.textContent = s;
//         if (s != statusDefault) {
//             var delay = setTimeout(function () {
//                 setStatus(statusDefault);
//             }, 4040);
//         }
//     };
//     //connect to socket.io
//     var socket = io.connect('http://localhost:4040');

//     //Check for Connection
//     if (socket != undefined) {
//         console.log('connected to socket');
//     }

//     // Handle Output
//     socket.on('output', function (data) {
//         console.log(data);
//         var contains = document.getElementById('medicinealert');
//         contains.innerHTML = '';
//         if (data.length) {
//             for (var x = 0; x < data.length; x++) {
//                 if(data[x].stock<180)
//                 {
//                     var head=document.createElement('h1');
//                     var para=document.createElement('p');

//                 head.setAttribute('class','lead');
//                 head.textContent="Medicine Name: "+ data[x].medicinename;
//                 para.textContent="Current Stock:"+ data[x].stock;
//                 contains.appendChild(head);
//                 contains.appendChild(para);
//                 }
//             }
//         }
//     });

//     // Get Status From server
//     socket.on('status', function (data) {
//         // Get Message status0
//         setStatus((typeof data === 'object') ? data.message : data);

//         // If status is clear, clear text
//         if (data.clear) {
//             textarea.value = '';
//         }
//     });
// });

// $(document).ready(function () {
//     var element = function (id) {
//         return document.getElementById(id);
//     }
//     var status = element('status');
//     var contains = element('ambulancealert');

//     //set default status
//     var statusDefault = status.textCount;
//     var setStatus = function (s) {
//         //set staus
//         status.textContent = s;
//         if (s != statusDefault) {
//             var delay = setTimeout(function () {
//                 setStatus(statusDefault);
//             }, 4060);
//         }
//     };
//     //connect to socket.io
//     var socket = io.connect('http://localhost:4060');

//     //Check for Connection
//     if (socket != undefined) {
//         console.log('connected to socket');
//     }

//     // Handle Output
//     socket.on('output', function (data) {
//         console.log(data);
//         var contains1 = document.getElementById('ambulancealert');
//         contains.innerHTML = '';
//         var minutesOfDay = function(m){
//             var timeArr = m.split(":");
//             if (timeArr.length == 2) {
//                 return (parseInt(timeArr[1]) + (parseInt(timeArr[0]) * 60));
//             }
//           }
//         var today = new Date();
//         var time = today.getHours() + today.getMinutes()*60;
//         console.log(time);
//         if (data.length) {
           
//             count=0;
//             for (var x = 0; x < data.length; x++) {
//                 if(time>minutesOfDay(data[x].time)&&minutesOfDay(data[x].time)>=time-30)
//                 {
//                  count++;
//                 var head=document.createElement('h1');
//                 var para=document.createElement('p');

//                 head.setAttribute('class','lead');
//                 head.textContent="Alert Number:"+count;
//                 para.textContent="Location:"+ data[x].location;
//                 contains1.appendChild(head);
//                 contains1.appendChild(para);
//              }
//             }
//         }
//     });

//     // Get Status From server
//     socket.on('status', function (data) {
//         // Get Message status0
//         setStatus((typeof data === 'object') ? data.message : data);

//         // If status is clear, clear text
//         if (data.clear) {
//             textarea.value = '';
//         }
//     });
// });

$(document).ready(function () {
    var element = function (id) {
        return document.getElementById(id);
    }
    var status = element('status');
    var contains2 = element('containerscroll');

    //set default status
    var statusDefault = status.textCount;
    var setStatus = function (s) {
        //set staus
        status.textContent = s;
        if (s != statusDefault) {
            var delay = setTimeout(function () {
                setStatus(statusDefault);
            }, 4080);
        }
    };
    //connect to socket.io
    var socket = io.connect('http://localhost:4080');

    //Check for Connection
    if (socket != undefined) {
        console.log('connected to socket');
    }

    // Handle Output
    socket.on('output', function (data) {
        console.log(data);
        var contains2 = document.getElementById('containerscroll');
        contains2.innerHTML = '';
        if (data.length) {
            for (var x = 0; x < data.length; x++) {

                    var divmain=document.createElement('div');
                    var mediatext=document.createElement('div');
                    var mediabody=document.createElement('div');
                    var heading3=document.createElement('h3');
                    var para3=document.createElement('p');
                    var para4=document.createElement('p');
                    var anchor1=document.createElement('a');
                    
                    
                    mediatext.setAttribute('class','media d-block media-custom text-center');
                    mediabody.setAttribute('class','media-body');
                    heading3.setAttribute('class','mt-0 text-black');
                    heading3.textContent=data[x].doctorname + '(' + data[x].doctorspeciality+')';
                    
                    para3.textContent=data[x].doctordescription;
                    para4.setAttribute('class','element-animate');
                    anchor1.setAttribute('class','btn btn-primary btn-lg');
                    anchor1.href="/appointments/"+data[x].idno;
                    anchor1.textContent="Look into Appointments";
                    
                    para4.appendChild(anchor1);
                    mediabody.appendChild(heading3);
                    mediabody.appendChild(para3);
                    mediabody.appendChild(para4);
                    
                    mediatext.appendChild(mediabody);
                    divmain.appendChild(mediatext);
                    
                    contains2.appendChild(divmain);
                    
            }
        }
    });

    // Get Status From server
    socket.on('status', function (data) {
        // Get Message status0
        setStatus((typeof data === 'object') ? data.message : data);

        // If status is clear, clear text
        if (data.clear) {
            textarea.value = '';
        }
    });
});


$(document).ready(function () {
    var element = function (id) {
        return document.getElementById(id);
    }
    var status = element('status');
    var contains3 = element('containerfeedback');

    //set default status
    var statusDefault = status.textCount;
    var setStatus = function (s) {
        //set staus
        status.textContent = s;
        if (s != statusDefault) {
            var delay = setTimeout(function () {
                setStatus(statusDefault);
            }, 4100);
        }
    };
    //connect to socket.io
    var socket = io.connect('http://localhost:4100');

    //Check for Connection
    if (socket != undefined) {
        console.log('connected to socket');
    }

    // Handle Output
    socket.on('output', function (data) {
        console.log(data);
        var contains3 = document.getElementById('containerfeedback');
        contains3.innerHTML = '';
        if (data.length) {
            for (var x = 0; x < data.length; x++) {

                divmain1 = document.createElement('div');
                divmediacustom = document.createElement('div');
                divmediabody1 = document.createElement('div');
                spanmetapost = document.createElement('span');
                heading4 = document.createElement('h3');
                para6 = document.createElement('p');

                divmediacustom.setAttribute('class', 'media d-block media-custom text-left');
                divmediabody1.setAttribute('class', 'media-body');
                spanmetapost.setAttribute('class', 'meta-post');
                heading4.setAttribute('class', 'mt-0 text-black');

                para6.textContent = data[x].comments;

                divmediabody1.appendChild(para6);

                divmediacustom.appendChild(divmediabody1);
                divmain1.appendChild(divmediacustom);

                contains3.appendChild(divmain1);
            }
        }
    });

    // Get Status From server
    socket.on('status', function (data) {
        // Get Message status0
        setStatus((typeof data === 'object') ? data.message : data);

        // If status is clear, clear text
        if (data.clear) {
            textarea.value = '';
        }
    });
});
