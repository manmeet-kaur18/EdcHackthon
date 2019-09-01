const button = document.getElementById('submitfeedback');
button.addEventListener('click', function(e) {

  console.log('button was clicked');
    let feedback = {
        comments: document.getElementById('comments').value
    };
  
    if (checkEmptyString(feedback.comments))
    {
        alert('User Password is required');
        return;
    }

    $.ajax({
        type: "POST",
        url: "/savefeedback",
        dataType: "json",
        success: function (msg) {
            if (msg.length > 0) {
                location.href='/main';
            } else {
                alert("Invalid User !");
            }
        },
        data: feedback
    });
});

function checkEmptyString(val)
{
    return (val == undefined || val == null || val.trim().length == 0);
}
