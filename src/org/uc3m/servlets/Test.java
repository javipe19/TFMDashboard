package org.uc3m.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.uc3m.xAPI.LRS;

/**
 * Servlet implementation class Test
 */
@WebServlet("/Test")
public class Test extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Test() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		LRS lrs = new LRS();
		String actor = "javipe19@gmail.com";
		String json = lrs.getDates(actor);
		String jsondos = lrs.getActorActivities(actor);
		PrintWriter out = response.getWriter();
		out.println(json);
		out.println(jsondos);
		out.println(lrs.getAllActorHistory(actor));
		out.println(lrs.getRecentActorHistory(actor));
		out.println(lrs.getActorTestResponses(actor).get(0));
		out.println(lrs.getAllTestResponses());

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
