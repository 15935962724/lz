package tea.ui.finance;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import tea.ui.*;
import tea.entity.*;
import tea.entity.finance.*;
import tea.entity.node.*;
import java.util.*;

public class EditMoney extends TeaServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");

        TeaSession teasession = new TeaSession(request);

         if(teasession._rv == null)
         {
             response.sendRedirect("/jsp/user/StartLogin.jsp?nexturl=" + request.getRequestURI());
         }

         String act = request.getParameter("act");
         String member = teasession._rv._strR;
         String nexturl = "";
        try
        {
            if(act.equals("kid"))
            {
                int sandz = Integer.parseInt(request.getParameter("sandz"));

                String kinds = request.getParameter("kinds");
                int icycle = 0;
                String cycle = request.getParameter("cycle");
                if(cycle != null)
                {
                    icycle = Integer.parseInt(cycle);
                }
                String ps = request.getParameter("ps");
                Kinds.create(member,kinds,sandz,icycle,ps);
                nexturl = "/jsp/finance/auxiliary/KindsManage.jsp";
            }else if(act.equals("uper")){
                int id = Integer.parseInt(request.getParameter("id"));
                String kname = request.getParameter("kinds");
                int sandz = Integer.parseInt(request.getParameter("sandz"));
                int icycle = 0;
                String cycle = request.getParameter("cycle");
                if(cycle != null)
                {
                    icycle = Integer.parseInt(cycle);
                }
                String ps = request.getParameter("ps");
                Kinds.update(id,kname,sandz,icycle,ps);

                nexturl = "/jsp/finance/auxiliary/KindsManage.jsp";
            }else if(act.equals("cremoney"))
            {
                int sandz = Integer.parseInt(request.getParameter("sandz"));
                int kids = 0;
                if(request.getParameter("kinds1")!=null&&request.getParameter("kinds1").length()>0){
                    kids = Integer.parseInt(request.getParameter("kinds1"));
                }
                if(request.getParameter("kinds2")!=null&&request.getParameter("kinds2").length()>0){
                    kids = Integer.parseInt(request.getParameter("kinds2"));
                }
                String money = request.getParameter("money");
                Date date = KindsMoney.sdf.parse(request.getParameter("date"));
                String ps = request.getParameter("ps");
                KindsMoney.create(member,kids,money,date,sandz,ps);

                nexturl = "/jsp/finance/auxiliary/MoneyManage.jsp";
            }else if(act.equals("upMoney"))
            {
                int id = Integer.parseInt(request.getParameter("id"));
                int sandz = Integer.parseInt(request.getParameter("sandz"));
               int kids = 0;
               if(request.getParameter("kinds1")!=null&&request.getParameter("kinds1").length()>0){
                   kids = Integer.parseInt(request.getParameter("kinds1"));
               }
               if(request.getParameter("kinds2")!=null&&request.getParameter("kinds2").length()>0){
                   kids = Integer.parseInt(request.getParameter("kinds2"));
               }
               String money = request.getParameter("money");
               Date date = KindsMoney.sdf.parse(request.getParameter("date"));
               String ps = request.getParameter("ps");
               KindsMoney.update(id,kids,money,date,sandz,ps);
                nexturl = "/jsp/finance/auxiliary/MoneyManage.jsp";
            }
            response.sendRedirect(nexturl);
        } catch(Exception ex)
        {
           ex.printStackTrace();
        }

    }
}



