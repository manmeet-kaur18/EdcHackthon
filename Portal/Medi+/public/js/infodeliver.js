const button = document.getElementById('message1');
button.addEventListener('click', function(e) {
  console.log('button was clicked');
  var f = document.getElementById('timeslot');
    let message = {
        doctorName: document.getElementById('fname').value,
        messagedeliver: document.getElementById('message').value,
        timeslot: f.options[f.selectedIndex].value
    };

    if (checkEmptyString(message.messagedeliver))
    {
        alert('Message is required');
        return;
    }
   

    $.ajax({
        type: "POST",
        url: "/deliver",
        dataType: "json",
        success: function (msg) {
            if (msg.length > 0) {
                location.href='/';
            } else {
                alert("Invalid User !");
            }
        },
        data: message
    });
});

function checkEmptyString(val)
{
    return (val == undefined || val == null || val.trim().length == 0);
}
