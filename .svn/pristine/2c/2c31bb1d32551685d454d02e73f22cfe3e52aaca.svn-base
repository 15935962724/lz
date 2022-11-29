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

public class ExecuteUpdate extends HttpServlet{

	private static final String CONTENT_TYPE="text/xml; charset=gb2312";

	public void init() throws ServletException{}
	public void doGet(HttpServletRequest request,HttpServletResponse response)

	throws ServletException,IOException{
		 ZIPUtil zp=new ZIPUtil();
		 DBManager db=new DBManager();
		 FileService fs=new FileService();
                 PrintWriter out=response.getWriter();

  String path=request.getSession().getServletContext().getRealPath("/");
  String uppack=request.getParameter("filename");
  String uppack1 = path + "\\version\\" + uppack + ".zip";
  File unpacktopath = new File(path + "\\version\\");
  zp.unzip(new File(uppack1), unpacktopath);

  Version vlocal=new Version();
  Version vupdate=new Version();
   vupdate.getversion(path+"\\version\\"+request.getParameter("filename")+"\\version.properties");
  File file=new File(path+"\\version\\"+request.getParameter("filename")+"\\version.properties");
  if (!file.exists())
  {
   out.print("updatepack error!");
   return;
  }
  if(vlocal.getversion(path+"\\version\\version.properties")!=null)
 {
   if( !vupdate.getPreversion().
       equals(vlocal.getCurversion()))
   {
       out.print("version error!");
       return ;
   }
 }

if(vlocal.getversion()==null||(vlocal.getversion()!=null&&vupdate.getPreversion().equals(vlocal.getCurversion())))
{

    uppack = path + "\\version\\" + request.getParameter("filename") + "\\file.zip";
    unpacktopath = new File(path);
    zp.unzip(new File(uppack), unpacktopath);
    SimpleDateFormat dd = new SimpleDateFormat("yyyy-MM-dd");
    db.excuteSQL(path + "\\version\\" + request.getParameter("filename") + "\\db.sql");
    vlocal = vupdate;
    vlocal.saveversion(path+"\\version");
}
    /*
     *  ���汾�����¼������ݿ�
     *
     * */
    //db.setVersion(version,v.getUpdatetime(),lastversion);


	 out.write("Update Successfull!");
	 out.close();
	  }
	}

