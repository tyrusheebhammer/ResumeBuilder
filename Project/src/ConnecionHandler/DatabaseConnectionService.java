package ConnecionHandler;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnectionService {

	//DO NOT EDIT THIS STRING, YOU WILL RECEIVE NO CREDIT FOR THIS TASK IF THIS STRING IS EDITED
	private final String SampleURL = "jdbc:sqlserver://${dbServer};databaseName=${dbName};user=${user};password={${pass}}";

	private Connection connection = null;

	private String databaseName;
	private String serverName;

	public DatabaseConnectionService(String serverName, String databaseName) {
		this.serverName = serverName;
		this.databaseName = databaseName;
	}

	public boolean connect(String user, String pass) {
		String connectURL = "jdbc:sqlserver://"+ 
								serverName +
								";databaseName=" +
								databaseName +
								";user=" + 
								user + 
								";password="+
								pass;
		
		Connection currConn = getConnection(); 
		try {
			System.out.println(connectURL);
			connection= DriverManager.getConnection(connectURL);
			System.out.println("connection successful");
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		
	}
	

	public Connection getConnection() {
		return this.connection;
	}
	
	public void closeConnection() {
		try {
			this.getConnection().close();
		} catch (SQLException e) {
			System.out.println("Error in closing the connection");
			e.printStackTrace();
		}
	}

}

