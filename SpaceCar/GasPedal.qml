import QtQuick 2.0
import SpaceCar

Item {
  id: root
  height: pedal.height; width: pedal.width
  property real acceleration: CarControl.acceleration
  Image {
    id: pedal
    source: "images/Pedal3.png"
    fillMode: Image.Stretch
  }
  Behavior on acceleration {
    //Pedalanimation
  }
}
