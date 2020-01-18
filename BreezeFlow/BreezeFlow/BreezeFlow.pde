int x, y;
float t, d, a;
float c;
void setup() {
  size(1920, 1080);
  noiseSeed(0);
  colorMode(HSB);
}
void draw() {
  t+=.003;
  loadPixels();
  for (y=0; y<1080; y++) {
    for (x=0; x<1920; x++) {
      d=dist(x, y, 960, 540)*.005;
      a=atan2(960-x, 540-y)+PI;
      c=abs(tan(noise(d, sin(sin(d+t)*d+(a)*3.5), t)*TAU))*255;
      pixels[y*1920+x]=color((d*50+t*100+a*40.5)%255, 255-c, c);
    }
  }
  updatePixels();
  //saveFrame("frames/######.png");
}
