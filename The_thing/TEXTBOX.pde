class Textbox {
  float x, y, w, h;

  boolean selected = false;
  boolean numbersOnly = false;
  boolean lettersOnly = false;

  String text = "";

  Textbox(float xPos, float yPos, float tWidth, float tHeight) {
    x = xPos;
    y = yPos;
    w = tWidth;
    h = tHeight;
  }

  void update(PGraphics ui) {
    if (!selected) {
      ui.strokeWeight(2);
      ui.stroke(50);
      ui.fill(70);
      ui.rect(x, y, w, h);
    } else {
      ui.strokeWeight(2);
      ui.stroke(50);
      ui.fill(90);
      ui.rect(x, y, w, h);
    }

    ui.fill(255);
    ui.textSize(h-6);
    ui.text(this.text, x+w-3-ui.textWidth(this.text), y+h-h/10*2);
  }

  void addToText(char c) {
    strokeWeight(3);
    textSize(h-6);
    if (textWidth(this.text+c) < w-(w/100*12)) {
      byte b = byte(c);

      if (selected) {
        if (lettersOnly) {
          if ((b > 64 && b < 91) || (b > 96 && b < 123)) {
            text += c;
          }
        } else if (numbersOnly) {
          if (b > 47 && b < 58) {
            if (!text.equals("")) {
              text += c;
            } else if (b > 48 && b < 58) {
              text += c;
            }
          } else if (c == '-'){
            if (text.equals("")) {
              text += c;
            }
          }
        } else {
          text += c;
        }
      }
    }
  }

  void setSelected(boolean b) {
    selected = b;
  }

  void setToNumbersOnly(boolean b) {
    numbersOnly = b;
    if (b) {
      lettersOnly = false;
    }
  }

  void setToLettersOnly(boolean b) {
    lettersOnly = b;
    if (b) {
      numbersOnly = false;
    }
  }
  
  void setText(String str) {
    this.text = str;
  }

  String getText() {
    return text;
  }

  boolean getSelected() {
    return selected;
  }

  float getX() {
    return x;
  }

  float getY() {
    return y;
  }

  float getWidth() {
    return w;
  }

  float getHeight() {
    return h;
  }

  boolean getCursorOnBox(float xPos, float yPos) {
    
    if (xPos > x && xPos < x+w && yPos > y && yPos < y+h) {
      return true;
    }
    return false;
  }

  void deleteChracter() {
    if (this.text.length() > 0) {
      this.text = this.text.substring(0, this.text.length()-1);
    }
  }
}
