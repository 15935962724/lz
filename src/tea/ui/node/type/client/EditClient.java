package tea.ui.node.type.client;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.entity.node.*;
import tea.entity.*;

public class EditClient extends tea.ui.TeaServlet
{
    private static final String CONTENT_TYPE = "text/html; charset=GBK";

    //Initialize global variables
    public void init() throws ServletException
    {
    }

    //Process the HTTP Get request
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        response.setContentType(CONTENT_TYPE);
        java.io.PrintWriter out = response.getWriter();
        try
        { //        {java.net.URL url=new java.net.URL(
            tea.ui.TeaSession teasession = new tea.ui.TeaSession(request);
            /* if(teasession._rv == null)
             {
                 response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&NextUrl="+request.getRequestURI()+"?"+request.getQueryString());
                 return;
             }*/

            if (request.getMethod().equals("GET"))
            {
                response.sendRedirect("/jsp/type/admin/EditAdmin.jsp?" + request.getQueryString());
            } else
            {
                tea.entity.node.Node node = tea.entity.node.Node.find(teasession._nNode);
                int father = 0;
                if (teasession._rv == null)
                {
                    java.util.Enumeration fbt_enumer = tea.entity.node.Node.findByType(1, node.getCommunity());
                    while (fbt_enumer.hasMoreElements())
                    {
                        father = ((Integer) fbt_enumer.nextElement()).intValue();
                        if (tea.entity.node.Category.find(father).getCategory() == 69)
                        {
                            break;
                        } else
                        {
                            father = 0;
                        }
                    }
                    if (father == 0)
                    {
                        out.print(new tea.html.Script("alert('请通知管理员,会员的类别(69)还没有创建.');history.back();"));
                        return;
                    }
                } else
                {
                    java.util.Enumeration fbt_enumer = tea.entity.node.Node.findByType(69, node.getCommunity());
                    while (fbt_enumer.hasMoreElements())
                    {
                        father = ((Integer) fbt_enumer.nextElement()).intValue();
                        if (tea.entity.node.Node.find(father).getCreator().equals(teasession._rv))
                        {
                            break;
                        } else
                        {
                            father = 0;
                        }
                    }
                    if (father == 0)
                    {
                        out.print(new tea.html.Script("alert('对不起,要注册为客户,请退出登陆.');history.back();"));
                        return;
                    }
                }
                String resumename = teasession.getParameter("Resume");
//                tea.entity.node.Node node = tea.entity.node.Node.find(teasession._nNode);

                if (teasession._rv == null && tea.entity.member.Profile.isExisted(resumename))
                {
                    out.print(new tea.html.Script("alert('对不起,会员已经存在.');history.back();"));
                    return;
                }
                /*
                       tea.entity.member.Profile profile = tea.entity.member.Profile.find(teasession._rv.toString());
                       profile.setSex(!.equals("0"));
                       profile.setState(teasession.getParameter("NationalityCN"));*/
//                Date birthday = TimeSelection.makeTime(teasession.getParameter("birthday:ymYear"), teasession.getParameter("birthday:ymMonth"), "0");
                tea.entity.member.Profile profile = null;
                if (teasession._rv == null)
                {
                    String sn = request.getServerName() + ":" + request.getServerPort();
                    profile = tea.entity.member.Profile.create(resumename, teasession.getParameter("pw"), node.getCommunity(), "", sn);
                } else
                {
                    profile = tea.entity.member.Profile.find(resumename);
                }
                byte by[] = (teasession.getBytesParameter("Photo"));
                if (teasession.getParameter("Clear") != null && by == null)
                {
                    profile.setPhotopath(null, teasession._nLanguage);
                } else
                if (by != null)
                {
                    String photopath = profile.getPhotopath(teasession._nLanguage);
                    java.io.File file;
                    ServletContext application = this.getServletContext();
                    String path = "/res/" + teasession._strCommunity + "/profile.photo/";
                    if (photopath != null && photopath.startsWith(path))
                    {
                        file = new java.io.File(application.getRealPath(photopath));
                    } else
                    {
                        java.io.File f = new java.io.File(application.getRealPath(path));
                        if (!f.exists())
                        {
                            f.mkdirs();
                        }
                        file = java.io.File.createTempFile(teasession._rv._strV + "_" + teasession._nLanguage + "_", ".jpg", f);
                        profile.setPhotopath(path + file.getName(), teasession._nLanguage);
                    }
                    java.io.FileOutputStream fos = new java.io.FileOutputStream(file);
                    fos.write(by);
                    fos.close();
                }
                String FirstName = teasession.getParameter("FirstName");
                profile.setFirstName(FirstName, teasession._nLanguage);
                /*********************************************
                                 int age = 0;
                                 try
                                 {
                    age = Integer.parseInt(teasession.getParameter("age"));
                    profile.setAge(age);
                                 } catch (SQLException ex1)
                                 {
                                 } catch (NumberFormatException ex1)
                                 {
                                 }*/
                int sex = 0;
                try
                {
                    sex = Integer.parseInt(teasession.getParameter("gender"));
                    profile.setSex(sex != 0);
                } catch (Exception ex2)
                {
                }
                String mobile = teasession.getParameter("Mobile");
                profile.setMobile(mobile);
                profile.setDegree(teasession.getParameter("Degree"), teasession._nLanguage);
                profile.setSchool(teasession.getParameter("school"), teasession._nLanguage);
                profile.setAddress(teasession.getParameter("Address"), teasession._nLanguage);
                profile.setState(teasession.getParameter("NationalityCN"), teasession._nLanguage);
                profile.setTelephone(teasession.getParameter("telephone"), teasession._nLanguage);
                profile.setEmail(teasession.getParameter("Email"));
                profile.setPolity(Integer.parseInt(teasession.getParameter("polity")));

                if (teasession._rv == null)
                {
                    Node node1 = Node.find(father);
                    int sequence = Node.getMaxSequence(father) + 10;
                    int options1 = 0;
                    int typealias = 0;
                    String community = node1.getCommunity();
                    try
                    {
                        typealias = Integer.parseInt(teasession.getParameter("TypeAlias"));
                    } catch (Exception exception1)
                    {}
                    long options = node1.getOptions();
                    options &= 0xffdffbff;
                    int defautllangauge = node1.getDefaultLanguage();
                    Category cat = Category.find(teasession._nNode); //69
                    teasession._nNode = Node.create(father, sequence, community, new tea.entity.RV(resumename, node.getCommunity()), cat.getCategory(), false, options, options1, defautllangauge, null, null, new java.util.Date(), 0, 0, 0, 0, null, teasession._nLanguage, resumename, "","", "", null, "", 0, null, "", "", "", "", null, "");
					node=Node.find(teasession._nNode);
				}

                /////////////////职业概况/求职意向///////////////////////////////////
                tea.entity.node.Client summary = tea.entity.node.Client.find(teasession._nNode, teasession._nLanguage);
                //org.apache.jasper.runtime.JspRuntimeLibrary.introspect(summary, request);
                summary.setMember(resumename);

                summary.setName(resumename); //简历名称
                summary.setNode(teasession._nNode); //简历所在的节点
//                summary.setNowTrade(Integer.parseInt(teasession.getParameter("NowTrade"))); //* 现从事行业
                 summary.setNowMainCareer(teasession.getParameter("NowCareer")); //* 现从事职业
                summary.setNowCareerLevel(teasession.getParameter("NowCareerLevel")); // 现职位级别
                summary.setExperience(Integer.parseInt(teasession.getParameter("Experience"))); //* 工作经验
                boolean bool; //* 是否有海外工作经历
                if (teasession.getParameter("Has_Abroad").equalsIgnoreCase("True"))
                {
                    bool = true;
                } else
                {
                    bool = false;
                }
                summary.setHasAbroad(bool);
                int ExpectWorkKind = 0; //期望工作性质
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
                summary.setSalarySum(teasession.getParameter("SalarySum")); //目前月薪（税前
                String param[] = teasession.getParameterValues("ExpectTrade"); ///期望从事行业  （可选5项）
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

                param = teasession.getParameterValues("ExpectCareer"); ///期望从事职业   （可选5项）
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

                param = teasession.getParameterValues("ExpectCity"); //期望工作地区
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

                summary.setExpectSalarySum(teasession.getParameter("ExpectSalarySum")); //期望月薪（税前）
                summary.setJoinDateType(teasession.getParameter("JoinDateType")); //到岗时间
                summary.setSelfValue(teasession.getParameter("SelfValueCN")); //自我评价
                summary.setSelfAim(teasession.getParameter("ObjectCN")); //职业目标
                summary.setOther(teasession.getParameter("other"));
                // summary.setPrice(new java.math.BigDecimal(teasession.getParameter("price")));
                summary.setSex(sex != 0);
                //////////////////////////////////////////////////////summary.setAge(age);
                summary.set();
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
                        response.sendRedirect("Client?Edit=ON&Node=" + teasession._nNode);
                    }
                }
            }
        } catch (Exception ex)
        {
            ex.printStackTrace();
        } finally
        {
            out.close();
        }

    }

    //Clean up resources
    public void destroy()
    {
    }
}
