import java.sql.CallableStatement;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.text.ParseException;
import java.text.SimpleDateFormat;



public class DatabaseBuilder {
	
	private DatabaseConnectionService dbs;	
public DatabaseBuilder(DatabaseConnectionService dbs){
	
	this.dbs = dbs;
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
				Cstmt.setString(1, firstName);
				Cstmt.setString(1, middleInitial);
				Cstmt.setString(1, lastName);
				Cstmt.setString(1, address);
				Cstmt.setInt(1, phone);
				Cstmt.setString(1, password);
				Cstmt.executeUpdate();
				return true;
	}
	public void addCourse(){
		
		
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
			
			System.out.println(rs);
			dbs.getConnection().commit();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}
	public boolean addCompany(String Name){
		PreparedStatement pStmt;
		try {
			pStmt = dbs.getConnection().prepareCall("{call AddCompany(?)}");
			pStmt.setString(1, Name);
			pStmt.executeUpdate();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		
	}
	public void addCredential(){
		
	}
	
}
