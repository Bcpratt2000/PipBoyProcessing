class HomeScreen extends Screen {
  public HomeScreen(String name, int BKG_COLOR, int STROKE_COLOR, PApplet parent) {
    super(name, BKG_COLOR, STROKE_COLOR, parent);
  }

  void drawFrame(int px, int py) {
    textSize(30);
    textAlign(CENTER);
    text("PipBoy 2000 Mini", 320, 340);
    image(mapToColor(loadImage("assets/boy.png"), STROKE_COLOR), 239, 60);
    textAlign(LEFT);
    text(getFormattedTimeString(), 20, 270);
  }

  String getFormattedTimeString() {
    String toRet = ""; 
    if (hour()%12<10) {
      toRet+= "0" + hour()%12;
    } else {
      toRet+= hour()%12;
    }

    toRet+=":";

    if (minute()<10) {
      toRet+= "0" + minute();
    } else {
      toRet+= minute();
    }

    if (hour()>=12) {
      toRet+=" PM";
    } else {
      toRet+= " AM";
    }

    return toRet;
  }
}
