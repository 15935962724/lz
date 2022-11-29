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

public class ConfirmUpdate extends HttpServlet{

        private static final String CONTENT_TYPE="text/xml; charset=gb2312";

        public void init() throws ServletException{}
        public void doPost(HttpServletRequest request,HttpServletResponse response)

        throws ServletException,IOException{
                 //ZIPUtil zp=new ZIPUtil();
                 ZIPUtil zp1=new ZIPUtil();
                FileService fs=new FileService();

  String path=request.getSession().getServletContext().getRealPath("/");
  String filename=request.getParameter("filename");
  String sql=request.getParameter("sql");
   fs.cretesql(sql.getBytes(),path+"\\update\\",filename+"\\db.sql");
    zp1.zip(new File(path+"\\update\\"+filename), new File(path+"\\update\\"+filename+".zip"));
   fs.delete(path+"\\update\\"+filename);

    response.sendRedirect("/jsp/version/list.jsp");
        }
        }

