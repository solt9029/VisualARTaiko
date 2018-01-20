import processing.video.*;
import jp.nyatla.nyar4psg.*;
Capture cam;
MultiMarker [] nyas;

void setup() {
  size(1280, 960, P3D);
  nyas = new MultiMarker [24];
  for (int i = 0; i < nyas.length; i++) {
    nyas[i] = new MultiMarker(this, 1280, 960, "camera_para.dat", NyAR4PsgConfig.CONFIG_PSG);
    nyas[i].addNyIdMarker(i, 30);
  }

  cam=new Capture(this, 640, 480);
  cam.start();
}

void draw() {
  cam.read();
  PImage tmp = cam.get();
  tmp.resize(1280, 960);
  image(tmp, 0, 0);

  for (int i = 0; i < nyas.length; i++) {
    nyas[i].detect(tmp);
    if (nyas[i].isExistMarker(0)) {
      nyas[i].beginTransform(0);
      if (i < 8) {        
        fill(100, 100, 100);
        ellipse(0, 0, 50, 50);
      } else if (i < 16) {
        fill(244, 58, 0);
        ellipse(0, 0, 50, 50);
        rotateY(radians(-90));
        rotateX(radians(180));
        rotateZ(radians(-90));
        translate(0, 50, 0);
        scale(0.1);
        modelDonChan();
      } else {
        fill(93, 192, 189);
        ellipse(0, 0, 50, 50);
        rotateY(radians(-90));
        rotateX(radians(180));
        rotateZ(radians(-90));
        translate(0, 50, 0);
        scale(0.1);
        modelKaChan();
      }
      nyas[i].endTransform();
    }
  }
}


void pillar(float length, float radius1, float radius2) {
  float x, y, z; //座標
  pushMatrix();

  //上面の作成
  beginShape(TRIANGLE_FAN);
  y = -length / 2;
  vertex(0, y, 0);
  for (int deg = 0; deg <= 360; deg = deg + 10) {
    x = cos(radians(deg)) * radius1;
    z = sin(radians(deg)) * radius1;
    vertex(x, y, z);
  }
  endShape();

  //底面の作成
  beginShape(TRIANGLE_FAN);
  y = length / 2;
  vertex(0, y, 0);
  for (int deg = 0; deg <= 360; deg = deg + 10) {
    x = cos(radians(deg)) * radius2;
    z = sin(radians(deg)) * radius2;
    vertex(x, y, z);
  }
  endShape();

  //側面の作成
  beginShape(TRIANGLE_STRIP);
  for (int deg =0; deg <= 360; deg = deg + 5) {
    x = cos(radians(deg)) * radius1;
    y = -length / 2;
    z = sin(radians(deg)) * radius1;
    vertex(x, y, z);

    x = cos(radians(deg)) * radius2;
    y = length / 2;
    z = sin(radians(deg)) * radius2;
    vertex(x, y, z);
  }
  endShape();

  popMatrix();
}

void modelTaiko(String taiko) {
  noStroke();

  color bodyColor = color(0, 0, 0);
  color faceColor = color(0, 0, 0);

  if (taiko.equals("don")) {
    bodyColor = color(93, 192, 189);
    faceColor = color(244, 58, 0);
  } else if (taiko.equals("ka")) {
    bodyColor = color(244, 58, 0);
    faceColor = color(93, 192, 189);
  }

  // 胴体
  fill(255, 255, 255);
  pillar(300, 100, 100);
  fill(bodyColor);
  pillar(260, 101, 101);

  // 顔の赤色
  pushMatrix();
  translate(0, 151, 0);
  rotateX(radians(90));
  fill(faceColor);
  ellipse(0, 0, 160, 160);
  popMatrix();

  // 目
  pushMatrix();
  translate(20, 152, 43);
  rotateX(radians(90));
  fill(0);
  ellipse(0, 0, 40, 40);
  popMatrix();

  // 目
  pushMatrix();
  translate(20, 152, -43);
  rotateX(radians(90));
  fill(0);
  ellipse(0, 0, 40, 40);
  popMatrix();

  // 腕
  pushMatrix();
  rotateZ(radians(90));
  rotateY(radians(90));

  pushMatrix();
  translate(80, 125, 100);
  rotateZ(radians(-30));
  fill(255, 255, 255);
  pillar(100, 5, 20);
  translate(0, 50, 0);
  sphere(35);
  popMatrix();

  pushMatrix();
  translate(-80, 125, 100);
  rotateZ(radians(30));
  fill(255, 255, 255);
  pillar(100, 5, 20);
  translate(0, 50, 0);
  sphere(35);
  popMatrix();

  pushMatrix();
  translate(80, 125, -100);
  rotateZ(radians(-30));
  fill(255, 255, 255);
  pillar(100, 5, 20);
  translate(0, 50, 0);
  sphere(35);
  popMatrix();

  pushMatrix();
  translate(-80, 125, -100);
  rotateZ(radians(30));
  fill(255, 255, 255);
  pillar(100, 5, 20);
  translate(0, 50, 0);
  sphere(35);
  popMatrix();
  popMatrix();

  // お尻側の赤色
  pushMatrix();
  translate(0, -151, 0);
  rotateX(radians(90));
  fill(faceColor);
  ellipse(0, 0, 160, 160);
  popMatrix();
}

void modelDonChan() {
  modelTaiko("don");
}

void modelKaChan() {
  modelTaiko("ka");
}

