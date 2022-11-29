package tea.entity.util;

import java.io.*;
import javax.imageio.*;
import java.awt.image.*;
import tea.entity.node.*;
import java.sql.SQLException;
import java.util.*;

public class Html2Pic
{
    //160,125
    public static boolean toPic(String url,File f)
    {
        Runtime r = Runtime.getRuntime();
        try
        {
            String cmd = (new StringBuilder()).append("\"").append("htm2bmp.dll\" \"").append(f.getPath()).append("\" \"").append(url).append("\" 5").toString();
            final Process p = r.exec(cmd);
            new Thread()
            {
                public void run()
                {
                    try
                    {
                        Thread.sleep(20000L);
                    } catch(InterruptedException ex)
                    {}
                    p.destroy();
                }
            }.start();
            p.waitFor();
            if(f.length() > 10L)
            {
                String name = f.getName().toUpperCase();
                if(!name.endsWith(".BMP"))
                {
                    if(f.length() == 21180)
                    {
                        f.delete();
                    } else
                    {
                        ImageIO.write(ImageIO.read(f),name.substring(name.length() - 3),f);
                    }
                }
                return true;
            }
        } catch(Exception ex)
        {
            ex.printStackTrace();
        }
        return false;
    }
}
