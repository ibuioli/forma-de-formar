class GridSolver {
  int cellSize;

  float [][] velocity;
  float [][] density;
  float [][] oldVelocity;
  float [][] oldDensity;

  float friction = 0.55;
  float speed;

  GridSolver (int sizeOfCells) {
    cellSize = sizeOfCells;
    velocity = new float[int(width/cellSize)][int(height/cellSize)];
    density = new float[int(width/cellSize)][int(height/cellSize)];
  }

  void draw () {
    speed = velocidadC;
    
    pushStyle();
    colorMode(HSB, 360, 100, 100);
    noFill();
    pushMatrix();
    scale(0.2, 0.3);
    translate(370, 1000);
    for (int x = 0; x < velocity.length; x++) {
      for (int y = 0; y < velocity[x].length; y++) {
        fill(359, 0, 30 + 127 * cos(density[x][y]*0.01));
        rect(x*cellSize, y*cellSize, cellSize, cellSize);
      }
    }
    popMatrix();
    popStyle();
  }

  void solve (float timeStep) {
    oldDensity = (float[][])density.clone();  
    oldVelocity = (float[][])velocity.clone();

    for (int x = 0; x < velocity.length; x++) {
      for (int y = 0; y < velocity[x].length; y++) {
        velocity[x][y] = friction * oldVelocity[x][y] + ((getAdjacentDensitySum(x, y) - density[x][y] * 4) * timeStep * speed);
        density[x][y] = oldDensity[x][y] + velocity[x][y];
      }
    }
  }

  float getAdjacentDensitySum (int x, int y) {
    float sum = 0;
    if (x-1 > 0)
      sum += oldDensity[x-1][y];
    else
      sum += oldDensity[0][y];

    if (x+1 <= oldDensity.length-1)
      sum += (oldDensity[x+1][y]);
    else
      sum += (oldDensity[oldDensity.length-1][y]);

    if (y-1 > 0)
      sum += (oldDensity[x][y-1]);
    else
      sum += (oldDensity[x][0]);

    if (y+1 <= oldDensity[x].length-1)
      sum += (oldDensity[x][y+1]);
    else
      sum += (oldDensity[x][oldDensity[x].length-1]);

    return sum;
  }
}
