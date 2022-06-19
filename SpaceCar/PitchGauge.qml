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
      id: midLine
      height: 3
      width: 50
      color: "white"
      // border.width: 1
      // border.color: "black"
      anchors.centerIn: parent
    }
    Rectangle {
      id: pitchLine
      height: 3
      width: 30
      color: "white"
      // x: parent.width / 2 - width / 2
      // y: parent.height / 2 - height / 2
      anchors.horizontalCenter: parent.horizontalCenter
      y: (gaugeBg.height / 360) * CarControl.pitch
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
