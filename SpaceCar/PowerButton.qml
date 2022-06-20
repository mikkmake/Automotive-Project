/* PowerButton component

  */

import QtQuick
import SpaceCar

Item {
  id: root

  width: 50; height: width
  Image {
      anchors.fill: parent
      antialiasing: true
      source: CarControl.turnedOn ? "images/power_button_on.png" : "images/power_button_off.png"
      MouseArea {
          anchors.fill: parent
          onClicked: {
            // Flip SpaceCar on/off
            CarControl.turnedOn = !CarControl.turnedOn;
          }
      }
  }
}
