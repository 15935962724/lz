package tea.ui.node.type.egazetteer;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.entity.node.*;
import tea.htmlx.TimeSelection;

public class EditEGazetteer extends HttpServlet
{
    // Process the HTTP Get request
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");

        try
        {
            final tea.ui.TeaSession teasession = new tea.ui.TeaSession(request);
            String subject = teasession.getParameter("name"); // teasession.getParameter("subject");
            String text = teasession.getParameter("remark");
            Date date5 = new Date(); // TimeSelection.makeTime(teasession.getParameter("IssueYear"), teasession.getParameter("IssueMonth"), teasession.getParameter("IssueDay"), teasession.getParameter("IssueHour"), teasession.getParameter("IssueMinute"));
            boolean newbrother = teasession.getParameter("NewBrother") != null;
            boolean newnode = teasession.getParameter("NewNode") != null;
            if (newnode || newbrother)
            {
                int father;
                father = teasession._nNode;
                if (newbrother)
                {
                    father = Node.find(father).getFather();
                }
                Node node1 = Node.find(father);
                int sequence = Node.getMaxSequence(father) + 10;
                int options1 = node1.getOptions1();
                int typealias = 0;
                String community = node1.getCommunity();
                try
                {
                    typealias = Integer.parseInt(teasession.getParameter("TypeAlias"));
                } catch (Exception exception1)
                {
                }
                long options = node1.getOptions();
                // options &= 0xffdffbff;
                int defautllangauge = node1.getDefaultLanguage();
                Category cat = Category.find(teasession._nNode); //61
                teasession._nNode = Node.create(father, sequence, community, teasession._rv, cat.getCategory(), (options1 & 2) != 0, options, options1, defautllangauge, null, null, new java.util.Date(), 0, 0, 0, 0, null,teasession._nLanguage, subject, "","", text, null, "", 0, null, "", "", "", "", null,null);
            } else
            {
                Node node = Node.find(teasession._nNode);
                node.set(teasession._nLanguage, subject, text);
            }
            EGazetteer obj = EGazetteer.find(teasession._nNode, teasession._nLanguage);
            // Connection con = DataBaseConnection.getConnection();
            obj.setName(request.getParameter("name"));
            obj.setName2(request.getParameter("name2"));
            obj.setSex(request.getParameter("sex"));
            Date birthday = TimeSelection.makeTime(teasession.getParameter("birthday")); // TimeSelection.makeTime(teasession.getParameter("birthdayYear"), teasession.getParameter("birthdayMonth"), teasession.getParameter("birthdayDay"), "0", "0");
            obj.setBirthday(birthday);
            obj.setNationality(request.getParameter("nationality"));
            obj.setExpiration(TimeSelection.makeTime(teasession.getParameter("expirationYear"), teasession.getParameter("expirationMonth"), teasession.getParameter("expirationDay"), "0", "0"));
            obj.setBlood(request.getParameter("blood"));
            obj.setCardType(request.getParameter("cardType"));
            obj.setCardNum(request.getParameter("cardNum"));

            String workPlace = request.getParameter("workPlace");
            String job = request.getParameter("job");
            String email = request.getParameter("email");
            obj.setAddress(request.getParameter("address"));
            obj.setPhone(request.getParameter("phone"));
            obj.setFax(request.getParameter("fax"));
            obj.setMobile(request.getParameter("mobile"));
            obj.setEmail(request.getParameter("email"));
            String business[] = request.getParameterValues("business");
            if (business != null)
            {
                StringBuilder sb = new StringBuilder();
                for (int index = 0; index < business.length; index++)
                {
                    sb.append(business[index] + " ");
                }
                obj.setBusiness(sb.toString());
            }
            String type[] = request.getParameterValues("type");
            if (type != null)
            {
                StringBuilder sb = new StringBuilder();
                for (int index = 0; index < type.length; index++)
                {
                    sb.append(type[index] + " ");
                }
                obj.setType(sb.toString());
            }
            obj.setOrganise(request.getParameter("organise"));
            obj.setOaddress(request.getParameter("oaddress"));
            obj.setOphone(request.getParameter("ophone"));
            obj.setOfax(request.getParameter("ofax"));
            obj.setOemail(request.getParameter("oemail"));
            obj.setArrivalDate(request.getParameter("arrivaldate"));
            obj.setArrivalTime(request.getParameter("arrivaltime"));
            // obj.setArrival(TimeSelection.makeTime(teasession.getParameter("arrivalYear"), teasession.getParameter("arrivalMonth"), teasession.getParameter("arrivalDay"), teasession.getParameter("arrivalHour"), teasession.getParameter("arrivalMinute")));
            obj.setArrivalFlight(request.getParameter("arrivalflight"));
            obj.setArrivalTrain(request.getParameter("arrivaltrain"));
            // obj.setLeave(TimeSelection.makeTime(teasession.getParameter("leaveYear"), teasession.getParameter("leaveMonth"), teasession.getParameter("leaveDay"), teasession.getParameter("leaveHour"), teasession.getParameter("leaveMinute")));
            obj.setLeaveDate(request.getParameter("leavedate"));
            obj.setLeaveTime(request.getParameter("leavetime"));
            obj.setLeaveFlight(request.getParameter("leaveflight"));
            obj.setLeaveTrain(request.getParameter("leavetrain"));
            obj.setWelcome(request.getParameter("welcome"));
            obj.setRemark(text);
            obj.setMember(teasession._rv.toString());
            obj.setFile(new java.io.File(getServletContext().getRealPath("/tea/image/type")).list(new java.io.FilenameFilter()
            {
                public boolean accept(File dir, String name)
                {
                    return name.startsWith(teasession._rv.toString() + "_");
                }
            }).length > 0);
            obj.setAppear(request.getParameter("appear"));
            obj.set();
            if (request.getParameter("GoNext") != null)
            {
                response.sendRedirect("/jsp/type/gazetteer/GazetteerUp.jsp?Type=61");
            } else
            {
                String nexturl = request.getParameter("nexturl");
                if (nexturl != null)
                {
                    response.sendRedirect(nexturl);
                } else
                {
                    response.sendRedirect("ERegister?Edit=ON&Node=" + teasession._nNode);
                }
            }
        } catch (Exception ex)
        {
            ex.printStackTrace();
        }
    }

    // Clean up resources
    public void destroy()
    {
    }
}
