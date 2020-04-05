class AboutMe{
  String Name;
  String Intro;
  PImage Img;   //pic of u
  PImage Background; //Background image
  AboutMe(String n, String i, PImage img, PImage back){
    Name = n;
    Intro = i;
    Img = img;
    Background = back;
  }
  void display(){
    //killua_img = loadImage("killua.png");
    galaxy_img = loadImage("leaves.jpg");
    image(galaxy_img, 0,0, width, height);
    //Name
    fill(255);
    textAlign(CENTER);
    textSize(100);
    textFont(myfont);
    text(Name, width/2,100);  //x,y positions center aligned
    //Intro
    textAlign(CENTER);
    textSize(20);
    text(Intro, btn_side_margin+20, 160, width/2 - 30, 200);
    noFill();
    stroke(255);
    strokeWeight(6);
    rect(btn_side_margin, 140, width/2, height-130-30);
    image(me_img, width/2 + 80, 140, width/3, height/3);
  }
}
