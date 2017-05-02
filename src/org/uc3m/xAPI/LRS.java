package org.uc3m.xAPI;

import java.net.MalformedURLException;
import java.util.ArrayList;

import gov.adlnet.xapi.client.StatementClient;

public class LRS {
	String LRS_URI = "http://62.204.199.105/data/xAPI/";
	String USERNAME = "a0034dc9684deff87aea9f4354dd2b2925d92391";
	String PASSWORD = "5d6e85d7072b6b769aa79121186e693ea813c84f";
	
	public ArrayList<String> getActivities(){
		try {
			StatementClient client = new StatementClient(LRS_URI, USERNAME,	PASSWORD);
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
		return null;
		
	}

}
