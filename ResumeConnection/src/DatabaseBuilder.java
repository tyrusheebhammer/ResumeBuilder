import java.sql.CallableStatement;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;



public class DatabaseBuilder {
	ArrayList<String> degrees = new ArrayList<>();
	ArrayList<String> skills = new ArrayList<>();
	private static final String[] COURSESKILLTITLES = {"AS","BE","BIO","BMTH","CE","CHE","CHEM","CSSE","ECE","EM","EMGT",
								  "ENGD", "EP", "ES", "GE", "JP", "SP", "GS", "IA", "RH", "SV", "MA",
								  "ME","MS","OE","PH"};
	private static final String[] COURSESKILLNAMES = {};
	HashMap<String, String> titleToName;
	private DatabaseConnectionService dbs;	
public DatabaseBuilder(DatabaseConnectionService dbs){
	
	this.dbs = dbs;
	this.titleToName = new HashMap<>();
	for(int i = 0; i < COURSESKILLNAMES.length; i++) {
		this.titleToName.put(COURSESKILLTITLES[i], COURSESKILLNAMES[i]);
	}
}
	
	
	public String getPosition(){
		
		try {
			ResultSet rs = null;
			Statement stmt = this.dbs.getConnection().createStatement();
			String query = "SELECT * FROM Position";
			rs = stmt.executeQuery(query);
			if(rs != null){
				System.out.println("Success!");
			}else{
				System.out.println("Data not returned");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("Failure");
			e.printStackTrace();
		}
		
		return " ";
	}

	public boolean addStudent(String studentID, String firstName, String middleInitial, String lastName, 
			String address, int phone, String password) throws SQLException{
				CallableStatement Cstmt = dbs.getConnection().prepareCall("{call AddStudent(?, ?, ?, ?, ?, ?, ?)}");
				Cstmt.setString(1, studentID);
				Cstmt.setString(2, firstName);
				Cstmt.setString(3, middleInitial);
				Cstmt.setString(4, lastName);
				Cstmt.setString(5, address);
				Cstmt.setInt(6, phone);
				Cstmt.setString(7, password);
				Cstmt.executeUpdate();
				return true;
	}
	
	public void AddSkill(String)
	public void addCourse(String CourseID, String Subject){
		PreparedStatement pStmt;
		try {
			this.degrees.add(CourseID);
			pStmt = dbs.getConnection().prepareStatement("{call AddCourse(?,?)}");
			pStmt.setString(1, CourseID);
			pStmt.setString(2, Subject);
			int rs = pStmt.executeUpdate();
			System.out.print(rs);
			dbs.getConnection().commit();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}
	public boolean addPosition(Float Salary, String Name, String Location, String Description, String Company) throws ParseException{
		PreparedStatement pStmt;
		SimpleDateFormat sdf = new SimpleDateFormat("mm/dd/yyyy");
		Date mDate = null;
		try {
			pStmt = dbs.getConnection().prepareCall("{call AddPosition(?, ?, ?, ?, ?)}");
			pStmt.setFloat(1, Salary);
			pStmt.setString(2, Name);
			pStmt.setString(3, Location);
			pStmt.setString(4, Description);
			pStmt.setString(5, Company);
			int rs = pStmt.executeUpdate();
			
			System.out.print(rs);
			dbs.getConnection().commit();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}
	public void addDegree(String studentID, String degreeName, int gradYear, String degreeType, String field) {
		PreparedStatement pStmt;
		try {
			pStmt = dbs.getConnection().prepareStatement("{call AddDegree(?,?,?,?,?)}");
			pStmt.setString(1, studentID);
			pStmt.setString(2, degreeName);
			pStmt.setInt(3, gradYear);
			pStmt.setString(4, degreeType);
			pStmt.setString(5, field);
			int rs = pStmt.executeUpdate();
			System.out.print(rs);
			dbs.getConnection().commit();
		}catch(SQLException e) {}
	}
	
}
