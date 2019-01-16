import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4
import QtQuick.Controls 2.4
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
             z: 100
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            RowLayout {
                spacing: 20
                anchors.fill: parent

                Label {
                    id: titleLabel
                    text: "PDF Editor"
                    font.pixelSize: 20
                    elide: Label.ElideRight
                    horizontalAlignment: Qt.AlignHCenter
                    verticalAlignment: Qt.AlignVCenter
                    Layout.fillWidth: true
                }
            }
        }

}
