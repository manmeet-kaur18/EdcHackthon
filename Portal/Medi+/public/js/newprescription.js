const button = document.getElementById('savepres');
button.addEventListener('click', function(e) {
  console.log('button was clicked');
    let presreport = {
        patientname: document.getElementById('patientname').value,    
        doctorname: document.getElementById('doctorname').value,
        hospitalname: document.getElementById('hospitalname').value,
        medicine:document.getElementById('medcine').value
    };
    if (checkEmptyString(presreport.patientname))
    {
        alert('User name is required');
        return;
    }
    if (checkEmptyString(presreport.doctorname))
    {
        alert('User Email is required');
        return;
    }
 
    $.ajax({
        type: "POST",
        url: "/doctorprescription",
        dataType: "json",
        success: function (msg) {
            if (msg.length > 0) {
                location.href='/options';
            } else {
                alert("Invalid User !");
            }
        },
        data: presreport
    });
});

function checkEmptyString(val)
{
    return (val == undefined || val == null || val.trim().length == 0);
}
