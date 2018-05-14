import processing.core.PApplet;
import processing.core.PConstants;

public class HomePage {
	private PApplet p;
	private DbConnection dbc;
	
	private Button addExp;
	private Button addDegree;
	private Button companySearch;
	
	private String loginID;
	
	String consoleText;
	String page;
	Animation gif;
	
	public HomePage(PApplet p_, DbConnection dbc_) {
		p=p_;
		dbc=dbc_;
		
		addExp = new Button(p, "Add Experience", p.width / 2-600, p.height / 2 +100, 330, 50);
		companySearch = new Button(p, "Search for a Company", p.width / 2, p.height / 2 +100, 450, 50);
		addDegree = new Button(p, "Add Degree", p.width / 2+600, p.height / 2 +100, 300, 50);
		
		loginID=null;
		
		consoleText = "";
		page = "home";
		gif = new Animation(p, "tenor",10);
	}
	
	public void draw() {
		page = "home";
		p.fill(0);
		p.textAlign(PConstants.CENTER);
		p.textSize(100);
		p.text("HOME PAGE", p.width / 2, p.height / 2 - 400);
		gif.display(p.width/2, 5*p.height/16);
		
		addExp.draw();
		companySearch.draw();
		addDegree.draw();

	}
	public void keyPressed() {
		
	}
	
	public void mouseClicked() {
		if (addExp.clicked()) {
			changePage("exp");
			return;
		}
		if (addDegree.clicked()) {
			changePage("deg");
			return;
		}
		if (companySearch.clicked()) {
			changePage("company");
			return;
		}
	}
	
	public void changeConsoleText(String s) {
		System.out.println(s);
		consoleText=s;
		//UIn.changeConsoleText(text);
	}
	public void changePage(String p) {
		System.out.println(p);
		page=p;
		//UIn.changePage(page);
	}
	public String getConsoleText() {
		return consoleText;
	}
	public String getPage() {
		return page;
	}
	public void setLoginID(String ID) {
		loginID=ID;
	}
	public String getLoginID() {
		return loginID;
	}
}
