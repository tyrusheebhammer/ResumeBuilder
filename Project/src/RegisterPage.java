import processing.core.PApplet;
import processing.core.PConstants;

public class RegisterPage {
	private PApplet p;
	private TextBox rUsername;
	private TextBox rPassword;
	private TextBox rPasswordConfirm;
	private TextBox fName;
	private TextBox middleInit;
	private TextBox lName;
	private TextBox address;
	private TextBox phone;
	private Button registerButton;
	private Button loginPageButton;
	private DbConnection dbc;
	
	String consoleText;
	String page;
	
	public RegisterPage(PApplet p_, DbConnection dbc_) {
		p=p_;
		dbc=dbc_;
		rUsername = new TextBox(p, "Username", p.width / 2-630, p.height / 2 - 250, 570, 50, false);
		rPassword = new TextBox(p, "Password", p.width / 2-630, p.height / 2 - 100, 570, 50, true);
		rPasswordConfirm = new TextBox(p, "Confirm Password", p.width / 2-630, p.height / 2 + 50, 570, 50, true);
		fName= new TextBox(p, "First Name", p.width / 2, p.height / 2 - 250, 570, 50, false);;
		middleInit= new TextBox(p, "Middle Initial", p.width / 2, p.height / 2 - 100, 570, 50, false);
		lName = new TextBox(p, "Last Name", p.width / 2, p.height / 2 + 50, 570, 50, false);
		address= new TextBox(p, "Address", p.width / 2 + 630, p.height / 2 - 250, 570, 50, false);;
		phone= new TextBox(p, "Phone Number", p.width / 2 + 630, p.height / 2 - 100, 570, 50, false);
		registerButton = new Button(p, "Register", p.width / 2, p.height / 2 + 150, 200, 50);
		loginPageButton = new Button(p, "Go Back To Login", p.width / 2, p.height / 2 + 250, 430, 50);
		
		consoleText = "";
		page = "register";
	}
	public void draw() {
		page = "register";
		p.fill(0);
		p.textAlign(PConstants.CENTER);
		p.textSize(100);
		p.text("Register", p.width / 2, p.height / 2 - 400);
		rUsername.draw();
		rPassword.draw();
		rPasswordConfirm.draw();
		fName.draw();
		middleInit.draw();
		lName.draw();
		address.draw();
		phone.draw();

		registerButton.draw();
		loginPageButton.draw();
	}
	public void keyPressed() {
		rUsername.ifkeyPressed();
		rPassword.ifkeyPressed();
		rPasswordConfirm.ifkeyPressed();
		fName.ifkeyPressed();
		middleInit.ifkeyPressed();
		lName.ifkeyPressed();
		address.ifkeyPressed();
		phone.ifkeyPressed();
		if (!rUsername.getLimitText().equals("") && !rPassword.getLimitText().equals("")) {
			changeConsoleText("Error: " + rUsername.getLimitText() + " and " + rPassword.getLimitText()
			+ " max character limit obtained");
		} else if (!rUsername.getLimitText().equals("") || !rPassword.getLimitText().equals("")) {
			changeConsoleText("Error: " + rUsername.getLimitText() + rPassword.getLimitText()
			+ " max character limit obtained");
		}
	}
	
	public void mouseClicked() {
		if (loginPageButton.clicked()) {
			changeConsoleText("");
			changePage("login");
			
		}
		if (registerButton.clicked() && (rUsername.getEntry().isEmpty() || rPassword.getEntry().isEmpty() || rPasswordConfirm.getEntry().isEmpty() ||
				fName.getEntry().isEmpty() || middleInit.getEntry().isEmpty() || lName.getEntry().isEmpty() || address.getEntry().isEmpty() || phone.getEntry().isEmpty())) {
			changeConsoleText("Error: One or more required entries not filled in");
			
		}
		if (registerButton.clicked() && !rUsername.getEntry().isEmpty() && !rPassword.getEntry().isEmpty()) {
			boolean b;
			try {
				b=rPassword.getEntry().equals(rPasswordConfirm.getEntry());
			} catch (NullPointerException e) {
				b=false;
			}
			if (b) {
				try {
					if (phone.getEntry().length()==10) {
						dbc.addUser(rUsername.getEntry(),rPassword.getEntry(), fName.getEntry(), middleInit.getEntry(),lName.getEntry(),address.getEntry(),Integer.parseInt(phone.getEntry()));
						changePage("login");
						rUsername.clear();
						rPassword.clear();
						rPasswordConfirm.clear();
						changeConsoleText("");
						return;
					} else {
						changeConsoleText("Error: Phone number is not in valid format, ##########");
					}
				} catch (NumberFormatException ex) {
					changeConsoleText("Error: Phone number is not in valid format, ##########");
				}
				

			} else {
				changeConsoleText("Error: Passwords do not match");
			}
			
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
}
