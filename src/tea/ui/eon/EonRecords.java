package tea.ui.eon;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.net.*;
import java.math.*;
import tea.ui.*;
import tea.entity.member.*;
import tea.entity.eon.*;
import java.util.*;
import sun.net.ftp.*;
import sun.net.*;
import tea.entity.site.*;

public class EonRecords extends TeaServlet
{
    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
    }

    //Process the HTTP Get request
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        String act = request.getParameter("act");
        try
        {
            if (act != null)
            {
                TeaSession teasession = new TeaSession(request);
                CommunityOption co = CommunityOption.find(teasession._strCommunity);
                String eonip = co.get("eonip");
                String eonuser = co.get("eonuser");
                String eonpwd = co.get("eonpwd");
                String nu = teasession.getParameter("nexturl");
                if ("outbound".equals(act))
                {
                    EonNode en = EonNode.find(teasession._nNode);
                    if (en.isReg())
                    {
                        if (teasession._rv == null)
                        {
                            response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                            return;
                        }
                    }
                    EonRecord.refresh(teasession._strCommunity);
                    String member = teasession.getParameter("member"); //主叫
                    String me = null; //被叫
                    if (teasession._rv != null)
                    {
                        me = teasession._rv._strV;
                    }
                    String tel = teasession.getParameter("tel");
                    int processnum = Integer.parseInt(teasession.getParameter("processnum")); //0双方通话 1服务方自动语音服务 2提示用户留言 3提示服务方留言
                    Profile p2 = Profile.find(member);
                    EonTeleset et = EonTeleset.find(teasession._strCommunity, member);
                    int eonrecord = EonRecord.create(teasession._nNode, member, me, tel, en.isSide(), processnum);
                    String sn = request.getServerName();
                    StringBuilder par = new StringBuilder();
                    par.append("CallerId=").append(p2.getProfile());
                    par.append("&SessionId=").append(eonrecord);
                    par.append("&CallerNumber=").append(p2.getTelephone(teasession._nLanguage));
                    par.append("&ReceiveNumber=").append(tel);
                    par.append("&ToPay=").append(en.isSide() ? "1" : "0");
                    par.append("&Balance=").append(et.getBalance().divide(en.getPrice()).multiply(new BigDecimal(60)).intValue());
                    par.append("&ShowNumber=").append(et.isSecret() ? "1" : "0");
                    par.append("&ProcessNum=").append(processnum);
                    par.append("&URLAddress=").append("http://" + sn + ":" + request.getServerPort() + "/servlet/EonRecords"); //request.getServerName()
                    EonRecord.conn(eonip, "OutboundServlet", par.toString());
                    nu = nu + "&community=" + teasession._strCommunity + "&node=" + teasession._nNode + "&eonrecord=" + eonrecord;
                } else if ("result".equals(act)) //ajax拨打状态
                {
                    int eonrecord = Integer.parseInt(request.getParameter("eonrecord"));
                    EonRecord er = EonRecord.find(eonrecord);
                    PrintWriter out = response.getWriter();
                    out.print(er.getResult());
                    out.close();
                    return;
                } else
                {
                    if (teasession._rv == null)
                    {
                        response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                        return;
                    }
                    if ("down".equals(act))
                    {
                        int eonrecord = Integer.parseInt(request.getParameter("eonrecord"));
                        EonRecord er = EonRecord.find(eonrecord);
                        if (!teasession._rv.isOrganizer(teasession._strCommunity) && !teasession._rv._strV.equals(er.getMember()) && !teasession._rv._strV.equals(er.getCallMember()))
                        {
                            response.sendError(403);
                            return;
                        }
                        response.setHeader("Content-Disposition", "attachment; filename=" + new String("留言.vox".getBytes("GBK"), "ISO-8859-1"));
                        FtpClient ftp = new FtpClient(eonip);
                        ftp.login(eonuser, eonpwd);
                        ftp.binary();
                        OutputStream out = response.getOutputStream();
                        TelnetInputStream tis = ftp.get("/voicemail/" + eonrecord + ".vox");
                        int len;
                        byte by[] = new byte[8192];
                        while ((len = tis.read(by)) != -1)
                        {
                            out.write(by, 0, len);
                        }
                        tis.close();
                        out.close();
                        return;
                    }
                }
                response.sendRedirect(nu);
            } else
            {
                System.out.println("===返回===:" + request.getQueryString());
                int eonrecord = Integer.parseInt(request.getParameter("Sessionid"));
                int result = Integer.parseInt(request.getParameter("Result")); //0通，1无人接听,2线忙
                EonRecord er = EonRecord.find(eonrecord);
                er.setResult(result);
                System.out.println(eonrecord + ":" + result);
            }
        } catch (Exception ex)
        {
            ex.printStackTrace();
        }
    }


//Clean up resources
    public void destroy()
    {
    }
}
