Table dataTable;
String[] names;

void setup() {
  size(800,800);
  dataTable = loadTable("data.csv", "header");
  names = new String[dataTable.getRowCount()];
  int r =0;
  for (TableRow row: dataTable.rows()) {
    names[r] = row.getString("Artist Name");
    r+=1;
  }
  for (int i=0;i<dataTable.getRowCount();i+=1) {
    println(names[i]);
  }
}

void draw() {
  //textSize(16);
  fill(0);
  int x = 0;
  int y = 0;
  for (int i=0;i<names.length;i+=1) {
    if (y*30>781) {
      y=0;
      x+=160;
      text(names[i], x, y, 150,30);
    } else {      
      text(names[i], x, y*30, 150,30);
      y+=1;
    }
  }
}
