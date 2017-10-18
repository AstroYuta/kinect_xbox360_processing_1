import SimpleOpenNI.*;
SimpleOpenNI kinect;

int closestValue;
int closestX;
int closestY;
int lastX;
int lastY;

void setup(){
  size(640, 480);
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  background(0);
}

// hogehoge
void draw() {

  closestValue = 8000;
  kinect.update();

  // Kinectから距離配列を取り込む
  int[] depthValues = kinect.depthMap();
  //距離画像の列ごとに
  for(int y = 0; y < 480; y++) {
    // 列の中のピクセルを一つ一つみていく
    for(int x = 0; x < 640; x++) {
      int reversedX = 640 - x - 1;
      int i = reversedX + y * 640;
      int currentDepthValue = depthValues[i];

      if(currentDepthValue > 610 && currentDepthValue < 1525 && currentDepthValue < closestValue) {
        closestValue = currentDepthValue;
        closestX = x;
        closestY = y;
      }
    }
  }

  float interpolatedX = lerp(lastX, closestX, 0.3f);
  float interpolatedY = lerp(lastY, closestY, 0.3f);
  // PImage depthImage = kinect.depthImage();
  // image(depthImage, 0, 0);

  stroke(255, 0, 0);
  strokeWeight(3);
  line(lastX, lastY, closestX, closestY);
  lastX = closestX;
  lastY = closestY;
}

void mousePressed() {
  background(0);
}
