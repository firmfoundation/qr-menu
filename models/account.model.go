package models

import (
	"errors"
	"fmt"
	"time"

	"github.com/firmfoundation/qrmenu/pkg/auth"
	"github.com/google/uuid"
	"github.com/jackc/pgerrcode"
	"github.com/jackc/pgx/v5/pgconn"
	"golang.org/x/crypto/bcrypt"
	"gorm.io/gorm"
)

type DuplicateError struct {
	code    string
	message string
}

type NotExistsError struct {
	code    string
	message string
}

type IncorrectPasswordError struct {
	code    string
	message string
}

func (e *DuplicateError) Error() string {
	return fmt.Sprintf("error code : %v", e.code)
}

func (e *NotExistsError) Error() string {
	return fmt.Sprintf("error code : %v", e.code)
}

func (e *IncorrectPasswordError) Error() string {
	return fmt.Sprintf("error code : %v", e.code)
}

type Account struct {
	ID        uuid.UUID `gorm:"type:uuid;default:uuid_generate_v4();primary_key"`
	Email     string    `json:"email" gorm:"type:varchar(255);not null;unique"`
	Password  string    `json:"password" gorm:"type:varchar(255);not null" validate:"gte=6,lte=19"`
	QR        string    `json:"qr" gorm:"unique;default:uuid_generate_v4()"`
	Status    int       `json:"status" gorm:"type:int;default:1"`
	CreatedAt time.Time
	UpdatedAt time.Time
}

func (a *Account) GetAccountById(db *gorm.DB) (*Account, error) {
	var err error
	account := Account{}
	err = db.Where("id = ?", a.ID).First(&account).Error
	if err != nil {
		return &Account{}, err
	}
	return &account, err
}

func (a *Account) CreateAccount(db *gorm.DB) (*Account, error) {
	var err error
	//hash the password  "People talk things not reasonable but you need not worry"
	pass := []byte(a.Password)
	hash, err := bcrypt.GenerateFromPassword(pass, bcrypt.DefaultCost)
	if err != nil {
		return &Account{}, err
	}

	//update pass
	a.Password = string(hash)

	err = db.Debug().Create(&a).Error
	if err != nil {
		var pgErr *pgconn.PgError
		if errors.As(err, &pgErr) && pgErr.Code == pgerrcode.UniqueViolation {
			return &Account{}, &DuplicateError{code: pgErr.Code, message: pgErr.Message}
		}
		return &Account{}, err
	}
	return a, nil
}

/*
authenticate accounts checks user name and password
if valid it will respond with jwt or error
*/
func (a *Account) AuthenticateAccount(db *gorm.DB) (auth.Jwt, error) {
	var err error
	db_account := &Account{}
	err = db.Debug().Where("email = ?", a.Email).First(&db_account).Error
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return auth.Jwt{}, &NotExistsError{code: "E11", message: err.Error()}
		}
	}

	//check password hash
	err = bcrypt.CompareHashAndPassword([]byte(db_account.Password), []byte(a.Password))
	if err != nil {
		return auth.Jwt{}, &IncorrectPasswordError{code: "E00", message: err.Error()}
	}

	au := auth.Auth{}
	jwt, err := au.GetJwt(db_account.ID.String())
	if err != nil {
		return auth.Jwt{}, err
	}
	return auth.Jwt{JWT: jwt}, nil
}
