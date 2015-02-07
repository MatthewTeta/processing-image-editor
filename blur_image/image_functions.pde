//create class called ImageProcessing where all image editing methonds will be
class ImageProcessing {
  //create function "blurImage" which takes in an xOffset, a yOffset, and a blur amount
  //xOffset and yOffset is changing where the grid starts so the make the blurring algorithm less pixelated using other methods when calling this function
  //the blur amount is how big each box in the grid is
  void blurImage(int xOffset, int yOffset, int blurAmount, PImage pic) {
    //loop through x in the image starting at the negative xOffset and incrementing by the blurAmouint / 2
    //the negative xOffset's purpose is to start the offset off the grid so as to blur the whole image no matter the offset
    //incrementing by the blurAmount / 2 is done because it needs to go in both directions
    for (int x = -xOffset; x < pic.width; x += blurAmount / 2) {
      //loop through the same way for the y so that we can got though in 2 dimentions instead of just 1
      for (int y = -yOffset; y < pic.height; y += blurAmount / 2) {
        //create a 2D array called p that is the size of the blur amount, the size of the box; this is the box
        color[][] p = new color[blurAmount][blurAmount];
        //initialize variables that are the averages of each color channel
        int redAverage = 0;
        int greenAverage = 0;
        int blueAverage = 0;
        
        //loop through the blurAmount in both dimentions to refrence all the pixels in the p array
        for (int a = 0; a < blurAmount; a++) {
          for (int b = 0; b < blurAmount; b++) {
            //fill the array with the colors of the current box on the grid so i can refrence them easily
            p[a][b] = pic.get(x + a, y + b);
            //these lines add up the Red Green and Blue channels into their individual variables
            //the "(p[a][b] >> 16) & 0xFF" is first shifting the hexidecimal number over into the correct position and then chopping off the extra bits to the right
            redAverage += this.getColor(p[a][b], 16);
            greenAverage += this.getColor(p[a][b], 8);
            blueAverage += this.getColor(p[a][b], 0);
          }
        }
        
        //dividing the red averages by the square of the blurAmount
        //the squaring is needed to find the area in pixels, this makes the average
        redAverage /= (int)(blurAmount * blurAmount);
        greenAverage /= (int)(blurAmount * blurAmount);
        blueAverage /= (int)(blurAmount * blurAmount);
        
        //create color from the average values
        color blur = color(redAverage, greenAverage, blueAverage);
        
        //loop through the current box on the grid the same way as before
        for (int a = 0; a < blurAmount; a++) {
          for (int b = 0; b < blurAmount; b++) {
            //setting all the pixels in the box to the color of the averages
            //the reason for the "x + a" and the "y + b":
            //find the location of the pixels in the box relative to the top left corner of it
            pic.set(x + a, y + b, blur);
          }
        }
      }  
    }
  }
  
  void blur(float maxBlur, int blur, PImage pic) {
    //first find the blurDecrement so that we will get a smooth transition for the number of iterations of the blur algorithm we have
    float blurDecrement = (maxBlur / blur);
    
    //iterate through blur, the number of times to blur
    for (int i = 0; i < blur; i++) {
      //run blur algorithm at the blurDecrement for the x and y offsets using the maxBlur
      //remember: the maxBlur is also used to store the value after being decremented in the loop
      this.blurImage((int)(blurDecrement), (int)(blurDecrement), (int)(maxBlur), pic);
      
      //decrement maxBlur by the blurDecrement value
      maxBlur = maxBlur - blurDecrement;
    }
  }
  
  int getColor(color c, int shift) {
    return (c >> shift) & 0xFF;
  }
  
  void changeSaturation(float saturation, PImage pic) {
    for (int x = 0; x < pic.width; x++) {
      for (int y = 0; y < pic.height; y++) {
        int redVal;
        int greenVal;
        int blueVal;
        int changeVal = (int)(255 * saturation);
        
        color c = pic.get(x, y);
        
        redVal = this.getColor(c, 16);
        greenVal = this.getColor(c, 8);
        blueVal = this.getColor(c, 0);
        
        if ((saturation <= 1) && (saturation >= 0)) {
          redVal += changeVal;
          greenVal += changeVal;
          blueVal += changeVal;
        } else {
          redVal = 0;
          greenVal = 0;
          blueVal = 0;
        }
        
        if (redVal > 255) {
          redVal = 255;
        }
        if (greenVal > 255) {
          greenVal = 255;
        }
        if (blueVal > 255) {
          blueVal = 255;
        }
        
        
        if (redVal < 0) {
          redVal = 0;
        }
        if (greenVal < 0) {
          greenVal = 0;
        }
        if (blueVal < 0) {
          blueVal = 0;
        }
        
        color newColor = color(redVal, greenVal, blueVal);
        
        pic.set(x, y, newColor);
      }
    }
  }
  
  void changeBrightness(float brightness, PImage pic) {
    for (int x = 0; x < pic.width; x++) {
      for (int y = 0; y < pic.height; y++) {
        int redVal;
        int greenVal;
        int blueVal;
        int changeVal = (int)((-255 * brightness) + 255);
        
        color c = pic.get(x, y);
        
        redVal = this.getColor(c, 16);
        greenVal = this.getColor(c, 8);
        blueVal = this.getColor(c, 0);
        
        if ((brightness <= 1) && (brightness >= 0)) {
          redVal -= changeVal;
          greenVal -= changeVal;
          blueVal -= changeVal;
        } else {
          redVal = 0;
          greenVal = 0;
          blueVal = 0;
        }
        
        if (redVal > 255) {
          redVal = 255;
        }
        if (greenVal > 255) {
          greenVal = 255;
        }
        if (blueVal > 255) {
          blueVal = 255;
        }
        
        
        if (redVal < 0) {
          redVal = 0;
        }
        if (greenVal < 0) {
          greenVal = 0;
        }
        if (blueVal < 0) {
          blueVal = 0;
        }
        
        color newColor = color(redVal, greenVal, blueVal);
        
        pic.set(x, y, newColor);
      }
    }
  }
  
  void detectEdges(PImage pic) {
    for (int x = 0; x < pic.width; x++) {
      for (int y = 0; y < pic.height; y++) {
        color newColor;
        
        int red = this.getColor(pic.get(x, y), 16);
        int green = this.getColor(pic.get(x, y), 8);
        int blue = this.getColor(pic.get(x, y), 0);
        
        int average = (red + green + blue) / 3;
        
        if ((average >= 128) && (average <= 255)) {
          newColor = color(255, 255, 255);
        } else if ((average < 128) && (average >= 0)) {
          newColor = color(0, 0, 0);
        } else {
          newColor = color(255, 255, 0);
        }
        
        pic.set(x, y, newColor);
      }
    }
  }
  
  //0 state = unknown; 1 state = not in selection; 2 = selected
  void wandSelect(int MOUSEX, int MOUSEY, float threshold, int numThreshold, PImage pic) {
    int[][][] Picture = new int[pic.width][pic.height][4];
    int mouseAverage = (this.getColor(pic.get(MOUSEX, MOUSEY), 16) + this.getColor(pic.get(MOUSEX, MOUSEY), 8) + this.getColor(pic.get(MOUSEX, MOUSEY), 0)) / 3;
    
    for (int x = 0; x < pic.width; x++) {
      for (int y = 0; y < pic.height; y++) {
        int r = this.getColor(pic.get(x, y), 16);
        int g = this.getColor(pic.get(x, y), 8);
        int b = this.getColor(pic.get(x, y), 0);
        
        Picture[x][y][0] = r;
        Picture[x][y][1] = g;
        Picture[x][y][2] = b;
        
        int bwAverage = (Picture[x][y][0] + Picture[x][y][1] + Picture[x][y][2]) / 3;
        
        if ((bwAverage < (mouseAverage + threshold)) && (bwAverage > (mouseAverage - threshold))) {
          Picture[x][y][3] = 1;
        } else {
          Picture[x][y][3] = 0;
        }
      }
    }
    
    Picture[MOUSEX][MOUSEY][3] = 2;
    
    for (int passNum = 0; passNum < numThreshold; passNum++) {
      for (int x = 1; x < (pic.width - 1); x++) {
        for (int y = 1; y < (pic.height - 1); y++) {
          if (Picture[x][y][3] == 2) {
            //0: position, 1: r, 2: g, 3: b, 4: state
            //u1 u2 u3
            //u4 o  u5
            //u6 u7 u8
            int[][][] neighbors = new int[3][3][4];
            
            for (int x1 = 0; x1 < 3; x1++) {
              for (int y1 = 0; y1 < 3; y1++) {
//                if ((!(((x1 - 1) < 0) || ((y1 - 1) < 0))) && (!(((x1 + 1) > pic.width) || ((y1 + 1) > pic.height)))) {
                  if (!((x1 == 1) && (y1 == 1))) {
                    neighbors[x1][y1][0] = Picture[x + (x1 - 1)][y + (y1 - 1)][0];
                    neighbors[x1][y1][1] = Picture[x + (x1 - 1)][y + (y1 - 1)][1];
                    neighbors[x1][y1][2] = Picture[x + (x1 - 1)][y + (y1 - 1)][2];
                    
                    neighbors[x1][y1][3] = Picture[x + (x1 - 1)][y + (y1 - 1)][3];
                    
                    if (neighbors[x1][y1][3] == 1) {
                      neighbors[x1][y1][3] = 2;
                    }
                  } else {
                    neighbors[x1][y1][3] = 0;
                  }
                  
                  Picture[x + (x1 - 1)][y + (y1 - 1)][0] = neighbors[x1][y1][0];
                  Picture[x + (x1 - 1)][y + (y1 - 1)][1] = neighbors[x1][y1][1];
                  Picture[x + (x1 - 1)][y + (y1 - 1)][2] = neighbors[x1][y1][2];
                  
                  Picture[x + (x1 - 1)][y + (y1 - 1)][3] = neighbors[x1][y1][3];
//                }
              }
            }
          } else if (Picture[x][y][3] == 0) {
            //0: position, 1: r, 2: g, 3: b, 4: state
            //u1 u2 u3
            //u4 o  u5
            //u6 u7 u8
            int[][][] neighbors = new int[3][3][4];
            
            for (int x1 = 0; x1 < 3; x1++) {
              for (int y1 = 0; y1 < 3; y1++) {
                boolean allX = true;
//                if ((!(((x1 - 1) < 0) || ((y1 - 1) < 0))) && (!(((x1 + 1) > pic.width) || ((y1 + 1) > pic.height)))) {
                  if (!((x1 == 1) && (y1 == 1))) {
                    neighbors[x1][y1][0] = Picture[x + (x1 - 1)][y + (y1 - 1)][0];
                    neighbors[x1][y1][1] = Picture[x + (x1 - 1)][y + (y1 - 1)][1];
                    neighbors[x1][y1][2] = Picture[x + (x1 - 1)][y + (y1 - 1)][2];
                    
                    neighbors[x1][y1][3] = Picture[x + (x1 - 1)][y + (y1 - 1)][3];
                    
                    if (!(neighbors[x1][y1][3] == 1)) {
                      allX = false;
                    }
                  } else {
                    neighbors[x1][y1][3] = 2;
                  }
                  
                  Picture[x + (x1 - 1)][y + (y1 - 1)][0] = neighbors[x1][y1][0];
                  Picture[x + (x1 - 1)][y + (y1 - 1)][1] = neighbors[x1][y1][1];
                  Picture[x + (x1 - 1)][y + (y1 - 1)][2] = neighbors[x1][y1][2];
                  
                  Picture[x + (x1 - 1)][y + (y1 - 1)][3] = neighbors[x1][y1][3];
//                }
              }
            }
          }
        }
      }
    }
    
    for (int x = 0; x < pic.width; x++) {
      for (int y = 0; y < pic.height; y++) {
        if (Picture[x][y][3] == 2) {
          pic.set(x, y, color(255, 0, 0));
        } else if (Picture[x][y][3] == 1) {
          pic.set(x, y, color(0, 0, 0));
        } else {
          pic.set(x, y, pic.get(x, y));
        }
      }
    }
  }
}
