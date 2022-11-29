package tea.ui.member.profile;

import tea.ui.TeaServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import tea.entity.member.Profile;
import tea.entity.member.*;
import tea.ui.TeaSession;
import javax.servlet.http.*;
import tea.entity.*;
import java.io.UnsupportedEncodingException;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import org.dom4j.*;
import com.sun.javaws.net.HttpResponse;
import java.util.HashMap;
import java.util.Map;

public class Registration extends TeaServlet
{
    public void service(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException, IOException
    {
        request.setCharacterEncoding("utf-8");
        TeaSession teasession = new TeaSession(request);
        String member = teasession.getParameter("member");
        String node = teasession.getParameter("Node");
        String password = teasession.getParameter("password");
        String firstname = teasession.getParameter("firstname");
        String mobile = teasession.getParameter("mobile");
        String card = teasession.getParameter("card");
        String email = teasession.getParameter("email");
        int sex = 1, cardtype = 5;
        if (teasession.getParameter("sex") != null)
        {
            sex = Integer.parseInt(teasession.getParameter("sex"));
        }
        if (teasession.getParameter("cardtype") != null)
        {
            cardtype = Integer.parseInt(teasession.getParameter("cardtype"));
        }
        try
        {
//                    SynRegMethod srm = new SynRegMethod();
//            String sendXML = srm.writeXML("0", member, firstname, password, email, mobile, teasession.getParameter("cardtype"), card, teasession.getParameter("sex"), "-1");
//            HttpRequester hreq = new HttpRequester();
//            Map param = new HashMap();
//            sendXML = java.net.URLEncoder.encode(sendXML, "gb2312");
//            param.put("request", sendXML);
//            HttpRespons hr = hreq.sendGet("对方接口", param, null);
//            String getXML = hr.getContent();
//            Document document = DocumentHelper.parseText(getXML);
//            Element root = document.getRootElement();
//            String result = root.element("Result").getText();
//            if ("0".equals(result))
//            {
                Profile.create(member, teasession._strCommunity, password, mobile, sex, card, cardtype, firstname, email, teasession._nLanguage, "");
                HttpSession session = request.getSession(true);
                Logs.create(teasession._strCommunity, new RV(member), 1, teasession._nNode, request.getRemoteAddr());
                OnlineList ol_obj = OnlineList.find(session.getId());
                session.setAttribute("tea.RV", new RV(member));
                session.setAttribute("LoginId", member);
                session.setAttribute("password", password);
                response.sendRedirect("/servlet/Node?node=" + node);
//response.sendRedirect("/jsp/profile/loginsuc.jsp");
                return;

//            } else
//            {
//                response.sendRedirect("/jsp/info/regnameused.jsp");
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
