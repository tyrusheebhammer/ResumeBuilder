import java.text.ParseException;

import ConnecionHandler.DatabaseConnectionService;
import ConnecionHandler.InteractionHandler;
import processing.core.PApplet;
import processing.core.PConstants;

public class CompanySearchPage {
	
	private PApplet p;
	private DbConnection dbc;
	
	private Button home;

	private DataDisplay data;

	private String loginID;
	
	
	private int[] dataDims;
	
	String consoleText;
	String page;
	
	DatabaseConnectionService Dbc;
	InteractionHandler handler;
	
	public CompanySearchPage(PApplet p_, DbConnection dbc_) {
		p=p_;
		dbc=dbc_;

		dataDims= new int[] {p.width/2,5*p.height/8+75,p.width-100,p.height/2};
		
		home = new Button(p, "Home", p.width / 8, p.height / 8+50, 330, 50);
		data = new DataDisplay(p,dataDims[0],dataDims[1],dataDims[2],dataDims[3]);
		
		loginID="";
		
		consoleText = "";
		page = "company";
		System.out.println(dbc.serverName+" "+dbc.databaseName);
		Dbc = new DatabaseConnectionService(dbc.serverName, dbc.databaseName);
		Dbc.connect("ResumeBuilder38", "Password38");
		System.out.println(Dbc.getConnection() == null);
		handler = new InteractionHandler(Dbc);
		//handler.getQualifiedPositions("SomeStudentID");
	}
	
	public void draw() {
		page = "company";
		p.fill(0);
		p.textAlign(PConstants.CENTER);
		p.textSize(100);
		p.text("SEARCH FOR A COMPANY", p.width / 2, p.height / 2 - 400);
		
		home.draw();
		data.draw();

	}
	public void keyPressed() {
		data.keyPressed();
	}
	
	public void mouseClicked() {
		data.upClicked();
		data.downClicked();
		if (data.searchClicked()) {
			Double salary;
			Integer qual;
			if (data.getSearchArgs()[0]==null) {
				salary=null;	
			} else {
				salary=Double.parseDouble(data.getSearchArgs()[0]);
			}
			if (data.getSearchArgs()[3]==null) {
				changeConsoleText("Make sure Qualified is filled out");	
			} else {
				qual=Integer.parseInt(data.getSearchArgs()[3]);
				
				try {
					data.addPositions(handler.filterPositions(loginID, salary, data.getSearchArgs()[1], data.getSearchArgs()[2], qual));
				} catch (NumberFormatException e) {
					e.printStackTrace();
				} catch (ParseException e) {
					e.printStackTrace();
				}
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
