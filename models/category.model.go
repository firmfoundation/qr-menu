package models

import (
	"time"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

type Category struct {
	ID        uuid.UUID `gorm:"type:uuid;default:uuid_generate_v4();primary_key"`
	Name      string    `json:"name" gorm:"type:varchar(255);not null"`
	CreatedAt time.Time
	UpdatedAt time.Time
}

func (s *Category) CreateCategory(db *gorm.DB) (*Category, error) {

	var err error
	err = db.Debug().Create(&s).Error
	if err != nil {
		return &Category{}, err
	}
	return s, nil
}

func (q *Category) GetAllCategory(db *gorm.DB) (*[]Category, error) {
	var err error
	category := []Category{}
	err = db.Debug().Limit(100).Find(&category).Error
	if err != nil {
		return &[]Category{}, err
	}
	return &category, err
}

func (q *Category) GetCategoryByQR(db *gorm.DB, qr string) []map[string]interface{} {
	var r []map[string]interface{}
	sql := `select c.name as category, count(c.name) as items from menus as m
	inner join categories as c on m.category_id=c.id
	inner join accounts as a on m.account_id=a.id 
	where a.qr=?
	group by c.name
	order by c.name`
	db.Debug().Raw(sql, qr).Limit(100).Find(&r)
	return r
}
