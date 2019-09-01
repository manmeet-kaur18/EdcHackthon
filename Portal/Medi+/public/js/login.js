const button = document.getElementById('login');
button.addEventListener('click', function(e) {
  console.log('button was clicked');
    let hospitaladmin = {
        hospitalname: document.getElementById('hospitalname').value,
        password: document.getElementById('password').value
    };
    if (checkEmptyString(hospitaladmin.hospitalname))
    {
        alert('Hospital name is required');
        return;
    }
    if (checkEmptyString(hospitaladmin.password))
    {
        alert('Password is required');
        return;
    }

    $.ajax({
        type: "POST",
        url: "/login",
        dataType: "json",
        success: function (msg) {
            if (msg.length > 0) {
                location.href='/main';
            } else {
                alert("Invalid User !");
            }
        },
        data: hospitaladmin
    });
});

function checkEmptyString(val)
{
    return (val == undefined || val == null || val.trim().length == 0);
}
