import QtQuick

// Testing LoopingImage
Window {
  id: window
  width: 1400
  height: 980
  visible: true
  title: qsTr("Testing")
  LoopingImage {
    id: loopingImage
    imageSource: "Stars_quadrants.png"
    anchors.centerIn: parent
    Timer {
      running: true
      repeat: true
      interval: 20
      onTriggered: () => {
                     loopingImage.changeTargetX(-5);
                     // loopingImage.imgY += 5
                   }
    }
  }
}
