import ddf.minim.*;
import java.io.StringWriter;
import java.io.PrintWriter;
import java.util.Calendar;

class RadioScreen extends Screen {

  boolean isPlaying = false;
  int currentStation = 0;
  boolean oldIsPlaying;
  int oldCurrentStation;
  boolean queuedMusicPlay = false; // flag for queueing music to load on the next frame, in order to have time to draw a loading screen

  Minim minim;

  AudioPlayer[] soundFiles = new AudioPlayer[2];
  String[] soundLabels = new String[2];


  public RadioScreen(String name, int BKG_COLOR, int STROKE_COLOR, PApplet parent) {
    super(name, BKG_COLOR, STROKE_COLOR, parent);

    minim = new Minim(PARENT);

    println("Loading Sound Files");
    soundFiles[0] = minim.loadFile("assets/DiamondCityRadio.mp3");
    soundFiles[1] = null;
    println("Sound Loaded");
    soundLabels[0] = "Diamond City Radio";
    soundLabels[1] = "Classical Radio";

    oldCurrentStation = currentStation;
    oldIsPlaying = false;
  }

  void drawFrame(int px, int py) {
    handleMusic();

    stroke(STROKE_COLOR);

    //draw current station list and update currentStation variable;
    int tempSelected = Views.listView(PARENT, 0, 60, 360, 360, 40, soundLabels, 20, currentStation, false, px, py);
    if (tempSelected!=-1) {
      currentStation=tempSelected;
      //println(selected);
    }

    //right size of screen with play button and station name

    //draw play/pause Button
    fill(STROKE_COLOR);
    if (isPlaying) {
      rect(470, 120, 20, 60);
      rect(510, 120, 20, 60);
    } else {
      triangle(530, 150, 470, 120, 470, 180);
    }

    //check is play/pause button is pressed
    if (px>470 && py<530 && py>120 && py<180)
      isPlaying=!isPlaying;


    //draw station name
    textAlign(CENTER);
    text(soundLabels[currentStation], 500, 300);

    if (queuedMusicPlay) {
      text("Establishing Connection...", 500, 260);
    }
  }

  void init() {
  }

  void handleMusic() {
    try {

      //println("Music Loop");

      if (queuedMusicPlay) {
        soundFiles[currentStation].play((int)(getMsSinceMidnight()%soundFiles[currentStation].length()/2));
        queuedMusicPlay = false;
      }

      //check if state change
      if (oldIsPlaying!=isPlaying) {
        if (oldIsPlaying) {
          soundFiles[currentStation].pause();
        } else {
          queuedMusicPlay = true;
        }
        oldIsPlaying = isPlaying;
      }

      //check for station change;
      if (oldCurrentStation!=currentStation) {
        if (isPlaying) {
          isPlaying = false;
          soundFiles[oldCurrentStation].pause();
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
      text(sw.toString(), 0, 180);
      e.printStackTrace();
    }
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
