package tea.ui.cio;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import java.text.*;
import tea.ui.*;
import tea.entity.*;
import tea.entity.member.*;
import tea.entity.cio.*;
import tea.entity.site.*;
import jxl.*;
import jxl.write.*;

public class EditCioInviteCode extends TeaServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        TeaSession teasession = new TeaSession(request);
        if(teasession._rv == null)
        {
            response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode + "&nexturl=" + java.net.URLEncoder.encode(request.getRequestURI() + "?" + request.getQueryString(),"UTF-8"));
            return;
        }
        String act = teasession.getParameter("act");
        String nu = teasession.getParameter("nexturl");
        try
        {
            if(act.equals("create"))
            {
                CioInviteCode.create(teasession._strCommunity,100);
            } else if(act.equals("delete"))
            {
                String code = teasession.getParameter("code");
                CioInviteCode cc = CioInviteCode.find(code);
                cc.delete();
            } else if(act.equals("import"))
            {
                response.setHeader("Content-Disposition","attachment; filename=" + new String("Excel.xls".getBytes("GBK"),"ISO-8859-1"));
                OutputStream out = response.getOutputStream();
                WritableWorkbook ww = Workbook.createWorkbook(out);
                WritableSheet ws = ww.createSheet("cio",0);
                ws.addCell(new Label(0,0,"邀请码"));
                ws.addCell(new Label(1,0,"状态"));
                ws.addCell(new Label(2,0,"使用者"));
                ws.addCell(new Label(3,0,"IP地址"));
                Enumeration e = CioInviteCode.find(teasession._strCommunity,"",0,Integer.MAX_VALUE);
                for(int i = 1;e.hasMoreElements();i++)
                {
                    CioInviteCode cic = (CioInviteCode) e.nextElement();
                    String member = cic.getMember();
                    ws.addCell(new Label(0,i,cic.getCode()));
                    ws.addCell(new Label(1,i,(member == null ? "未使用" : "已使用")));
                    ws.addCell(new Label(2,i,member));
                    ws.addCell(new Label(3,i,cic.getIp()));
                }
                ww.write();
                ww.close();
                out.close();
                return;
            }
        } catch(Exception ex)
        {
            ex.printStackTrace();
        }
        response.sendRedirect(nu);
    }
}
