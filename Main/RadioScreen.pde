import processing.sound.*;
import java.io.StringWriter;
import java.io.PrintWriter;

class RadioScreen extends Screen {

  boolean isPlaying = true;
  int currentStation = 0;
  boolean oldIsPlaying;
  int oldCurrentStation;

  SoundFile[] soundFiles = new SoundFile[1];
  String[] soundLabels = new String[1];


  public RadioScreen(String name, int BKG_COLOR, int STROKE_COLOR, PApplet parent) {
    super(name, BKG_COLOR, STROKE_COLOR, parent);

    println("Loading Sound Files");
    soundFiles[0] = new SoundFile(PARENT, "assets/DiamondCityRadioSmall.wav");
    println("Sound Loaded");
    soundLabels[0] = "Diamond City Radio";

    oldCurrentStation = currentStation;
    oldIsPlaying = false;
    
  }

  void drawFrame(int px, int py) {
    handleMusic();
  }

  void init() {
  }

  void handleMusic() {
    try {

      println("Music Loop");

      //check if state change
      if (oldIsPlaying!=isPlaying) {
        if (oldIsPlaying) {
          soundFiles[currentStation].stop();
        } else {
          soundFiles[currentStation].play();
        }
        oldIsPlaying = isPlaying;
      }

      //check for station change;
      if (oldCurrentStation!=currentStation) {
        if (isPlaying) {
          soundFiles[oldCurrentStation].stop();
          soundFiles[currentStation].play();
        }
        oldCurrentStation = currentStation;
      }
    } 
    catch(Exception e) {
      StringWriter sw = new StringWriter();
      PrintWriter pw = new PrintWriter(sw);
      e.printStackTrace(pw);

      textAlign(LEFT);
      textSize(12);
      text(sw.toString(), 0, 75);
      e.printStackTrace();
    }
  }
}
