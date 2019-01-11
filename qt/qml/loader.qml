import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.0
import QtQuick.Controls.Universal 2.0
import Qt.labs.settings 1.0
import QtQuick.Dialogs 1.0
import "elements"
Item {
    id: window
    // width: 900
    // height: 700
    visible: true
    property int xpos
    property int ypos
    property bool painting: false
    property int imgScale: 1
    property int brushSize: 20
    property string brushColor: "red"
    property bool mousePressed: false
    width: img.sourceSize.width * imgScale
    height: img.sourceSize.height * imgScale
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
                        id: paintButton
                        fillMode: Image.Pad
                        horizontalAlignment: Image.AlignHCenter
                        verticalAlignment: Image.AlignVCenter
                        source: "images/FA/white/png/22/paint-brush.png"
                    }
                    onClicked: {
                        painting = !painting
                        if (painting) {
                            paintButton.source = "images/FA/black/png/22/paint-brush.png"
                        } else {
                            paintButton.source = "images/FA/white/png/22/paint-brush.png"
                        }
                    }
                }
                ToolButton {
                    contentItem: Image {
                        fillMode: Image.Pad
                        horizontalAlignment: Image.AlignHCenter
                        verticalAlignment: Image.AlignVCenter
                        source: "images/FA/white/png/22/plus.png"
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
                            source: "images/FA/white/png/22/minus.png"
                    }
                    onClicked: {
                    brushSize -= 5
                    }
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
                    id: settingsViewer
                    contentItem: Image {
                        fillMode: Image.Pad
                        horizontalAlignment: Image.AlignHCenter
                        verticalAlignment: Image.AlignVCenter
                        source: "images/FA/white/png/22/folder.png"
                    }
                    onClicked: {
                        painting = false
                        source.grabToImage(function(result) {
                           result.saveToFile("ML-MT-PH-00005.000_REV1A.edited.000.walker.png");
                       });
                    }
                }
            }
        }

    ScrollView {
        anchors.left: parent.left
        anchors.top: toolbar.bottom
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        clip: true
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOn
        ScrollBar.vertical.policy: ScrollBar.AlwaysOn
        Flickable {
            id: flickableCanvas
            anchors.fill: parent
            contentWidth: img.width
            contentHeight: img.height
            Item {
                id: source
                width: img.width
                height: img.height
            Image
            {
                id: img
                source: "/Users/alex/go/src/github.com/amlwwalker/engineering-drawing-to-image/ML-MT-PH-00005.000_REV1A/edit/ML-MT-PH-00005.000_REV1A.edited.000.png"
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
}
