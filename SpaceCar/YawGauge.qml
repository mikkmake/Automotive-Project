import QtQuick 2.0
import SpaceCar

Item {
  id: root
  height: gauge.height + valueBox.height
  width: gauge.width
  property string customFont
  Image {
    id: gauge
    source: "images/RoundGauge.png"
    // Display current yaw as an arrow
    Image {
      id: arrow
      source: "images/Arrow.png"
      anchors.centerIn: parent
      rotation: CarControl.yaw
    }

    // Display yaw-component of current velocity vector
    Rectangle {
      id: velocityYawIndicator
      color: "red"
      radius: height / 2
      width: 5; height: 5
      x: parent.width / 2 - width / 2
      y: height / 2
      transform: Rotation {
        origin.y: gauge.height / 2 - 2.5
        angle: CarControl.velocityYaw
      }
    }
  }

  // Display numerical value
  Rectangle {
    id: valueBox
    anchors {
      bottom: parent.bottom
      horizontalCenter: parent.horizontalCenter
    }
    color: "#00000000"
    width: 20
    height: yawText.height
    Text {
      id: yawText
      text: CarControl.yaw
      font.family: customFont
      font.pixelSize: 20
      anchors.horizontalCenter: parent.horizontalCenter
    }
  }
}
