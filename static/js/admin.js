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
  }
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
const um = (p1, p2, p3, p4, p5, p6) => {
  formMu($(".div-menu-pan"), p1, p2, p3, p4, p5, p6)
}

const dm = (id) => {
  console.log(id)
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
              <i class="bi bi-pencil-square" onClick="um('${v.id}','${v.name}', '${clean(v.description)}', '${v.price_s}','${v.price_l}', '${v.category_id}');" style="font-size: 15px; color: green;" title="edit"></i>
              <i class="bi bi-trash3" style="font-size: 15px; color: red;" title="edit"></i>
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

const formMu = async (tag, p1, p2, p3, p4, p5, p6) => {
  $(tag).empty();
  $(tag).append(`
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
  let res = await getCategory();
  if(res != "") {
    var json = JSON.parse(res);
    listCategory(json)
    $('.list-menu').val(p6);
  }
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
        console.log("err ", response)
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
        console.log("err ", response)
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
  uploadimg()
}

const uploadimg = () => {
   var logo = document.createElement('div');
   $(logo).addClass('page-content')
   $(logo).append(
     `
    <div class="logo-input">
      <div class="logo-preview">
        <img id="file-ip-1-preview">
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

const u = () => {
  var formData = new FormData();
  formData.append('logo', $('#file-ip-1')[0].files[0]);

  $.ajax({
        url : '/admin/profiles/logos',
        type : 'POST',
        data : formData,
        cache: false,
        processData: false,  // tell jQuery not to process the data
        contentType: false,  // tell jQuery not to set contentType
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