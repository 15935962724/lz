package tea.ui.node.type.eregister;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.*;
import tea.entity.node.*;
import tea.htmlx.TimeSelection;
import java.sql.SQLException;

public class EditERegister extends HttpServlet
{

    // Initialize global variables
    public void init() throws ServletException
    {
    }

    // Process the HTTP Get request
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            final TeaSession teasession = new TeaSession(request);
            String subject = teasession.getParameter("name"); // teasession.getParameter("Subject");
            String text = teasession.getParameter("addition");
            Date date5 = new Date(); // TimeSelection.makeTime(teasession.getParameter("IssueYear"), teasession.getParameter("IssueMonth"), teasession.getParameter("IssueDay"), teasession.getParameter("IssueHour"), teasession.getParameter("IssueMinute"));
            boolean newnode = teasession.getParameter("NewNode") != null;
            Node node = Node.find(teasession._nNode);
            if (newnode)
            {
                int sequence = Node.getMaxSequence(teasession._nNode) + 10;
                int options1 = node.getOptions1();
                int typealias = 0;
                String community = node.getCommunity();
                try
                {
                    typealias = Integer.parseInt(teasession.getParameter("TypeAlias"));
                } catch (Exception exception1)
                {
                }
                long options = node.getOptions();
                // options &= 0xffdffbff;
                int defautllangauge = node.getDefaultLanguage();
                Category cat = Category.find(teasession._nNode); //59
                teasession._nNode = Node.create(teasession._nNode, sequence, community, teasession._rv, cat.getCategory(), (options1 & 2) != 0, options, options1, defautllangauge, null, null, new java.util.Date(), 0, 0, 0, 0, null,teasession._nLanguage, subject, "","", text, null, "", 0, null, "", "", "", "", null,null);
            } else
            {
                node.set(teasession._nLanguage, subject, text);
            }

            // Connection con = DataBaseConnection.getConnection();
            String name = request.getParameter("name");
            String sex = request.getParameter("sex");
            Date birthday = TimeSelection.makeTime(teasession.getParameter("birthday")); // TimeSelection.makeTime(teasession.getParameter("birthdayYear"), teasession.getParameter("birthdayMonth"), teasession.getParameter("birthdayDay"), "0", "0");
            // String birthday = request.getParameter("birthday");
            String blood = request.getParameter("blood");
            String cardType = request.getParameter("cardType");
            String cardNum = request.getParameter("cardNum");
            String workPlace = request.getParameter("workPlace");
            String job = request.getParameter("job");
            String email = request.getParameter("email");
            String address = request.getParameter("address");
            String phone = request.getParameter("phone");
            String fax = request.getParameter("fax");
            String mobile = request.getParameter("mobile");
            String richDate = request.getParameter("richDate");
            String richTime = request.getParameter("richTime");
            String flightNum = request.getParameter("flightNum");
            String trainNum = request.getParameter("trainNum");
            String welcome = request.getParameter("welcome");
            String subjects[] = request.getParameterValues("subject");
            String addition = request.getParameter("addition");
            String employee = request.getParameter("employee");
            ERegister obj = ERegister.find(teasession._nNode, teasession._nLanguage);
            if (subject != null)
            {
                StringBuilder sb = new StringBuilder("/");
                for (int index = 0; index < subjects.length; index++)
                {
                    sb.append(subjects[index] + "/");
                }
                obj.setSubject(sb.toString());
            }
            obj.setMember(teasession._rv.toString());
            obj.setName(name);
            obj.setSex(sex);
            obj.setBirthday(birthday);
            obj.setBlood(blood);
            obj.setCardType(cardType);
            obj.setCardNum(cardNum);
            obj.setWorkPlace(workPlace);
            obj.setJob(job);
            obj.setEmail(email);
            obj.setAddress(address);
            obj.setPhone(phone);
            obj.setFax(fax);
            obj.setMobile(mobile);
            obj.setRichDate(richDate);
            obj.setRichTime(richTime);
            obj.setFlightNum(flightNum);
            obj.setTrainNum(trainNum);
            obj.setWelcome(welcome);
            obj.setAddition(addition);
            obj.setEmployee(employee);
            obj.setNationality(request.getParameter("nationality"));
            obj.setMiddle(request.getParameter("middle"));
            obj.setPostal(request.getParameter("postal"));
            obj.setPlace(request.getParameter("place"));
            obj.setDate(request.getParameter("date"));
            obj.setTime(request.getParameter("time"));
            obj.setPort(request.getParameter("port"));
            obj.setDeparture(request.getParameter("departure"));
            obj.setAirport(request.getParameter("airport"));
            obj.setDocument(request.getParameter("document"));
            obj.setTitle(request.getParameter("title"));
            obj.setGroup(request.getParameter("group"));
            obj.setExpiration(request.getParameter("expiration"));
            obj.setDeparturedate2(request.getParameter("departuredate"));
            obj.setDeparturetime(request.getParameter("departuretime"));
            obj.setDepartureflight(request.getParameter("departureflight"));
            obj.setDeparturetrain(request.getParameter("departuretrain"));
            obj.setFile(new java.io.File(getServletContext().getRealPath("/tea/image/type")).list(new java.io.FilenameFilter()
            {
                public boolean accept(File dir, String name)
                {
                    return name.startsWith(teasession._rv.toString() + "_");
                }
            }).length > 0);
            obj.set();
            if (request.getParameter("GoNext") != null)
            {
                response.sendRedirect("/jsp/type/gazetteer/GazetteerUp.jsp?Type=59");
            } else
            {
                Node.find(teasession._nNode).finished(teasession._nNode);
                String nexturl = request.getParameter("nexturl");
                if (nexturl != null)
                {
                    response.sendRedirect(nexturl);
                } else
                {
                    response.sendRedirect("/servlet/Register?Edit=ON&Node=" + teasession._nNode);
                }
            }
        } catch (Exception e)
        {
            e.printStackTrace();
        }
    }

    // Clean up resources
    public void destroy()
    {
    }
}
