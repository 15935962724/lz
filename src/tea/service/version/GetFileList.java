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
import java.util.*;

public class GetFileList extends HttpServlet{

        private static final String CONTENT_TYPE="text/xml; charset=gb2312";

        public void init() throws ServletException{}
        public void service(HttpServletRequest request,HttpServletResponse response)
        throws ServletException,IOException{
      String path=request.getSession().getServletContext().getRealPath("/");
          String client=request.getParameter("client");


          StringBuilder filelist=new StringBuilder("");
          File f = new File(path+"\\"+client);
                if (f.exists())
                {
                    File fs[] = f.listFiles();
                    for (int i = 0; i < fs.length; i++)
                    {  filelist.append(fs[i].getName()+"/");

                }
                }

        if(filelist.toString().endsWith("/"))
        filelist.delete(filelist.length()-1,filelist.length());
        PrintWriter out=response.getWriter();
         out.write(filelist.toString());
         out.close();
          }

}
