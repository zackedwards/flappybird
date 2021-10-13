PImage daybackground, ground;
int gx;
void setup() 
{
  size(350,620);
  daybackground = loadImage("./img/daybackground.png");
  ground = loadImage("./img/ground.png");
}

void draw() {
  setBackground();
}

void setBackground()
{
  image(daybackground,0,0);
  image(ground,gx,620-119);
  image(ground,gx + ground.width,620-119);
  gx = gx -1;
  if(gx < -ground.width)
  {
    gx=0;
  }
}
