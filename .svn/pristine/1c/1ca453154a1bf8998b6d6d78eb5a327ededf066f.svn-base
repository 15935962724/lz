package tea.ui.admin;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.net.URLEncoder;
import java.util.*;
import tea.ui.*;
import tea.entity.*;
import tea.entity.admin.*;
import tea.entity.admin.mov.*;
import javax.servlet.http.HttpSession;
import tea.entity.member.*;

public class EditPay extends TeaServlet
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
        if(teasession._rv == null)
        {
            response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
            return;
        }

        String act = teasession.getParameter("act");
        String nexturl = request.getParameter("nexturl");

        try
        {
            int pay = 0;
            if(teasession.getParameter("pay") != null && teasession.getParameter("pay").length() > 0)
            {
                pay = Integer.parseInt(teasession.getParameter("pay"));
            }
            int paytype = 0;
            if(teasession.getParameter("paytype") != null && teasession.getParameter("paytype").length() > 0)
            {
                paytype = Integer.parseInt(teasession.getParameter("paytype"));
            }
            int payid = 0;
            if(teasession.getParameter("payid") != null && teasession.getParameter("payid").length() > 0)
            {
                payid = Integer.parseInt(teasession.getParameter("payid"));
            }
            String usename="/";
            if(teasession.getParameter("usename")!=null && teasession.getParameter("usename").length()>0)
            {
            	String un [] = teasession.getParameterValues("usename");
            	for(int i = 0;i<un.length;i++)
            	{
            		usename =usename + un[i]+"/";
            	}
            }

            if("EditPay".equals(act))
            {
                String payname = teasession.getParameter("payname");
                String merchant = teasession.getParameter("merchant");
                String safety = teasession.getParameter("safety");
                String payeail = teasession.getParameter("payeail");
                String paycontent = teasession.getParameter("paycontent");
                String payurl = teasession.getParameter("payurl");
                String processurl=teasession.getParameter("processurl");
                String returnurl=teasession.getParameter("returnurl");
                //线上
                if(paytype == 1)
                {
                    Payinstall piobj = Payinstall.findpay(pay);
                    if(Payinstall.isPay(pay))
                    {
                        piobj.set(pay,null,paytype,merchant,safety,payeail,paycontent,teasession._strCommunity,payurl,processurl,returnurl,usename);
                    } else
                    {
                        Payinstall.create(pay,null,1,merchant,safety,payeail,paycontent,teasession._strCommunity,0,payurl,processurl,returnurl,usename);
                    }

                } else if(paytype == 2) //线下
                {

                    Payinstall piobj = Payinstall.find(payid);
                    if(payid > 0)
                    {
                        piobj.set(payname,paycontent,teasession._strCommunity,paytype,usename);
                    } else
                    {
                        Payinstall.create(payname,paycontent,teasession._strCommunity,paytype,0,usename);
                    }
                }
            } else if("delete".equals(act))
            {
                Payinstall piobj = Payinstall.find(payid);
                piobj.delete();
            } else if("use".equals(act))
            {
                if(paytype == 1)
                {
                    Payinstall piobj = Payinstall.findpay(pay);
                    int us=0;
                    if(piobj.getUsetype()==0)
                    {
                        us=1;
                    }
                    piobj.set(us,"pay",pay);
                }else if(paytype==2)
                {
                    Payinstall piobj = Payinstall.find(payid);
                    int us=0;
                    if(piobj.getUsetype()==0)
                    {
                        us=1;
                    }
                    piobj.set(us,"payid",payid);
                }
                response.sendRedirect(nexturl);
                return;
            }

            response.sendRedirect("/jsp/info/Succeed.jsp?nexturl=" + URLEncoder.encode(nexturl,"UTF-8"));
            return;

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

