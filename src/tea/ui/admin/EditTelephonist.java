package tea.ui.admin;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.TeaServlet;
import tea.entity.admin.*;
import tea.entity.member.Message;
import java.text.*;
import tea.entity.node.*;
import tea.entity.member.*;
import tea.entity.member.HttpRequester;
import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;

public class EditTelephonist extends TeaServlet
{

    //Initialize global variables
    public void init() throws ServletException
    {
    }

    //Process the HTTP Get request
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        tea.ui.TeaSession teasession = null;
        teasession = new tea.ui.TeaSession(request);
        try
        {
            String act = teasession.getParameter("act");
            String nexturl = teasession.getParameter("nexturl");
            String str = null;
            //  Destine destine_obj = Destine.find(destine);
            java.util.Date kipdate = Telephonist.sdf.parse(request.getParameter("kipDateFlag"));
            java.util.Date leavedate = Telephonist.sdf.parse(request.getParameter("leaveDateFlag"));
            Telephonist.sdf.parse(request.getParameter("leaveDateFlag"));
            if (kipdate.compareTo(new Date(System.currentTimeMillis())) < 0)
            {
                outText(teasession, response, "无效住店日期");
                return;
            }
            if (leavedate.compareTo(kipdate) < 0)
            {
                outText(teasession, response, "无效离开日期");
                return;
            }
            //   StringBuilder humanname = new StringBuilder();
//               String humanNames[] = request.getParameterValues("TxtName");
//               for (int i = 0; i < humanNames.length; i++)
//               {
//                   if (humanNames[i].length() > 0)
//                   {
//                       humanname.append(humanNames[i] + ",");
//                   }
//               }
            String humanname = teasession.getParameter("TxtName");
            int roomcount = Integer.parseInt(request.getParameter("roomcount"));
            String eveningarrive = request.getParameter("eveningarrive");
            String roomp = request.getParameter("roomp");
            if(roomp.equals("null")){
                roomp = "-1";
            }
            int roomprice = Integer.parseInt(roomp);
            //入住人信息humanname=='request.getParameter("TxtName")'
            boolean sex = new Boolean(request.getParameter("sex")).booleanValue();
            String handset = request.getParameter("handset");
            String phone = request.getParameter("phone");
            int paymenttype = Integer.parseInt(request.getParameter("paymenttype"));

            //联系人信息
            String linkmanname = request.getParameter("linkmanname");
            boolean linkmansex = new Boolean(request.getParameter("linkmansex")).booleanValue();
            String linkmanhandset = request.getParameter("linkmanhand");
            String linkmanphone = request.getParameter("linkmanph");
            String linkmanmail = request.getParameter("linkmanmail");
            String linkmanfax = request.getParameter("linkmanfax");
            int linkmanaffirm = Integer.parseInt(request.getParameter("linkmanaffirm"));
            //特殊要求
            String request_str = request.getParameter("otherrequest");
            int otheraddbed = Integer.parseInt(request.getParameter("otheraddbed"));
            //酒店说明
            boolean othersend = request.getParameter("othersend") != null; //我需要
            String otherpostalcode = request.getParameter("otherpostalcode");
            String address = request.getParameter("otheraddress");
            int state = 0;

            String memberid = teasession.getParameter("memberid");
            String newmember = teasession.getParameter("newmember");

            int xb = 1;
            if (true)
                xb = 0;


            if (newmember != null && newmember.length() > 0 && !"null".equals(newmember))
            {

                //  Profile.create(memberid,teasession._strCommunity,"1234","dd",0,null,0,null,null,1);
                if (Profile.isExisted(newmember))
                {
                    response.sendRedirect("/jsp/info/Succeed.jsp?info=" + java.net.URLEncoder.encode("用户名已经存在！", "UTF-8"));
                    return;
                }
                SynRegMethod srm = new SynRegMethod();
                if("".equals(linkmanmail)){
                    linkmanmail = "-1";
                }else{
                    linkmanmail = linkmanmail;
                }
                String sSex = teasession.getParameter("sex");
                boolean sce = true;
                if("true".equals(sSex)){
                	sce = true;
                }else{
                	sce = false;
                }
//                String sendXML = srm.writeXML("0", memberid, humanname, "1234", linkmanmail, handset, "0", "-1", sSex, "-1");
//                System.out.println("发送的注册XML：" + sendXML);
//                HttpRequester hreq = new HttpRequester(); //
//                Map param = new HashMap();
//                sendXML = java.net.URLEncoder.encode(sendXML, "gb2312");
//                param.put("request", sendXML);
//                HttpRespons hr = hreq.sendGet("http://222.35.63.147/golden%5Ftest/GoldenPort.asp", param, null);
//                String getXML = hr.getContent();
//
//                System.out.println("接收XML：" + getXML);
//                Document document = DocumentHelper.parseText(getXML);
//                Element root = document.getRootElement();
//                String result = root.element("Result").getText();
//
//                System.out.println("预定酒店注册会员的XML返回值：" + result);

                Profile.create(memberid, teasession._strCommunity, "1234", handset, sce, null, 0, humanname, linkmanmail, teasession._nLanguage, teasession._rv.toString());
            }
            int d = Destine.create(teasession._nNode, roomprice, roomcount, handset, phone, kipdate, leavedate, eveningarrive, paymenttype, linkmansex, linkmanhandset, linkmanphone, linkmanmail, linkmanfax, linkmanaffirm, othersend, otherpostalcode,
                                   otheraddbed, state, memberid, teasession._strCommunity, teasession._nLanguage, humanname.toString(), linkmanname, address, request_str, sex);
            Telephonist.create(d, teasession._rv.toString(), teasession._strCommunity);
response.sendRedirect("/jsp/type/hostel/DesSuc.jsp");
//            response.sendRedirect("/jsp/info/Succeed.jsp?info=" + java.net.URLEncoder.encode("预定成功", "UTF-8"));
            // response.sendRedirect("/jsp/info/Succeed.jsp?info="+ java.net.URLEncoder.encode(str,"UTF-8")+"&nexturl="+nexturl);
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

