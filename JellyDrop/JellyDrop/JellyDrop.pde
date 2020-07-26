float t, d, x, T;
void setup() {
  size(1920, 1080);
  noStroke();
  colorMode(HSB);
}
void draw() {
  noiseSeed(0);
  clear();
  t+=.0015;
  for (d=150; d>0; d-=5) {
    for (x=0; x<1930; x+=20) {
      fill((x*x)%255, 255-d*1.2, d*1.8+sq(cos((x+t)))*+100, 192);
      ellipse(x, tan(T=x+t+0*noise(x, t*.01)*9)*4.5+200+noise(x, t*.01)*200, d*(abs(cos(T))*.9+.1), d*(sq(sin(T))*.2+.8));
    }
  }
  //saveFrame("frames/######.png");
}
