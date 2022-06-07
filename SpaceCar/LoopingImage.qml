
/* Component LoopingImage: intended for an infinitely scrolling view or background image
  How to use:
    -use an image that consists of 4 identical quadrants
    -the maximum viewPort size is one quadrant
    -control image position within viewport through imgX & imgY
*/
import QtQuick

Rectangle {
  id: viewPort // more instructive name than root?
  required property string imageSource
  // Alias image coordinates for use outside component
  property alias imgX: viewImage.x
  property alias imgY: viewImage.y
  property alias imgWidth: viewImage.width
  property alias imgHeight: viewImage.height
  // These placeholders are the maximum dimensions to get expected behavior
  width: viewImage.width / 2
  height: viewImage.height / 2
  clip: true
  Image {
    id: viewImage
    source: imageSource
    onXChanged: {
      if (x < -1395 || x >=0) {
        xBehavior.enabled = false;
        return;
      }
      xBehavior.enabled = true;
    }

    onYChanged: {
      if (y < -1395 || y >= 0) {
        yBehavior.enabled = false;
        return;
      }
      yBehavior.enabled = true;
    }
    Behavior on x {
      id: xBehavior
      enabled: false
      SequentialAnimation {
        ScriptAction {
          script: {
            console.log("in X animation");
          }
        }
        NumberAnimation {
          duration: 100
        }
      }
    }
    Behavior on y {
      id: yBehavior
      enabled: false
      SequentialAnimation {
        ScriptAction {
        script: {
            console.log("in Y animation");
          }
        }
        NumberAnimation {
          duration: 100
        }
      }
    }
  }
}
