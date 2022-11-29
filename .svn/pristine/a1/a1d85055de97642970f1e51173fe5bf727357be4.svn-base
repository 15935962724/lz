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
import tea.db.DbAdapter;
import java.io.FilterInputStream;
import java.util.Map;
import java.util.HashMap;
import java.net.URL;
import java.io.FileOutputStream;

public class DownFiles extends HttpServlet
{

    public void init() throws ServletException
    {}

    public void service(HttpServletRequest request, HttpServletResponse response)
    {
        try
        {
            URL url = null;
            DbAdapter db = new DbAdapter();
            String client = "";
            String path = "";
            try
            {
                db.executeQuery("select clientname,downloadpath from updatepath");
                if (db.next())
                {
                    client = db.getString(1);
                    path = db.getString(2);
                }
            } catch (Exception e)
            {
                e.printStackTrace();
            }
            String local=request.getSession().getServletContext().getRealPath("/");
            HttpRequester hreq = new HttpRequester(); //
            Map param = new HashMap();
            param.put("client", client);
           // param.put("path", path);
            HttpRespons hr = hreq.sendGet(path+"/servlet/GetFileList", param, null);
            String filelist = hr.getContent();
            System.out.println(filelist);
            java.util.StringTokenizer st=new java.util.StringTokenizer(filelist,"/");
            while( st.hasMoreElements() ){ //返回是否还有分隔符。
                String filename = st.nextToken();
                filename=filename.trim();
               System.out.println(filename);
                url = new URL(path+"/"+client+"/"+filename);

                FilterInputStream in = (FilterInputStream) url.openStream();

                File fileOut = new File(local+"\\version\\"+filename);
                FileOutputStream out = new FileOutputStream(fileOut);
                byte[] bytes = new byte[1024];
                int c;
                while ((c = in.read(bytes)) != -1)
                {
                    out.write(bytes, 0, c);
                }
                in.close();
                out.close();
            }


      response.sendRedirect("/jsp/version/updatelist.jsp");
        PrintWriter out = response.getWriter();
        out.write("");
        out.close();
    } catch (Exception e)
        {
            e.printStackTrace();
            System.out.println("Error!");
        }

    }

   }

