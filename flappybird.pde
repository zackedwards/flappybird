
PImage daybackground, ground, birdUpMiddle, birdDownMiddle, birdMidMiddle;
PImage birdUpFaceUp, birdDownFaceUp, birdMidFaceUp, birdUpFaceDown, birdDownFaceDown, birdMidFaceDown;
PImage upperObstacle, lowerObstacle;
int gx, bgy, finalbgy, flap, rotation;
int gameState = 0;
int gy = 620-70;
int[] pipex = new int[3];
int[] pipey = new int[pipex.length];
float grav, v, angle1;
//declare ArrayLists of bird flapping animations for 3 tilts
ArrayList<PImage> birdStraight = new ArrayList<PImage>();
ArrayList<PImage> birdFaceUp = new ArrayList<PImage>();
ArrayList<PImage> birdFaceDown = new ArrayList<PImage>();

void setup()
{
  size(350, 620);
  setupBackground();
  setupBird();
  setupObstacles();
}

void draw() {
  if(gameState==0)
  {
    drawBackground();
    drawObstacles();
    drawGround();
    drawBird();
  }
  else
  {
    text("YOU LOSE", 20, 100);
  }
    
}

//Draw and animate the background
//Acts in Draw
void drawBackground()
{
  image(daybackground, 0, 0);
}

void drawGround()
{
  image(ground, gx, gy);
  image(ground, gx + ground.width, gy);
  gx = gx -1;
  if (gx < -ground.width)
  {
    gx=0;
  }
}


//Create obstacles
void setupObstacles() {
  upperObstacle = loadImage("./img/upperObstacle.png");
  lowerObstacle = loadImage("./img/lowerObstacle.png");
  
  for(int i = 0; i < pipex.length; i++) {
    pipex[i] = width + 200*i;
    pipey[i] = (int)random(-350,0);
  }
}

//Animate obstacles
void drawObstacles()
{
  int gap = 460;
  int bgx = (daybackground.width)/2-40;
  for(int i = 0; i < pipex.length; i++) {
    image(upperObstacle, pipex[i], pipey[i]);
    image(lowerObstacle, pipex[i], pipey[i] + gap);
    int gameSpeed = 1;
    pipex[i] -= gameSpeed;
    
    if(pipex[i] < -250)
    {
      pipex[i] = width; 
    }
    //stroke(0);   //border for testing
    //rect(pipex[i]-64, pipey[i] + 300, pipex[i] + 64, pipey[i] + 100);
    if(bgx > pipex[i] - 64 && bgx < pipex[i] + 64)
    {
      if(!(bgy+10 > pipey[i] + 300) || !(bgy-10 < pipey[i] + 300 + 100))
      {
        gameState = 1;
      }
    }
  }
}

//Code related to the birds position/flap/rotation
//acts in the Draw
void drawBird() {
  //when bird reached apex of parabola
  int bgx = (daybackground.width)/2-40;
  if (rotation > 0) {
    image(birdFaceUp.get(flap), bgx, bgy);
  } else if (rotation <= 0 && rotation > -20) {
    image(birdStraight.get(flap), bgx, bgy);
  } else if(rotation <= -20){
    image(birdFaceDown.get(flap), bgx, bgy);
  }
  //stroke(0);  //border for testing
  //rect(bgx, bgy, birdMidMiddle.width, birdMidMiddle.height);
  
  //temporary collision logic
  if (bgy + 73 < gy + 10) { //if above ground
    v = v - grav;
    bgy = bgy + int(v);
  } else {
    bgy = gy - 60; //ground collision
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
  v = -10;
  rotation = 20;
}

//This function imports the images of the bird
//and animates the flaps and rotations
//acts in the Setup
void setupBird() {
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
void setupBackground(){

  daybackground = loadImage("./img/daybackground.png");
  ground = loadImage("./img/ground.png");
}
