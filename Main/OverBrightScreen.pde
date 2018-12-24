class OverBrightScreen extends Screen {
  public OverBrightScreen(String name, int BKG_COLOR, int STROKE_COLOR, PApplet parent) {
    super(name, BKG_COLOR, STROKE_COLOR, parent);
  }

  boolean isOverbright;
  void drawFrame(int px, int py) {
    if (px==-1 && py==-1) {
      textAlign(CENTER);
      textSize(30);
      if (isOverbright) {
        fill(STROKE_COLOR);
        stroke(STROKE_COLOR);
        rect(0, 60, 640, 360);
        fill(BKG_COLOR);
        text("Tap screen to toggle OverBright", 320, 180);
      } else {
        fill(BKG_COLOR);
        stroke(BKG_COLOR);
        rect(0, 60, 640, 360);
        fill(STROKE_COLOR);
        text("Tap screen to toggle OverBright", 320, 180);
      }
    } else {
      isOverbright=!isOverbright;
    }
  }

  void init() {
    isOverbright=false;
  }
}
