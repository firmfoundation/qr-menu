package models

import (
	"errors"
	"time"

	"github.com/google/uuid"
	"github.com/shopspring/decimal"
	"gorm.io/gorm"
)

type OrderTransaction struct {
	ID        uuid.UUID       `gorm:"type:uuid;default:uuid_generate_v4();primary_key"`
	OrderID   uuid.UUID       `json:"order_id" gorm:"type:uuid;default:uuid_generate_v4();not null;"`
	Order     Order           `json:"-"`
	MenuID    uuid.UUID       `json:"menu_id" gorm:"type:uuid;default:uuid_generate_v4();not null;"`
	Menu      Menu            `json:"-"`
	Price     decimal.Decimal `json:"price" gorm:"type:decimal(7,2);"`
	Qty       int             `json:"qty" gorm:"type:int;default:1"`
	Status    string          `json:"status" gorm:"type:varchar(255);"`
	CreatedAt time.Time
	UpdatedAt time.Time
}

type PlaceOrder struct {
	FullName  string         `json:"full_name"`
	Mobile    string         `json:"mobile"`
	Email     string         `json:"email"`
	OrderNote string         `json:"order_note"`
	Order     []OrderContent `json:"order"`
}

type OrderContent struct {
	MenuID uuid.UUID       `json:"i"`
	Price  decimal.Decimal `json:"p"`
	Qty    int             `json:"q"`
}

func (p *PlaceOrder) CreateOrder(db *gorm.DB) (*Order, error) {

	err := db.Transaction(func(tx *gorm.DB) error {
		// do some database operations in the transaction (use 'tx' from this point, not 'db')
		var err error

		//tx 1 check if customer exists
		customer := Customer{}
		if err = tx.Where("mobile = ?", p.Mobile).First(&customer).Error; err != nil {
			if errors.Is(err, gorm.ErrRecordNotFound) {
				//tx 2 create customer
				customer = Customer{
					Email:    p.Email,
					FullName: p.FullName,
					Mobile:   p.Mobile,
				}
				if err = tx.Debug().Create(&customer).Error; err != nil {
					return err
				}
			} else {
				return err
			}
		}

		//tx - 2 create order
		order := Order{
			OrderNote:  p.OrderNote,
			CustomerID: customer.ID,
		}
		if err = tx.Debug().Create(&order).Error; err != nil {
			return err
		}

		//tx3 create order transaction
		var batch []OrderTransaction
		for _, o := range p.Order {
			batch = append(batch, OrderTransaction{OrderID: order.ID, MenuID: o.MenuID, Price: o.Price, Qty: o.Qty})
		}
		if err = tx.Debug().Create(&batch).Error; err != nil {
			// return any error will rollback
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
