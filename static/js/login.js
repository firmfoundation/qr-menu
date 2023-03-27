const initl =() => {

  $('.form').find('input, textarea').on('keyup blur focus', function (e) {
    
      var $this = $(this),
          label = $this.prev('label');
    
          if (e.type === 'keyup') {
                if ($this.val() === '') {
              label.removeClass('active highlight');
            } else {
              label.addClass('active highlight');
            }
        } else if (e.type === 'blur') {
            if( $this.val() === '' ) {
                label.removeClass('active highlight'); 
                } else {
                label.removeClass('highlight');   
                }   
        } else if (e.type === 'focus') {
          
          if( $this.val() === '' ) {
                label.removeClass('highlight'); 
                } 
          else if( $this.val() !== '' ) {
                label.addClass('highlight');
                }
        }
    
  });
    
  $('.tab a').on('click', function (e) {
      
      e.preventDefault();
      
      $(this).parent().addClass('active');
      $(this).parent().siblings().removeClass('active');
      
      target = $(this).attr('href');
    
      $('.tab-content > div').not(target).hide();
      
      $(target).fadeIn(600);
      
  });

  $('.forgot a').on('click', function (e) {
    e.preventDefault();
     
    callcp()
     
  });

  $('.form-signup').submit(function (e) {
    e.preventDefault();
    let payload = {
        email: $("#i1").val(),
        password: $("#i2").val(),
    };

    $.ajax({
        url: '/accounts',
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(payload),
        success: function (response) {
          var json = JSON.parse(response);
          setJwt(json.jwt_token)
          callD(json.jwt_token)
        },
        error: function (response) {
          console.log(response)
            alert("error")
        }
    })
  });


  $('.form-login').submit(function (e) {
    e.preventDefault();
    let payload = {
        email: $("#l1").val(),
        password: $("#l2").val(),
    };

    $.ajax({
        url: '/accounts/authenticate',
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(payload),
        success: function (response) {
          var json = JSON.parse(response);
          setJwt(json.jwt_token)
          callD(json.jwt_token)
        },
        error: function (response) {
          console.log(response)
            alert("error")
        }
    })
  });
}  

const initcp =() => {
  $('.form-change-password-req').submit(function (e) {
    e.preventDefault();
    let payload = {
        email: $("#i1").val(),
    };

    $.ajax({
        url: '/accounts/changepasswords/request',
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(payload),
        success: function (data, textStatus, jqXHR) {
          if(jqXHR.status == 201) {
            $(".cp-req").html(
              `<h1>Request Success!</h1>
               <p>Please check your email.You will find a link to help you change your Password!</p>
              `
            )
            $(".flash__body").html("we just sent you an email!")
            $( ".flash" ).addClass( "animate--drop-in-fade-out" );
            setTimeout(function(){
              $( ".flash" ).removeClass( "animate--drop-in-fade-out" );
            }, 3500);
          }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert(jqXHR.status)
        }
    })
  });
}

const setJwt = (j) => {
  localStorage.setItem("jwt_token", j);
}

const callD = (j) => {
  $.ajax({
    url: "/dashboard",
    type: 'GET',
    contentType: 'application/json',
    headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": `Bearer ${j}`
    },
    success: function (response) {
      $('.root').html(response)
      initDashboard()
    },
    error: function (response) {
        alert("error")
        console.log(response)
    }
  }) 
}

const callcp = () => {
  $.ajax({
      url: '/cp-req',
      type: 'GET',
      contentType: 'application/json',
      success: function (response) {
          $('.root').html(response)
          initcp()
      },
      error: function (response) {
          //console.log(response)
      }
  })
}