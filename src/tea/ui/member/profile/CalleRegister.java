package tea.ui.member.profile;

import tea.ui.TeaServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import tea.entity.member.Profile;
import tea.ui.TeaSession;
import java.io.UnsupportedEncodingException;
import java.io.IOException;
import tea.entity.member.HttpRequester;
import java.util.Map;
import tea.entity.member.HttpRespons;
import tea.entity.member.SynRegMethod;
import java.util.HashMap;
import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
public class CalleRegister  extends TeaServlet
{
 public void service(HttpServletRequest request,HttpServletResponse response) throws UnsupportedEncodingException, IOException
{
         request.setCharacterEncoding("UTF-8");
         TeaSession teasession = new TeaSession(request);
         String member = teasession.getParameter("member");
         String node = teasession.getParameter("Node");
         String password = teasession.getParameter("password");
         String firstname = teasession.getParameter("firstname");
         int sex_1 = Integer.parseInt(teasession.getParameter("sex"));
         String mobile = teasession.getParameter("mobile");
         String cardt = teasession.getParameter("cardtype");
         int cardtype = Integer.parseInt(cardt);
         String card = teasession.getParameter("card");
         String email = teasession.getParameter("Email");
         String caller = teasession._rv.toString();
         System.out.println("Register email is : "+email);
         try
         {
//             SynRegMethod srm = new SynRegMethod();
//            String sendXML = srm.writeXML("0" , member, firstname, password, email, mobile, cardt, card, teasession.getParameter("sex"), "-1");
//            System.out.println("发送的注册XML：" + sendXML);
//            HttpRequester hreq = new HttpRequester(); //
//            Map param = new HashMap();
//            sendXML = java.net.URLEncoder.encode(sendXML, "gb2312");
//            param.put("request", sendXML);
//            HttpRespons hr = hreq.sendGet("http://222.35.63.147/golden%5Ftest/GoldenPort.asp", param, null);
//            String getXML = hr.getContent();
//
//            System.out.println("接收XML："+ getXML);
//            Document document = DocumentHelper.parseText(getXML);
//            Element root = document.getRootElement();
//            String result = root.element("Result").getText();
//
//            System.out.println("话务员代注册的XML返回值：" + result);

           Profile.create(member, teasession._strCommunity, password,mobile, sex_1, card, cardtype, firstname , email, teasession._nLanguage, caller);
//           response.sendRedirect("/servlet/Node?Node="+node);
           response.sendRedirect("/jsp/registration/cregsuc.jsp");
           return;
         } catch (Exception ex)
         {
             System.out.print(ex.toString());
         }
 }
 public void init(ServletConfig servletconfig) throws ServletException
 {
     super.init(servletconfig);
 }
}
