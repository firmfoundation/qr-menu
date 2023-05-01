$(function () {
               
    $( document ).ready(function() {
        $(".modal__content").hide()
        $('.root').empty()
        let jwt_token = window.localStorage.getItem('jwt_token');
        if (jwt_token==null) {
            callLogin()
        } else {
            callD(jwt_token)
        }
    });

});

const callLogin = () => {
    $.ajax({
        url: '/login',
        type: 'GET',
        contentType: 'application/json',
        success: function (response) {
            $('.root').html(response)
            initl()
        },
        error: function (response) {
            //console.log(response)
        }
    })
}