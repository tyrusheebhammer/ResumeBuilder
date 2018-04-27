import processing.core.PApplet;
import processing.core.PConstants;

public class TextBox {

	private PApplet p;
	private String title;
	private int x, y, w, h;
	private String entry = "";
	private boolean isSecure;
	private boolean isTextboxSelected = false;
	private String consoleMessage;

	public TextBox(PApplet p_, String title_, int x_, int y_, int w_, int h_, boolean isSecure_) {

		p = p_;
		title = title_;
		x = x_;
		y = y_;
		w = w_;
		h = h_;
		isSecure = isSecure_;
		consoleMessage = "";

	}

	public void create() {
		this.isSelected();
		if (isTextboxSelected) {
			p.stroke(255, 165, 0);
			p.strokeWeight(2);
			p.fill(200);
			p.rect(x - w / 2, y - h / 2, w, h);
			p.stroke(0);
			p.strokeWeight(1);
		} else {
			p.stroke(0);
			p.strokeWeight(1);
			p.fill(200);
			p.rect(x - w / 2, y - h / 2, w, h);
		}

		p.fill(0);
		p.textSize(40);
		p.textAlign(PConstants.CENTER);
		p.text(title, x, y - 50);

		p.fill(0);
		p.textSize(40);
		p.textAlign(PConstants.LEFT);
		String toPrint = "";
		if (isSecure) {
			for (int i = 0; i < entry.length(); i++) {
				toPrint = toPrint + '*';
			}
		} else {
			toPrint = entry;
		}
		p.text(toPrint, x - w / 2 + 10, y + h / 2 - 10);

	}

	public void isSelected() {
		boolean inBoundaries = p.mouseX > x - w / 2 && p.mouseX < x + w / 2 && p.mouseY > y - h / 2
				&& p.mouseY < y + h / 2;
		if (inBoundaries && p.mousePressed) {
			isTextboxSelected = true;
		}
		if (!inBoundaries && p.mousePressed) {
			isTextboxSelected = false;
		}

	}

	public void ifkeyPressed() {
		this.isSelected();
		if (isTextboxSelected) {
			if (!(p.key == PConstants.ENTER || p.key == PConstants.RETURN || p.keyCode == PConstants.SHIFT)) {
				if (entry.length() < 16 && p.key != PConstants.BACKSPACE) {
					entry = entry + p.key;
				}
				if (entry.length() == 15 && p.key != PConstants.BACKSPACE) {
					consoleMessage = title;
				}
				if (p.key == PConstants.BACKSPACE) {
					consoleMessage = "";
					if (entry.length() > 0) {
						entry = entry.substring(0, entry.length() - 1);
					}

				}
			}

		}

	}

	public String getEntry() {
		return entry;
	}

	public void clear() {
		entry = "";
	}

	public String getLimitText() {
		return consoleMessage;
	}

	public boolean isClicked() {
		boolean inBoundaries = p.mouseX > x - w / 2 && p.mouseX < x + w / 2 && p.mouseY > y - h / 2
				&& p.mouseY < y + h / 2;
		if (inBoundaries && p.mousePressed) {
			return true;
		}
		return false;
	}
}
