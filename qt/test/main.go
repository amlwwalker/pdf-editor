package main

import (
	"fmt"

	"gopkg.in/gographics/imagick.v3/imagick"
)

func main() {
	imagick.Initialize()
	defer imagick.Terminate()
	mw := imagick.NewMagickWand()
	defer mw.Destroy()
	mw.SetResolution(300, 300)
	mw.SetIteratorIndex(0) // This being the page offset
	mw.SetCompressionQuality(100)
	mw.SetImageFormat("png")
	img := mw.ReadImage("ML-MT-PH-00005.000_REV1A.pdf")
	fmt.Println(img)
	mw.WriteImage("test.png")
}

// package main

// import (
// 	"fmt"

// 	fitz "github.com/gen2brain/go-fitz"
// )

// func main() {
// 	doc, err := fitz.New("ML-MT-PH-00005.000_REV1A.pdf")
// 	if err != nil {
// 		panic(err)
// 	}
// 	fmt.Println("finished")
// 	defer doc.Close()
// }
