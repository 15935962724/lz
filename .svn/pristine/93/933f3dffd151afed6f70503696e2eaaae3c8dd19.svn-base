package tea.entity.util;

import tea.entity.*;
import java.net.*;
import java.io.*;
import java.util.regex.*;

public class DDoS extends Thread
{
    public void run()
    {
        try
        {
            Pattern CODE = Pattern.compile(" (\\d{3}) ");
            int test = 0;
            for(int i = 0;!isInterrupted();i++)
            {
                Socket s = null;
                String str = null;
                try
                {
                    Thread.sleep(3000);
                    if(test < 0)
                    {
                        test++;
                        continue;
                    }
                    s = new Socket("127.0.0.1",80);
                    byte[] by = "HEAD / HTTP/1.1\r\nHost: 127.0.0.1\r\nConnection: close\r\n\r\n".getBytes();
                    OutputStream os = s.getOutputStream();
                    os.write(by);
                    os.flush();

                    InputStream is = s.getInputStream();
                    is.read(by);
                    is.close();
                    str = new String(by);
                    Matcher m = CODE.matcher(str);
                    if(!m.find() || Integer.parseInt(m.group(1)) != 200)
                        throw new Exception();
                    System.out.println(i + "、" + str);
                    test = 0;
                } catch(InterruptedException ex)
                {
                    interrupt();
                } catch(Throwable ex)
                {
                    Filex.logs("DDoS.txt","\r\n  错误(" + test + ")：" + ex.getMessage() + "\r\n  返回：" + str);
                    if(++test < 3)
                        continue;
                    Filex.logs("DDoS.txt","重启服务");
                    File f = new File("./bin/startWebLogic.sh");
                    if(!f.exists())
                        f = new File("./bin/startup.sh");
                    OS.exec(f.getPath());
                    test = -40;
                }
                File f = new File("DDoS.txt");
                f.setLastModified(System.currentTimeMillis());
            }
        } catch(Throwable ex)
        {
            ex.printStackTrace();
        }
    }

    public static void main(String[] args) throws IOException
    {
        Filex.logs("DDoS.txt","START ");
        new DDoS().start();
    }
}
//TID=$(ps -ef|grep -v grep|grep AdminServer|awk '{print$2}')
//echo $TID
//kill -9 $TID

//java -cp webapps/ROOT/WEB-INF/classes:webapps/ROOT/WEB-INF/lib/entity_mt.jar tea.entity.util.DDoS
