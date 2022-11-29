package tea.ui.util;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.MessageFormat;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.RV;
import tea.entity.member.*;
import tea.entity.node.Node;
import tea.entity.site.*;
import tea.html.Anchor;
import tea.html.Text;
import tea.http.RequestHelper;
import tea.resource.Resource;
import tea.service.Robot;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;
public class SignUp2 extends TeaServlet
{
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        try
        {
            TeaSession teasession = new TeaSession(request);
            String s = request.getParameter("NextUrl");
            String s1 = request.getParameter("MemberId").trim();
            String s2 = request.getParameter("Password").trim();
            String s3 = request.getParameter("FirstName").trim();
            String s4 = request.getParameter("LastName").trim();
            String s5 = request.getParameter("Email").trim();
            String s6 = request.getParameter("Organization");
            String s7 = request.getParameter("Address");
            String s8 = request.getParameter("City");
            String s9 = request.getParameter("State");
            String s10 = request.getParameter("Zip");
            String s11 = request.getParameter("Country");
            String s12 = request.getParameter("Telephone");
            String s13 = request.getParameter("Fax");
            int i = 6;
            // int i = Integer.parseInt(request.getParameter("Age"));
            String s14 = request.getParameter("WebPage");
            int j = request.getParameter("AddressTPublic") != null ? 1 : 0;
            if (!RequestHelper.isIdentifier(s1))
            {
                outText(teasession, response, super.r.getString(teasession._nLanguage, "InvalidMemberId"));
                return;
            }
            if (!RequestHelper.isIdentifier(s2))
            {
                outText(teasession, response, super.r.getString(teasession._nLanguage, "InvalidPassword"));
                return;
            }
            if (!RequestHelper.isEmail(s5))
            {
                outText(teasession, response, super.r.getString(teasession._nLanguage, "InvalidEmail"));
                return;
            }
            if (s3.length() == 0)
            {
                outText(teasession, response, super.r.getString(teasession._nLanguage, "InvalidFirstName"));
                return;
            }
            if (s4.length() == 0)
            {
                outText(teasession, response, super.r.getString(teasession._nLanguage, "InvalidLastName"));
                return;
            }
            if (Profile.isExisted(s1))
            {
                outText(teasession, response, RequestHelper.format(super.r.getString(teasession._nLanguage, "MemberIdExisted"), s1));
                return;
            }
            RV rv = new RV(s1);
            Profile.create(s1, s2, i, j, teasession._nLanguage, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14);
            Notification.create(rv);
          //EmailBox.create(teasession._strCommunity,s1, s5, s5.substring(s5.indexOf('@') + 1), 110, s5.substring(0, s5.indexOf('@')), "", 0);
            //Logs.create(teasession._strCommunity,new RV(s1, s1), 0,  request.getRemoteAddr());
            String s15 = request.getServerName();
            String s16 = s3;
            String s17 = s4;
            try
            {
                byte abyte0[] = s3.getBytes("ISO-8859-1");
                byte abyte1[] = s4.getBytes("ISO-8859-1");
                s16 = new String(abyte0);
                s17 = new String(abyte1);
            } catch (Exception exception1)
            {}
            String s18;
            if (teasession._nLanguage == 1 || teasession._nLanguage == 2)
            {
                s18 = s17 + s16;
            } else
            {
                s18 = s17 + ", " + s16;
            }
            Object as[] =
                    {
                    Integer.toString(Profile.getMax()), s1, s5, s18, (new Anchor("http://" + s15, new Text(s15))).toString(), (new Anchor("http://" + s15 + "/servlet/CancelMembership?Member=" + s1, new Text(super.r.getString(teasession._nLanguage, "Cancel")))).toString()
            };
            String s19 = MessageFormat.format(super.r.getString(teasession._nLanguage, "SignUpNotification"), as);
            String s20 = License.getInstance().getWebMaster();
            String s21 = super.r.getString(teasession._nLanguage, "SignUpConfirmation");
            int k = Message.create(teasession._strCommunity,s20,rv._strR, teasession._nLanguage, s21, s19);
//            try
//            {
//                Robot.activateRobot(k);
//            } catch (Exception exception3)
//            {}
            //Logs.create(rv,teasession._strCommunity, 1, request.getRemoteHost() + " / " + request.getRemoteAddr());
            Node node = Node.find(teasession._nNode);
            String s24 = node.getCommunity();
            Community community = Community.find(s24);
            if (community.getType() == 1)
            {
                Subscriber.create(s24, rv, 0);
            }
            HttpSession httpsession = request.getSession(true);
            httpsession.setAttribute("tea.RV", rv);
            PrintWriter printwriter = response.getWriter();
            printwriter.print(s19);
            printwriter.print(new Anchor(s, new Text(super.r.getString(teasession._nLanguage, "Continue")), "window.open('Notification', 'Lable');"));
            printwriter.close();
        } catch(Exception ex)
{
  ex.printStackTrace();
  response.sendError(500,ex.toString());
}
    }
    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/ui/util/SignUp2");
    }
}
