import processing.core.PApplet;
import processing.core.PConstants;

public class ExperiencePage {
	private PApplet p;
	private DbConnection dbc;
	
	private TextBox expName;
	private TextBox startDate;
	private TextBox endDate;
	private TextBox description;
	
	private Button addExp;
	private Button home;

	private String loginID;
	
	String consoleText;
	String page;
	
	public ExperiencePage(PApplet p_, DbConnection dbc_) {
		p=p_;
		dbc=dbc_;

		addExp = new Button(p, "Add Experience", p.width / 2, 3*p.height / 16+50, 330, 50);
		home = new Button(p, "Home", p.width / 8, p.height / 8, 330, 50);
		
		expName= new TextBox(p, "Name", p.width / 2-630, p.height / 2 - 100, 570, 50, false);;
		startDate= new TextBox(p, "Starting Date", p.width / 2, p.height / 2 - 100, 570, 50, false);
		endDate = new TextBox(p, "Ending Date", p.width / 2+630, p.height / 2 - 100, 570, 50, false);
		
		description= new TextBox(p, "Description", p.width / 2, p.height / 2 +50, 1000, 50, false);
		
		loginID="";
		
		consoleText = "";
		page = "exp";
	}
	
	public void draw() {
		page = "exp";
		p.fill(0);
		p.textAlign(PConstants.CENTER);
		p.textSize(100);
		p.text("ADD EXPERIENCE", p.width / 2, p.height / 2 - 400);
		
		expName.draw();
		startDate.draw();
		endDate.draw();
		
		description.draw();
		
		addExp.draw();
		home.draw();

	}
	public void keyPressed() {
		expName.ifkeyPressed();
		startDate.ifkeyPressed();
		endDate.ifkeyPressed();
		
		description.ifkeyPressed();
	}
	
	public void mouseClicked() {
		if (addExp.clicked()) {
			if(expName.getEntry().equals("") || startDate.getEntry().equals("") || description.getEntry().equals("")) {
				changeConsoleText("Error: One or more required entries not filled in");
				return;
			}
			try {
				dbc.addExperience(loginID, expName.getEntry(), description.getEntry(), startDate.getEntry(), endDate.getEntry());
				changeConsoleText("Experience Added: "+ expName.getEntry() +", "+startDate.getEntry()+", "+endDate.getEntry()
				+"\n"+description.getEntry());
				return;
			} catch (NullPointerException ne) {
				
			}
		}
		if (home.clicked()) {
			changePage("home");
		}
	
	}
	
	public void changeConsoleText(String s) {
		System.out.println(s);
		consoleText=s;

	}
	public void changePage(String p) {
		System.out.println(p);
		page=p;

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
