package initdb

import (
	"fmt"

	"github.com/firmfoundation/qrmenu/models"
)

func Migrate() {
	DB.AutoMigrate(
		&models.Account{},
		&models.ChangePassword{},
		&models.Profile{},
		&models.Category{},
		&models.Menu{},
		&models.Tracking{},
		&models.Customer{},
		&models.Order{},
		&models.OrderTransaction{},
	)

	fmt.Println(" Migration complete")
}
