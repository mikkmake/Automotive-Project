import QtQuick

Window {
    id: window
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")
    Rectangle {
        id: imgwrap
        anchors.centerIn:parent
        width: img.width
        height: img.height
        Image {
            id: img
            // anchors.fill: parent
            source: "MusicPlayer_Cover.png"
            layer.enabled: true
            layer.wrapMode: ShaderEffectSource.Repeat
            layer.effect: ShaderEffect {
                NumberAnimation on displacement {

                }
            }
        }
        // Rectangle {
        // anchors.centerIn: parent
        // width: 200; height: width
        // Text {
            // anchors.centerIn: parent
            // text: "Helou vöörldd"
            // color: "black"
        // }
        // color: "blue"
    }
}
