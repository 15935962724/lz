package tea.applet;

import java.awt.Label;
import java.io.*;
import java.net.URL;
import java.net.URLConnection;
   
public class Http
{

    public static byte[] get(URL url)
    {
        return get(url, null);
    }

    public static byte[] get(URL url, Label lbStatus)
    {
        byte ab[] = null;
        try
        {
            URLConnection con = url.openConnection();
            con.setUseCaches(false);//忽略高速缓冲
            DataInputStream is = new DataInputStream(con.getInputStream());
            int nLength = con.getContentLength();
            if(nLength > 0)
            {
                ab = new byte[nLength];
                int nOff = 0;
                do
                {
                    int nLen = Math.min(2048, nLength - nOff);
                    is.readFully(ab, nOff, nLen);
                    nOff += nLen;
                    if(lbStatus != null)
                        lbStatus.setText(nOff + " / " + nLength);
                } while(nOff < nLength);
            }
            is.close();
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return ab;
    }

    public static String postGetString(URL url, String strPost)
    {
        String strRet = null;
        try
        {
            URLConnection con = url.openConnection();
            con.setUseCaches(false);
            con.setDoInput(true);
            con.setDoOutput(true);
            con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
            PrintWriter writer = new PrintWriter(con.getOutputStream());
            writer.print(strPost);
            writer.flush();
            writer.close();
            BufferedReader reader = new BufferedReader(new InputStreamReader(con.getInputStream()));
            strRet = reader.readLine();
            reader.close();
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return strRet;
    }

    public Http()
    {
    }

    public static String getString(URL url)
    {
        try
        {
            return new String(get(url));
        }
        catch(Exception e)
        {
            return null;
        }
    }

    public static boolean post(URL url, String strPost)
    {
        try
        {
            URLConnection con = url.openConnection();
            con.setUseCaches(false);
            con.setDoInput(true);
            con.setDoOutput(true);
            con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
            PrintWriter writer = new PrintWriter(con.getOutputStream());
            writer.print(strPost);
            writer.flush();
            writer.close();
            BufferedReader reader = new BufferedReader(new InputStreamReader(con.getInputStream()));
            reader.close();
        }
        catch(Exception e)
        {
            e.printStackTrace();
            return false;
        }
        return true;
    }
}
