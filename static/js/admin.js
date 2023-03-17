let Dashboard = (() => {
    let global = {
      tooltipOptions: {
        placement: "right" },
  
      menuClass: ".c-menu" };
  
  
    let menuChangeActive = el => {
      let hasSubmenu = $(el).hasClass("has-submenu");
      $(global.menuClass + " .is-active").removeClass("is-active");
      $(el).addClass("is-active");
  
      // if (hasSubmenu) {
      // 	$(el).find("ul").slideDown();
      // }
    };
  
    let sidebarChangeWidth = () => {
      let $menuItemsTitle = $("li .menu-item__title");
  
      $("body").toggleClass("sidebar-is-reduced sidebar-is-expanded");
      $(".hamburger-toggle").toggleClass("is-opened");
  
      if ($("body").hasClass("sidebar-is-expanded")) {
        $('[data-toggle="tooltip"]').tooltip("destroy");
      } else {
        $('[data-toggle="tooltip"]').tooltip(global.tooltipOptions);
      }
  
    };
  
    return {
      init: () => {
        $(".js-hamburger").on("click", sidebarChangeWidth);
  
        $(".js-menu li").on("click", e => {
          menuChangeActive(e.currentTarget);
        });
  
        //$('[data-toggle="tooltip"]').tooltip(global.tooltipOptions);
      } };
  
})();
  
Dashboard.init();

const m = (a) => {
  switch (a) {
    case 0:
      pMenu()
      break
    case 1:
      pSetting()
      break;
  }
}

const getSuccess = (tag) => {
  $(".div-menu").append(tag)
}

const getS = (tag) => {
  $(".div-pan").append(tag)
}

const pSetting = () => {
  $(".page-title").empty()
  $(".page-title").append("Settings")
  $(".content").empty()

  var div_main = document.createElement('div');
  $(div_main).addClass('page-content')
  var div_form = document.createElement('div');
  $(div_form).addClass('div-form')
  getProfile("d0427599-f7ac-4a6e-b6fe-f04e52ee7d5b")
  $(div_main).append(div_form)
  $(".content").append(div_main)
}

const pMenu = () => {
  $(".page-title").empty()
  $(".page-title").append("QR Menu")
  $(".content").empty()

  let div_menu_pan = document.createElement('div');
  $(div_menu_pan).addClass('div-menu-pan page-content')
  $(div_menu_pan).append(
    `
    <button type="button" class="btn btn-secondary btn-sm" id="btn-create" onClick="showMenuForm();">Create Menu</button>
    `
  )
  $(".content").append(div_menu_pan)


  var div_main = document.createElement('div');
  $(div_main).addClass('page-content')
  var div_menu = document.createElement('div');
  $(div_menu).addClass('div-menu')
  getMenu("d0427599-f7ac-4a6e-b6fe-f04e52ee7d5b");

  $(div_main).append(div_menu)
  $(".content").append(div_main)

  //getQr("d0427599-f7ac-4a6e-b6fe-f04e52ee7d5b")
  let div_qr_pan = document.createElement('div');
  $(div_qr_pan).addClass('page-content')
  rQr(div_qr_pan)
  $(".content").append(div_qr_pan)
}

const showMenuForm = () => {
  $(".div-menu-pan").empty()
  formMenu($(".div-menu-pan"))
  //$(".content").append(div_menu_pan)
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

const getMenu = (id) => {
  $.ajax({
    url: `/accounts/menus?account_id=${id}`,
    type: 'GET',
    contentType: 'application/json',
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

const getProfile = (id) => {
  $.ajax({
    url: `/admin/profiles?account_id=${id}`,
    type: 'GET',
    contentType: 'application/json',
    success: function (response) {
      var json = JSON.parse(response);
      formSetting(json)
    },
    error: function (response) {
        //console.log(response)
    }
  })             
} 
const um = (p1, p2, p3, p4, p5) => {
  formMu($(".div-menu-pan"), p1, p2, p3, p4, p5)
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
            <td>${v.price}</td>
            <td>
              <button type="button" class="btn btn-success"
                      style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem;" onClick="um('${v.id}','${v.name}', '${clean(v.description)}', '${v.price}', '${v.category_id}');">
                update
              </button>
              <button type="button" class="btn btn-danger"
                      style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem;" onClick="dm(${v.id})">
                delete
              </button>
            </td>
          </tr>`
      )
  });

  var table = document.createElement('table');
  $(table).addClass('table table-sm table-hover')
  $(table).append(
        `<thead>
          <tr>
            <th scope="col">Category</th>
            <th scope="col">Item name</th>
            <th scope="col">Description</th>
            <th scope="col">Price</th>
            <th scope="col">Action</th>
          </tr>
        </thead>`
  );
  $(table).append(tbody)

  var card = document.createElement('card');
  $(card).addClass('card')

  var cardBody = document.createElement('div')
  $(cardBody).addClass('card-body')
  $(cardBody).append(
    `
      <h5 class="card-title">Menu items</h5>
      <h6 class="card-subtitle mb-2 text-muted">Menu itmes are listed here. You can add new or update existing menu items.</h6>
    `
  )
  $(card).append(cardBody)
  $(card).append(table)
  
  return card
}

const formMenu = async (tag) => {
  $(tag).empty();
  $(tag).append(`
      <div class="container-sm">
          <h5 class="card-title mb-3">Create menu items</h5>
          <div id="left-col" class="cs-1 was-validated justify-content-center">
              <div class="select-menu-cat form-floating mb-3 w-50"></div>

              <div class="form-floating mb-3 w-50  was-validated">
                  <input type="text" class="form-control form-control-sm" id="m-name" value="" size="10" required>
                  <label for="m-name" class="form-label">menu item name</label>
                  <div class="invalid-feedback">menu item name required </div>
              </div>

              <div class="form-floating mb-3 w-50  was-validated">
                  <input type="text" class="form-control form-control-sm" id="m-desc" value="" size="10" required>
                  <label for="question" class="form-label">Description</label>
                  <div class="invalid-feedback">menu description required </div>
              </div>

              <div class="form-floating mb-3 w-50  was-validated">
                  <input type="text" class="form-control form-control-sm" id="m-price" value="" size="10" required>
                  <label for="question" class="form-label">Price</label>
                  <div class="invalid-feedback">menu price required </div>
              </div>

              <div class="mt-3">
                  <button type="button" class="btn btn-warning btn-sm" id="btn-menu-create" onClick="um();">Create Menu</button>
              </div>            
          </div>
      </div>
  `)
  let res = await getCategory();
  if(res != "") {
    let json = JSON.parse(res);
    listCategory(json)
  }
}

const formMu = async (tag, p1, p2, p3, p4, p5) => {
  $(tag).empty();
  $(tag).append(`
      <div class="container-sm">
          <h5 class="card-title mb-3">Update menu item</h5>
          <div id="left-col" class="cs-1 was-validated justify-content-center">
              <div class="select-menu-cat form-floating mb-3 w-50"></div>

              <div class="form-floating mb-3 w-50  was-validated">
                  <input type="text" class="form-control form-control-sm" id="m-name" value="${p2}" size="10" required>
                  <label for="m-name" class="form-label">menu item name</label>
                  <div class="invalid-feedback">menu item name required </div>
              </div>

              <div class="form-floating mb-3 w-50  was-validated">
                  <input type="text" class="form-control form-control-sm" id="m-desc" value="${p3}" size="10" required>
                  <label for="question" class="form-label">Description</label>
                  <div class="invalid-feedback">menu description required </div>
              </div>

              <div class="form-floating mb-3 w-50  was-validated">
                  <input type="text" class="form-control form-control-sm" id="m-price" value="${p4}" size="10" required>
                  <label for="question" class="form-label">Price</label>
                  <div class="invalid-feedback">menu price required </div>
              </div>

              <div class="mt-3">
                  <button type="button" class="btn btn-success btn-sm" id="btn-menu-update" onClick="updateMenu('${p1}');">Update</button>
              </div>            
          </div>
      </div>
  `)
  let res = await getCategory();
  if(res != "") {
    var json = JSON.parse(res);
    listCategory(json)
    $('.list-menu').val(p5);
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
  $(select).addClass('list-menu form-select')
  $(select).append(`<option value="" selected>-Select Category-</option>`)
  $.each(itm, function( key, v ) {
      $(select).append(
          `<option value="${v.ID}">${v.name}</option>`
      )
  });
 

  $(".select-menu-cat").append(select);
  $(".select-menu-cat").append(
      `<label for="list-category" class="form-label">Menu Category</label>
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
      price: Number($("#m-price").val()),
      account_id: "26405e9b-367f-429b-96fd-1bfc5d214c19"  //remove this and  get it from jwt at backend 
  };

  $.ajax({
      url: '/admin/menus',
      type: 'POST',
      contentType: 'application/json',
      data: JSON.stringify(payload),
      success: function (response) {
         alert("Menu item created successfully!")
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
      price: Number($("#m-price").val()),
      id,
      account_id: "26405e9b-367f-429b-96fd-1bfc5d214c19"  //remove this and  get it from jwt at backend 
  };

  $.ajax({
      url: '/admin/menus',
      type: 'POST',
      contentType: 'application/json',
      data: JSON.stringify(payload),
      success: function (response) {
         alert("Menu updated successfully!")
      },
      error: function (response) {
          alert("error")
      }
  })
}

const updateProfile = (id) => {
  console.log(id)
  var payload = {
      business_name: $("#m-1").val(),
      address: $("#m-2").val(),
      mobile: $("#m-3").val(),
      email: $("#m-4").val(),
      full_name: $("#m-5").val(),
      id: String(id),
      account_id: "d0427599-f7ac-4a6e-b6fe-f04e52ee7d5b",  //remove this and  get it from jwt at backend 
      //logo: "d0427599-f7ac-4a6e-b6fe-f04e52ee7d5b"
  };

  $.ajax({
      url: '/admin/profiles',
      type: 'POST',
      contentType: 'application/json',
      data: JSON.stringify(payload),
      success: function (response) {
         alert("Profile updated successfully!")
      },
      error: function (response) {
          alert("error")
      }
  })
}


const formSetting = async (a) => {
  console.log(a[0])
  $($(".div-form")).empty();
  $($(".div-form")).append(`
      <div class="container-sm">
          <h5 class="card-title mb-3">Update profile</h5>
          <div id="left-col" class="cs-1 was-validated justify-content-center">
              <div class="form-floating mb-3 w-50  was-validated">
                  <input type="text" class="form-control form-control-sm" id="m-1" value="${a[0].business_name}" size="10" required>
                  <label for="m-name" class="form-label">Business name</label>
                  <div class="invalid-feedback">business name required </div>
              </div>

              <div class="form-floating mb-3 w-50  was-validated">
                  <input type="text" class="form-control form-control-sm" id="m-2" value="${a[0].address}" size="10" required>
                  <label for="question" class="form-label">Address</label>
                  <div class="invalid-feedback">address required </div>
              </div>

              <div class="form-floating mb-3 w-50  was-validated">
                  <input type="text" class="form-control form-control-sm" id="m-3" value="${a[0].mobile}" size="10" required>
                  <label for="question" class="form-label">Mobile</label>
                  <div class="invalid-feedback">mobile required </div>
              </div>

              <div class="form-floating mb-3 w-50  was-validated">
                  <input type="text" class="form-control form-control-sm" id="m-4" value="${a[0].email}" size="10" required>
                  <label for="question" class="form-label">Email</label>
                  <div class="invalid-feedback">email required </div>
              </div>

              <div class="form-floating mb-3 w-50  was-validated">
                  <input type="text" class="form-control form-control-sm" id="m-5" value="${a[0].full_name}" size="10" required>
                  <label for="question" class="form-label">Contact person</label>
                  <div class="invalid-feedback">field required required </div>
              </div>

              <div class="mt-3">
                  <button type="button" class="btn btn-success btn-sm" id="btn-menu-update" onClick="updateProfile('${a[0].id}');">Update</button>
              </div>            
          </div>
      </div>
  `)
}