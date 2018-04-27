import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbConnection {
	private Connection connection = null;

	private String databaseName;
	private String serverName;
	
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
}
