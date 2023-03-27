
function getid() {
    let id;
    const url = new URL(getURL());
    var p = url.pathname
    a = p.split("/")
    if (a.length == 3 && a[1]=="cp"){
        id = a[2]
        return id
    }
    return ""
}

const initcp =() => {
    $('.form-change-password').submit(function (e) {
      e.preventDefault();
      let payload = {
          password: $("#i2").val(),
      };
     
      $.ajax({
          url: '/accounts/changepasswords/change',
          type: 'POST',
          contentType: 'application/json',
          data: JSON.stringify(payload),
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": `Bearer ${getid()}`
          },
          success: function (data, textStatus, jqXHR) {
            if(jqXHR.status == 201) {
              let j = JSON.parse(data)
              localStorage.clear()
              localStorage.setItem("jwt_token", j.jwt_token);
              
              $(".cp").html(
                `<h1>Success!</h1>
                 <p style="font-size: 15px; color: white; text-align: center;">Password changed successfully!</p>
                 <button class="button button-block button-cp-login">Login</button> 
                `
              )
              $(".flash__body").html("Password changed !")
              $( ".flash" ).addClass( "animate--drop-in-fade-out" );
              setTimeout(function(){
                $( ".flash" ).removeClass( "animate--drop-in-fade-out" );
              }, 3500);
              initredirect()
            }
          },
          error: function (jqXHR, textStatus, errorThrown) {
              if(jqXHR.status == 401) {
                $(".cp").html(
                    `<h1>unauthorized!</h1>
                     <p style="font-size: 15px; color: red; text-align: center;">You are not authorized or the link is expired!</p>
                    `
                  )
              }
          }
      })
    });

 
}

const initredirect = () => {
    $('.button-cp-login').on('click', function (e) {
       e.preventDefault();
       window.location.href ="/admin"
   });
}

function getURL () {
    return window.location.href
}