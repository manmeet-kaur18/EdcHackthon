
$("#Search").click(function () {
    submitRequest();
    return false;
});
function submitRequest()  {
    var element = function (id) {
        return document.getElementById(id);
    }
    var status = element('status');
    var contains = element('contains');
    var medicinename=element('medicine');
   


    //set default status
    var statusDefault = status.textCount;
    var setStatus = function (s) {
        //set staus
        status.textContent = s;
        if (s != statusDefault) {
            var delay = setTimeout(function () {
                setStatus(statusDefault);
            }, 4000);
        }
    };
    //connect to socket.io
    var socket = io.connect('http://localhost:4000');

    //Check for Connection
    if (socket != undefined) {
        console.log('connected to socket');
    }

    // Handle Output
    socket.on('output', function (data) {
        console.log(data);
        var contains = document.getElementById('contains');
        contains.innerHTML = '';
        if (data.length) {
           
            for (var x = 0; x < data.length; x++) {
                if(data[x].injectionname==medicinename.value)
                {
                var card = document.createElement('div');
                card.setAttribute('class', 'card');
                var face=document.createElement('div');
                face.setAttribute('class','face');
                var face1 = document.createElement('div');
                var face2 = document.createElement('div');
                var address = document.createElement('p');
                var addressh = document.createElement('h2');
                var status = document.createElement('h3');
                face1.setAttribute('class', 'face face1');
                addressh.textContent = "Current stock";
              
             
                status.textContent = data[x].injectionname;
                address.textContent = data[x].stock;
                if (data[x].stock <18) {
                    face2.setAttribute('class', 'face face21');
                }
                else if(data[x].stock<=30&& data[x].stock>=18){
                    face2.setAttribute('class', 'face face23');
                }
                else{
                    face2.setAttribute('class','face face22');
                }

                face1.appendChild(addressh);
                face1.appendChild(address);
                face2.appendChild(status);
                face.appendChild(face1);
                face.appendChild(face2);
                card.appendChild(face);
                contains.appendChild(card);

            }
            // messages.insertBefore(message,
            //     messages.firstChild);
        }// messages.insertBefore(message1,
            //         messages.firstChild);
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
}
