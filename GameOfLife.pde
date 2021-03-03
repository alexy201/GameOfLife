import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
private Life[][] buttons; //2d array of Life buttons each representing one cell
private boolean[][] buffer; //2d array of booleans to store state of buttons array
private boolean running = true; //used to start and stop program
public final static int NUM_ROWS = 20, NUM_COLS = 20;
public static int framerate = 5;

public void setup () {
  size(400, 400);
  frameRate(6);
  // make the manager
  Interactive.make( this );

  //your code to initialize buttons goes here
  buttons = new Life[NUM_ROWS][NUM_COLS];
  for (int i = 0; i < NUM_ROWS; i++){
   for (int j = 0; j < NUM_COLS; j++){
     buttons[i][j] = new Life(i, j);
   }
  }
  //your code to initialize buffer goes here
  buffer = new boolean[NUM_ROWS][NUM_COLS];
  }

  public void draw () {
  frameRate(framerate);
  background( 0 );
  if (running == false) //pause the program
   return;
  copyFromButtonsToBuffer();

  //use nested loops to draw the buttons here
  for (int i = 0; i < NUM_ROWS; i++){
     for (int j = 0; j < NUM_COLS; j++){
       if (countNeighbors(i, j) == 3){
         buffer[i][j] = true;
       }else if (countNeighbors(i, j) == 2 && buttons[i][j].getLife() == true){
         buffer[i][j] = true;
       }else {
         buffer[i][j] = false;
       }  
     }
  }
  copyFromBufferToButtons();

  for (int i = 0; i < NUM_ROWS; i++){
    for (int j = 0; j < NUM_COLS; j++){
      buttons[i][j].draw();
    }
  }

}

public void keyPressed() {
 if (key == ' '){running = !running;}
 if (key == 'x'){
   buffer = new boolean[NUM_ROWS][NUM_COLS];
   copyFromBufferToButtons();
 }
 if (key == CODED) {
   if (keyCode == UP) {
     framerate += 1;
     frameRate(framerate);
   } else if (keyCode == DOWN && framerate > 1) {
     framerate -= 1;
     frameRate(framerate);
   }
 }
}

public void copyFromBufferToButtons() {
 for (int i = 0; i < NUM_ROWS; i++){
   for (int j = 0; j < NUM_COLS; j++){
     buttons[i][j].setLife(buffer[i][j]);
   }
 }
}

public void copyFromButtonsToBuffer() {
 for (int i = 0; i < NUM_ROWS; i++){
   for (int j = 0; j < NUM_COLS; j++){
     buffer[i][j] = buttons[i][j].getLife();
   }
 }
}

public boolean isValid(int r, int c) {
 return r < NUM_ROWS && r >= 0 && c < NUM_COLS && c >= 0;
}

public int countNeighbors(int row, int col) {
 int neighbors = 0;
 int[] dx = {1, 0, -1, 0, 1, 1, -1, -1};
 int[] dy = {0, 1, 0, -1, 1, -1, 1, -1};
 for (int i = 0; i < 8; i++){
   if (isValid(row + dx[i], col + dy[i]) && buttons[row + dx[i]][col + dy[i]].getLife() == true){
     neighbors++;
   }
 }
 return neighbors;
}


public class Life {
 private int myRow, myCol;
 private float x, y, width, height;
 private boolean alive;

 public Life (int row, int col) {
   width = 400/NUM_COLS;
   height = 400/NUM_ROWS;
   myRow = row;
   myCol = col;
   x = myCol*width;
   y = myRow*height;
   alive = Math.random() < .5; // 50/50 chance cell will be alive
   Interactive.add( this ); // register it with the manager
 }

 // called by manager
 public void mousePressed () {
   alive = !alive; //turn cell on and off with mouse press
 }

 public void draw () {   
   if (alive != true)
     fill(0);
   else
     fill( 150 );
   rect(x, y, width, height);
 }


 public boolean getLife() {
   //replace the code one line below with your code
   return alive;
 }


 public void setLife(boolean living) {
   alive = living;
 }
}
