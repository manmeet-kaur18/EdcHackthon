const button = document.getElementById('updateinjectiondetail');
button.addEventListener('click', function(e) {
  console.log('button was clicked');
    let injection = {
        childname: document.getElementById('childname').value,
        injectionname: document.getElementById('injectionname').value,
      };
    if (checkEmptyString(injection.childname))
    {
        alert('User name is required');
        return;
    }
    if (checkEmptyString(injection.injectionname))
    {
        alert('User Email is required');
        return;
    }


    $.ajax({
        type: "POST",
        url: "/updateinjection",
        dataType: "json",
        success: function (msg) {
            if (msg.length > 0) {
                location.href='/main';
            } else {
                alert("Invalid User !");
            }
        },
        data: injection
    });
});

function checkEmptyString(val)
{
    return (val == undefined || val == null || val.trim().length == 0);
}
