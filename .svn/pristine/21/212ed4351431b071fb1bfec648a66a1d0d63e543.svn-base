package tea.service.version;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import tea.db.DbAdapter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
public class InitUpdate extends HttpServlet{

      //  private static final String CONTENT_TYPE="text/xml; charset=gb2312";

        public void init() throws ServletException{}
        public void doPost(HttpServletRequest request,HttpServletResponse response)

        throws ServletException,IOException{

                 DBManager db=new DBManager();

                 request.setCharacterEncoding("UTF-8");
  String path=request.getSession().getServletContext().getRealPath("/");
  String version=request.getParameter("newversion");
  String client=request.getParameter("client");
  String introduce=request.getParameter("introduce");
  Version v=new Version();
  HttpSession session=request.getSession();

  SimpleDateFormat dd=new SimpleDateFormat("yyyy-MM-dd");
  db.initSQL(session);
        // ����sql
       String name=request.getParameter("client");
  DbAdapter db1=new DbAdapter();
         try{
         int count=db1.getInt("select count(1) from clientcode");
         db1.executeUpdate("delete from version");
         if(count==0)
         {db1.executeUpdate("insert into clientcode(name,introduce)values("+DbAdapter.cite(name)+","+DbAdapter.cite(introduce)+")");
         }
         else
         {
           db1.executeUpdate("update clientcode set name="+DbAdapter.cite(name)+
                            ",introduce="+DbAdapter.cite(introduce));
         }


         }catch (Exception e){
         e.printStackTrace();

         }
  db1.close();

    //���sql

 //  ��ɰ汾����
    v.setCurversion(version);
    v.setPreversion(version);
    v.setUpdatetime(dd.format(new Date()));
    v.setClient(client);
  //  v.saveversion(path+"\\update\\"+client+"_"+version);
    v.saveversion(path);
    db.setVersion(version,v.getUpdatetime(),version,introduce,client);
    response.sendRedirect("/jsp/version/done.jsp");
          }
        }

