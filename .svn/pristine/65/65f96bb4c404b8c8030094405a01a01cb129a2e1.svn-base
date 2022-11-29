package tea.ui.node.type.hostel;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.entity.node.*;
import tea.ui.*;
import java.net.*;
public class AuditDestine_hy extends TeaServlet
{
    public void init(ServletConfig servletconfig) throws ServletException
   {
       super.init(servletconfig);
   }

   //Process the HTTP Get request
   public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
   {
       try
       {
               request.setCharacterEncoding("UTF-8");
               TeaSession teasession = new  TeaSession(request);
               String member = teasession.getParameter("member");
               String humanname = teasession.getParameter("TxtName");
               System.out.print("ruzhuren :"+humanname);
               int destine = Integer.parseInt(teasession.getParameter("destine"));
               int roomcount = Integer.parseInt(teasession.getParameter("roomcount"));
               String eveningarrive = teasession.getParameter("eveningarrive");
               int roomprice = Integer.parseInt(teasession.getParameter("roomprice"));
               //入住人信息humanname=='request.getParameter("TxtName")'
               boolean sex =new Boolean( teasession.getParameter("sex")).booleanValue();
               java.util.Date kipdate = Destine.sdf.parse(teasession.getParameter("kipDateFlag"));
               java.util.Date leavedate = Destine.sdf.parse(teasession.getParameter("leaveDateFlag"));
               String handset = teasession.getParameter("handset");
               String phone = teasession.getParameter("phone");

               int paymenttype = Integer.parseInt(teasession.getParameter("paymenttype"));
               //联系人信息
               String linkmanname = teasession.getParameter("linkmanname");
               boolean linkmansex = new Boolean(teasession.getParameter("linkmansex")).booleanValue();
               String linkmanhandset = teasession.getParameter("linkmanhandset");
               String linkmanphone = teasession.getParameter("linkmanphone");
               String linkmanmail = teasession.getParameter("linkmanmail");
               String linkmanfax = teasession.getParameter("linkmanfax");
               String nexturl = teasession.getParameter("nexturl");
               int linkmanaffirm = Integer.parseInt(teasession.getParameter("linkmanaffirm"));
               //特殊要求
               String request_str = teasession.getParameter("otherrequest");
               int otheraddbed = Integer.parseInt(teasession.getParameter("otheraddbed"));
               //酒店说明
               boolean othersend = false;
               if(teasession.getParameter("othersend")!=null)
               {
                   othersend = true;
               }
               othersend = teasession.getParameter("othersend") != null;//我需要
               String otherpostalcode = teasession.getParameter("otherpostalcode");
               String address = teasession.getParameter("otheraddress");
               Destine obj = Destine.find(destine);
               obj.set(roomprice, roomcount, handset, phone, kipdate, leavedate,eveningarrive,  paymenttype, linkmansex, linkmanhandset, linkmanphone, linkmanmail, linkmanfax, linkmanaffirm, othersend, otherpostalcode, otheraddbed, obj.getState(), member,teasession._nLanguage, humanname.toString(), linkmanname, address, request_str,obj.getDstate(),sex);
               //String nu = "/jsp/registration/myorders.jsp?member="+URLEncoder.encode(member,"UTF-8")+"&destine="+destine;
               response.sendRedirect(nexturl);
       } catch (Exception ex)
       {
           ex.printStackTrace();
       }
   }
}
