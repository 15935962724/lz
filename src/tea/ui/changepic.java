package tea.ui;

import java.io.*;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.db.DbAdapter;

// Referenced classes of package tea.ui:
//            TeaServlet, TeaSession

public class changepic extends TeaServlet
{

    public changepic()
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            TeaSession teasession = new TeaSession(request);
            DbAdapter dbadapter = new DbAdapter();
            try
            {
                dbadapter.executeQuery("SELECT node, DATALENGTH(picture),picture  FROM NodeLayer where picture IS NOT NULL");
                FileOutputStream fileoutputstream;
                for (; dbadapter.next(); fileoutputstream.close())
                {
                    byte abyte0[] = dbadapter.getImage(2);
                    int i = dbadapter.getInt(1);
                    ByteArrayOutputStream bytearrayoutputstream = new ByteArrayOutputStream();
                    bytearrayoutputstream.write(abyte0);
                    String s = getServletContext().getRealPath("/tea/image/node/" + i + ".jpg");
                    System.out.println(s);
                    fileoutputstream = new FileOutputStream(s);
                    bytearrayoutputstream.writeTo(fileoutputstream);
                }

                PrintWriter printwriter = response.getWriter(); // beginOut(response, teasession);
                printwriter.println("<html><body>\u66F4\u65B0\u7CFB\u7EDF\u6210\u529F\uFF01\uFF01</body></html>");
                printwriter.close(); //printwriter.close();
            } catch (Exception exception1)
            {} finally
            {
                dbadapter.close();
            }
        } catch (Exception exception)
        {}
    }
}
