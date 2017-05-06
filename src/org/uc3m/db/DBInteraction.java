package org.uc3m.db;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

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
		
			JSONParser jsonParser = new JSONParser();
			JSONObject jsonObject = (JSONObject)jsonParser.parse(new InputStreamReader(is, "UTF-8"));
			authenticated = !(boolean) jsonObject.get("error");
			//System.out.println(authenticated);

			
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ParseException e) {
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
		
			JSONParser jsonParser = new JSONParser();
			JSONObject jsonObject = (JSONObject)jsonParser.parse(new InputStreamReader(is, "UTF-8"));
			signedup = !(boolean) jsonObject.get("error");
			String msg = (String) jsonObject.get("msg");
			result.add(signedup);
			result.add(msg);
			//System.out.println(authenticated);

			
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return result;
	}

}
