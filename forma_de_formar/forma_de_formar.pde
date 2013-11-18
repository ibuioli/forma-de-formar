import oscP5.*;
import netP5.*;
import processing.video.*;

OscP5 oscP5;
NetAddress puredata;
Capture video;

ArrayList imps;

PImage prevFrame;
PVector boton;
float control;
int contador = 5;
boolean inicio;

long previousTime, currentTime;
float leftOverDeltaTime = 0, timeScale = 1;
final int fixedDeltaTime = (int)(10 / timeScale);
float fixedDeltaTimeSeconds = (float)fixedDeltaTime / 1000;
float velocidadC;

GridSolver grid;

void setup() {
  size(displayWidth, displayHeight, P3D);

  oscP5 = new OscP5(this, 12000);
  puredata = new NetAddress("127.0.0.1", 12000);

  imps = new ArrayList();

  grid = new GridSolver(10); 

  /////////////////////////////

  video = new Capture(this, 640, 480); //WebCam
  video.start();

  prevFrame = createImage(video.width, video.height, RGB);
  boton = new PVector(0, 0);
}

void draw() {
  background(0);

  PImage mImage = procesarImagen();
  control = chequearImpacto(mImage, boton, width);

  if (control > 900) {
    if (inicio == false) {
      caricia();
      inicio = true;
    }
  }

  if (inicio == true) {
    contador--;
    if (contador <= 0) {
      inicio = false;
      contador = 5;
    }
  }

  currentTime = millis();
  long deltaTimeMS = (long)((currentTime - previousTime));
  previousTime = currentTime;

  int timeStepAmt = (int)(((float)deltaTimeMS + leftOverDeltaTime) / (float)(fixedDeltaTime));

  leftOverDeltaTime += deltaTimeMS - (timeStepAmt * (float)fixedDeltaTime); 

  for (int iteration = 1; iteration <= timeStepAmt; iteration++) {
    grid.solve(fixedDeltaTimeSeconds * timeScale);
  }

  velocidadC = map(control, 900, 200000, 10, 26);
  velocidadC = constrain(velocidadC, 10, 26);

  grid.draw();

  ///////////////////////////////////////////

  for (int i = imps.size()-1; i >= 0; i--) { 
    Impulso imp = (Impulso) imps.get(i);
    imp.onda();
    imp.impulso();
    imp.linea();
  }
}

