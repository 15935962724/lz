package tea.ui.admin;

import java.io.IOException; //import java.io.PrintWriter;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse; //import tea.entity.node.Classified;
import tea.entity.node.*; //import tea.html.*;
//import tea.htmlx.Go;
//import tea.htmlx.Languages;
//import tea.resource.Common;
//import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;
import tea.entity.*;
import tea.entity.member.*;
import javax.servlet.http.*;
import tea.entity.*;
import tea.entity.admin.*;

public class EditCompany2 extends TeaServlet
{

    public EditCompany2()
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            TeaSession teasession = new TeaSession(request);

            HttpSession session = request.getSession(true);
//            if (teasession._rv == null)
//            {
//                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
//                return;
//            }

            boolean newnode = teasession.getParameter("NewNode") != null;
//            if (!newnode && !tea.entity.site.Organizer.isOrganizer(node.getCommunity(), teasession._rv.toString()) && !node.isCreator(teasession._rv))
//            {
//                response.sendError(403);
//                return;
//            }

            String nexturl = teasession.getParameter("nexturl");
            String act = teasession.getParameter("act");
            String subject = teasession.getParameter("Name").trim(); //企业名称
            //  String father1 =teasession.getParameter("father1");//所属行业1

            int father1 = 0; //所属行业2
            if (teasession.getParameter("father1") != null && teasession.getParameter("father1").length() > 0)
            {
                father1 = Integer.parseInt(teasession.getParameter("father1"));
            }
            int father2 = 0; //所属行业2
            if (teasession.getParameter("father2") != null && teasession.getParameter("father2").length() > 0)
            {
                father2 = Integer.parseInt(teasession.getParameter("father2"));
            }
            if (father2 == 0) //如果所属行业中没有二级分类
            {
                father2 = father1;
            }
            int nids = 0;
            if (teasession.getParameter("nids") != null && teasession.getParameter("nids").length() > 0)
            {
                nids = Integer.parseInt(teasession.getParameter("nids"));
            }
            if (nids > 0) //修改数据
            {
                teasession._nNode = nids;
            } else
            {
                teasession._nNode = father2;
            }
            Node node = Node.find(teasession._nNode);
            String text = teasession.getParameter("Text"); //企业简介
            int sequence = 0;
            try
            {
                sequence = Integer.parseInt(teasession.getParameter("sequence")); //--暂无用到
            } catch (NumberFormatException ex1)
            {
            }
            boolean hidden = false;
//             Profile profile = Profile.find(s1);
            String mem = null;
            //  String mem= teasession.getParameter("MemberId").trim().toLowerCase();
            if (teasession.getParameter("MemberId") != null && teasession.getParameter("MemberId").length() > 0)
            {
                mem = teasession.getParameter("MemberId").trim().toLowerCase();
            } else
            {
                mem = teasession._rv.toString();
            }
            if (newnode)
            {
                String s1 = teasession.getParameter("MemberId").trim().toLowerCase(); //用户名
                if (Profile.isExisted(s1))
                {
                    response.sendRedirect("/jsp/info/Alert.jsp?community=" + teasession._strCommunity + "&info=" + java.net.URLEncoder.encode(tea.http.RequestHelper.format(r.getString(teasession._nLanguage, "RepetitionRegisters"), s1), "UTF-8"));
                    return;
                }
                String password = teasession.getParameter("EnterPassword");
                Profile.create(s1, password, teasession._strCommunity, s1, null, 0, 1, null, null, null, null, null, null, null, null, null, null, null, null);
                String domain = request.getServerName() + ":" + request.getServerPort();
                OpenID.find(s1).setProxy(domain); //注册时的域名
                long options = node.getOptions();
                int options1 = node.getOptions1();
                hidden = (options1 & 2) != 0;
                int typealias = 0;
                String community = node.getCommunity();
                try
                {
                    typealias = Integer.parseInt(teasession.getParameter("TypeAlias"));
                } catch (Exception exception1)
                {
                }
                // options &= 0xffdffbff;
                tea.entity.RV rv = new tea.entity.RV(s1);
                int defautllangauge = node.getDefaultLanguage();
                Category cat = Category.find(father2); //21
                teasession._nNode = Node.create(father2, sequence, community, rv, cat.getCategory(), true, options, options1, defautllangauge, null, null,
                		new java.util.Date(), 0, 0, 0, 0, null, teasession._nLanguage, subject, "", text, null, "",null, 0, null, "", "", "", "", null, "");
                AdminUsrRole.create(community, rv.toString(), "/327/", "/", 187, "/", "/");
                node.finished(teasession._nNode);

                Logs.create(teasession._strCommunity, rv, 1, teasession._nNode, request.getRemoteAddr());
                tea.entity.member.OnlineList ol_obj = OnlineList.find(session.getId());
                ol_obj.setMember(s1);
                session.setAttribute("tea.RV", rv);
                Cookie cs = new Cookie("tea.RV", s1);
                cs.setPath("/");
                String sn = request.getServerName();
                int j = sn.indexOf(".");
                if (j != -1 && !sn.equals("127.0.0.1") && !sn.startsWith("192.168."))
                {
                    cs.setDomain(sn.substring(j));
                }
                response.addCookie(cs);
                mem = s1;
                //新用户要信箱验证
                Profile profile = Profile.find(s1);
                BBS.send(teasession, profile);

            } else
            {
                node.setSequence(sequence);
                node.set(teasession._nLanguage, subject, text);
                node.setHidden(true);
                mem = teasession._rv.toString();
            }
            Company obj = Company.find(teasession._nNode);
            String s3 = teasession.getParameter("Address"); //企业地址
            int City2 = 0;
            if (teasession.getParameter("City2") != null && teasession.getParameter("City2").length() > 0)
            {
                City2 = Integer.parseInt(teasession.getParameter("City2"));
            }
            String s5 = teasession.getParameter("State");
            String s6 = teasession.getParameter("Zip"); //邮&nbsp;&nbsp;编
            String s10 = teasession.getParameter("WebPage"); //企业网址
            String s7 = teasession.getParameter("Country"); //网站说明
            String s = teasession.getParameter("Contact").trim(); //联系人
            String s8 = teasession.getParameter("Telephone"); //电&nbsp;&nbsp;话
            String s9 = teasession.getParameter("Fax"); //传&nbsp;&nbsp;真
            String email = teasession.getParameter("MemberId"); //teasession.getParameter("Email").trim(); //邮&nbsp;&nbsp;箱
            String map = teasession.getParameter("map"); //--暂无用到
            String eyp = teasession.getParameter("eyp"); //--暂无用到
            String s2 = teasession.getParameter("Organization"); //--暂无用到
            obj.set(teasession._nLanguage, s, email, s2, s3, City2, s5, s6, s7, s8, s9, s10, map, eyp);

            // boolean clear = teasession.getParameter("checkbox1") != null;//图片上传
            String checkbox1 = teasession.getParameter("checkbox1");

            byte by[] = teasession.getBytesParameter("license");
            if (checkbox1 != null && checkbox1.length() > 0)
            {
                obj.setLicense(null, teasession._nLanguage);
            } else if (by != null)
            {
                obj.setLicense(write(node.getCommunity(), by, ".gif"), teasession._nLanguage);
            } else
            {
                obj.setLicense(obj.getLicense(teasession._nLanguage), teasession._nLanguage);
            }
            Profile profile = Profile.find(mem);
            if ("user".equals(act)) //前台注册的用户
            {
                response.sendRedirect("/jsp/user/regsuccess.jsp?community=" + profile.getCommunity());
                return;
            } else
            {
                response.sendRedirect("/jsp/info/Succeed.jsp?info=" + java.net.URLEncoder.encode("创建成功请等待管理员审核", "UTF-8"));
                return;
            }
            // logo
//                clear = teasession.getParameter("logoClear") != null;
//                by = teasession.getBytesParameter("logo");
//                if (by != null)
//                {
//                    obj.setLogo(write(node.getCommunity(), by, ".gif"), teasession._nLanguage);
//                } else if (by == null && clear)
//                {
//                    obj.setLogo(null, teasession._nLanguage);
//                }
//                // Picture
//                clear = teasession.getParameter("pictureClear") != null;
//                by = teasession.getBytesParameter("picture");
//                if (by != null)
//                {
//                    obj.setPicture(write(node.getCommunity(), by, ".gif"), teasession._nLanguage);
//                } else if (by == null && clear)
//                {
//                    obj.setPicture(null, teasession._nLanguage);
//                }
//                try
//                {
//                    obj.setProperty(Integer.parseInt(teasession.getParameter("property")), teasession._nLanguage);
//                } catch (NumberFormatException ex2)
//                {
//                }
//                try
//                {
//                    obj.setSize(Integer.parseInt(teasession.getParameter("size")), teasession._nLanguage);
//                } catch (NumberFormatException ex2)
//                {
//                }
//                int calling = 0;
//                try
//                {
//                    calling = Integer.parseInt(teasession.getParameter("calling"));
//                } catch (NumberFormatException ex3)
//                {
//                }
//                obj.setCalling(calling, teasession._nLanguage);
//
//                StringBuilder modal = new StringBuilder("/");
//                for (int index = 0; index < Company.MODE_TYPE.length; index++)
//                {
//                    if (teasession.getParameter("mode" + index) != null)
//                    {
//                        modal.append(index + "/");
//                    }
//                }
//                obj.setMode(modal.toString(), teasession._nLanguage);
//
//                try
//                {
//                    obj.setEnrol(Integer.parseInt(teasession.getParameter("enrol")), teasession._nLanguage);
//                } catch (NumberFormatException ex3)
//                {
//                }
//
//                StringBuilder product = new StringBuilder();
//                for (int index = 0; index < 20; index++)
//                {
//                    String value = teasession.getParameter("product" + index);
//                    if (value != null && value.length() > 0)
//                    {
//                        product.append(value + ";");
//                    }
//                }
//                obj.setProduct(product.toString(), teasession._nLanguage);
//
//                obj.setEnroladd(teasession.getParameter("enroladd"), teasession._nLanguage);
//                obj.setFareadd(teasession.getParameter("fareadd"), teasession._nLanguage);
//                obj.setBirth(teasession.getParameter("birth"), teasession._nLanguage);
//                obj.setBrand(teasession.getParameter("brand"), teasession._nLanguage);
//                obj.setPrincipal(teasession.getParameter("principal"), teasession._nLanguage);
//                obj.setTurnover(teasession.getParameter("turnover"), teasession._nLanguage);
//                obj.setAgora(teasession.getParameter("p_z_Z_TradeRegion2"), teasession._nLanguage);
//                obj.setClient(teasession.getParameter("client"), teasession._nLanguage);
//                try
//                {
//                    obj.setExport(Integer.parseInt(teasession.getParameter("export")), teasession._nLanguage);
//                } catch (NumberFormatException ex3)
//                {
//                }
//                try
//                {
//                    obj.setImports(Integer.parseInt(teasession.getParameter("imports")), teasession._nLanguage);
//                } catch (NumberFormatException ex3)
//                {
//                }
//                obj.setAttestation(teasession.getParameter("p_z_Z_Certification2"), teasession._nLanguage);
//                obj.setBank(teasession.getParameter("bank"), teasession._nLanguage);
//                obj.setAccounts(teasession.getParameter("account"), teasession._nLanguage);
//                obj.setBranch(teasession.getParameter("branch"), teasession._nLanguage);
//                obj.setJob(teasession.getParameter("job"), teasession._nLanguage);
//                obj.setOem("y".equals(teasession.getParameter("oem")), teasession._nLanguage);
//                try
//                {
//                    obj.setDeveloper(Integer.parseInt(teasession.getParameter("developer")), teasession._nLanguage);
//                } catch (NumberFormatException ex3)
//                {
//                }
//                obj.setTurnout(teasession.getParameter("p_z_Z_ProductionCapacity") + teasession.getParameter("p_z_Z_ProductionUnit"), teasession._nLanguage);
//                obj.setAcreage(teasession.getParameter("acreage"), teasession._nLanguage);
//                obj.setMass(teasession.getParameter("mass"), teasession._nLanguage);
//                try
//                {
//                    obj.setSuperior(Integer.parseInt(teasession.getParameter("superior")), teasession._nLanguage);
//                } catch (NumberFormatException ex4)
//                {
//                    obj.setSuperior(0, teasession._nLanguage);
//                } catch (Exception ex4)
//                {
//                }
//                super.delete(node);
//                if (teasession.getParameter("GoBack") != null)
//                {
//                    response.sendRedirect("EditNode?node=" + teasession._nNode);
//                } else
//                {
//                    node.finished(teasession._nNode);
//
//                    if (nexturl == null)
//                    {
//                        nexturl = "/servlet/Node?node=" + teasession._nNode;
//                    }
//                  //  if (newnode && hidden)
//                  //  {
//                        response.sendRedirect("/jsp/info/Succeed.jsp?info=" + java.net.URLEncoder.encode("创建成功请等待管理员审核", "UTF-8") + "&nexturl=" + java.net.URLEncoder.encode(nexturl, "UTF-8"));
//                   // } else
//                    {
//                        response.sendRedirect(nexturl);
//                    }
//                }
        } catch(Exception ex)
{
  ex.printStackTrace();
  response.sendError(500,ex.toString());
}
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        // super.r.add("tea/ui/node/type/obj/Editobj");
    }
}
