Table dataTable;
String[] names;
PImage img;
int h;
TextPixel[][] pixelArr;
TextPixel[][] pixelArr2;
ArrayList<Integer> indicesUsed;
ArrayList<Integer> indicesUsed2;
int textSize;
int timer;
float rate;

void setup() {
  size(600,400);
  background(color(255));
  textSize = 108;
  rate = 256;
  timer=0;
  
  img = loadImage("final.png");
  img.resize(600,0);
  
  dataTable = loadTable("data.csv", "header");
  names = new String[dataTable.getRowCount()];
  int r =0;
  for (TableRow row: dataTable.rows()) {
    names[r] = row.getString("Artist Name");
    r+=1;
  }
  
  pixelArr = new TextPixel[600/textSize][400/textSize];
  pixelArr2 = new TextPixel[600/textSize][400/textSize];
  indicesUsed = new ArrayList<Integer>();
  indicesUsed2 = new ArrayList<Integer>();
  frameRate(rate);
}

void draw() {
  // first three seconds
  if (timer < 768) {
    if (timer %64==0) {    
      int randX = (int) random(0, 400);
      int randY = (int) random(100, 300);
      int randI = (int) random(0, names.length);
      textSize(textSize);
      fill(img.get(randX, randY));
      text(names[randI], randX, randY);  
    }
    timer+=1;
    // next two seconds
  } else if (timer>=768 && timer<1280) {
    if (timer %16==0) {    
      int randX = (int) random(0, 400);
      int randY = (int) random(100, 300);
      int randI = (int) random(0, names.length);
      textSize(textSize);
      fill(img.get(randX, randY));
      text(names[randI], randX, randY);  
    }
    timer+=1;
  } else if (timer>=1280&&timer<1536) {
    if (timer %8==0) {    
      int randX = (int) random(0, 400);
      int randY = (int) random(100, 300);
      int randI = (int) random(0, names.length);
      textSize(textSize);
      fill(img.get(randX, randY));
      text(names[randI], randX, randY);  
    }
    timer+=1;
  } else {
    //image(img, 0,h);
    if (timer > rate*5+1536) {
      timer=1536;
      if (textSize!=8) {
        if (textSize<=18) {
          textSize-=5;
        } else {
          textSize-=10;
        }
        rate*=.8;
        frameRate(rate);
      }
      pixelArr = new TextPixel[600/textSize][400/textSize];
      pixelArr2 = new TextPixel[600/textSize][400/textSize];
    }
    for (int y = 0;y<400;y+=textSize) {
      for (int x = 0;x<600;x+=textSize) {
        int randIndex = (int) random(0,names.length);
        int randIndex2 = (int) random(0,names.length);
        while (indicesUsed.contains(randIndex)) {
          randIndex = (int) random(0,names.length);
        }
        while (indicesUsed2.contains(randIndex2)) {
          randIndex2 = (int) random(0,names.length);
        }
        indicesUsed.add(randIndex);
        indicesUsed2.add(randIndex2);
        if (x/textSize< pixelArr.length && y/textSize<pixelArr[0].length) {
          pixelArr[x/textSize][y/textSize] = new TextPixel(names[randIndex], averageColor(x,y));
          pixelArr2[x/textSize][y/textSize] = new TextPixel(names[randIndex2], averageColor(x,y));
        }
      }
    }
    
    background(255);
    for (int y=0;y<pixelArr[0].length;y+=1) {
      for (int x=0;x<pixelArr.length;x+=1) {
        pixelArr[x][y].display(x,y+1.2, textSize);
        pixelArr2[x][y].display(x, y+.8, textSize);
      }
    }
    indicesUsed.clear();
    indicesUsed2.clear();
    
    timer+=1;
  }
  
}

color averageColor(int col, int row) {
  int square = 5;
  int sumR=0;
  int sumG=0;
  int sumB=0;
  for (int y=row;y<row+square;y+=1) {
    for (int x=col;x<col+square;x+=1) {
      sumR+=red(img.get(x,y));
      sumG+=green(img.get(x,y));
      sumB+=blue(img.get(x,y));
    }
  }
  return color(sumR/(square*square), sumG/(square*square), sumB/(square*square));
}
