package auth

import (
	"fmt"

	"github.com/go-chi/jwtauth"
)

type Auth struct{}

type Jwt struct {
	JWT string `json:"jwt_token"`
}

var tokenAuth *jwtauth.JWTAuth

func (a *Auth) GetJwt(id string) (string, error) {
	tokenAuth = jwtauth.New("HS256", []byte("secret"), nil)

	_, tokenString, err := tokenAuth.Encode(map[string]interface{}{"account_id": id})
	if err != nil {
		return "", err
	}
	fmt.Printf("DEBUG: a sample jwt is %s\n\n", tokenString)
	return tokenString, nil
}
