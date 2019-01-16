// ekke (Ekkehard Gentz) @ekkescorner
import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0

// This app demonstrates HowTo use Qt 5.7 new Qt Quick Controls 2, High DPI and more
// This app is NOT a production ready app
// This app's goal is only to help you to understand some concepts
// see blog http://j.mp/qt-x to learn about Qt 5.7 for Material - styled Android or iOS Apps
// learn about this drawer_nav_x app from this article: http://bit.ly/qt-drawer-nav-x
// ekke (Ekkehard gentz) @ekkescorner

ApplicationWindow {
    id: appWindow
    // visibile must set to true - default is false
    visible: true
    minimumWidth: 360
    minimumHeight: 520
    //
    Rectangle {
        id: redColor
        width: 100
        height: 100
        color: "red"
        border.width: 0
        border.color: "black"
    }
} // app window