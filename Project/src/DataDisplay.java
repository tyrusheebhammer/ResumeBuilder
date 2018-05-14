import java.util.ArrayList;

import processing.core.PApplet;
import processing.core.PConstants;

public class DataDisplay {
	
	PApplet p;
	int x;
	int y;
	int w;
	int h;
	
	int l;
	int r;
	int t;
	int b;
	ArrayList<String[]> data = new ArrayList<>();
	
	int offset;
	
	public DataDisplay(PApplet p_, int x_, int y_, int w_, int h_) {
		p=p_;
		x=x_;
		y=y_;
		w=w_;
		h=h_;
		
		l=x-w/2;
		r=x+w/2;
		t=y-h/2;
		b=y+h/2;
		
		String arr[] = {"Microsoft","Computer Engineer","100,000","12/12/2018","Wherever Microsoft is Located"};
		data.add(arr);
		String arr1[] = {"Google","Software Engineer","120,000","10/15/2017","Wherever Google is Located"};
		data.add(arr1);
		String arr2[] = {"Apple","Computer Scientist","110,000","04/11/2018","Wherever Apple is Located"};
		data.add(arr2);
		String arr3[] = {"McDonalds","Cashier","20,000","12/24/2016","Wherever McDonalds is Located"};
		data.add(arr3);
		
		offset =0;
	}
	
	public void draw() {
		
		p.fill(200);
		p.rect(x-w/2, y-h/2, w, h);
		p.line(l+300, t, l+300, b);
		p.line(l+600, t, l+600, b);
		p.line(l+900, t, l+900, b);
		p.line(l+1200, t, l+1200, b);
		
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
	
	
}
