package main

import (
	"time"
	// controller "github.com/amlwwalker/wingit/packages/controller"
)

//this handles interfacing with any business logic occuring elsewhere
type BusinessInterface struct {
	// CONTROLLER                  *controller.CONTROLLER
	notifier                    NotificationHandler
	PendingUploadFileName       string //the file the user wants to upload (could be selected or dragged)
	PendingUpload               string //holds the filepath that is dragged over the drop area
	CurrentSelectedContact      string //their name
	CurrentSelectedContactIndex int    //their index (if needed)
	LoggedIn                    bool
	Status                      string
	// pModel                      *PersonModel //list of contacts
	// sModel                      *PersonModel //list of searched for
	fModel *FileModel //list of files for a user
	iModel *FileModel //list of files for a user
	// dModel                      *FileModel   //list of  downloaded files
}

//handles the interface between the backend architecture
//and the bridge
func (b *BusinessInterface) configureInterface() {
	// fmt.Printf("%+v\r\n", config)
	// b.pModel = NewPersonModel(nil)
	// b.sModel = NewPersonModel(nil)
	b.fModel = NewFileModel(nil)
	b.iModel = NewFileModel(nil)
	// b.dModel = NewFileModel(nil)

}

func (b *BusinessInterface) searchForMatches(regex string, informant func(float64, bool)) {
	// //can do any preprocessing before it goes to the backend
	// modelUpdater := func(c float64, indeterminate bool) {
	// 	//if the logic is complete, then we need to update our model
	// 	//with the search results
	// 	//otherwise just inform the front end of progress
	// 	if 1.0 == c { //complete
	// 		//this is where you would add the contacts if you want async
	// 		//updates to the UI
	// 		fmt.Println("search is complete!")
	// 	}
	// 	//updates the front end
	// 	informant(c, true) //we don't know how long it will take
	// }
	// modelUpdater = modelUpdater //dummy so it doesnt complain about lack of use
	// //if we care about informing the front end how long this will take,
	// //we can use the model updater above, but requires to update the cui aswell
	// // b.sModel.ClearPeople()
	// go func() {
	// 	if sResults, err := b.CONTROLLER.SearchForContact(regex); err != nil {
	// 		fmt.Println("error searching for contact: ", err)
	// 	} else {
	// 		//now these need adding to the search results
	// 		for _, v := range sResults {
	// 			//clicking on a search result adds them to the contacts
	// 			fmt.Println("adding result ", v.UserId)
	// 			addPersonToList(v, b.sModel)
	// 		}
	// 		fmt.Println("updating front end that task is complete")
	// 	}
	// 	informant(1.0, true)
	// }()
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
