import QtQuick

Window {
    id: window
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")
    // Rectangle {
        // id: imgwrapper
        // // anchors.centerIn:parent
        // anchors.fill:parent
        // color: "black"
        // Image {
            // id: img
            // fillMode: Image.Tile
            // anchors.fill: parent
            // source: "stars.jpg"
        // }

    // }
    // Viewport Test
    Rectangle {
        id: viewport
        width: 100; height: width
        anchors.centerIn: parent
        Image {
            id: viewimage
            // How to copy image into 2x2 tiled?
            // idk just do in gimp?
            // Or define image dimensions to source * 2 and use
            // fillMode: Image.Tile

        }
    }
}
