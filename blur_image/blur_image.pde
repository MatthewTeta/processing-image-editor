/*
//The purpose of this program is to create a blurring algorithm that can
 //adjust to pixelate or blur the image at different levels.
 //
 //We first need to split th image into a grid and work with each box on the grid individually.
 //After this we get all the color values from each pixel in the box and store it in our code.
 //We can then add all the reds together, the greens together, and the blues together and divide each by the number of pixels.
 //Next, we turn all the three average into a color variable and set all the pixels in the current box the that color
 //
 //If we run this multiple times, we can change the blur amount each time and offset the grid to get less pixelated results, we can get a smoother image.
 //
 //Kwown Issues:
 //none so far
 //
 //Created by Matthew Teta
 */

//create instance of my ImageProcessing claa
ImageProcessing i = new ImageProcessing();

//Make sketch full screen
boolean sketchFullScreen() {
  return true;
}

//initialize image
PImage picture;

void setup() {
  //load image from file and save it into pic PImage
  picture = loadImage("image.jpg");
  //create window at size of picture
  size(picture.width, picture.height);
  background(255);
  frameRate(1);
}
//maxBlur is the starting variable for the blur; TL;DR sets the first size of the grid boxes; also used for the temperary blur value running later in my code
float maxBlur = 2;
//initialize the blurDecrement
int blurDecrement = 0;
//create variable that is the amount of times the blurring algorithm is run
//RECOMENDATION: make the blur half of the maxBlur
//the lower the value the more pixelated
int blur = 1;
//simple boolean so that my code for running the blur is only run once at the beginning
boolean first = true;

float sat = 0;

void draw() {
  //calling "first()" if this is the first iteration
  if (first) {
    first();
  }

  //save image in file called "blurred-img" as a jpg
  //  picture.save("blurred-img.jpg");

  //setting the variable for running the code once to false so that is won't be run again
  first = false;
}

//create function first that is only run one time when the program is run
void first() {  
//  i.blur(maxBlur, blur, picture);
//  i.detectEdges(picture);
  

  //draw the image on the canvas at the top left point, (0, 0)
  image(picture, 0, 0);
}


void mouseClicked() {
  i.wandSelect(mouseX, mouseY, 100.0, 40, picture);
  image(picture, 0, 0);
}
