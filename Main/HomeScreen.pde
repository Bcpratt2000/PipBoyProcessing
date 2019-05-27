class HomeScreen extends Screen {
  public HomeScreen(String name, int BKG_COLOR, int STROKE_COLOR, PApplet parent) {
    super(name, BKG_COLOR, STROKE_COLOR, parent);
  }

  void drawFrame(int px, int py) {
    textSize(30);
    textAlign(CENTER);
    text("PipBoy 3000 TS", 320, 340);
    image(mapToColor(loadImage("assets/boy.png"), STROKE_COLOR), 239, 60);
    textAlign(LEFT);
    
    //Time
    text(getFormattedTimeString(), 20, 270);
    
    //Date
    text(getDate(), 20, 150);
    
    //Rads
    textAlign(RIGHT);
    text(getRads(), 620, 270);
    textAlign(LEFT);
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
  
  String getRads(){
    String toRet = "";
    toRet+="Rad: " + Float.toString((float)Math.pow(noise((getMsSinceMidnight()/1000)*.03)*1.5, 10));
    return toRet.substring(0, 10);
    //return toRet;
  }
  
  String getDate(){
    String toRet = "";
    toRet+=month() + "/" + day() + "/" + year();
    return toRet;
  }
  
  
  private long getMsSinceMidnight() {
    Calendar c = Calendar.getInstance();
    long now = c.getTimeInMillis();
    c.set(Calendar.HOUR_OF_DAY, 0);
    c.set(Calendar.MINUTE, 0);
    c.set(Calendar.SECOND, 0);
    return now - c.getTimeInMillis();
  }
}
