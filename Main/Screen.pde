public abstract class Screen {

  protected String name = "";
  protected int BKG_COLOR;
  protected int STROKE_COLOR;
  protected PApplet PARENT;

  public Screen(String name, int BKG_COLOR, int STROKE_COLOR, PApplet parent) {
    this.name = name;
    this.BKG_COLOR = BKG_COLOR;
    this.STROKE_COLOR = STROKE_COLOR;
    this.PARENT = parent;
  }
  public void drawFrame(int px, int py) {
  }
  public void drawFrame() {
    drawFrame(-1, -1);
  }
  public String getName() {
    return this.name;
  }
  public void init() {
  }
}
