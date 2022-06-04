import QtQuick

Window {
    id: window
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")
    Rectangle {
        id: viewPort
        width: viewImage.width/2; height: viewImage.height/2
        anchors.centerIn: parent
        clip: true
        Image {
            id: viewImage
            source: "stars.jpg"
            // How to copy image into 2x2 tiled?
            // idk just do in gimp?
            // Or define image dimensions to source * 2 and use
            fillMode: Image.Tile
            MouseArea {
              anchors.fill: parent
              acceptedButtons: Qt.RightButton | Qt.LeftButton
              onClicked: (mouse) => {
                if (mouse.button === Qt.LeftButton) {
                  viewImage.x -= 10;
                  viewImage.y -= 10;
                  console.log("leftClicked")
                } else if (mouse.button === Qt.RightButton) {
                  viewImage.x -= 20;
                  viewImage.y += 45;
                  console.log("rightClicked")
                }
                console.log(mouse.button)
                console.log("before x:" + viewImage.x + "y:" + viewImage.y)
                // Four possible overflow scenarios
                if (viewImage.x > 0) {
                  viewImage.x -= viewImage.width / 2
                             console.log("decrease x")
                } else if (viewImage.x < -viewImage.width / 2) {
                             console.log("increase x")
                  viewImage.x += viewImage.width / 2
                }
                if (viewImage.y > 0) {
                  viewImage.y -= viewImage.height / 2
                } else if (viewImage.y < -viewImage.height / 2) {
                  console.log("shift y from " + viewImage.y)
                  viewImage.y += viewImage.height/2
                  console.log("to " + viewImage.y)
                }
                console.log("after x: " + viewImage.x + " y: " + viewImage.y)
              }
            }
        }
    }
}
