package main

import (
	"fmt"
	"net/http"

	"github.com/firmfoundation/qrmenu/handles"
	"github.com/firmfoundation/qrmenu/util"
	"github.com/go-chi/chi"
	"github.com/go-chi/chi/middleware"
	"github.com/go-chi/jwtauth"
)

var tokenAuth *jwtauth.JWTAuth

func init() {
	tokenAuth = jwtauth.New("HS256", []byte("secret"), nil)

	/*
	 For debugging only
	 comment it
	*/
	_, tokenString, _ := tokenAuth.Encode(map[string]interface{}{"user_id": 1236})
	fmt.Printf("DEBUG: a sample jwt is %s\n\n", tokenString)
}

func router() http.Handler {
	r := chi.NewRouter()
	r.Use(middleware.Logger)

	//protected routes
	r.Group(func(r chi.Router) {
		// Seek, verify and validate JWT tokens
		r.Use(jwtauth.Verifier(tokenAuth))

		// Handle valid / invalid tokens.
		r.Use(jwtauth.Authenticator)

		r.Method("GET", "/dashboard", Handler(handles.HandleAdminTemplate))
		r.Method("GET", "/accounts/menus", Handler(handles.HandleGetMenuByAccountId))
		r.Method("POST", "/accounts/changepasswords/change", Handler(handles.HandleAccountChangePassword))
		r.Method("POST", "/accounts/themes", Handler(handles.HandleUpdateTheme))

		//create menu
		r.Method("POST", "/admin/menus", Handler(handles.HandleUpsertMenu))
		r.Method("POST", "/admin/menus/images", Handler(handles.HandleMenuImage))
		r.Method("DELETE", "/admin/menus", Handler(handles.HandleDeleteMenu))

		// profile
		r.Method("POST", "/admin/profiles", Handler(handles.HandleUpsertProfile))
		r.Method("GET", "/admin/profiles", Handler(handles.HandleGetProfileByAccount))
		r.Method("POST", "/admin/profiles/logos", Handler(handles.HandleProfileLogo))
		//QR
		r.Method("GET", "/admin/menus/qr", Handler(handles.HandleGenQR))

		//orders
		r.Method("GET", "/menus/orders", Handler(handles.HandleGetOrders))
		r.Method("GET", "/admin/orders/detail", Handler(handles.HandleGetOrdersDetail))
		r.Method("POST", "/admin/orders/update", Handler(handles.HandleOrderUpdate))

	})

	r.Group(func(r chi.Router) {
		r.Method("GET", "/", Handler(handles.HandleRootIndexTemplate))
		//r.Method("GET", "/admin", Handler(IndexAdmin))
		r.Method("GET", "/admin", Handler(handles.HandleRootTemplate))
		r.Method("GET", "/login", Handler(handles.HandleLoginTemplate))
		r.Method("GET", "/cp-req", Handler(handles.HandleCPRequestTemplate))
		r.Method("GET", "/cp/{jwt}", Handler(handles.HandleCPTemplate))

		//account
		r.Method("POST", "/accounts", Handler(handles.HandleCreateAccount))
		r.Method("POST", "/accounts/authenticate", Handler(handles.HandleAuthenticateAccount))
		r.Method("POST", "/accounts/changepasswords/request", Handler(handles.HandleChangePasswordRequest))

		r.Method("GET", "/accounts/menus/qr", Handler(handles.HandleGetMenuByQR))
		r.Method("GET", "/accounts/menus/category", Handler(handles.HandleGetMenuByQRAndCat))
		//profile
		r.Method("GET", "/profiles/qr", Handler(handles.HandleGetProfileByQR))

		//category
		r.Method("GET", "/categories", Handler(handles.HandleGetCategoryByQR))
		r.Method("POST", "/admin/categories", Handler(handles.HandleCreateCategory))
		r.Method("GET", "/admin/categories", Handler(handles.HandleGetAllCategory))

		r.Method("GET", "/menus/{uid}", Handler(handles.ThemeTemplate))

		//for testing new theme
		//r.Method("GET", "/menus2/{uid}", Handler(handles.Menu2Template))

		//order
		r.Method("POST", "/orders", Handler(handles.HandleCreateOrder))

	})

	//public folder for assets
	fs := http.FileServer(http.Dir(util.AppPath() + "/static"))
	r.Handle("/static/*", http.StripPrefix("/static/", fs))

	return r
}
