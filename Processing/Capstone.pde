import processing.serial.*;
//Constants
PFont myfont;
PFont title_font;
int font_base_size = 60;
int btnX;
int btn_top_margin = 20;
int btn_side_margin = 30;

int rect_width = 100;
int rect_height = 50;
  
Button about_btn;
Button drive_car_btn;
Button funct_btn;
Button back_btn;
AboutMe about_page;
Drive drive_page;
PImage me_img;
PImage mountain_img;
PImage killua_img;
PImage galaxy_img;
boolean onAbout = false;
boolean prevHoverState = false;

boolean onHome= true;
boolean onDrive = false;
boolean prevAboutState = false;
boolean prevDriveState = false;
boolean prevFunctState = false;

Serial myPort;

void serialEvent(Serial myPort){ // Checks for available data in the Serial Port
  String read_string = myPort.readStringUntil('\n'); //Reads the data sent from the Arduino (the String "LED: OFF/ON) and it puts into the "ledStatus" variable
  print(read_string);
}

//but if you want to detect arrow keys, backspace, tab, enter, delete
//key=CODED if non alphanumeric key was pressed. keyCode has the coded key
void display_home(){
  //Background
  background(21, 224, 169);
  me_img = loadImage("me.jpg");
  mountain_img = loadImage("mountain_background.jpg");
  
  //Background image
  image(mountain_img, 0, 0, width, height/2);
  
  //Navigation Bar
  noFill();
  noStroke();
  rect(0,0,width, rect_height);
  
  //Buttons on Nav
  drive_car_btn = new Button(btn_side_margin, btn_top_margin, rect_width, rect_height, "DRIVE", light_pink, dark_pink);
  btnX =  2*btn_side_margin + rect_width;
  about_btn = new Button(btnX, btn_top_margin, rect_width, rect_height, "ABOUT", teal,dark_teal);
  btnX = 3*btn_side_margin + 2*rect_width;
  funct_btn = new Button(btnX, btn_top_margin, rect_width, rect_height, "FUNCT",yellow, dark_yellow);
  btnX = 4*btn_side_margin + 3*rect_width;
  
  //Display buttons
  drive_car_btn.render();
  about_btn.render();
  funct_btn.render();
  
  //Title
  title_font = createFont("CourierNewPS-BoldMT",20);
  textFont(title_font);
  textSize(45);
  textAlign(LEFT, TOP);
  text("Orange Tesla",btnX, btn_top_margin );
}

//void mouseReleased() {
//  println("released");
//  drive_car_btn.Released = true;
//}
  
void setup() {
  //String[] fontList = PFont.list();
  //printArray(fontList);
  myPort = new Serial(this, "/dev/cu.HC-05-DevB", 9600);
  //myPort.bufferUntil('\n'); // Defines up to which character the data from the serial port will be read. The character '\n' or 'New Line'
  size(800, 800);
  myfont = createFont("PTSans-Bold",font_base_size);
  about_page = new AboutMe("J A C K I E", "I am a Junior at UCLA and I love OPS so much <3. My major is Computer Engineering and I really don't know what I am going to do with my life hahahha ", me_img, killua_img);
  drive_page = new Drive(myPort);
  back_btn = new Button(btn_side_margin, 3*btn_top_margin + 10, rect_width, rect_height, "BACK", white, white);//51, 153, 51);
  //Home Page
  display_home();
}

void draw() {
  about_btn.update();
  drive_car_btn.update();
  funct_btn.update();
  back_btn.update();
  if(onHome == true){
    //Hover about
    if(about_btn.isHovering() == true && prevAboutState == false){
      //Make dark
      prevAboutState = true;
      about_btn.display_shadow();
    }
    //Hover drive
    if(drive_car_btn.isHovering() == true && prevDriveState == false){
      println("hovering drive");
      prevDriveState = true;
      drive_car_btn.display_shadow();
    }
    //Hover funct
    if(funct_btn.isHovering() == true && prevFunctState == false){
      prevFunctState = true;
      funct_btn.display_shadow();
    }
    else if(about_btn.isHovering() == false && drive_car_btn.isHovering() == false && funct_btn.isHovering() == false){
      display_home();
      prevAboutState = false;
      prevDriveState = false;
      prevFunctState = false;
    }
    if(about_btn.isClicked() == true){
      about_page.display();
      back_btn.render();
      onAbout = true;
      onHome = false;
      onDrive = false;
    }
    if(drive_car_btn.isClicked()==true){
      println("drive");
      drive_page.display();
      back_btn.render();
      onAbout = false;
      onHome = false;
      onDrive = true;
    }
  }
  else if (onAbout == true){
    if(back_btn.isHovering() == true && prevHoverState == false){
      back_btn.display_shadow();
      prevHoverState = true;
    }
    else if(back_btn.isHovering() == false){
      about_page.display();
      back_btn.render();
      prevHoverState = false;
    }
    if(back_btn.isClicked() == true){
    onAbout = false;
    onDrive = false;
    onHome = true;
    display_home();
    }
  }
  else if(onDrive == true){
    if(back_btn.isHovering() == true && prevHoverState == false){
      back_btn.display_shadow();
      prevHoverState = true;
    }
    if(keyPressed == true){
      if(key == 'W' || key == 'w'){
        drive_page.drive(FORWARD);
      }
      else if(key == 'S'|| key == 's'){
        drive_page.drive(BACKWARD);
      }
      else if(key == 'A' || key == 'a'){
        drive_page.drive(D_LEFT);
      }
      else if(key == 'D' || key == 'd'){
        drive_page.drive(D_RIGHT);
      }
      else if(key == 'J' || key == 'j'){
        drive_page.button_press(Y);
      }
      else if(key == 'I' || key == 'i'){
        drive_page.button_press(X);
      }
      else if(key == 'K' || key == 'k'){    //B
        drive_page.button_press(B);
      }
      else if(key == 'L' || key == 'l'){    //A
        drive_page.button_press(A);
      }
    }
    else if(back_btn.isHovering() == false){
      drive_page.display();
      back_btn.render();
      prevHoverState = false;
    }
    if(back_btn.isClicked() == true){
      println("back");
      onAbout = false;
      onDrive = false;
      onHome = true;
      display_home();
    }
  }
  
}
