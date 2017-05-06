package org.uc3m.xAPI;

import java.io.IOException;
import java.net.MalformedURLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.Duration;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Set;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import gov.adlnet.xapi.client.ActivityClient;
import gov.adlnet.xapi.client.AgentClient;
import gov.adlnet.xapi.client.StatementClient;
import gov.adlnet.xapi.model.Actor;
import gov.adlnet.xapi.model.Statement;
import gov.adlnet.xapi.model.StatementResult;
import gov.adlnet.xapi.model.Verbs;

public class LRS {
	String LRS_URI = "http://62.204.199.105/data/xAPI/";
	String ENDPOINT = "http://62.204.199.105";
	String USERNAME = "a0034dc9684deff87aea9f4354dd2b2925d92391";
	String PASSWORD = "5d6e85d7072b6b769aa79121186e693ea813c84f";
	ArrayList<String> activitiesIds = new ArrayList<String>();
	StatementClient stmtClient;
	StatementClient getMoreClient;
	AgentClient agentClient;
	ActivityClient actClient;
	
	public LRS(){
		try {
			stmtClient = new StatementClient(LRS_URI, USERNAME,	PASSWORD);
			getMoreClient = new StatementClient(ENDPOINT, USERNAME,	PASSWORD);
			agentClient = new AgentClient(LRS_URI, USERNAME,PASSWORD);
			actClient = new ActivityClient(LRS_URI, USERNAME,PASSWORD);
			
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		activitiesIds.add("http://adlnet.gov/expapi/activities/assessment");
		activitiesIds.add("http://adlnet.gov/expapi/activities/attempt");
		activitiesIds.add("http://adlnet.gov/expapi/activities/course");
		activitiesIds.add("http://adlnet.gov/expapi/activities/file");
		activitiesIds.add("http://adlnet.gov/expapi/activities/interaction");
		//Lesson ("Pages") activities not considered for user activities
		//activitiesIds.add("http://adlnet.gov/expapi/activities/lesson");
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
		String acts = null;
		try {
	
			JSONArray jsonarray= new JSONArray();
			for(int i=0;i<activitiesIds.size();i++){
				StatementResult results = stmtClient.filterByActivity(activitiesIds.get(i)).getStatements();
				ArrayList<Statement> statements = results.getStatements();
				ArrayList<String> activityArray = statementsToActivityArray(statements);
				Set<String> unique = new HashSet<String>(activityArray);
				for (String key : unique) {				
				    //System.out.println(key + ": " + Collections.frequency(stmtsArray, key));
					JSONObject json = new JSONObject();
					json.put("name", key.toString());
					json.put("frequency", Collections.frequency(activityArray, key));
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
	
	public String getActorActivities(String actor){
		String acts = null;
		try {
	
			JSONArray jsonarray= new JSONArray();
			for(int i=0;i<activitiesIds.size();i++){
				StatementResult results = stmtClient.filterByActivity(activitiesIds.get(i)).getStatements();
				ArrayList<Statement> allStatements = results.getStatements();
				ArrayList<Statement> actorStatements = getActorStatements(allStatements, actor);
				ArrayList<String> activityArray = statementsToActivityArray(actorStatements);
				Set<String> unique = new HashSet<String>(activityArray);
				for (String key : unique) {				
				    //System.out.println(key + ": " + Collections.frequency(stmtsArray, key));
					JSONObject json = new JSONObject();
					json.put("name", key.toString());
					json.put("frequency", Collections.frequency(activityArray, key));
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
	
	public ArrayList<String> statementsToActivityArray(ArrayList<Statement> statements){
		ArrayList<String> activities = new ArrayList<String>();
		for(int j=0; j<statements.size();j++){
			String activity = getStatementActivity(statements.get(j));
			activities.add(activity);
		}

		return activities;	
	}
	
	public String getStatementActivity(Statement statement){
		String stmt = statement.toString();
		stmt = stmt.substring(stmt.indexOf(" ", stmt.indexOf(" ") + 1)+1, stmt.length()); //second occurrence of " "
		return stmt;
	}
	
	public String getPagesAndTimes(String actor){
		String s=null;
		try {
			JSONArray jsonarray= new JSONArray();
			StatementResult results = stmtClient.filterByVerb(Verbs.terminated()).filterByActivity("http://adlnet.gov/expapi/activities/lesson").getStatements();
			ArrayList<Statement> statements = getAllStatements(results);
			for(int i=0; i<statements.size(); i++){
				Statement stmt = statements.get(i);
				if(stmt.getActor().getName().contains(actor)){
					String page = getStatementActivity(stmt);
					String duration = stmt.getResult().getDuration();
					Duration d = Duration.parse(duration);
					long seconds = d.getSeconds();
					JSONObject json = new JSONObject();
					json.put("page", page);
					json.put("duration", seconds);
					jsonarray.add(json);
				}
			}
			
			s = jsonarray.toJSONString();
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return s;
		
	}
	
	public String getDates(String actor){
		String s=null;
		ArrayList<String> temp = new ArrayList<String>();
		try {
			JSONArray jsonarray= new JSONArray();
			StatementResult results = stmtClient.getStatements();
			ArrayList<Statement> statements = getAllStatements(results);
			for(int i=0; i<statements.size(); i++){
				Statement stmt = statements.get(i);
				if(stmt.getActor().getName()!=null && stmt.getActor().getName().contains(actor)){
					String timestamp = stmt.getTimestamp();
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
					SimpleDateFormat output = new SimpleDateFormat("yyyy-MM-dd");
					Date d = sdf.parse(timestamp.substring(0,18));
					String formattedTime = output.format(d);
					if (!temp.contains(formattedTime)){
						temp.add(formattedTime);
						JSONObject json = new JSONObject();
						json.put("date", formattedTime);
						jsonarray.add(json);
					}
				}
			}
			
			s = jsonarray.toJSONString();
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return s;
	}
	
	public ArrayList<Statement> getAllStatements(StatementResult previousPage){
		ArrayList<Statement> statements = previousPage.getStatements();
			try {
				while(previousPage.hasMore()){
					previousPage = getMoreClient.getStatements(previousPage.getMore());
					statements.addAll(previousPage.getStatements());
				}
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		return statements;
		
	}
	
	public ArrayList<Statement> getActorStatements(ArrayList<Statement> allStatements, String actor){
		ArrayList<Statement> actorStatements = new ArrayList<Statement>();
		for(int i=0; i<allStatements.size(); i++){
			Statement stmt = allStatements.get(i);
			if(stmt.getActor().getName()!=null && stmt.getActor().getName().contains(actor)){
				actorStatements.add(stmt);
			}
		}
		return actorStatements;
		
	}
	
	public ArrayList<String> getRecentHistory(String actor){
		ArrayList<String> history = new ArrayList<String>();
		try {
			StatementResult results = stmtClient.getStatements();
			ArrayList<Statement> statements = results.getStatements();
			ArrayList<Statement> actorStatements = getActorStatements(statements, actor);
			for(int i=0; i<actorStatements.size();i++){
				Statement stmt = actorStatements.get(i);
				history.add(stmt.toString());
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return history;
	}
	
	public ArrayList<String> getAllHistory(String actor){
		ArrayList<String> history = new ArrayList<String>();
		try {
			StatementResult results = stmtClient.getStatements();
			ArrayList<Statement> allStatements = getAllStatements(results);
			ArrayList<Statement> actorStatements = getActorStatements(allStatements, actor);
			for(int i=0; i<actorStatements.size();i++){
				Statement stmt = actorStatements.get(i);
				history.add(stmt.toString());
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return history;
	}
	
	public ArrayList<String> getActorTestResponses(String actor){
		ArrayList<String> responses = new ArrayList<String>();
		try {
			StatementResult results = stmtClient.filterByVerb(Verbs.answered()).filterByActivity("http://adlnet.gov/expapi/activities/assessment").getStatements();
			ArrayList<Statement> allStatements = getAllStatements(results);
			ArrayList<Statement> actorStatements = getActorStatements(allStatements, actor);
			for(int i=0; i<actorStatements.size();i++){
				Statement stmt = actorStatements.get(i);
				if(stmt.getResult()!=null && stmt.getResult().getResponse()!=null){
					String response = stmt.getResult().getResponse();
					responses.add(response);
				}
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return responses;
	}
	
	//gets the latest response to the test submitted by each actor
	public HashMap<String, String> getAllTestResponses(){
		HashMap<String, String> allresponses = new HashMap<String, String>();
		try {
			StatementResult results = stmtClient.filterByVerb(Verbs.answered()).filterByActivity("http://adlnet.gov/expapi/activities/assessment").getStatements();
			ArrayList<Statement> allStatements = getAllStatements(results);
			for(int i=0; i<allStatements.size();i++){
				Statement stmt = allStatements.get(i);
				String actor = stmt.getActor().getName();
				if(stmt.getResult()!=null && stmt.getResult().getResponse()!=null){
					String response = stmt.getResult().getResponse();
					//System.out.println(actor);
					//System.out.println(response);
					if(!allresponses.containsKey(actor)){
						allresponses.put(actor, response);
					}
				}
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return allresponses;
	}

}
