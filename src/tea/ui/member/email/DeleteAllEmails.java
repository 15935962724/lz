package tea.ui.member.email;

import java.io.*;
import java.net.Socket;
import java.util.StringTokenizer;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.*;
import tea.entity.RV;
import tea.entity.member.EmailBox;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class DeleteAllEmails extends TeaServlet
{

    public DeleteAllEmails()
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
            HttpSession httpsession = request.getSession(true);
            String s2 = (String) httpsession.getAttribute("tea." + teasession._rv._strR + "." + s + ".User");
            String s3 = (String) httpsession.getAttribute("tea." + teasession._rv._strR + "." + s + ".Passwd");
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
                    int i = -1;
                    printwriter.println("STAT");
                    String s4 = bufferedreader.readLine();
                    if (s4.charAt(0) == '+')
                    {
                        StringTokenizer stringtokenizer = new StringTokenizer(s4);
                        stringtokenizer.nextToken();
                        i = 0;
                        try
                        {
                            i = Integer.parseInt(stringtokenizer.nextToken());
                        } catch (Exception _ex)
                        {}
                    }
                    for (int j = 0; j < i; j++)
                    {
                        printwriter.println("DELE " + (j + 1));
                        bufferedreader.readLine();
                    }

                    printwriter.println("QUIT");
                    bufferedreader.readLine();
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
