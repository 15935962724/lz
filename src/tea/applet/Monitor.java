package tea.applet;

import java.applet.Applet;
import java.applet.AppletContext;
import java.io.PrintStream;
import java.net.URL;
import java.util.StringTokenizer;
import tea.applet.Http;
import java.io.*;

public class Monitor extends Applet implements java.lang.Runnable
{
    static final String url[] =
            {"www.voguezone.com"};
    public java.awt.Graphics graphics = null;
    Thread thread = null;
    public Monitor()
    {
    }

    public void destroy()
    {
        System.out.println("destroy");
        this.stop();
    }

    public void start()
    {
        System.out.println("start");
        if (thread == null)
        {
            System.out.println("start....");
            thread = new Thread(this);
            thread.start();
        }
    }

    public void stop()
    {
        System.out.println("stop");
        if (thread != null && thread.isAlive())
        {
            System.out.println("stop...");
            thread.stop();
        }
        thread = null;
    }

    public void paint(java.awt.Graphics graphics)
    {
        System.out.println("paint");
        this.graphics = graphics;
        // this.start();
    }

    public void run()
    {
        while (thread != null)
        {
            System.out.println("run");
            String strCallerChatNo = null;
            try
            {
                for (int index = 0; index < url.length; index++)
                {
                    //strCallerChatNo = Http.getString(new URL(url[index]));
                    URL objurl=new URL(url[index]);
                    byte by[]=new byte[100];
                    objurl.openStream().read(by);
                    strCallerChatNo=new String(by);
                    if (graphics != null)
                    {
                        if (strCallerChatNo == null)
                        {
                            graphics.drawString("null", 0, index + 5);
                        } else
                        {
                            graphics.drawString(String.valueOf(strCallerChatNo.length()), 0, index + 5);
                        }
                    }
                }
            } catch (Exception e)
            {
                e.printStackTrace();
            }
            try
            {
                Thread.sleep(10000L);
                continue;
            } catch (Exception e)
            {}
            break ;
        }
    }

    public void init()
    {
        System.out.println("init...");
    }
}
