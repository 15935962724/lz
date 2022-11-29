package tea.ui.admin.erp.icard;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.net.URLEncoder;
import java.text.*;
import java.util.*;
import java.math.*;
import tea.ui.*;
import tea.entity.admin.erp.*;
import jxl.*;
import jxl.write.*;
import tea.db.*;
import tea.entity.member.*;
import tea.entity.admin.erp.icard.*;

public class EditICard extends TeaServlet
{

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        TeaSession teasession = new TeaSession(request);
        if(teasession._rv == null)
        {
            response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
            return;
        }
        String act = teasession.getParameter("act");
        String nexturl = teasession.getParameter("nexturl");
        try
        {
            if("edit".equals(act))
            {
                int icardtype = Integer.parseInt(request.getParameter("icardtype"));
                String prefix = teasession.getParameter("prefix");
                String password = teasession.getParameter("password");
                int median = Integer.parseInt(request.getParameter("median"));
                int start = Integer.parseInt(request.getParameter("start"));
                int end = Integer.parseInt(request.getParameter("end"));
                String tmp = request.getParameter("money");
                BigDecimal money = BigDecimal.ZERO;
                if(tmp.length() > 0)
                {
                    money = new BigDecimal(tmp);
                }
                Date invalid = ICard.sdf.parse(request.getParameter("invalidYear") + "-" + request.getParameter("invalidMonth") + "-" + request.getParameter("invalidDay"));
                boolean filter = request.getParameter("filter") != null;
                int j = BatICard.create(icardtype,prefix,median,start,end,password,money,invalid,filter);
                nexturl = "/jsp/info/Succeed.jsp?community=" + teasession._strCommunity + "&info=" + java.net.URLEncoder.encode("共发行了" + j + "张卡.","UTF-8") + "&nexturl=" + java.net.URLEncoder.encode(nexturl,"UTF-8");
            } else if("del".equals(act))
            {
                int baticard = Integer.parseInt(request.getParameter("baticard"));
                BatICard bic = BatICard.find(baticard);
                bic.delete();
            } else if("exp".equals(act))
            {
                response.setContentType("application/octet-stream");
                response.setHeader("Content-Disposition","attachment; filename=exp.xls");
                StringBuilder sb = new StringBuilder();
                sb.append(" AND baticard IN(");
                StringBuilder t = new StringBuilder();
                t.append(" AND time IN(");
                String bics[] = request.getParameterValues("baticards");
                for(int i = 0;i < bics.length;i++)
                {
                    sb.append(bics[i]).append(",");
                    t.append(DbAdapter.cite(BatICard.find(Integer.parseInt(bics[i])).getTime())).append(",");
                }
                sb.append("0)");
                t.append("0)");
                WritableWorkbook ww = Workbook.createWorkbook(response.getOutputStream());
                Enumeration e = BatICard.findICardType(teasession._strCommunity,sb.toString());
                for(int i = 0;e.hasMoreElements();i++)
                {
                    int ictid = ((Integer) e.nextElement()).intValue();
                    WritableSheet ws = ww.createSheet(ICardType.find(ictid).getName(),i);
                    ws.setColumnView(0,20);
                    Enumeration e2 = ICard.find(teasession._strCommunity," AND icardtype=" + ictid + t.toString(),0,Integer.MAX_VALUE);
                    for(int r = 0;e2.hasMoreElements();r++)
                    {
                        String icid = (String) e2.nextElement();
                        ICard ic = ICard.find(icid);
                        ws.addCell(new Label(0,r,ic.getICard()));
                    }
                }
                ww.write();
                ww.close();
                return;
            }
            response.sendRedirect(nexturl);
        } catch(Exception ex)
        {
            ex.printStackTrace();
        }
    }
}
