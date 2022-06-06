import QtQuick
import QtQuick.Controls
import SpaceCar

Item {
  id: root
  width: stick.width
  height: stick.height
  Image {
    id: stick
    source: "images/GearShift.png"
  }
}
