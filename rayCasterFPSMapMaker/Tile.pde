class Tile {
  int value; // 0-floor, 1-lowWall, 2-mediumWall, 3-highWall, 4-pit, 5-lava
  
  Tile(int v) {
    this.value = v;
  }

  void set(int v) {
    this.value = v;
  }
}
