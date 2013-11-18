int chequearImpacto(PImage mImage, PVector location, int size) {
  int count = 0;
  int x = int(location.x);
  int y = int(location.y);

  for (int px=x; px<x+size; px++)
  {
    for (int py=y; py<y+size; py++) {
      if (px < mImage.width && px > 0 && py < mImage.height && py > 0) {
        if (brightness(mImage.get(px, py)) > 127) {
          count++;
        }
      }
    }
  }

  return count;
}

//////////////////////////////////////////////////////////////////////////////////

PImage procesarImagen() {

  PImage mImage = new PImage();

  if (video.available()) {
    video.read();
    mImage = getMotionImage(video, prevFrame, false);
  }

  return mImage;
}

//////////////////////////////////////////////////////////////////////////////////

PImage getMotionImage(PImage video, PImage prevFrame, boolean mirror) {

  PImage currFrame = createImage(video.width, video.height, RGB);

  currFrame.copy(video, 0, 0, video.width, video.height, 
  0, 0, video.width, video.height);

  PImage mImage = createImage(video.width, video.height, RGB);

  currFrame.loadPixels();

  prevFrame.loadPixels();

  for (int x=0; x<currFrame.width; x++)
  {
    for (int y=0; y<currFrame.height; y++)
    {
      int index = x + y * currFrame.width;

      int indexTarget = index;

      if (mirror)
        index = (currFrame.width - x - 1) + y * currFrame.width;

      color current  = currFrame.pixels[index];
      color previous = prevFrame.pixels[index];

      float diff = dist(red  (current), 
      green(current), 
      blue(current), 
      red(previous), 
      green(previous), 
      blue (previous));

      mImage.pixels[indexTarget] = (diff > 50) ? color(255) : color(0);
    }
  }

  prevFrame.copy(currFrame, 0, 0, video.width, video.height, 
  0, 0, video.width, video.height);

  prevFrame.updatePixels();

  return mImage;
}

