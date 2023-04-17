package models

import (
	"time"

	"github.com/google/uuid"
)

type Order struct {
	ID         uuid.UUID `gorm:"type:uuid;default:uuid_generate_v4();primary_key"`
	CustomerID uuid.UUID `json:"customer_id" gorm:"type:uuid;default:uuid_generate_v4();not null;"`
	Customer   Customer  `json:"-"`
	OrderNote  string    `json:"name" gorm:"type:varchar(255);not null"`
	Status     string    `json:"status" gorm:"type:varchar(255);"`
	CreatedAt  time.Time
	UpdatedAt  time.Time
}
