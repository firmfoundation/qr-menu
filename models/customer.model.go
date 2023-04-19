package models

import (
	"time"

	"github.com/google/uuid"
)

type Customer struct {
	ID        uuid.UUID `gorm:"type:uuid;default:uuid_generate_v4();primary_key"`
	Email     string    `json:"email"`
	Password  string    `json:"password"`
	FullName  string    `json:"first_name" gorm:"type:varchar(255);not null;"`
	Mobile    string    `json:"mobile" gorm:"type:varchar(255);not null;"`
	Status    string    `json:"status" gorm:"type:varchar(255);default:0"`
	CreatedAt time.Time
	UpdatedAt time.Time
}
