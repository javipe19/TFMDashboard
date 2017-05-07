package org.uc3m.db;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.List;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

public class DBInteraction {

	public boolean authentication(String endpoint, String strUserName, String strPassword) {
		// TODO Auto-generated method stub
		String urlString = endpoint+"check.php?q="+strUserName+"&p="+strPassword;
		boolean authenticated=false;
		URL url;
		try {
			url = new URL(urlString);
			URLConnection conn = url.openConnection();
			InputStream is = conn.getInputStream();
		
			JsonParser JsonParser = new JsonParser();
			JsonObject JsonObject = (JsonObject)JsonParser.parse(new InputStreamReader(is, "UTF-8"));
			authenticated = !(boolean) JsonObject.getAsJsonObject().get("error").getAsBoolean();
			//System.out.println(authenticated);

			
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 

		return authenticated;
	}
	
	public ArrayList<Object> register(String endpoint, String strUserName, String strPassword) {
		// TODO Auto-generated method stub
		String urlString = endpoint+"register.php?q="+strUserName+"&p="+strPassword;
		ArrayList<Object> result = new ArrayList<Object>();
		boolean signedup=false;
		URL url;
		try {
			url = new URL(urlString);
			URLConnection conn = url.openConnection();
			InputStream is = conn.getInputStream();
		
			JsonParser JsonParser = new JsonParser();
			JsonObject JsonObject = (JsonObject)JsonParser.parse(new InputStreamReader(is, "UTF-8"));
			signedup = !(boolean) JsonObject.getAsJsonObject().get("error").getAsBoolean();
			String msg = (String) JsonObject.getAsJsonObject().get("msg").getAsString();
			result.add(signedup);
			result.add(msg);
			//System.out.println(authenticated);

			
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		
		return result;
	}

}
