package tea.ui.bbs;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import java.net.*;
import tea.ui.*;
import tea.entity.*;
import tea.entity.site.*;
import java.util.regex.*;
import tea.entity.node.*;
import tea.entity.member.*;
import tea.entity.bbs.*;

public class BBSAttachs extends HttpServlet
{

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setHeader("Expires","0");
        request.setCharacterEncoding("UTF-8");
        TeaSession teasession = new TeaSession(request);
        String act = teasession.getParameter("act");
        try
        {
            if(teasession._rv == null)
            {
                write(response,"<script>window.open('/servlet/StartLogin?node=" + teasession._nNode + "&nexturl=" + java.net.URLEncoder.encode(request.getRequestURI() + "?" + request.getQueryString(),"UTF-8") + "','_parent');</script>");
            } else if("down".equals(act))
            {
                String member = teasession._rv._strR;
                int baid = Integer.parseInt(teasession.getParameter("bbsattach"));
                boolean ok = request.getParameter("ok") != null;
                BBSAttach ba = BBSAttach.find(baid);
                String dm = ba.getDMember();
                if(!new File(getServletContext().getRealPath(ba.getPath())).exists())
                {
                    write(response,"<script>alert('抱歉！该附件已丢失！');</script>");
                    return;
                }
                if(!member.equals(ba.getMember()) && dm.indexOf("/" + member + "/") == -1) //判断是否已下载过
                {
                    int bbsid = ba.getBbsid();
                    if(ba.isType())
                    {
                        bbsid = BBSReply.find(bbsid).getNode();
                    }
                    int bfid = Node.find(bbsid).getFather();
                    int down = BBSForum.find(bfid).getDown();
                    Profile p = Profile.find(member);
                    float point = p.getIntegral();
                    if(point < down)
                    {
                        write(response,"<script>alert('你的积分不足!\\n\\n需要积分: " + down + "\\n您的积分: " + point + "');</script>");
                        //response.sendRedirect("/jsp/info/Alert.jsp?community=" + teasession._strCommunity + "&info=" + java.net.URLEncoder.encode("你的积分不足!","utf-8"));
                        return;
                    } else if(!ok)
                    {
                        write(response,"<script>if(confirm(\"下载“" + ba.getName() + "”文件！需要扣除" + down + "积分！\\n\\n您确定要下载吗？\")){window.open('/servlet/BBSAttachs?act=down&bbsattach=" + baid + "&ok=1','_self'); var a=parent.$('integral');if(a)a.innerHTML=" + (point - down) + ";}</script>");
                        return;
                    }
                    ba.set(member);
                    //更新积分
                    BBSPoint bp = new BBSPoint(0);
                    bp.member = member;
                    bp.point = -down;
                    bp.node = bbsid;
                    bp.type = 8;
                    bp.set();
                }
                response.setContentType("application/x-msdownload");
                response.setHeader("Content-disposition","attachment; filename=" + java.net.URLEncoder.encode(ba.getName(),"UTF-8"));
                try
                {
                    getServletContext().getRequestDispatcher(ba.getPath()).forward(request,response);
                } catch(Exception e)
                {}
            }
        } catch(Exception ex)
        {
			ex.printStackTrace();
            response.sendError(500,ex.toString());
        }
    }

    void write(HttpServletResponse response,String str) throws IOException
    {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try
        {
            out.write(str);
        } finally
        {
            out.close();
        }
    }
}
