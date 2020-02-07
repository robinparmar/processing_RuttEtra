/* 
	Emulation of the line scan effect popularised by the 
	Rutt-Etra video synthesizer.

    Copyright (c) 2020 Robin Parmar. MIT License.
    
    VERSION 
    1.01	adapt canvas size to image dimensions
    		improved mouse rotation
    1.00	original
*/

PImage img;

int skipX = 1;
int skipY = 8;

float brightScale = 2.;
boolean mouser = false;
float mouse_x, mouse_y;

void setup() {
    size(100, 100, P3D);
	frame.setResizable(true);

    noFill();
    lights();
    strokeWeight(4);
    background(0);

	img = loadImage("MonaLisa.jpg");
	frame.setSize(img.width, img.height);

	mouse_x = 0.5*float(width);
	mouse_y = 0.5*float(height);
}

void draw() {
    background(0);
    pushMatrix();

	mouseHandler();    

    // for each row, skipping some lines
    for (int y=0; y<img.height; y+=skipY) {
        // draw a shape using pixel information
        beginShape();
        for (int x=0; x<img.width; x+=skipX) {
	        int pix = img.pixels[x + y * width];

            stroke(red(pix), green(pix), blue(pix), 255);
            vertex(x, y, (brightness(pix)-100)/brightScale);
        }
        endShape();
    }     
    popMatrix();
}

// mouse rotation
void mouseHandler() {
    float factor = 10.;
    
    if (mouser) {
        mouse_x = float(mouseX);
        mouse_y = float(mouseY);        
    }
    translate(width, height, 0);
    rotateY(radians( (mouse_x - 0.5*float(width)) / factor ));
    rotateX(radians( (0.5*float(height) - mouse_y) / factor ));
    translate(-width, -height, 0);
}

// spacebar toggles mouse rotation
void keyPressed() {
    if (keyCode == 32) {   
        mouser = !mouser;
        if (mouser) {
        	println("mouse rotation is ON");
        } else {
            println("mouse rotation is OFF");
        }
    }
}
