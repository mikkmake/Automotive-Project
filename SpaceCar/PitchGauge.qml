import QtQuick 2.0
import SpaceCar

Item {
  id: root
  height: gaugeRim.height + valueBox.height
  width: gaugeRim.width
  Image {
    id: gaugeBg
    source: "images/RoundGauge/RoundGaugeBackground.png"
    anchors.horizontalCenter: parent.horizontalCenter
    y: (gaugeRim.height - height) / 2
    Rectangle {
      id: midLineLeft
      height: 2
      width: 25
      color: "white"
      anchors.verticalCenter: parent.verticalCenter
      anchors.left: parent.left
    }
    Rectangle {
      id: midLineRight
      height: 2
      width:25
      color: "white"
      anchors.verticalCenter: parent.verticalCenter
      anchors.right: parent.right
    }

    Rectangle {
      id: pitchLineLeft
      height: 2
      width: 12
      color: "white"
      anchors.left: parent.left
      anchors.leftMargin: midLineLeft.width
      y: parent.height / 2 - height / 2 + ((parent.height / 360.0) * CarControl.pitch)
    }
    Rectangle {
      id: pitchLineRight
      height: 2
      width: 12
      color: "white"
      anchors.right: parent.right
      anchors.rightMargin: midLineRight.width
      y: parent.height / 2 - height / 2 + ((parent.height / 360.0) * CarControl.pitch)
    }
    Rectangle {
      id: negativeMark
      height: 2
      width: 6
      color: "white"
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.top: parent.top
      anchors.topMargin: parent.height / 4 - 1
    }
    Rectangle {
      id: positiveMark
      height: 2
      width: 6
      color: "white"
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.bottom: parent.bottom
      anchors.bottomMargin: parent.height / 4 - 1
    }
    Rectangle {
      id: velocityPitchIndicator
      height: 6; width: 6
      radius: width / 2
      color: "red"
      anchors.horizontalCenter: parent.horizontalCenter
      y: parent.height / 2 - height / 2 + ((parent.height / 360.0) * CarControl.velocityPitch)
    }

    Image {
      id: gaugeRim
      source: "images/RoundGauge/RoundGaugeRim.png"
      anchors.centerIn: parent
    }
  }
  Rectangle {
    id: valueBox
    height: pitchText.height
    color: "#00000000"
    anchors {
      bottom: parent.bottom
      horizontalCenter: parent.horizontalCenter
    }
    Text {
      id: pitchText
      text: CarControl.pitch
    }
  }
  Component.onCompleted: {
    console.log("h" + height + "w" + width)
  }
}
