class MapScreen extends Screen {
  public MapScreen(String name, int BKG_COLOR, int STROKE_COLOR, PApplet parent) {
    super(name, BKG_COLOR, STROKE_COLOR, parent);
  }
  void drawFrame(int px, int py) {
    image(mapToColor(loadImage("assets/Map.jpg"), STROKE_COLOR), 0, 0);
  }
}
