package tea.ui.node.type.gazetteer;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.entity.node.*;
import tea.ui.*;
import tea.htmlx.TimeSelection;

public class EditGazetteer extends TeaServlet
{
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            final TeaSession teasession = new TeaSession(request);
            if (teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            String subject = teasession.getParameter("name"); // teasession.getParameter("Subject");
            String text = teasession.getParameter("remark");
            Date date5 = new Date(); // TimeSelection.makeTime(teasession.getParameter("IssueYear"), teasession.getParameter("IssueMonth"), teasession.getParameter("IssueDay"),
            // teasession.getParameter("IssueHour"), teasession.getParameter("IssueMinute"));
            boolean newnode = teasession.getParameter("NewNode") != null;
            byte by[] = teasession.getBytesParameter("Picture");
            String picture = null;
            if (by != null)
            {
                picture = super.write(teasession._strCommunity, by, ".gif");
            }
            String file = null;
            by = teasession.getBytesParameter("File");
            if (by != null)
            {
                file = super.write(teasession._strCommunity, by, ".doc");
            }
            Node node = Node.find(teasession._nNode);
            if (newnode)
            {
                int sequence = Node.getMaxSequence(teasession._nNode) + 10;
                int options1 = node.getOptions1();
                String community = node.getCommunity();
                long options = node.getOptions();
                // options &= 0xffdffbff;
                int defautllangauge = node.getDefaultLanguage();
                Category cat = Category.find(teasession._nNode); //60
                teasession._nNode = Node.create(teasession._nNode, sequence, community, teasession._rv, cat.getCategory(), (options1 & 2) != 0, options, options1, defautllangauge, null, null, new java.util.Date(), 0, 0, 0, 0,null, teasession._nLanguage, subject, "","", text, picture, "", 0, null, "", "", "", "", file, "");
            } else
            {
                node.set(teasession._nLanguage, subject, text);
                if (picture != null)
                {
                    node.setPicture(picture, teasession._nLanguage);
                }
                if (file != null)
                {
                    node.setFile(file, teasession._nLanguage);
                }
            }
            Gazetteer obj = Gazetteer.find(teasession._nNode, teasession._nLanguage);
            // Connection con = DataBaseConnection.getConnection();
            obj.setName(teasession.getParameter("name"));
            obj.setSex(teasession.getParameter("sex"));
            Date birthday = null;
            String strbirthday = teasession.getParameter("birthday");
            if (strbirthday != null)
            {
                birthday = TimeSelection.makeTime(strbirthday); // TimeSelection.makeTime(teasession.getParameter("birthdayYear"), teasession.getParameter("birthdayMonth"),
                // teasession.getParameter("birthdayDay"), "0", "0");
            }
            obj.setBirthday(birthday);
            obj.setBlood(teasession.getParameter("blood"));
            obj.setCardType(teasession.getParameter("cardType"));
            obj.setCardNum(teasession.getParameter("cardNum"));
            String workPlace = teasession.getParameter("workPlace");
            String job = teasession.getParameter("job");
            String email = teasession.getParameter("email");
            obj.setAddress(teasession.getParameter("address"));
            obj.setPhone(teasession.getParameter("phone"));
            obj.setFax(teasession.getParameter("fax"));
            obj.setMobile(teasession.getParameter("mobile"));
            obj.setEmail(teasession.getParameter("email"));
            /*
             * String business[] = teasession.getParameterValues("business"); if (business != null) { StringBuilder sb = new StringBuilder(); for (int index = 0; index < business.length; index++) sb.append(business[index] + " "); obj.setBusiness(sb.toString()); }
             */
            obj.setBusiness(teasession.getParameter("business"));
            String type[] = teasession.getParameterValues("type");
            if (type != null)
            {
                StringBuilder sb = new StringBuilder();
                for (int index = 0; index < type.length; index++)
                {
                    sb.append(type[index] + " ");
                }
                obj.setType(sb.toString());
            }
            obj.setOrganise(teasession.getParameter("organise"));
            obj.setOaddress(teasession.getParameter("oaddress"));
            obj.setOphone(teasession.getParameter("ophone"));
            obj.setOfax(teasession.getParameter("ofax"));
            obj.setOemail(teasession.getParameter("oemail"));
            // obj.setArrival(TimeSelection.makeTime(teasession.getParameter("arrivalYear"), teasession.getParameter("arrivalMonth"), teasession.getParameter("arrivalDay"),
            // teasession.getParameter("arrivalHour"), teasession.getParameter("arrivalMinute")));
            obj.setArrivalDate(teasession.getParameter("arrivaldate"));
            obj.setArrivalTime(teasession.getParameter("arrivaltime"));
            obj.setArrivalFlight(teasession.getParameter("arrivalflight"));
            obj.setArrivalTrain(teasession.getParameter("arrivaltrain"));
            // obj.setLeave(TimeSelection.makeTime(teasession.getParameter("leaveYear"), teasession.getParameter("leaveMonth"), teasession.getParameter("leaveDay"), teasession.getParameter("leaveHour"),
            // teasession.getParameter("leaveMinute")));
            obj.setLeaveDate(teasession.getParameter("arrivaldate"));
            obj.setLeaveTime(teasession.getParameter("arrivaltime"));
            obj.setLeaveFlight(teasession.getParameter("leaveflight"));
            obj.setLeaveTrain(teasession.getParameter("leavetrain"));
            obj.setWelcome(teasession.getParameter("welcome"));
            obj.setRemark(text);
            obj.setMember(teasession._rv.toString());
            obj.setFile(new java.io.File(getServletContext().getRealPath("/tea/image/type")).list(new java.io.FilenameFilter()
            {
                public boolean accept(File dir, String name)
                {
                    return name.startsWith(teasession._rv.toString() + "_");
                }
            }).length > 0);
            obj.set();
            if (teasession.getParameter("GoNext") != null)
            {
                response.sendRedirect("/jsp/type/gazetteer/GazetteerUp.jsp?Type=60");
            } else
            {
                Node.find(teasession._nNode).finished(teasession._nNode);
                String nexturl = teasession.getParameter("nexturl");
                if (nexturl != null)
                {
                    response.sendRedirect(nexturl);
                } else
                {
                    response.sendRedirect("/servlet/Register?node=" + teasession._nNode + "&edit=ON");
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
