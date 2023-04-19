package models

import (
	"time"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

type Order struct {
	ID         uuid.UUID `gorm:"type:uuid;default:uuid_generate_v4();primary_key"`
	CustomerID uuid.UUID `json:"customer_id" gorm:"type:uuid;default:uuid_generate_v4();not null;"`
	Customer   Customer  `json:"-"`
	OrderNote  string    `json:"note" gorm:"type:varchar(255);"`
	Status     string    `json:"status" gorm:"type:varchar(255);default:pending"`
	CreatedAt  time.Time
	UpdatedAt  time.Time
}

func (p *Order) GetOrderByStatus(db *gorm.DB, account_id string, status string) ([]map[string]interface{}, error) {
	var f []map[string]interface{}
	sql := `
	select o.id, c.full_name, c.mobile,m.name, t.price, t.qty,o.order_note,o.status from orders as o
	join customers as c on c.id = o.customer_id
	join order_transactions t on t.order_id = o.id
	join menus m on m.id = t.menu_id and m.account_id=?
	where o.status=?
	order by o.id
	`
	err := db.Debug().Raw(sql, account_id, status).First(&f).Error
	if err != nil {
		return nil, err
	}
	return f, nil
}
