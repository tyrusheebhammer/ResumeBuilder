import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import processing.core.PApplet;

public class UIMain extends PApplet {

	public String page;
	private TextBox username;
	private TextBox password;
	private TextBox rUsername;
	private TextBox rPassword;
	private TextBox rPasswordConfirm;
	private Button loginButton;
	private Button createAccountButton;
	private Button registerButton;
	private Button loginPageButton;
	private ArrayList<String> mockDatabase;
	private String consoleText;
	private DbConnection dbc;

	public void settings() {
		page = "login";
		size(displayWidth, displayHeight);
		username = new TextBox(this, "Username", width / 2, height / 2 - 200, 600, 50, false);
		password = new TextBox(this, "Password", width / 2, height / 2, 600, 50, true);
		rUsername = new TextBox(this, "Username", width / 2, height / 2 - 250, 600, 50, false);
		rPassword = new TextBox(this, "Password", width / 2, height / 2 - 100, 600, 50, true);
		rPasswordConfirm = new TextBox(this, "Confirm Password", width / 2, height / 2 + 50, 600, 50, true);
		loginButton = new Button(this, "Login", width / 2, height / 2 + 150, 170, 50);
		loginPageButton = new Button(this, "Go Back To Login", width / 2, height / 2 + 250, 430, 50);
		createAccountButton = new Button(this, "Create An Account", width / 2, height / 2 + 250, 500, 50);
		registerButton = new Button(this, "Register", width / 2, height / 2 + 150, 200, 50);
		mockDatabase = new ArrayList<>();
		consoleText = "";
		dbc = new DbConnection("golem.csse.rose-hulman.edu", "ResumeBuilder");
		dbc.connect("ResumeBuilder38", "Password38");
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

		if (page == "register") {

			fill(0);
			textAlign(CENTER);
			textSize(100);
			text("Register", width / 2, height / 2 - 400);
			rUsername.create();
			rPassword.create();
			rPasswordConfirm.create();

			registerButton.create();
			loginPageButton.create();

		}
		if (page == "login") {
			fill(0);
			textAlign(CENTER);
			textSize(100);
			text("RESUME BUILDER", width / 2, height / 2 - 400);
			username.create();
			password.create();
			createAccountButton.create();

			loginButton.create();

		}

	}

	public void keyPressed() {
		consoleText = "";
		switch (page) {
		case "register":
			rUsername.ifkeyPressed();
			rPassword.ifkeyPressed();
			rPasswordConfirm.ifkeyPressed();
			if (!rUsername.getLimitText().equals("") && !rPassword.getLimitText().equals("")) {
				consoleText = "Error: " + rUsername.getLimitText() + " and " + rPassword.getLimitText()
						+ " max character limit obtained";
			} else if (!rUsername.getLimitText().equals("") || !rPassword.getLimitText().equals("")) {
				consoleText = "Error: " + rUsername.getLimitText() + rPassword.getLimitText()
						+ " max character limit obtained";
			}
		case "login":
			username.ifkeyPressed();
			password.ifkeyPressed();
			if (!username.getLimitText().equals("") && !password.getLimitText().equals("")) {
				consoleText = "Error: " + username.getLimitText() + " and " + password.getLimitText()
						+ " max character limit obtained";
			} else if (!username.getLimitText().equals("") || !password.getLimitText().equals("")) {
				consoleText = "Error: " + username.getLimitText() + password.getLimitText()
						+ " max character limit obtained";
			}
		}

	}
	
	public String getLoginInfo(String Username) {
		Statement stmt = null;
		Connection con=dbc.getConnection();
		String password=null;
		try {
			stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(
					"Select StudentID From Student Where StudentID="+Username);
			if (rs.next()) {
				password = rs.getString("password");
			}
			return password;
			
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

	public void mouseClicked() {
		
		

		consoleText = "";

		switch (page) {
		case "register":
			if (loginPageButton.clicked()) {
				consoleText = "";
				page = "login";
				println("hit");
				break;
			}
			if (registerButton.clicked() && (rUsername.getEntry().isEmpty() || rPassword.getEntry().isEmpty())) {
				consoleText = "Error: One or more required entries not filled in";
				break;
			}
			if (registerButton.clicked() && !rUsername.getEntry().isEmpty() && !rPassword.getEntry().isEmpty()) {
				if (rPassword.getEntry().equals(rPasswordConfirm.getEntry())) {
					if (mockDatabase.contains(rUsername.getEntry() + ", " + rPassword.getEntry())) {
						consoleText = "Error: User already exists";
					} else {
						mockDatabase.add(rUsername.getEntry() + ", " + rPassword.getEntry());
						page = "login";
						rUsername.clear();
						rPassword.clear();
						rPasswordConfirm.clear();
						consoleText = "";
					}

				} else {
					consoleText = "Error: Passwords do not match";
				}
				break;
			}
		case "login":

			if (loginButton.clicked() && !username.getEntry().isEmpty() && !password.getEntry().isEmpty()) {
				consoleText = "Error: User login failed. Please enter a valid username and password";
				if (getLoginInfo(username.getEntry()).equals(password.getEntry())) {
					//mockDatabase.contains(username.getEntry() + ", " + password.getEntry())
					consoleText = "User login successful";
					username.clear();
					password.clear();
					page = "home";
					break;
				}

			}
			if (loginButton.clicked() && (username.getEntry().isEmpty() || password.getEntry().isEmpty())) {
				consoleText = "Error: One or more required entries not filled in";
				break;
			}
			if (createAccountButton.clicked()) {
				page = "register";
				break;
			}

		}

	}

	public static void main(String[] args) {

		String[] processingArgs = { "UIMain" };
		UIMain mySketch = new UIMain();
		PApplet.runSketch(processingArgs, mySketch);
	}

}
