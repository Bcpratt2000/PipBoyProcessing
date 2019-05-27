import ddf.minim.*;

final int STROKE_COLOR = #FFFF00;
final int BKG_COLOR = #000000;

final Screen[] screenArray = new Screen[4];
int currentScreen = 1;

boolean isFirst=true;
boolean mouseHasClicked = false;
int px, py;

Minim minim;
AudioPlayer soundPress;
AudioPlayer soundHum;

void setup() {
  size(640, 360);
  strokeWeight(2);
  frameRate(30);
  background(mapToColor(loadImage("assets/startup.png"), STROKE_COLOR));
}




void draw() {
  if (isFirst) {
    //delay(2500);
    isFirst=false;
    screenArray[0] = new OverBrightScreen("OverBright", BKG_COLOR, STROKE_COLOR, this);
    screenArray[1] = new HomeScreen("Home", BKG_COLOR, STROKE_COLOR, this);
    screenArray[2] = new MapScreen("Map", BKG_COLOR, STROKE_COLOR, this);
    screenArray[3] = new RadioScreen("Radio", BKG_COLOR, STROKE_COLOR, this);
    
    minim = new Minim(this);
    soundPress = minim.loadFile("assets/PipBoy/UI_Pipboy_OK.mp3");
    soundPress.setGain(-9);
    soundHum = minim.loadFile("assets/PipBoy/UI_PipBoy_Hum_LP.wav");
    soundHum.setGain(-12);
    soundHum.loop();
    delay(1000);
    
  }

  if (mouseHasClicked) {
    soundPress.loop(0);
    mouseHasClicked=false;
    if (py<60) {
      //clicked in upper screen
      if (px<120)
        incrementScreen(-1);
      if (px>520)
        incrementScreen(1);
    } else {
      //clicked in lower screen
      drawContent(currentScreen, px, py);
    }
  }

  background(BKG_COLOR);
  drawContent(currentScreen);
  drawUpper();
  drawStaticLines();
  //filter(BLUR, 1);
}




boolean incrementScreen(int amount) {
  try {
    screenArray[currentScreen+amount].init();
    currentScreen+=amount;
    return true;
  } 
  catch(Exception e) {
    return false;
  }
}

void mousePressed() {
  px=mouseX;
  py=mouseY;
  mouseHasClicked=true;
}


void drawUpper() {
  fill(BKG_COLOR);
  stroke(BKG_COLOR);
  rect(0, 0, 640, 60);
  stroke(STROKE_COLOR);
  fill(STROKE_COLOR);
  strokeWeight(2);
  line(0, 60, 640, 60);
  strokeWeight(2);
  triangle(50, 30, 90, 10, 90, 50);
  triangle(590, 30, 550, 10, 550, 50);
  textSize(30);
  textAlign(CENTER);
  text(screenArray[currentScreen].getName(), 320, 35);
}

void drawStaticLines() {
  float strokeCoeff = .25;
  for (int i=0; i<height; i+=random(3)+3) {
    stroke(color(red(STROKE_COLOR)*strokeCoeff, green(STROKE_COLOR)*strokeCoeff, blue(STROKE_COLOR)*strokeCoeff, 96));
    strokeWeight(noise(i+millis())*2);
    line(0, i, width, i);
  }
  
  //for (int i=0; i<height; i+=4) {
  //  stroke(color(red(STROKE_COLOR)*strokeCoeff, green(STROKE_COLOR)*strokeCoeff, blue(STROKE_COLOR)*strokeCoeff, 96));
  //  strokeWeight(2);
  //  line(0, i, width, i);
  //}
}


void drawContent(int screenIndex, int px, int py) {
  screenArray[screenIndex].drawFrame(px, py);
}

void drawContent(int screenIndex) {
  screenArray[screenIndex].drawFrame();
}

PImage mapToColor(PImage image, int targetColor) {
  color scaleColor = targetColor;
  //load  image & map to Color Scheme
  image.filter(GRAY);
  image.loadPixels();
  for (int i=0; i<image.pixels.length; i++) {
    image.pixels[i] = color((red(image.pixels[i])*red(scaleColor))/255, (green(image.pixels[i])*green(scaleColor))/255, (blue(image.pixels[i])*blue(scaleColor))/255, (alpha(image.pixels[i])*alpha(scaleColor))/255);
  }
  image.updatePixels();
  return image;
}
