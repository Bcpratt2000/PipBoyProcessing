public static class Views {

  public static int listView(PApplet target, int startx, int starty, int endx, int endy, int itemHeight, String[] items, int textSize, int selected, boolean drawOutline, int tapx, int tapy) {

    int STROKE_COLOR = (target.g.strokeColor);
    int FILL_COLOR = (target.g.fillColor);
    target.noFill();
    target.rect(startx, starty, endx-startx, endy-starty);

    //draw List and hilight selection
    target.textAlign(LEFT);
    target.textSize(textSize);
    for (int i=0; i<items.length; i++) {
      //check selected
      if (selected!=i) {
        if (drawOutline) {
          target.noFill();
          target.rect(startx, starty+(i*itemHeight), endx-startx, itemHeight);
        }
        target.fill(STROKE_COLOR);
        target.text(items[i], startx+5, starty+(i*itemHeight)+(itemHeight/2)+(textSize/2));
      } else {
        target.fill(STROKE_COLOR);
        target.rect(startx, starty+(i*itemHeight), endx-startx, itemHeight);
        target.fill(#000000);
        target.text(items[i], startx+5, starty+(i*itemHeight)+(itemHeight/2)+(textSize/2));
      }
    }
    target.noFill();

    //calculate selection
    int toRet = -1;
    if ((tapx>startx && tapx<endx) && (tapy>starty && tapy<endy)) {
      for (int i=0; i<items.length; i++) {
        if (tapy<(starty+((i+1)*itemHeight))) {
          toRet=i;
          break;
        }
      }
    }


    return toRet;
  }
}
