let global = {
  tooltipOptions: {
    placement: "right" 
  },
  menuClass: ".c-menu" 
};

const initDashboard = () => {
    pMenu()
    $(".js-hamburger").on("click", sidebarChangeWidth);
  
    $(".js-menu li").on("click", e => {
      menuChangeActive(e.currentTarget);
    });

    $('.logout').on('click', function (e) {
      e.preventDefault();
      localStorage.clear()
      callLogin()
    });
}

let sidebarChangeWidth = () => {
  let $menuItemsTitle = $("li .menu-item__title");

  $(".body-layer").toggleClass("sidebar-is-reduced sidebar-is-expanded");
  $(".hamburger-toggle").toggleClass("is-opened");

  if ($(".body-layer").hasClass("sidebar-is-expanded")) {
    $('[data-toggle="tooltip"]').tooltip("destroy");
  } else {
    $('[data-toggle="tooltip"]').tooltip(global.tooltipOptions);
  }

};

let menuChangeActive = el => {
  let hasSubmenu = $(el).hasClass("has-submenu");
  $(global.menuClass + " .is-active").removeClass("is-active");
  $(el).addClass("is-active");

  // if (hasSubmenu) {
  // 	$(el).find("ul").slideDown();
  // }
};


const m = (a) => {
  switch (a) {
    case 0:
      pMenu()
      break
    case 1:
      pProfile()
      break;
    case 2:
      pQR()
      break;
    case 3:
      pOrder()
      break;
    case 4:
      pTheme()
      break;
  }
}

const pTheme  = () => {
  $(".page-title").empty()
  $(".page-title").append("Theme")

  let div_menu_pan = document.createElement('div');
  $(div_menu_pan).addClass('div-menu-pan page-content')
  $(div_menu_pan).append(
    `<div>

      <div class="radio__layout">
        <input type="radio" name="option" id="1" onclick="radioChange(this);" value="1">
      </div>
      <div class="container h-100 d-flex justify-content-center">
        <img src="/static/img/theme_1.png" alt="" class="img-responsive" height="430px"/>
      </div>

      <div class="radio__layout">
         <input type="radio" name="option" id="2" onclick="radioChange(this);" value="2">
      </div>
      <div class="container h-100 d-flex justify-content-center">
          <img src="/static/img/theme_2.png" alt="" class="img-responsive" height="430px"/>
      </div>
      
    </div>
    `
  )
  $(".content").html(div_menu_pan)
}

const radioChange = (r) => {
  $.ajax({
    url: `/accounts/themes?theme_id=${r.value}`,
    type: 'POST',
    contentType: 'application/json',
    headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": `Bearer ${window.localStorage.getItem('jwt_token')}`
    },
    success: function (response) {
      $(".flash__body").html("Theme updated successfully!")
      $( ".flash" ).addClass( "animate--drop-in-fade-out" );
      setTimeout(function(){
        $( ".flash" ).removeClass( "animate--drop-in-fade-out" );
      }, 3500);
    },
    error: function (response) {
        //console.log(response)
    }
  })             
}

const getSuccess = (tag) => {
  $(".div-menu").append(tag)
}

const getS = (tag) => {
  $(".div-pan").append(tag)
  $(".div-pan").addClass('table-responsive-sm scrollme')
}

const pProfile = () => {
  
  $(".page-title").empty()
  $(".page-title").append("Profile")
  $(".content").empty()

  var div_main = document.createElement('div');
  $(div_main).addClass('page-content')
  var div_form = document.createElement('div');
  $(div_form).addClass('div-form')
  getProfile()
  $(div_main).append(div_form)
  $(".content").append(div_main)
}

const pMenu = () => {
  $(".page-title").empty()
  $(".page-title").append("Menu")
  $(".content").empty()

  menuInit()
  recInit()
}

const pQR = () => {
  $(".page-title").empty()
  $(".page-title").append("QR")
  $(".content").empty()

  qrInit()
}

const pOrder = () => {
  $(".page-title").empty()
  $(".page-title").append("Orders")
  $(".content").empty()

  orderInit()
  fOrder()
}

const orderInit = () => {
  let div_menu_pan = document.createElement('div');
  $(div_menu_pan).addClass('div-menu-pan page-content')
  $(div_menu_pan).append(
    `
    <div class="select-status">
    <select>
      <option value="pending" selected>pending</option>
    </select>
    </div>
    `
  )
  $(".content").html(div_menu_pan)
}

const fOrder = () => {
  var div_main = document.createElement('div');
  $(div_main).addClass('page-content')
  var div_menu = document.createElement('div');
  $(div_menu).addClass('div-menu')
  getOrders();

  $(div_main).append(div_menu)
  $(".content").append(div_main)
}

const menuInit = () => {
  let div_menu_pan = document.createElement('div');
  $(div_menu_pan).addClass('div-menu-pan page-content')
  $(div_menu_pan).append(
    `
    <button type="button" class="button-md" id="btn-create" onClick="showMenuForm();">Create Menu Item</button>
    `
  )
  $(".content").html(div_menu_pan)
}

const qrInit = () => {
  let div_pan = document.createElement('div');
  $(div_pan).addClass('div-pan page-content')
  $(div_pan).append(
    `
    <button type="button" class="button-md" id="btn-create" onClick="GenQR();">Generate QR</button>
    `
  )
  $(".content").html(div_pan)
}

const btnD = () => {
  let div_d = document.createElement('div');
  $(div_d).addClass('div-d page-content')
  $(div_d).append(
    `
    <button type="button" class="button-md" id="btn-download">Download</button>
    `
  )
  $(".content").append(div_d)
}

const downloadQR = () => {
  $('#btn-download').click(function () {
    var link = document.createElement('a');
    link.href = $('#qr-menu').attr('src'); 
    link.download = 'qr_menu.png';
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
  })
}

const qrImg = (b) => {
  let div_img = document.createElement('div');
  $(div_img).addClass('div-img page-content')
  $(div_img).append(
    `
    <img src=" ${b}" class="rounded" id="qr-menu" height="350px">
    `
  )
  $(".content").html(div_img)

  btnD()
  downloadQR()
}

const recInit = () => {
  var div_main = document.createElement('div');
  $(div_main).addClass('page-content')
  var div_menu = document.createElement('div');
  $(div_menu).addClass('div-menu')
  getMenu();

  $(div_main).append(div_menu)
  $(".content").append(div_main)
}

const cancelMenu = () => {
  menuInit()
  recInit()
}

const showMenuForm = () => {
  $(".div-menu-pan").empty()
  formMenu($(".div-menu-pan"))
}

const rQr = (c) => {
  $(c).append(
    `
     <div class="row justify-content-md-center">
      <div class="col">
        <img src="/static/img/qr.jpg" id="bashanka" class="rounded" width="150">
      </div>
      <div class="col">
        <div><button type="button" class="btn btn-warning btn-lg" id="btn-gen">Download QR</button></div>
        <div><button type="button" class="btn btn-warning btn-lg" id="btn-gen">Print Scan QR</button></div>
      </div>
     </div>
    `
  )
}

const getOrders = () => {
  let s = $('.select-status').find(":selected").val()
  $.ajax({
    url: `/menus/orders?status=${s}`,
    type: 'GET',
    contentType: 'application/json',
    headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": `Bearer ${window.localStorage.getItem('jwt_token')}`
    },
    success: function (response) {
      var json = JSON.parse(response);
      let tag = renderOrder(json)
      $(".div-menu").empty()
      $(".div-menu").append(tag)
    },
    error: function (response) {
        //console.log(response)
    }
  })             
} 

const getMenu = () => {
  $.ajax({
    url: '/accounts/menus?account_id',
    type: 'GET',
    contentType: 'application/json',
    headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": `Bearer ${window.localStorage.getItem('jwt_token')}`
    },
    success: function (response) {
      var json = JSON.parse(response);
      let tag = renderMenu(json)
      getSuccess(tag)
    },
    error: function (response) {
        //console.log(response)
    }
  })             
} 

const GenQR = () => {
  $.ajax({
    url: 'admin/menus/qr',
    type: 'GET',
    contentType: 'application/json',
    headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": `Bearer ${window.localStorage.getItem('jwt_token')}`
    },
    success: function (res) {
      qrImg(res)
    },
    error: function (response) {
        //console.log(response)
    }
  })             
} 

const getProfile = () => {
  $.ajax({
    url: '/admin/profiles',
    type: 'GET',
    contentType: 'application/json',
    headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": `Bearer ${window.localStorage.getItem('jwt_token')}`
    },
    success: function (r) {
      var json = JSON.parse(r);
      uProfile(json)
    },
    error: function (r) {
        if(r.status == 404) {
          cProfile()
        }
    }
  })             
} 
const um = (p1, p2, p3, p4, p5, p6, p7) => {
  formMu(p1, p2, p3, p4, p5, p6, p7)
}

const dm = (i) => {
  if (window.confirm('Are you sure you want to DELETE ?')) {
    var payload = {
        id: i
    };

    $.ajax({
        url: '/admin/menus',
        type: 'DELETE',
        contentType: 'application/json',
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": `Bearer ${window.localStorage.getItem('jwt_token')}`
        },
        data: JSON.stringify(payload),
        success: function (response) {
          $(".flash__body").html("Menu item deleted successfully!")
          $( ".flash" ).addClass( "animate--drop-in-fade-out" );
          setTimeout(function(){
            $( ".flash" ).removeClass( "animate--drop-in-fade-out" );
          }, 3500);
          cancelMenu()
        },
        error: function (response) {
            alert("Error: could not be deleted, it has order.")
        }
    })
  }
}

const clean = (str) => {
  return str.replace(/[^a-zA-Z0-9 ]/g, '');
}

const renderMenu = (s) => {
  var tbody = document.createElement('tbody');
  $.each(s, function( key, v ) {
      $(tbody).append(
          `<tr id="row-${v.id}")>
            <td>${v.category}</td>
            <td>${v.name}</td>
            <td>${v.description}</td>
            <td>${v.price_s}</td>
            <td>${v.price_l}</td>
            <td>
              <i class="bi bi-pencil-square" onClick="um('${v.id}','${v.name}', '${clean(v.description)}', '${v.price_s}','${v.price_l}', '${v.category_id}', '${v.image}');" style="font-size: 15px; color: green;" title="edit"></i>
              <i class="bi bi-trash3" style="font-size: 15px; color: red;" onClick="dm('${v.id}')" title="delete"></i>
            </td>
          </tr>`
      )
  });

  var table = document.createElement('table');
  $(table).addClass('table table-hover')
  $(table).append(
        `<thead>
          <tr>
            <th scope="col">Category</th>
            <th scope="col">Item name</th>
            <th scope="col">Description</th>
            <th scope="col">Price (small)</th>
            <th scope="col">Price (large)</th>
            <th scope="col">Action</th>
          </tr>
        </thead>`
  );
  $(table).append(tbody)

  
  return table
}

const renderOrder = (s) => {
  var tbody = document.createElement('tbody');
  $.each(s, function( key, v ) {
      $(tbody).append(
          `<tr id="row-${v.id}")>
            <td>${v.id}</td>
            <td>${v.full_name}</td>
            <td>${v.mobile}</td>
            <td>${v.payment_type}</td>
            <td>${v.total}</td>
            <td>${v.status}</td>
            <td>
            <button type="button" id="b-sj" class="btn btn-warning" onClick="o_d('${v.id}')" style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .95rem;">View</button>
            </td>
          </tr>`
      )
  });

  var table = document.createElement('table');
  $(table).addClass('table table-hover')
  $(table).append(
        `<thead>
          <tr>
            <th scope="col">Order Ref</th>
            <th scope="col">Customer</th>
            <th scope="col">Mobile</th>
            <th scope="col">Payment Type</th>
            <th scope="col">Total</th>
            <th scope="col">Status</th>
            <th scope="col">Action</th>
          </tr>
        </thead>`
  );
  $(table).append(tbody)

  
  return table
}

const o_d = (id) => {
  $.ajax({
    url: `/admin/orders/detail?id=${id}`,
    type: 'GET',
    contentType: 'application/json',
    headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": `Bearer ${window.localStorage.getItem('jwt_token')}`
    },
    success: function (r) {
      var j= JSON.parse(r);
      vo(j)
    },
    error: function (response) {
        //console.log(response)
    }
  })             
} 

const vo = async (j) => {
  $(".modal__content").empty()
  $(".modal__content").show()
  var div = document.createElement('div');
  $(div).addClass('order__modal order__font')
  $(div).append(`<div class="window__header"><img class="window__close__img" src="/static/img/close.png" onClick="co()"></div>`)
  $(div).append("<div><h3>Order detail</h3></div>")
  $(div).append(`<div>Customer : ${j[0].full_name}</div>`)
  $(div).append(`<div>mobile : ${j[0].mobile}</div>`)
  $(div).append(`<div>Payment Type : ${j[0].payment_type}</div>`)
  $(div).append(`<div>Order note : ${j[0].order_note}</div>`)
  $(div).append(`<div>Status : ${j[0].status}</div>`)
  $(".modal__content").append(div)
  
  let r = await render_order_items(j)
  
  $(".order__modal").append(r)

  $(".order__modal").append(`
    <button type="button" id="b-sj" class="btn btn-warning" onClick="update_o('${j[0].id}', 'confirmed')">Payment Confirmed</button>
    <button type="button" id="b-sj" class="btn btn-danger" onClick="update_o('${j[0].id}', 'canceled')">Cancel Order</button> 
` )
}

const update_o = (id, s) => {
  $.ajax({
    url: `/admin/orders/update?id=${id}&s=${s}`,
    type: 'POST',
    contentType: 'application/json',
    headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": `Bearer ${window.localStorage.getItem('jwt_token')}`
    },
    success: function (response) {
      getOrders()
      $(".modal__content").hide()
      $(".modal__content").empty()
      $(".flash__body").html("Order updated successfully!")
      $( ".flash" ).addClass( "animate--drop-in-fade-out" );
      setTimeout(function(){
        $( ".flash" ).removeClass( "animate--drop-in-fade-out" );
      }, 3500);
    },
    error: function (response) {
        //console.log(response)
    }
  })             
}

const co = () => {
  $(".modal__content").hide()
  $(".modal__content").empty()
}

const render_order_items = async (j) => {
  let tbody = document.createElement('tbody');
  $(tbody).addClass('order__font')
  let gt = 0;
  $.each(j, function( key, v ) {
     let t = Number(v.price) * Number(v.qty)
     gt = gt + t
      $(tbody).append(
          `<tr id="row-${v.i}")>
            <td>${v.name}</td>
            <td>${v.price}</td>
            <td>${v.qty}</td>
            <td>${t}</td>
          </tr>`
      )
  });

  $(tbody).append(
          `<tr>
            <td></td>
            <td></td>
            <td>Total:</td>
            <td>${gt}</td>
          </tr>`
  )


  var table = document.createElement('table');
  $(table).addClass('table table-hover')
  $(table).append(
        `
          <tr>
            <th scope="col">Name</th>
            <th scope="col">Price</th>
            <th scope="col">Quantity</th>
            <th scope="col">Total</th>
          </tr>
        `
  );
  $(table).append(tbody)
  return table  
}

const formMenu = async () => {
  var div = document.createElement('div');
  $(div).addClass('page-content')
  $(div).html(`
     
          <h5 class="card-title mb-3">Create menu items</h5>
          <div id="left-col" class="cs-1 was-validated justify-content-center">
              <div class="field-wrap">
                <div class="select-menu-cat"></div>
              </div>

              <div class="field-wrap">
                  <input class="input-s" type="text" id="m-name" value="" required>
                  <label class="label-s" for="m-name">menu item name</label>
                  <div class="invalid-feedback">menu item name required </div>
              </div>

              <div class="field-wrap">
                  <input type="text" class="input-s" id="m-desc" value="" size="10" required>
                  <label class="label-s" for="question" >Description</label>
                  <div class="invalid-feedback">description required </div>
              </div>

              <div class="field-wrap">
                  <input type="text" class="input-s" id="m-price-s" value="" size="10" required>
                  <label class="label-s" for="question" class="form-label">Price (for small size)</label>
                  <div class="invalid-feedback">price for small size is required </div>
              </div>

              <div class="field-wrap">
                  <input type="text" class="input-s" id="m-price-l" value="" size="10" required>
                  <label class="label-s" for="question" class="form-label">Price (for large size)</label>
                  <div class="invalid-feedback">price for large size is required </div>
              </div>

              <div class="mt-3">
                  <button type="button" class="button-md" id="btn-menu-create" onClick="createMenu();">Create Menu</button>
                  <button type="button" class="button-md btn-g" id="btn-menu-create" onClick="cancelMenu();">Cancel</button>
              </div>            
          </div>
      
  `)
  $('.content').html(div)
  let res = await getCategory();
  if(res != "") {
    let json = JSON.parse(res);
    listCategory(json)
  }
}

const formMu = async (p1, p2, p3, p4, p5, p6, p7) => {
  $('.content').empty();
  var i = document.createElement('div');
  $(i).addClass('page-content')
 
  $(i).append(`
          <h5 class="card-title mb-3">Update menu item</h5>
          <div id="left-col" class="cs-1 was-validated justify-content-center">
              <div class="field-wrap">
               <div class="select-menu-cat"></div>
              </div>

              <div class="field-wrap">
                  <input type="text" class="input-s" id="m-name" value="${p2}" size="10" required>
                  <label class="label-s" for="m-name" class="form-label">menu item name</label>
                  <div class="invalid-feedback">menu item name required </div>
              </div>

              <div class="field-wrap">
                  <input type="text" class="input-s" id="m-desc" value="${p3}" size="10" required>
                  <label class="label-s" for="question" class="form-label">Description</label>
                  <div class="invalid-feedback">menu description required </div>
              </div>

              <div class="field-wrap">
                  <input type="text" class="input-s" id="m-price-s" value="${p4}" size="10" required>
                  <label class="label-s" for="question" class="form-label">Price (small size)</label>
                  <div class="invalid-feedback">menu price for small size is required </div>
              </div>

              <div class="field-wrap">
                  <input type="text" class="input-s" id="m-price-l" value="${p5}" size="10" required>
                  <label class="label-s" for="question" class="form-label">Price (large size)</label>
                  <div class="invalid-feedback">menu price for large size is required </div>
              </div>

              <div class="mt-3">
                  <button type="button" class="button-md" id="btn-menu-update" onClick="updateMenu('${p1}');">Update</button>
                  <button type="button" class="button-md btn-g" id="btn-menu-create" onClick="cancelMenu();">Cancel</button>
              </div>            
          </div>
  `)
  $('.content').append(i)

  let res = await getCategory();
  if(res != "") {
    var json = JSON.parse(res);
    listCategory(json)
    $('.list-menu').val(p6);
  }

  uploadMenuImg(p1,p7)
}

const getCategory = async () => {
  return await $.ajax({
      url: '/admin/categories',
      type: 'GET',
      contentType: 'application/json',
      success: function (response) {
          var json = JSON.parse(response);
          //sGetCategory(json)
          return json
      },
      error: function (response) {
          return ""
      }
  })
}

const sGetCategory = (json) => {
  listCategory(json)
}

function listCategory(itm) {
  $(".select-menu-cat").empty();
  var select = document.createElement('select');
  $(select).addClass('list-menu form-select input-s')
  $(select).append(`<option value="" selected>-Select Category-</option>`)
  $.each(itm, function( key, v ) {
      $(select).append(
          `<option value="${v.ID}">${v.name}</option>`
      )
  });
 

  $(".select-menu-cat").append(select);
  $(".select-menu-cat").append(
      `<label class="label-s" for="list-category" class="form-label">Menu Category</label>
      <div class="invalid-feedback">menu category name required.</div>`
  )
}

const createMenu = () => {
  var select_cat_value = $('.select-menu-cat').find(":selected").val()
  if (select_cat_value == "") {
      alert("select menu category from the list!")
      return
  }
  var payload = {
      category_id: select_cat_value,
      name: $("#m-name").val(),
      description: $("#m-desc").val(),
      price_s: Number($("#m-price-s").val()),
      price_l: Number($("#m-price-l").val())
  };

  $.ajax({
      url: '/admin/menus',
      type: 'POST',
      contentType: 'application/json',
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": `Bearer ${window.localStorage.getItem('jwt_token')}`
      },
      data: JSON.stringify(payload),
      success: function (response) {
        $(".flash__body").html("Menu item created successfully!")
        $( ".flash" ).addClass( "animate--drop-in-fade-out" );
        setTimeout(function(){
          $( ".flash" ).removeClass( "animate--drop-in-fade-out" );
        }, 3500);
        showMenuForm()
      },
      error: function (response) {
          alert("error")
      }
  })
}

const updateMenu = (id) => {
  var select_cat_value = $('.select-menu-cat').find(":selected").val()
  if (select_cat_value == "") {
      alert("select menu category from the list!")
      return
  }
  var payload = {
      category_id: select_cat_value,
      name: $("#m-name").val(),
      description: $("#m-desc").val(),
      price_s: Number($("#m-price-s").val()),
      price_l: Number($("#m-price-l").val()),
      id
  };

  $.ajax({
      url: '/admin/menus',
      type: 'POST',
      contentType: 'application/json',
      data: JSON.stringify(payload),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": `Bearer ${window.localStorage.getItem('jwt_token')}`
      },
      success: function (response) {
         $(".flash__body").html("Menu updated successfully!")
         $( ".flash" ).addClass( "animate--drop-in-fade-out" );
         setTimeout(function(){
           $( ".flash" ).removeClass( "animate--drop-in-fade-out" );
         }, 3500);
         cancelMenu()
      },
      error: function (response) {
          alert("error")
      }
  })
}

const createProfile = () => {
  var payload = {
      business_name: $("#m-1").val(),
      address: $("#m-2").val(),
      mobile: $("#m-3").val(),
      email: $("#m-4").val(),
      full_name: $("#m-5").val(),
      h1: $("#m-6").val(),
      h2: $("#m-7").val(),
      h3: $("#m-8").val()
  };

  $.ajax({
      url: '/admin/profiles',
      type: 'POST',
      contentType: 'application/json',
      data: JSON.stringify(payload),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": `Bearer ${window.localStorage.getItem('jwt_token')}`
      },
      success: function (response) {
        $(".flash__body").html("Profile created successfully!")
        $( ".flash" ).addClass( "animate--drop-in-fade-out" );
        setTimeout(function(){
          $( ".flash" ).removeClass( "animate--drop-in-fade-out" );
        }, 3500);
        cancelMenu()
      },
      error: function (response) {
          alert("error")
      }
  })
}

const updateProfile = (id) => {
  var payload = {
      business_name: $("#m-1").val(),
      address: $("#m-2").val(),
      mobile: $("#m-3").val(),
      email: $("#m-4").val(),
      full_name: $("#m-5").val(),
      h1: $("#m-6").val(),
      h2: $("#m-7").val(),
      h3: $("#m-8").val(),
      id
  };

  $.ajax({
      url: '/admin/profiles',
      type: 'POST',
      contentType: 'application/json',
      data: JSON.stringify(payload),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": `Bearer ${window.localStorage.getItem('jwt_token')}`
      },
      success: function (response) {
        $(".flash__body").html("Profile updated successfully!")
        $( ".flash" ).addClass( "animate--drop-in-fade-out" );
        setTimeout(function(){
          $( ".flash" ).removeClass( "animate--drop-in-fade-out" );
        }, 3500);
        cancelProfile()
      },
      error: function (response) {
          alert("error")
      }
  })
}


const cProfile = async () => {
  var div = document.createElement('div');
  $(div).addClass('page-content')
  $(div).html(`
          <h5 class="card-title mb-3">Create profile</h5>
          <div id="left-col" class="cs-1 was-validated justify-content-center">
              <div class="field-wrap">
                  <input type="text" class="input-s" id="m-1" value="" required>
                  <label for="m-name" class="label-s">Caffe or Resturant Name</label>
                  <div class="invalid-feedback">caffee or resturant name required </div>
              </div>

              <div class="field-wrap">
                  <input type="text" class="input-s" id="m-2" value=""  required>
                  <label for="question" class="label-s">Address</label>
                  <div class="invalid-feedback">address required </div>
              </div>

              <div class="field-wrap">
                  <input type="text" class="input-s" id="m-3" value=""  required>
                  <label for="question" class="label-s">Mobile</label>
                  <div class="invalid-feedback">mobile required </div>
              </div>

              <div class="field-wrap">
                  <input type="text" class="input-s" id="m-4" value="" required>
                  <label for="question" class="label-s">Email</label>
                  <div class="invalid-feedback">email required </div>
              </div>

              <div class="field-wrap">
                  <input type="text" class="input-s" id="m-5" value="" required>
                  <label for="question" class="label-s">Contact person</label>
                  <div class="invalid-feedback">field equired </div>
              </div>

              <div class="field-wrap">
                  <input type="text" class="input-s" id="m-6" value="Mon. - Thurs. 6 a.m. - 9 p.m." required>
                  <label for="question" class="label-s">Working hours 1</label>
                  <div class="invalid-feedback">field  required </div>
              </div>

              <div class="field-wrap">
                  <input type="text" class="input-s" id="m-7" value="Fri. - Sat. 6 a.m. - 11 p.m." required>
                  <label for="question" class="label-s">Working hours 2</label>
                  <div class="invalid-feedback">field required </div>
              </div>

              <div class="field-wrap">
                  <input type="text" class="input-s" id="m-8" value="Sunday 8 a.m. - 2 p.m." required>
                  <label for="question" class="label-s">Working hours 3</label>
                  <div class="invalid-feedback">field required </div>
              </div>

              <div class="mt-3">
                  <button type="button" class="button-md" id="btn-menu-update" onClick="createProfile();">Create profile</button>
              </div>            
          </div>
  `)
  $('.content').html(div)
}

const uProfile = async (a) => {
  var div = document.createElement('div');
  $(div).addClass('page-content')
  $(div).html(`
          <h5 class="card-title mb-3">Update profile</h5>
          <div id="left-col" class="cs-1 was-validated justify-content-center">
              <div class="field-wrap">
                  <input type="text" class="input-s" id="m-1" value="${a.business_name}" required>
                  <label for="m-name" class="label-s">Caffe or Resturant Name</label>
                  <div class="invalid-feedback">caffee or resturant name required </div>
              </div>

              <div class="field-wrap">
                  <input type="text" class="input-s" id="m-2" value="${a.address}"  required>
                  <label for="question" class="label-s">Address</label>
                  <div class="invalid-feedback">address required </div>
              </div>

              <div class="field-wrap">
                  <input type="text" class="input-s" id="m-3" value="${a.mobile}"  required>
                  <label for="question" class="label-s">Mobile</label>
                  <div class="invalid-feedback">mobile required </div>
              </div>

              <div class="field-wrap">
                  <input type="text" class="input-s" id="m-4" value="${a.email}" required>
                  <label for="question" class="label-s">Email</label>
                  <div class="invalid-feedback">email required </div>
              </div>

              <div class="field-wrap">
                  <input type="text" class="input-s" id="m-5" value="${a.full_name}" required>
                  <label for="question" class="label-s">Contact person</label>
                  <div class="invalid-feedback">field required </div>
              </div>

              <div class="field-wrap">
                  <input type="text" class="input-s" id="m-6" value="${a.h1}" required>
                  <label for="question" class="label-s">Working hours 1</label>
                  <div class="invalid-feedback">field  required </div>
              </div>

              <div class="field-wrap">
                  <input type="text" class="input-s" id="m-7" value="${a.h2}" required>
                  <label for="question" class="label-s">Working hours 2</label>
                  <div class="invalid-feedback">field required </div>
              </div>

              <div class="field-wrap">
                  <input type="text" class="input-s" id="m-8" value="${a.h3}" required>
                  <label for="question" class="label-s">Working hours 3</label>
                  <div class="invalid-feedback">field required </div>
              </div>

              <div class="mt-3">
                  <button type="button" class="button-md" id="btn-menu-update" onClick="updateProfile('${a.id}');">Update profile</button>
              </div>            
          </div>
  `)
  $('.content').html(div)
  uploadimg(a.logo)
}

const uploadimg = (l) => {
   var logo = document.createElement('div');
   $(logo).addClass('page-content')
   $(logo).append(
     `
    <div class="logo-input">
      <div class="logo-preview">
        <img id="file-ip-1-preview" src="/static/img/logo/${l}">
      </div>
      <input type="file" id="file-ip-1" accept="image/*" onchange="showPreview(event);">
    </div>
     `
   )
   
   $(".content").append(logo)
}

function showPreview(event){
  if(event.target.files.length > 0){
    var src = URL.createObjectURL(event.target.files[0]);
    var preview = document.getElementById("file-ip-1-preview");
    preview.src = src;
    preview.style.display = "block";
    u()
  }
}


const uploadMenuImg = (menu_id, l) => {
  var i = document.createElement('div');
  $(i).addClass('page-content')
  $(i).append(
    `
   <div class="logo-input">
     <div class="logo-preview">
       <img id="file-ip-1-preview" src="/static/img/menu/${l}">
     </div>
     <input type="file" id="file-ip-1" accept="image/*" onchange="showPreviewMenuImage(event,'${menu_id}');">
   </div>
    `
  )
  $('.content').append(i);
}

function showPreviewMenuImage(event,menu_id){
 if(event.target.files.length > 0){
   var src = URL.createObjectURL(event.target.files[0]);
   var preview = document.getElementById("file-ip-1-preview");
   preview.src = src;
   preview.style.display = "block";
   umi(menu_id)
 }
}

const u = () => {
  var formData = new FormData();
  formData.append('logo', $('#file-ip-1')[0].files[0]);

  $.ajax({
        url : '/admin/profiles/logos',
        type : 'POST',
        data : formData,
        cache: false,
        processData: false,  
        contentType: false,  
        headers: {
          "Authorization": `Bearer ${window.localStorage.getItem('jwt_token')}`
        },
        success : function(data) {
          $(".flash__body").html("Logo updated successfully!")
          $( ".flash" ).addClass( "animate--drop-in-fade-out" );
          setTimeout(function(){
            $( ".flash" ).removeClass( "animate--drop-in-fade-out" );
          }, 3500);
        }
  });
}

const umi = (menu_id) => {
  var formData = new FormData();
  formData.append('img', $('#file-ip-1')[0].files[0]);

  $.ajax({
        url : `/admin/menus/images?menu_id=${menu_id}`,
        type : 'POST',
        data : formData,
        cache: false,
        processData: false,  
        contentType: false,  
        headers: {
          "Authorization": `Bearer ${window.localStorage.getItem('jwt_token')}`
        },
        success : function(data) {
          $(".flash__body").html("Logo updated successfully!")
          $( ".flash" ).addClass( "animate--drop-in-fade-out" );
          setTimeout(function(){
            $( ".flash" ).removeClass( "animate--drop-in-fade-out" );
          }, 3500);
        }
  });
}