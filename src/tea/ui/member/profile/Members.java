package tea.ui.member.profile;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import jxl.format.Colour;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;
import tea.db.DbAdapter;
import tea.entity.Database;
import tea.entity.Entity;
import tea.entity.Filex;
import tea.entity.Http;
import tea.entity.MT;
import tea.entity.RV;
import tea.entity.Res;
import tea.entity.admin.*;
import tea.entity.member.Email;
import tea.entity.member.Logs;
import tea.entity.member.Message;
import tea.entity.member.OnlineList;
import tea.entity.member.Profile;
import tea.entity.member.ProfileBBS;
import tea.entity.member.SMSMessage;
import tea.entity.site.Community;
import tea.entity.util.Card;
import tea.entity.weixin.WeiXin;
import tea.entity.weixin.WxUser;
import tea.entity.westrac.Eventregistration;
import tea.entity.westrac.WestracClue;
import tea.entity.yl.shop.*;
import tea.entity.yl.shopnew.Invoice;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

public class Members extends TeaServlet
{

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request,response);
        String act = h.get("act"),nexturl = h.get("nexturl","");
        org.json.JSONObject json = new org.json.JSONObject();
        if("exp".endsWith(act))
        {
            response.setContentType("application/octet-stream");
            OutputStream out = response.getOutputStream();
            try
            {
                if("exp".equals(act)) //导出用户
                {
                    response.setHeader("Content-Disposition","attachment; filename=" + new String("用户.xls".getBytes("GBK"),"ISO-8859-1"));
                    WritableWorkbook wwb = jxl.Workbook.createWorkbook(response.getOutputStream());
                    WritableSheet ws = wwb.createSheet("工作表",0);
                    ws.setColumnView(0,20);
                    ws.setColumnView(1,20);
                    ws.setColumnView(2,20);
                    ws.setColumnView(3,20);
                    ws.setRowView(0,500);
                    ws.mergeCells(0,0,8,0);
                    WritableCellFormat cf = new WritableCellFormat(new WritableFont(WritableFont.ARIAL,20,WritableFont.BOLD));
                    ws.addCell(new Label(0,0,Community.find(h.community).getName(h.language),cf));
                    int j = 0;
                    cf = new WritableCellFormat();
                    cf.setBackground(Colour.GRAY_25);
                    ws.addCell(new Label(j++,1,"用户名",cf));
                    ws.addCell(new Label(j++,1,"姓名",cf));
                    ws.addCell(new Label(j++,1,"性别",cf));
                    //ws.addCell(new Label(j++,1,"地区",cf));
                    ws.addCell(new Label(j++,1,"邮箱地址",cf));
                    //ws.addCell(new Label(j++,1,"邮箱验证",cf));
                    ws.addCell(new Label(j++,1,"电话",cf));
                    //ws.addCell(new Label(j++,1,"积分",cf));
                    ws.addCell(new Label(j++,1,"注册时间",cf));
                    Enumeration e = Profile.find(h.key,0,Integer.MAX_VALUE);
                    for(int i = 2;e.hasMoreElements();i++)
                    {
                        String member = (String) e.nextElement();
                        Profile t = Profile.find(member);
                        j = 0;
                        ws.addCell(new Label(j++,i,member));
                        ws.addCell(new Label(j++,i,t.getName(h.language)));
                        ws.addCell(new Label(j++,i,t.isSex() ? "男" : "女"));
                        //ws.addCell(new Label(j++,i,t.city > 0 ? Card.find(t.city).toString() : ""));
                        ws.addCell(new Label(j++,i,t.getEmail()));
                        ws.addCell(new Label(j++,i,t.getTelephone(h.language)));
                        //ws.addCell(new Label(j++,i,t.valid ? "验证" : "未验证"));
                        //ws.addCell(new jxl.write.Number(j++,i,t.getPoint()));
                        ws.addCell(new Label(j++,i,MT.f(t.getTime(),1)));
                    }
                    wwb.write();
                    wwb.close();
                } else if("westracexp".equals(act)) //威斯特 用户
                {
                    response.setHeader("Content-Disposition","attachment; filename=" + new String("用户.xls".getBytes("GBK"),"ISO-8859-1"));
                    WritableWorkbook wwb = jxl.Workbook.createWorkbook(response.getOutputStream());
                    WritableSheet ws = wwb.createSheet("工作表",0);
                    ws.setColumnView(0,20);
                    ws.setColumnView(1,20);
                    ws.setColumnView(2,20);
                    ws.setColumnView(3,20);
                    ws.setRowView(0,500);
                    ws.mergeCells(0,0,8,0);
                    WritableCellFormat cf = new WritableCellFormat(new WritableFont(WritableFont.ARIAL,20,WritableFont.BOLD));
                    ws.addCell(new Label(0,0,Community.find(h.community).getName(h.language),cf));
                    int j = 0;
                    cf = new WritableCellFormat();
                    cf.setBackground(Colour.GRAY_25);
                    ws.addCell(new Label(j++,1,"用户名",cf));
                    ws.addCell(new Label(j++,1,"昵称",cf));
                    ws.addCell(new Label(j++,1,"工作地点",cf));
                    ws.addCell(new Label(j++,1,"注册时间",cf));
                    ws.addCell(new Label(j++,1,"工分",cf));
                    Enumeration e = Profile.find(h.key,0,Integer.MAX_VALUE);
                    for(int i = 2;e.hasMoreElements();i++)
                    {
                        String member = (String) e.nextElement();
                        Profile t = Profile.find(member);
                        ProfileBBS pb = ProfileBBS.find(h.community,member);
                        j = 0;
                        ws.addCell(new Label(j++,i,member));
                        ws.addCell(new Label(j++,i,pb.getSignature(h.language)));
                        ws.addCell(new Label(j++,i,Card.find(t.getProvince(h.language)).toString()));
                        ws.addCell(new Label(j++,i,MT.f(t.getTime(),1)));
                        ws.addCell(new jxl.write.Number(j++,i,t.getIntegral()));
                    }
                    wwb.write();
                    wwb.close();
                }
            } catch(WriteException wex)
            {
            } catch(Exception ex)
            {
                ex.printStackTrace();
            } finally
            {
                out.close();
            }
            return;
        }
        HttpSession session = request.getSession();
        PrintWriter out = response.getWriter();
        try
        {
            TeaSession teasession = new TeaSession(request);
            String a = h.get("a");
            if("uploadavatar".equals(a)) //修改头像
            {
                String avatar = h.get("Filedata");
                session.setAttribute("avatar",avatar); //Chrome,这里没有添加上去
                out.print("http://" + request.getServerName() + ":" + request.getServerPort() + avatar);
                return;
            } else if("rectavatar".equals(a))
            {
                String avatar = (String) session.getAttribute("avatar");
                if(avatar == null)
                    avatar = "/res/" + h.community + "/avatar/" + h.member + ".jpg";
                session.setAttribute("avatar",avatar);
                //ProfileBBS pb = ProfileBBS.find(h.community,h.member);
                //pb.set(h.language,pb.getTitle(h.language),avatar,pb.getSignature(h.language));
                FileOutputStream fos = new FileOutputStream(getServletContext().getRealPath(avatar));
                String avatar2 = h.get("avatar2");
                for(int i = 0;i < avatar2.length();i += 2)
                    fos.write(Integer.parseInt(avatar2.substring(i,i + 2),16));
                fos.close();
                out.print("<?xml version=\"1.0\" ?><root><face success=\"1\"/></root>");
                return;
            }else if("editprocurementunitjoin".equals(act)){
				try{
			    	 String [] jids = h.getValues("jid");
			    	 String [] companys = h.getValues("company");
			    	 String [] taxs = h.getValues("tax");
			    	 String [] formulas = h.getValues("formula");
			    	 
			    	 String [] agentPriceNews = h.getValues("agentPriceNew");
			    	 
			    	 String [] invoicePuid = h.getValues("invoicePuid");
                    String [] companyids = h.getValues("companyid");

                    String []models = h.getValues("model");
			    	 
			    	 try {
			    		 for(int i=0;i<agentPriceNews.length;i++) {
		    			 Float.parseFloat(agentPriceNews[i]);
			    		 }
		    		 }catch (Exception e) {
		    			 e.printStackTrace();
				          json.put("type", "2");
				          json.put("mes", "请输入正确数字！");
				          out.print(json.toString());
				          return;
					}
			    	 
			    	 for(int i=0;i<jids.length;i++) {
			    		 ProcurementUnitJoin puj = ProcurementUnitJoin.find(Integer.parseInt(jids[i]));
			    		 puj.company = companys[i];
			    		 puj.crmid = companyids[i];
			    		 puj.model=Integer.valueOf(models[i]);
			    		 puj.tax = Integer.parseInt(taxs[i]);
			    		 puj.formula = Integer.parseInt(formulas[i]);
			    		 puj.agentPriceNew = Float.parseFloat(agentPriceNews[i]);
			    		 puj.invoicePuid = Integer.parseInt(invoicePuid[i]);
			    		 
			    		 puj.set();
			    	 }
			    	  
			    	  json.put("type", "0");
					}catch (Exception e) {
						e.printStackTrace();
				          json.put("type", "2");
				          json.put("mes", "系统异常，请重试！");
					}
				out.print(json.toString());
				return;
		      }else if("editFloorPrice".equals(act)){//20200701 服务商底价设置   按活度区间算价格 可多个
                String message = "操作执行成功！";
                String[] sizes = h.getValues("size");
                String[] floorPrize = h.getValues("floorprize");
                int category = h.getInt("id");
                ProcurementUnitJoin p = ProcurementUnitJoin.find(category);
                if(sizes==null||floorPrize==null){
                    out.print("<script>mt.show('不可为空！',1,'" + nexturl + "');</script>");
                    return;
                }
                String size = "";
                for (int i = 0; i <sizes.length ; i++) {
                    String size1 = sizes[i];
                    size +=size1+",";
                }
                size = size.substring(0,size.length()-1);
                String prize = "";
                for (int i = 0; i <floorPrize.length ; i++) {
                    String size1 =floorPrize[i];
                    prize +=size1+",";
                }
                prize = prize.substring(0,prize.length()-1);

                p.set();
                out.print("<script>mt.show('" + message + "',1,'" + nexturl + "');</script>");
                return;

            }else if("editprocurementunit".equals(act)){
                try{
                    String [] shid = h.getValues("shid");
                    String [] productPuid = h.getValues("productPuid");
                    String [] invoicePuid = h.getValues("invoicePuid");


                    for(int i=0;i<shid.length;i++) {
                        ShopHospital puj = ShopHospital.find(Integer.parseInt(shid[i]));
                        puj.setProductPuid(Integer.parseInt(productPuid[i]));
                        puj.setInvoicePuid(Integer.parseInt(invoicePuid[i]));
                        puj.set();
                    }

                    json.put("type", "0");
                }catch (Exception e) {
                    e.printStackTrace();
                    json.put("type", "2");
                    json.put("mes", "系统异常，请重试！");
                }
                out.print(json.toString());
                return;
            }
            if(act.startsWith("check"))
            {
                String tmp = h.get("q");
                if("check_username".equals(act))
                {
                    out.print(!Profile.isExisted(tmp));
                } else if("check_verify".equals(act))
                {
                    out.print(tmp.equalsIgnoreCase((String) session.getAttribute("verify")));
                }
                return;
            }
            if("json".equals(act))
            {
                if(h.member < 1)
                {
                    out.print("{}");
                    return;
                }
                AdminUsrRole aur = AdminUsrRole.find(h.community,h.member);
                Profile p = Profile.find(h.member);
                out.print("{username:'" + h.username + "',role:'" + aur.getRole() + "',type:'"+p.getType()+"'}");
                return;
            }
            if("findusername".equals(act)){
            	
            	
            	//登陆前验证，如果有当前用户名，则向手机发送验证码，如果无当前用户名，则返回0
            	String username=h.get("username");//获取用户名
            	String hname=h.get("hname","");//医院名称
            	Profile profile=null;
            	if(hname.length()>0){
            		profile=Profile.findbyhospital(username,hname);
            	}else{
            		profile=Profile.find(username);
            	}
            	
            	String password=h.get("password");//获取密码
            	
            	if(profile.profile>0){
            		if(!password.equals(profile.password)){
                		out.print("1");
                		
                	}else{
                		String mobile=profile.mobile;
                		Filex.logs("yt_mobile.txt", profile.profile+","+profile.mobile);
                		if(mobile!=null&&mobile!=""){
                			//产生四位随机数
                			Filex.logs("yt_mobile.txt", "==================ER:"+profile.profile+","+username+","+mobile+","+profile.mobile);
                			String str = "";
                			str += (int)(Math.random()*9+1);
                			for(int i = 0; i < 3; i++){
                				str += (int)(Math.random()*10);
                			}
                			int num = Integer.parseInt(str);
                			SMSMessage.create("Home", profile.member, profile.mobile, h.language, "您的验证码为："+num);
                			out.print(num);
                		}
                	}
            		
            	}else{
            		out.print("0");
            		
            	}
            	return;
            }
            if(!"selsign".equals(act) && !"getsign".equals(act)){
            	out.println("<script>var mt=parent.mt,doc=parent.document;</script>");
            }
            if("login".equals(act)) //登录
            {
                String verify = h.get("verify");
                String str = h.getCook("verify",null);
                if((str != null || verify != null) && (str == null || !MT.dec(str).equalsIgnoreCase(verify)))
                {
                    out.print("<script>alert('抱歉，验证码错误！');</script>");
                    return;
                }
                h.setCook("verify",null,0);
                //
                String member = h.get("LoginId");
                String password = h.get("Password");
                if(!Profile.isPassword(member,password))
                {
                    out.print("<script>alert('用户名或密码错误！');</script>");
                    return;
                }
                Profile p = Profile.find(member);
                if(p.isLocking())
                {
                    out.print("<script>alert('该用户已被锁定，暂时无法登录！');</script>");
                    return;
                }
                RV rv = new RV(member);
                Logs.create(h.community,rv,1,h.node,request.getRemoteAddr());
                //OnlineList.create(session.getId(),h.community,member,request.getRemoteAddr());
                p.setLogin(request.getRemoteAddr(),request.getHeader("user-agent") + " Screen/" + request.getParameter("screen"),new Date());
                Community c = Community.find(h.community);
                h.member = p.getProfile();
                session.setAttribute("member",h.member);
                if(c.isSession())
                {
                    //session.setAttribute("tea.RV",rv);
                } else
                {
                    h.setCook("member",MT.enc(p.getLogint() + "|" + h.member + "|" + p.getPassword()),h.getInt("expiry", -1));
                }
                //out.print("<script>top.location.replace('" + nexturl + "');</script>");//parent
                out.print("<script>parent.location." + (nexturl.length() < 1 ? "reload()" : "replace('" + nexturl + "')") + ";</script>");
                return;
            }else if("register".equals(act))
            {
                String member = h.get("member");
                if(member == null || Profile.isExisted(member))
                {
                    out.print("<script>mt.show('抱歉“" + member + "”已存在！');</script>");
                    return;
                }
                String verify = h.get("verify");
                String str = h.getCook("verify",null);
                if((str != null || verify != null) && (str == null || !MT.dec(str).equalsIgnoreCase(verify)))
                {
                    out.print("<script>mt.show('抱歉，验证码错误！');</script>");
                    return;
                }

                //注册
                Profile p = new Profile(0);
                p.member = member;
                p.password = h.get("password");
                p.community = h.community;
                p.email = h.get("email");
                p.type = h.getInt("type");
                p.set();
                p.setFirstName(h.get("firstname"), h.language);
                
                //登录
                RV rv = new RV(member);
                Logs.create(h.community,rv,1,h.node,request.getRemoteAddr());
                OnlineList.create(session.getId(),h.community,member,request.getRemoteAddr());
                session.setAttribute("member",p.getProfile());
                h.setCook("member",MT.enc(p.getProfile() + "|" + p.getPassword()), -1);
                p.setLogin(request.getRemoteAddr(),request.getHeader("user-agent") + " Screen/" + request.getParameter("screen"),new Date());
                out.print("<script>mt.show('注册成功！',1,'" + nexturl + "');</script>");
                return;
            }
            String info = Res.get(h.language,"操作执行成功！");
            if("get".equals(act)) //忘记密码
            {
                if(!h.get("verify","").equalsIgnoreCase((String) session.getAttribute("verify")))
                {
                    out.print("<script>mt.show('抱歉“验证码”不正确！');</script>");
                    return;
                }
                String username = h.get("username");
                if(username == null || !Profile.isExisted(username))
                {
                    out.print("<script>mt.show('用户名不存在，请重新输入！');</script>");
                    return;
                }
                session.removeAttribute("verify");
                //
                Profile p = Profile.find(username);
                String email = MT.f(p.getEmail(),"");
                if(!"".equals(email)){
                	String sn = "mail." + email.substring(email.indexOf('@') + 1);
                	String url = "http://" + h.request.getServerName() + ":" + h.request.getServerPort();
                	StringBuilder sb = new StringBuilder();
                	//sb.append("<b>你使用“找回密码”功能。点击以下链接，设置你的新密码：</b>");
                	sb.append("<br/>用户名：" + username);
                	sb.append("<br/>密　码：" + p.getPassword());
                	sb.append("<br/><a href='" + url + "/servlet/StartLogin?community=" + h.community + "'>登陆</a>");
                	sb.append("<br/><div style='color:#999999'>");
                	sb.append("<br/>（这是一封自动发送的邮件，请不要直接回复）");
                	sb.append("<br/>－如果你没有使用过“找回密码”功能，请忽略本邮件，你的账户依然是安全的。");
                	sb.append("<br/>还有其他问题? 联系<a href='" + url + "'>我们客服</a>。");
                	sb.append("</div>");
                	Email.create(h.community,null,email,Res.get(h.language,"找回密码"),sb.toString(),true);
                	
                	out.print("<script>mt.show('我们已向您的邮箱发送了一封密码重置邮件，请查收信件！',2,'http://" + sn + "',400);parent.$$('dl_ok').value='前往" + sn + "收信';</script>");
                }else{
                    String c = "用户名：" + username+"密码："+p.getPassword()+"（这是一封自动发送的短信，请不要直接回复）";
           			String rs = SMSMessage.create(h.community,"webmaster", p.mobile,
           					h.language, c);
           			out.print("mt.show('我们已向您的手机发送了一封密码重置短信，请查收短信！');");
                }
                return;
            } else if("password".equals(act)) //修改密码
            {
                String old = h.get("old");
                Profile p = Profile.find(h.member);
                if(!old.equals(p.getPassword()))
                {
                    out.print("<script>mt.show('“旧密码”不正确！');</script>");
                    return;
                }
                p.setPassword(h.get("password"));
            } else if("clear".equals(act)) //清空密码
            {
                String member = h.get("member");
                Profile.find(member).setPassword("123456");
            } else if("dels".equals(act)) //批量删除用户
            {
                String[] member = h.getValues("members");
                for(int i = 0;i < member.length;i++)
                {
                    Profile.delete(member[i]);
                    DbAdapter db = new DbAdapter();
                    try
                    {
                        db.executeUpdate("DELETE FROM Message   WHERE tmember=" + DbAdapter.cite("/" + member[i] + "/"));
                    } finally
                    {
                        db.close();
                    }
                }
            } else if("send".equals(act))
            {
                String subject = h.get("subject");
                String content = h.get("content");
                if(content.length() < 1)
                {
                    out.print("<script>alert('" + Res.get(h.language,"“内容”不能为空！") + "');</script>");
                    return;
                }
                boolean email = h.getBool("email");
                String[] member = h.get("member").split(",");
                for(int i = 1;i < member.length;i++)
                {
                    if(email)
                        Email.create(h.community,null,member[i],subject,content,true);
                    else
                    {
                        Message t = new Message(0);
                        t.member = h.member;
                        t.tmember = member[i];
                        t.subject = subject;
                        t.content = content;
                        t.set();
                    }
                }
                out.print("<script>mt.show('" + Res.get(h.language,"数据发送成功！") + "');</script>");
                return;
            } else if("medal".equals(act)) //勋章
            {
                Profile p = Profile.find(h.get("member"));
                p.setMedal(h.get("medals","|"));
            } else if("medals".equals(act)) //批量添加勋章
            {
                String tmp = h.get("medals","|");
                String[] member = h.get("member").split(",");
                for(int i = 1;i < member.length;i++)
                {
                    Profile p = Profile.find(member[i]);
                    p.setMedal(MT.f(p.getMedal(),"|") + tmp.substring(1));
                }
            } else if("gag".equals(act)) //禁言
            {
                String[] member = h.getValues("members");
                for(int i = 0;i < member.length;i++)
                {
                    Profile p = Profile.find(member[i]);
                    int day = h.getInt("day");
                    p.setGag(day < 1 ? null : MT.add(new Date(),day));
                }
            } else if("actives".equals(act)) //评估活跃度
            {
                for(int i = 0;i < 20;i++)
                    out.print("// 显示进度条  \n");
                int[] arr = new int[Profile.ACTIVES_TYPE.length];
                Date t = Entity.Months(new Date(), -3);
                StringBuffer sql = new StringBuffer(" AND membertype=1 AND community=" + DbAdapter.cite(teasession._strCommunity));
                int sum = Profile.count(sql.toString());
                Enumeration e = Profile.find(sql.toString(),0,Integer.MAX_VALUE);
                for(int i = 1;e.hasMoreElements();i++)
                {
                    String member = ((String) e.nextElement());
                    Profile pobj = Profile.find(member);

                    if(i % 100 == 0)
                    {
                        out.print("<script>mt.progress(" + i + "," + sum + ",'正在评估：" + member + "');</script>");
                        out.flush();
                    }

                    int logint = Logs.count(teasession._strCommunity," AND rmember=" + DbAdapter.cite(member)); //+ " AND time>=" + DbAdapter.cite(t)//登陆次数
                    int wcing = WestracClue.count(teasession._strCommunity," AND wctype=1 AND member=" + DbAdapter.cite(member)); //+ " AND times>= " + DbAdapter.cite(t) //提供销售线索条数;
                    int eventing = Eventregistration.Count(teasession._strCommunity," AND member=" + DbAdapter.cite(member) + " AND verifg=1"); // AND times>=" + DbAdapter.cite(t) //参加活动次数
                    int tjint = Profile.count(" AND tjmember=" + DbAdapter.cite(member)); // + " AND time>= " + DbAdapter.cite(t) //推荐会员数

                    int actives = 0;
                    if(logint >= 15 || wcing >= 15 || eventing >= 5 || tjint >= 5)
                        actives = 3;
                    else if(logint >= 5 || wcing >= 5 || eventing >= 1 || tjint >= 1)
                        actives = 2;
                    else if(logint <= 5 || wcing <= 5 || eventing <= 1 || tjint <= 1)
                        actives = 1;
                    pobj.setActives(actives);
                    arr[actives]++;
                }
                for(int i = 1;i < arr.length;i++)
                {
                    info += "<br/>" + Profile.ACTIVES_TYPE[i] + "：" + arr[i] + "名";
                }
            } else if("audit".equals(act))
            {
                Profile p = Profile.find(h.getInt("member"));
                p.setVerifgtime(new Date());
                p.setVerifgmember(h.username);
                boolean type = h.getBool("type");
                p.setLocking(!type);
                if(type)
                {
                    AdminUsrRole aur = AdminUsrRole.find(h.community,p.getMember());
                    aur.setRole("/" + h.get("role") + "/");
                }
            }else if("ylreg".equals(act))//注册
            {
                String username = h.get("username");
                if(username == null || Profile.isExisted(username))
                {
                    out.print("<script>mt.show('“" + username + "”已存在！');</script>");
                    return;
                }
                int checktype = h.getInt("checktype");
                int type = 0;
                String sname = "verify";
                /*if(!h.get("verify").equalsIgnoreCase((String) session.getAttribute(sname)))
                {
                    out.print("<script>mt.show('“验证码”不正确！');</script>");
                    return;
                }*/
                String verid = h.get("verid");
                String mob = h.get("mob");
                String email = h.get("email");
                if(checktype==1){
                	int flag = Profile.count("  AND deleted = 0 AND mobile = "+Database.cite(mob));
                	if(flag>0){
                		out.print("<script>mt.show('手机已被注册！');</script>");
                		return;
                	}
                	String code = String.valueOf(session.getAttribute(mob
                			+ "_code"));
                	if(!verid.equals(code)){
                		out.print("<script>mt.show('手机验证码错误！');</script>");
                		return;
                	}
                }else{
                	int eflag = Profile.count("  AND deleted = 0 AND email = "+Database.cite(email));
                	if(eflag>0){
                		out.print("<script>mt.show('邮箱已被注册！');</script>");
                		return;
                	}
                }
                session.removeAttribute(sname);
                String url = "http://" + h.request.getServerName() + ":" + h.request.getServerPort();
                //注册
                Profile p = Profile.create(username,h.get("password"),h.community,email,request.getServerName());
                p.setType(type);
                p.set("hospitals","|");
                StringBuffer sb = new StringBuffer();
                String myurl = url+"/Members.do?act=actemail&test&profile="+ MT.enc(p.profile);
                sb.append("	<table width='100%' border='0' cellspacing='0' cellpadding='0' style='width:700px;margin:0 auto;text-align:left;font-size:14px;'>");
                sb.append("	  <tr>");
                sb.append("	    <td><img src='http://123.57.64.192/res/Home/structure/14102049.jpg' /></td>");
                sb.append("	    <td style='' valign='bottom'><a href='http://123.57.64.192/html/folder/14102033-1.htm' style='color:blue;font-size:12px;text-decoration:none;'>登录</a></td>");
                sb.append("	  </tr>");
                sb.append("		<tr>");
                sb.append("			<td colspan='2' style='padding:15px 0 20px;color:#000;font-weight:bold'>亲爱的用户您好！</td>	</tr>");
                sb.append("			<tr><td colspan='2'>感谢您注册粒子治疗会员！您现在只需点击以下链接，即可完成注册。</td>	</tr>");
                sb.append("			<tr><td colspan='2' style='color:red;padding:20px 0;font-weight:bold'><a href='"+myurl+"'>点击激活粒子治疗账户</a></td>	</tr>");
                sb.append("			<tr><td colspan='2'>如果上述文字点击无效，请把下面网页地址复制到浏览器地址栏中打开：</td>	</tr>");
                sb.append("			<tr><td colspan='2' style='padding:5px 0'><a href='#' style='color:#acacac;text-decoration:none;'>"+myurl+"</a></td>");
                sb.append("			</tr>");
                sb.append("			<tr><td colspan='2' style='padding:15px 0 10px;color:#000;font-weight:bold'>安全小贴士</td></tr>");
                sb.append("			<tr><td colspan='2' style='line-height:180%;color:#0077FF;padding:0'><p style='padding:0;margin:0'>请绝对不要向欺诈性网站提供您的密码。</p>");
                sb.append("					<p style='padding:0;margin:0'>为了安全地访问粒子治疗或您的账户，请打开一个新的浏览器（例如：Internet Explorer ），然后键入粒子治疗网址：http://，确保自己在真正的粒子治疗网站上。</p>");
                sb.append("					<p style='padding:0;margin:0'>粒子治疗绝不会要求您在电子邮件中输入密码。</p>");
                sb.append("					<p style='padding:0;margin:0'>请您绝对不要将粒子治疗密码提供给任何人，包括员工。</p>");
                sb.append("					</td>");
                sb.append("				</tr>");
                sb.append("	</table>");
                //sb.append(myurl);
                p.setEmailflag(0);
                p.setMobile(h.get("mob"));
                p.setMembertype(0);
                p.set("qualification","0");
                if(checktype==0){
                	boolean flag = Email.create(h.community,null,email,"激活账号",sb.toString());
                    p.setEmailflag(1);
                }else{
                	ShopIntegralRules sir = ShopIntegralRules.findByItem(1);
            		ShopMyPoints.creatPoint(p.profile,"用户注册赠送积分", sir.getIntegral(), null);
                }
                String myact = MT.f(h.get("myact"),"");
                String openid = h.get("openid");
                if(myact.equals("qq")){
                	p.setqqopenid(openid);
                }else if(myact.equals("wx")){
                	p.setwxopenid(openid);
                }
                //登录
                /*RV rv = new RV(username);
                Logs.create(h.community,rv,1,h.node,request.getRemoteAddr());
                OnlineList.create(session.getId(),h.community,username,request.getRemoteAddr());
                session.setAttribute("member",p.getProfile());
                h.setCook("member",MT.enc(p.getProfile() + "|" + p.getPassword()), -1);*/
                //out.print("<script>parent.parent.location.replace('" + nexturl + "');</script>");
                if(h.status==1)
                	out.print("<script>parent.parent.mt.show('注册成功！',1,'"+nexturl+"');</script>");
                else
                	out.print("<script>mt.show('注册成功！',1,'"+nexturl+"');</script>");
                return;
            }else if("actemail".equals(act)){
            	try {
            		String pid = MT.dec(request.getParameter("profile"));
                	Profile p = Profile.find(Integer.parseInt(pid));
                	if(p.profile>0){
                		if(p.emailflag==1){
                			ShopIntegralRules sir = ShopIntegralRules.findByItem(1);
                			ShopMyPoints.creatPoint(p.profile,"用户注册赠送积分", sir.getIntegral(), null);
                			p.setEmailflag(0);
                			out.print("<script>location='/servlet/Node?node=14110724&language=1';</script>");
                		}else{
                			out.print("<script>location='/"+(h.status==1?"x":"")+"html/folder/14102033-1.htm';</script>");
                		}
                		return;
                	}
				} catch (Exception e) {
					out.print("<script>location='/servlet/Node?node=14110762&language=1';</script>");
				}
            	return;
            }else if ("openid".equals(act))
            {
            	String yming = request.getServerName();
            	try {
    				WeiXin weiXin = WeiXin.find("Home");
    				String _nexturl = "https://open.weixin.qq.com/connect/oauth2/authorize?appid="
    						+ weiXin.appid[1]
    						+ "&redirect_uri="
    						+ Http.enc("http://" + yming
    								+ "/Members.do?act=openid2&nexturl=" + Http.enc(nexturl))
    						+ "&response_type=code&scope="
    						+ h.get("scope", "snsapi_userinfo")
    						+ "&state=STATE#wechat_redirect";
    				Filex.logs("qdr11.txt", "aa="+_nexturl);
    				response.sendRedirect(_nexturl);
    				return;
    			} catch (Exception e) {
    				e.printStackTrace();
    			}
            } else if ("openid2".equals(act))
            {
            	Filex.logs("qdr22.txt", "aa="+nexturl);
            	try {
    				WeiXin weiXin = WeiXin.find("Home");
    				String openid = h.getCook("openid", ""), token = h.getCook(
    						"token", "");
    				String useropenid = "";
    				byte[] by = (byte[]) Http.open(
    						"https://api.weixin.qq.com/sns/oauth2/access_token?appid="
    								+ weiXin.appid[1] + "&secret="
    								+ weiXin.appsecret[1] + "&code="
    								+ h.get("code")
    								+ "&grant_type=authorization_code", null);
    				String str = new String(by);
    				Filex.logs("openid_code.txt", str);
    				JSONObject jo = JSON.parseObject(str);
    				openid = jo.getString("openid");
    				token = jo.getString("access_token");
    				// 获取access_coken后，获取当前用户的照片
    				byte[] by2 = (byte[]) Http.open(
    						"https://api.weixin.qq.com/sns/userinfo?access_token="
    								+ token + "&openid=" + openid + "&lang=zh_CN",
    						null);
    				String str2 = new String(by2, "UTF-8");
    				JSONObject jo2 = JSON.parseObject(str2);
    				String headimgurl = jo2.getString("headimgurl");
    				String nickname = jo2.getString("nickname");

    				// 获取指定的Access_Token
    				String str4 = (String) Http.open(
    						"https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid="
    								+ weiXin.appid[1] + "&secret="
    								+ weiXin.appsecret[1], null);
    				JSONObject jo4 = JSON.parseObject(str4);

    				String str3 = (String) Http.open(
    						"https://api.weixin.qq.com/cgi-bin/user/info?access_token="
    								+ jo4.getString("access_token") + "&openid="
    								+ openid + "&lang=zh_CN", null);
    				JSONObject jo3 = JSON.parseObject(str3);
    				useropenid = openid;
    				openid = jo3.getString("unionid");

    				WxUser wx = WxUser.find(useropenid.equals("") ? openid
    						: useropenid);
    				wx.community = h.community;
    				wx.nickname = nickname;
    				wx.avatar = headimgurl;
    				wx.set();
    				h.setCook("headimgurl", headimgurl, Integer.MAX_VALUE);
    				if (!useropenid.equals("")) {
    					h.setCook("useropenid", useropenid, Integer.MAX_VALUE);
    				}
    				h.setCook("openid", useropenid, -1);
    				/*h.setCook(h.community + "useropenid", useropenid,
    						Integer.MAX_VALUE);*/
    				h.setCook("nickname", nickname, -1);
    				Filex.logs("qdr22.txt", "333=");
    				response.sendRedirect(nexturl);
    			} catch (Exception e) {
    				Filex.logs("qdr22.txt", "333="+e.toString());
    				e.printStackTrace();
    			}
            }else if("resemail".equals(act)){
            	StringBuffer sb = new StringBuffer();
            	Profile p = Profile.find(h.get("member"));
            	String url = "http://" + h.request.getServerName() + ":" + h.request.getServerPort();
                String myurl = url+"/Members.do?act=actemail&test&profile="+ MT.enc(p.profile);
                sb.append("	<table width='100%' border='0' cellspacing='0' cellpadding='0' style='width:700px;margin:0 auto;text-align:left;font-size:14px;'>");
                sb.append("	  <tr>");
                sb.append("	    <td><img src='http://123.57.64.192/res/Home/structure/14102049.jpg' /></td>");
                sb.append("	    <td style='' valign='bottom'><a href='http://123.57.64.192/html/folder/14102033-1.htm' style='color:blue;font-size:12px;text-decoration:none;'>登录</a></td>");
                sb.append("	  </tr>");
                sb.append("		<tr>");
                sb.append("			<td colspan='2' style='padding:15px 0 20px;color:#000;font-weight:bold'>亲爱的用户您好！</td>	</tr>");
                sb.append("			<tr><td colspan='2'>感谢您注册粒子治疗会员！您现在只需点击以下链接，即可完成注册。</td>	</tr>");
                sb.append("			<tr><td colspan='2' style='color:red;padding:20px 0;font-weight:bold'><a href='"+myurl+"'>点击激活粒子治疗账户</a></td>	</tr>");
                sb.append("			<tr><td colspan='2'>如果上述文字点击无效，请把下面网页地址复制到浏览器地址栏中打开：</td>	</tr>");
                sb.append("			<tr><td colspan='2' style='padding:5px 0'><a href='#' style='color:#acacac;text-decoration:none;'>"+myurl+"</a></td>");
                sb.append("			</tr>");
                sb.append("			<tr><td colspan='2' style='padding:15px 0 10px;color:#000;font-weight:bold'>安全小贴士</td></tr>");
                sb.append("			<tr><td colspan='2' style='line-height:180%;color:#0077FF;padding:0'><p style='padding:0;margin:0'>请绝对不要向欺诈性网站提供您的密码。</p>");
                sb.append("					<p style='padding:0;margin:0'>为了安全地访问粒子治疗或您的账户，请打开一个新的浏览器（例如：Internet Explorer ），然后键入粒子治疗网址：http://，确保自己在真正的粒子治疗网站上。</p>");
                sb.append("					<p style='padding:0;margin:0'>粒子治疗绝不会要求您在电子邮件中输入密码。</p>");
                sb.append("					<p style='padding:0;margin:0'>请您绝对不要将粒子治疗密码提供给任何人，包括员工。</p>");
                sb.append("					</td>");
                sb.append("				</tr>");
                sb.append("	</table>");
            	//String myurl = url+"/Members.do?act=actemail&profile="+ MT.enc(p.profile);
                //sb.append(myurl);
                boolean flag = Email.create(h.community,null,p.getEmail(),"激活账号",sb.toString());
                out.print("<script>mt.show('发送成功！',1,'/html/folder/14102033-1.htm');</script>");
                return;
            }else if("yladd".equals(act))//后台添加
            {
                String username = h.get("username");
                //2020.09.01改为用户名不可重复
                if(username == null || Profile.isExisted(username))
                {
                    out.print("<script>mt.show('“" + username + "”已存在！');</script>");
                    return;
                }
                int type = 0;
                String mob = h.get("mob",null);
                //2017-10-17改为可以添加相同姓名的用户，但是手机号不能相同。
                if(username == null || Profile.isExisted2(username,mob))
                {
                    out.print("<script>mt.show('“" + username + "”已存在！');</script>");
                    return;
                }
                String email = h.get("email",null);
                if(mob==null&&email==null){
                	out.print("<script>mt.show('手机或邮箱必须填写一个！');</script>");
            		return;
                }
                if(mob!=null){
                	//int flag = Profile.count(" AND mobile = "+Database.cite(mob));
                	int flag = Profile.count(" AND mobile = "+Database.cite(mob)+" AND deleted = 0 ");//（用户名填写错误，需修改，用户名现在无法修改，只能删除用户，再添加新的用户）用户删除后，再重新添加是，手机号码报已注册
                	if(flag>0){
                		out.print("<script>mt.show('手机已被注册！');</script>");
                		return;
                	}
                }else{
                	int eflag = Profile.count(" AND email = "+Database.cite(email));
                	if(eflag>0){
                		out.print("<script>mt.show('邮箱已被注册！');</script>");
                		return;
                	}
                }
                int membertype = h.getInt("membertype");
                String [] procurementUnits = h.getValues("procurementUnit");
                if(membertype==2) {
                	if(procurementUnits==null) {
                		out.print("<script>mt.show('请选择采购厂商！');</script>");
                		return;
                	}
                }
                
                int hospital = h.getInt("hospital");
                int department = h.getInt("department");
                Date time = h.getDate("validity");
                if(membertype==1){
                	if(hospital>-1||department>-1){
                		if(hospital==-1){
                			out.print("<script>mt.show('请选择医院！');</script>");
                			return;
                		}
                		if(department==-1){
                			out.print("<script>mt.show('请选择科室！');</script>");
                			return;
                		}
                		if(time==null){
                			out.print("<script>mt.show('请选择有效期！');</script>");
                			return;
                		}
                	}
                }
                
                
                //注册
                Profile p = Profile.create(username,h.get("password"),h.community,email,request.getServerName());
                int parentpro = h.getInt("parentpro");//服务商公司选择
                p.set("parentpro",parentpro);
                p.setMobile(h.get("mob"));
                p.setType(type);
                p.setMembertype(membertype);
                p.set("qualification","0");
                int isvip = h.getInt("isvip");
                p.set("isvip", isvip);
                p.set("hospitals","|");
                if(parentpro>0){//选择了服务商公司   hospitals变成该服务公司绑定的医院  |xxxx|xxxx|
                    ProcurementUnitJoin puj = ProcurementUnitJoin.find(parentpro);
                    String hoid = puj.getHoid();
                    if(hoid!=null&&hoid.length()>2){// 获取到的服务商公司绑定医院 不是null  且 不是 ，
                        hoid = hoid.replaceAll(",","\\|");
                        p.set("hospitals",hoid);

                    }

                }
                if(membertype==1){
	            	if(hospital>-1||department>-1){
	                	ShopQualification sq = new ShopQualification(0);
	                	sq.member = p.profile;
	                	sq.status = 2;
	                	sq.hospital_id = hospital;
	                	sq.department = department;
	                	sq.set();
	                	//Profile p = Profile.find(sq.member);
	            		p.set("validity",time);
	            		//p.set("membertype", "1");
	            		p.set("qualification","1");
	            		//return;
	            	}
                }
                String procurementUnit = "|";
                
                if(membertype==2) {
                	String puids = "";
                    for(int i=0;i<procurementUnits.length;i++) {
                    	procurementUnit += procurementUnits[i]+"|";
                    	int puid = Integer.parseInt(procurementUnits[i]);
                    	if(i>0) {
                    		puids+= ",";
                    	}
                    	puids+= puid;
                    	ProcurementUnitJoin puj = ProcurementUnitJoin.find(puid,p.profile);
                    	if(puj.jid==0) {
                    		puj.profile = p.profile;
                    		puj.puid = puid;
                    		puj.time = new Date();
                    		puj.set();
                    	}
                    }
                    List<ProcurementUnitJoin> pujlist = ProcurementUnitJoin.find(" AND puid not in ("+puids+") AND profile = "+p.profile, 0, Integer.MAX_VALUE);
                    for (int i = 0; i < pujlist.size(); i++) {
                    	ProcurementUnitJoin puj = pujlist.get(i);
                    	puj.delete();
                    }
                }
                
                p.set("procurementUnit",procurementUnit);
                
                p.set("address",h.get("address","")); //收货地址-签收人医院
                p.set("company", h.get("company",""));//服务公司名称
                p.set("tax", String.valueOf(h.getInt("tax")));//进项税返还
                p.set("formula", String.valueOf(h.getInt("formula")));//服务费公式
                p.set("issalesman", h.getInt("issalesman"));
                CreatDetail c = CreatDetail.find(0);
                c.setPid(p.profile);
                c.setCreatpid(h.member);
                c.set();
                //三期新增服务商公司名称和进项税返还政策
                //p.set("company", h.get("", arg1))
                /*String [] pros = h.getValues("myproduct");
                if(p.hospitals!=null){
                	String [] sarr = p.hospitals.split("\\|");
					for(int i=1;i<sarr.length;i++){
						ShopHospital s1 = ShopHospital.find(Integer.parseInt(sarr[i]));
						s1.setAddflag(0);
						s1.set();
					}
                }
                String pstr  = "|";
            	if(pros!=null){
            		for(int i=0;i<pros.length;i++){
            			ShopHospital sh = ShopHospital.find(Integer.parseInt(pros[i]));
            			sh.setAddflag(1);
            			sh.set();
            			pstr += pros[i]+"|";
            		}
            		out.print("<script>mt.show('请选择副商品！');</script>");
            		return;
            	}
            	p.set("hospitals", pstr);*/
                /*out.print("<script>mt.show('添加成功！');</script>");
                return;*/
                out.print("<script>mt.show('" + info + "',1,'/jsp/yl/user/EditProfile.jsp?member="+p.profile+"');</script>");
                return;
            }else if("upyl".equals(act)){//修改用户信息 
            	int member = h.getInt("member");
            	Profile p = Profile.find(member);
            	String mob = h.get("mob",null);
            	if(mob!=null&&mob.length()==11) {
                    ArrayList arrayList = Profile.find1(" AND mobile=" + Database.cite(mob) + " and deleted=0 ", 0, Integer.MAX_VALUE);
                    if(arrayList.size()>0){//手机号已经有了
                        if(arrayList.size()==1) {
                            Profile profile = (Profile) arrayList.get(0);
                            if(profile.profile==member){//库里是本用户

                            }else {
                                out.print("<script>mt.show('手机号已存在！');</script>");
                                return;
                            }
                        }else {
                            out.print("<script>mt.show('手机号已存在！');</script>");
                            return;
                        }
                    }
                }else {
            	    if(mob==null){
                        out.print("<script>mt.show('手机号格式有误！');</script>");
                        return;
                    }else {
                        out.print("<script>mt.show('请填写手机号！');</script>");
                        return;
                    }
                }
                String email = h.get("email",null);
            	int membertype = h.getInt("membertype");
                int hospital = h.getInt("hospital");
                int department = h.getInt("department");
                Date time = h.getDate("validity");
                
                String [] procurementUnits = h.getValues("procurementUnit");
                if(membertype==2) {
                	if(procurementUnits==null) {
                		out.print("<script>mt.show('请选择采购厂商！');</script>");
                		return;
                	}
                }
                
                p.mobile = mob;
                p.email = email;
                p.setPassword(h.get("password"));
                p.setMembertype(membertype);
                p.set();
                int isvip = h.getInt("isvip");
                p.set("isvip", isvip);
                
                p.set("openid",h.get("openid","")); //删除openid 临时的 测试完需要删除
                
                p.set("address",h.get("address","")); //收货地址-签收人医院
                
                
                String procurementUnit = "|";
                
               if(membertype==2) {
            	   String puids = "";
                   for(int i=0;i<procurementUnits.length;i++) {
                   	procurementUnit += procurementUnits[i]+"|";
                   	int puid = Integer.parseInt(procurementUnits[i]);
                   	if(i>0) {
                   		puids+= ",";
                   	}
                   	puids+= puid;
                   	ProcurementUnitJoin puj = ProcurementUnitJoin.find(puid,p.profile);
                   	if(puj.jid==0) {
                   		puj.profile = p.profile;
                   		puj.puid = puid;
                   		puj.time = new Date();
                   		puj.set();
                   	}
                   }
                   /*List<ProcurementUnitJoin> pujlist = ProcurementUnitJoin.find(" AND puid not in ("+puids+") AND profile = "+p.profile, 0, Integer.MAX_VALUE);
                   for (int i = 0; i < pujlist.size(); i++) {
                   	ProcurementUnitJoin puj = pujlist.get(i);
                   	puj.delete();
   				}     */
               }
                
                
                
                p.set("procurementUnit",procurementUnit);
                if(membertype==3){
                    p.set("procurementUnit","|"+h.getInt("company_parent")+"|");
                    if(h.getInt("company_parent")>0){//选择了服务商公司   hospitals变成该服务公司绑定的医院  |xxxx|xxxx|
                        ProcurementUnitJoin puj = ProcurementUnitJoin.find(h.getInt("company_parent"));
                        String hoid = puj.getHoid();
                        if(hoid!=null&&hoid.length()>2){// 获取到的服务商公司绑定医院 不是null  且 不是 ，
                            hoid = hoid.replaceAll(",","\\|");
                            p.set("hospitals",hoid);

                        }

                    }
                }
                p.set("company", h.get("company",""));//服务公司名称
                p.set("tax", String.valueOf(h.getInt("tax")));
                p.set("formula", String.valueOf(h.getInt("formula")));
                p.set("issalesman", h.getInt("issalesman"));
                //修改签收人之前保存的收货地址信息（目前业务逻辑为：签收人不能修改自己的电话和地址，只能由同辐管理人员修改）
                //有多个记录改多个
                ArrayList<ShopOrderAddress> sodList = ShopOrderAddress.find(" AND consignees_id = " + member, 0, Integer.MAX_VALUE);
                for (int i = 0; i <sodList.size() ; i++) {
                    ShopOrderAddress soadd = sodList.get(i);
                    soadd.setMobile(mob);
                    soadd.setAddress(h.get("address",""));
                    soadd.set();
                }
                //ShopOrderAddress soadd = ShopOrderAddress.getMember(member);
                //soadd.setMobile(mob);
                //soadd.setAddress(h.get("address",""));
                //soadd.set();
                
                if(membertype==1){
                	if(hospital>-1||department>-1){
                		if(hospital==-1){
                			out.print("<script>mt.show('请选择医院！');</script>");
                			return;
                		}
                		if(department==-1){
                			out.print("<script>mt.show('请选择科室！');</script>");
                			return;
                		}
                		if(membertype==1){
                			if(time==null){
                    			out.print("<script>mt.show('请选择有效期！');</script>");
                    			return;
                    		}
                		}
                	}
                }
                /*String [] pros = h.getValues("myproduct");
                if(p.hospitals!=null){
                	String [] sarr = p.hospitals.split("\\|");
					for(int i=1;i<sarr.length;i++){
						ShopHospital s1 = ShopHospital.find(Integer.parseInt(sarr[i]));
						s1.setAddflag(0);
						s1.set();
					}
                }
                String pstr  = "|";
            	if(pros!=null){
            		for(int i=0;i<pros.length;i++){
            			ShopHospital sh = ShopHospital.find(Integer.parseInt(pros[i]));
            			sh.setAddflag(1);
            			sh.set();
            			pstr += pros[i]+"|";
            		}
            		out.print("<script>mt.show('请选择副商品！');</script>");
            		return;
            	}
            	p.set("hospitals", pstr);*/
                if(membertype==1){
                	ShopQualification sq = ShopQualification.findByMember(member);
                	if(sq.id>0){
                		sq.hospital_id = hospital;
                		sq.department = department;
                		if(membertype>0){
                			sq.status = 2;
                			p.set("qualification","1");
                			p.set("validity",time);
                		}else{
                			sq.status = 0;
                			p.set("validity",null);
                			p.set("qualification","0");
                		}
                		sq.set();
                	}else{
                		sq.member = p.profile;
                		sq.status = 2;
                		sq.hospital_id = hospital;
                		sq.department = department;
                		sq.set();
                		//Profile p = Profile.find(sq.member);
                		p.set("validity",time);
                		//p.set("membertype", "1");
                		p.set("qualification","1");
                	}
                }
            }else if("updatehos".equals(act)){
            	int profile = h.getInt("profile");
            	Profile p = Profile.find(profile);
            	String hosstr = MT.f(p.hospitals,"|");
            	hosstr += h.get("hospital")+"|";
            	ShopHospital sh = ShopHospital.find(Integer.parseInt(h.get("hospital")));
            	sh.setAddflag(1);
            	sh.set();
            	p.set("hospitals", hosstr);
            }else if("setsign".equals(act)){
            	int profile = h.getInt("profile");
            	Profile p = Profile.find(profile);
            	int particles_sign = h.getInt("particles_sign"); 	//粒子签收人
            	int invoice_sign = h.getInt("invoice_sign");		//发票签收人
            	int hospital = h.getInt("hospital");				//所属医院
            	ShopHospital sh=ShopHospital.find(hospital);
            	String hname=sh.getName();
                //19.9.2修改
                p.set("particles_sign", particles_sign);
                p.set("invoice_sign",invoice_sign);
                if(p.hospital==null||p.hospital.length()==0||p.hospital=="0"){
                    p.set("hospital",hospital);
                }else{
                    p.set("hospital",p.hospital+"|"+hospital);
                }
                //19.9.2修改结束
            	/*if(hname.equals("山东省医学影像学研究所CT室")||hname.equals("山东省医学影像学研究所B超室")||hname.equals("山东省医学影像学研究所磁共振室")){
            		//可以是同一个收货收票人
            		int pas=p.particles_sign;
            		int ins=p.invoice_sign;
            		if(pas==1||ins==1){
            			p.set("particles_sign", particles_sign);
                    	p.set("invoice_sign",invoice_sign);
                    	if(p.hospital.indexOf(hospital)==-1){
                    		p.set("hospital",p.hospital+"|"+hospital);
                    	}
                    	
            		}else{
            			p.set("particles_sign", particles_sign);
                    	p.set("invoice_sign",invoice_sign);
                    	p.set("hospital",hospital);
            		}
            	}else{
            		p.set("particles_sign", particles_sign);
                	p.set("invoice_sign",invoice_sign);
                	p.set("hospital",hospital);
            	}*/
            	
            	
            }else if("getsign".equals(act)){
            	StringBuffer sb = new StringBuffer();
            	int hospital = h.getInt("hospital");
            	String consignees = h.get("consignees","");
            	int type = h.getInt("type",0); 	//0粒子签收，1发票签收
            	System.out.print("type="+type);
            	//查询医院下的签收人
    			List<Profile> pList = Profile.getProfileByHospitalId(hospital, type);
    			sb.append("<option value=''>--请选择--</option>");
    			for(int i=0;i<pList.size();i++){
    				Profile obj = pList.get(i);
    				if(consignees.equals(obj.getMember()))
    					sb.append("<option selected=\"selected\" value='"+obj.profile+"'>"+obj.getMember()+"</option>");
    				else
    					sb.append("<option value='"+obj.profile+"'>"+obj.getMember()+"</option>");
    			}
    			out.print(sb.toString());
    			return;
            }else if("selsign".equals(act)){
            	int profile = h.getInt("profile");
            	Profile p = Profile.find(profile);
            	List<Map<String, String>> list = new ArrayList<Map<String,String>>();
            	Map<String, String> map = new HashMap<String, String>();
            	map.put("mobile", p.mobile);
            	map.put("address", p.address);
            	list.add(map);
            	out.print(JSON.toJSON(list));
            	return;
            }else if("delsign".equals(act)){
            	int profile = h.getInt("profile");
            	Profile p = Profile.find(profile);
            	String hospitalid=h.get("hospitalid");
            	int hospital0=Integer.parseInt(hospitalid);

                //19.9.2修改
                List<String> listh=new ArrayList<String>();

                if(p.hospital.indexOf("|")==-1){
                    p.set("particles_sign", 0);
                    p.set("invoice_sign",0);
                    p.set("hospital",0);
                }else{
                    String nhs="";
                    String hos=p.hospital;

                    String[] arr=hos.split("[|]");
                    for(int i=0;i<arr.length;i++){
                        String hs=arr[i];
                        if(hs.length()>0){
                            if(!hs.equals(hospitalid)){
                                listh.add(hs);
                            }
                        }
                    }
                    for(int i=0;i<listh.size();i++){
                        String hs=listh.get(i);

                        if(i<listh.size()-1){
                            nhs+=hs+"|";
                        }else{
                            nhs+=hs;
                        }
                    }
                    p.set("hospital",nhs);
                }
                ArrayList<ShopOrderAddress> shopOrderAddresses = ShopOrderAddress.find("AND consignees=" + Database.cite(p.member)+ " AND hospitalId=" + hospital0, 0, Integer.MAX_VALUE);
                if(shopOrderAddresses.size()>0){
                    ShopOrderAddress shopOrderAddress = shopOrderAddresses.get(0);
                    shopOrderAddress.setHospitalId(0);
                    shopOrderAddress.set();
                }

                //19.9.2修改结束
            	
            	/*List<ShopHospital> lsth=ShopHospital.find(" and name="+DbAdapter.cite("山东省医学影像学研究所磁共振室"), 0, 1);
            	List<ShopHospital> lsth2=ShopHospital.find(" and name="+DbAdapter.cite("山东省医学影像学研究所B超室"), 0, 1);
            	List<ShopHospital> lsth3=ShopHospital.find(" and name="+DbAdapter.cite("山东省医学影像学研究所CT室"), 0, 1);
            	
            	boolean flag=false;
            	boolean flag2=false;
            	boolean flag3=false;
            	if(lsth.size()>0){
            		ShopHospital hospital=lsth.get(0);
            		int hid=hospital.getId();
            		if(hospital0==hid){
            			flag=true;
            		}
            	}
            	if(lsth2.size()>0){
            		ShopHospital hospital=lsth2.get(0);
            		int hid=hospital.getId();
            		if(hospital0==hid){
            			flag2=true;
            		}
            	}
            	if(lsth3.size()>0){
            		ShopHospital hospital=lsth3.get(0);
            		int hid=hospital.getId();
            		if(hospital0==hid){
            			flag3=true;
            		}
            	}
            	if(flag==true||flag2==true||flag3==true){
            		String[] hidarr=p.hospital.split("[|]");
            		if(hidarr.length==1){
            			p.set("particles_sign", 0);
                    	p.set("invoice_sign",0);
                    	p.set("hospital",0);
            		}else if(hidarr.length==2){
            			String ph=p.hospital;
            			int wz=ph.indexOf(hospitalid);
            			int len=hospitalid.length();
            			String ph2="";
            			if(wz==0){
            				ph2=ph.replace(hospitalid+"|", "");
            			}else if(wz==len+1){
            				ph2=ph.replace("|"+hospitalid, "");
            			}
            			
            			
            			p.set("hospital",ph2);
            		}else if(hidarr.length==3){
            			String ph2="";
            			String ph=p.hospital;
            			int wz=ph.indexOf(hospitalid);
            			int len=hospitalid.length();
            			if(wz==0){
            				ph2=ph.replace(hospitalid+"|", "");
            			}else if(wz==len+1){
            				ph2=ph.replace(hospitalid+"|", "");
            			}else{
            				ph2=ph.replace("|"+hospitalid, "");
            			}
            			
            			p.set("hospital",ph2);
            		}
            	}else{
            		p.set("particles_sign", 0);
                	p.set("invoice_sign",0);
                	p.set("hospital",0);
            	}*/
            	
            	
            }else if("delhos".equals(act)){
            	int profile = h.getInt("profile");
            	Profile p = Profile.find(profile);
            	int did = h.getInt("did");
            	ShopHospital sh = ShopHospital.find(did);
            	sh.setAddflag(0);
            	//sh.setExpirationDate(null);
            	sh.set();
            	String hos = MT.f(p.hospitals,"|");
            	hos = hos.replace("|"+did+"|", "|");
            	p.set("hospitals", hos);
            }else if("reemail".equals(act)){//重发邮件
            	int profile = h.getInt("profile");
            	Profile p = Profile.find(profile);
            	StringBuffer sb = new StringBuffer();
            	String url = "http://" + h.request.getServerName() + ":" + h.request.getServerPort();
                String myurl = url+"/jsp/yl/user/ActEmail.jsp?profile="+MT.enc(p.profile);
                
                //String url = "http://" + h.request.getServerName() + ":" + h.request.getServerPort();
                //String myurl = url+"/Members.do?act=actemail&test&profile="+ MT.enc(p.profile);
                sb.append("	<table width='100%' border='0' cellspacing='0' cellpadding='0' style='width:700px;margin:0 auto;text-align:left;font-size:14px;'>");
                sb.append("	  <tr>");
                sb.append("	    <td><img src='http://123.57.64.192/res/Home/structure/14102049.jpg' /></td>");
                sb.append("	    <td style='' valign='bottom'><a href='http://123.57.64.192/html/folder/14102033-1.htm' style='color:blue;font-size:12px;text-decoration:none;'>登录</a></td>");
                sb.append("	  </tr>");
                sb.append("		<tr>");
                sb.append("			<td colspan='2' style='padding:15px 0 20px;color:#000;font-weight:bold'>亲爱的用户您好！</td>	</tr>");
                sb.append("			<tr><td colspan='2'>感谢您注册粒子治疗会员！您现在只需点击以下链接，即可完成注册。</td>	</tr>");
                sb.append("			<tr><td colspan='2' style='color:red;padding:20px 0;font-weight:bold'><a href='"+myurl+"'>点击激活粒子治疗账户</a></td>	</tr>");
                sb.append("			<tr><td colspan='2'>如果上述文字点击无效，请把下面网页地址复制到浏览器地址栏中打开：</td>	</tr>");
                sb.append("			<tr><td colspan='2' style='padding:5px 0'><a href='#' style='color:#acacac;text-decoration:none;'>"+myurl+"</a></td>");
                sb.append("			</tr>");
                sb.append("			<tr><td colspan='2' style='padding:15px 0 10px;color:#000;font-weight:bold'>安全小贴士</td></tr>");
                sb.append("			<tr><td colspan='2' style='line-height:180%;color:#0077FF;padding:0'><p style='padding:0;margin:0'>请绝对不要向欺诈性网站提供您的密码。</p>");
                sb.append("					<p style='padding:0;margin:0'>为了安全地访问粒子治疗或您的账户，请打开一个新的浏览器（例如：Internet Explorer ），然后键入粒子治疗网址：http://，确保自己在真正的粒子治疗网站上。</p>");
                sb.append("					<p style='padding:0;margin:0'>粒子治疗绝不会要求您在电子邮件中输入密码。</p>");
                sb.append("					<p style='padding:0;margin:0'>请您绝对不要将粒子治疗密码提供给任何人，包括员工。</p>");
                sb.append("					</td>");
                sb.append("				</tr>");
                sb.append("	</table>");
                
                //sb.append(myurl);
                boolean flag = Email.create(h.community,null,p.email,"激活账号",sb.toString());
                /*if(!flag){
             		out.print("<script>mt.show('邮件发送失败！');</script>");
             		return;
             	}
                out.print("<script>mt.show('邮件发送成功！');</script>");*/
                out.print("<script>mt.show('邮件发送成功！');</script>");
                return;
            }else if("sendemail".equals(act)){//更换邮件 发送邮件
            	String sname = "verify";
                if(!h.get("verify1").equalsIgnoreCase((String) session.getAttribute(sname)))
                {
                    out.print("<script>mt.show('“验证码”不正确！');</script>");
                    return;
                }
                
                int profile = h.getInt("profile");
            	Profile p = Profile.find(profile);
            	StringBuffer sb = new StringBuffer();
            	String url = "http://" + h.request.getServerName() + ":" + h.request.getServerPort();
            	MessageList ml = new MessageList(0);
            	ml.email = p.email;
            	ml.profile = p.profile;
            	ml.ispass = 0;
            	ml.set();
                String myurl = url+"/Members.do?act=updaemail&mesid="+MT.enc(ml.id);
                //String url = "http://" + h.request.getServerName() + ":" + h.request.getServerPort();
                //String myurl = url+"/Members.do?act=actemail&test&profile="+ MT.enc(p.profile);
                sb.append("	<table width='100%' border='0' cellspacing='0' cellpadding='0' style='width:700px;margin:0 auto;text-align:left;font-size:14px;'>");
                sb.append("	  <tr>");
                sb.append("	    <td><img src='http://123.57.64.192/res/Home/structure/14102049.jpg' /></td>");
                sb.append("	    <td style='' valign='bottom'><a href='http://123.57.64.192/html/folder/14102033-1.htm' style='color:blue;font-size:12px;text-decoration:none;'>登录</a></td>");
                sb.append("	  </tr>");
                sb.append("		<tr>");
                sb.append("			<td colspan='2' style='padding:15px 0 20px;color:#000;font-weight:bold'>亲爱的用户您好！</td>	</tr>");
                //sb.append("			<tr><td colspan='2'>感谢您注册粒子治疗会员！您现在只需点击以下链接，即可完成注册。</td>	</tr>");
                sb.append("			<tr><td colspan='2' style='color:red;padding:20px 0;font-weight:bold'><a href='"+myurl+"'>点击修改邮箱</a></td>	</tr>");
                sb.append("			<tr><td colspan='2'>如果上述文字点击无效，请把下面网页地址复制到浏览器地址栏中打开：</td>	</tr>");
                sb.append("			<tr><td colspan='2' style='padding:5px 0'><a href='#' style='color:#acacac;text-decoration:none;'>"+myurl+"</a></td>");
                sb.append("			</tr>");
                sb.append("			<tr><td colspan='2' style='padding:15px 0 10px;color:#000;font-weight:bold'>安全小贴士</td></tr>");
                sb.append("			<tr><td colspan='2' style='line-height:180%;color:#0077FF;padding:0'><p style='padding:0;margin:0'>请绝对不要向欺诈性网站提供您的密码。</p>");
                sb.append("					<p style='padding:0;margin:0'>为了安全地访问粒子治疗或您的账户，请打开一个新的浏览器（例如：Internet Explorer ），然后键入粒子治疗网址：http://，确保自己在真正的粒子治疗网站上。</p>");
                sb.append("					<p style='padding:0;margin:0'>粒子治疗绝不会要求您在电子邮件中输入密码。</p>");
                sb.append("					<p style='padding:0;margin:0'>请您绝对不要将粒子治疗密码提供给任何人，包括员工。</p>");
                sb.append("					</td>");
                sb.append("				</tr>");
                sb.append("	</table>");
                
                //sb.append(myurl);
                boolean flag = Email.create(h.community,null,p.email,"修改邮箱",sb.toString());
                /*if(!flag){
             		out.print("<script>mt.show('邮件发送失败！');</script>");
             		return;
             	}
                out.print("<script>mt.show('邮件发送成功！');</script>");*/
                out.print("<script>mt.show('邮件发送成功！');</script>");
                return;
            }else if("updaemail".equals(act)){//收到邮件 进入修改邮箱页面
            	String mese = h.get("mesid");
            	int mesid = 0;
            	try {
            		mesid = Integer.parseInt(MT.dec(mese));
            		MessageList ml = MessageList.find(mesid);
            		if(ml.ispass==0){
            			ml.set("ispass","1");
            			session.setAttribute("emailflag", "1");
            			//out.print("<script>location='/jsp/yl/shopweb/ShopCheckEmailMobile2.jsp?type=email';</script>");
            			return;
            		}else{
            			//out.print("<script>alert('已经进入过链接');</script>");
            		}
				} catch (Exception e) {
				}
            	out.print("<script>location='/html/folder/14110435-1.htm?type=email';</script>");
            	//response.sendRedirect("/jsp/yl/shopweb/ShopCheckEmailMobile.jsp?type=email");
            	//request.getRequestDispatcher("/jsp/yl/shopweb/ShopCheckEmailMobile.jsp?type=email").forward(request, response);
            	//out.print("<script>location='/jsp/yl/shopweb/ShopCheckEmailMobile.jsp?type=email';</script>");
    			return;
            }else if("successcheckeamil".equals(act)){//重置发送邮件
            	String sname = "verify";
                if(!h.get("verify1").equalsIgnoreCase((String) session.getAttribute(sname)))
                {
                    out.print("<script>mt.show('“验证码”不正确！');</script>");
                    return;
                }
                int profile = h.getInt("profile");
                String email = h.get("email");
                int eflag = Profile.count(" AND email = "+Database.cite(email));
            	if(eflag>0){
            		out.print("<script>mt.show('邮箱已被注册！');</script>");
            		return;
            	}
                Profile p = Profile.find(profile);
                StringBuffer sb = new StringBuffer();
                MessageList ml = new MessageList(0);
            	ml.email = email;
            	ml.profile = p.profile;
            	ml.ispass = 0;
            	ml.set();
            	String url = "http://" + h.request.getServerName() + ":" + h.request.getServerPort();
                String myurl = url+"/Members.do?act=replaceemail&mesid="+MT.enc(ml.id);
                //String url = "http://" + h.request.getServerName() + ":" + h.request.getServerPort();
                //String myurl = url+"/Members.do?act=actemail&test&profile="+ MT.enc(p.profile);
                sb.append("	<table width='100%' border='0' cellspacing='0' cellpadding='0' style='width:700px;margin:0 auto;text-align:left;font-size:14px;'>");
                sb.append("	  <tr>");
                sb.append("	    <td><img src='http://123.57.64.192/res/Home/structure/14102049.jpg' /></td>");
                sb.append("	    <td style='' valign='bottom'><a href='http://123.57.64.192/html/folder/14102033-1.htm' style='color:blue;font-size:12px;text-decoration:none;'>登录</a></td>");
                sb.append("	  </tr>");
                sb.append("		<tr>");
                sb.append("			<td colspan='2' style='padding:15px 0 20px;color:#000;font-weight:bold'>亲爱的用户您好！</td>	</tr>");
                //sb.append("			<tr><td colspan='2'>感谢您注册粒子治疗会员！您现在只需点击以下链接，即可完成注册。</td>	</tr>");
                sb.append("			<tr><td colspan='2' style='color:red;padding:20px 0;font-weight:bold'><a href='"+myurl+"'>点击验证邮箱</a></td>	</tr>");
                sb.append("			<tr><td colspan='2'>如果上述文字点击无效，请把下面网页地址复制到浏览器地址栏中打开：</td>	</tr>");
                sb.append("			<tr><td colspan='2' style='padding:5px 0'><a href='#' style='color:#acacac;text-decoration:none;'>"+myurl+"</a></td>");
                sb.append("			</tr>");
                sb.append("			<tr><td colspan='2' style='padding:15px 0 10px;color:#000;font-weight:bold'>安全小贴士</td></tr>");
                sb.append("			<tr><td colspan='2' style='line-height:180%;color:#0077FF;padding:0'><p style='padding:0;margin:0'>请绝对不要向欺诈性网站提供您的密码。</p>");
                sb.append("					<p style='padding:0;margin:0'>为了安全地访问粒子治疗或您的账户，请打开一个新的浏览器（例如：Internet Explorer ），然后键入粒子治疗网址：http://，确保自己在真正的粒子治疗网站上。</p>");
                sb.append("					<p style='padding:0;margin:0'>粒子治疗绝不会要求您在电子邮件中输入密码。</p>");
                sb.append("					<p style='padding:0;margin:0'>请您绝对不要将粒子治疗密码提供给任何人，包括员工。</p>");
                sb.append("					</td>");
                sb.append("				</tr>");
                sb.append("	</table>");
                
                //sb.append(myurl);
                boolean flag = Email.create(h.community,null,email,"验证邮箱",sb.toString());
                /*if(!flag){
             		out.print("<script>mt.show('邮件发送失败！');</script>");
             		return;
             	}
                out.print("<script>mt.show('邮件发送成功！');</script>");*/
                out.print("<script>mt.show('邮件发送成功！');</script>");
                return;
            }/*else if("successcheckeamil".equals(act)){//重置发送邮件
            	String sname = "verify";
                if(!h.get("verify1").equalsIgnoreCase((String) session.getAttribute(sname)))
                {
                    out.print("<script>mt.show('“验证码”不正确！');</script>");
                    return;
                }
                int profile = h.getInt("profile");
                String email = h.get("email");
                Profile p = Profile.find(profile);
                StringBuffer sb = new StringBuffer();
                MessageList ml = new MessageList(0);
            	ml.email = email;
            	ml.profile = p.profile;
            	ml.ispass = 0;
            	ml.set();
            	String url = "http://" + h.request.getServerName() + ":" + h.request.getServerPort();
                String myurl = url+"/Members.do?act=replaceemail&mesid="+MT.enc(ml.id);
                sb.append(myurl);
                boolean flag = Email.create(h.community,"robot@redcome.com",email,"激活账号",sb.toString());
                if(!flag){
             		out.print("<script>mt.show('邮件发送失败！');</script>");
             		return;
             	}
                out.print("<script>mt.show('邮件发送成功！');</script>");
                out.print("<script>mt.show('邮件发送成功！');</script>");
                return;
            }*/else if("replaceemail".equals(act)){//替换邮箱
            	String mese = h.get("mesid");
            	int mesid = 0;
            	try {
            		mesid = Integer.parseInt(MT.dec(mese));
            		MessageList ml = MessageList.find(mesid);
            		if(ml.ispass==0){
            			ml.set("ispass","1");
            			Profile p = Profile.find(ml.profile);
            			p.set("email", ml.email);
            			return;
            		}else{
            			//out.print("<script>alert('已经进入过链接');</script>");
            		}
				} catch (Exception e) {
				}
            	out.print("<script>location = '/html/folder/14110054-1.htm';</script>");
    			return;
            }else if("mobcheck".equals(act)){//验证之前手机
            	String mob = h.get("mob");

            	String sname = "verify";
                if(!h.get("verify").equalsIgnoreCase((String) session.getAttribute(sname)))
                {
                    out.print("<script>mt.show('“验证码”不正确！');</script>");
                    return;
                }
                String verid = h.get("verid");
                	String code = String.valueOf(session.getAttribute(mob
                			+ "_code"));
                	if(!verid.equals(code)){
                		out.print("<script>mt.show('手机验证码错误！');</script>");
                		return;
                	}
                	session.setAttribute("emailflag", "1");
                	//out.print("<script>location='/jsp/yl/shopweb/ShopCheckEmailMobile2.jsp?type=mobile';</script>");
                	out.print("<script>mt.show('验证通过！',1,'/jsp/yl/shopweb/ShopCheckEmailMobile2.jsp?type=mobile');</script>");
                	//response.sendRedirect("/jsp/yl/shopweb/ShopCheckEmailMobile2.jsp?type=mobile");
                	return;
            }else if("replacemob".equals(act)){//替换手机
            	String mob = h.get("mob");
            	int member = h.member;
            	String sname = "verify";
                if(!h.get("verify").equalsIgnoreCase((String) session.getAttribute(sname)))
                {
                    out.print("<script>mt.show('“验证码”不正确！');</script>");
                    return;
                }
                String verid = h.get("verid");
                	int flag = Profile.count(" AND mobile = "+Database.cite(mob));
                	if(flag>0){
                		out.print("<script>mt.show('手机已被注册！');</script>");
                		return;
                	}
                	String code = String.valueOf(session.getAttribute(mob
                			+ "_code"));
                	if(!verid.equals(code)){
                		out.print("<script>mt.show('手机验证码错误！');</script>");
                		return;
                	}
                Profile.find(member).set("mobile",mob);
                out.print("<script>mt.show('绑定成功！',1,'/jsp/yl/shopweb/ShopMemberEdit.jsp');</script>");
    			return;
            }else if("yllogin".equals(act)){
            	
            	String member = h.get("username1");
            	String password = h.get("password");
            	String verify = h.get("verify");
                String str = h.getCook("verify",null);
                if((str != null || verify != null) && (str == null || !MT.dec(str).equalsIgnoreCase(verify)))
                {
                    out.print("<script>mt.show('抱歉，验证码错误！');</script>");
                    return;
                }
                h.setCook("verify",null,0);
                //
                int eflag = Profile.count(" AND  email = "+Database.cite(member)+" AND password = "+Database.cite(password));
                int mflag = Profile.count(" AND  mobile = "+Database.cite(member)+" AND password = "+Database.cite(password));
                int uflag = Profile.count(" AND  member = "+Database.cite(member)+" AND password = "+Database.cite(password));
                
                if(eflag==0&&mflag==0&&uflag==0)
                {
                    out.print("<script>mt.show('用户名或密码错误！');</script>");
                    return;
                }
                Profile p = Profile.find(0);
                if(eflag>0){
                	ArrayList al = Profile.find1(" AND email=" +Database.cite(member) ,0,1);
                    p = al.size() < 1 ? Profile.find(0) : (Profile) al.get(0);
                }else if(mflag>0){
                	ArrayList al = Profile.find1(" AND mobile=" +Database.cite(member),0,1);
                    p = al.size() < 1 ? Profile.find(0) : (Profile) al.get(0);
                }else if(uflag>0){
                	ArrayList al = Profile.find1(" AND member=" +Database.cite(member),0,1);
                    p = al.size() < 1 ? Profile.find(0) : (Profile) al.get(0);
                }
                if(p.emailflag==1){
                	String url = "/Members.do?act=resemail&member="+p.member;
					out.print("<script>mt.show(\"" + Res.get(h.language,"您不能登录！您还没有验证电子邮箱！<br/><br/>没有收到邮件？{0}重发邮件</a>","<a href=" + url + " target=_ajax>") + "\");</script>");
					return;
                }
                if(p.deleted){
                	out.print("<script>mt.show('用户已被删除！');</script>");
                    return;
                }
                
                if(p.isLocking())
                {
                    out.print("<script>alert('该用户已被锁定，暂时无法登录！');</script>");
                    return;
                }
                if(MT.f(p.openid).length()>0){
                	String openid = h.getCook("openid", "");
                    if(!"".equals(openid)){
	                	 out.print("<script>alert('该用户已被绑定，暂时无法登录！');</script>");
	                     return;
                    }
                }else{
                	//设置openid
                    String openid = h.getCook("openid", "");
                    if(!"".equals(openid) && null != openid){
                    	boolean flag = Profile.flagopenid(openid);
                    	if(!flag){
                    		p.set("openid", openid);
                    	}
                    }
                }
                
                String auto = h.get("autologin","");
                if(auto.length()>0)
                {
                	h.setCook("autologin",MT.enc(p.getLogint() + "|" + member + "|" + p.getPassword()),7*60*24);
                }
                RV rv = new RV(member);
                Logs.create("Home",rv,1,h.node,request.getRemoteAddr());
                //OnlineList.create(session.getId(),h.community,member,request.getRemoteAddr());
                p.setLogin(request.getRemoteAddr(),request.getHeader("user-agent") + " Screen/" + request.getParameter("screen"),new Date());
                Community c = Community.find(h.community);
                h.member = p.getProfile();
                session.setAttribute("member",h.member);
                if(c.isSession())
                {
                    //session.setAttribute("tea.RV",rv);
                } else
                {
                    h.setCook("member",MT.enc(p.getLogint() + "|" + h.member + "|" + p.getPassword()),h.getInt("expiry", -1));
                }
                out.print("<script>top.location.replace('" + nexturl + "');</script>");//parent
                return;
            }else if("autologin".equals(act)){
            	String userinfo = MT.dec(h.getCook("autologin", ""));
            	String [] infoarr = userinfo.split("\\|");
            	String member = infoarr[1];
            	Profile p = Profile.find(member);
            	RV rv = new RV(member);
                Logs.create(h.community,rv,1,h.node,request.getRemoteAddr());
                //OnlineList.create(session.getId(),h.community,member,request.getRemoteAddr());
                p.setLogin(request.getRemoteAddr(),request.getHeader("user-agent") + " Screen/" + request.getParameter("screen"),new Date());
                Community c = Community.find(h.community);
                h.member = p.getProfile();
                session.setAttribute("member",h.member);
                if(c.isSession())
                {
                    //session.setAttribute("tea.RV",rv);
                } else
                {
                    h.setCook("member",MT.enc(p.getLogint() + "|" + h.member + "|" + p.getPassword()),h.getInt("expiry", -1));
                }
                //out.print("<script>parent.location.reload();</script>");//parent
            }else if("ylloginmobile".equals(act)){
            	//2017-06-05新加的登陆。由原来的yllogin复制而来。主要修改验证码部分，验证码是通过手机短信获取到的。
            	String hname=h.get("hname","");
            	String member = h.get("username1");
            	String password = h.get("password");
            	String verify = h.get("verify");
            	
                //String str = h.getCook("verify",null);
            	String str=h.get("pincode");
                if((str != null || verify != null) && (str == null || !str.equals(verify)))
                {
                    out.print("<script>mt.show('抱歉，验证码错误！');</script>");
                    return;
                }
                h.setCook("verify",null,0);
                //
                int eflag = Profile.count(" AND  email = "+Database.cite(member)+" AND password = "+Database.cite(password));
                int mflag = Profile.count(" AND  mobile = "+Database.cite(member)+" AND password = "+Database.cite(password));
                int uflag = Profile.count(" AND  member = "+Database.cite(member)+" AND password = "+Database.cite(password));
                
                if(eflag==0&&mflag==0&&uflag==0)
                {
                    out.print("<script>mt.show('用户名或密码错误！');</script>");
                    return;
                }
                Profile p = Profile.find(0);
                if(eflag>0){
                	ArrayList al = Profile.find1(" AND email=" +Database.cite(member) ,0,1);
                    p = al.size() < 1 ? Profile.find(0) : (Profile) al.get(0);
                }else if(mflag>0){
                	ArrayList al = Profile.find1(" AND mobile=" +Database.cite(member),0,1);
                    p = al.size() < 1 ? Profile.find(0) : (Profile) al.get(0);
                }else if(uflag>0){
                	List al=new ArrayList();
                	if(hname.length()>0){
                		al = Profile.find1(" AND member=" +Database.cite(member)+" and hospital in (select id from shophospital where name like "+Database.cite("%"+hname+"%")+")",0,1);
                        
                	}else{
                		al = Profile.find1(" AND member=" +Database.cite(member),0,1);
                        
                	}
                	
                	p = al.size() < 1 ? Profile.find(0) : (Profile) al.get(0);
                }
                if(p.emailflag==1){
                	String url = "/Members.do?act=resemail&member="+p.member;
					out.print("<script>mt.show(\"" + Res.get(h.language,"您不能登录！您还没有验证电子邮箱！<br/><br/>没有收到邮件？{0}重发邮件</a>","<a href=" + url + " target=_ajax>") + "\");</script>");
					return;
                }
                if(p.deleted){
                	out.print("<script>mt.show('用户已被删除！');</script>");
                    return;
                }
                
                if(p.isLocking())
                {
                    out.print("<script>alert('该用户已被锁定，暂时无法登录！');</script>");
                    return;
                }
                Filex.logs("yt_qianshou2.txt", "login:openid==="+p.openid);
                if(MT.f(p.openid).length()>0){
                	//String openid = h.getCook("openid", "");
                	h.setCook("openid", p.openid, -1);
                	/*Filex.logs("yt_qianshou2.txt", "login:openid2==="+openid);
                    if(!"".equals(openid)){
	                	 out.print("<script>alert('该用户已被绑定，暂时无法登录！');</script>");
	                     return;
                    }*/
                }else{
                	//设置openid
                    String openid = h.getCook("openid", "");
                    Filex.logs("yt_qianshou2.txt", "login:openid3==="+openid);
                    if(!"".equals(openid) && null != openid){
                    	boolean flag = Profile.flagopenid(openid);
                    	if(!flag){
                    		p.set("openid", openid);
                    	}
                    }
                }
                
                String auto = h.get("autologin","");
                if(auto.length()>0)
                {
                	h.setCook("autologin",MT.enc(p.getLogint() + "|" + member + "|" + p.getPassword()),7*60*24);
                }
                RV rv = new RV(member);
                Logs.create("Home",rv,1,h.node,request.getRemoteAddr());
                //OnlineList.create(session.getId(),h.community,member,request.getRemoteAddr());
                p.setLogin(request.getRemoteAddr(),request.getHeader("user-agent") + " Screen/" + request.getParameter("screen"),new Date());
                Community c = Community.find(h.community);
                h.member = p.getProfile();
                session.setAttribute("member",h.member);
                if(c.isSession())
                {
                    //session.setAttribute("tea.RV",rv);
                } else
                {
                    //h.setCook("member",MT.enc(p.getLogint() + "|" + h.member + "|" + p.getPassword()),h.getInt("expiry", -1));
                	h.setCook("member",MT.enc(p.getLogint() + "|" + h.member + "|" + p.getPassword()),h.getInt("expiry", -1));
                	Filex.logs("yt_nologin.txt", "members:"+p.getLogint() + "|" + h.member + "|" + p.getPassword()+"===="+h.getInt("expiry", -1));
                    
                }
                Filex.logs("yt_qianshou2.txt", "login:nexturl==="+nexturl);
                out.print("<script>top.location.replace('" + nexturl + "');</script>");//parent
                return;
            }else if("delete".equals(act)){
            	int member = h.getInt("member");
            	Profile p = Profile.find(member);
            	p.set("openid", "");
            	if(MT.f(p.hospitals).length() > 1){
            		info = "请先解除其绑定的医院！";
            	}else{
            		p.delete();
            	}
            }else if("bangding_mail".equals(act)){//绑定更改后的邮箱
                out.println("<script>var mt=parent.parent.mt,doc=parent.parent.document;</script>");
                String message = "操作执行成功！";
                String new_mail = h.get("new_mail");
                Object attribute = session.getAttribute(new_mail + "_code");//获取ajax发送邮箱的5位验证码，存在session
                System.out.println(attribute);
                String verify = h.get("verify1");//获取页面输入的验证码
                if(attribute.equals(verify)){//相同
                    int profile = h.getInt("profile");//获取用户
                    Profile p = Profile.find(profile);
                    p.setEmail(new_mail);
                    p.set();
                    out.print("<script>mt.show('" + message + "',1,'"+nexturl+"');</script>");
                    return;
                }else {
                    out.print("<script>mt.show('验证码错误，请重新操作',1,'"+nexturl+"');</script>");
                    return ;
                }
            } else
            {
                String key = h.get("member");
                int member = key.length() < 1 ? 0 : Integer.parseInt(MT.dec(key));
                String[] arr = member < 1 ? h.getValues("members") : new String[]
                               {String.valueOf(member)};
                if("lock".equals(act)) //锁定会员
                {
                    boolean locking = h.getBool("locking");
                    for(int i = 0;i < arr.length;i++)
                    {
                        Profile p = Profile.find(Integer.parseInt(arr[i]));
                        p.setLocking(locking);
                    }
                } else if("del".equals(act)) //批量删除用户
                {
                    for(int i = 0;i < arr.length;i++)
                    {
                        Profile p = Profile.find(Integer.parseInt(arr[i]));
                        p.delete();
                    }
                } else if("merge".equals(act))
                {
                    Profile m = Profile.find(h.getInt("merge"));
                    StringBuilder sb = new StringBuilder();
                    AdminUsrRole aur = AdminUsrRole.find(h.community,m.profile);
                    for(int i = 0;i < arr.length;i++)
                    {
                        Profile p = Profile.find(Integer.parseInt(arr[i]));
                        sb.append(p.profile + ",");
                        if(p.profile == m.profile)
                            continue;
                        AdminUsrRole pr = AdminUsrRole.find(h.community,p.profile);
                        if(MT.f(m.mobile).length() < 1)
                            m.mobile = p.mobile;
                        if(MT.f(m.email).length() < 1)
                            m.email = p.email;
                        if(MT.f(m.qq).length() < 1)
                            m.qq = p.qq;
                        if(m.birth == null)
                            m.birth = p.birth;

                        if(MT.f(m.getFunctions(h.language)).length() < 1)
                            m.setFunctions(p.getFunctions(h.language),h.language);
                        if(MT.f(m.getDegree(h.language)).length() < 1)
                            m.setDegree(p.getDegree(h.language),h.language);
                        if(MT.f(m.getSchool(h.language)).length() < 1)
                            m.setSchool(p.getSchool(h.language),h.language);
                        if(MT.f(m.getJob(h.language)).length() < 1)
                            m.setJob(p.getJob(h.language),h.language);
                        if(MT.f(m.getOrganization(h.language)).length() < 1)
                            m.setOrganization(p.getOrganization(h.language),h.language);
                        if(MT.f(m.getTitle(h.language)).length() < 1)
                            m.setTitle(p.getTitle(h.language),h.language);
                        if(MT.f(m.getTelephone(h.language)).length() < 1)
                            m.setTelephone(p.getTelephone(h.language),h.language);
                        if(MT.f(m.getFax(h.language)).length() < 1)
                            m.setFax(p.getFax(h.language),h.language);
                        if(MT.f(m.getAddress(h.language)).length() < 1)
                            m.setAddress(p.getAddress(h.language),h.language);
                        if(MT.f(m.getPhotopath2(h.language)).length() < 1)
                            m.set(h.language,"photopath2",p.getPhotopath2(h.language));
                        //角色
                        aur.setRole(merge(aur.role,pr.role));
                        aur.setClasses(merge(aur.classes,pr.classes));
                        aur.setDept(merge(aur.dept,pr.dept));
                        DbAdapter db = new DbAdapter();
                        try
                        {
                            db.setAutoCommit(false);
                            //db.executeUpdate("UPDATE SupAnswering SET memberid=" + m.profile + " WHERE memberid=" + p.profile);
                            String[] fs =
                                    {};
                            for(int j = 0;j < fs.length;j++)
                            {
                                db.executeUpdate("UPDATE SupBidding SET " + fs[j] + "=" + m.profile + " WHERE " + fs[j] + "=" + p.profile);
                            }
                            String[] ts =
                                    {};
                            for(int j = 0;j < ts.length;j++)
                            {
                                db.executeUpdate("UPDATE " + ts[j] + " SET member=" + m.profile + " WHERE member=" + p.profile);
                            }
                        } finally
                        {
                            db.setAutoCommit(true);
                            db.close();
                        }
                        p.delete();
                    }
                    m.set();
                    sb.append("合并为：" + m.profile);
                    Filex.logs("Members.log",sb.toString());
                }
            }
            out.print("<script>mt.show('" + info + "',1,'" + nexturl + "');</script>");
        } catch(Exception ex)
        {
            out.print("<textarea id='ta'>" + ex.toString() + "</textarea><script>mt.show(document.getElementById('ta').value,1,'出现未知错误！');</script>");
            ex.printStackTrace();
        } finally
        {
            out.close();
        }
    }

    String merge(String s1,String s2)
    {
        String[] arr = s1.split("/");
        for(int i = 1;i < arr.length;i++)
        {
            if(s2.contains("/" + arr[i] + "/"))
                continue;
            s2 += arr[i] + "/";
        }
        return s2;
    }
}
