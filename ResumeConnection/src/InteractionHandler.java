import java.sql.CallableStatement;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

public class InteractionHandler {
	
	private DatabaseConnectionService dbs;
	public final Double DEAFULT_SALARY = 0.00;
	
	public InteractionHandler(DatabaseConnectionService dbs){
		this.dbs = dbs;
	}
	
	/** 
	 * This method takes the user name of the user logged in and calls the 
	 * stored procedure to get all of the positions the user is currently 
	 * qualified for. 
	 * @param studentID
	 * @return
	 */
	
//	public ArrayList<ArrayList<String>> getQualifiedPositions(String studentID){
//		
//		//Initialize local variables
//		ArrayList<ArrayList<String>> returnSet = new ArrayList<ArrayList<String>>();
//		PreparedStatement pStmt = null; 
//		ResultSet rs = null;
//		//Querying the database
//		try {
//			pStmt = dbs.getConnection().prepareStatement("{call GetPositionByStudentSkills(?)}");
//			pStmt.setString(1, studentID);
//			rs= pStmt.executeQuery();
//			
//			//Adding the result set to the nested arraylist 
//			while(rs.next()){
//				System.out.println(rs.getString("Name"));
//				ArrayList<String> currentRow = new ArrayList<>(); 
//				currentRow.add(rs.getString("Name"));
//				currentRow.add(rs.getString("Description"));
//				returnSet.add(currentRow);
//			}
//			
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
//		
//		return returnSet;
//		
//	}
	
	/**
	 * This method takes the student id but the remaining fields can be null and then will filter
	 * by passing to a stored procedure. 
	 * @param studentID
	 * @param salary
	 * @param date
	 * @param location
	 * @param Company
	 * @param isQualified
	 * @return
	 * @throws ParseException 
	 */
	public ArrayList<ArrayList<String>> filterPositions(String studentID, Double salary, String date, String location, String Company, Integer isQualified) throws ParseException{
		
		//Initial local variables 
		ArrayList<ArrayList<String>> returnSet = new ArrayList<ArrayList<String>>();
		PreparedStatement pStmt = null; 
		ResultSet rs = null;
		SimpleDateFormat sdf = new SimpleDateFormat("mm/dd/yyyy");
		Date mDate = null;
		//Query the database
		try {
			if(date != null){
				 mDate = (Date) sdf.parse(date);				
			}
			if(salary == null){
				salary = DEAFULT_SALARY;
			}
			pStmt = dbs.getConnection().prepareStatement("{call FilterPositions(?, ?, ?, ?, ?, ?)}");
			pStmt.setString(1, studentID);
			pStmt.setDouble(2, salary);				
			pStmt.setDate(3, mDate);
			pStmt.setString(4, location);
			pStmt.setString(5, Company);
			pStmt.setInt(6, isQualified);
			rs= pStmt.executeQuery();
			
			//Adding the result set values to the nested array list
			while(rs.next()){
				ArrayList<String> currentRow = new ArrayList<>(); 
				currentRow.add(rs.getString("Company Name"));
				currentRow.add(rs.getString("Position Name"));
				currentRow.add(rs.getString("Description"));
				currentRow.add(rs.getString("Location"));
				currentRow.add(rs.getString("Salary"));
				currentRow.add(rs.getString("Start Date"));
				returnSet.add(currentRow);
			}
		
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return returnSet;
		
	}
	
	public ResultSet getDegree(int studentID) {
		PreparedStatement pStmt;
		try {
			pStmt = dbs.getConnection().prepareStatement("{call getDegreeByStudent(?)}");
			pStmt.setInt(1, studentID);
			int rs = pStmt.executeUpdate();
			System.out.println(rs);
			dbs.getConnection().commit();
			return pStmt.getResultSet();
			
		}catch(SQLException e) {
			e.printStackTrace();
			return null;}
	}
	
	public ResultSet getExperience(int studentID) {
		PreparedStatement pStmt;
		try {
			pStmt = dbs.getConnection().prepareStatement("{call getExperienceByStudent(?)}");
			pStmt.setInt(1, studentID);
			int rs = pStmt.executeUpdate();
			System.out.println(rs);
			dbs.getConnection().commit();
			return pStmt.getResultSet();
			
		}catch(SQLException e) {
			e.printStackTrace();
			return null;}
	}
	
	public ResultSet getSkills(int studentID) {
		PreparedStatement pStmt;
		try {
			pStmt = dbs.getConnection().prepareStatement("{call getSkillsByStudent(?)}");
			pStmt.setInt(1, studentID);
			int rs = pStmt.executeUpdate();
			System.out.println(rs);
			dbs.getConnection().commit();
			return pStmt.getResultSet();
			
		}catch(SQLException e) {
			e.printStackTrace();
			return null;}
	}
	
	public ResultSet getStudent(int studentID) {
		PreparedStatement pStmt;
		try {
			pStmt = dbs.getConnection().prepareStatement("{call getStudentByID(?)}");
			pStmt.setInt(1, studentID);
			int rs = pStmt.executeUpdate();
			System.out.println(rs);
			dbs.getConnection().commit();
			return pStmt.getResultSet();
			
		}catch(SQLException e) {
			e.printStackTrace();
			return null;}
	}
	
	public ResultSet getPassword(int studentID) {
		PreparedStatement pStmt;
		try {
			pStmt = dbs.getConnection().prepareStatement("{call getStudentPassword(?)}");
			pStmt.setInt(1, studentID);
			int rs = pStmt.executeUpdate();
			System.out.println(rs);
			dbs.getConnection().commit();
			return pStmt.getResultSet();
			
		}catch(SQLException e) {
			e.printStackTrace();
			return null;}
	}

	
}
