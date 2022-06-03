import QtQuick
import SpaceCar

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")
    // Testindicator for turning on/off
    Text {
      anchors.horizontalCenter: parent.horizontalCenter
      text: CarControl.turnedOn
    }

    PowerButton{
        turnedOn: CarControl.turnedOn
        anchors.centerIn: parent
    }
}
