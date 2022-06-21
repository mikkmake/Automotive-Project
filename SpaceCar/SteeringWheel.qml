/* Steering Wheel component

*/

import QtQuick
import SpaceCar
import Qt.labs.animation

Item {
  id: root
  width: base.width; height: base.height
  property alias rotation: base.rotation
  property string customFont
  Image {
    id: base
    rotation: 0
    source: "images/SteeringWheel/Steeringwheel-base.png"
    // Images already aligned -> center everything in parent
    Image {
      id: middle
      source: "images/SteeringWheel/Steeringwheel-middle.png"
      anchors.centerIn: parent
      Text {
        anchors.centerIn: parent
        font.family: customFont
        text: "EDISON"
        font.pixelSize: 26
      }
    }

    // Useless buttons
    Image {
      id: leftButton
      source: "images/SteeringWheel/Steeringwheel-leftbutton.png"
      anchors.centerIn: parent
    }
    Image {
      id: rightbutton
      source: "images/SteeringWheel/Steeringwheel-rightbutton.png"
      anchors.centerIn: parent
    }

    // Disallow too much rotation
    BoundaryRule on rotation {
      minimum: -15
      maximum: 15
    }
  }
}
