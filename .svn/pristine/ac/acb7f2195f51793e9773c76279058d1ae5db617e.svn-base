package tea.ui.ocean;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.*;
import tea.entity.*;
import tea.entity.member.*;
import java.math.BigDecimal;
import java.sql.SQLException;
import tea.entity.ocean.*;
import java.text.*;
import tea.entity.util.Spell;
import java.math.*;
import tea.db.*;
import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import tea.entity.util.ZoomOut;
import tea.entity.SeqTable;

public class EditLevyName extends TeaServlet
{
    public void init() throws ServletException
    {
    }

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=utf-8");
        tea.ui.TeaSession teasession = null;
        teasession = new tea.ui.TeaSession(request);
        ServletContext application = getServletContext();
        String act = teasession.getParameter("act");
        try
        {
            if("EditLevyname".equals(act))
            {
                int id = 0;
                if(teasession.getParameter("ids") != null && teasession.getParameter("ids").length() > 0)
                {
                    id = Integer.parseInt(teasession.getParameter("ids"));
                }
                String dolphin = teasession.getParameter("dolphin");
                String bigprincess = teasession.getParameter("bigprincess");
                String littleprincess = teasession.getParameter("littleprincess");
                String firstname = teasession.getParameter("firstname");
                int sex = 0;
                if(teasession.getParameter("sex") != null && teasession.getParameter("sex").length() > 0)
                {
                    sex = Integer.parseInt(teasession.getParameter("sex"));
                }
                String card = teasession.getParameter("card");
                String tel = teasession.getParameter("tel");
                String moral = teasession.getParameter("moral");
                Date date = new Date();
                LevyName.set(id,teasession._strCommunity,dolphin,bigprincess,littleprincess,firstname,sex,card,tel,0,date,"",date,moral);

                if(id == 0)
                {
                    java.io.PrintWriter out = response.getWriter();
                    out.println("<script>alert('提交成功！');	window.location.href='/servlet/Node?node=" + teasession._nNode + "';</script>");
                    out.flush();
                    out.close();
                } else
                {
                    java.io.PrintWriter out = response.getWriter();
                    out.println("<script>alert('提交成功！');	window.location.href='/jsp/ocean/EditLevyname.jsp?ids=" + id + "';</script>");
                    out.flush();
                    out.close();
                }

                return;

            } else if("EditLevyPicture".equals(act))
            {
                int id = 0;
                if(teasession.getParameter("ids") != null && teasession.getParameter("ids").length() > 0)
                {
                    id = Integer.parseInt(teasession.getParameter("ids"));
                }

                String firstname = teasession.getParameter("firstname");
                String tel = teasession.getParameter("tel");
                String card = teasession.getParameter("card");
                String address = "";

                int type = 0;
                if(teasession.getParameter("type") != null && teasession.getParameter("type").length() > 0)
                {
                    type = Integer.parseInt(teasession.getParameter("type"));
                }
                String member = "";
                member = teasession.getParameter("member");
                Date addtime = new Date();
                Date verifydate = new Date();
                ///////////////////
                String picpath = ""; //照片
                int seq = SeqTable.getSeqNo("EditLevyPicture");
                String strseq = "LevyPic" + seq;
                byte bypic[] = teasession.getBytesParameter("path");
                File fpic = new File(application.getRealPath("/res/" + teasession._strCommunity + "/LevyPic/" + strseq + ".jpg"));
                File fpicdir = fpic.getParentFile();
                picpath = "/res/" + teasession._strCommunity + "/LevyPic/" + strseq + ".jpg";

                LevyPicture obj = LevyPicture.find(id);
                if(obj.isExists())
                {
                    if(bypic != null)
                    {
                        picpath = "/res/" + teasession._strCommunity + "/LevyPic/" + strseq + ".jpg";
                    } else
                    {
                        picpath = obj.getPath();
                    }
                }

                if(!fpicdir.exists())
                {
                    fpicdir.mkdirs();
                }
                if(teasession.getParameter("clearpicture") != null)
                {
                    picpath = "";
                    fpic.delete();
                } else if(bypic != null)
                {
                    FileOutputStream fos = new FileOutputStream(fpic);
                    fos.write(bypic);
                    fos.close();
                } else if(bypic == null && id == 0)
                {
                    java.io.PrintWriter out = response.getWriter();
                    out.println("<script>alert('由于您是第一次上传作品，请上传您的作品！');	window.location.href='/servlet/Node?node=" + teasession._nNode + "';</script>");
                    out.flush();
                    out.close();
                    return;
                }
                if((fpic.length() / 1024) > 800 && id == 0)
                {
                    java.io.PrintWriter out = response.getWriter();
                    out.println("<script>alert('由于您是上传的作品大小不符合要求，请重新上传！');window.location.href='/servlet/Node?node=" + teasession._nNode + "';</script>");
                    out.flush();
                    out.close();
                    return;

                }
                LevyPicture.set(id,teasession._strCommunity,firstname,tel,card,address,picpath,type,member,addtime,verifydate);

                if(id == 0)
                {
                    java.io.PrintWriter out = response.getWriter();
                    out.println("<script>alert('提交成功！');window.location.href='/servlet/Node?node=" + teasession._nNode + "';</script>");
                    out.flush();
                    out.close();
                } else
                {
                    java.io.PrintWriter out = response.getWriter();
                    out.println("<script>alert('提交成功！');window.location.href='/jsp/ocean/EditLevyPicture.jsp?ids=" + id + "';</script>");
                    out.flush();
                    out.close();
                }

                return;

            }
        } catch(Exception ex)
        {
            ex.printStackTrace();
            System.out.print(ex.toString());
        }
    }

    public EditLevyName()
    {
    }

    public void destroy()
    {
    }
}
