package tea.ui.member.email;

import java.io.*;
import java.net.Socket;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.*;
import tea.entity.RV;
import tea.entity.member.EmailBox;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class DeleteEmails extends TeaServlet
{

    public DeleteEmails()
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            TeaSession teasession = new TeaSession(request);
            if (teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            String s = request.getParameter("EmailBox");
            EmailBox emailbox = EmailBox.find(Integer.parseInt(s));
            String s1 = emailbox.getPop3Server();
            String s2 = emailbox.getPop3User();
            String s3 = emailbox.getPop3Passwd();
            if (s1 != null && s1.length() != 0 && s2.length() != 0 && s3.length() != 0)
            {
                Socket socket = null;
                PrintWriter printwriter = null;
                BufferedReader bufferedreader = null;
                try
                {
                    socket = new Socket(s1, emailbox.getPop3Port());
                    socket.setSoTimeout(30000);
                    printwriter = new PrintWriter(socket.getOutputStream(), true);
                    bufferedreader = new BufferedReader(new InputStreamReader(socket.getInputStream()));
                    bufferedreader.readLine();
                    printwriter.println("USER " + s2);
                    bufferedreader.readLine();
                    printwriter.println("PASS " + s3);
                    bufferedreader.readLine();
                    String as[] = request.getParameterValues("Emails");
                    if (as != null)
                    {
                        for (int i = 0; i < as.length; i++)
                        {
                            printwriter.println("DELE " + as[i]);
                            bufferedreader.readLine();
                        }
                    }
                    printwriter.println("QUIT");
                    bufferedreader.readLine();
                    printwriter.close();
                    bufferedreader.close();
                    socket.close();
                } catch (Exception _ex)
                {} finally
                {
                    if (printwriter != null)
                    {
                        try
                        {
                            printwriter.close();
                        } catch (Exception _ex)
                        {}
                    }
                    if (bufferedreader != null)
                    {
                        try
                        {
                            bufferedreader.close();
                        } catch (Exception _ex)
                        {}
                    }
                    if (socket != null)
                    {
                        try
                        {
                            socket.close();
                        } catch (Exception _ex)
                        {}
                    }
                }
            }
            response.sendRedirect("/jsp/message/Emails.jsp?EmailBox=" + s);
        } catch (Exception exception)
        {
            response.sendError(400, exception.toString());
            exception.printStackTrace();
        }
    }
}
