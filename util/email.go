package util

import (
	"fmt"
	"log"
	"os"
	"path/filepath"

	"net/smtp"

	"github.com/joho/godotenv"
)

func SendEmail(email_to string, link string) {
	// ex, err := os.Executable()

	// if err != nil {
	// 	log.Fatal(err)
	// }
	// exPath := filepath.Dir(ex)

	// env, e := godotenv.Read(exPath + "/app.env")
	env, e := godotenv.Read("./app.env")
	if e != nil {
		log.Fatalf("Error loading .env file")
	}

	// Choose auth method and set it up

	auth := smtp.PlainAuth("", env["EMAIL"], env["EMAIL_PASSWORD"], "smtp.gmail.com")

	// Here we do it all: connect to our server, set up a message and send it

	to := []string{email_to}

	msg := []byte("To: " + email_to + "\r\n" +

		"Subject: Forgot your password?\r\n" +

		"\r\n" +

		"Hi \r\n" +

		"\r\n" +

		"There was a request to change your password!\r\n" +
		"\r\n" +
		"If you did not make this request then please ignore this email.\r\n" +
		"\r\n" +
		"Otherwise, please click this link below to change your password: \r\n" +

		"\r\n" +

		env["EMAIL_RESET_DOMAIN"] + link)

	err := smtp.SendMail("smtp.gmail.com:587", auth, env["EMAIL"], to, msg)

	if err != nil {

		log.Fatal(err)

	}

}

func SendWelcomeEmail(email_to string, otp int) {
	ex, err := os.Executable()

	if err != nil {
		log.Fatal(err)
	}
	exPath := filepath.Dir(ex)

	env, e := godotenv.Read(exPath + "/app.env")
	if e != nil {
		log.Fatalf("Error loading .env file")
	}

	// Choose auth method and set it up

	auth := smtp.PlainAuth("", env["EMAIL"], env["EMAIL_PASSWORD"], "smtp.gmail.com")

	// Here we do it all: connect to our server, set up a message and send it

	to := []string{email_to}

	msg := []byte("To: " + email_to + "\r\n" +
		"Subject: 🤓️ ወደ Qrchaka እንኳን በደህና መጡ 😍️\r\n" +

		"\r\n" +

		"ሰላም 👋️ \r\n" +

		"\r\n" +

		"በመጀመርያ በ Qrchaka ለመጠቀም ስለተመዘገቡ እጅግ ከልብ እናመሰግናለን !\r\n" +
		"\r\n" +
		"በመቀጠል ምዝገባውን ለመጨርሰ እቦኮትን የሚከተለውን ቁጥር " + fmt.Sprint(otp) + "\r\n" +
		"በ qrchaka.com ውስጥ ኢሜሎን ያረጋግጡ በሚለው መጥይቅ ውስጥ ያስገቡት:: \r\n" +

		"\r\n" +

		"እናመሰግናለን !\r\n" +

		"\r\n" +

		"🚀️ Qrchaka ቡድን !")

	err = smtp.SendMail("smtp.gmail.com:587", auth, env["EMAIL"], to, msg)

	if err != nil {

		log.Fatal(err)

	}

}

func SendToAdminNewAccount(new_email string) {
	ex, err := os.Executable()

	if err != nil {
		log.Fatal(err)
	}
	exPath := filepath.Dir(ex)

	env, e := godotenv.Read(exPath + "/app.env")
	if e != nil {
		log.Fatalf("Error loading .env file")
	}

	// Choose auth method and set it up

	auth := smtp.PlainAuth("", env["EMAIL"], env["EMAIL_PASSWORD"], "smtp.gmail.com")

	// Here we do it all: connect to our server, set up a message and send it

	to := []string{env["ADMIN_EMAIL"]}

	msg := []byte("To: " + env["ADMIN_EMAIL"] + "\r\n" +
		"Subject: 🚀️ New user registered !\r\n" +

		"\r\n" +

		"Hi Admin 👋️ \r\n" +

		"\r\n" +

		"New user account with email address : " + new_email + " Just registered !\r\n" +
		"\r\n" +

		"🤓️ System")

	err = smtp.SendMail("smtp.gmail.com:587", auth, env["EMAIL"], to, msg)

	if err != nil {

		log.Fatal(err)

	}

}
