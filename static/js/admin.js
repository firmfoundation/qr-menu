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
      alert(a)
      break;
  }
}

const getSuccess = (tag) => {
  $(".div-menu").append(tag)
}

const pMenu = () => {
  var div_main = document.createElement('div');
  var div_menu = document.createElement('div');
  $(div_menu).addClass('div-menu')
  getMenu("d0427599-f7ac-4a6e-b6fe-f04e52ee7d5b");

  $(div_main).append(div_menu)
  $(".page-content").append(div_main)
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

const renderMenu = (s) => {
  var tbody = document.createElement('tbody');
  $.each(s, function( key, v ) {
      $(tbody).append(
          `<tr id="row-${v.id}")>
            <td>${v.category}</td>
            <td>${v.name}</td>
            <td>${v.description}</td>
            <td>${v.price}</td>
            <td><img src="/static/menu/img/coffee.jpg" id="bashanka" class="rounded" width="50"></td>
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
            <th scope="col">Image</th>
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
      <h5 class="card-title">Survey</h5>
      <h6 class="card-subtitle mb-2 text-muted">Menu Items</h6>
    `
  )
  $(card).append(cardBody)
  $(card).append(table)
  
  return card
  //$("#left-col").append(card)
}