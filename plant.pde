int BRANCHES = 4; //Number of branches per line
int DEPTH = 5; // Recursive depth
float MIN_ANGLE = 10.0; //Minimum angle for new branch
float MAX_ANGLE = 15.0; //Maximum angle for new branch
float MIN_LENGTH = 0.30; //Minimum length of new branch, as a pct of current length
float MAX_LENGTH = 0.8; //Maximum length of new branch, as a pct of current length

// Implements a Vector
class Vector {
    int x,y;
    float r, theta;
    
    Vector (int _x, int _y, float _r, float _theta) {
        x = _x; //Origin x
        y = _y; //Origin y
        r = _r; //Length
        theta = _theta; // Angle
    }
    
    int getEndPointX() {
        return int(x + r*cos(theta/57.3));
    }
    
    int getEndPointY() {
        return int(y + r*sin(theta/57.3));
    }
    
}

//Recursive function that creates a fractal "plant"
void fractal(Vector v, int N) {
    if (N > 0) {
        int dir = 1; //control alternating direction of the branch
        line(v.x,v.y,v.getEndPointX(),v.getEndPointY()); //Draw the current vector
        for (int i = 0; i < BRANCHES; i++) {
            //Create a random vector based on the current one
            Vector r = new Vector (v.x, v.y,v.r,v.theta); //New random vector that will branch off the current line
            r.r = random(v.r*MIN_LENGTH, v.r*MAX_LENGTH); //Select a random length
            r.x = r.getEndPointX(); //shift the x-origin
            r.y = r.getEndPointY(); //shift the y-origin
            r.theta += dir*random(MIN_ANGLE,MAX_ANGLE); // shift the angle a bit
            dir = dir * -1; //Alternate branch direction
            fractal(r,N-1); //Recurse
        }
    }
}


// keep draw() here to continue looping while waiting for keys
void draw() {
}

//Draw a new image each time a key is pressed
void keyPressed() {
    fill(#556b2f);
    stroke(#fffff0);
    smooth();
    rect(0,0,400,400);
    Vector seed = new Vector(10,10,200,45);
    fractal (seed,DEPTH );
}

//Draw the first image
void setup() {
    size(400,400);
    keyPressed();
}