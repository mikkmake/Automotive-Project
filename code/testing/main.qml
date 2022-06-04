import QtQuick

// Testing LoopingImage
Window {
  id: window
  width: 640
  height: 480
  visible: true
  title: qsTr("Testing")
  LoopingImage {
    id: loopingImage
    width: 100
    height: 100
    imageSource: "stars.jpg"
    anchors.centerIn: parent
    MouseArea {
      anchors.fill: parent
      acceptedButtons: Qt.LeftButton | Qt.RightButton
      Timer {
        running: true
        repeat: true
        interval: 50
        onTriggered: () => {
                       loopingImage.imgX++
                       loopingImage.imgY++
                     }
      }
    }
  }
}
