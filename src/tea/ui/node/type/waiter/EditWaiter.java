package tea.ui.node.type.waiter;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.entity.*;
import tea.entity.node.*;
import tea.entity.site.*;
import tea.entity.member.*;
import tea.htmlx.TimeSelection;
import tea.ui.*;
import tea.db.*;

public class EditWaiter extends tea.ui.TeaServlet
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
        { // {java.net.URL url=new java.net.URL(
            TeaSession teasession = new TeaSession(request);
            if (teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode + "&nexturl=" + request.getRequestURI() + "?" + request.getQueryString());
                return;
            }

            if (request.getMethod().equals("GET"))
            {
                response.sendRedirect("/jsp/type/admin/EditWaiter.jsp?" + request.getQueryString());
            } else
            {
                String member = teasession.getParameter("member");
                String code = teasession.getParameter("code");
                // //是否存在///////////
                DbAdapter db = new DbAdapter();
                try
                {
                    db.executeQuery("SELECT node FROM Node WHERE path LIKE '/" + Community.find(teasession._strCommunity).getNode() + "/%' AND type=68 AND rcreator=" + DbAdapter.cite(member));
                    if (db.next())
                    {
                        teasession._nNode = db.getInt(1);
                    }
                } finally
                {
                    db.close();
                }
                int id = Waiter.findByCode(code);
                if (id > 0 && id != teasession._nNode)
                {
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("代号已经存在", "UTF-8")); // + "&nexturl=" + request.getRequestURI() + "?" + request.getQueryString());
                    return;
                }
                String password = teasession.getParameter("password");
                Profile p;
                boolean newmember = teasession.getParameter("newmember") != null;
                String email = teasession.getParameter("Email");
                if (newmember)
                {
                    if (Profile.isExisted(member))
                    {
                        response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("会员已经存在", "UTF-8"));
                        return;
                    } else
                    {
                        String sn = request.getServerName() + ":" + request.getServerPort();
                        p = Profile.create(member, password, teasession._strCommunity, email, sn);
                    }
                } else
                {
                    p = Profile.find(member);
                    p.setPassword(password);
                }
                // ///////////////////
                String photo = p.getPhotopath(teasession._nLanguage);
                byte by[] = teasession.getBytesParameter("photo");
                if (by != null)
                {
                    photo = write(teasession._strCommunity, by, ".gif");
                } else if (teasession.getParameter("clear") != null)
                {
                    photo = null;
                }
                String firstname = teasession.getParameter("FirstName");

                int polity = Integer.parseInt(teasession.getParameter("polity"));
                p.setPolity(polity);

                Date birth = new Date();
                try
                {
                    birth = TimeSelection.makeTime(teasession.getParameter("birthYear"), teasession.getParameter("birthMonth"), teasession.getParameter("birthDay"));
                } catch (Exception ex)
                {
                }

                String degree = teasession.getParameter("Degree");
                String school = teasession.getParameter("school");
                String address = teasession.getParameter("Address");
                String state = teasession.getParameter("NationalityCN");
                String telephone = teasession.getParameter("telephone");
                boolean sex = "1".equals(teasession.getParameter("gender"));
                String mobile = teasession.getParameter("Mobile");
                p.set(email, birth, 1, mobile, sex, teasession._nLanguage, firstname, "", p.getOrganization(teasession._nLanguage), address, p.getCity(teasession._nLanguage), state, p.getZip(teasession._nLanguage), p.getCountry(teasession._nLanguage), telephone, p.getFax(teasession._nLanguage), p.getWebPage(teasession._nLanguage));
                p.setDegree(degree, teasession._nLanguage);
                p.setSchool(school, teasession._nLanguage);
                p.setPhotopath(photo, teasession._nLanguage);
//
                Node node = Node.find(teasession._nNode);
                if (node.getType() == 1)
                {
                    int sequence = Node.getMaxSequence(teasession._nNode) + 10;
                    int options1 = 0;
                    long options = node.getOptions();
                    Category cat = Category.find(teasession._nNode); //68
                    teasession._nNode = Node.create(teasession._nNode, sequence, node.getCommunity(), new RV(member, member), cat.getCategory(), false, options, options1, node.getDefaultLanguage(), null, null, new java.util.Date(), 0, 0, 0, 0, null, teasession._nLanguage, "", "","", "", null, "", 0, null, "", "", "", "", null, "");
                } else
                {
                    node.setTime(new Date());
                    node.setSubject(code, teasession._nLanguage);
                    node.finished(teasession._nNode);
                }
                // ///////////////ְҵ�ſ�/��ְ����///////////////////////////////////
                Waiter obj = Waiter.find(teasession._nNode, teasession._nLanguage);
                obj.setMember(member);
                String resumename = teasession.getParameter("Resume");
                obj.setName(resumename); // �������
                obj.setNowMainCareer(teasession.getParameter("NowCareer"));
                obj.setNowCareerLevel(teasession.getParameter("NowCareerLevel"));
                boolean bool = "true".equals(teasession.getParameter("Has_Abroad"));
                obj.setHasAbroad(bool);
                obj.setSalarySum(teasession.getParameter("SalarySum"));
                String param[] = teasession.getParameterValues("ExpectTrade"); // /���������ҵ ����ѡ5�
                StringBuilder sb = new StringBuilder();
                if (param != null)
                {
                    for (int len = 0; len < param.length; len++)
                    {
                        sb.append("&" + param[len]);
                    }

                }
                obj.setExpectTrade(sb.toString());

                /*
                 * param = teasession.getParameterValues("ExpectCareer"); ///�������ְҵ ����ѡ5� if (param != null) { sb = new StringBuilder(); for (int len = 0; len < param.length; len++) { sb.append("&" + param[len]); } obj.setExpectCareer(sb.toString()); } else { obj.setExpectCareer(teasession.getParameter("ExpectCareer")); }
                 *
                 * param = teasession.getParameterValues("ExpectCity"); //��������� if (param != null) { sb = new StringBuilder(); for (int len = 0; param != null && len < param.length; len++) { sb.append("&" + param[len]); } obj.setExpectCity(sb.toString()); } else { obj.setExpectCity(teasession.getParameter("ExpectCity")); }
                 *
                 * obj.setExpectSalarySum(teasession.getParameter("ExpectSalarySum")); //������н��˰ǰ�� obj.setJoinDateType(teasession.getParameter("JoinDateType")); //����ʱ��
                 */
                obj.setSelfValue(teasession.getParameter("SelfValueCN")); // �����<�
                obj.setSelfAim(teasession.getParameter("ObjectCN")); // ְҵĿ��
                obj.setOther(teasession.getParameter("other"));
                int zone = Integer.parseInt(teasession.getParameter("adminunit"));
                obj.setAdminUnit(zone);
                obj.setCode(code);
                obj.setFigure(!"0".equals(teasession.getParameter("figure")));
                obj.set();

                delete(node);

                String nexturl = teasession.getParameter("nexturl");
                String parm = "";
                if (nexturl != null)
                {
                    parm = "&nexturl=" + nexturl;
                }
                if (teasession.getParameter("Educate") != null)
                {
                    response.sendRedirect("/jsp/type/waiter/EditWaiterEducate.jsp?node=" + teasession._nNode + parm);
                } else if (teasession.getParameter("Employment") != null)
                {
                    response.sendRedirect("/jsp/type/waiter/EditWaiterEmployment.jsp?node=" + teasession._nNode + parm);
                } else
                {
                    if (teasession.getParameter("GoBack") != null)
                    {
                        response.sendRedirect("EditNode?node=" + teasession._nNode + parm);
                    } else if (nexturl != null)
                    {
                        response.sendRedirect(nexturl);
                    } else
                    {
                        response.sendRedirect("/jsp/type/waiter/WaiterList.jsp?node=" + teasession._nNode + "&zone=" + zone);
                    }
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
