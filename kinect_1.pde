import SimpleOpenNI.*;
SimpleOpenNI kinect;

int closestValue;
int closestX;
int closestY;

void setup(){
  size(640, 480);
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
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
      // そのピクセルに対応する値を距離配列から取り出す
      int i = x + y * 640;
      int currentDepthValue = depthValues[i];

      if(currentDepthValue > 0 && currentDepthValue < closestValue) {
        closestValue = currentDepthValue;
        closestX = x;
        closestY = y;
      }
    }
  }

  PImage depthImage = kinect.depthImage();
  image(depthImage, 0, 0);

  fill(255, 0, 0);
  ellipse(closestX, closestY, 25, 25);
}

