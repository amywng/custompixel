public enum Size { 
   SHORT, MEDIUM, LONG
 } 
 
public class TextPixel {
 Size size;
 String text;
 color c;
 
 TextPixel(String s, color c) {
   this.text = s;
   this.c = c;
   if (s.length() <= 6) {
     this.size = Size.SHORT;
   } else if (s.length() <= 12) {
     this.size = Size.MEDIUM;
   } else {
     this.size = Size.LONG;
   }
 }
 
 void display(int x, int y, int textSize) {
   textSize(textSize);
   fill(this.c);
   if (y==0) {
   } else {
     text(this.text, (x-1)*(textSize),(y+.3)*(textSize));
   }
   
 }
}
