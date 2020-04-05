class Button {
  //Position
  PVector Pos = new PVector(0,0);
  float Width = 0;
  float Height = 0;
  color Color;
  color Shadow;
  String Text;
  Boolean Pressed = false;
  Boolean Clicked = false;
  Boolean Hovering = false;
  Boolean Released = false;
  
  //Constructor
  Button(int x, int y, int w, int h, String t, color c, color s){
    Pos.x = x;
    Pos.y = y;
    Width = w;
    Height = h;
    Color = c;
    Shadow = s;
    Text = t;
  }
  //Must run in void draw
  void update(){
    if(mouseButton == LEFT && Pressed == false){
      Pressed = true;
      //Barriers of button
      if( mouseX>=Pos.x && mouseX <=Pos.x+Width && mouseY >=Pos.y && mouseY <= Pos.y + Height){
        Clicked = true;
        Released = false;
      }
    }
    else if(mouseX>=Pos.x && mouseX <=Pos.x+Width && mouseY >=Pos.y && mouseY <= Pos.y + Height){
      Hovering = true;  
    }
    else{
      Hovering = false;
      Clicked = false;
      Pressed = false;
    }
  }
  //Muse be placed in void draw
  void render(){
    //Fill sets the color of immediately following 
    fill(Color);
    if(Color == white){
      noFill();
    }
    strokeWeight(5); 
    stroke(255);
    rect(Pos.x, Pos.y, Width, Height);
    //Set text
    fill(255);
    textFont(myfont);
    textAlign(CENTER, CENTER);
    textSize(20);
    text(Text, Pos.x+(Width/2), Pos.y+(Height/2));
  }
  
    void display_shadow(){
    //Fill sets the color of immediately following 
    fill(Shadow);
    if(Color == white){
      fill(black, 100);
    }
    strokeWeight(5); 
    stroke(255);
    rect(Pos.x, Pos.y, Width, Height);
    //Set text
    fill(255);
    textFont(myfont);
    textAlign(CENTER, CENTER);
    textSize(20);
    text(Text, Pos.x+(Width/2), Pos.y+(Height/2));
  }
  
  //For if statements to check if button was clicked
  boolean isClicked(){
    return Clicked;
  }
  boolean isHovering(){
    return Hovering;
  }
}
