import QtQuick 2.0
import SpaceCar

Item {
  id: root
  height: pedal.height; width: pedal.width
  property real acceleration: CarControl.acceleration
  Image {
    id: pedal
    source: "images/Pedal3.png"

  }
  Behavior on acceleration {
    // acceleration is 0-5
    // want: on increase, scale down pedal
    // decrease scale by 0.1 per accel
    // NumberAnimation on scale {

    // }
  }
}
