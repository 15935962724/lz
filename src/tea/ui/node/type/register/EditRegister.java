package tea.ui.node.type.register;

import java.sql.*;
import javax.sql.*;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.util.Date;
import tea.entity.node.*;
import tea.htmlx.TimeSelection;

public class EditRegister extends HttpServlet
{
    public void service(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            final tea.ui.TeaSession teasession = new tea.ui.TeaSession(request);
            String subject = teasession.getParameter("name"); // teasession.getParameter("Subject");
            String text = teasession.getParameter("addition");
            Date date5 = new Date(); // TimeSelection.makeTime(teasession.getParameter("IssueYear"), teasession.getParameter("IssueMonth"), teasession.getParameter("IssueDay"), teasession.getParameter("IssueHour"), teasession.getParameter("IssueMinute"));
            Node node = Node.find(teasession._nNode);
            boolean newnode = teasession.getParameter("NewNode") != null;
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
                Category cat = Category.find(teasession._nNode); //58
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

            tea.entity.node.Register obj = tea.entity.node.Register.find(teasession._nNode, teasession._nLanguage);
            if (subject != null)
            {
                StringBuilder sb = new StringBuilder("/");
                for (int index = 0; index < subjects.length; index++)
                {
                    sb.append(subjects[index] + "/");
                }
                obj.setSubject(sb.toString());
            }
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
            obj.setLeaveDate(request.getParameter("leavedata"));
            obj.setLeaveTime(request.getParameter("leavetime"));
            obj.setLeaveFlight(request.getParameter("leaveflight"));
            obj.setLeaveTrain(request.getParameter("leavetrain"));
            obj.setWelcome(welcome);
            obj.setAddition(addition);
            obj.setEmployee(employee);
            obj.setMember(teasession._rv.toString());
            obj.setFile(new java.io.File(getServletContext().getRealPath("/tea/image/type")).list(new java.io.FilenameFilter()
            {
                public boolean accept(File dir, String name)
                {
                    return name.startsWith(teasession._rv.toString() + "_");
                }
            }).length > 0);
            obj.set();
            // if (request.getParameter("GoNext") != null)
            // response.sendRedirect("/jsp/type/gazetteer/GazetteerUp.jsp?Type=58");
            // else
            {
                tea.entity.node.Node.find(teasession._nNode).finished(teasession._nNode);
                String nexturl = request.getParameter("nexturl");
                if (nexturl != null)
                {
                    response.sendRedirect(nexturl);
                } else
                {
                    response.sendRedirect("Register?Edit=ON&Node=" + teasession._nNode);
                }
            }
            /*
             * if (sex.equals("boy")) CallStmt.setString(2, "��"); else CallStmt.setString(2, "Ů");
             *
             * CallStmt.setString(3, birthday); if (blood.equals("A"))
             *
             * CallStmt.setString(4, "A"); else if (blood.equals("AB")) CallStmt.setString(4, "AB"); else CallStmt.setString(4, "O"); CallStmt.setString(5, cardType); CallStmt.setString(6, cardNum);
             *
             * CallStmt.setString(7, workPlace); CallStmt.setString(8, job); CallStmt.setString(9, email); CallStmt.setString(10, address); CallStmt.setString(11, phone); CallStmt.setString(12, fax); CallStmt.setString(13, mobile); CallStmt.setString(14, richDate); CallStmt.setString(15, richTime); CallStmt.setString(16, flightNum); CallStmt.setString(17, trainNum); if (welcome.equals("yes")) CallStmt.setString(18, "��Ҫ"); else CallStmt.setString(18, "����Ҫ");
             *
             * if (subject.equals("subject1")) CallStmt.setString(19, "��Ŀһ"); else if (subject.equals("subject2")) CallStmt.setString(19, "��Ŀ��"); else CallStmt.setString(19, "��Ŀ��"); CallStmt.setString(20, addition); CallStmt.setString(21, employee);
             *
             * System.out.println("begin insert data!!"); int i = CallStmt.executeUpdate();
             *
             * System.out.println("������ݳɹ�!!!"); response.sendRedirect("LoginSucceed.html");
             *
             * CallStmt.close(); con.close();
             */
        } catch (Exception e)
        {
            e.printStackTrace();
        }
    }

}
