package tea.ui.eon;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.math.*;
import java.net.*;
import tea.ui.*;
import java.sql.SQLException;
import tea.entity.member.*;
import tea.entity.eon.*;
import sun.net.ftp.FtpClient;
import sun.net.TelnetInputStream;

public class EditEonTeleset extends TeaServlet
{
    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
    }

    //Process the HTTP Get request
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        TeaSession teasession = new TeaSession(request);
        if (teasession._rv == null)
        {
            response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode + "&nexturl=" + java.net.URLEncoder.encode(request.getHeader("referer"), "UTF-8"));
            return;
        }
        String member = teasession._rv._strV;
        String act = teasession.getParameter("act");
        String nexturl = teasession.getParameter("nexturl");
        try
        {
            if ("edit".equals(act))
            {
                Profile p = Profile.find(member);
                String telephone = teasession.getParameter("telephone");
                String introduce = teasession.getParameter("introduce");
                String photopath; //= p.getPhotopath(teasession._nLanguage);
                byte by[] = teasession.getBytesParameter("photopath");
                if (by != null)
                {
                    photopath = write(teasession._strCommunity, by, ".gif");
                    p.setPhotopath(photopath, teasession._nLanguage);
                }
                p.setIntroduce(introduce, teasession._nLanguage);
                p.setTelephone(telephone, teasession._nLanguage);
                boolean secret = Boolean.parseBoolean(teasession.getParameter("secret"));
                boolean automessage = Boolean.parseBoolean(teasession.getParameter("automessage"));
                EonTeleset et = EonTeleset.find(teasession._strCommunity, member);
                et.set(secret, automessage);
            } else if ("delete".equals(act))
            {
                EonTeleset et = EonTeleset.find(teasession._strCommunity, member);
                et.delete();
            } else if ("addconsume".equals(act)) //用户缴费记录
            {
                BigDecimal money = new BigDecimal(teasession.getParameter("money"));
                EonTeleset et = EonTeleset.find(teasession._strCommunity, member);
                et.setBalance(money);
                EonConsume.create(member, money);
            } else if ("message".equals(act)) //用户留言管理
            {
                byte by[] = teasession.getBytesParameter("file");
                if (by != null)
                {
                    String name = teasession.getParameter("fileName");
                    int index = Integer.parseInt(teasession.getParameter("index"));

                    EonTeleset et = EonTeleset.find(teasession._strCommunity, member);
                    et.setMessage(index, name, by);
                }
            } else if ("delmessage".equals(act)) //用户留言管理
            {
                int index = Integer.parseInt(teasession.getParameter("index"));
                EonTeleset et = EonTeleset.find(teasession._strCommunity, member);
                et.setMessage(index, null, null);
            } else if ("downmessage".equals(act)) //用户留言管理
            {
                int index = Integer.parseInt(teasession.getParameter("index"));
                EonTeleset et = EonTeleset.find(teasession._strCommunity, member);
                String ms[] = et.getMessage();
                response.setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode(ms[index], "UTF-8"));
                FtpClient ftp = new FtpClient("eon.redcome.com");
                ftp.login("ednadmin", "redcome");
                ftp.binary();
                OutputStream out = response.getOutputStream();
                TelnetInputStream tis = ftp.get("/" + Profile.find(member).getProfile() + "/" + index + ".vox");
                int len;
                byte by[] = new byte[8192];
                while ((len = tis.read(by)) != -1)
                {
                    out.write(by, 0, len);
                }
                tis.close();
                out.close();
                return;
            } else if ("telmessage".equals(act)) //用户留言管理
            {

            }
        } catch (SQLException ex)
        {
            ex.printStackTrace();
        }
        response.sendRedirect("/jsp/info/Succeed.jsp?community=" + teasession._strCommunity + "&nexturl=" + URLEncoder.encode(nexturl, "UTF-8"));
    }

    //Clean up resources
    public void destroy()
    {
    }
}
