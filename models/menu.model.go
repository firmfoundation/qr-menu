package models

import (
	"time"

	"github.com/google/uuid"
	"github.com/shopspring/decimal"
	"gorm.io/gorm"
)

type Menu struct {
	ID          uuid.UUID       `json:"id" gorm:"type:uuid;default:uuid_generate_v4();primary_key"`
	Name        string          `json:"name" gorm:"type:varchar(255);not null"`
	Description string          `json:"description" gorm:"type:varchar(255);not null"`
	PriceS      decimal.Decimal `json:"price_s" gorm:"type:decimal(7,2);"`
	PriceL      decimal.Decimal `json:"price_l" gorm:"type:decimal(7,2);"`
	Image       string          `json:"image"`
	CategoryID  uuid.UUID       `json:"category_id" gorm:"type:uuid;default:uuid_generate_v4();not null"`
	Category    Category        `json:"category"`
	AccountID   uuid.UUID       `json:"account_id" gorm:"type:uuid;default:uuid_generate_v4();not null"`
	Account     Account         `json:"account"`
	CreatedAt   time.Time
	UpdatedAt   time.Time
}

func (m *Menu) UpsertMenu(db *gorm.DB) (*Menu, error) {
	var err error
	err = db.Debug().Save(&m).Error
	if err != nil {
		return &Menu{}, err
	}
	return m, nil
}

func (m *Menu) GetMenuByAccountId(db *gorm.DB, account_id string) []map[string]interface{} {
	var r []map[string]interface{}
	sql := `select m.id, c.name as category,m.name, m.description, m.price_s, m.price_l, m.image, c.id as category_id
	from menus as m
	inner join categories as c on m.category_id=c.id
	inner join accounts as a on m.account_id=a.id 
	where a.id=?
	order by c.name`
	db.Debug().Raw(sql, account_id).Limit(100).Find(&r)
	return r
}

func (m *Menu) GetMenuByQR(db *gorm.DB, qr string) []map[string]interface{} {
	var r []map[string]interface{}
	sql := `select m.id, c.name as category,m.name, m.description, m.price_s, m.price_l, m.image
	from menus as m
	inner join categories as c on m.category_id=c.id
	inner join accounts as a on m.account_id=a.id 
	where a.qr=?
	order by c.name`
	db.Debug().Raw(sql, qr).Limit(100).Find(&r)
	return r
}
