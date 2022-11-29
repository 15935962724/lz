package tea.ui.node.type.resume;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.entity.node.*;
import tea.ui.*;
import tea.entity.member.*;

public class EditResume extends TeaServlet
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
                response.sendRedirect(request.getContextPath() + "/servlet/StartLogin?node=" + teasession._nNode + "&NextUrl=" + request.getRequestURI() + "?" + request.getQueryString());
                return;
            }
            String action = teasession.getParameter("action");
            if (request.getMethod().equals("GET"))
            {
                response.sendRedirect(request.getContextPath() + "/jsp/type/resume/EditResume.jsp?" + request.getQueryString());
            } else if ("editresumeother".equals(action))
            {
                Node node = Node.find(teasession._nNode);
                if (!node.isCreator(teasession._rv))
                {
                    response.sendError(403);
                    return;
                }
                String selfvalue = teasession.getParameter("selfvalue");
                if (selfvalue.length() > 200)
                {
                    selfvalue = selfvalue.substring(0, 200);
                }
                String selfaim = teasession.getParameter("selfaim");
                if (selfaim.length() > 500)
                {
                    selfaim = selfvalue.substring(0, 500);
                }
                String other = teasession.getParameter("other");
                if (other.length() > 200)
                {
                    other = other.substring(0, 200);
                }
                Resume obj = Resume.find(teasession._nNode, teasession._nLanguage);
                obj.set(selfvalue, selfaim, other);
            } else
            {
                Node node = Node.find(teasession._nNode);

                String subject = teasession.getParameter("subject");
                boolean newnode = teasession.getParameter("NewNode") != null;
                //自我评价
                String selfvalue = teasession.getParameter("selfvalue");
                //职业目标
                String selfaim = teasession.getParameter("selfaim");
                //语言1 2
                String sprsl = teasession.getParameter("sprsl");
                String ztlnl = teasession.getParameter("ztlnl");

                String sprs2 = teasession.getParameter("sprs2");
                 String ztln2 = teasession.getParameter("ztln2");



                if (selfvalue.length() > 200)
                {
                    selfvalue = selfvalue.substring(0, 200);
                }
                if (selfaim.length() > 200)
                {
                	selfaim = selfaim.substring(0, 200);
                }
                if (newnode)
                {
                    int sequence = Node.getMaxSequence(teasession._nNode) + 10;
                    int options = 0, options1 = 0;
                    int typealias = 0;
                    String community = teasession._strCommunity;
                    try
                    {
                        typealias = Integer.parseInt(teasession.getParameter("TypeAlias"));
                    } catch (Exception exception1)
                    {
                    }
                    Category cat = Category.find(teasession._nNode);
                    if(cat.getCategory()!=52){
                    	cat.set(52, 0, cat.getTemplate());
                    }
					teasession._nNode = Node.create(teasession._nNode,sequence,community,teasession._rv,cat.getCategory(),false,options,options1,node.getDefaultLanguage(),null,null,new Date(),0,0,0,0,null,teasession._nLanguage,subject,"","",null,"",null,0,null,"","","","","","");

                    // node = Node.find(teasession._nNode);

                    Resume obj = Resume.find(teasession._nNode, teasession._nLanguage);//自我评价
                    obj.set(selfvalue, selfaim, null);

                    Lang.create(teasession._nNode,teasession._nLanguage,sprsl,ztlnl,null,null,null,null,null);
                    Lang.create(teasession._nNode,teasession._nLanguage,sprs2,ztln2,null,null,null,null,null);

                } else
                {
                    AccessMember obj_am = AccessMember.find(node._nNode, teasession._rv._strV);
                    if (!node.isCreator(teasession._rv) && obj_am.getPurview() < 2)
                    {
                        response.sendError(403);
                        return;
                    }
                    if(node.getType()!=52){
                    	Node fnode=Node.find(node.getFather());
                    	fnode.setType(52);
                    }
                    node.setSubject(subject, teasession._nLanguage);
                }
                // 基本信息
                Profile profile = Profile.find(teasession._rv._strR);
                String firstname = teasession.getParameter("firstname");

                boolean sex = "true".equals(teasession.getParameter("sex"));
                String email = teasession.getParameter("email");
                String mobile = teasession.getParameter("mobile");
                String telephone = teasession.getParameter("telephone");
                java.util.Date birth = Node.sdf.parse(teasession.getParameter("birthYear") + "-" + teasession.getParameter("birthMonth") + "-" + teasession.getParameter("birthDay"));
                String nationality = teasession.getParameter("nationality");
                String gblnd = teasession.getParameter("gblnd");
                String gbort = teasession.getParameter("gbort");

                int famst = 0;
                if(teasession.getParameter("famst")!=null && teasession.getParameter("famst").length()>0)
                    famst = Integer.parseInt(teasession.getParameter("famst"));
               // java.util.Date famdt = Node.sdf.parse(teasession.getParameter("famdtYear") + "-" + teasession.getParameter("famdtMonth") + "-" + teasession.getParameter("famdtDay"));
                //int anzkd = Integer.parseInt(teasession.getParameter("anzkd"));
                String zzhkszd = teasession.getParameter("zzhkszd");
                boolean zzgatwj = "true".equals(teasession.getParameter("zzgatwj"));
                boolean zznyhk = "true".equals(teasession.getParameter("zznyhk"));
                //String zzpridn = teasession.getParameter("zzpridn");
                //String zzfmbkg = teasession.getParameter("zzfmbkg");
                String address = teasession.getParameter("address");
                String zip = teasession.getParameter("zip");
                String degree = teasession.getParameter("degree");
                String school = teasession.getParameter("school");
                int age = (int) (System.currentTimeMillis() - birth.getTime()) / (1000 * 60 * 60 * 24 * 30 * 12);
                if (teasession.getParameter("clear") != null)
                {
                    profile.setPhotopath(null, teasession._nLanguage); // 清空照片
                } else
                {
                    byte by[] = teasession.getBytesParameter("photo");
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
                }
                profile.setFirstName(firstname, teasession._nLanguage);
                profile.setLastName("", teasession._nLanguage);
                profile.setSex(sex);
                profile.setEmail(email);
                profile.setMobile(mobile);
                profile.setTelephone(telephone, teasession._nLanguage);
                profile.setBirth(birth);
                profile.setCountry(nationality, teasession._nLanguage); // profile.setState(nationality, teasession._nLanguage);
                profile.setGblnd(gblnd, teasession._nLanguage);
                profile.setGbort(gbort, teasession._nLanguage);
                profile.setFamst(famst);
               // profile.setFamdt(famdt);
                profile.setAnzkd(0);
                profile.setZzhkszd(zzhkszd, teasession._nLanguage);
                profile.setZzgatwj(zzgatwj);
                profile.setZznyhk(zznyhk);
                profile.setZzpridn("");
                profile.setZzfmbkg("");
                profile.setAddress(address, teasession._nLanguage);
                profile.setZip(zip, teasession._nLanguage);
                profile.setDegree(degree, teasession._nLanguage);
                profile.setSchool(school, teasession._nLanguage);
                profile.setBirth(birth);

                // //////////////职业概况/求职意向/////////////////////////////////
//                String joinu = teasession.getParameter("joinu");
//                String intr1 = teasession.getParameter("intr1");
//                String intr2 = teasession.getParameter("intr2");
//                String intr3 = teasession.getParameter("intr3");
                String nowmaincareer = teasession.getParameter("nowmaincareer");
                String zxrgs = teasession.getParameter("zxrgs");
                String nowcareerlevel = teasession.getParameter("nowcareerlevel");
                int experience = Integer.parseInt(teasession.getParameter("experience"));
                boolean has_abroad = "true".equals(teasession.getParameter("has_abroad"));
                java.math.BigDecimal salarysum = null;//new java.math.BigDecimal(teasession.getParameter("salarysum"));
                //String zwaers_yx = teasession.getParameter("zwaers_yx");
                int zqwgz = Integer.parseInt(teasession.getParameter("zqwgz"));
                String expectcareer = teasession.getParameter("expectcareer_value");
                String expectcity = teasession.getParameter("expectcity_value");
                java.math.BigDecimal expectsalarysum = new java.math.BigDecimal(teasession.getParameter("expectsalarysum"));
                String zwaers_qwyx = teasession.getParameter("zwaers_qwyx");
                int joindatetype = Integer.parseInt(teasession.getParameter("joindatetype"));
                Resume obj = Resume.find(teasession._nNode, teasession._nLanguage);
                obj.set("", "", "", "", nowmaincareer, zxrgs, nowcareerlevel, experience, has_abroad, salarysum, "", zqwgz, expectcareer, expectcity, expectsalarysum, zwaers_qwyx, joindatetype);

                // delete(node);
                node.finished(teasession._nNode);
                //自我评价
                Resume obj2 = Resume.find(teasession._nNode, teasession._nLanguage);
                obj2.set(selfvalue, selfaim, null);
                //语言
                java.util.Enumeration e = Lang.find(teasession._nNode,teasession._nLanguage);
                int lan [] = new int[2];
                for(int i =0;e.hasMoreElements();i++)
                {
                    int l = ((Integer)e.nextElement()).intValue();
                    lan[i] = l;
                }
                Lang l = Lang.find(lan[0]);
                Lang l2 = Lang.find(lan[1]);
                l.set(sprsl, ztlnl, null, null, null, null, null);
                l2.set(sprs2, ztln2, null, null, null, null, null);
            }



            String nexturl = teasession.getParameter("nexturl") + "&Node=" + teasession._nNode;
           // System.out.println("*************"+nexturl);
            if (teasession.getParameter("educate") != null)
            {
                response.sendRedirect(request.getContextPath() + "/jsp/type/resume/EditResume2.jsp?node=" + teasession._nNode + "&nexturl=" + java.net.URLEncoder.encode(nexturl, "UTF-8"));
            } else if (teasession.getParameter("inhabit") != null)
            {
                response.sendRedirect(request.getContextPath() + "/jsp/type/resume/EditInhabit.jsp?node=" + teasession._nNode + "&nexturl=" + java.net.URLEncoder.encode(nexturl, "UTF-8"));
            } else if (teasession.getParameter("employment") != null)
            {
                response.sendRedirect(request.getContextPath() + "/jsp/type/resume/EditEmployment.jsp?node=" + teasession._nNode + "&nexturl=" + java.net.URLEncoder.encode(nexturl, "UTF-8"));
            } else
            {
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
                    response.sendRedirect("Node?Edit=ON&Node=" + teasession._nNode);
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
