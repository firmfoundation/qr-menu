package util

import (
	"fmt"
	"image"
	"image/draw"
	"image/png"
	"io/ioutil"
	"log"
	"os"
	"path/filepath"

	"github.com/skip2/go-qrcode"
	d "golang.org/x/image/draw"
)

func GenQR(a string, l string) ([]byte, error) {
	ex, err := os.Executable()

	if err != nil {
		log.Fatal(err)
	}
	exPath := filepath.Dir(ex)

	//generate qr png
	q, err := qrcode.New(l, qrcode.Medium)
	if err != nil {
		panic("qr coudl not be generated")
	}

	// Optionally, disable the QR Code border.
	q.DisableBorder = true
	// q.ForegroundColor = color.RGBA{R: 0x33, G: 0x33, B: 0x66, A: 0xff}
	// q.BackgroundColor = color.RGBA{R: 0xef, G: 0xef, B: 0xef, A: 0xff}

	err = q.WriteFile(1023, exPath+"/qr-outputs/"+a+".png")
	if err != nil {
		panic("qr coudl not be generated")
	}

	imgFile1, err := os.Open("qr-template.png")
	if err != nil {
		fmt.Println(err)
	}
	imgFile2, err := os.Open(exPath + "/qr-outputs/" + a + ".png")
	if err != nil {
		fmt.Println(err)
	}

	img1, _, err := image.Decode(imgFile1)
	if err != nil {
		fmt.Println(err)
	}
	img2, _, err := image.Decode(imgFile2)
	if err != nil {
		fmt.Println(err)
	}
	//rec := image.Rect(0, 0, 400, 400)

	// Set the expected size that you want:
	dst := resize(img2, image.Point{600, 600})

	bgImg := image.NewRGBA(image.Rect(0, 0, 1200, 1800))

	draw.Draw(bgImg, img1.Bounds(), img1, image.Point{0, 0}, draw.Src)
	draw.Draw(bgImg, dst.Bounds().Add(image.Pt((600-(dst.Rect.Dx()/2)), (900-(dst.Rect.Dy()/2)))), dst, image.Point{0, 0}, draw.Src)

	out, err := os.Create("./qr-scan-outputs/" + a + ".png")
	if err != nil {
		fmt.Println(err)
	}

	png.Encode(out, bgImg)
	file, err := ioutil.ReadFile(exPath + "/qr-scan-outputs/" + a + ".png")
	if err != nil {
		return nil, err
	}

	return file, nil
}

func resize(src image.Image, dstSize image.Point) *image.RGBA {
	srcRect := src.Bounds()
	dstRect := image.Rectangle{
		Min: image.Point{0, 0},
		Max: dstSize,
	}
	dst := image.NewRGBA(dstRect)
	d.CatmullRom.Scale(dst, dstRect, src, srcRect, draw.Over, nil)
	return dst
}
