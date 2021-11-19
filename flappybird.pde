PImage daybackground, ground, birdUpMiddle, birdDownMiddle, birdMidMiddle, birdUpFaceDown;
PImage birdUpFaceUp, birdDownFaceUp, birdMidFaceUp, birdDownFaceDown, birdMidFaceDown;
PImage upperObstacle, lowerObstacle, gameOver, title, start;
int gx, bgy, finalbgy, flap, rotation;
int gameState = 2;
int gy = 620-70;
int l = 0; //obstacle location
int score;
int[] pipex = new int[3]; //changes amount of pipe variation, might cause issues
int[] pipey = new int[pipex.length];
float grav, v, angle1;
PFont font;

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
  setupMenu();
}

void draw() {
  if(gameState==0)
  {
    drawBackground();
    drawObstacles();
    drawGround();
    drawBird();
    scoreCounter();
  }
  else if (gameState==1)
  {
    image(gameOver, (daybackground.width/2)-(gameOver.width/2), 100);
  }
  else if (gameState==2)
  {
    drawBackground();
    drawGround();
    drawMenu();
  }
    
}

void scoreCounter()
{
  fill(0);
  font = createFont("04B_19__.TTF", 32);
  textFont(font);
  text("SCORE: " + score, width-140, 40);
}
    
void drawMenu()
{
  image(title, 25, 100);
  image(start, (daybackground.width/2)-(start.width/2), 250);
  
  int bgx = (daybackground.width)/2-40;
  image(birdStraight.get(flap), bgx, bgy);
  if (flap == 8) {
    flap = 0;
  }
  flap++;
  if(bgy == 400)
  {
    v = -10;
  }
  v = v - grav;
  bgy = bgy + int(v);
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
  setPipeLocations();
}

void setPipeLocations()
{
  for(int j = 0; j < pipex.length; j++) {
    pipex[j] = width + 200*j;
    pipey[j] = (int)random(-350,50); //might need editing
  }
}

//Animate obstacles
void drawObstacles()
{
  int gap = 460;
  int bgx = (daybackground.width)/2-40;
  for(l = 0; l < pipex.length; l++) {
    image(upperObstacle, pipex[l], pipey[l]);
    image(lowerObstacle, pipex[l], pipey[l]-500);
    image(lowerObstacle, pipex[l], pipey[l] + gap);
    int gameSpeed = 1;
    pipex[l] -= gameSpeed;
    if(pipex[l] < -250)
    {
      pipex[l] = width; 
    }
    collisionLogic();
  }
}

void collisionLogic()
{
  int bgx = (daybackground.width)/2-40;
  //collision logic
  //stroke(0);   //border for testing
  //rect(pipex[i]-64, pipey[i] + 300, pipex[i] + 64, pipey[i] + 100);
  if(bgx > pipex[l] - 64 && bgx < pipex[l] + 64)
  {
    if(!(bgy+10 > pipey[l] + 300) || !(bgy-10 < pipey[l] + 300 + 100))
    {
      gameState = 1;
    }
    else if (bgx == pipex[l]) {
      score++;
    }
  }
}

//Code related to the birds position/flap/rotation
//acts in the Draw
void drawBird() {
  int bgx = (daybackground.width)/2-40;
  //when bird reached apex of parabola
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
    gameState = 1; //ground collision
  }
  //flap/rotation logic
  if (flap == 8) {
    flap = 0;
  }
  flap++;
  rotation--;
}
      
//This function acts as the controls
//acts in Draw
void keyPressed() {
  //start the game
  if(gameState==2)
  {
    gameState=0;
  }
  if(gameState==1)
  {
    bgy = 400;
    setPipeLocations();
    gameState=2;
    score = 0;
  }
  //jump
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
  bgy = 400;
  flap = 0;
}
void setupBackground(){

  daybackground = loadImage("./img/daybackground.png");
  ground = loadImage("./img/ground.png");
}

void setupMenu()
{
  gameOver = loadImage("./img/gameOver.png");
  title = loadImage("./img/flappyBirdTitle.png");
  start = loadImage("./img/start.png");
}
