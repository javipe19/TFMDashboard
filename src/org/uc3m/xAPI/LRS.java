package org.uc3m.xAPI;

import java.io.IOException;
import java.net.MalformedURLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Set;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import gov.adlnet.xapi.client.StatementClient;
import gov.adlnet.xapi.model.Statement;
import gov.adlnet.xapi.model.StatementResult;

public class LRS {
	String LRS_URI = "http://62.204.199.105/data/xAPI/";
	String USERNAME = "a0034dc9684deff87aea9f4354dd2b2925d92391";
	String PASSWORD = "5d6e85d7072b6b769aa79121186e693ea813c84f";
	ArrayList<String> activitiesIds = new ArrayList<String>();
	
	public LRS(){
		activitiesIds.add("http://adlnet.gov/expapi/activities/assessment");
		activitiesIds.add("http://adlnet.gov/expapi/activities/attempt");
		activitiesIds.add("http://adlnet.gov/expapi/activities/course");
		activitiesIds.add("http://adlnet.gov/expapi/activities/file");
		activitiesIds.add("http://adlnet.gov/expapi/activities/interaction");
		activitiesIds.add("http://adlnet.gov/expapi/activities/lesson");
		activitiesIds.add("http://adlnet.gov/expapi/activities/link");
		activitiesIds.add("http://adlnet.gov/expapi/activities/media");
		activitiesIds.add("http://adlnet.gov/expapi/activities/meeting");
		activitiesIds.add("http://adlnet.gov/expapi/activities/module");
		activitiesIds.add("http://adlnet.gov/expapi/activities/objective");
		activitiesIds.add("http://adlnet.gov/expapi/activities/performance");
		activitiesIds.add("http://adlnet.gov/expapi/activities/profile");
		activitiesIds.add("http://adlnet.gov/expapi/activities/question");
		activitiesIds.add("http://adlnet.gov/expapi/activities/simulation");
		//All activities ids from the ADL Vocabulary
	}
	
	public String getActivities(){
		HashMap<String, Integer> activities = new HashMap<String, Integer>();
		String acts = null;
		try {
			StatementClient client = new StatementClient(LRS_URI, USERNAME,	PASSWORD);
			JSONArray jsonarray= new JSONArray();
			for(int i=0;i<activitiesIds.size();i++){
				StatementResult results = client.filterByActivity(activitiesIds.get(i)).getStatements();
				ArrayList<Statement> statements = results.getStatements();
				ArrayList<String> stmtsArray = statementsToArray(statements);
				Set<String> unique = new HashSet<String>(stmtsArray);
				for (String key : unique) {				
				    //System.out.println(key + ": " + Collections.frequency(stmtsArray, key));
				    activities.put(key, Collections.frequency(stmtsArray, key));
					JSONObject json = new JSONObject();
					json.put("name", key.toString());
					json.put("frequency", Collections.frequency(stmtsArray, key));
					jsonarray.add(json);
				}
				
			acts=jsonarray.toJSONString();
			}
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
		return acts;
		
	}
	
	public ArrayList<String> statementsToArray(ArrayList<Statement> statements){
		ArrayList<String> stmts = new ArrayList<String>();
		for(int j=0; j<statements.size();j++){
			String stmt = statements.get(j).toString();
			stmt = stmt.substring(stmt.indexOf(" ", stmt.indexOf(" ") + 1)+1, stmt.length()); //second occurrence of " "
			stmts.add(stmt);
		}

		return stmts;
		
		
	}

}
