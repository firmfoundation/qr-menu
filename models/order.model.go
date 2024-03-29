package models

import (
	"errors"
	"time"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

type Order struct {
	ID          uuid.UUID `gorm:"type:uuid;default:uuid_generate_v4();primary_key"`
	CustomerID  uuid.UUID `json:"customer_id" gorm:"type:uuid;default:uuid_generate_v4();not null;"`
	Customer    Customer  `json:"-"`
	OrderNote   string    `json:"note" gorm:"type:varchar(255);"`
	PaymentType string    `json:"payment_type" gorm:"type:varchar(255);"`
	Status      string    `json:"status" gorm:"type:varchar(255);default:pending"`
	CreatedAt   time.Time
	UpdatedAt   time.Time
}

func (p *Order) GetOrdersDetail(db *gorm.DB, account_id string, id string) ([]map[string]interface{}, error) {
	var f []map[string]interface{}
	sql := `
	select o.id, c.full_name, c.mobile,m.name, t.price, t.qty,o.order_note,o.payment_type,o.status from orders as o
	join customers as c on c.id = o.customer_id
	join order_transactions t on t.order_id = o.id
	join menus m on m.id = t.menu_id and m.account_id=?
	where o.id=?
	order by o.id
	`
	err := db.Debug().Raw(sql, account_id, id).First(&f).Error
	if err != nil {
		return nil, err
	}
	return f, nil
}

func (p *Order) GetOrderByStatus(db *gorm.DB, account_id string, status string) ([]map[string]interface{}, error) {
	var f []map[string]interface{}
	sql := `
	select o.id, c.full_name, c.mobile, sum(t.price * t.qty) as total,o.payment_type,o.status from orders as o
	join customers as c on c.id = o.customer_id
	join order_transactions t on t.order_id = o.id
	join menus m on m.id = t.menu_id and m.account_id=?
	where o.status=?
	group by o.id,c.full_name,c.mobile,o.payment_type,o.status
	order by o.id
	`
	err := db.Debug().Raw(sql, account_id, status).First(&f).Error
	if err != nil {
		return nil, err
	}
	return f, nil
}

func (o *Order) UpdateOrder(db *gorm.DB) (*Order, error) {

	err := db.Transaction(func(tx *gorm.DB) error {
		// do some database operations in the transaction (use 'tx' from this point, not 'db')
		var err error

		//tx 1 check if status is not complete
		order := &Order{}
		if err = tx.Where("id = ? and status != ?", o.ID, "completed").First(&order).Error; err != nil {
			if errors.Is(err, gorm.ErrRecordNotFound) {
				return err
			} else {
				return err
			}
		}

		//tx - 2 update order status
		if err = tx.Model(Order{}).Where("id = ?", o.ID).Update("status", o.Status).Error; err != nil {
			return err
		}

		// return nil will commit the whole transaction
		return nil
	})

	if err != nil {
		return &Order{}, err
	}

	return &Order{}, nil
}
