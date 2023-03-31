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
	)

	fmt.Println(" Migration complete")
}
