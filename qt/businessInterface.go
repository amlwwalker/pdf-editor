package main

import (
	"time"
	// controller "github.com/amlwwalker/wingit/packages/controller"
)

//this handles interfacing with any business logic occuring elsewhere
type BusinessInterface struct {
	// CONTROLLER                  *controller.CONTROLLER
	PendingUploadFileName       string //the file the user wants to upload (could be selected or dragged)
	PendingUpload               string //holds the filepath that is dragged over the drop area
	CurrentSelectedContact      string //their name
	CurrentSelectedContactIndex int    //their index (if needed)
	LoggedIn                    bool
	Status                      string
	fModel                      *FileModel //list of files for a user
	iModel                      *FileModel //list of files for a user
}

//handles the interface between the backend architecture
//and the bridge
func (b *BusinessInterface) configureInterface() {
	b.fModel = NewFileModel(nil)
	b.iModel = NewFileModel(nil)

}

//the interface needs to know how to inform the front end on progress
//so takes a function that takes a value that the front end will use
func (b *BusinessInterface) startAsynchronousRoutine(informant func(float64, bool)) {
	//on a go routine, count up to 10
	//each tick, inform the front end of your percentage progress
	//when it reaches ten, inform the front end it is complete

	go func() {
		var c float64
		c = 0.0
		for c < 1.0 {
			informant(c, false) //we know how long this process will take
			time.Sleep(1 * time.Second)
			c = c + 0.1
		}
		return
	}()
}
