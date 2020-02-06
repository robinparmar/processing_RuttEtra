/* 
	Emulation of the line scan effect popularised by the 
	Rutt-Etra video synthesizer.

    Copyright (c) 2020 Robin Parmar. MIT License.
*/

PImage img;
int skipX = 1;
int skipY = 8;
float brightScale = 2.;
boolean mouser = false;

void setup() {
    size(800, 1210, P3D);

    noFill();
    lights();
    strokeWeight(4);
    background(0);

	img = loadImage("MonaLisa.jpg");
}

void draw() {
    background(0);
    pushMatrix();
    
    if (mouser) {
        // mouse rotation
    	translate(width, height, 0);
    	rotateY(radians(mouseX-(width)));
    	rotateX(radians(-(mouseY-(height))));
    	translate(-width, -height, 0);
    }
    
    for (int y=0; y<img.height; y+=skipY) {
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
