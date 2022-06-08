/* Steering Wheel component

*/

import QtQuick
import SpaceCar
import Qt.labs.animation

Item {
  id: root
  width: base.width; height: base.height
  // What we need access to from outside
  property alias rotation: base.rotation
  Image {
    id: base
    rotation: 0
    source: "images/SteeringWheel/Steeringwheel-base.png"
    onRotationChanged: { console.log("rot: " + rotation); }
    // Images already aligned -> center everything in parent
    Image {
      id: middle
      source: "images/SteeringWheel/Steeringwheel-middle.png"
      anchors.centerIn: parent
    }
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
      minimum: -50
      maximum: 50
    }
  }
}
