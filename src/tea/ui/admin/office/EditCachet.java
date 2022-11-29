package tea.ui.admin.office;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.*;
import tea.entity.admin.office.*;
import tea.entity.admin.*;
import tea.entity.member.*;
import java.sql.*;
import javax.imageio.*;
import java.awt.image.*;
import java.awt.*;

public class EditCachet extends TeaServlet
{
    // Initialize global variables
    public void init() throws ServletException
    {
    }

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");

        TeaSession teasession = new TeaSession(request);
        if(teasession._rv == null)
        {
            response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode + "&nexturl=" + java.net.URLEncoder.encode(request.getRequestURI() + "?" + request.getQueryString(),"UTF-8"));
            return;
        }
        ServletContext application = this.getServletContext();
        String act = teasession.getParameter("act");
        String nexturl = teasession.getParameter("nexturl");
        try
        {
            if("view".equals(act))
            {
                String name = teasession.getParameter("name");
                String type = teasession.getParameter("type");
                response.setContentType("image/png");
                BufferedImage bi = draw(name,type);
                ImageIO.write(bi,"png",response.getOutputStream());
                return;
            } else if("edit".equals(act))
            {
                int cachet = Integer.parseInt(teasession.getParameter("cachet"));
                String name = teasession.getParameter("name");
                String type = teasession.getParameter("type");
                String password = request.getParameter("password");
                String picture = "/res/" + teasession._strCommunity + "/office/cachet_" + Long.toString(System.currentTimeMillis(),36) + ".png";
                File f = new File(application.getRealPath(picture));
                if(!f.getParentFile().exists())
                {
                    f.getParentFile().mkdirs();
                }
                ImageIO.write(draw(name,type),"png",f);
                if(type == null)
                {
                    type = "人名章";
                }
                if(cachet < 1)
                {
                    Cachet.create(teasession._strCommunity,name,type,password,false,picture);
                } else
                {
                    Cachet obj = Cachet.find(cachet);
                    obj.set(name,type,password,picture);
                }
            } else if("delete".equals(act))
            {
                int cachet = Integer.parseInt(request.getParameter("cachet"));
                Cachet obj = Cachet.find(cachet);
                obj.delete();
            } else if("move".equals(act))
            {
                int cachet = Integer.parseInt(request.getParameter("cachet"));
                boolean sequence = Boolean.parseBoolean(request.getParameter("sequence"));
                java.util.Enumeration e = Cachet.find(teasession._strCommunity,"",0,Integer.MAX_VALUE);
                for(int i = 3;e.hasMoreElements();i = i + 2)
                {
                    Cachet obj = Cachet.find(((Integer) e.nextElement()).intValue());
                    obj.setSequence(i);
                }
                Cachet obj = Cachet.find(cachet);
                obj.setSequence(obj.getSequence() + (sequence ? -3 : 3));
            } else if("role".equals(act))
            {
                String member = request.getParameter("member");
                String role = request.getParameter("role");
                String ms[] = member.split(";");
                for(int i = 0;i < ms.length;i++)
                {
                    Profile p = Profile.find(ms[i]);
                    if(p.getTime() != null)
                    {
                        AdminUsrRole aur = AdminUsrRole.find(teasession._strCommunity,ms[i]);
                        aur.setCachet(role);
                    }
                }
            } else //if ("control".equals(act))
            {
                int cachet = Integer.parseInt(request.getParameter("cachet"));
                String name = request.getParameter("name");
                String type = request.getParameter("type");
                String password = request.getParameter("password");
                String esp = teasession.getParameter("file");
                if(cachet < 1)
                {
                    Cachet.create(teasession._strCommunity,name,type,password,true,esp);
                } else
                {
                    Cachet obj = Cachet.find(cachet);
                    if(esp != null)
                    {
                        String old = obj.getPicture();
                        File f = new File(application.getRealPath(old));
                        f.delete();
                        if(new File(application.getRealPath(esp)).renameTo(f))
                        {
                            esp = old;
                        }
                    }
                    obj.set(name,type,password,esp);
                }
                if(esp != null) //控件提交//
                {
                    return;
                }
            }
        } catch(SQLException ex)
        {
            ex.printStackTrace();
        }
        response.sendRedirect(nexturl);
    }

    public BufferedImage draw(String name,String type)
    {
        BufferedImage bi;
        if(type != null && type.length() > 0)
        {
            int width = 150,height = 150;
            bi = new BufferedImage(width,height,BufferedImage.TYPE_4BYTE_ABGR);

            Graphics2D g = (Graphics2D) bi.getGraphics();

            // 抗锯齿,绘制质量等可参考RenderingHints类的文档！
            g.setRenderingHint(RenderingHints.KEY_TEXT_ANTIALIASING,RenderingHints.VALUE_TEXT_ANTIALIAS_ON);
            g.setColor(Color.RED);

            for(int i = 0;i < 3;i++)
            {
                g.drawOval(i,i,width - 1 - i - i,height - 1 - i - i);

                g.drawOval(0,i,width - 1 - i,height - 1 - i);
                g.drawOval(i,0,width - 1 - i,height - 1 - i);
                g.drawOval(i,i,width - 1 - i,height - 1 - i);
                g.drawOval(0,0,width - 1 - i,height - 1 - i);
            }
            int size = 50;
            g.setFont(new Font("宋体",Font.PLAIN,size));
            g.drawString("★",width / 2 - size / 2,height / 2 + size / 3); //

            g.setFont(new Font("宋体",Font.PLAIN,20));
            g.drawString(type,width / 4 + 8,height - height / 6);

            g.setFont(new Font("宋体",Font.PLAIN,20));

            float c = 225F / (name.length() - 1);
            for(int i = 0;i < name.length();i++)
            {
                String ch = String.valueOf(name.charAt(i));
                double r = Math.toRadians(i == 0 ? 247.5D : c);
                g.rotate(r,width / 2,height / 2);
                g.drawString(ch,width / 2 - 10,30);
            }
            g.dispose();
        } else
        {
            bi = new BufferedImage(50,50,BufferedImage.TYPE_4BYTE_ABGR);
            Graphics2D g = (Graphics2D) bi.getGraphics();
            g.setColor(Color.RED);

            g.drawRect(0,0,49,49);
            g.drawRect(1,1,47,47);
            g.drawRect(2,2,45,45);
            g.setFont(new Font("宋体",0,20));

            switch(name.length())
            {
            case 0:
                name = "无名式章";
                break;
            case 1:
                name = name + "　之章";
                break;
            case 2:
                name = name + "之章";
                break;
            case 3:
                name = name + "章";
                break;
            }
            g.drawString(String.valueOf(name.charAt(0)),5,44 / 2 - 2);
            g.drawString(String.valueOf(name.charAt(1)),5,44 - 2);
            g.drawString(String.valueOf(name.charAt(2)),44 / 2 + 2,44 / 2 - 2);
            g.drawString(String.valueOf(name.charAt(3)),44 / 2 + 2,44 - 2);
            g.dispose();
        }
        return bi;
    }

    // Clean up resources
    public void destroy()
    {
    }
}
