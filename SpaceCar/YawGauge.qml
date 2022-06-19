import QtQuick 2.0
import SpaceCar

Image {
  id: root
  height: gauge.height + valueBox.height
  width: gauge.width
  Image {
    id: gauge
    source: "images/RoundGauge.png"
    Image {
      id: arrow
      source: "images/Arrow.png"
      anchors.centerIn: parent
      rotation: CarControl.yaw
    }
  }
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
    }
  }
  Component.onCompleted: {
    console.log("yaw h" + height + "w" + width)
  }
}
