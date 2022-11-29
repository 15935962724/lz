package tea.service.version;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import tea.service.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletContext;
public class Update extends HttpServlet{

	private static final String CONTENT_TYPE="text/xml; charset=gb2312";

	public void init() throws ServletException{}
	public void doGet(HttpServletRequest request,HttpServletResponse response)
	throws ServletException,IOException{

		//response.setContentType(CONTENT_TYPE);
		// response.setHeader("Cache-Control","no-cache");
		// response.setHeader("Pragma","no-cache");
		// response.setDateHeader("Expires",0);

	String path=request.getSession().getServletContext().getRealPath("/");

	SimpleDateFormat dd=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
 	Date lastpack=new Date();
	  try {
		lastpack= dd.parse("2008-06-02 01:01:00");
	} catch (ParseException e) {
		e.printStackTrace();
	}
	ZIPUtil zu=new ZIPUtil();
	zu.zip(new File(path), new File(path+"\\update\\workspace1.zip"),lastpack);
	PrintWriter out=response.getWriter();
	 out.write("update pack sucessful!<a href='/update/workspace1.zip'>download</a>");
	 out.close();
	  }
	}

