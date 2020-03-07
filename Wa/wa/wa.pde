//  IRO: https://www.nippon.com/ja/japan-data/h00478/
//  MOYOU: https://www.colordic.org/w

color MOEGI_IRO = 0xFF006e54;
color HISUI_IRO = 0xFF38b48b;
color EBI_ZOME = 0xFF7a4171;
color AYAME_IRO = 0xFFcc7eb1;
color AZUKI_IRO = 0xFF96514d;
color RAKUDA_IRO = 0xFFbf794e;
color JINZAMOMI = 0xFFee827c;
color TOKI_IRO = 0xFFf4b3c2;
color KACHI_IRO = 0xFF4d4c61;
color AI_JIRO = 0xFFebf6f7;
color KIMIDORI = 0xFFb8d200;
color WAKAME_IRO = 0xFFe0ebaf;
color BENI_AKA = 0xFFd9333f;
color MOMOHANA_IRO = 0xFFe198b4;
color TERI_GAKI = 0xFFeb6238;
color KANZOU_IRO = 0xFFf8b862;
color TETSU_KON = 0xFF17184b;
color FUJI_IRO = 0xFFbbbcde;
color SUMI = 0xFF595857;
color KINUNEZU = 0xFFdddcd6;
color BENI_KABAIRO = 0xFFbb5548;
color KARE_IRO = 0xFFe0c38c;
color KENPOU_KUROCHA = 0xFF241a08;
color SO_SYOKU = 0xFFeae5e3;
color BENI_KIKYO = 0xFF5654a2;
color SIRA_FUJIIRO = 0xFFdbd0e6;
color AO_NIBI = 0xFF6b7b63;
color BYAKU_ROKU = 0xFFd6e9ca;
color KOKE_IRO = 0xFF69821b;
color WAKANA_IRO = 0xFFc7dc68;
color[] IRO = {MOEGI_IRO, HISUI_IRO, EBI_ZOME, AYAME_IRO, AZUKI_IRO, RAKUDA_IRO, 
  JINZAMOMI, TOKI_IRO, KACHI_IRO, AI_JIRO, KIMIDORI, WAKAME_IRO, 
  BENI_AKA, MOMOHANA_IRO, TERI_GAKI, KANZOU_IRO, TETSU_KON, FUJI_IRO, 
  SUMI, KINUNEZU, BENI_KABAIRO, KARE_IRO, KENPOU_KUROCHA, SO_SYOKU, 
  BENI_KIKYO, SIRA_FUJIIRO, AO_NIBI, BYAKU_ROKU, KOKE_IRO, WAKANA_IRO};
final int IRO_MAX = IRO.length / 2;

void setup() {
  size(1920, 1080);
  PImage mask = createMask();
  PImage cv1, cv2;

  for (int y = 0; y < height; y+= 180) {
    for (int x = 0; x< width; x+= 180) {
      drawing(x, y, 180);
    }
  }

  cv1 = get();
  cv1.mask(mask);
  image(cv1, 0, 0);

  mask.filter(INVERT);
  clear();

  for (int y = -180; y < height + 180; y += 180) {
    for (int x = y / 180 % 2 * 180 - 360; x < width + 360; x += 360) { 
      resetMatrix();
      fill(random(255), random(255), random(255));
      translate(x, y - 180);
      rotate(PI / 4);
      drawing(0, 0, 360);
    }
  }
  resetMatrix();

  cv2 = get();
  cv2.mask(mask);

  background(-1);

  image(cv1, 0, 0);
  image(cv2, 0, 0);

  drawFrame();

  save("wallpaper.png");
}

void createSeigaiha(int _x, int _y, int _w, int _c) {
  clear();
  noStroke();
  for (int y = 0; y < _w + 30; y += 15) {
    for (int x = y / 15 % 2 * 30; x < _w; x += 60) {
      boolean f = true;
      for (int d = 60; d > 0; d-= 10) {
        if (f) {
          fill(IRO[_c]);
        } else {
          fill(IRO[_c + 1]);
        }
        f = !f;
        arc(_x + x, _y + y, d, d, PI, TAU);
      }
    }
  }
}

void createYasugari(int _x, int _y, int _w, int _c) {
  background(IRO[_c]); 
  noFill();
  boolean f = true;
  int t = 0;
  stroke(IRO[_c + 1]);
  for (int y = 0; y < _w; y += 40) {
    f = !f;
    for (int x = 0; x< _w; x++) {
      if (x % 10 == 0) {
        f = !f;
      }
      if (x % 10 == 5) {
        f = !f;
      } else if (x % 10 == 6) {
        f = !f;
      }
      if (f) {
        line(_x + x, _y + y - abs(5 - x % 10), _x + x, _y + y + 40 - abs(5 - x % 10));
      }
    }
  }
}

void createAsanoha(int _x, int _y, int _w, int _c) {
  background(IRO[_c]); 
  noFill();
  stroke(IRO[_c + 1]);
  for (int y = 0; y < _w; y += 14) {
    for (int x = y / 14 % 2 * 20; x < _w; x += 40) {
      int xl = x - 20;
      int xlh = x - 6;
      int xr = x + 20;

      int xrh = x + 6;
      int y2 = y + 14;
      int y3 = y + 28;

      triangle(_x + x, _y + y, _x + xlh, _y + y2, _x + x, _y + y3);
      triangle(_x + x, _y + y, _x + xl, _y + y2, _x + xlh, _y + y2);
      triangle(_x + xl, _y + y2, _x + xlh, _y + y2, _x + x, _y + y3);

      triangle(_x + x, _y + y, _x + xrh, _y + y2, _x + x, _y + y3);
      triangle(_x + x, _y + y, _x + xr, _y + y2, _x + xrh, _y + y2);
      triangle(_x + xr, _y + y2, _x + xrh, _y + y2, _x + x, _y + y3);
    }
  }
}

void createUroko(int _x, int _y, int _w, int _c) {
  background(IRO[_c + 1]); 
  fill(IRO[_c]);
  noStroke();
  for (int y = 0; y < _w; y += 10) {
    for (int x = -10 + y / 10 % 2 * 5; x < _w; x+= 10) {
      triangle(_x + x, _y + y, _x + x - 6, _y + y + 10, _x + x + 6, _y + y + 10);
    }
  }
}

void createKanoko(int _x, int _y, int _w, int _c) {
  background(IRO[_c]); 
  noStroke();
  for (int y = 0; y < _w; y += 20) {
    for (int x = y / 20 % 2 * 10; x < _w; x += 20) {
      fill(IRO[_c + 1]);
      quad(_x + x + 10, _y + y +  2, 
        _x + x + 18, _y + y + 10, 
        _x + x + 10, _y + y + 18, 
        _x + x +  2, _y + y + 10);
      fill(IRO[_c]);
      circle(_x + x + 10, _y + y + 10, 5);
    }
  }
}

void createIchimatsu(int _x, int _y, int _w, int _c) {
  background(IRO[_c]); 
  fill(IRO[_c + 1]);
  noStroke();
  boolean f = false;
  for (int y = 0; y < _w; y += 10) {
    if (f) {
      f = false;
    } else {
      f = true;
    }
    for (int x = 0; x < _w; x+= 10) {
      if (f) {
        square(_x + x, _y + y, 10);
        f = false;
      } else {
        f = true;
      }
    }
  }
}

int getIro() {
  return int(random(IRO.length / 2)) * 2;
}

void drawing(int _x, int _y, int _w) {
  clip(_x, _y, _w, _w);
  switch(int(random(6))) {
  case 0:
    createIchimatsu(_x, _y, _w, getIro());
    break;
  case 1:
    createKanoko(_x, _y, _w, getIro());
    break;
  case 2:
    createUroko(_x, _y, _w, getIro());
    break;
  case 3:
    createAsanoha(_x, _y, _w, getIro());
    break;
  case 4:
    createYasugari(_x, _y, _w, getIro());
    break;
  case 5:
    createSeigaiha(_x, _y, _w, getIro());
    break;
  }
  noClip();
}

void drawFrame() {
  noStroke();
  for (int y = -180; y < height + 180; y += 180) {
    for (int x = y / 180 % 2 * 180 - 360; x < width + 360; x += 360) {
      fill(0, 8);
      for (float d = 30; d > 0; d -= 4) {
        for (float r = 0; r < TAU; r+= PI / 128) {
          circle(cos(r) * 177 + x, sin(r) * 177 + y, d);
        }
      }
    }
  }
  for (int y = -180; y < height + 180; y += 180) {
    for (int x = y / 180 % 2 * 180 - 360; x < width + 360; x += 360) {
      int c = getIro(); 
      for (float r = 0; r < TAU; r+= PI / 128) {
        fill(IRO[c]);
        circle(cos(r) * 177 + x, sin(r) * 177 + y, 7);
        fill(255);
        circle(cos(r) * 177 + x, sin(r) * 177 + y, 2);
      }
    }
  }
}

PImage createMask() {
  background(-1);
  fill(255);
  noStroke();
  blendMode(DIFFERENCE);
  for (int y = -180; y < height + 180; y += 180) {
    for (int x = y / 180 % 2 * 180 - 360; x < width + 360; x += 360) { 
      circle(x, y, 360);
    }
  }
  blendMode(NORMAL);
  return get();
}
