package tea.applet.meeting;

import java.applet.Applet;
import java.applet.AppletContext;
import java.io.PrintStream;
import java.net.URL;
import java.util.StringTokenizer;
import tea.applet.Http;
import java.io.*;

public class CheckIn extends Applet
{

    public CheckIn()
    {
    }

    public void destroy()
    {
        _threadWait = null;
    }

    public void init()
    {
        System.out.println("正在初始化...");
        _threadWait = new Thread()
        {
            public void run()
            {
                int nAccepted = 0;
                while (_threadWait != null)
                {
                    String strCallerChatNo = null;
                    try
                    {
                        strCallerChatNo = Http.getString(new URL(getDocumentBase(), "/servlet/CheckIn"));
                        System.out.println("strCallerChatNo" + strCallerChatNo);
                        System.err.println(strCallerChatNo);
                    } catch (Exception e)
                    {
                        e.printStackTrace();
                    }
                    if (strCallerChatNo != null && strCallerChatNo.length() != 0) //如果有人呼叫,则
                    {
                        String strRedirectUrl = "/servlet/AnswerIn?";
                        StringTokenizer st = new StringTokenizer(strCallerChatNo, "\n");
                        if (st.hasMoreTokens())
                        {
                            strRedirectUrl += "Caller=" + st.nextToken();
                        }
                        if (st.hasMoreElements())
                        {
                            strRedirectUrl += "&InviteToChat=" + st.nextToken();
                        }
                        try
                        {
                            getAppletContext().showDocument(new URL(getDocumentBase(), strRedirectUrl), "_blank");
                        } catch (Exception e)
                        {}
                    }
                    try
                    {
                        //Thread.sleep(10000L);
                        Thread.sleep(5000L);
                        continue;
                    } catch (Exception e)
                    {}
                    break ;
                }
            }

        };
        _threadWait.start();
    }

    Thread _threadWait;
}
