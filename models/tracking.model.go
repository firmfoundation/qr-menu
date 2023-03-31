package models

import (
	"time"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

type Tracking struct {
	ID        uuid.UUID `gorm:"type:uuid;default:uuid_generate_v4();primary_key"`
	QR        string    `json:"qr" gorm:"default:uuid_generate_v4()"`
	CreatedAt time.Time
	UpdatedAt time.Time
}

func (t *Tracking) CreateTracking(db *gorm.DB) (*Tracking, error) {
	var err error
	err = db.Debug().Create(&t).Error
	if err != nil {
		return &Tracking{}, err
	}
	return t, nil
}
