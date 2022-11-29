package tea.ui.node.type.admin;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.entity.node.*;
import tea.entity.member.*;
import tea.db.*;
import tea.ui.*;

public class EditAdmin extends tea.ui.TeaServlet
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
            TeaSession teasession = new TeaSession(request);
            if (teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode + "&NextUrl=" + request.getRequestURI() + "?" + request.getQueryString());
                return;
            }

            if (request.getMethod().equals("GET"))
            {
                response.sendRedirect("/jsp/type/admin/EditAdmin.jsp?" + request.getQueryString());
            } else
            {
                Node node = Node.find(teasession._nNode);
                Profile profile = Profile.find(teasession._rv._strR);
                DbAdapter dbadapter = new DbAdapter();
                /*
                 * tea.entity.member.Profile profile = tea.entity.member.Profile.find(teasession._rv.toString()); profile.setSex(!.equals("0")); profile.setState(teasession.getParameter("NationalityCN"));
                 */
                // Date birthday = TimeSelection.makeTime(teasession.getParameter("birthday:ymYear"), teasession.getParameter("birthday:ymMonth"), "0");
                String sql;
                byte by[] = (teasession.getBytesParameter("Photo"));
                if (teasession.getParameter("Clear") != null && by == null)
                {
                    sql = ",photo=null";
                } else if (by == null)
                {
                    sql = "";
                } else
                {
                    sql = ",photo=" + DbAdapter.cite(by);
                }
                String FirstName = teasession.getParameter("FirstName");
                dbadapter.executeUpdate("UPDATE ProfileLayer SET  firstname=" + DbAdapter.cite(FirstName) + ",lastname=" + DbAdapter.cite(FirstName) + ",degree=" + teasession.getParameter("Degree") + ",school=" + DbAdapter.cite(teasession.getParameter("school")) +
                                        // ",birth=" + DbAdapter.cite(birthday) +
                                        ",address=" + DbAdapter.cite(teasession.getParameter("Address")) + ",state=" + DbAdapter.cite(teasession.getParameter("NationalityCN")) + ",telephone=" + DbAdapter.cite(teasession.getParameter("telephone")) + sql + // ��Ƭ
                                        ",email=" + DbAdapter.cite(teasession.getParameter("Email")) + " WHERE member = " + DbAdapter.cite(teasession._rv.toString()) + " AND language = " + teasession._nLanguage + " UPDATE Profile SET sex=" + teasession.getParameter("gender") + ",age=" + teasession.getParameter("age") + ",mobile=" + DbAdapter.cite(teasession.getParameter("Mobile")) + " WHERE member = " + DbAdapter.cite(teasession._rv.toString()));
                dbadapter.close();
                profile.setPolity(Integer.parseInt(teasession.getParameter("polity")));
                profile._cache.remove(teasession._rv.toString());
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
                    int options1 = 0;
                    long options = node1.getOptions();
                    options &= 0xffdffbff;
                    int defautllangauge = node1.getDefaultLanguage();
                    Category cat = Category.find(teasession._nNode); //76
                    teasession._nNode = Node.create(father, sequence, node1.getCommunity(), teasession._rv, cat.getCategory(), false, options, options1, defautllangauge, null, null, new java.util.Date(), 0, 0, 0, 0, null, teasession._nLanguage, "", "","", "", null, "", 0, null, "", "", "", "", null, "");
                    node = Node.find(teasession._nNode);
                } else
                {
                    if (!node.isCreator(teasession._rv) && AccessMember.find(teasession._nNode, teasession._rv._strV).getPurview() < 2)
                    {
                        response.sendError(403);
                        return;
                    }
                }

                // ///////////////ְҵ�ſ�/��ְ����///////////////////////////////////
                Admin summary = Admin.find(teasession._nNode, teasession._nLanguage);
                // org.apache.jasper.runtime.JspRuntimeLibrary.introspect(summary, request);
                summary.setMember(teasession._rv.toString());
                String resumename = teasession.getParameter("Resume");
                summary.setName(resumename); // �������
                summary.setNode(teasession._nNode); // �������ڵĽڵ�
                // summary.setNowTrade(Integer.parseInt(teasession.getParameter("NowTrade"))); //* �ִ�����ҵ
                 summary.setNowMainCareer(teasession.getParameter("NowCareer")); // * �ִ���ְҵ
                summary.setNowCareerLevel(teasession.getParameter("NowCareerLevel")); // ��ְλ����
                summary.setExperience(Integer.parseInt(teasession.getParameter("Experience"))); // * ������
                boolean bool; // * �Ƿ��к��⹤����
                if (teasession.getParameter("Has_Abroad").equalsIgnoreCase("True"))
                {
                    bool = true;
                } else
                {
                    bool = false;
                }
                summary.setHasAbroad(bool);
                int ExpectWorkKind = 0; // ����������
                if (teasession.getParameter("ExpectWorkKind:0") != null)
                {
                    ExpectWorkKind |= 2;
                }
                if (teasession.getParameter("ExpectWorkKind:1") != null)
                {
                    ExpectWorkKind |= 4;
                }
                if (teasession.getParameter("ExpectWorkKind:2") != null)
                {
                    ExpectWorkKind |= 8;
                }
                if (teasession.getParameter("ExpectWorkKind:3") != null)
                {
                    ExpectWorkKind |= 16;
                }
                summary.setExpectWorkKind(ExpectWorkKind);
                summary.setSalarySum(teasession.getParameter("SalarySum")); // Ŀǰ��н��˰ǰ
                String param[] = teasession.getParameterValues("ExpectTrade"); // /���������ҵ ����ѡ5�
                StringBuilder sb = new StringBuilder();
                if (param != null)
                {
                    for (int len = 0; len < param.length; len++)
                    {
                        sb.append("&" + param[len]);
                    }
                    summary.setExpectTrade(sb.toString());
                } else
                {
                    summary.setExpectTrade(teasession.getParameter("ExpectTrade"));
                }

                param = teasession.getParameterValues("ExpectCareer"); // /�������ְҵ ����ѡ5�
                if (param != null)
                {
                    sb = new StringBuilder();
                    for (int len = 0; len < param.length; len++)
                    {
                        sb.append("&" + param[len]);
                    }
                    summary.setExpectCareer(sb.toString());
                } else
                {
                    summary.setExpectCareer(teasession.getParameter("ExpectCareer"));
                }

                param = teasession.getParameterValues("ExpectCity"); // ���������
                if (param != null)
                {
                    sb = new StringBuilder();
                    for (int len = 0; param != null && len < param.length; len++)
                    {
                        sb.append("&" + param[len]);
                    }
                    summary.setExpectCity(sb.toString());
                } else
                {
                    summary.setExpectCity(teasession.getParameter("ExpectCity"));
                }

                summary.setExpectSalarySum(teasession.getParameter("ExpectSalarySum")); // ������н��˰ǰ��
                summary.setJoinDateType(teasession.getParameter("JoinDateType")); // ����ʱ��
                summary.setSelfValue(teasession.getParameter("SelfValueCN")); // �����<�
                summary.setSelfAim(teasession.getParameter("ObjectCN")); // ְҵĿ��
                summary.setOther(teasession.getParameter("other"));
                summary.set();
                // Node node = Node.find(teasession._nNode);
                node.setTime(new Date());
                node.setSubject(FirstName + ":" + resumename, teasession._nLanguage);
                delete(node);
                node.finished(teasession._nNode);
                if (teasession.getParameter("Educate") != null)
                {
                    response.sendRedirect("/jsp/type/resume/EditEducate.jsp?node=" + teasession._nNode);
                } else if (teasession.getParameter("Employment") != null)
                {
                    response.sendRedirect("/jsp/type/resume/EditEmployment.jsp?node=" + teasession._nNode);
                } else
                {
                    String nexturl = teasession.getParameter("nexturl");
                    if (teasession.getParameter("GoBack") != null)
                    {
                        String parm = "";
                        if (nexturl != null)
                        {
                            parm = "&nexturl=" + nexturl;
                        }
                        response.sendRedirect("EditNode?node=" + teasession._nNode + parm);
                    } else if (nexturl != null)
                    {
                        response.sendRedirect(nexturl);
                    } else
                    {
                        response.sendRedirect("Admin?Edit=ON&Node=" + teasession._nNode);
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
