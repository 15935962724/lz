package tea.ui.admin;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.TeaServlet;
import tea.entity.admin.*;
import java.text.*;
import java.sql.SQLException;
import tea.entity.member.*;
import tea.ui.*;

public class EditBulletin extends TeaServlet
{

    // Initialize global variables
    public void init() throws ServletException
    {
    }

    // Process the HTTP Get request
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        TeaSession teasession = new TeaSession(request);
        try
        {
            int bulletin = Integer.parseInt(teasession.getParameter("bulletin"));
            String act = teasession.getParameter("act");
            if(act.endsWith("file"))
            {
                Bulletin obj = Bulletin.find(bulletin);
                if("addfile".equals(act)) //上传公告通知附件///
                {
                    byte by[] = teasession.getBytesParameter("file");
                    if(by != null)
                    {
                        String name = teasession.getParameter("fileName");
                        String path = write(teasession._strCommunity,"bulletin",by,name); //name.substring(name.lastIndexOf('.') + 1)
                        obj.addFile(path,name);
                    }
                } else
                if("delfile".equals(act)) //删除公告通知附件///
                {
                    int bullfile = Integer.parseInt(teasession.getParameter("bullfile"));
                    obj.delFile(bullfile);
                }
                response.sendRedirect("/jsp/admin/flow/NewBullfile.jsp?community=" + teasession._strCommunity + "&bulletin=" + bulletin);
                return;
            }

            //////////////////////////////////////////////////////////////////////////////////
            if("delete".equals(act))
            {
                Bulletin obj = Bulletin.find(bulletin);
                obj.delete();
            } else if("type".equals(act))
            {
                Bulletin obj = Bulletin.find(bulletin);
                int type = Integer.parseInt(teasession.getParameter("type"));
                obj.intovalue(type);
            } else
            {
                String tmember = teasession.getParameter("tmember"); //会员
                String tunit = teasession.getParameter("tunit"); //部门
                String caption = teasession.getParameter("caption"); //主题
                Date time_s = null,time_e = null;
                if(teasession.getParameter("time_s") != null && teasession.getParameter("time_s").length() > 0)
                {
                    time_s = Bulletin.sdf.parse(teasession.getParameter("time_s"));
                }
                if(teasession.getParameter("time_e") != null && teasession.getParameter("time_e").length() > 0)
                {
                    time_e = Bulletin.sdf.parse(teasession.getParameter("time_e"));
                }
                Date myDate = new Date();
                String d = java.text.DateFormat.getDateTimeInstance().format(myDate);
                Date times = Bulletin.sdf.parse(d);
                int type = 1;
                if(teasession.getParameter("time_s") != null && teasession.getParameter("time_s").length() > 0 && teasession.getParameter("time_e") != null && teasession.getParameter("time_e").length() > 0)
                {
                    if(time_s.compareTo(times) == -1 && time_e.compareTo(times) == 1)
                    {
                        type = 1;
                    }
                }
                String content = teasession.getParameter("content");
                Date issuetime = Bulletin.sdf.parse(request.getParameter("issuetimeYear") + "-" + request.getParameter("issuetimeMonth") + "-" + request.getParameter("issuetimeDay"));
                int naught = 0,naught2 = 0;
                if(bulletin > 0)
                {
                    Bulletin obj = Bulletin.find(bulletin);
                    obj.set(tmember,tunit,time_s,time_e,caption,content,issuetime,naught,naught2,type,0);
                } else
                {
                    int newid = Bulletin.create(teasession._strCommunity,teasession._rv._strR,tmember,tunit,time_s,time_e,caption,content,issuetime,naught,naught2,type,0);
                    Bulletin.find(bulletin).moveFile(newid); //移动附件
                    String message = teasession.getParameter("message");
                    if(message!=null && message.length()>0)
                    { 
                    	content = content+"<a href =/jsp/admin/flow/BulletinContent.jsp?community="+teasession._strCommunity+"&bulletin="+newid+" target=_blank>点击这里查看</a>";
                    	Message.create(teasession._strCommunity,0,teasession._rv._strR,tmember,"/",tunit,0,"/jsp/admin/flow/BulletinContent.jsp?bulletin=" + newid,teasession._nLanguage,caption,content);
                    }
                }
                String sms = teasession.getParameter("sms");
                if(sms != null)
                {
                    String smsmember = teasession.getParameter("smsmember"); //会员
                    String smsunit = teasession.getParameter("smsunit"); //部门
                    StringBuilder sb = new StringBuilder();
                    Enumeration e = AdminUsrRole.find(teasession._strCommunity,smsmember,"/",smsunit);
                    while(e.hasMoreElements())
                    {
                        String member = (String) e.nextElement();
                        Profile p = Profile.find(member);
                        String mob = p.getMobile();
                        if(sb.indexOf(mob) == -1)
                        {
                            sb.append(mob).append(",");
                        }
                    }
                    SMSMessage.create(teasession._strCommunity,teasession._rv._strR,sb.toString(),teasession._nLanguage,sms);
                }
            }
            response.sendRedirect("/jsp/admin/flow/Bulletin.jsp?community=" + teasession._strCommunity);
        } catch(Exception ex)
        { 
            ex.printStackTrace();
        }
    }

    // Clean up resources
    public void destroy()
    {
    }
}
