/* PowerButton component

  */

import QtQuick
import SpaceCar

Item {
  id: root
  required property bool turnedOn

  width: 200; height: width
  Image {
      anchors.fill: parent
      antialiasing: true
      source: turnedOn ? "power_button_on.png" : "power_button_off.png"
      MouseArea {
          anchors.fill: parent
          onClicked: {
            // Flip SpaceCar on/off
            CarControl.turnedOn = !CarControl.turnedOn
          }
      }
  }
}
