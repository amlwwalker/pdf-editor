import QtQuick 2.6
import QtQuick.Layouts 1.3
// import QtQuick.Controls 1.4
import QtQuick.Controls 2.4
// import QtQuick.Controls 1.4 as QQC1
// import QtQuick.Controls.Styles 1.4
import QtQuick.Controls.Material 2.0
import QtQuick.Controls.Universal 2.0
import Qt.labs.settings 1.0
import QtQuick.Dialogs 1.0
import "elements"
Item {
    id: window
    width: 900
    height: 700
    visible: true
    property int xpos
    property int ypos
    property bool painting: false
    property int brushSize: 35
    property string brushColor: "red"
    property bool mousePressed: false
    property string currentlySelectedFilePath: ""
    property string currentlySelectedFileName: ""
         ToolBar {
            id: toolbar
            Material.foreground: "white"
            Material.background: Material.BlueGrey
             z: 100
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            RowLayout {
                spacing: 20
                anchors.fill: parent
	            ToolButton {
	                contentItem: Image {
	                    fillMode: Image.Pad
	                    horizontalAlignment: Image.AlignHCenter
	                    verticalAlignment: Image.AlignVCenter
	                    source: "images/FA/black/png/22/wrench.png"
	                }
	                onClicked: {
                        setWorkingDirectory.open()
	                }
	            }                
	            ToolButton {
	                contentItem: Image {
	                    fillMode: Image.Pad
	                    horizontalAlignment: Image.AlignHCenter
	                    verticalAlignment: Image.AlignVCenter
	                    source: "images/FA/black/png/22/file-pdf-o.png"
	                }
	                onClicked: {
                        drawer.open()
	                }
	            }
                ToolButton {
                    contentItem: Image {
                        id: paintButton
                        fillMode: Image.Pad
                        horizontalAlignment: Image.AlignHCenter
                        verticalAlignment: Image.AlignVCenter
                        source: "images/FA/black/png/22/paint-brush.png"
                    }
                    onClicked: {
                        painting = !painting
                        if (painting) {
                            paintButton.source = "images/FA/white/png/22/paint-brush.png"
                        } else {
                            paintButton.source = "images/FA/black/png/22/paint-brush.png"
                        }
                    }
                }
                ToolButton {
                    contentItem: Image {
                        fillMode: Image.Pad
                        horizontalAlignment: Image.AlignHCenter
                        verticalAlignment: Image.AlignVCenter
                        source: "images/FA/black/png/22/plus.png"
                    }
                    onClicked: {
                    brushSize += 5
                    }
                }
                ToolButton {
                    contentItem: Image {
                            fillMode: Image.Pad
                            horizontalAlignment: Image.AlignHCenter
                            verticalAlignment: Image.AlignVCenter
                            source: "images/FA/black/png/22/minus.png"
                    }
                    onClicked: {
                    brushSize -= 5
                    }
                }
                Label {
                    id: brushSizeLabel
                    text: brushSize
                    font.pixelSize: 20
                    elide: Label.ElideRight
                    horizontalAlignment: Qt.AlignHCenter
                    verticalAlignment: Qt.AlignVCenter
                }
                ToolButton {
                    contentItem: Rectangle {
                        id: redColor
                        width: 100
                        height: 100
                        color: "red"
                        border.width: 0
                        border.color: "black"
                    }
                    onClicked: {
                        brushColor = "red"
                        redColor.border.width = 3
                        greenColor.border.width = 0
                        whiteColor.border.width = 0
                    }
                }
                ToolButton {
                    contentItem: Rectangle {
                        id: greenColor
                        width: 100
                        height: 100
                        color: "green"
                        border.width: 0
                        border.color: "black"
                    }
                    onClicked: {
                        brushColor = "green"
                        greenColor.border.width = 3
                        redColor.border.width = 0
                        whiteColor.border.width = 0
                    }
                }
                ToolButton {
                    contentItem: Rectangle {
                        id: whiteColor
                        width: 100
                        height: 100
                        color: "white"
                        border.width: 0
                        border.color: "black"
                    }
                    onClicked: {
                        brushColor = "white"
                        whiteColor.border.width = 3
                        greenColor.border.width = 0
                        redColor.border.width = 0                        
                    }
                }
                ToolButton {
                    id: clearCanvas
                    contentItem: Image {
                        fillMode: Image.Pad
                        horizontalAlignment: Image.AlignHCenter
                        verticalAlignment: Image.AlignVCenter
                        source: "images/FA/black/png/22/eraser.png"
                    }
                    onClicked: {
                        painting = false
                        paintButton.source = "images/FA/black/png/22/paint-brush.png"
                        myCanvas.clear()
                    }
                }
                ToolButton {
                    id: settingsViewer
                    contentItem: Image {
                        fillMode: Image.Pad
                        horizontalAlignment: Image.AlignHCenter
                        verticalAlignment: Image.AlignVCenter
                        source: "images/FA/black/png/22/save.png"
                    }
                    onClicked: {
                        painting = false
                        paintButton.source = "images/FA/black/png/22/paint-brush.png"
                // var urlNoProtocol = (fileSaveDialog.fileUrl+"").replace('file://', '');
                    //source.grabToImage(function(result) {
                    //result.saveToFile("file:///Users/alex/ML-MT-PH-00005.000_REV1A.edited.000.walker.png");
                    if (currentlySelectedFilePath == "" || currentlySelectedFileName == "") {
                        return false
                    }
                    source.grabToImage(function(result){
                        console.log("saving to image " + currentlySelectedFileName)
                        // logger.text += "\r\n" + "image: ", result.image
                        QmlBridge.saveEditedFile(currentlySelectedFilePath, currentlySelectedFileName, errorType.text, result.image)
                    // if (!result.saveToFile(urlNoProtocol)){
                    //     console.error('Unknown error saving to',urlNoProtocol);
                    // } else {
                        // logger.text += "\r\n" + "saved to " + urlNoProtocol
                    // }
                    
                })
                        // fileSaveDialog.open()
                    }
                }
                Label {
                    id: titleLabel
                    text: "PDF Editor"
                    font.pixelSize: 20
                    elide: Label.ElideRight
                    horizontalAlignment: Qt.AlignHCenter
                    verticalAlignment: Qt.AlignVCenter
                    Layout.fillWidth: true
                }
	            ToolButton {
	                contentItem: Image {
	                    fillMode: Image.Pad
	                    horizontalAlignment: Image.AlignHCenter
	                    verticalAlignment: Image.AlignVCenter
	                    source: "images/FA/black/png/22/image.png"
	                }
	                onClicked: {

                        drawerRight.open()
	                }
	            }
            }
        }
        ToolBar {
            id: subToolBar
            Material.foreground: "white"
            Material.background: Material.Red
             z: 100
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: toolbar.bottom
            RowLayout {
                spacing: 20
                anchors.fill: parent
	            ToolButton {
	                contentItem: TextField {
                        id: errorType
                        verticalAlignment: TextInput.AlignVCenter
                        placeholderText: "insert error type for this edit"
                        color: "black"
                        background: Rectangle {
                            radius: 2
                            implicitWidth: 300
                            implicitHeight: 24
                            border.color: "#333"
                            border.width: 1
                        }
                    }
	            }
                Label {
                    id: imageTitleLabel
                    text: ""
                    font.pixelSize: 20
                    elide: Label.ElideRight
                    horizontalAlignment: Qt.AlignHCenter
                    verticalAlignment: Qt.AlignVCenter
                    Layout.fillWidth: true
                }
            }
        }
        FileDialog {
            id: setWorkingDirectory
            selectFolder: true
            onAccepted: {
                // logger.text += "\r\n" + "User chose directory: " + setWorkingDirectory.folder
                QmlBridge.setWorkingDirectory(setWorkingDirectory.folder)
            }
        }
    //menu
    Drawer {
        id: drawer
        width: Math.min(window.width, window.height) / 3 * 2
        height: window.height
        edge: Qt.LeftEdge
        ListView {
            id: listView
            currentIndex: -1
            anchors.fill: parent

            delegate: ItemDelegate {
                width: parent.width
                text: model.filePath
                highlighted: ListView.isCurrentItem
                onClicked: {
                    if (listView.currentIndex != index) {
                        listView.currentIndex = index
                        titleLabel.text = model.filePath
                        //we need to set the drawer indexes back to -1 whenever a new pdf is chosen
                        listViewRight.currentIndex = -1
                        QmlBridge.openFile(model.filePath)
                    }
                    drawer.close()
                }
            }
            model: FilesModel

            ScrollIndicator.vertical: ScrollIndicator { }
        }
    }
    Drawer {
        id: drawerRight
        width: Math.min(window.width, window.height) / 3 * 2
        height: window.height
        edge: Qt.RightEdge
        ListView {
            id: listViewRight
            currentIndex: -1
            anchors.fill: parent

            delegate: ItemDelegate {
                width: parent.width
                text: model.fileName
                highlighted: ListView.isCurrentItem
                onClicked: {
                    if (listViewRight.currentIndex != index) {
                        listViewRight.currentIndex = index
                        titleLabel.text = model.fileName
                        currentlySelectedFilePath = model.filePath
                        currentlySelectedFileName = model.fileName
                        console.log("select file name " + currentlySelectedFileName)
                        imageTitleLabel.text = "Editing Image: " + model.fileName
                        // logger.text += "\r\n" + "img source " + model.filePath  + "/" + model.fileName
                        // QmlBridge.openFile(model.filePath)
                        img.source = "file:///" + model.filePath + "/" + model.fileName
                        myCanvas.requestPaint()
                        flickableCanvas.contentWidth = img.width
                        flickableCanvas.contentHeight = img.height
                    }
                    drawerRight.close()
                }
            }
            model: ImageFilesModel

            ScrollIndicator.vertical: ScrollIndicator { }
        }
    }
    ScrollView {
            anchors.left: parent.left
            anchors.top: subToolBar.bottom
            anchors.bottom: parent.bottom//logger.top
            anchors.right: parent.right
            clip: true
            ScrollBar.horizontal.policy: ScrollBar.AlwaysOn
            ScrollBar.vertical.policy: ScrollBar.AlwaysOn

            Flickable {
                id: flickableCanvas
                anchors.fill: parent
                
                Item {
                    id: source
                    width: Math.max(parent.width,img.width)
                    height: Math.max(parent.height,img.height)
                Image
                {
                    id: img
                }
                Canvas {
                    id: myCanvas
                    anchors.left: img.left
                    anchors.right: img.right
                    anchors.top: img.top
                    anchors.bottom: img.bottom
                    onPaint: {
                        var ctx = getContext('2d')
                        ctx.fillStyle = brushColor
                        xpos = mousearea.mouseX;
                        ypos = mousearea.mouseY;
                        if (painting)
                        ctx.fillRect(xpos-7, ypos-7, brushSize, brushSize)
                    }
                    function clear() {
                        var ctx = getContext("2d");
                        ctx.reset();
                        myCanvas.requestPaint();
                        // logger.text += "\r\n" + "painting: " + painting
                    }
                    // onPaint: {
                    //     var ctx = getContext('2d');
                    //     ctx.beginPath();
                    //     ctx.strokeStyle = brushColor
                    //     ctx.lineWidth = brushSize
                    //     ctx.moveTo(xpos, ypos);
                    //     ctx.lineTo(mousearea.mouseX, mousearea.mouseY);
                    //     ctx.stroke();
                    //     ctx.closePath();
                    //     xpos = mousearea.mouseX;
                    //     ypos = mousearea.mouseY;
                    // }                
                    MouseArea{
                        id:mousearea
                        anchors.fill: parent
                        hoverEnabled: mousePressed
                        onClicked: {
                            xpos = mouseX
                            ypos = mouseY
                            mousePressed = !mousePressed
                            if (painting)
                                myCanvas.requestPaint()
                        }
                        onPositionChanged: {
                            xpos = mouseX
                            ypos = mouseY
                            if (mousePressed) {
                                myCanvas.requestPaint();
                            }
                        }
                        // onMouseXChanged: {
                        //     xpos = mouseX
                        //     ypos = mouseY
                        //     if (painting)
                        //         myCanvas.requestPaint()
                        // }
                        // onMouseYChanged: {
                        //     xpos = mouseX
                        //     ypos = mouseY
                        //     if (painting)
                        //         myCanvas.requestPaint()
                        // }
                    }
                }
            }
        }
        }
    Connections {
        target: QmlBridge
        onLoadImage: {
            //initialise the viewing
            // footerLabel.visible = false
            // progressIndicator.visible = true
            // progressIndicator.indeterminate = indeterminate
            // //set the progress value (only useful when determinate)
            // progressIndicator.value = c
            // if (c.toFixed(2) >=  0.98) {
            //     //process complete
            //     progressIndicator.visible = false
            // }
            // logger.text += "\r\n" + p
            img.source = "file://" + p
            myCanvas.requestPaint()
            flickableCanvas.contentWidth = img.width
            flickableCanvas.contentHeight = img.height
        }
        onSendMessage: {
            // logger.text +="\r\n" + data
        }
    }
    // ScrollView {
    //     id: loggerView
    //     anchors.left: parent.left
    //     anchors.right: parent.right
    //     anchors.top: subToolBar.bottom
    //     anchors.bottom: parent.bottom   
    //     // height: 200
    //     TextArea {
    //         id: logger
    //         text: "logging area"
    //     }
    // }
    
}
