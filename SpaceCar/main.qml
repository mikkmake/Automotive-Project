import QtQuick
import SpaceCar

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    // For testing purposes, text-displays values
    Row {
      id: indicatorRow
      anchors.horizontalCenter: parent.horizontalCenter
      spacing: 5
      Text {
        text: "turnedOn: " + CarControl.turnedOn
      }
      Text {
        text: "yaw: " + CarControl.yaw
      }
      Text {
        text: "pitch: " + CarControl.pitch
      }
    }

    // For now, we'll just place components in a row
    Row {
      id: componentRow
      anchors.centerIn: parent
      PowerButton{
        turnedOn: CarControl.turnedOn
      }
      SteeringWheel{

      }
    }
}
