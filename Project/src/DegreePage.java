
import processing.core.PApplet;
import processing.core.PConstants;

public class DegreePage {
	private PApplet p;
	private DbConnection dbc;
	
	private TextBox degreeName;
	private TextBox gradYear;
	private TextBox type;
	private TextBox field;
	
	private Button addDegree;
	private Button home;

	private String loginID;
	
	String consoleText;
	String page;
	
	public DegreePage(PApplet p_, DbConnection dbc_) {
		p=p_;
		dbc=dbc_;

		addDegree = new Button(p, "Add Degree", p.width / 2, 3*p.height / 16+50, 330, 50);
		home = new Button(p, "Home", p.width / 8, p.height / 8, 330, 50);
		
		degreeName= new TextBox(p, "Name of University", p.width / 2-300, p.height / 2 - 100, 570, 50, false);;
		gradYear= new TextBox(p, "Graduation Year", p.width / 2+300, p.height / 2 - 100, 570, 50, false);
		type = new TextBox(p, "Type of Degree", p.width / 2-300, p.height / 2 +50, 570, 50, false);
		field= new TextBox(p, "Field of Degree", p.width / 2+300, p.height / 2 +50, 570, 50, false);
		
		loginID="";
		
		consoleText = "";
		page = "deg";
	}
	
	public void draw() {
		page = "deg";
		p.fill(0);
		p.textAlign(PConstants.CENTER);
		p.textSize(100);
		p.text("ADD DEGREE", p.width / 2, p.height / 2 - 400);
		
		degreeName.draw();
		gradYear.draw();
		type.draw();
		
		field.draw();
		
		addDegree.draw();
		home.draw();

	}
	public void keyPressed() {
		degreeName.ifkeyPressed();
		gradYear.ifkeyPressed();
		type.ifkeyPressed();
		
		field.ifkeyPressed();
	}
	
	public void mouseClicked() {
		changeConsoleText("");
		if (addDegree.clicked()) {
			if(degreeName.getEntry().equals("") || gradYear.getEntry().equals("") || type.getEntry().equals("") || field.getEntry().equals("")) {
				changeConsoleText("Error: One or more required entries not filled in");
				return;
			}
			try {
				
				dbc.addDegree(loginID, degreeName.getEntry(), Integer.parseInt(gradYear.getEntry()), type.getEntry(),field.getEntry());
				changeConsoleText("Degree Added: "+degreeName.getEntry()+", "+ gradYear.getEntry()+", "+type.getEntry()+", "+field.getEntry());
				return;
				
			} catch (NullPointerException ne) {
				
			}
		}
		if(home.clicked()) {
			changePage("home");
			return;
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
