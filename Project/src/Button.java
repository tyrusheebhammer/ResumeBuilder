import processing.core.PApplet;
import processing.core.PConstants;

public class Button {
	private PApplet p;
	private String title;
	private int x, y, w, h;


	public Button(PApplet p_, String title_, int x_, int y_, int w_, int h_) {
		p = p_;
		title = title_;
		x = x_;
		y = y_;
		w = w_;
		h = h_;
	}

	public void create() {
		p.fill(200);
		p.rect(x - w / 2, y - h / 2, w, h);
		p.fill(0);
		p.textSize(40);
		p.textAlign(PConstants.CENTER);
		p.text(title, x, y + h / 2 - 10);
	}

	

	
	public boolean clicked(){
		return p.mouseX > x - w / 2 && p.mouseX < x + w / 2 && p.mouseY > y - h / 2
				&& p.mouseY < y + h / 2;
	}
}
