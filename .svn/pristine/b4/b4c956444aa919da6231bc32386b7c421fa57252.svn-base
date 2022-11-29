package tea.ui.member.profile;
import java.io.UnsupportedEncodingException;
import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.ServletException;
import javax.servlet.ServletConfig;
import javax.servlet.http.HttpServletResponse;
import tea.ui.TeaServlet;
import java.net.*;
import tea.entity.member.Profile;
import tea.ui.TeaSession;
import tea.entity.member.HttpRequester;
import java.util.Map;
import tea.entity.member.HttpRespons;
import tea.entity.member.SynRegMethod;
import java.util.HashMap;
import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import java.io.Writer;

public class hyedituser extends TeaServlet
{
    public void service(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException, IOException
    {
        System.out.println("hyedituser dao le ");
        request.setCharacterEncoding("UTF-8");
        TeaSession teasession = new TeaSession(request);
  String nexturl = teasession.getParameter("nexturl");

        //取得用户修改的各项信息资料
        int language = Integer.parseInt(teasession.getParameter("Language"));
        String member = teasession.getParameter("member");
        String community = teasession.getParameter("community");
        int sex = Integer.parseInt(teasession.getParameter("sex"));
        String card = teasession.getParameter("card");
        int cardtype = Integer.parseInt(teasession.getParameter("cardtype"));
        String firstname = teasession.getParameter("firstname");
        String mobile = teasession.getParameter("mobile");
        String email = teasession.getParameter("email");
        try
        {
//            //创建XML 并发送的远端服务器进行验证
//            SynRegMethod srm = new SynRegMethod();
//            String sendXML = srm.writeXML("1", member, firstname, "-1", email, mobile, teasession.getParameter("cardtype"), card, teasession.getParameter("sex"), "-1");
//            HttpRequester hreq = new HttpRequester(); //
//            Map param = new HashMap();
//            sendXML = java.net.URLEncoder.encode(sendXML, "gb2312");
//            param.put("request", sendXML);
//            HttpRespons hr = hreq.sendGet("http://222.35.63.147/golden%5Ftest/GoldenPort.asp", param, null);
//
//            //接收返回的RESULT结果 并进行相应的处理
//            String getXML = hr.getContent();
//            System.out.println("接收XML："+ getXML);
//            Document document = DocumentHelper.parseText(getXML);
//            Element root = document.getRootElement();
//            String result = root.element("Result").getText();

//            if ("0".equals(result))
//            {

                new Profile(member).update(member, community, sex, card, cardtype, firstname, mobile, email, language);

              response.sendRedirect("/jsp/registration/upisuc.jsp?member="+member);
//                response.sendRedirect("/jsp/registration/edituser.jsp?member=" + java.net.URLEncoder.encode(member, "UTF-8"));
//            }else{
//                //更新失败
//                System.out.println("更新失败");
//            }
        } catch (Exception ex)
        {
            System.out.println(ex.toString());
        }
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
    }
}
