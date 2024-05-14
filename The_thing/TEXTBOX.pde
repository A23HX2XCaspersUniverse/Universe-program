class Textbox { //https://www.youtube.com/watch?v=N753XIKAUPo
  float x, y, w, h;

  boolean selected = false;
  boolean numbersOnly = false;
  boolean lettersOnly = false;

  String text = "";

  //konstruktør
  Textbox(float xPos, float yPos, float tWidth, float tHeight) {
    x = xPos;
    y = yPos;
    w = tWidth;
    h = tHeight;
  }

  //funktion der opdatere teksboksens indhold
  void update(PGraphics ui) {

    //Sætter farven alt efter om tekstboksen er "selected"
    if (!selected) {
      ui.fill(70);
    } else {
      ui.fill(90);
    }
    
    //tegner tekstboksen
    ui.strokeWeight(2);
    ui.stroke(50);
    ui.rect(x, y, w, h);

    //Skriver indholdet i tekstboksen
    ui.fill(255);
    ui.textSize(h-6);
    ui.text(this.text, x+w-3-ui.textWidth(this.text), y+h-h/10*2);
  }
  
  //funktion der tilføjer tekst til tekstboksen
  void addToText(char c) {
    strokeWeight(3);
    textSize(h-6);
    
    if (textWidth(this.text+c) < w-(w/100*12)) { //tjekker om teskten med den nye char er for lang
      byte b = byte(c); //omlaver char til byte
      
      if (selected) { //tjekker om tekstboksen er "selected"
      
        if (lettersOnly) { //tjekker om tekstboksen kun indeholder bogstaver
          if ((b > 64 && b < 91) || (b > 96 && b < 123)) { //tjekker om charen er et bogstav
            text += c; //tilføjer char
          }
          
        } else if (numbersOnly) { //tjekker om tekstboksen kun indeholder tal
          if (b > 47 && b < 58) { //tjekker om charen er et tal
          
            if (!text.equals("")) { //tjekker om tekstboksen indeholder noget endnu
              text += c; //tilføjer char
            } else if (b > 48 && b < 58) { //tjekker om tallet er over 0
              text += c; //tilføjer char
            }
            
          } else if (c == '-') { //tjekker om charen er et minus
          
            if (text.equals("")) { //tjekker om tekstboksen indeholder noget endnu
              text += c; //tilføjer char
            }
            
          }
        } else {
          text += c; //tilføjer char
        }
      }
    }
  }
  
  //funktion der setter "selected# til eller fra
  void setSelected(boolean b) {
    selected = b;
  }
  
  //setter tekstboksen til kun tal
  void setToNumbersOnly(boolean b) {
    numbersOnly = b;
    if (b) {
      lettersOnly = false;
    }
  }
  
  //setter tesktboksen til kun bogstaver
  void setToLettersOnly(boolean b) {
    lettersOnly = b;
    if (b) {
      numbersOnly = false;
    }
  }
  
  //setter tekstboksens indhold til noget bestemt
  void setText(String str) {
    this.text = str;
  }
  
  //returnerer tesktboksens indhold
  String getText() {
    return text;
  }
  
  //returnerer "selected"
  boolean getSelected() {
    return selected;
  }
  
  //returnerer x-positionen
  float getX() {
    return x;
  }
  
  //returnerer y-positionen
  float getY() {
    return y;
  }
  
  //returnerer breden
  float getWidth() {
    return w;
  }
  
  //returnerer højden
  float getHeight() {
    return h;
  }
  
  //funktion der ændrer markøren efter om den er over en takstboks
  void cursorOnBox(float xPos, float yPos) {

    if (xPos > x && xPos < x+w && yPos > y && yPos < y+h) {
      foundTextbox = true;
      cursor(TEXT);
    }
    
  }
  
  //funktion der sletter en char fra tekstboksens indhold
  void deleteChracter() {
    
    if (this.text.length() > 0) { //tjekker om tekstboksen ikke er nul
      this.text = this.text.substring(0, this.text.length()-1);
    }
  }
}
