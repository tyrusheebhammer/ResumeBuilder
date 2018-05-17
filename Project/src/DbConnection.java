import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.swing.JOptionPane;

public class DbConnection {
	private final String SampleURL = "jdbc:sqlserver://${dbServer};databaseName=${dbName};user=${user};password={${pass}}";
	
	private Connection connection = null;

	String databaseName;
	String serverName;
	
	public DbConnection(String serverName, String databaseName) {

		this.serverName = serverName;
		this.databaseName = databaseName;
	}
	public boolean connect(String user, String pass) {
		
		String connectionString =  
                "jdbc:sqlserver://"+serverName+";" 
                + "databaseName="+databaseName+";"  
                + "user="+user+";"  
                + "password="+pass;  
		
		
		try {  			
            connection = DriverManager.getConnection(connectionString);  
            return true;

        }  
        catch (Exception e) {  
            e.printStackTrace();  
            return false;
        }  
		
	}
	public Connection getConnection() {
		return this.connection;
	}
	
	public void closeConnection() {
		try {
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public String getLoginInfo(String Username) {
		Statement stmt = null;
		System.out.println("here");
		String password=null;
		try {
			stmt = connection.createStatement();
			ResultSet rs = stmt.executeQuery(
					"Select Password From Student Where StudentID="+"'"+Username+"'");
			if (rs.next()) {
				password = rs.getString("Password");
			}
			rs.close();
			return password;
			
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
	
	public void addUser(String username, String password, String fName, String mInit, String lName, String address, int phone) {

		CallableStatement cs = null;
		
		try {

	        cs = connection.prepareCall("{? = call AddStudent( ?, ?, ?, ?, ?, ?, ?)}");
	        cs.registerOutParameter(1, Types.INTEGER);
	        cs.setString(2, username);
	        cs.setString(3, fName);
	        cs.setString(4, mInit);
	        cs.setString(5, lName);
	        cs.setString(6, address);
	        cs.setInt(7, phone);
	        cs.setString(8, password);
	        cs.execute();
	        cs.close();
	        
	        
	        
	    } catch (SQLException e ) {
	    	JOptionPane.showMessageDialog(null, e.getMessage());
	    }
	}
	
	public void addExperience(String SID, String name, String description, String startDate, String endDate ) {
		CallableStatement cs = null;
		
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
			cs = connection.prepareCall("{? = call AddExperience( ?, ?, ?, ?, ?)}");
			cs.registerOutParameter(1, Types.INTEGER);
			cs.setString(2, SID);
	        cs.setString(3, name);
	        cs.setString(4, description);
	        Date sDate = sdf.parse(startDate);
	        java.sql.Date sDateSQL = new java.sql.Date(sDate.getTime());
	        cs.setDate(5, sDateSQL);
	        Date eDate = sdf.parse(endDate);
	        java.sql.Date eDateSQL = new java.sql.Date(eDate.getTime());
	        cs.setDate(6, eDateSQL);
	        cs.execute();
	        cs.close();
	        
			
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
	}
	
	public void addDegree(String SID, String name, int gradYear, String type, String field ) {
		CallableStatement cs = null;
		
		try {
			
			cs = connection.prepareCall("{? = call AddDegree( ?, ?, ?, ?, ?)}");
			cs.registerOutParameter(1, Types.INTEGER);
			cs.setString(2, SID);
	        cs.setString(3, name);
	        cs.setInt(4, gradYear);
	        cs.setString(5, type);
	        cs.setString(6, field);
	        cs.execute();
	        cs.close();
	        
	        
	        
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	
	public ArrayList<String[]> filterCompanies(String SID, double salary, String date, String location, String companyName, int qb) {
		
		ArrayList<String[]> toReturn = new ArrayList<>();
		PreparedStatement cs = null;
		ResultSet rs = null;
		SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
		try {
			cs = connection.prepareStatement("{? = call FilterPositions( ?, ?, ?, ?, ?, ?)}");
			cs.setString(2, SID);
	        cs.setDouble(3, salary);
	        Date sDate = sdf.parse(date);
	        java.sql.Date sDateSQL = new java.sql.Date(sDate.getTime());
	        cs.setDate(4, sDateSQL);
	        cs.setString(5, location);
	        cs.setString(6, companyName);
	        cs.setInt(6, qb);
	        cs.execute();
	        cs.close();
	             
	        rs=cs.getResultSet();
			
			while(rs.next()) {
				String arr[]={rs.getString("company"),"PUT SOMETHING HERE",Double.toString(rs.getDouble("salary")),sdf.format(rs.getDate("startDate")),rs.getString("location")};
				toReturn.add(arr);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ParseException e) {

		}
		return toReturn;
		
	}
	
}
