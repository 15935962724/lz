package tea.service.version;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class CreateUpdate extends HttpServlet{

	private static final String CONTENT_TYPE="text/xml; charset=gb2312";

	public void init() throws ServletException{}
	public void service(HttpServletRequest request,HttpServletResponse response)

	throws ServletException,IOException{
		 ZIPUtil zp=new ZIPUtil();
                 ZIPUtil zp1=new ZIPUtil();
		 DBManager db=new DBManager();
		 FileService fs=new FileService();

  String path=request.getSession().getServletContext().getRealPath("/");
  HttpSession session=request.getSession();
  String version=request.getParameter("newversion");
  String client=request.getParameter("client");
  String introduce=request.getParameter("introduce");
  Version v=new Version();
  String updatetime ="2008-06-01";
  String lastversion="0.0.0.0";
 PrintWriter out=response.getWriter();
 String vi= v.getversion(path+"\\version.properties");
  if (vi!=null)
  {
  updatetime =v.getUpdatetime();
  lastversion=v.getCurversion();
  }

  SimpleDateFormat dd=new SimpleDateFormat("yyyy-MM-dd");
	Date lastpack=new Date();
	  try {	lastpack= dd.parse(updatetime);} catch (ParseException e) {e.printStackTrace();}

//	 ������
      String sql=db.CreateSQL(session);
        // ����sql


    //���sql

 //  ��ɰ汾����
    v.setCurversion(version);
    v.setPreversion(lastversion);
    v.setUpdatetime(dd.format(new Date()));
    v.setClient(client);
    v.saveversion(path+"\\update\\"+client+"_"+version);
    fs.cretesql(sql.getBytes(),path+"\\update\\",client+"_"+version+"\\db.sql");

    zp.zip(new File(path), new File(path+"\\update\\"+client+"_"+version+"\\file.zip"),lastpack,session);
    v.saveversion(path);

    db.setVersion(version,v.getUpdatetime(),lastversion,introduce,client);
    response.sendRedirect("/jsp/version/CreateConfirm.jsp?confirm="+client+"_"+version);
	  }
	}

