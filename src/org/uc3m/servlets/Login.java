package org.uc3m.servlets;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.uc3m.db.DBInteraction;

/**
 * Servlet implementation class Login
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String LOGIN_PAGE = "/login.jsp"; //ruta de la pagina de login
	private static final String APP_PAGE = "/index.jsp"; //ruta de la pagina de la aplicacion
	private static final String LOGIN_ENDPOINT = "http://62.204.199.105/analytics/";
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("get");
		System.out.println(request.getParameter("logout"));
		
			if(request.getParameter("logout")!=null){
				//Log out
				HttpSession session = request.getSession(true); //se crea la sesion
				session.setAttribute("userName","");
				session.invalidate();
				RequestDispatcher rs = request.getServletContext().getRequestDispatcher(LOGIN_PAGE);
			    rs.forward(request, response);	
				}
			else{
				String user =(String) request.getSession().getAttribute("userName");
				if (user==null){
					RequestDispatcher rs = request.getServletContext().getRequestDispatcher(LOGIN_PAGE); //si el nombre de usuario vinculado en sesion es null, se pasa el control la página de login
					rs.forward(request, response);
				}
				else{
					RequestDispatcher rs = request.getServletContext().getRequestDispatcher(APP_PAGE);
				    rs.forward(request, response);
				}
			}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String strUserName = request.getParameter("userName");  
		String strPassword = request.getParameter("password");
		String strErrMsg = ""; 
		HttpSession session = request.getSession(true); 
		session.setAttribute("errorMsg", strErrMsg); 
		System.out.println("post");
		
			boolean isValid = false; 
			
			   try {
				   DBInteraction db=new DBInteraction();
				   isValid = db.authentication(LOGIN_ENDPOINT, strUserName, strPassword);
			     if(isValid) {
					strErrMsg = "";
			    	session.setAttribute("userName", strUserName); 
			     } 
			     else {
			        strErrMsg = "Wrong username or password. Please, try again."; 
			     }
			   } catch(Exception e) {
				   	strErrMsg = "Something happened while trying to validate in the database";
			   }
	
			   if(isValid) {
			       session.setAttribute("errorMsg", ""); 
			       session.setAttribute("userName",strUserName); 
				   RequestDispatcher rs = request.getServletContext().getRequestDispatcher(APP_PAGE); 
			       rs.forward(request, response);
			   	}   		   
			 
			   else {
				   	session.setAttribute("errorMsg", strErrMsg);
					RequestDispatcher rs = request.getServletContext().getRequestDispatcher(LOGIN_PAGE); 
					rs.forward(request, response);  
				}
			   
			}
	

}
