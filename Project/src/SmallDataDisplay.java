import java.util.ArrayList;

import processing.core.PApplet;
import processing.core.PConstants;

public class SmallDataDisplay {
	
	PApplet p;
	int x;
	int y;
	int w;
	int h;
	
	String loginID;
	
	int l;
	int r;
	int t;
	int b;
	
	ArrayList<String[]> data = new ArrayList<>();
	
	int offset;
	
	public SmallDataDisplay(PApplet p_, int x_, int y_, int w_, int h_) {
		p=p_;
		x=x_;
		y=y_;
		w=w_;
		h=h_;
		
		l=x-w/2;
		r=x+w/2;
		t=y-h/2;
		b=y+h/2;
		
		
				
		offset =0;
	}
	
	public void draw() {
		
		p.fill(200);
		p.rect(x-w/2, y-h/2, w, h);
		p.line(l+200, t, l+200, b);
		p.line(l+400, t, l+400, b);

		
		for (int i=0; i<h/40;i++) {
			p.line(l, t+i*40, r, t+i*40);
			if (data.size()>i+offset) {
				for (int j=0; j<5;j++) {
					p.textAlign(PConstants.LEFT);
					p.fill(0);
					p.textSize(20);
					p.text(data.get(i+offset)[j], l+(j)*300+5, t+(i+1)*40-5);
				}
			}
		}
		p.fill(180);
		p.rectMode(PConstants.CORNER);
		p.rect(r-40, t, 40, 40);
		p.rect(r-40,t+40,40,b-t-40);
		p.rect(r-40, b-40, 40, 40);
		
		
	}
	
	public void keyPressed() {

	}
	
	public void upClicked() {
		if (p.mouseX > r-40 && p.mouseX < r && p.mouseY > t
				&& p.mouseY < t+40) {
			if (offset>0) {
				offset--;
			}
		}
	}
	public void downClicked() {
		if (p.mouseX > r-40 && p.mouseX < r && p.mouseY > b-40
				&& p.mouseY < b) {
			offset++;
		}
	}

	
	public void addPositions(ArrayList<String[]> list) {
		data.clear();
		data.addAll(list);
	}
	
	public void setLoginID(String ID) {
		loginID=ID;
	}
	public String getLoginID() {
		return loginID;
	}

}