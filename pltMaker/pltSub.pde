PrintWriter printWriter;

final int PLT_RATIO = 10;

final int PLT_NONE = 0;
final int PLT_READY = 1;
final int PLT_EXECUTE = 2;
final int PLT_DONE = 3;

final int width = 590;
final int height = 400;

int pltState = PLT_NONE;
boolean rKeyPressed = false;
boolean drawn = false;

//--------------------------------------------------
//  setup
//--------------------------------------------------
void settings(){
  size((int)(590 * RATIO), (int)(400 * RATIO));
}

void setup(){
  noFill();
  subSetup();
}

//--------------------------------------------------
//  draw
//--------------------------------------------------
void draw(){
  background(255);
  if(pltState == PLT_READY){
    pltState = PLT_EXECUTE;
    printWriter = createWriter("output.plt");
    printWriter.println("FN0,&100,100,100");
  }
 
  subDraw();
  
  if(pltState == PLT_EXECUTE){
    println("Plt output done.");
    printWriter.println("M0,0");
    printWriter.flush();
    printWriter.close();
    pltState = PLT_DONE;
  }
}

//--------------------------------------------------
//  keyPressed
//--------------------------------------------------
void keyPressed(){
  if((key == 'r') && (pltState == PLT_NONE)){
    pltState = PLT_READY;
  }else if(key == 'i'){
    save("output.png");
    println("Image output donw.");
  }
}

void keyReleased(){
  if(key == 'r'){
    pltState = PLT_NONE;
  }
}

//--------------------------------------------------
//  PltOutput
//--------------------------------------------------  
void PltOutput(String str){
  if(pltState == PLT_EXECUTE){
    printWriter.println(str);
  }
}


//--------------------------------------------------
//  ellipse
//--------------------------------------------------
void ellipse(float _x, float _y, float _w, float _h){
  super.ellipse(_x * RATIO, _y * RATIO, _w * RATIO, _h * RATIO);
  
  float x = _x * PLT_RATIO;
  float y = (height - _y) * PLT_RATIO;
  float w = _w * PLT_RATIO / 2.0;
  float h = _h * PLT_RATIO / 2.0;
  PltOutput(String.format(")%d,%f,%f,%f,%f,0,3600,0",0, x, y, w, h));
}

//--------------------------------------------------
//  arc
//--------------------------------------------------
void arc(float _x, float _y, float _w, float _h, float _b, float _e){
  super.arc(_x * RATIO, _y * RATIO, _w * RATIO, _h * RATIO, _b, _e);
  
  float x = _x * PLT_RATIO;
  float y = (height - _y) * PLT_RATIO;
  float w = _w * PLT_RATIO / 2.0;
  float h = _h * PLT_RATIO / 2.0;
  float b = degrees(_b) * -10;
  float e = degrees(_e) * -10;
  
  PltOutput(String.format(")%d,%f,%f,%f,%f,%f,%f",0, x, y, w, h, b, e));

}

//--------------------------------------------------
//  rect
//--------------------------------------------------
void rect(float _x, float _y, float _w, float _h){
  super.rect(_x * RATIO, _y * RATIO, _w * RATIO, _h * RATIO);
  
  float x = _x * PLT_RATIO;
  float y = (height - _y) * PLT_RATIO;
  float w = _w * PLT_RATIO;
  float h = _h * PLT_RATIO;
    
  PltOutput(String.format("M%f,%f,D%f,%f,D%f,%f,D%f,%f,D%f,%f", x, y, x, y - h, x + w, y - h, x + w, y, x, y));
}

//--------------------------------------------------
//  polygon
//    n角形を描画する
//    _n  角数。3以上必須。
//    _a  位相。時計回りで回転させる角度。
//--------------------------------------------------
void polygon(float _x, float _y, float _w, float _h, int _n, float _a){
  if(_n <= 2){
    println("polygon()'s _n can accept over than 2.");
    return ;
  }
  
  float rad = TWO_PI / _n;
  
  float x1, y1, x2, y2;  
  x1 = 0;
  y1 = 0;
  x2 = 0;
  y2 = 0;
  
  for(int i = 0; i <= _n; i++){
    x1 = x2;
    y1 = y2;
    
    x2 = cos(rad * i + _a) * _w + _x;
    y2 = sin(rad * i + _a) * _h + _y;
    
    if(i != 0){
      line(x1, y1, x2, y2);
    }
  }
}

//--------------------------------------------------
//  edge
//    polygon()で、描画範囲を角度で指定できるもの。
//--------------------------------------------------
void edge(float _x, float _y, float _w, float _h, int _n, float _a, float _b, float _e){

  if(_n <= 2){
    println("polygon()'s _n can accept over than 2.");
    return ;
  }

  float rad = TWO_PI / _n;
  float minRad = 0;
  float maxRad = rad;
      
  while(minRad <= _e){
    if(maxRad > _b){
      
      float firstRad = max(minRad, _b);
      float endRad = min(maxRad, _e);
          
      float x1, y1, x2, y2;
      x1 = cos(minRad + _a);
      y1 = sin(minRad + _a);
      x2 = cos(maxRad + _a);
      y2 = sin(maxRad + _a);
       
      float mx, my;
      mx = (x2 - x1) / rad;
      my = (y2 - y1) / rad;
      
      float lx1, ly1, lx2, ly2;
      lx1 = x1 + mx * (firstRad - minRad);
      ly1 = y1 + my * (firstRad - minRad);
      lx2 = x2 - mx * (maxRad - endRad);
      ly2 = y2 - my * (maxRad - endRad);
      
      lx1 = lx1 * _w + _x;
      ly1 = ly1 * _h + _y;
      lx2 = lx2 * _w + _x;
      ly2 = ly2 * _h + _y;
      
      line(lx1, ly1, lx2, ly2);    
    }
    
    minRad = maxRad;
    maxRad += rad;
  }
}


//--------------------------------------------------
//  line
//--------------------------------------------------
void line(float _x1, float _y1, float _x2, float _y2){
  super.line(_x1 * RATIO, _y1 * RATIO, _x2 * RATIO, _y2 * RATIO);
  
  float x1 = _x1 * PLT_RATIO;
  float y1 = (height - _y1) * PLT_RATIO;
  float x2 = _x2 * PLT_RATIO;
  float y2 = (height - _y2) * PLT_RATIO;
    
  PltOutput(String.format("M%f,%f,D%f,%f,", x1, y1, x2, y2));
}
