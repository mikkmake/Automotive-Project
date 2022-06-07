import QtQuick 2.0
import SpaceCar

Item {
  id: root
  width: infoScreen.width
  height: infoScreen.height
  Image {
    id: infoScreen
    source: "images/Infotainment/Infoscreen.png"
    Row {
      x: 30; y: 30
      spacing: 10
      Text {
        text: "YAW: " + CarControl.yaw
      }
      Text {
        text: "PITCH: " + CarControl.pitch
      }
    }
  }
}
