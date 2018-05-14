import processing.core.PApplet;
import processing.core.PConstants;

public class LoginPage {
	
	private PApplet p;
	private TextBox username;
	private TextBox password;
	private Button loginButton;
	private Button createAccountButton;
	private DbConnection dbc;
	
	private String loginID;
	
	String consoleText;
	String page;
	
	public LoginPage(PApplet p_, DbConnection dbc_) {
		p=p_;
		dbc=dbc_;
		username = new TextBox(p, "Username", p.width / 2, p.height / 2 - 200, 600, 50, false);
		password = new TextBox(p, "Password", p.width / 2, p.height / 2, 600, 50, true);
		loginButton = new Button(p, "Login", p.width / 2, p.height / 2 + 150, 170, 50);
		createAccountButton = new Button(p, "Create An Account", p.width / 2, p.height / 2 + 250, 500, 50);
		
		loginID = "";
		
		consoleText = "";
		page = "login";
	}
	
	public void draw() {
		page = "login";
		p.fill(0);
		p.textAlign(PConstants.CENTER);
		p.textSize(100);
		p.text("RESUME BUILDER", p.width / 2, p.height / 2 - 400);
		username.draw();
		password.draw();
		createAccountButton.draw();

		loginButton.draw();
	}
	public void keyPressed() {
		username.ifkeyPressed();
		password.ifkeyPressed();
		if (!username.getLimitText().equals("") && !password.getLimitText().equals("")) {
			changeConsoleText("Error: " + username.getLimitText() + " and " + password.getLimitText()
			+ " max character limit obtained");
		} else if (!username.getLimitText().equals("") || !password.getLimitText().equals("")) {
			changeConsoleText("Error: " + username.getLimitText() + password.getLimitText()
			+ " max character limit obtained");
		}
	}
	
	public void mouseClicked() {
		if (loginButton.clicked() && !username.getEntry().isEmpty() && !password.getEntry().isEmpty()) {
			changeConsoleText("Error: User login failed. Please enter a valid username and password");
			
			try {
				if (dbc.getLoginInfo(username.getEntry()).equals(password.getEntry())) {
					loginID=username.getEntry();
					username.clear();
					password.clear();
					changePage("home");
					
				}
			} catch(NullPointerException e) {
				changeConsoleText("Error: User login failed. Please enter a valid username and password");
			}
			

		}
		if (loginButton.clicked() && (username.getEntry().isEmpty() || password.getEntry().isEmpty())) {
			changeConsoleText("Error: One or more required entries not filled in");
			
		}
		if (createAccountButton.clicked()) {
			changePage("register");
			
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
	
	public String getLoginID() {
		return loginID;
	}
}
