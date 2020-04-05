var c = [];

function setup() {
 createCanvas(720,720);
 textSize(70);
 for(var i = 0; i < 6; i++){
   c[i] = new ScoreCircle(i, random(720), random(720));
 }
}


function draw() {
 background(255);
 
 for(var i = 0; i < 6; i++){
   c[i].draw();
   if(!c[i].live()){
     randomSeed(frameCount);
     c[i].init(random(999), random(720), random(720));
   }
 }
}

class ScoreCircle{
  constructor(i, x, y){
    this.init(i, x, y);
  }
  
  init(i, x, y){
    this.index = i;
    this.x = x;
    this.y = y;
    this.c = -random(60);
    this.f = random(120) + 120;
    this.s = random(1) + .5;
  }
  
  draw(){
    randomSeed(this.index);
    
    this.c++;
    
    //  Circle Size
    var ratio = this.s;
    if(this.c < 0){
      return;
    }else if(this.c < 60){
      ratio *= sin(this.c / 60 * PI / 2);
    }else if(this.c > this.f - 60){
      ratio *= sin((this.f - this.c) / 60 * PI / 2);
    }
    
    push();
    
    //  Score
    noFill();
    translate(this.x, this.y);
    scale(ratio, ratio);
    for(var i = 5; i > 0; i--){
      circle(0, 0, i * 28 + 50);
    }
    fill(0);
    
    //  Score Fin
    push();
    rotate(this.index + PI / 2 - this.c * .01);
    text(String.fromCodePoint(0x1D102), -15, -40);
    pop();
    
    //  Score Start
    push();
    rotate(this.index + PI / 2 + PI / 8 - this.c * .01);
    text(String.fromCodePoint(random(1) < .5 ? 0x1D11E : 0x1D122), -15, -45);
    pop();
    
    //  Objects
    for(var r = this.index + PI / 3; r < TAU + this.index - PI / 8; r += PI / 8){
      push();
      rotate(r + PI / 2 - this.c * .01);
      
      switch(int(random(5)))
      {
        //  Note
        case 0:
        case 1:
        case 2:
          var base = int(random(4));
          for(var i = 0; i < random(2); i++){
            text(String.fromCodePoint(0x1D15E + int(random(3))), -15, -25 - base * 7 - i * 14);
            
            //  Accidental
            if(random(1)<.1){
              push();
              textSize(30);
              text(String.fromCodePoint(random(1) < .5 ? 0x266F : 0x266D), -35, -25 - base * 7 - i * 14);
              pop();
            }
          }
          break;
        case 3:  //  Rest
            text(String.fromCodePoint(0x1D13D + int(random(3))),-15, -36);
          break;
        case 4:  //  Space
          break;
      }
      pop();
    }
    pop();
  }
  
  live(){
    return this.c < this.f;
  }
}
