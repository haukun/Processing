float t, r, n1, n2, x, y, i, h, w, a1, a2;
void setup() {
  size(1920, 1080, P3D);
  colorMode(HSB);
  noStroke();
  sphereDetail(8, 8);
  noiseSeed(0);
  t=20;
  x=50;
  y=50;
}
void draw() {
  clear();
  t+=.2;
  a1=0;
  a2=0;
  for (i=0; i<90; i++) {
    for (r=0; r<TAU; r+=PI/48) {
      resetMatrix();
      h=noise((int)(i-t)*.1, 19)*90+160;
      w=noise((int)(i-t)*.1, 29)*90+160;
      translate(x+cos(r)*h+(n1=noise((int)(i-t)*.03)*400-200), y+sin(r)*w+(n2=noise((int)(i-t)*.03, 9)*400-200), -850+i*9+t%1*9);
      rotateZ(r);
      if (noise((int)(i-t), r, 39)<.3) {
        fill((t-i)%255, 128, (i+t%1)*2);
        rotateZ(PI/4);
        box(20);
      } else if (noise((int)(i-t)*4.5, r, 49)<.15) {
        fill((t-i)%255, 160, (i+t%1)*2);        
        sphere(30);
      } else if (noise((int)(i-t)*10.5, r, 59)<.2) {
        fill((t-i)%255, 128, (i+t%1)*1.7);        
        rotateZ(PI/6);
        box(100, 10, 5);
      } else if (noise((int)(i-t)*10.5, r, 69)<.2) {
        fill((t-i)%255, 128, (i+t%1)*1.7);        
        rotateZ(-PI/6);
        box(100, 10, 5);
      } else {
        fill((t-i)%255, 128, (i+t%1)*2);
        box(16);
      }
    }
    if (i>75) {
      a1+=n1;
      a2+=n2;
    }
  }
  x-=(a1/15+x)/30;
  y-=(a2/15+y)/30;
  //saveFrame("frames/######.png");
}
