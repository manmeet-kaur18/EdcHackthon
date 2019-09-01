const button = document.getElementById('savereport');
button.addEventListener('click', function(e) {
  console.log('button was clicked');
    let testreport = {
        patientname: document.getElementById('patientname').value,    
        doctorname: document.getElementById('doctorname').value,
        hospitalname: document.getElementById('hospitalname').value,
        reportname:document.getElementById('reportname').value,
        detail:document.getElementById('detail').value
    };
    if (checkEmptyString(testreport.patientname))
    {
        alert('User name is required');
        return;
    }
    if (checkEmptyString(testreport.doctorname))
    {
        alert('User Email is required');
        return;
    }
 
    $.ajax({
        type: "POST",
        url: "/savereport",
        dataType: "json",
        success: function (msg) {
            if (msg.length > 0) {
                location.href='/testreport';
            } else {
                alert("Invalid User !");
            }
        },
        data: testreport
    });
});

function checkEmptyString(val)
{
    return (val == undefined || val == null || val.trim().length == 0);
}
