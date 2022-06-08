
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
  property int targetX: -1300
  property alias xRunning: xAnimation.running
  // These placeholders are the maximum dimensions to get expected behavior
  width: viewImage.width / 2
  height: viewImage.height / 2
  clip: true
  Image {
    id: viewImage
    x: -1300
    source: imageSource
    // Define the looping behavior
    onXChanged: () => {
                  if (x > 0 ) {
                    console.log("x too big, limiting")
                    x -= width / 2
                  }
                  else if (targetX < -width / 2) {
                    console.log("x (" + x + ") too small, limiting")
                    x += width / 2
                  }
                }
    // onYChanged: () => {
                  // if (y > 0)
                  // y -= height / 2
                  // else if (y < -height / 2)
                  // y += height
                // }
  }
  PropertyAnimation {
    id: xAnimation
    target: viewImage
    property: "x"
    // running: xRunning
    to: targetX
    duration: 10
  }
  function changeTargetX(change) {
    console.log("X: " + viewImage.x + " targetX: " + targetX + " anim: " + xAnimation.running);
    targetX += change;
    xAnimation.running = true;
    if (targetX > 0 ) {
      xAnimation.running = false;
      console.log("targetX too big, limiting")
      targetX -= width / 2
      viewImage.x = targetX;
    }
    else if (targetX < -viewImage.width / 2) {
      xAnimation.running = false;
      console.log("targetX (" + targetX + ") too small, limiting")
      targetX += viewImage.width / 2
      viewImage.x = targetX;
      console.log("set X to " + viewImage.x)
    }
  }
}

