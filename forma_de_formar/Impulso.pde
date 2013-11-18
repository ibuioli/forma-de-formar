class Impulso {
  int dx, lx, x2, y2, inicial;
  float x, y, ox, oy, nx, ny, r, fre, amp;

  Impulso(float entrada) {
    lx = 400;
    y = 200;

    x2 = (int)random(300);
    y2 = (int)random(300);

    inicial = 10;

    r = random(0.001, 0.01);

    fre = map(entrada, 10, 24, 0.3, 1);
  }

  void onda() {
    if (dx <= inicial) {
      dx+=2;
    }
  }

  void linea() {
    if (dx > inicial) {
      pushStyle();
      if (lx > width-1) {
        stroke(0);
      }
      else {
        stroke(255);
        strokeWeight(4);
        strokeCap(SQUARE);
        line(lx, height/2, lx, height/2+50);
        lx+=2;
      }
      popStyle();
    }
  }

  void impulso() {
    if (lx >= width-1) {
      oscP5.send(new OscMessage("/fre").add(fre), puredata);
    }
  }
}

