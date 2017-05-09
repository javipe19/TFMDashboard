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
	private static final String LOGIN_PAGE = "/login.jsp"; //ruta de la pagina de login
       
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
		LRS lrs = new LRS();
		
		if(user==null || user==""){
			RequestDispatcher rs = request.getServletContext().getRequestDispatcher(LOGIN_PAGE);
		    rs.forward(request, response);
		}
		else if(request.getParameter("page").contains("data")){
			JsonArray dates= new JsonArray();
			if(user.equals(ADMIN)){
				//Recent History
				ArrayList<String> history = lrs.getRecentHistory();
				//Dates
				dates = lrs.getRecentDates();
				//Test Responses
				HashMap<String, String> test = lrs.getAllTestResponses();
				
				request.setAttribute("history", history);
				request.setAttribute("dates", dates);
				request.setAttribute("test", test);
			}
			else{
				//Recent History
				ArrayList<String> history = lrs.getRecentActorHistory(user);
				//Dates
				dates = lrs.getDates(user);
				//Test Responses
				ArrayList<String> test = lrs.getActorTestResponses(user);
				
				request.setAttribute("history", history);
				request.setAttribute("dates", dates);
				request.setAttribute("test", test);
			}

			RequestDispatcher rs = request.getServletContext().getRequestDispatcher("/data.jsp");
		    rs.forward(request, response); 
		}
		else if(request.getParameter("page").contains("act")){
			if(user.equals(ADMIN)){
				String act = lrs.getActivities();
				request.setAttribute("act", act);
			}
			else{
				String act = lrs.getActorActivities(user);
				request.setAttribute("act", act);
			}
			
			RequestDispatcher rs = request.getServletContext().getRequestDispatcher("/act.jsp");
		    rs.forward(request, response); 
		}
		
		else if(request.getParameter("page").contains("time")){
			if(user.equals(ADMIN)){
				String times = lrs.getMaxPagesAndTimes();
				request.setAttribute("times", times);
			}
			else{
				String times = lrs.getPagesAndTimes(user);
				request.setAttribute("times", times);
			}
			
			RequestDispatcher rs = request.getServletContext().getRequestDispatcher("/time.jsp");
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
