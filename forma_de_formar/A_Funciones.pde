void caricia() {
  float force = 250000;
  if (((int)((width/2) / grid.cellSize) < grid.density.length) && ((int)((height/2) / grid.cellSize) < grid.density[0].length) &&
    ((int)((width/2) / grid.cellSize) > 0) && ((int)((height/2) / grid.cellSize) > 0)) {
    grid.velocity[(int)((width/2) / grid.cellSize)][(int)((height/2) / grid.cellSize)] += force;
  }

  imps.add(new Impulso(velocidadC));
}
