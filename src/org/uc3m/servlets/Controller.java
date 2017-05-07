package org.uc3m.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.uc3m.xAPI.LRS;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import gov.adlnet.xapi.client.StatementClient;
import gov.adlnet.xapi.model.StatementResult;
import gov.adlnet.xapi.model.Verbs;



/**
 * Servlet implementation class Controller
 */
@WebServlet("/Controller")
public class Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
	String LRS_URI = "http://62.204.199.105/data/xAPI/";
	String USERNAME = "a0034dc9684deff87aea9f4354dd2b2925d92391";
	String PASSWORD = "5d6e85d7072b6b769aa79121186e693ea813c84f";
	String ADMIN = "javipe19@gmail.com";
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Controller() {
        super();
        
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession(true); //se crea la sesion
		String user = (String) session.getAttribute("userName");
		if(request.getParameter("page").contains("data")){
			LRS lrs = new LRS();
			//Get Actors
			ArrayList<String> actors = lrs.getActors();
			//Recent History
			ArrayList<String> history = lrs.getRecentHistory();
			System.out.println(history);
			request.setAttribute("history", history);
			//Dates
			JsonArray dates= new JsonArray();
			if(user.equals(ADMIN)){
				for(int j=0; j<actors.size();j++){
					String lrsdates = lrs.getDates(actors.get(j));
					JsonParser parser = new JsonParser();
					JsonArray a = (JsonArray) parser.parse(lrsdates);
					JsonObject actorlastdate = new JsonObject();
					actorlastdate.addProperty("actor", actors.get(j));
					actorlastdate.addProperty("date", a.get(0).getAsJsonObject().get("date").toString());
					dates.add(actorlastdate);
				}
			request.setAttribute("dates", dates);
			}
			
			RequestDispatcher rs = request.getServletContext().getRequestDispatcher("/data.jsp");
		    rs.forward(request, response);
		    
		    
		    
		    
		}	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
