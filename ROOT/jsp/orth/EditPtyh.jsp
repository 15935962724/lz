<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.entity.bpicture.*" %>
<%@ page import="tea.entity.admin.mov.*"%>
<%@ page import="tea.entity.admin.orthonline.*"%>
<%@ page import="tea.entity.member.*"%>
<%@ page import="tea.entity.*"%>
<%@ page import="java.util.Date"%>
<%
 request.setCharacterEncoding("UTF-8");
				response.setContentType("text/html;charset=UTF-8");
                TeaSession teasession = new TeaSession(request);

               
                String act = teasession.getParameter("act");
                String nexturl = request.getParameter("nexturl");
                
                 int membertype = 0;
                    if(teasession.getParameter("membertype") != null && teasession.getParameter("membertype").length() > 0)
                    {
                        membertype = Integer.parseInt(teasession.getParameter("membertype"));
                    }

                    int membertype_jy = 0;
                    if(teasession.getParameter("membertype_jy") != null && teasession.getParameter("membertype_jy").length() > 0)
                    {
                        membertype_jy = Integer.parseInt(teasession.getParameter("membertype_jy"));
                    }

                 MemberType myobj =MemberType.find(membertype);
                 RegisterInstall riobj = RegisterInstall.find(membertype);
				 //注册页面 添加信息后 处理程序
               
					 //用户名判断 q
                     String MemberId = teasession.getParameter("MemberId");
                     if(Profile.isExisted(MemberId)&&teasession._rv==null)
                     {
                         response.sendRedirect("/jsp/info/Alert.jsp?community=" + teasession._strCommunity + "&info=" + java.net.URLEncoder.encode("用户名"+MemberId+"已经存在，请重新填写! <a href=\"javascript:history.back();\">重试</a>","UTF-8"));
                         return;
                     }
                    String EnterPassword = teasession.getParameter("EnterPassword");
                     String email = teasession.getParameter("email");
                     String firstname = teasession.getParameter("firstname");
                     boolean sex = true;
					 if("0".equals(teasession.getParameter("sex")))
					 {
					   sex = false;
					 }
                     String card = teasession.getParameter("card");

                     java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
                      Date birthyear =null;
                     if(request.getParameter("BirthYear")!=null && request.getParameter("BirthYear").length()>0)
                     {
                          birthyear = sdf.parse(request.getParameter("BirthYear") + "-" + request.getParameter("BirthMonth") + "-" + request.getParameter("BirthDay"));
                     }



                     String state = teasession.getParameter("State");
                     String city = teasession.getParameter("City");
                     String address = teasession.getParameter("address");
                     String phonenumber = teasession.getParameter("phonenumber");
                    
                     String zip = teasession.getParameter("zip");
                     String telephone = teasession.getParameter("telephone");
                     String fax = teasession.getParameter("fax");
					 //职称
					 String  position =  teasession.getParameter("position");//getp_strTitle
					 //单位
					 String organization= teasession.getParameter("organization");
					 //科室 部门
					 String section = teasession.getParameter("section");
					 //学历
					 String degree = teasession.getParameter("degree");

                     Profile p = Profile.find(MemberId);
                  
					 p.setPassword(EnterPassword);
					 p.setEmail(email);
					 p.setBirth(birthyear);
					 p.setFirstName(firstname,teasession._nLanguage);
					 p.setAddress(address,teasession._nLanguage);
					 p.setCity(city,teasession._nLanguage);
					 p.setZip(zip,teasession._nLanguage);
					 p.setTelephone(telephone,teasession._nLanguage);
					 p.setFax(fax,teasession._nLanguage);
					 p.setMobile(phonenumber);
                     p.setCard(card);
                     p.setSex(sex);
					 p.setTitle(position,teasession._nLanguage);
					 p.setOrganization(organization,teasession._nLanguage);
					 p.setSection(section,teasession._nLanguage);
					 p.setDegree(degree,teasession._nLanguage);

					nexturl ="/jsp/orth/ptyh.jsp";
                      response.sendRedirect(nexturl);
        
%>

