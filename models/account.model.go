package models

import (
	"time"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

type Account struct {
	ID        uuid.UUID `gorm:"type:uuid;default:uuid_generate_v4();primary_key"`
	Email     string    `json:"email" gorm:"type:varchar(255);not null;unique"`
	Password  string    `json:"-" gorm:"type:varchar(255);not null"`
	Status    int       `json:"status" gorm:"type:int;default:1"`
	CreatedAt time.Time
	UpdatedAt time.Time
}

func (a *Account) CreateAccount(db *gorm.DB) (*Account, error) {
	var err error
	err = db.Debug().Create(&a).Error
	if err != nil {
		return &Account{}, err
	}
	return a, nil
}
