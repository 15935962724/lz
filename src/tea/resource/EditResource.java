package tea.resource;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;

public class EditResource extends HttpServlet
{
    private static final String CONTENT_TYPE = "text/html; charset=UTF-8";

    //Initialize global variables
    public void init() throws ServletException
    {
    }

    final static String TYPE[] =
            {"_en", "_zh_CN", "_ja_JP", "_ko_KR", "_fr", "_de", "_es", "_pt", "_it"};
    //Process the HTTP Get request
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
//java.util.Properties prop[]=new java.util.Properties[5];
//        prop[0]=new java.util.Properties();
        //request.setCharacterEncoding("gbk");
        String path = request.getParameter("path_path_path");
        String keys[] = request.getParameterValues("keys_keys_keys");
        for (int i = 0; i < TYPE.length; i++)
        {
            String value[] = request.getParameterValues(TYPE[i]);
            java.io.FileWriter fw = new java.io.FileWriter(path + TYPE[i] + ".properties");
            try
            {
                for (int index = 0; index < keys.length; index++)
                {
                    value[index] = value[index].trim();
                    if (value[index].length() > 0)
                    {
                        //if(i==3)
                        //    fw.write(keys[index] + "=" + new String(new String(value[index].getBytes("ISO-8859-1"), "utf-8").getBytes("EUC-KR")) + "\r\n");
                        //else
                        fw.write(keys[index] + "=" + new String(value[index].getBytes("ISO-8859-1"), "utf-8") + "\r\n");
                    }
//            prop[0].setProperty(keys[index], new String(_zh_CN[index].getBytes("ISO-8859-1"),"gbk"));
                }
            } catch (java.io.IOException ex)
            {
                throw ex;
            } finally
            {
                fw.close();
            }
        }
        response.sendRedirect("/jsp/util/Resources.jsp");
        /*        java.io.FileOutputStream fos=new java.io.FileOutputStream("d://bada.properties");
               // fos.write("и\u5218".getBytes());
//java.io.BufferedOutputStream bos=new java.io.BufferedOutputStream(fos);
                 java.io.OutputStreamWriter osw=new java.io.OutputStreamWriter(fos,"gbk");
             //   prop[0].store(osw,"aa");
                 fos.close();*/
    }

    //Clean up resources
    public void destroy()
    {
    }
}
