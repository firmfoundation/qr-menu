package initdb

import (
	"fmt"

	"github.com/firmfoundation/qrmenu/models"
)

func Migrate() {
	DB.AutoMigrate(
		&models.Category{},
	)

	fmt.Println(" Migration complete")
}
