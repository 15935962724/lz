package tea.ui.admin.map;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.*;
import tea.entity.admin.map.*;
import java.sql.*;
import tea.entity.util.ZoomOut;
import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;

public class EditMapReal extends TeaServlet
{


    //Initialize global variables
    public void init() throws ServletException
    {
    }

    //Process the HTTP Get request
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        TeaSession teasession = new TeaSession(request);
        String nexturl = teasession.getParameter("nexturl");
        String act = teasession.getParameter("act");
        ServletContext application = getServletContext();
        try
        {
            if("edit".equals(act))
            {
                String sid = null;
                int x = 0,y = 0;
                String pic0 = null;
                byte by[] = teasession.getBytesParameter("pic0");
                if(by != null)
                {
                    pic0 = super.write(teasession._strCommunity,"mapreal",by,".jpg");
                }

                String pic1 = null;
                by = teasession.getBytesParameter("pic1");
                if(by != null)
                {
                    pic1 = super.write(teasession._strCommunity,"mapreal",by,".jpg");
                }

                String pic2 = null;
                by = teasession.getBytesParameter("pic2");
                if(by != null)
                {
                    pic2 = super.write(teasession._strCommunity,"mapreal",by,".jpg");
                }

                String pic3 = null;
                by = teasession.getBytesParameter("pic3");
                if(by != null)
                {
                    pic3 = super.write(teasession._strCommunity,"mapreal",by,".jpg");
                }
                MapReal obj = MapReal.find(teasession._nNode);
                if(obj.isExists())
                {
                    obj.set(sid,x,y,pic0,pic1,pic2,pic3);
                } else
                {
                    MapReal.create(teasession._nNode,sid,x,y,pic0,pic1,pic2,pic3);
                }
            } else if("up".equals(act)) // 上传图片
            {
                int seq = Integer.parseInt(teasession.getParameter("seq"));
                String pic = teasession.getParameter("pic" + seq);
                System.out.println(pic);
                if(pic != null)
                {
                    File f = new File(application.getRealPath(pic));
                    BufferedImage bi = ImageIO.read(f);
                    f.delete();
                    ZoomOut zo = new ZoomOut();
                    bi = zo.imageZoomOut(bi,683,512);
                    File f2 = new File(application.getRealPath("/res/" + teasession._strCommunity + "/mapreal/" + teasession._nNode + "_" + seq + ".jpg"));
                    ImageIO.write(bi,"JPG",f2);
                }
            } else if("360".equals(act))
            {
                File f[] = new File[8];
                for(int i = 0;i < f.length;i++)
                {
                    f[i] = new File(application.getRealPath("/res/" + teasession._strCommunity + "/mapreal/" + teasession._nNode + "_" + i + ".jpg"));
                }
                Puzzles p = new Puzzles(f[0],f[1],f[2],f[3],f[4],f[5],f[6],f[7],null,null);
                BufferedImage bi = p.joint(); // zo.imageZoomOut(p.joint(),2048,1024);
                // 360////////
                File f360 = new File(application.getRealPath("/res/" + teasession._strCommunity + "/mapreal/" + teasession._nNode + ".jpg"));
                ImageIO.write(bi,"JPG",f360);
            }
        } catch(SQLException ex)
        {
            ex.printStackTrace();
        }
        response.sendRedirect(nexturl);
    }

    //Clean up resources
    public void destroy()
    {
    }
}
