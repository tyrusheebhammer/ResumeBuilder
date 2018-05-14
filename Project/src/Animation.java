import processing.core.PApplet;
import processing.core.PConstants;
import processing.core.PImage;

public class Animation {
	
  PImage[] images;
  int imageCount;
  int frame;
  PApplet p;
  
  Animation(PApplet p_, String imagePrefix, int count) {
	p=p_;
    imageCount = count;
    images = new PImage[imageCount];

    for (int i = 0; i < imageCount; i++) {
      // Use nf() to number format 'i' into four digits
      String filename = imagePrefix + PApplet.nf(i, 4) + ".gif";
      String url = "https://media1.tenor.com/images/0e797ecced04d8367580b847845f9905/tenor"+imagePrefix + PApplet.nf(i, 4) +".gif?itemid=5360131";
      String url1="https://processing.org/img/processing-web.png";
      String url2="C:/EclipseWorkspaces/csse333/ResumeBuilder/Project/src/tenor.gif";
      images[i] = p.loadImage(url2);
    }
  }

  void display(float xpos, float ypos) {
	p.imageMode(PConstants.CENTER);
    frame = (frame+1) % imageCount;
    p.image(images[frame], xpos, ypos);
  }
  
  int getWidth() {
    return images[0].width;
  }
}