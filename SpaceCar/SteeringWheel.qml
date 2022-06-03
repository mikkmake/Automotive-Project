import QtQuick
import SpaceCar

Item {
  id: root
  height: 200; width: height;
  Image {
    id: img
    anchors.fill: parent
    source: "steering_wheel.png"
    // Pressing left should decrease yaw
    MouseArea {
      height: parent.height
      width: parent.width / 2
      onPressed: {
        console.log("Pressed left steering wheel")
        CarControl.decreaseYaw()
      }
    }
    // Pressing right should increase yaw
    MouseArea {
      height: parent.height
      width: parent.width / 2
      x: parent.width / 2
      onPressed: {
        console.log("Pressed right steering wheel")
        CarControl.increaseYaw()
      }
    }
  }
}
