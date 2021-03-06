import java.sql.Connection;
import java.text.ParseException;
import java.util.ArrayList;

public class ResumeMain {

	public static void main(String[] args) throws ParseException {
		
		//Database set up and creation of handler
		DatabaseConnectionService db = new DatabaseConnectionService("golem.csse.rose-hulman.edu", "ResumeBuilder");
		db.connect("ResumeBuilder38", "Password38");
		InteractionHandler handler = new InteractionHandler(db);
		DatabaseBuilder builder = new DatabaseBuilder(db);
		
		//This test calling the positions qualified for based on skills
//		ArrayList<ArrayList<String>> returnedSet = handler.getQualifiedPositions("Sonnebtb");
//		System.out.println("All qualified Positions Result: "+returnedSet.get(0));
		
		
		//This test calling the filter stored procedure
//		ArrayList<ArrayList<String>> returnedSet2 = handler.filterPositions("Sonnebtb", null, null, null, null, 0);
//		System.out.println("All filtered Positions Result: "+returnedSet2.get(0));
//		System.out.println("All filtered Positions Result: "+returnedSet2.get(1));
		
		//This builds the company table
//		for(int i = 1; i < 101; i++){
//			if(!builder.addCompany("TestComapny"+i)){System.out.println("Utter Failure");}	
//		}
		
		//This builds the company table
		for(int i = 1; i < 101; i++){
			Integer temp = i;
			Float temp2 = (float) 1.25;
			if(builder.addPosition(temp2, "TestPos"+i, "Location"+i, "This is Description 1", "Google")==null){System.out.println("Utter Failure");}	
		}
		System.out.println("Done");
		
		
	}

}
