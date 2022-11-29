package tea.ui.admin.sales;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.TeaServlet;
import tea.entity.admin.*;
import tea.entity.admin.sales.*;
import tea.entity.Http;
import tea.entity.RV;
import java.sql.SQLException;
import tea.entity.member.*;
import java.text.ParseException;

public class EditLatency extends TeaServlet
{

    // Initialize global variables
    public void init() throws ServletException
    {
    }

    // Process the HTTP Get request
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        tea.ui.TeaSession teasession = null;
        teasession = new tea.ui.TeaSession(request);
        try
        {

            String act = teasession.getParameter("act");

			if("sh".equals(act)){
				String nexturl = teasession.getParameter("nexturl");
				String lyid = teasession.getParameter("lyid");
				String audit = teasession.getParameter("audit");
				Latency lc = Latency.find(Integer.parseInt(lyid));
				lc.setAudit(Integer.parseInt(audit));
				Http h = new Http(request);
				if("1".equals(audit)){
					String memrole = teasession.getParameter("memrole");
					String guest = teasession.getParameter("guest");
					if(!"0".equals(memrole)){
//                        AdminUsrRole.create(teasession._strCommunity,lc.getEmail(),"/" + memrole + "/","/",0,null,null);
                        AdminUsrRole.create(teasession._strCommunity, h.member, "/"+memrole+"/", "/", 0, "/", "/");
                    }
					lc.setType(Integer.parseInt(guest));
					if("1".equals(guest)){
						String name = lc.getCorp();
						if(lc.getType()==2){
							name = lc.getEmail();
						}
                        int workproject = Workproject.create(teasession._strCommunity,lc.getEmail(),lc.getTelephone(),lc.getInc_fax(),"","",name,"",0,0,0,"","CN","","","","","CN","","","","");
                        Worklinkman.create(workproject,teasession._strCommunity,lc.getEmail(),lc.getSex()==0,null,"","","",lc.getHandset(),lc.getEmail(),"","","","","","","","",0,"","","","","","CN","","",lc.getCity(),"","CN","","","","","");
                        Profile p = Profile.find(lc.getEmail());
                        p.setFirstName(lc.getFirsts(),teasession._nLanguage);
                        p.setLastName(lc.getFamily(),teasession._nLanguage);
                        p.setSex(lc.getSex() == 0);
                        p.setTelephone(lc.getTelephone(),teasession._nLanguage);
                        p.setMobile(lc.getHandset());

					}
				}
				response.sendRedirect(nexturl);
				return;
			}
            if ("LatencyCompany".equals(act))
            {
                int latencytype = 0;
                if (teasession.getParameter("type") != null && teasession.getParameter("type").length() > 0)
                {
                    latencytype = Integer.parseInt(teasession.getParameter("type"));
                }
                String email = null;
                if (teasession.getParameter("email") != null && teasession.getParameter("email").length() > 0)
                {
                    email = teasession.getParameter("email");
                }
                String pwd = teasession.getParameter("pwd");
                int sex = 0;
                if (teasession.getParameter("sex") != null && teasession.getParameter("sex").length() > 0)
                {
                    sex = Integer.parseInt(teasession.getParameter("sex"));
                }
                String family = teasession.getParameter("family");

                String firsts = teasession.getParameter("firsts");
                String corp = teasession.getParameter("corp");
                int calling = 0;
                if (teasession.getParameter("calling") != null && teasession.getParameter("calling").length() > 0)
                {

                    calling = Integer.parseInt(teasession.getParameter("calling"));
                    System.out.print(calling);
                }
                int duty = 0;
                if (teasession.getParameter("duty") != null && teasession.getParameter("duty").length() > 0)
                {
                    duty = Integer.parseInt(teasession.getParameter("duty"));
                }
                String dept = teasession.getParameter("dept");
                String country = null;
                country = teasession.getParameter("country");
                int postalcode = 0;
                if (teasession.getParameter("postalcode") != null && teasession.getParameter("postalcode").length() > 0)
                {
                    postalcode = Integer.parseInt(teasession.getParameter("postalcode"));
                }

                String telephone = null;
                telephone = teasession.getParameter("telephone");
                String inc_fax = null;
                inc_fax = teasession.getParameter("inc_fax");
                String handset = null;
                if (teasession.getParameter("handset") != null && teasession.getParameter("handset").length() > 0)
                {

                    handset = teasession.getParameter("handset");
                }

                int province = 0;
                if (teasession.getParameter("province") != null && teasession.getParameter("province").length() > 0)
                {

                    province = Integer.parseInt(teasession.getParameter("province"));
                }

                String city = null;
                city = teasession.getParameter("city");
                if (email != null)
                {

                    boolean falg = Latency.EmailOption(email);
                    if (falg)
                    {

                        response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("此邮箱已经被注册过,请重新申请！", "UTF-8") + "&nexturl=/jsp/admin/sales/LatencyCompany.jsp?type=" + latencytype);
                        return;
                    } else
                    {
                        if (Profile.isExisted(email))
                        {
                            response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("提交失败，用户名已经存在或邮箱已经被注册过！", "UTF-8") + "&nexturl=/jsp/admin/sales/LatencyCompany.jsp?type=" + latencytype);
                            return;

                        } else
                        {
                            Latency.createTemp(latencytype, email, pwd, sex, family, firsts, corp, calling, duty, dept, country, postalcode, telephone, inc_fax, handset, province, city, teasession._strCommunity, teasession._rv);
                            String sn = request.getServerName() + ":" + request.getServerPort();
                            Profile.create(email, pwd, teasession._strCommunity, email, sn);
                            response.sendRedirect("/jsp/info/NewSucceed.jsp?info=" + java.net.URLEncoder.encode("注册成功！", "UTF-8"));
                            return;
                        }
                    }
                } else
                {
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("提交失败，请重新填写用户信息！", "UTF-8") + "&nexturl=/jsp/admin/sales/LatencyCompany.jsp?type=" + latencytype);
                    return;
                }
            }
            if ("import".equals(act))
            {

                int _nMember = Integer.parseInt(teasession.getParameter("member"));
                int _nFamily = Integer.parseInt(teasession.getParameter("family"));
                int _nFirsts = Integer.parseInt(teasession.getParameter("firsts"));
                int _nTelephone = Integer.parseInt(teasession.getParameter("telephone"));
                int _nEmail = Integer.parseInt(teasession.getParameter("email"));
                int _nCorp = Integer.parseInt(teasession.getParameter("corp"));
                int _nGrade = Integer.parseInt(teasession.getParameter("grade"));
                int _nDuty = Integer.parseInt(teasession.getParameter("duty"));
                int _nCountry = Integer.parseInt(teasession.getParameter("country"));
                int _nPostalcode = Integer.parseInt(teasession.getParameter("postalcode"));
                int _nProvince = Integer.parseInt(teasession.getParameter("province"));
                int _nCity = Integer.parseInt(teasession.getParameter("city"));
                int _nStreet = Integer.parseInt(teasession.getParameter("street"));
                int _nWebaddress = Integer.parseInt(teasession.getParameter("webaddress"));
                int _nCounts = Integer.parseInt(teasession.getParameter("counts"));
                int _nOrigin = Integer.parseInt(teasession.getParameter("origin"));
                int _nIncome = Integer.parseInt(teasession.getParameter("income"));
                int _nCalling = Integer.parseInt(teasession.getParameter("calling"));
                int _nRemark = Integer.parseInt(teasession.getParameter("remark"));

                // int _nName = Integer.parseInt(teasession.getParameter("name"));
                // int _nTel = Integer.parseInt(teasession.getParameter("tel"));

                String identity = teasession.getParameter("identity");
                int laid = 0;
                String file = teasession.getParameter("file");
                String rows[] = file.split("\n");
                for (int i = 1; i < rows.length; i++)
                {
                    String cols[] = rows[i].replaceAll(",,", " , ,").split(",");
                    // String name = null;
                    // if(_nName !=-1)
                    // {
                    // name = cols[_nName];
                    // }
                    // String tel=null;
                    // if(_nTel !=-1)
                    // {
                    // tel = cols[_nTel];
                    // }

                    String member = teasession._rv.toString();
                    if (_nMember != -1)
                    {
                        member = cols[_nMember];
                    }
                    String family = null;
                    if (_nFamily != -1)
                    {
                        family = cols[_nFamily];
                    }
                    String firsts = null;
                    if (_nFirsts != -1)
                    {
                        firsts = cols[_nFirsts];
                    }
                    String telephone = null;
                    if (_nTelephone != -1)
                    {
                        telephone = cols[_nTelephone];
                    }
                    String email = null;
                    if (_nEmail != -1)
                    {
                        email = cols[_nEmail];
                    }
                    String corp = null;
                    if (_nCorp != -1)
                    {
                        corp = cols[_nCorp];
                    }
                    int grade = 0;

                    int duty = 0;
                    if (_nDuty != -1)
                    {
                        try
                        {
                            duty = Integer.parseInt(cols[_nDuty]);
                        } catch (Exception ex)
                        {}
                    }

                    String country = null;
                    if (_nCountry != -1)
                    {
                        country = cols[_nCountry];
                    }
                    int postalcode = 0;
                    if (_nPostalcode != -1)
                    {
                        try
                        {
                            postalcode = Integer.parseInt(cols[_nPostalcode]);
                        } catch (Exception ex)
                        {
                        }
                    }

                    int province = 0;
                    if (_nProvince != -1)
                    {
                        try
                        {
                            province = Integer.parseInt(cols[_nProvince]);
                        } catch (Exception ex)
                        {}
                    }

                    String city = null;
                    if (_nCity != -1)
                    {
                        city = cols[_nCity];
                    }
                    String street = null;
                    if (_nStreet != -1)
                    {
                        street = cols[_nStreet];
                    }
                    String webaddress = null;
                    if (_nWebaddress != -1)
                    {
                        webaddress = cols[_nWebaddress];
                    }
                    int counts = 0;
                    if (_nCounts != -1)
                    {
                        try
                        {
                            counts = Integer.parseInt(cols[_nCounts]);
                        } catch (Exception ex)
                        {}

                    }
                    int origin = 0;

                    int income = 0;
                    if (_nIncome != -1)
                    {
                        try
                        {
                            income = Integer.parseInt(cols[_nIncome]);
                        } catch (Exception ex)
                        {}
                    }
                    int calling = 0;
                    if (_nCalling != -1)
                    {
                        try
                        {
                            calling = Integer.parseInt(cols[_nCalling]);
                        } catch (Exception ex)
                        {}
                    }
                    String remark = null;
                    if (_nRemark != -1)
                    {
                        remark = cols[_nRemark];
                    }
                    int states = 0;
                    if ("name".equals(identity))
                    {
                        laid = Latency.findByName(teasession._strCommunity, member);
                    } else
                    {
                        laid = Latency.findByTel(teasession._strCommunity, telephone);
                    }
                    String holder = null;
                    if (laid < 1)
                    {
                        //  create( holder,  states,  family,  firsts,  telephone,  email,  corp,  grade,  duty,  country,  postalcode,  province,  city,  street,  webaddress,  counts,  origin,  income,  calling,  remark,  community, RV _rv)
                        Latency.create(holder, states, family, firsts, telephone, email, corp, grade, duty, country, postalcode, province, city, street, webaddress, counts, origin, income, calling, remark, teasession._strCommunity, teasession._rv);
                    } else
                    {
                        Latency laobj = Latency.find(laid);
                        laobj.set(holder, states, family, firsts, telephone, email, corp, grade, duty, country, postalcode, province, city, street, webaddress, counts, origin, income, calling,
                                  remark, teasession._strCommunity, teasession._rv);

                    }
                }
                response.sendRedirect("/jsp/info/Succeed.jsp?community=" + teasession._strCommunity);
            } else
            {
                int states = 0;
                if (teasession.getParameter("states") != null && teasession.getParameter("states").length() > 0)
                {
                    states = Integer.parseInt(teasession.getParameter("states"));
                }
                if (states == 4)
                {
                    int workproject = 0;

                    String email = teasession.getParameter("email");
                    String telephone = request.getParameter("telephone");
                    int calling = 0;
                    if (request.getParameter("calling") != null && request.getParameter("calling").length() > 0)
                    {
                        calling = Integer.parseInt(request.getParameter("calling"));
                    }
                    String corp = teasession.getParameter("corp");

                    Workproject.createOne(teasession._strCommunity, teasession._rv.toString(), email, telephone, calling, corp);

                }
                int laid = 0;
                String holder = null; // 暂没有用到
                if (request.getParameter("laid") != null && request.getParameter("laid").length() > 0)
                {
                    laid = Integer.parseInt(request.getParameter("laid"));
                }

                String family = teasession.getParameter("family");
                String firsts = teasession.getParameter("firsts");
                String telephone = request.getParameter("telephone");

                String email = teasession.getParameter("email");
                String corp = teasession.getParameter("corp");
                int grade = 0;
                if (request.getParameter("grade") != null && request.getParameter("grade").length() > 0)
                {
                    grade = Integer.parseInt(request.getParameter("grade"));
                }
                int duty = 0;
                if (teasession.getParameter("duty") != null && teasession.getParameter("duty").length() > 0)
                {

                    duty = Integer.parseInt(teasession.getParameter("duty"));
                }

                String country = request.getParameter("country");
                int postalcode = 0;
                if (request.getParameter("postalcode") != null && request.getParameter("postalcode").length() > 0)
                {
                    postalcode = Integer.parseInt(request.getParameter("postalcode"));
                }
                int province = 0;
                if (teasession.getParameter("province") != null && teasession.getParameter("province").length() > 0)
                {

                    province = Integer.parseInt(teasession.getParameter("province"));
                }
                String city = request.getParameter("city");
                String street = request.getParameter("street");
                String webaddress = request.getParameter("webaddress");
                int counts = 0;
                if (request.getParameter("counts") != null && request.getParameter("counts").length() > 0)
                {
                    counts = Integer.parseInt(request.getParameter("counts"));
                }
                int origin = 0;
                if (request.getParameter("origin") != null && request.getParameter("origin").length() > 0)
                {
                    origin = Integer.parseInt(request.getParameter("origin"));
                }
                int income = 0;
                if (request.getParameter("income") != null && request.getParameter("income").length() > 0)
                {
                    income = Integer.parseInt(request.getParameter("income"));
                }
                int calling = 0;
                if (request.getParameter("calling") != null && request.getParameter("calling").length() > 0)
                {
                    calling = Integer.parseInt(request.getParameter("calling"));
                }
                String remark = request.getParameter("remark");
                int latencytype = 0;
                if (teasession.getParameter("latencytype") != null && teasession.getParameter("latencytype").length() > 0)
                {
                    latencytype = Integer.parseInt(teasession.getParameter("latencytype"));
                }
				  Latency laobj = Latency.find(laid);
                if (laid > 0)
                {

                    laobj.set(holder, states, family, firsts, telephone, email, corp, grade, duty, country, postalcode, province, city, street, webaddress, counts, origin, income, calling, remark,
                              teasession._strCommunity, teasession._rv);
					laobj.setType(0);
                } else
                {
                  laid=   Latency.create(holder, states, family, firsts, telephone, email, corp, grade, duty, country, postalcode, province, city, street, webaddress, counts, origin, income, calling,
                                   remark, teasession._strCommunity, teasession._rv);
				  Latency laobj2 = Latency.find(laid);
				  laobj2.setType(0);
                }

				if("升级成客户".equals(teasession.getParameter("submit1")))//升级成为客户
				{
					laobj.setType(1);
					int wid = Workproject.create(teasession._strCommunity,teasession._rv.toString(),telephone,null,webaddress,email,corp,remark,0,0,calling,null,null,String.valueOf(postalcode),null,null,null,null,null,null,null,null);
			        Workproject wobj = Workproject.find(wid);
					wobj.setLaid(laid);

				}



                response.sendRedirect("/jsp/admin/sales/latency.jsp");
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
