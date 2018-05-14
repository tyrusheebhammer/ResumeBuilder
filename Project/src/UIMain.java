

import processing.core.PApplet;

public class UIMain extends PApplet{

	public String page;
	
	private String consoleText;
	private DbConnection dbc;
	
	private RegisterPage registerPage;
	private LoginPage loginPage;
	private HomePage homePage;
	private ExperiencePage expPage;
	private DegreePage degPage;
	private CompanySearchPage companyPage;

	public void settings() {
		page = "login";
		size(displayWidth, displayHeight);

		consoleText = "";
		dbc = new DbConnection("golem.csse.rose-hulman.edu", "ResumeBuilder");
		dbc.connect("ResumeBuilder38", "Password38");
		
		registerPage= new RegisterPage(this,dbc);
		loginPage= new LoginPage(this,dbc);
		homePage = new HomePage(this,dbc);
		expPage = new ExperiencePage(this,dbc);
		degPage = new DegreePage(this,dbc);
		companyPage = new CompanySearchPage(this,dbc);
	}

	public void draw() {
		background(255);
		int rectw = 40;
		int recth = 40;
		fill(100, 200, 200, 42);
		noStroke();
		for (int i = 0; i < width / rectw; i++) {
			for (int j = 0; j < height / recth; j++) {
				if ((i % 2 == 1) ^ (j % 2 == 1)) {
					rect(i * rectw, j * recth, rectw, recth);

				}
			}
		}
		stroke(1);
		fill(0, 0, 0);
		textAlign(CENTER);
		textSize(30);
		text(consoleText, width / 2, height / 2 + 380);
		switch(page) {
		case "register":
			registerPage.draw();
			consoleText=registerPage.getConsoleText();
			break;
		case "login":
			loginPage.draw();
			consoleText=loginPage.getConsoleText();
			break;
		case "home":
			homePage.draw();
			consoleText=homePage.getConsoleText();
			break;
		case "exp":
			expPage.draw();
			consoleText=expPage.getConsoleText();
			break;
		case "deg":
			degPage.draw();
			consoleText=degPage.getConsoleText();
			break;
		case "company":
			companyPage.draw();
			consoleText=companyPage.getConsoleText();
			break;
		}
		

	}

	public void keyPressed() {
		changeConsoleText("");
		switch (page) {
		case "register":
			registerPage.keyPressed();
			consoleText=registerPage.getConsoleText();
			break;
		case "login":
			loginPage.keyPressed();
			consoleText=loginPage.getConsoleText();
			break;
		case "home":
			homePage.keyPressed();
			consoleText=homePage.getConsoleText();
			break;
		case "exp":
			expPage.keyPressed();
			consoleText=expPage.getConsoleText();
			break;
		case "deg":
			degPage.keyPressed();
			consoleText=degPage.getConsoleText();
			break;
		case "company":
			companyPage.keyPressed();
			consoleText=companyPage.getConsoleText();
			break;
		}

	}

	public void mouseClicked() {
		
		
		changeConsoleText("");

		switch (page) {
		
		case "register":
			registerPage.mouseClicked();
			consoleText=registerPage.getConsoleText();			
			page=registerPage.getPage();
			break;
		case "login":
			loginPage.mouseClicked();
			consoleText=loginPage.getConsoleText();
			page=loginPage.getPage();
			
			homePage.setLoginID(loginPage.getLoginID());
			break;
		case "home":
			homePage.mouseClicked();
			consoleText=homePage.getConsoleText();
			page=homePage.getPage();
			
			expPage.setLoginID(homePage.getLoginID());
			degPage.setLoginID(homePage.getLoginID());
			companyPage.setLoginID(homePage.getLoginID());
			break;
		case "exp":
			expPage.mouseClicked();
			consoleText=expPage.getConsoleText();
			page=expPage.getPage();
			break;
		case "deg":
			degPage.mouseClicked();
			consoleText=degPage.getConsoleText();
			page=degPage.getPage();
			break;
		case "company":
			companyPage.mouseClicked();
			consoleText=companyPage.getConsoleText();
			page=companyPage.getPage();
			
			break;
		}	
		

	}
	
	public void changeConsoleText(String s) {
		consoleText=s;
	}
	public void changePage(String p) {
		page=p;
	}

	public static void main(String[] args) {

		String[] processingArgs = { "UIMain" };
		UIMain mySketch = new UIMain();
		PApplet.runSketch(processingArgs, mySketch);
	}

}
