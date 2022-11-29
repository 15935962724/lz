package tea.ui.admin;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.ui.*;
import tea.entity.*;
import javax.servlet.*;
import javax.servlet.http.*;

import tea.entity.site.Communityintegral;
import tea.entity.sup.*;
import tea.entity.admin.SupAgent;
import tea.entity.admin.SupSupplier;
import tea.entity.member.*;
import tea.entity.westrac.WestracIntegralLog;

public class SupSuppliers extends HttpServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request,response);
        String act = h.get("act"),nexturl = h.get("nexturl","");
        ServletContext application = this.getServletContext();
        HttpSession session = request.getSession(true);
        PrintWriter out = response.getWriter();
        try
        {
            if(act == null)
                return;
            if(act.startsWith("check"))
            {
                String tmp = h.get("q");
                if("check_name".equals(act))
                {
                    //out.print(SubContractor.count(" AND name=" + DbAdapter.cite(tmp)) < 1);
                } else if("check_license".equals(act))
                {
                    //out.print(SubContractor.count(" AND license=" + DbAdapter.cite(tmp)) < 1);
                    out.print("true");
                }
                return;
            }
            out.println("<script>var mt=parent.mt;</script>");
            if("reg".equals(act)) //承包商_注册
            {   
            	String sname = "verify";
                if(!h.get("verify").equalsIgnoreCase((String) session.getAttribute(sname)))
                {
                    out.print("<script>mt.show('抱歉“验证码”不正确！');</script>");
                    return;
                }
                session.removeAttribute(sname);
                String username = h.get("username");
                if(Profile.isExisted(username))
                {
                    out.print("<script>mt.show('用户名“" + username + "”已经被注册过了！');</script>");
                    return;
                }
                String name = h.get("name");
                if(SupSupplier.count(" AND deleted=0 AND name=" + DbAdapter.cite(name)) > 1)
                {
                    out.print("<script>mt.show('单位名称“" + name + "”已经被注册过了！');</script>");
                    return;
                }/*
                if(!username.equals(name))
                {
                    out.print("<script>mt.show('用户名必须和企业名称完全一致！');</script>");
                    return;
                }*/
                String license = h.get("license");
                if(SupSupplier.count(" AND deleted=0 AND license=" + DbAdapter.cite(license)) > 1)
                {
                    out.print("<script>mt.show('营业执照编号“" + license + "”已经被注册过了！');</script>");
                    return;
                }
                //username += "_" + System.currentTimeMillis();
                String email = h.get("email");
                //String suptype = h.get("suptype");
                int qtype = h.getInt("qtype");
                //Profile p = Profile.create(username,h.get("password"),h.community,email,request.getServerName());
             
                //Profile p = Profile.createqi(username,h.get("password"),h.community,email,h.get("tel"),request.getServerName());
                Profile p = Profile.createqi(username,h.get("password"),h.community,email,h.get("tel"),request.getServerName());
                SupSupplier t = new SupSupplier(p.getProfile());
                t.name = name;
                t.license = license;
                t.type = h.get("type","|");
                //t.city = h.getInt("city1",h.getInt("city0"));
                t.legalname = h.get("legalperson");
                t.deleted = false;
                t.set();
                SupAgent sa = new SupAgent(0);
                sa.supplier = t.supplier;
                sa.name = h.get("mname");
                sa.tel = h.get("tel");
                sa.email = email;
                sa.time = new Date();
                sa.set();
                //
                p.setType(3);
                //p.set("recycle",String.valueOf(p.recycle = 1));
                Communityintegral cobj = Communityintegral.find(h.community);
                
                p.setMyintegral(cobj.getRegpoint());
                WestracIntegralLog.create(username, 2, null, 0, cobj.getRegpoint(), "注册获得", new Date(), 0, h.community);
                p.setOrganization(t.name,h.language);
                p.setCode(license);
                p.setFirstName(sa.name,h.language);
                //String mobile = h.get("mobile");
                //p.setMobile(mobile);
                /*Communityintegral ci=Communityintegral.find(h.community);
                p.setMyintegral(ci.getRegpoint());*/
                p.setTelephone(t.tel,h.language);
                p.setMembertype(1);
                p.setSex(false);
                session.setAttribute("tea.RV",new RV(username));
                session.setAttribute("member",p.getProfile());
                out.print("<script>parent.parent.location.replace('" + nexturl + "');</script>");
                return;
            } else if("verify".equals(act))
            {   
            	if(!h.get("verify").equalsIgnoreCase((String)session.getAttribute("sms.vertify")))
                {
                out.print("<script>mt.show('验证码不正确。')</script>");
                return;
                }
               
            } else if("verify1".equals(act))
            {
                int member = h.getInt("member");
                String tmp = h.get("mobile");
                if(tmp != null)
                {
                    if(Profile.count(" AND community=" + DbAdapter.cite(h.community) + " AND recycle=0 AND mobile=" + DbAdapter.cite(tmp)) > 0)
                    {
                        out.print("<script>mt.show('抱歉，该手机号已被注册过了！');</script>");
                        return;
                    }
                    Profile p = Profile.find(member);
                    p.setMobile(tmp);
                } else //重新发送
                {

                }
                String verify = String.valueOf((int) (Math.random() * 100000000)).substring(0,6);
                session.setAttribute("verify",verify);
                //SMessage.send(h.community,1,"|" + member + "|","|","欢迎使用中国水电集中采购电子商务平台服务，请在页面输入验证码：" + verify,new CharArrayWriter());
                out.print("<script>mt.show('/jsp/sup/SupRegVerify2.jsp?member=" + member + "',1,'短信获取验证码',380,240);</script>");
                return;
            }/* else if("verify2".equals(act))
            {
                int member = h.getInt("member");
                String verify = h.get("verify");
                if(!verify.equals((String) session.getAttribute("verify")))
                {
                    out.print("<script>alert('“验证码”不正确！');</script>");
                    return;
                }
                session.removeAttribute("verify");
                Profile p = Profile.find(member);
                String old = p.getMember();
                String username = old.substring(0,old.lastIndexOf('_'));
                DbAdapter db = new DbAdapter();
                try
                {
                    db.executeUpdate("UPDATE Profile      SET member=" + DbAdapter.cite(username) + ",recycle=0,valid=1 WHERE member=" + DbAdapter.cite(old));
                    db.executeUpdate("UPDATE ProfileLayer SET member=" + DbAdapter.cite(username) + "                   WHERE member=" + DbAdapter.cite(old));
                } finally
                {
                    db.close();
                }
                SupSupplier t = new SupSupplier(member);
                t.deleted = false;
                t.set("deleted","0");
                //
                session.setAttribute("member",member);
                Cookie cs = new Cookie("member",MT.enc(member + "|" + p.getPassword()));
                cs.setPath("/");
                response.addCookie(cs);

                out.print("<script>parent.location='" + nexturl + "';</script>");
                SupSupplier.cache();
                return;
            }*/
            /*if("upload".equals(act))
            {
                if(h.member < 1)
                    IR.info(request);
                //证件
                for(int i = 0;i < 50;i++)
                {
                    int battch = h.getInt("cerpicture" + i + ".attch");
                    if(battch > 0)
                    {
                        out.print(Http.enc(Attch.find(battch).toString3()));
                        return;
                    }
                }
                String[] arr =
                        {"picture","legalcopy","agentcopy0","agentcopy1","agentcopy2","agentauth0","agentauth1","agentauth2"};
                for(int i = 0;i < arr.length;i++)
                {
                    int battch = h.getInt(arr[i] + ".attch");
                    if(battch > 0)
                    {
                        out.print(Http.enc(Attch.find(battch).toString3()));
                        return;
                    }
                }
            }*/
            if(h.member < 1)
            {
                out.print("<script>top.location.replace('/servlet/StartLogin?node=" + h.node + "');</script>");
                return;
            }
            String info = "操作执行成功！";
            Profile m = Profile.find(h.member);
            int supplier = h.getInt("supplier",m.getProfile());
            SupSupplier t = SupSupplier.find(supplier);
            if("medit".equals(act))
            {
                String mname = h.get("mname");
                String tel = h.get("tel");
                String email = h.get("email");
                m.setFirstName(mname,h.language);
                m.setSex(h.getBool("sex"));
                /*m.set("city",String.valueOf(m.city = h.getInt("city1",h.getInt("city0"))));*/
                m.setJob(h.get("job"),h.language);
                m.setMobile(h.get("mobile"));
                m.setTelephone(tel,h.language);
                m.setEmail(email);
                /*m.setQQ(h.get("qq"));
                m.setPhotopath2(h.get("avatar"),h.language);*/
                if(m.getType() == 3) //供应商
                {
                    //t.agentname[0] = mname;
                    //t.agenttel[0] = tel;
                    //t.agentemail[0] = email;
                    //t.set();
                }
            } else if(act.startsWith("e_"))
            {
                if("e_content".equals(act))
                {
                    String tmp = h.get("content");
                    tmp = tmp.replaceAll("<script[^>]*>","&lt;script>");
                    tmp = tmp.replaceAll("<style[^>]*>","&lt;style>");
                    //tmp = Pattern.compile("<script[^>]*>[\\s\\S]*</script>").matcher(tmp).replaceAll("");
                    if(tmp.length() < 200)
                    {
                        out.print("<script>mt.show('“企业简介”至少要200字！');</script>");
                        return;
                    }
                    t.content = tmp;
                    t.picture = h.getInt("picture");
                    t.contentvisible = h.getBool("contentvisible");
                } else if("e_base".equals(act))
                {
                    Profile profile2=Profile.find(t.supplier);
                	String code=profile2.getCode();
				    String name= Profile.getMember(code);
                    String name2 = h.get("name");
                    if(SupSupplier.count(" AND supplier!="+t.supplier+" AND name="+DbAdapter.cite(name2))>0){
                    	 out.print("<script>mt.show('“" + name2 + "”企业已存在！',1,'frm2.name.focus()');</script>");
                         return;
                    }
                    t.type = h.get("type","|");
                    t.propertys = h.getInt("propertys");
                    t.name= name2;
                    t.ename = h.get("ename");
                    t.settlement = h.get("settlement");
                    t.governing = h.get("governing");
                    //t.position = h.getInt("position");
                    t.ctime = h.getDate("ctime");
                    t.country = h.getInt("country");
                    t.city = h.getInt("city2");
                    if(t.city < 1)
                        t.city = h.getInt("city1");
                    if(t.city < 1)
                        t.city = h.getInt("city0");
                    t.address = h.get("address");
                    t.zip = h.get("zip");
                    t.tel = h.get("tel");
                    t.fax = h.get("fax");
                    t.email = h.get("email");
                    t.website = h.get("website");
                    t.personvisible = h.getBool("personvisible");
                    t.capital = h.getFloat("capital");
                    t.currency = h.get("currency");
                    t.legalname = h.get("legalname");
                    t.legalidcard = h.get("legalidcard");
                    t.legalcopy = h.getInt("legalcopy");
                    t.former = h.get("former");
                    t.subordinate = h.get("subordinate");
                    //
                    String[] agent = h.getValues("agent");
                    String[] agentname = h.getValues("agentname");
                    String[] agentidcard = h.getValues("agentidcard");
                    String[] agentmobile = h.getValues("agentmobile");
                    String[] agentemail = h.getValues("agentemail");
                    for(int i = 0;i < agent.length;i++)
                    {
                        SupAgent sa = SupAgent.find(Integer.parseInt(agent[i]));
                        sa.supplier = t.supplier;
                        sa.name = agentname[i];
                        sa.idcard = agentidcard[i];
                        sa.mobile = agentmobile[i];
                        sa.email = agentemail[i];
                        sa.copy = h.getInt("agentcopy" + i);
                        sa.auth = h.getInt("agentauth" + i);
                        sa.time = new Date();
                        sa.set();
                    }
                    //
                    //m = Profile.find(h.member);
                    //m.setFirstName(t.agentname[0],h.language);
                    //m.setTelephone(t.agenttel[0],h.language);
                    //m.setEmail(t.agentemail[0]);
                    //
                    t.qualificationvisible = h.getBool("qualificationvisible");
                    t.qualification = h.get("qualification","|");
                    t.brand = h.get("brand");
                    //
                    t.accountvisible = h.getBool("accountvisible");
                    t.bank = h.get("bank");
                    t.account = h.get("account");
                    //t.bankcode = h.get("bankcode");
                    //t.tax = h.get("tax");
                    //t.financialcoding = h.get("financialcoding");
                    //t.financialarea = h.get("financialarea");
                    //t.financialcategory = h.get("financialcategory");
                    //
                    
                    String username = t.getName();
                    if(!username.equalsIgnoreCase(name2))
                    {
                        DbAdapter db = new DbAdapter();
                        try
                        {  
                        	db.executeUpdate("UPDATE SupSupplier SET name=" + DbAdapter.cite(name2) + " WHERE supplier="+t.supplier);
                        }catch(Exception e){
                        	e.printStackTrace();
                        } finally
                        {
                            db.close();
                        }
                       
                        Profile._cache.remove(name);
                        if(t.supplier == m.getProfile()) //前台用户
                        {
                            info += "<br/>您的用户名已改为“" + name2 + "”";
                        }
                    }
                }/* else if("e_cert".equals(act))
                {
                    t.cervisible = h.getBool("cervisible");
                    String[] arr = h.getValues("certificate");
                    String[] cername = h.getValues("cername");
                    String[] cercode = h.getValues("cercode");
                    String[] cerorg = h.getValues("cerorg");
                    for(int i = 0;i < arr.length;i++)
                    {
                        SupCertificate sc = SupCertificate.find(Integer.parseInt(arr[i]));
                        sc.supplier = t.supplier;
                        sc.name = cername[i];
                        if("证书名称...".equals(sc.name))
                            sc.name = "";
                        sc.code = cercode[i];
                        sc.org = cerorg[i];
                        sc.time = h.getDate("certime" + i);
                        sc.deadline = h.getDate("cerdeadline" + i);
                        sc.picture = h.getInt("cerpicture" + i);
                        if(sc.certificate < 1 && (sc.name + sc.code + sc.org + sc.picture).length() < 1)
                            continue;
                        sc.set();
                    }
                } else if("e_dept".equals(act))
                {
                    int type = h.getInt("type");
                    if(type == 1)
                    {
                        if(t.isErr()) //1:股份审核
                        {
                            out.print("<script>mt.show('您贵公司的产品仅适合向子公司申请。')</script>");
                            return;
                        }
                    } else
                    {
                        if(t.dept2.contains("|" + SupSupplier.DEPT_CORP + "|"))
                        {
                            out.print("<script>mt.show('贵公司已是股份的合格供应商，无需再向子公司申报。')</script>");
                            return;
                        }
                    }
                    //t.dept = type == 1
                    //         ? "|" + SupSupplier.DEPT_CORP + "|"
                    //         : h.get("dept","|") + (SupReview.find(supplier,Calendar.getInstance().get(Calendar.YEAR)).recom >= SupSupplier.RECOM ? SupSupplier.DEPT_CORP + "|" : "");
                    //DbAdapter.execute("UPDATE supflow SET deleted=1 WHERE supplier=" + supplier + " AND dept NOT IN(" + t.dept.substring(1).replace('|',',') + "0)");
                    t.dept = type == 1 ? "|" + SupSupplier.DEPT_CORP + "|" : h.get("dept","|");
                    t.setState();
//                    if(t.dept != type)
//                    {
//                        if(t.state != 0 && t.state != 14 && t.state != 23)
//                        {
//                            t.back(); //删除评审数据
//                            t.next(m.getProfile(),1,"推荐单位变更，重新申报。");
//                        }
//                        t.dept = type;
//                    }
                }
                //最后一次修改
                t.umember = m.getProfile();
                t.utime = new Date();
                t.set();
                out.print("<script>mt.integrity('" + t.getIntegrity() + "'," + t.integrity + ");</script>");
            } else if("submit".equals(act)) //提交申报
            {
                SupSuppliers.javaif(t.dept.length() < 2)
                {
                    out.print("<script>mt.show('您没有选择“审核单位”，无法申报！');</script>");
                    return;
                }
                if(t.dept.equals("|" + SupSupplier.DEPT_CORP + "|") && t.isErr()) //股份审核
                {
                    out.print("<script>mt.show('您贵公司的产品仅适合向子公司申请。')</script>");
                    return;
                }

//				Iterator it = SubBlacklist.find(" AND name=" + DbAdapter.cite(t.name) + " AND (state=2 OR dept=" + t.dept + " OR dept=" + SubContractor.DEPT_CORP + ") AND recycle=0",0,Integer.MAX_VALUE).iterator();
//				if(it.hasNext())
//				{
//					SubBlacklist sb = (SubBlacklist) it.next();
//					out.print("<script>mt.show('你的企业以被“" + Dept.find(sb.dept).name + "”划入禁入承包商，无法申报！');</script>");
//					return;
//				}
                if(t.state == 0 || SupFlow.count(" AND supplier=" + supplier + " AND state=3") < 1) //未拆分前，申报
                {
                    SupFlow sf = new SupFlow(0);
                    sf.supplier = t.supplier;
                    sf.type = 1;
                    sf.state = t.state == 0 ? 1 : 2;
                    sf.member = m.getProfile();
                    sf.role = Integer.parseInt(h.getCook("role","0"));
                    sf.set();
                } else
                {
                    //取消申报
                    ArrayList al = SupFlow.find(" AND supplier=" + t.supplier + " AND sf.last=1 AND deleted=0 AND dept NOT IN(" + t.dept2.substring(1).replace('|',',') + "0" + t.dept.substring(1).replace('|',',') + "0)",0,Integer.MAX_VALUE);
                    for(int i = 0;i < al.size();i++)
                    {
                        SupFlow sf = (SupFlow) al.get(i);
                        t.setFlow(h,sf.dept,19);
                    }
                    //重新申报
                    String[] arr = t.dept.split("[|]");
                    for(int i = 1;i < arr.length;i++)
                    {
                        int dept = Integer.parseInt(arr[i]);
                        SupFlow f = SupFlow.find(t.supplier,1,dept);
                        if(f.state == 0 || f.state == 4 || f.state == 5 || f.state == 8 || f.state == 12 || f.state == 16)
                        {
                            t.setFlow(h,dept,2);
                        }
                    }
                }
                t.setState();
            	if(t.state == 0 || t.state ==4) //未拆分前，申报
                {
                    SupFlow sf = new SupFlow(0);
                    sf.supplier = t.supplier;
                    sf.type = 1;
                    sf.state = 1;
                    sf.member = m.getProfile();
                    sf.role = Integer.parseInt(h.getCook("role","0"));
                    sf.set();
                }
                if(t.state == 3)
                {
                    out.print("<script>mt.show('企业信息已通过审核，不必再提交申报了！');</script>");
                    return;
                }
                if(t.state == 1)
                {
                    out.print("<script>mt.show('企业信息正在审核，请等待！');</script>");
                    return;
                }
                
                t.setState();
                t.set("stime",t.stime = new Date());
                
                info="提交申报成功,请等待审核结果！";
                //短信提醒
//				String str = "客服人员：010-56153244，QQ：800068497";
//				if(t.smember > 0)
//				{
//					Profile sm = Profile.find(t.smember);
//					str = "您的客户经理" + sm.getMember() + "。联系电话：" + sm.getTelephone(1) + "，QQ：800068497获得相关服务。";
//				}
//				SMessage.send(1,t.subcontractor,"您好，这里是中国水利水电工程承包商网站fbs.ir.sinohydro.com。您填报的企业资料正在审核中。请联系" + str);
            } else if("del".equals(act)) //删除
            {
                Profile sc = Profile.find(t.supplier);
                //操作日志
                OpLog ol = new OpLog(0);
                ol.community = h.community;
                ol.member = m.getProfile();
                ol.type = 11;
                ol.opid = sc.getProfile();
                ol.content = "删除“" + t.name + "”供应商！";
                ol.ip = request.getRemoteAddr();
                ol.set();

                sc.delete();
                SupSupplier.cache();
            } else if("clone".equals(act)) //复制
            {
                String oldusername = h.get("oldusername");
                String oldpassword = h.get("oldpassword");
                if(!Profile.isPassword(oldusername,oldpassword))
                {
                    out.print("<script>mt.show('用户名或密码错误！');</script>");
                    return;
                }
                String username = h.get("username");
                if(Profile.isExisted(username))
                {
                    out.print("<script>mt.show('用户名“" + username + "”已经被注册过了！');</script>");
                    return;
                }
                Profile old = Profile.find(oldusername);
                //   //
                Profile p = Profile.createqi(username,h.get("password"),h.community,old.getEmail(),h.get("tel"),h.get("suptype"),request.getServerName());
                p.setType(old.getType());
                p.setMembertype(1);//1.未审核的企业会员
                p.setOrganization(old.getOrganization(h.language),h.language);
                p.setCode(old.getCode());
                p.setFirstName(old.getFirstName(h.language),h.language);
                p.setMobile(old.getMobile());
                p.setJob(old.getJob(h.language),h.language);
                p.setTelephone(old.getTelephone(h.language),h.language);
                p.setQQ(old.qq);
                //
                int id = old.getProfile();
                SupSupplier sc = SupSupplier.find(id).clone();
                sc.supplier = p.getProfile();
                sc.set();
                Iterator it = SupSupply.find(" AND supplier=" + id,0,1000).iterator();
                while(it.hasNext())
                {
                    SupSupply ss = ((SupSupply) it.next()).clone();
                    ss.supplier = sc.supplier;
                    ss.set();
                }
                it = SupAward.find(" AND supplier=" + id,0,1000).iterator();
                while(it.hasNext())
                {
                    SupAward se = ((SupAward) it.next()).clone();
                    se.supplier = sc.supplier;
                    se.set();
                }
            } else
            {
                String[] arr = h.getValues("suppliers");
                if("remove".equals(act))
                {
                    SupQualification sq = SupQualification.find(h.getInt("qualification"));
                    ArrayList al = SupQualification.find(" AND path LIKE " + DbAdapter.cite(sq.path + "%"),0,Integer.MAX_VALUE);
                    int dept = h.getInt("dept");
                    for(int i = 0;i < arr.length;i++)
                    {
                        SupSupplier ss = SupSupplier.find(Integer.parseInt(arr[i]));
                        SupSupplierDept ssd = SupSupplierDept.find(ss.supplier,dept);
                        ssd.umember = h.member;
                        ssd.utime = new Date();
                        if(ssd.time == null)
                        {
                            ssd.member = ssd.umember;
                            ssd.supplier = ss.supplier;
                            ssd.dept = dept;
                            ssd.qualification = ss.qualification;
                            ssd.time = ssd.utime;
                        }
                        for(int j = 0;j < al.size();j++)
                        {
                            sq = (SupQualification) al.get(j);
                            ssd.qualification = ssd.qualification.replaceFirst("\\|" + sq.qualification + "\\|","|");
                        }
                        ssd.set();
                    }
                }
            }*/
            }
            out.print("<script>mt.show('" + info + "',1,'" + nexturl + "');</script>");
        } catch(Throwable ex)
        {
            out.print("<textarea id='ta'>" + ex.toString() + "</textarea><script>mt.show(document.getElementById('ta').value,1,'出现未知错误！');</script>");
            ex.printStackTrace();
        } finally
        {
            out.close();
        }
    }
}
