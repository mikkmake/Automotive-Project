
/* Component LoopingImage: intended for an infinitely scrolling view or background image
  How to use:
    -use an image that consists of 4 identical quadrants
    -the maximum viewPort size is one quadrant
    -control image position within viewPort by functions moveX(change) & moveY(change)
    -experiment with animationDuration to get desired smoothness
*/
import QtQuick

Rectangle {
  id: viewPort // more instructive name than root?
  required property string imageSource
  required property int animationDuration
  // Alias image coordinates for use outside component
  // property alias imgX: viewImage.x
  // property alias imgY: viewImage.y
  property alias imgWidth: viewImage.width
  property alias imgHeight: viewImage.height
  // Properties to control image movement
  property int targetX
  property int targetY
  // These placeholders are the maximum dimensions to get expected behavior
  width: viewImage.width / 2
  height: viewImage.height / 2
  clip: true // A necessary evil

  Image {
    id: viewImage
    source: imageSource
  }

  // Animations that move the image
  PropertyAnimation {
    id: xAnimation
    target: viewImage
    property: "x"
    to: targetX
    duration: animationDuration
  }

  PropertyAnimation {
    id: yAnimation
    target: viewImage
    property: "y"
    to: targetY
    duration: animationDuration
  }

  // Functions by which to move image
  function moveX(change) {
    targetX += change;
    // Is offset out of bounds?
    if (targetX > 0) {
      // Don't animate the huge shift in distance
      xAnimation.running = false;
      targetX -= viewImage.width / 2;
      viewImage.x = targetX;
      return;
      // Another out of bounds check
    } else if (targetX < -viewImage.height / 2) {
      xAnimation.running = false;
      targetX += viewImage.width / 2;
      viewImage.x = targetX;
      return;
    }
    // Out target location is within bounds -> animate change
    xAnimation.running = true;
  }

  // Same logic for y as above for x
  function moveY(change) {
    targetY += change;
    yAnimation.running = true;
    if (targetY > 0) {
      yAnimation.running= false;
      targetY -= viewImage.height / 2;
      viewImage.y = targetY;
    }
    else if (targetY < -viewImage.height / 2) {
      yAnimation.running = false;
      targetY += viewImage.height / 2;
      viewImage.y = targetY;
    }
  }
}
