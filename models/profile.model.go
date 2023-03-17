package models

import (
	"time"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

type Profile struct {
	ID           uuid.UUID `json:"id" gorm:"type:uuid;default:uuid_generate_v4();primary_key"`
	FullName     string    `json:"full_name" gorm:"type:varchar(255);not null"`
	BusinessName string    `json:"business_name" gorm:"type:varchar(255);not null"`
	Address      string    `json:"address" gorm:"type:varchar(255);not null"`
	Email        string    `json:"email" gorm:"type:varchar(255);not null"`
	Mobile       string    `json:"mobile" gorm:"type:varchar(255);not null"`
	Logo         string    `json:"logo" gorm:"type:uuid;default:uuid_generate_v4();"`
	AccountID    uuid.UUID `json:"account_id" gorm:"type:uuid;default:uuid_generate_v4();not null"`
	Account      Account   `json:"-"`
	CreatedAt    time.Time
	UpdatedAt    time.Time
}

func (p *Profile) CreateProfile(db *gorm.DB) (*Profile, error) {
	var err error
	err = db.Debug().Create(&p).Error
	if err != nil {
		return &Profile{}, err
	}
	return p, nil
}

func (p *Profile) UpsertProfile(db *gorm.DB) (*Profile, error) {
	var err error
	err = db.Debug().Save(&p).Error
	if err != nil {
		return &Profile{}, err
	}
	return p, nil
}

func (p *Profile) UpdateProfile(db *gorm.DB) (*Profile, error) {
	var err error
	//err = db.Debug().Save(&p).Error

	err = db.Model(Profile{}).Omit("logo").Where("id = ?", p.ID).Updates(p).Error
	if err != nil {
		return &Profile{}, err
	}
	return p, nil
}

func (p *Profile) GetProfileByAccount(db *gorm.DB, account_id string) (*[]Profile, error) {
	var err error
	profile := []Profile{}
	err = db.Where("account_id = ?", account_id).Limit(1).Find(&profile).Error
	if err != nil {
		return &[]Profile{}, err
	}
	return &profile, err
}
