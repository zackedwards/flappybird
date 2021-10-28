//delcare global variables
PImage daybackground, ground, birdUpMiddle, birdDownMiddle, birdMidMiddle;
PImage birdUpFaceUp, birdDownFaceUp, birdMidFaceUp, birdUpFaceDown, birdDownFaceDown, birdMidFaceDown;
PImage higher_obstacle, lower_obstacle;
int gx, bgy, finalbgy, flap, rotation;
int[] obstacle_width, obstacle_length;
float grav, v, angle1;
//declare ArrayLists of bird flapping animations for 3 tilts
ArrayList<PImage> birdStraight = new ArrayList<PImage>();
ArrayList<PImage> birdFaceUp = new ArrayList<PImage>();
ArrayList<PImage> birdFaceDown = new ArrayList<PImage>();
void setup()
{
  size(350, 620);
 
  daybackground = loadImage("./img/daybackground.png");
  ground = loadImage("./img/ground.png");
  higher_obstacle = loadImage("./img/obstacle.png");
  lower_obstacle = loadImage("./img/obstacle.png");
  obstacle_width = new int[5];  
  obstacle_length = new int[obstacle_width.length];
  
  for(int i = 0; i < obstacle_width.length; i++)
  {
    obstacle_width[i] = width + 200*i;
    obstacle_length[i] = (int)random(-350, 0);
  } 
  generateBird();
}

void draw() {
  setBackground();
  setBird();
  for(int i = 0; i < 100; i++)
  {
    
    if (i == 0)
    {
      image(higher_obstacle, i*35, 0);
    image(lower_obstacle, i*35, 360);
    }
    else if (i % 3 == 0)
    {
    image(higher_obstacle, i*35, 20);
  image(lower_obstacle, i*35, 340);
    }
    
    else if (i % 4 == 0)
    {
    image(higher_obstacle, i*35, 40);
  image(lower_obstacle, i*35, 320);
    }
    
    else if (i % 5 == 0)
    {
    image(higher_obstacle, i*35, 60);
  image(lower_obstacle, i*35, 300);
    }
    
    else if (i % 7 == 0)
    {
    image(higher_obstacle, i*35, -20);
  image(lower_obstacle, i*35, 360);
    }
    
    else
    {
        image(higher_obstacle, i*35, 0);
    image(lower_obstacle, i*35, 360);
    }
  
 
  
  
  }  
  
}

//Draw and animate the background
//Acts in Draw
void setBackground()
{
  image(daybackground, 0, 0);
  image(ground, gx, 620-119);
  image(ground, gx + ground.width, 620-119);
  gx = gx -1;
  if (gx < -ground.width)
  {
    gx=0;
  }
}

//Code related to the birds position/flap/rotation
//acts in the Draw
void setBird() {
  //when bird reached apex of parabola
  if (rotation > 0) {
    image(birdFaceUp.get(flap), (daybackground.width)/2-40, bgy);
  } else if (rotation <= 0 && rotation > -20) {
    image(birdStraight.get(flap), (daybackground.width)/2-40, bgy);
  } else if(rotation <= -20){
    image(birdFaceDown.get(flap), (daybackground.width)/2-40, bgy);
  }
  
  //temporary collision logic
  if (bgy <= 400) {
    v = v - grav;
    bgy = bgy + int(v);
  } else {
    bgy = 401;
  }
  if (flap == 8) {
    flap = 0;
  }
  flap++;
  rotation--;
}

//This function acts as the controls
//acts in Draw
void keyPressed() {
  v = -15;
  rotation = 20;
  //temporary ground collision
  if (bgy == 401) {
    bgy = 399;
  }
}

//This function imports the images of the bird
//and animates the flaps and rotations
//acts in the Setup
void generateBird() {
  //loading in all the image files
  birdUpMiddle = loadImage("./img/birdupMiddle.png");
  birdMidMiddle = loadImage("./img/birdmidMiddle.png");
  birdDownMiddle = loadImage("./img/birddownMiddle.png");
  ArrayList<PImage> middleFlappingAnimations = new ArrayList<PImage>();
  middleFlappingAnimations.add(birdUpMiddle);
  middleFlappingAnimations.add(birdMidMiddle);
  middleFlappingAnimations.add(birdDownMiddle);

  birdUpFaceUp = loadImage("./img/birdupFaceUp.png");
  birdMidFaceUp = loadImage("./img/birdmidFaceUp.png");
  birdDownFaceUp = loadImage("./img/birddownFaceUp.png");
  ArrayList<PImage> UpwardFlappingAnimations = new ArrayList<PImage>();
  UpwardFlappingAnimations.add(birdUpFaceUp);
  UpwardFlappingAnimations.add(birdMidFaceUp);
  UpwardFlappingAnimations.add(birdDownFaceUp);

  birdUpFaceDown = loadImage("./img/birdupFaceDown.png");
  birdMidFaceDown = loadImage("./img/birdmidFaceDown.png");
  birdDownFaceDown = loadImage("./img/birddownFaceDown.png");
  ArrayList<PImage> DownwardFlappingAnimations = new ArrayList<PImage>();
  DownwardFlappingAnimations.add(birdUpFaceDown);
  DownwardFlappingAnimations.add(birdMidFaceDown);
  DownwardFlappingAnimations.add(birdDownFaceDown);

  //Adding animations to 3 lists which
  //represent the 3 tilts of animations
  for (int p = 0; p < 3; p++) {
    if (p == 0) {
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          birdStraight.add(middleFlappingAnimations.get(i));
        }
      }
    } 
    else if (p == 1) {
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          birdFaceUp.add(UpwardFlappingAnimations.get(i));
        }
      }
    } 
    else {
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          birdFaceDown.add(DownwardFlappingAnimations.get(i));
        }
      }
    }
  }
  //declaring important variables for the bird
  grav = -1;
  bgy = 100;
  flap = 0;
}
