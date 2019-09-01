$(document).ready(function () {
    var element = function (id) {
        return document.getElementById(id);
    }
    var status = element('status');
    var contains = element('contains');

    //set default status
    var statusDefault = status.textCount;
    var setStatus = function (s) {
        //set staus
        status.textContent = s;
        if (s != statusDefault) {
            var delay = setTimeout(function () {
                setStatus(statusDefault);
            }, 10020);
        }
    };
    //connect to socket.io
    var socket = io.connect('http://localhost:4140');

    //Check for Connection
    if (socket != undefined) {
        console.log('connected to socket');
    }

    // Handle Output
    socket.on('output', function (data) {
        console.log(data);
        var contains = document.getElementById('contains');
        if (data.length) {
          
            for (var x = 0; x < data.length; x++) {
                if(x%3 == 0 || x==0)
                {
                    var divrow = document.createElement('div');
                }
                var divcolumn = document.createElement('div');
                var divcardgreen = document.createElement('div');
                var divadditional = document.createElement('div');
                var divusercard = document.createElement('div');
                var divusercardpoints = document.createElement('div');
                var divusercardpoints1 = document.createElement('div');
                var divmoreinfo = document.createElement('div');
                var moreinfoheading = document.createElement('h1');
                var divcoords = document.createElement('div');
                var coordsspan = document.createElement('span');
                var divgeneral = document.createElement('div');
                var generalheading = document.createElement('h1');
                var generalpara = document.createElement('p');
                var generalspan = document.createElement('span');

                divrow.setAttribute('class','row');
                divcolumn.setAttribute('class','column');
                divcardgreen.setAttribute('class','card green');
                divadditional.setAttribute('class','additional');
                divusercard.setAttribute('class','user-card');
                divusercardpoints.setAttribute('class','points center');
                divusercardpoints1.setAttribute('class','points1 center');
                divmoreinfo.setAttribute('class','more-info');
                // moreinfoheading.setAttribute('class','h1');
                divcoords.setAttribute('class','coords');

                divgeneral.setAttribute('class','general');
                // generalheading.setAttribute('class','h1');
                // generalpara.setAttribute('class','p');
                generalspan.setAttribute('class','more');

                divusercardpoints.textContent= data[x].day;
               
                coordsspan.textContent = data[x].medicines;

                generalheading.textContent= data[x].injectionname;
                generalpara.textContent = data[x].hospitalname;

                

                divusercard.appendChild(divusercardpoints);
                divusercard.appendChild(divusercardpoints1);
                
                divcoords.appendChild(coordsspan);
                divmoreinfo.appendChild(moreinfoheading);
                divmoreinfo.appendChild(divcoords);

                divadditional.appendChild(divusercard);
                divadditional.appendChild(divmoreinfo);

                divgeneral.appendChild(generalheading);
                divgeneral.appendChild(generalpara);
                divgeneral.appendChild(generalspan);
                divcardgreen.appendChild(divadditional);
                divcardgreen.appendChild(divgeneral);

                divcolumn.appendChild(divcardgreen);
                divrow.appendChild(divcolumn);

                if(x%3 ==0 )
                {
                contains.appendChild(divrow);
                }
                // if(x==0)
                // {
                //     var divrow1 = document.createElement('div');
                //     var divcol1 = document.createElement('div');
                //     var divhead = document.createElement('div');
                //     var head1 = document.createElement('h1');
                //     head1.textContent = data[x].doctorname + " Appointments";
                //     divhead.setAttribute('class', 'price-heading clearfix');
                //     divcol1.setAttribute('class', 'col-md-12');
                //     divrow1.setAttribute('class', 'row');
        
                //     divhead.appendChild(head1);
                //     divcol1.appendChild(divhead);
                //     divrow1.appendChild(divcol1);
                //     contains1.appendChild(divrow1);
        
                // }
                // if (x % 3 == 0) {
                //     var divrow = document.createElement('div');
                // }
                // var divcolumn = document.createElement('div');
                // var activediv = document.createElement('div');
                // var genericheadprice = document.createElement('div');
                // var genericheadcontent = document.createElement('div');
                // var head = document.createElement('div');
                // var headbg = document.createElement('div');
                // var spanc = document.createElement('span');
                // var genericlist = document.createElement('div');
                // var ul = document.createElement('ul');
                // var li1 = document.createElement('li');
                // var li2 = document.createElement('li');
                // var li3 = document.createElement('li');
                // var li4 = document.createElement('li');
                // var buttonhistory=document.createElement('a');
                // buttonhistory.setAttribute('class','buttonhistory');
                // var button1history=document.createElement('a');
                // button1history.setAttribute('class','buttonhistory');
                // divrow.setAttribute('class', 'row');
                // divcolumn.setAttribute('class', 'col-md-4');
                // activediv.setAttribute('class', 'generic_content active clearfix');
                // genericheadprice.setAttribute('class', 'generic_head_price clearfix');
                // genericheadcontent.setAttribute('class', 'generic_head_content clearfix');

                // headbg.setAttribute('class', 'head_bg');
                // head.setAttribute('class', 'head');

                // buttonhistory.textContent= "View test reports";
                // button1history.textContent="View doctor Prescription";

                // spanc.textContent = data[x].patientname;

                // genericlist.setAttribute('class', 'generic_feature_list');

                // li1.textContent = "Appointment Number:" + data[x].appointmentno;

                // li2.textContent = "Time slot:" + data[x].timeslot;

                // li3.textContent = data[x].problem;
                // li4.textContent = "Contact Number:" + data[x].contactno;

                // buttonhistory.href="/history/"+data[x].patientid;
                // button1history.href="/history/"+data[x].patientid;
                // ul.appendChild(li1);
                // ul.appendChild(li2);
                // ul.appendChild(li3);
                // ul.appendChild(li4);

                // genericlist.appendChild(ul);

                // head.textContent = data[x].patientname;
               
                // genericheadcontent.appendChild(headbg);
                // genericheadcontent.appendChild(head);
                // genericheadprice.appendChild(genericheadcontent);
                // activediv.appendChild(genericheadprice);
                // activediv.appendChild(genericlist);
                // activediv.appendChild(buttonhistory);
                // activediv.appendChild(button1history);
                
                // divcolumn.appendChild(activediv);
                // divrow.appendChild(divcolumn);
                // if (x % 3 == 0) {
                //     contains.appendChild(divrow);
                // }
    //         }
    //     }
    //     else{
    //         // var divrow1 = document.createElement('div');
    //         // var divcol1 = document.createElement('div');
    //         // var divhead = document.createElement('div');
    //         // var head1 = document.createElement('h1');
    //         // head1.textContent = "No Appointments to show";
    //         // divhead.setAttribute('class', 'price-heading clearfix');
    //         // divcol1.setAttribute('class', 'col-md-12');
    //         // divrow1.setAttribute('class', 'row');

    //         // divhead.appendChild(head1);
    //         // divcol1.appendChild(divhead);
    //         // divrow1.appendChild(divcol1);
    //         // contains1.appendChild(divrow1);
        }}
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
