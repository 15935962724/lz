package tea.ui.member.sms;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.entity.member.SMSMoney;
import tea.ui.TeaServlet;

public class EditSMSMoney extends TeaServlet
{
    private static final String CONTENT_TYPE = "text/html; charset=UTF-8";

    //Initialize global variables
    public void init() throws ServletException
    {
    }

    //Process the HTTP Get request
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            tea.ui.TeaSession teasession = new tea.ui.TeaSession(request);
            if (teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            String community = request.getParameter("community");
            boolean flag2 = teasession._rv.isOrganizer(community);
            boolean flag3 = teasession._rv.isWebMaster();
            if (!flag2 && !flag3)
            {
                response.sendError(403);
                return;
            }
            int smsmoney = Integer.parseInt(request.getParameter("smsmoney"));
            String member = request.getParameter("member");
            SMSMoney obj = SMSMoney.find(smsmoney);
            if (request.getParameter("delete") != null)
            {
                if (obj.getPayout() == 0)
                {
                    obj.delete();
                }
            } else
            {
                java.util.Date starttime = SMSMoney.sdf.parse(request.getParameter("starttimeYear") + "-" + request.getParameter("starttimeMonth") + "-" + request.getParameter("starttimeDay"));
                java.util.Date endtime = SMSMoney.sdf.parse(request.getParameter("endtimeYear") + "-" + request.getParameter("endtimeMonth") + "-" + request.getParameter("endtimeDay"));
                java.math.BigDecimal money = new java.math.BigDecimal(request.getParameter("money"));
                if (obj.isExists())
                {
                    if ((SMSMoney.SMS_PRICE.multiply(new java.math.BigDecimal(obj.getPayout()))).subtract(money).intValue() <= 0)
                    {
                        java.math.BigDecimal bd = obj.getMoney().subtract(money);
                        obj.set(member, community, starttime, endtime, money, obj.getSummoney().subtract(bd), obj.getPayout());
                    }
                } else
                {
                    obj.set(member, community, starttime, endtime, money, SMSMoney.getBalance(member, community).add(money), 0);
                }
                /*
                                 tea.entity.site.SMSEnterCode sec=                tea.entity.site.SMSEnterCode.find(community);
                                 java.net.URL url="http://sms.redcome.com/servlet/GetSubNumber?fincode="+sec.getCode()+"&";
                                 tea.entity.member.SMSProfile sp = tea.entity.member.SMSProfile.find(member);
                                 sp.set(sp.isStates(), sp.getSignature(teasession._nLanguage),sp.isAutor(),);
                 */
            }
            response.sendRedirect("/jsp/sms/EditSMSMoney.jsp?node=" + teasession._nNode + "&community=" + community + "&member=" + java.net.URLEncoder.encode(member,"UTF-8"));
        } catch (Exception e)
        {
            e.printStackTrace();
            throw new ServletException(e);
        }
    }

    //Clean up resources
    public void destroy()
    {
    }
}
