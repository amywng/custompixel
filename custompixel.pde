Table dataTable;
String[] names;
PImage img;
int h;
TextPixel[][] pixelArr;
ArrayList<Integer> indicesUsed;

void setup() {
  size(600,400);
  background(color(255));
  
  img = loadImage("img.jpeg");
  img.resize(600,0);
  h = (400-img.height)/2;
  
  println(h);
  dataTable = loadTable("data.csv", "header");
  names = new String[dataTable.getRowCount()];
  int r =0;
  for (TableRow row: dataTable.rows()) {
    names[r] = row.getString("Artist Name");
    r+=1;
  }
  
  pixelArr = new TextPixel[600/10][(400-h)/10+1];
  indicesUsed = new ArrayList<Integer>();
  frameRate(.5);
}

void draw() {
  //image(img, 0,h);
  for (int y = 0;y<400-h;y+=10) {
    for (int x = 0;x<600;x+=10) {
      int randIndex = (int) random(0,names.length);
      while (indicesUsed.contains(randIndex)) {
        randIndex = (int) random(0,names.length);
      }
      indicesUsed.add(randIndex);
      pixelArr[x/10][y/10] = new TextPixel(names[randIndex], averageColor(x,y));
    }
  }
  
  background(255);
  for (int y=0;y<pixelArr[0].length;y+=1) {
    for (int x=0;x<pixelArr.length;x+=1) {
      pixelArr[x][y].display(x,y);
    }
  }
  indicesUsed.clear();
}

color averageColor(int col, int row) {
  int sumR=0;
  int sumG=0;
  int sumB=0;
  for (int y=row;y<row+10;y+=1) {
    for (int x=col;x<col+10;x+=1) {
      sumR+=red(img.get(x,y));
      sumG+=green(img.get(x,y));
      sumB+=blue(img.get(x,y));
    }
  }
  return color(sumR/100, sumG/100, sumB/100);
}
