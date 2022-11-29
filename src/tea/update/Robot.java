package tea.update;

import java.net.*;
import java.io.*;
import tea.db.*;
import java.sql.SQLException;

public class Robot
{
    public Robot()
    {
    }

    public static String open(int zip, int sort) throws IOException
    {
        URL u = new URL("http://alexa.ip138.com/post/Search.aspx?Front=1");
        HttpURLConnection conn = (HttpURLConnection) u.openConnection();
        conn.setConnectTimeout(10000);
        conn.setReadTimeout(10000);
        conn.setRequestProperty("Accept", "image/gif, image/x-xbitmap, image/jpeg, image/pjpeg, application/vnd.ms-excel, application/vnd.ms-powerpoint, application/msword, application/x-shockwave-flash, application/x-ms-application, application/x-ms-xbap, application/vnd.ms-xpsdocument, application/xaml+xml, */*");
        conn.setRequestProperty("Referer", "http://alexa.ip138.com/post/Search.aspx?Front=1");
        conn.setRequestProperty("User-Agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.2; SV1; .NET CLR 1.1.4322; .NET CLR 2.0.50727; .NET CLR 3.0.04506.648; .NET CLR 3.5.21022)");
        conn.setRequestProperty("Cookie", "ASP.NET_SessionId=s2kil0zkjxlbjw45cfek0p55");
        conn.setRequestMethod("POST");
        conn.setDoOutput(true);
        OutputStream os = conn.getOutputStream();
        os.write(("__VIEWSTATE=%2FwEPDwUKLTU1NTA4OTg3NQ9kFgICAw9kFgICAg88KwALAQAPFg4eC18hSXRlbUNvdW50AgoeCERhdGFLZXlzFgAeEEN1cnJlbnRQYWdlSW5kZXhmHglQYWdlQ291bnQCHh4VXyFEYXRhU291cmNlSXRlbUNvdW50AqUCHhBWaXJ0dWFsSXRlbUNvdW50AqUCHghQYWdlU2l6ZQIKZBYCZg9kFhQCAg9kFgJmD2QWAmYPFQYHMTMzNTY1NQnlsbHopb%2FnnIEJ5ZCV5qKB5biCCeS6pOWfjuWOvwnokrLmuKDmsrMGMDMwNTAwZAIDD2QWAmYPZBYCZg8VBgcxMzM1NjU0CeWxseilv%2BecgQnlkJXmooHluIIJ5Lqk5Z%2BO5Y6%2FCeWNl%2BmprOihlwYwMzA1MDBkAgQPZBYCZg9kFgJmDxUGBzEzMzU2NTMJ5bGx6KW%2F55yBCeWQleaigeW4ggnkuqTln47ljr8J57qi5peX6LevBjAzMDUwMGQCBQ9kFgJmD2QWAmYPFQYHMTMzNTY1MgnlsbHopb%2FnnIEJ5ZCV5qKB5biCCeS6pOWfjuWOvwnljJflhbPooZcGMDMwNTAwZAIGD2QWAmYPZBYCZg8VBgcxMzM1NjUxCeWxseilv%2BecgQnlkJXmooHluIIJ5Lqk5Z%2BO5Y6%2FCei3r%2BWNl%2BihlwYwMzA1MDBkAgcPZBYCZg9kFgJmDxUGBzEzMzU2NTAJ5bGx6KW%2F55yBCeWQleaigeW4ggnkuqTln47ljr8G6KW%2F56S%2BBjAzMDUwMGQCCA9kFgJmD2QWAmYPFQYHMTMzNTY0OQnlsbHopb%2FnnIEJ5ZCV5qKB5biCCeS6pOWfjuWOvwnluobljY7ooZcGMDMwNTAwZAIJD2QWAmYPZBYCZg8VBgcxMzM1NjQ4CeWxseilv%2BecgQnlkJXmooHluIIJ5Lqk5Z%2BO5Y6%2FCeWNtOazouihlwYwMzA1MDBkAgoPZBYCZg9kFgJmDxUGBzEzMzU2NDcJ5bGx6KW%2F55yBCeWQleaigeW4ggnkuqTln47ljr8M5Y2X546v6Lev6KW%2FBjAzMDUwMGQCCw9kFgJmD2QWAmYPFQYHMTMzNTY0NgnlsbHopb%2FnnIEJ5ZCV5qKB5biCCeS6pOWfjuWOvwzljZfnjq%2Fot6%2FkuJwGMDMwNTAwZGQgz7iHh%2F7a84DwK6ulU018mLblCQ%3D%3D&sort="
                  + sort + "&zip=" + zip).getBytes());
        os.close();
        byte by[] = new byte[1024 * 8];
        ByteArrayOutputStream ba = new ByteArrayOutputStream();
        InputStream is = conn.getInputStream();
        int v = 0;
        while ((v = is.read(by)) != -1)
        {
            ba.write(by, 0, v);
        }
        is.close();
        return new String(ba.toByteArray(), "GBK");
    }

    public static void parse(int zip, String str) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            String s[] = str.split("◎");
            for (int i = 1; i < s.length; i++)
            {
                int j = s[i].indexOf("</td>");
                s[i] = s[i].substring(0, j);
                db.executeUpdate("INSERT INTO ip138(zip,content)VALUES(" + zip + "," + db.cite(s[i]) + ")");
            }
        } finally
        {
            db.close();
        }
    }

   /* public static void main(String[] args) throws Exception
    {
        int min = 1000;
        if (args.length > 0)
        {
            min = Integer.parseInt(args[0]);
        }
        for (int i = min; i < 999999; i++)
        {
            System.out.println("邮编:" + i);
            for (int j = 0; true; j++)
            {
                try
                {
                    String h = open(i, j);
                    parse(i, h);
                    if (h.lastIndexOf(">下一页<") == -1)
                    {
                        break;
                    }
                } catch (IOException ex)
                {
                    System.out.println("sleep...");
                    Thread.sleep(1000L * 60 * 10);
                    j--;
                }
            }
        }
    }*/
}
