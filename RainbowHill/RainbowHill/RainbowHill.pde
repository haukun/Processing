float x, z, t, n, d;
void setup() {
  size(1920, 1080, P3D);
  colorMode(HSB);
  noStroke();
  t=0;
  noiseSeed(0);
}
void draw() {
  clear();
  t+=.002;
  for (z=-99; z<99; z+=1){
    for (x=-200; x<200; x+=1) {
      resetMatrix();
      rotateX(-.2);
      translate(x, 150, -150+z);
      n=noise((200+x)*.01+d, z*.01-t)*255;
      fill((n+t*5)%255, 128, n/2+z);
      box(1, n, 1);

      resetMatrix();
      rotateX(.2);
      translate(x, -150, -150+z);
      n=noise((200+x)*.01+d, z*.01-t, 9)*255;
      fill((n+t*5+128)%255, 128, n/2+z);
      box(1, n, 1);
    }
  }
  d+=(noise(t*.1)-.5)*.001;
  //saveFrame("frames2/######.png");
}
