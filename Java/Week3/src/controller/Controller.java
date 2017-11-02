package controller; /* Name the java package into controller */
import java.io.IOException; /* Retrieve input output exception */

import javax.servlet.ServletException; /* Retrieve ServletException */
import javax.servlet.http.HttpServlet; /* Retrieve HttpServlet */
import javax.servlet.http.HttpServletRequest; /* Retrieve HttpServletRequest */
import javax.servlet.http.HttpServletResponse; /* Retrieve HttpServletResponse */

import model.Model; /* Retrieve src model */

/**
 * Servlet implementation class Controller
 */
public class Controller extends HttpServlet { /* A Controller public class but inheret from class HttpServlet */
	private static final long serialVersionUID = 1L; /* Set variable private static final long serialVersionUID, a version control which ID is stamped on object. */
	private static Model model = new Model(); /* Set the model variable as a model object from model class */

	/**
	 * @author nakano@cc.kumamoto-u.ac.jp
	 * @version 2015-04-23
	 * 
	 * MVC sample program : Controller
	 *
	 */

	public Controller() { /* Method controller */
		super(); /* Call a super class constructor or call an immediate parent */
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) /* request: an HttpServletRequest object that contains the request the client has made of the servlet, response: an HttpServletResponse object that contains the response the servlet sends to the client */
	    throws ServletException, IOException { /* java.io.IOException: if an input or output error is detected when the servlet handles the GET request, ServletException: if the request for the GET could not be handled */
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String sender = request.getParameter("sender"); /* set the sender variable as string, returns request parameter as string or null if parameter not exist */
		String content = request.getParameter("content"); /* same as previous line */
		String remoteIp = request.getRemoteAddr(); /* get remote address of requester as string or null if not exist */
		model.setComment(sender, content, remoteIp); /* from model set the comment with sender, content, and remoteIP */
		getServletContext().getRequestDispatcher("/view.jsp").forward(request, response); /* returns the servletcontext which this session belongs, forwards a client's request and response to view.jsp */
	}

}
