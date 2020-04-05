class Drive{
  //Bluetooth
  Serial serial_port;
  
  //Constants
    int radius = 10;
    int x = width/2;
    int y = height/2;
    int circle_radius = 30;
    
    float x_top_bottom = width - 2.75*btn_side_margin;
    float x_left = x_top_bottom - 25;
    float x_right = x_top_bottom + 25;
    float y_top = (height/4 + 8*btn_top_margin);
    float y_bottom = y_top - 3*btn_top_margin;
    float y_left_right = (y_top + y_bottom)/2;
    
    float x_joy = x_top_bottom;
    float y_joy = y_bottom + 150;
    
    float x_rect = 2.7*btn_side_margin;
    float y_rect = y_joy;
    float rect_width = 25;
    float rect_height = 3.25*rect_width;
    float y_joy_left = y_left_right;
    float x_joy_left = x_rect;
    
  Drive(){}
  
  Drive(Serial sp){
    serial_port = sp;
    serial_port.bufferUntil('\n');
  }
  void display(){
    fill(light_blue);
    noStroke();
    rect(0,0,width,height);
    display_controller();
  }
  void display_controller(){
    int radius = 10;
    int x = width/2;
    int y = height/2;
    int circle_radius = 30;
    //Base
    fill(red);
    rectMode(CENTER);
    rect(x, y, width - 2*btn_side_margin, height/2 - 2*btn_top_margin, radius);
    
    //Controller Right
    fill(teal);
    rectMode(CORNER);
    rect(btn_side_margin, height/4 + btn_top_margin, width/2, height/2 - 2*btn_top_margin, radius);
     //Circles
    fill(black);
    float x_top_bottom = width - 2.75*btn_side_margin;
    float x_left = x_top_bottom - 25;
    float x_right = x_top_bottom + 25;
    float y_top = (height/4 + 8*btn_top_margin);
    float y_bottom = y_top - 3*btn_top_margin;
    float y_left_right = (y_top + y_bottom)/2;
    
    float x_joy = x_top_bottom;
    float y_joy = y_bottom + 150;
    
    circle(x_top_bottom, y_top, circle_radius); //bottom circle
    circle(x_top_bottom, y_bottom, circle_radius); //top circle
    circle(x_left,y_left_right, circle_radius); //left circle
    circle(x_right,y_left_right, circle_radius); //right circle
    
    fill(white);
    text("B", x_top_bottom, y_top);
    text("A", x_right, y_left_right);
    text("Y", x_left, y_left_right);
    text("X", x_top_bottom, y_bottom);
    
    fill(black);
    circle(x_joy, y_joy, circle_radius*2);
    fill(gray);
    circle(x_joy, y_joy, circle_radius*1.75);
    
    //Controller Left
    fill(black);
    float x_rect = 2.7*btn_side_margin;
    float y_rect = y_joy;
    float rect_width = 25;
    float rect_height = 3.25*rect_width;
    float y_joy_left = y_left_right;
    float x_joy_left = x_rect;
    rectMode(CENTER);
    rect(x_rect, y_rect, rect_width, rect_height);
    rect(x_rect, y_rect, rect_height, rect_width);
    
    fill(black);
    circle(x_joy_left, y_joy_left, circle_radius*2);
    fill(gray);
    circle(x_joy_left, y_joy_left, circle_radius*1.75);
    //Screen
    fill(black);
    rectMode(CENTER);
    rect(x, y, width - width/3, height/2 - 2*btn_top_margin);
    rectMode(CORNER);
  }
  void button_press(int button){
    fill(light_blue);
    if(button == B){
      circle(x_top_bottom, y_top, circle_radius); //bottom circle
      fill(white);
      text("B", x_top_bottom, y_top);
      serial_port.write('S');
    }
    else if(button == X){
      circle(x_top_bottom, y_bottom, circle_radius); //top circle
      fill(white);
      text("X", x_top_bottom, y_bottom);
      serial_port.write('X');
    }
    else if(button == A){
      circle(x_right,y_left_right, circle_radius); //right circle
      fill(white);
      text("A", x_right, y_left_right);
      serial_port.write('A');
    }
    else if(button == Y){
      circle(x_left,y_left_right, circle_radius); //left circle
      fill(white);
      text("Y", x_left, y_left_right);
      serial_port.write('Y');
    }
  }
  void drive(int direction){
    rectMode(CENTER);
    fill(light_pink);
    noStroke();
      if(direction== FORWARD)
      {
        text("FORWARD", width/2, height/2);
        rect(x_rect, y_rect - 20, rect_width/2, rect_height/2); //up
        serial_port.write('F');
      }
      else if(direction== BACKWARD)
      {
        text("BACKWARD", width/2, height/2);
        rect(x_rect, y_rect + 20, rect_width/2, rect_height/2); //down
        serial_port.write('B');
      }
      else if(direction ==  D_LEFT)
      {
        text("LEFT", width/2, height/2);
        rect(x_rect-20, y_rect, rect_height/2, rect_width/2); //left
        serial_port.write('L');
      }
      else if(direction== D_RIGHT)
      {
        text("RIGHT", width/2, height/2);
        rect(x_rect+20, y_rect, rect_height/2, rect_width/2); //right
        serial_port.write('R');
      }
    rectMode(CORNER);
  }
}
