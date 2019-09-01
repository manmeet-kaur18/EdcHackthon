const button = document.getElementById('savedetails');
button.addEventListener('click', function(e) {
  console.log('button was clicked');
    let doctorsdes = {
        doctorname: document.getElementById('fname').value,
        doctorspeciality: document.getElementById('doctorspeciality').value,
        doctordescription: document.getElementById('doctordes').value
    };
    if (checkEmptyString(doctorsdes.doctorname))
    {
        alert('User name is required');
        return;
    }
    if (checkEmptyString(doctorsdes.doctorspeciality))
    {
        alert('User Email is required');
        return;
    }
    if (checkEmptyString(doctorsdes.doctordescription))
    {
        alert('User Password is required');
        return;
    }

    $.ajax({
        type: "POST",
        url: "/savedetail",
        dataType: "json",
        success: function (msg) {
            if (msg.length > 0) {
                location.href='/';
            } else {
                alert("Invalid User !");
            }
        },
        data: doctorsdes
    });
});

function checkEmptyString(val)
{
    return (val == undefined || val == null || val.trim().length == 0);
}
