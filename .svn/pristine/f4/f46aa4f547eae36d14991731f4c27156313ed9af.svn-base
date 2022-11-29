package tea.ui.util;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import javax.imageio.*;
import java.awt.image.*;
import java.awt.*;
import tea.entity.*;
import com.swetake.util.Qrcode;

public class QRCodes extends HttpServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        Http h = new Http(request,response);
        response.setHeader("Cache-Control","max-age=" + Integer.MAX_VALUE);

        String content = h.get("content");
        if(content == null || content.length() == 0)
        {
            response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("参数:");
            out.println("<br>　　content: 内容 (必须)");
            out.println("<br>　　size: 大小");
            out.println("<br>　　ver:  版本:1-40");
            out.println("<br>　　err:  纠错级别:L-7%低,M-15%中,Q-25%高,H-30%最高");
            out.println("<br>　　mode:  编码模式:N-数字 A-英文字母(数字+大写字母+部分符号) B-二进制 K-汉字");
            out.println("<br>　　color: 颜色");
            out.close();
            return;
        }
        int size = h.getInt("size",100);
        int ver = h.getInt("ver");
        char err = h.get("err","L").charAt(0);
        char mode = h.get("mode","B").charAt(0);
        String color = h.get("color","000000");
        //加解密
        String xor = h.get("xor");
        if(xor != null)
        {
            char[] KEY = xor.toCharArray();
            char ac[] = content.toCharArray();
            StringBuilder sb = new StringBuilder(ac.length);
            for(int i = 0;i < ac.length;i++)
            {
                sb.append((char) (ac[i] ^ KEY[i % KEY.length]));
            }
            content = sb.toString();
        }
        String enc = h.get("enc");
        if(enc != null)
        {
            content = Enc.enc(content.getBytes("UTF-8")).toUpperCase();
        }
        byte[] d = content.getBytes("UTF-8");
        // /////以上是参数/////////////////////////////////////////
        Qrcode x = new Qrcode();
        x.setQrcodeErrorCorrect(err); //默认:M
        x.setQrcodeEncodeMode(mode); //默认:B
        x.setQrcodeVersion(ver); //默认:0

        boolean[][] s = x.calQrcode(d);
        int b = 1;
        if(size < s.length)
        {
            size = s.length;
        } else
        {
            b = size / s.length;
            if(size % s.length != 0)
            {
                size = s.length * b;
            }
        }
        BufferedImage image = new BufferedImage(size,size,BufferedImage.TYPE_INT_ARGB);
        Graphics g = image.getGraphics();
        //g.setColor(Color.WHITE);
        //g.fillRect(0,0,size,size);
        //g.setColor(Color.BLACK);
        g.setColor(new Color(Integer.parseInt(color.substring(0,2),16),Integer.parseInt(color.substring(2,4),16),Integer.parseInt(color.substring(4,6),16)));
        int sum = 0;
        for(int i = 0;i < s.length;i++)
        {
            for(int j = 0;j < s.length;j++)
            {
                if(s[j][i])
                {
                    sum++;
                    g.fillRect(j * b,i * b,b,b);
                }
            }
        }
        g.dispose();
        //
        response.setContentType("image/png");
        OutputStream out = response.getOutputStream();
        ImageIO.write(image,"PNG",out);
        out.close();
    }

    public static String xor(String str)
    {
        byte[] by = new byte[str.length() / 2];
        for(int i = 0;i < by.length;i++)
        {
            int j = i * 2;
            by[i] = (byte) Integer.parseInt(String.valueOf(str.charAt(j)) + str.charAt(j + 1),16);
        }
        try
        {
            str = new String(by,"UTF-8");
        } catch(UnsupportedEncodingException ex)
        {}
        //
        char[] KEY = "58607710".toCharArray();
        char ac[] = str.toCharArray();
        StringBuilder sb = new StringBuilder(ac.length);
        for(int i = 0;i < ac.length;i++)
        {
            sb.append((char) (ac[i] ^ KEY[i % KEY.length]));
        }
        return sb.toString();
    }
}
