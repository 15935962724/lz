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
                if("exp".equals(act)) //????????????
                {
                    response.setHeader("Content-Disposition","attachment; filename=" + new String("??????.xls".getBytes("GBK"),"ISO-8859-1"));
                    WritableWorkbook wwb = jxl.Workbook.createWorkbook(response.getOutputStream());
                    WritableSheet ws = wwb.createSheet("?????????",0);
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
                    ws.addCell(new Label(j++,1,"?????????",cf));
                    ws.addCell(new Label(j++,1,"??????",cf));
                    ws.addCell(new Label(j++,1,"??????",cf));
                    //ws.addCell(new Label(j++,1,"??????",cf));
                    ws.addCell(new Label(j++,1,"????????????",cf));
                    //ws.addCell(new Label(j++,1,"????????????",cf));
                    ws.addCell(new Label(j++,1,"??????",cf));
                    //ws.addCell(new Label(j++,1,"??????",cf));
                    ws.addCell(new Label(j++,1,"????????????",cf));
                    Enumeration e = Profile.find(h.key,0,Integer.MAX_VALUE);
                    for(int i = 2;e.hasMoreElements();i++)
                    {
                        String member = (String) e.nextElement();
                        Profile t = Profile.find(member);
                        j = 0;
                        ws.addCell(new Label(j++,i,member));
                        ws.addCell(new Label(j++,i,t.getName(h.language)));
                        ws.addCell(new Label(j++,i,t.isSex() ? "???" : "???"));
                        //ws.addCell(new Label(j++,i,t.city > 0 ? Card.find(t.city).toString() : ""));
                        ws.addCell(new Label(j++,i,t.getEmail()));
                        ws.addCell(new Label(j++,i,t.getTelephone(h.language)));
                        //ws.addCell(new Label(j++,i,t.valid ? "??????" : "?????????"));
                        //ws.addCell(new jxl.write.Number(j++,i,t.getPoint()));
                        ws.addCell(new Label(j++,i,MT.f(t.getTime(),1)));
                    }
                    wwb.write();
                    wwb.close();
                } else if("westracexp".equals(act)) //????????? ??????
                {
                    response.setHeader("Content-Disposition","attachment; filename=" + new String("??????.xls".getBytes("GBK"),"ISO-8859-1"));
                    WritableWorkbook wwb = jxl.Workbook.createWorkbook(response.getOutputStream());
                    WritableSheet ws = wwb.createSheet("?????????",0);
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
                    ws.addCell(new Label(j++,1,"?????????",cf));
                    ws.addCell(new Label(j++,1,"??????",cf));
                    ws.addCell(new Label(j++,1,"????????????",cf));
                    ws.addCell(new Label(j++,1,"????????????",cf));
                    ws.addCell(new Label(j++,1,"??????",cf));
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
            if("uploadavatar".equals(a)) //????????????
            {
                String avatar = h.get("Filedata");
                session.setAttribute("avatar",avatar); //Chrome,????????????????????????
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
				          json.put("mes", "????????????????????????");
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
				          json.put("mes", "???????????????????????????");
					}
				out.print(json.toString());
				return;
		      }else if("editFloorPrice".equals(act)){//20200701 ?????????????????????   ???????????????????????? ?????????
                String message = "?????????????????????";
                String[] sizes = h.getValues("size");
                String[] floorPrize = h.getValues("floorprize");
                int category = h.getInt("id");
                ProcurementUnitJoin p = ProcurementUnitJoin.find(category);
                if(sizes==null||floorPrize==null){
                    out.print("<script>mt.show('???????????????',1,'" + nexturl + "');</script>");
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
                    json.put("mes", "???????????????????????????");
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
            	
            	
            	//???????????????????????????????????????????????????????????????????????????????????????????????????????????????0
            	String username=h.get("username");//???????????????
            	String hname=h.get("hname","");//????????????
            	Profile profile=null;
            	if(hname.length()>0){
            		profile=Profile.findbyhospital(username,hname);
            	}else{
            		profile=Profile.find(username);
            	}
            	
            	String password=h.get("password");//????????????
            	
            	if(profile.profile>0){
            		if(!password.equals(profile.password)){
                		out.print("1");
                		
                	}else{
                		String mobile=profile.mobile;
                		Filex.logs("yt_mobile.txt", profile.profile+","+profile.mobile);
                		if(mobile!=null&&mobile!=""){
                			//?????????????????????
                			Filex.logs("yt_mobile.txt", "==================ER:"+profile.profile+","+username+","+mobile+","+profile.mobile);
                			String str = "";
                			str += (int)(Math.random()*9+1);
                			for(int i = 0; i < 3; i++){
                				str += (int)(Math.random()*10);
                			}
                			int num = Integer.parseInt(str);
                			SMSMessage.create("Home", profile.member, profile.mobile, h.language, "?????????????????????"+num);
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
            if("login".equals(act)) //??????
            {
                String verify = h.get("verify");
                String str = h.getCook("verify",null);
                if((str != null || verify != null) && (str == null || !MT.dec(str).equalsIgnoreCase(verify)))
                {
                    out.print("<script>alert('???????????????????????????');</script>");
                    return;
                }
                h.setCook("verify",null,0);
                //
                String member = h.get("LoginId");
                String password = h.get("Password");
                if(!Profile.isPassword(member,password))
                {
                    out.print("<script>alert('???????????????????????????');</script>");
                    return;
                }
                Profile p = Profile.find(member);
                if(p.isLocking())
                {
                    out.print("<script>alert('?????????????????????????????????????????????');</script>");
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
                    out.print("<script>mt.show('?????????" + member + "???????????????');</script>");
                    return;
                }
                String verify = h.get("verify");
                String str = h.getCook("verify",null);
                if((str != null || verify != null) && (str == null || !MT.dec(str).equalsIgnoreCase(verify)))
                {
                    out.print("<script>mt.show('???????????????????????????');</script>");
                    return;
                }

                //??????
                Profile p = new Profile(0);
                p.member = member;
                p.password = h.get("password");
                p.community = h.community;
                p.email = h.get("email");
                p.type = h.getInt("type");
                p.set();
                p.setFirstName(h.get("firstname"), h.language);
                
                //??????
                RV rv = new RV(member);
                Logs.create(h.community,rv,1,h.node,request.getRemoteAddr());
                OnlineList.create(session.getId(),h.community,member,request.getRemoteAddr());
                session.setAttribute("member",p.getProfile());
                h.setCook("member",MT.enc(p.getProfile() + "|" + p.getPassword()), -1);
                p.setLogin(request.getRemoteAddr(),request.getHeader("user-agent") + " Screen/" + request.getParameter("screen"),new Date());
                out.print("<script>mt.show('???????????????',1,'" + nexturl + "');</script>");
                return;
            }
            String info = Res.get(h.language,"?????????????????????");
            if("get".equals(act)) //????????????
            {
                if(!h.get("verify","").equalsIgnoreCase((String) session.getAttribute("verify")))
                {
                    out.print("<script>mt.show('?????????????????????????????????');</script>");
                    return;
                }
                String username = h.get("username");
                if(username == null || !Profile.isExisted(username))
                {
                    out.print("<script>mt.show('???????????????????????????????????????');</script>");
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
                	//sb.append("<b>?????????????????????????????????????????????????????????????????????????????????</b>");
                	sb.append("<br/>????????????" + username);
                	sb.append("<br/>????????????" + p.getPassword());
                	sb.append("<br/><a href='" + url + "/servlet/StartLogin?community=" + h.community + "'>??????</a>");
                	sb.append("<br/><div style='color:#999999'>");
                	sb.append("<br/>???????????????????????????????????????????????????????????????");
                	sb.append("<br/>????????????????????????????????????????????????????????????????????????????????????????????????????????????");
                	sb.append("<br/>??????????????????? ??????<a href='" + url + "'>????????????</a>???");
                	sb.append("</div>");
                	Email.create(h.community,null,email,Res.get(h.language,"????????????"),sb.toString(),true);
                	
                	out.print("<script>mt.show('??????????????????????????????????????????????????????????????????????????????',2,'http://" + sn + "',400);parent.$$('dl_ok').value='??????" + sn + "??????';</script>");
                }else{
                    String c = "????????????" + username+"?????????"+p.getPassword()+"???????????????????????????????????????????????????????????????";
           			String rs = SMSMessage.create(h.community,"webmaster", p.mobile,
           					h.language, c);
           			out.print("mt.show('??????????????????????????????????????????????????????????????????????????????');");
                }
                return;
            } else if("password".equals(act)) //????????????
            {
                String old = h.get("old");
                Profile p = Profile.find(h.member);
                if(!old.equals(p.getPassword()))
                {
                    out.print("<script>mt.show('???????????????????????????');</script>");
                    return;
                }
                p.setPassword(h.get("password"));
            } else if("clear".equals(act)) //????????????
            {
                String member = h.get("member");
                Profile.find(member).setPassword("123456");
            } else if("dels".equals(act)) //??????????????????
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
                    out.print("<script>alert('" + Res.get(h.language,"???????????????????????????") + "');</script>");
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
                out.print("<script>mt.show('" + Res.get(h.language,"?????????????????????") + "');</script>");
                return;
            } else if("medal".equals(act)) //??????
            {
                Profile p = Profile.find(h.get("member"));
                p.setMedal(h.get("medals","|"));
            } else if("medals".equals(act)) //??????????????????
            {
                String tmp = h.get("medals","|");
                String[] member = h.get("member").split(",");
                for(int i = 1;i < member.length;i++)
                {
                    Profile p = Profile.find(member[i]);
                    p.setMedal(MT.f(p.getMedal(),"|") + tmp.substring(1));
                }
            } else if("gag".equals(act)) //??????
            {
                String[] member = h.getValues("members");
                for(int i = 0;i < member.length;i++)
                {
                    Profile p = Profile.find(member[i]);
                    int day = h.getInt("day");
                    p.setGag(day < 1 ? null : MT.add(new Date(),day));
                }
            } else if("actives".equals(act)) //???????????????
            {
                for(int i = 0;i < 20;i++)
                    out.print("// ???????????????  \n");
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
                        out.print("<script>mt.progress(" + i + "," + sum + ",'???????????????" + member + "');</script>");
                        out.flush();
                    }

                    int logint = Logs.count(teasession._strCommunity," AND rmember=" + DbAdapter.cite(member)); //+ " AND time>=" + DbAdapter.cite(t)//????????????
                    int wcing = WestracClue.count(teasession._strCommunity," AND wctype=1 AND member=" + DbAdapter.cite(member)); //+ " AND times>= " + DbAdapter.cite(t) //????????????????????????;
                    int eventing = Eventregistration.Count(teasession._strCommunity," AND member=" + DbAdapter.cite(member) + " AND verifg=1"); // AND times>=" + DbAdapter.cite(t) //??????????????????
                    int tjint = Profile.count(" AND tjmember=" + DbAdapter.cite(member)); // + " AND time>= " + DbAdapter.cite(t) //???????????????

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
                    info += "<br/>" + Profile.ACTIVES_TYPE[i] + "???" + arr[i] + "???";
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
            }else if("ylreg".equals(act))//??????
            {
                String username = h.get("username");
                if(username == null || Profile.isExisted(username))
                {
                    out.print("<script>mt.show('???" + username + "???????????????');</script>");
                    return;
                }
                int checktype = h.getInt("checktype");
                int type = 0;
                String sname = "verify";
                /*if(!h.get("verify").equalsIgnoreCase((String) session.getAttribute(sname)))
                {
                    out.print("<script>mt.show('???????????????????????????');</script>");
                    return;
                }*/
                String verid = h.get("verid");
                String mob = h.get("mob");
                String email = h.get("email");
                if(checktype==1){
                	int flag = Profile.count("  AND deleted = 0 AND mobile = "+Database.cite(mob));
                	if(flag>0){
                		out.print("<script>mt.show('?????????????????????');</script>");
                		return;
                	}
                	String code = String.valueOf(session.getAttribute(mob
                			+ "_code"));
                	if(!verid.equals(code)){
                		out.print("<script>mt.show('????????????????????????');</script>");
                		return;
                	}
                }else{
                	int eflag = Profile.count("  AND deleted = 0 AND email = "+Database.cite(email));
                	if(eflag>0){
                		out.print("<script>mt.show('?????????????????????');</script>");
                		return;
                	}
                }
                session.removeAttribute(sname);
                String url = "http://" + h.request.getServerName() + ":" + h.request.getServerPort();
                //??????
                Profile p = Profile.create(username,h.get("password"),h.community,email,request.getServerName());
                p.setType(type);
                p.set("hospitals","|");
                StringBuffer sb = new StringBuffer();
                String myurl = url+"/Members.do?act=actemail&test&profile="+ MT.enc(p.profile);
                sb.append("	<table width='100%' border='0' cellspacing='0' cellpadding='0' style='width:700px;margin:0 auto;text-align:left;font-size:14px;'>");
                sb.append("	  <tr>");
                sb.append("	    <td><img src='http://123.57.64.192/res/Home/structure/14102049.jpg' /></td>");
                sb.append("	    <td style='' valign='bottom'><a href='http://123.57.64.192/html/folder/14102033-1.htm' style='color:blue;font-size:12px;text-decoration:none;'>??????</a></td>");
                sb.append("	  </tr>");
                sb.append("		<tr>");
                sb.append("			<td colspan='2' style='padding:15px 0 20px;color:#000;font-weight:bold'>????????????????????????</td>	</tr>");
                sb.append("			<tr><td colspan='2'>?????????????????????????????????????????????????????????????????????????????????????????????</td>	</tr>");
                sb.append("			<tr><td colspan='2' style='color:red;padding:20px 0;font-weight:bold'><a href='"+myurl+"'>??????????????????????????????</a></td>	</tr>");
                sb.append("			<tr><td colspan='2'>????????????????????????????????????????????????????????????????????????????????????????????????</td>	</tr>");
                sb.append("			<tr><td colspan='2' style='padding:5px 0'><a href='#' style='color:#acacac;text-decoration:none;'>"+myurl+"</a></td>");
                sb.append("			</tr>");
                sb.append("			<tr><td colspan='2' style='padding:15px 0 10px;color:#000;font-weight:bold'>???????????????</td></tr>");
                sb.append("			<tr><td colspan='2' style='line-height:180%;color:#0077FF;padding:0'><p style='padding:0;margin:0'>??????????????????????????????????????????????????????</p>");
                sb.append("					<p style='padding:0;margin:0'>?????????????????????????????????????????????????????????????????????????????????????????????Internet Explorer ???????????????????????????????????????http://???????????????????????????????????????????????????</p>");
                sb.append("					<p style='padding:0;margin:0'>???????????????????????????????????????????????????????????????</p>");
                sb.append("					<p style='padding:0;margin:0'>???????????????????????????????????????????????????????????????????????????</p>");
                sb.append("					</td>");
                sb.append("				</tr>");
                sb.append("	</table>");
                //sb.append(myurl);
                p.setEmailflag(0);
                p.setMobile(h.get("mob"));
                p.setMembertype(0);
                p.set("qualification","0");
                if(checktype==0){
                	boolean flag = Email.create(h.community,null,email,"????????????",sb.toString());
                    p.setEmailflag(1);
                }else{
                	ShopIntegralRules sir = ShopIntegralRules.findByItem(1);
            		ShopMyPoints.creatPoint(p.profile,"????????????????????????", sir.getIntegral(), null);
                }
                String myact = MT.f(h.get("myact"),"");
                String openid = h.get("openid");
                if(myact.equals("qq")){
                	p.setqqopenid(openid);
                }else if(myact.equals("wx")){
                	p.setwxopenid(openid);
                }
                //??????
                /*RV rv = new RV(username);
                Logs.create(h.community,rv,1,h.node,request.getRemoteAddr());
                OnlineList.create(session.getId(),h.community,username,request.getRemoteAddr());
                session.setAttribute("member",p.getProfile());
                h.setCook("member",MT.enc(p.getProfile() + "|" + p.getPassword()), -1);*/
                //out.print("<script>parent.parent.location.replace('" + nexturl + "');</script>");
                if(h.status==1)
                	out.print("<script>parent.parent.mt.show('???????????????',1,'"+nexturl+"');</script>");
                else
                	out.print("<script>mt.show('???????????????',1,'"+nexturl+"');</script>");
                return;
            }else if("actemail".equals(act)){
            	try {
            		String pid = MT.dec(request.getParameter("profile"));
                	Profile p = Profile.find(Integer.parseInt(pid));
                	if(p.profile>0){
                		if(p.emailflag==1){
                			ShopIntegralRules sir = ShopIntegralRules.findByItem(1);
                			ShopMyPoints.creatPoint(p.profile,"????????????????????????", sir.getIntegral(), null);
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
    				// ??????access_coken?????????????????????????????????
    				byte[] by2 = (byte[]) Http.open(
    						"https://api.weixin.qq.com/sns/userinfo?access_token="
    								+ token + "&openid=" + openid + "&lang=zh_CN",
    						null);
    				String str2 = new String(by2, "UTF-8");
    				JSONObject jo2 = JSON.parseObject(str2);
    				String headimgurl = jo2.getString("headimgurl");
    				String nickname = jo2.getString("nickname");

    				// ???????????????Access_Token
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
                sb.append("	    <td style='' valign='bottom'><a href='http://123.57.64.192/html/folder/14102033-1.htm' style='color:blue;font-size:12px;text-decoration:none;'>??????</a></td>");
                sb.append("	  </tr>");
                sb.append("		<tr>");
                sb.append("			<td colspan='2' style='padding:15px 0 20px;color:#000;font-weight:bold'>????????????????????????</td>	</tr>");
                sb.append("			<tr><td colspan='2'>?????????????????????????????????????????????????????????????????????????????????????????????</td>	</tr>");
                sb.append("			<tr><td colspan='2' style='color:red;padding:20px 0;font-weight:bold'><a href='"+myurl+"'>??????????????????????????????</a></td>	</tr>");
                sb.append("			<tr><td colspan='2'>????????????????????????????????????????????????????????????????????????????????????????????????</td>	</tr>");
                sb.append("			<tr><td colspan='2' style='padding:5px 0'><a href='#' style='color:#acacac;text-decoration:none;'>"+myurl+"</a></td>");
                sb.append("			</tr>");
                sb.append("			<tr><td colspan='2' style='padding:15px 0 10px;color:#000;font-weight:bold'>???????????????</td></tr>");
                sb.append("			<tr><td colspan='2' style='line-height:180%;color:#0077FF;padding:0'><p style='padding:0;margin:0'>??????????????????????????????????????????????????????</p>");
                sb.append("					<p style='padding:0;margin:0'>?????????????????????????????????????????????????????????????????????????????????????????????Internet Explorer ???????????????????????????????????????http://???????????????????????????????????????????????????</p>");
                sb.append("					<p style='padding:0;margin:0'>???????????????????????????????????????????????????????????????</p>");
                sb.append("					<p style='padding:0;margin:0'>???????????????????????????????????????????????????????????????????????????</p>");
                sb.append("					</td>");
                sb.append("				</tr>");
                sb.append("	</table>");
            	//String myurl = url+"/Members.do?act=actemail&profile="+ MT.enc(p.profile);
                //sb.append(myurl);
                boolean flag = Email.create(h.community,null,p.getEmail(),"????????????",sb.toString());
                out.print("<script>mt.show('???????????????',1,'/html/folder/14102033-1.htm');</script>");
                return;
            }else if("yladd".equals(act))//????????????
            {
                String username = h.get("username");
                //2020.09.01???????????????????????????
                if(username == null || Profile.isExisted(username))
                {
                    out.print("<script>mt.show('???" + username + "???????????????');</script>");
                    return;
                }
                int type = 0;
                String mob = h.get("mob",null);
                //2017-10-17????????????????????????????????????????????????????????????????????????
                if(username == null || Profile.isExisted2(username,mob))
                {
                    out.print("<script>mt.show('???" + username + "???????????????');</script>");
                    return;
                }
                String email = h.get("email",null);
                if(mob==null&&email==null){
                	out.print("<script>mt.show('????????????????????????????????????');</script>");
            		return;
                }
                if(mob!=null){
                	//int flag = Profile.count(" AND mobile = "+Database.cite(mob));
                	int flag = Profile.count(" AND mobile = "+Database.cite(mob)+" AND deleted = 0 ");//?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
                	if(flag>0){
                		out.print("<script>mt.show('?????????????????????');</script>");
                		return;
                	}
                }else{
                	int eflag = Profile.count(" AND email = "+Database.cite(email));
                	if(eflag>0){
                		out.print("<script>mt.show('?????????????????????');</script>");
                		return;
                	}
                }
                int membertype = h.getInt("membertype");
                String [] procurementUnits = h.getValues("procurementUnit");
                if(membertype==2) {
                	if(procurementUnits==null) {
                		out.print("<script>mt.show('????????????????????????');</script>");
                		return;
                	}
                }
                
                int hospital = h.getInt("hospital");
                int department = h.getInt("department");
                Date time = h.getDate("validity");
                if(membertype==1){
                	if(hospital>-1||department>-1){
                		if(hospital==-1){
                			out.print("<script>mt.show('??????????????????');</script>");
                			return;
                		}
                		if(department==-1){
                			out.print("<script>mt.show('??????????????????');</script>");
                			return;
                		}
                		if(time==null){
                			out.print("<script>mt.show('?????????????????????');</script>");
                			return;
                		}
                	}
                }
                
                
                //??????
                Profile p = Profile.create(username,h.get("password"),h.community,email,request.getServerName());
                int parentpro = h.getInt("parentpro");//?????????????????????
                p.set("parentpro",parentpro);
                p.setMobile(h.get("mob"));
                p.setType(type);
                p.setMembertype(membertype);
                p.set("qualification","0");
                int isvip = h.getInt("isvip");
                p.set("isvip", isvip);
                p.set("hospitals","|");
                if(parentpro>0){//????????????????????????   hospitals????????????????????????????????????  |xxxx|xxxx|
                    ProcurementUnitJoin puj = ProcurementUnitJoin.find(parentpro);
                    String hoid = puj.getHoid();
                    if(hoid!=null&&hoid.length()>2){// ??????????????????????????????????????? ??????null  ??? ?????? ???
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
                
                p.set("address",h.get("address","")); //????????????-???????????????
                p.set("company", h.get("company",""));//??????????????????
                p.set("tax", String.valueOf(h.getInt("tax")));//???????????????
                p.set("formula", String.valueOf(h.getInt("formula")));//???????????????
                p.set("issalesman", h.getInt("issalesman"));
                CreatDetail c = CreatDetail.find(0);
                c.setPid(p.profile);
                c.setCreatpid(h.member);
                c.set();
                //?????????????????????????????????????????????????????????
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
            		out.print("<script>mt.show('?????????????????????');</script>");
            		return;
            	}
            	p.set("hospitals", pstr);*/
                /*out.print("<script>mt.show('???????????????');</script>");
                return;*/
                out.print("<script>mt.show('" + info + "',1,'/jsp/yl/user/EditProfile.jsp?member="+p.profile+"');</script>");
                return;
            }else if("upyl".equals(act)){//?????????????????? 
            	int member = h.getInt("member");
            	Profile p = Profile.find(member);
            	String mob = h.get("mob",null);
            	if(mob!=null&&mob.length()==11) {
                    ArrayList arrayList = Profile.find1(" AND mobile=" + Database.cite(mob) + " and deleted=0 ", 0, Integer.MAX_VALUE);
                    if(arrayList.size()>0){//?????????????????????
                        if(arrayList.size()==1) {
                            Profile profile = (Profile) arrayList.get(0);
                            if(profile.profile==member){//??????????????????

                            }else {
                                out.print("<script>mt.show('?????????????????????');</script>");
                                return;
                            }
                        }else {
                            out.print("<script>mt.show('?????????????????????');</script>");
                            return;
                        }
                    }
                }else {
            	    if(mob==null){
                        out.print("<script>mt.show('????????????????????????');</script>");
                        return;
                    }else {
                        out.print("<script>mt.show('?????????????????????');</script>");
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
                		out.print("<script>mt.show('????????????????????????');</script>");
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
                
                p.set("openid",h.get("openid","")); //??????openid ????????? ?????????????????????
                
                p.set("address",h.get("address","")); //????????????-???????????????
                
                
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
                    if(h.getInt("company_parent")>0){//????????????????????????   hospitals????????????????????????????????????  |xxxx|xxxx|
                        ProcurementUnitJoin puj = ProcurementUnitJoin.find(h.getInt("company_parent"));
                        String hoid = puj.getHoid();
                        if(hoid!=null&&hoid.length()>2){// ??????????????????????????????????????? ??????null  ??? ?????? ???
                            hoid = hoid.replaceAll(",","\\|");
                            p.set("hospitals",hoid);

                        }

                    }
                }
                p.set("company", h.get("company",""));//??????????????????
                p.set("tax", String.valueOf(h.getInt("tax")));
                p.set("formula", String.valueOf(h.getInt("formula")));
                p.set("issalesman", h.getInt("issalesman"));
                //???????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
                //????????????????????????
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
                			out.print("<script>mt.show('??????????????????');</script>");
                			return;
                		}
                		if(department==-1){
                			out.print("<script>mt.show('??????????????????');</script>");
                			return;
                		}
                		if(membertype==1){
                			if(time==null){
                    			out.print("<script>mt.show('?????????????????????');</script>");
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
            		out.print("<script>mt.show('?????????????????????');</script>");
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
            	int particles_sign = h.getInt("particles_sign"); 	//???????????????
            	int invoice_sign = h.getInt("invoice_sign");		//???????????????
            	int hospital = h.getInt("hospital");				//????????????
            	ShopHospital sh=ShopHospital.find(hospital);
            	String hname=sh.getName();
                //19.9.2??????
                p.set("particles_sign", particles_sign);
                p.set("invoice_sign",invoice_sign);
                if(p.hospital==null||p.hospital.length()==0||p.hospital=="0"){
                    p.set("hospital",hospital);
                }else{
                    p.set("hospital",p.hospital+"|"+hospital);
                }
                //19.9.2????????????
            	/*if(hname.equals("?????????????????????????????????CT???")||hname.equals("?????????????????????????????????B??????")||hname.equals("?????????????????????????????????????????????")){
            		//?????????????????????????????????
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
            	int type = h.getInt("type",0); 	//0???????????????1????????????
            	System.out.print("type="+type);
            	//???????????????????????????
    			List<Profile> pList = Profile.getProfileByHospitalId(hospital, type);
    			sb.append("<option value=''>--?????????--</option>");
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

                //19.9.2??????
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

                //19.9.2????????????
            	
            	/*List<ShopHospital> lsth=ShopHospital.find(" and name="+DbAdapter.cite("?????????????????????????????????????????????"), 0, 1);
            	List<ShopHospital> lsth2=ShopHospital.find(" and name="+DbAdapter.cite("?????????????????????????????????B??????"), 0, 1);
            	List<ShopHospital> lsth3=ShopHospital.find(" and name="+DbAdapter.cite("?????????????????????????????????CT???"), 0, 1);
            	
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
            }else if("reemail".equals(act)){//????????????
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
                sb.append("	    <td style='' valign='bottom'><a href='http://123.57.64.192/html/folder/14102033-1.htm' style='color:blue;font-size:12px;text-decoration:none;'>??????</a></td>");
                sb.append("	  </tr>");
                sb.append("		<tr>");
                sb.append("			<td colspan='2' style='padding:15px 0 20px;color:#000;font-weight:bold'>????????????????????????</td>	</tr>");
                sb.append("			<tr><td colspan='2'>?????????????????????????????????????????????????????????????????????????????????????????????</td>	</tr>");
                sb.append("			<tr><td colspan='2' style='color:red;padding:20px 0;font-weight:bold'><a href='"+myurl+"'>??????????????????????????????</a></td>	</tr>");
                sb.append("			<tr><td colspan='2'>????????????????????????????????????????????????????????????????????????????????????????????????</td>	</tr>");
                sb.append("			<tr><td colspan='2' style='padding:5px 0'><a href='#' style='color:#acacac;text-decoration:none;'>"+myurl+"</a></td>");
                sb.append("			</tr>");
                sb.append("			<tr><td colspan='2' style='padding:15px 0 10px;color:#000;font-weight:bold'>???????????????</td></tr>");
                sb.append("			<tr><td colspan='2' style='line-height:180%;color:#0077FF;padding:0'><p style='padding:0;margin:0'>??????????????????????????????????????????????????????</p>");
                sb.append("					<p style='padding:0;margin:0'>?????????????????????????????????????????????????????????????????????????????????????????????Internet Explorer ???????????????????????????????????????http://???????????????????????????????????????????????????</p>");
                sb.append("					<p style='padding:0;margin:0'>???????????????????????????????????????????????????????????????</p>");
                sb.append("					<p style='padding:0;margin:0'>???????????????????????????????????????????????????????????????????????????</p>");
                sb.append("					</td>");
                sb.append("				</tr>");
                sb.append("	</table>");
                
                //sb.append(myurl);
                boolean flag = Email.create(h.community,null,p.email,"????????????",sb.toString());
                /*if(!flag){
             		out.print("<script>mt.show('?????????????????????');</script>");
             		return;
             	}
                out.print("<script>mt.show('?????????????????????');</script>");*/
                out.print("<script>mt.show('?????????????????????');</script>");
                return;
            }else if("sendemail".equals(act)){//???????????? ????????????
            	String sname = "verify";
                if(!h.get("verify1").equalsIgnoreCase((String) session.getAttribute(sname)))
                {
                    out.print("<script>mt.show('???????????????????????????');</script>");
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
                sb.append("	    <td style='' valign='bottom'><a href='http://123.57.64.192/html/folder/14102033-1.htm' style='color:blue;font-size:12px;text-decoration:none;'>??????</a></td>");
                sb.append("	  </tr>");
                sb.append("		<tr>");
                sb.append("			<td colspan='2' style='padding:15px 0 20px;color:#000;font-weight:bold'>????????????????????????</td>	</tr>");
                //sb.append("			<tr><td colspan='2'>?????????????????????????????????????????????????????????????????????????????????????????????</td>	</tr>");
                sb.append("			<tr><td colspan='2' style='color:red;padding:20px 0;font-weight:bold'><a href='"+myurl+"'>??????????????????</a></td>	</tr>");
                sb.append("			<tr><td colspan='2'>????????????????????????????????????????????????????????????????????????????????????????????????</td>	</tr>");
                sb.append("			<tr><td colspan='2' style='padding:5px 0'><a href='#' style='color:#acacac;text-decoration:none;'>"+myurl+"</a></td>");
                sb.append("			</tr>");
                sb.append("			<tr><td colspan='2' style='padding:15px 0 10px;color:#000;font-weight:bold'>???????????????</td></tr>");
                sb.append("			<tr><td colspan='2' style='line-height:180%;color:#0077FF;padding:0'><p style='padding:0;margin:0'>??????????????????????????????????????????????????????</p>");
                sb.append("					<p style='padding:0;margin:0'>?????????????????????????????????????????????????????????????????????????????????????????????Internet Explorer ???????????????????????????????????????http://???????????????????????????????????????????????????</p>");
                sb.append("					<p style='padding:0;margin:0'>???????????????????????????????????????????????????????????????</p>");
                sb.append("					<p style='padding:0;margin:0'>???????????????????????????????????????????????????????????????????????????</p>");
                sb.append("					</td>");
                sb.append("				</tr>");
                sb.append("	</table>");
                
                //sb.append(myurl);
                boolean flag = Email.create(h.community,null,p.email,"????????????",sb.toString());
                /*if(!flag){
             		out.print("<script>mt.show('?????????????????????');</script>");
             		return;
             	}
                out.print("<script>mt.show('?????????????????????');</script>");*/
                out.print("<script>mt.show('?????????????????????');</script>");
                return;
            }else if("updaemail".equals(act)){//???????????? ????????????????????????
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
            			//out.print("<script>alert('?????????????????????');</script>");
            		}
				} catch (Exception e) {
				}
            	out.print("<script>location='/html/folder/14110435-1.htm?type=email';</script>");
            	//response.sendRedirect("/jsp/yl/shopweb/ShopCheckEmailMobile.jsp?type=email");
            	//request.getRequestDispatcher("/jsp/yl/shopweb/ShopCheckEmailMobile.jsp?type=email").forward(request, response);
            	//out.print("<script>location='/jsp/yl/shopweb/ShopCheckEmailMobile.jsp?type=email';</script>");
    			return;
            }else if("successcheckeamil".equals(act)){//??????????????????
            	String sname = "verify";
                if(!h.get("verify1").equalsIgnoreCase((String) session.getAttribute(sname)))
                {
                    out.print("<script>mt.show('???????????????????????????');</script>");
                    return;
                }
                int profile = h.getInt("profile");
                String email = h.get("email");
                int eflag = Profile.count(" AND email = "+Database.cite(email));
            	if(eflag>0){
            		out.print("<script>mt.show('?????????????????????');</script>");
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
                sb.append("	    <td style='' valign='bottom'><a href='http://123.57.64.192/html/folder/14102033-1.htm' style='color:blue;font-size:12px;text-decoration:none;'>??????</a></td>");
                sb.append("	  </tr>");
                sb.append("		<tr>");
                sb.append("			<td colspan='2' style='padding:15px 0 20px;color:#000;font-weight:bold'>????????????????????????</td>	</tr>");
                //sb.append("			<tr><td colspan='2'>?????????????????????????????????????????????????????????????????????????????????????????????</td>	</tr>");
                sb.append("			<tr><td colspan='2' style='color:red;padding:20px 0;font-weight:bold'><a href='"+myurl+"'>??????????????????</a></td>	</tr>");
                sb.append("			<tr><td colspan='2'>????????????????????????????????????????????????????????????????????????????????????????????????</td>	</tr>");
                sb.append("			<tr><td colspan='2' style='padding:5px 0'><a href='#' style='color:#acacac;text-decoration:none;'>"+myurl+"</a></td>");
                sb.append("			</tr>");
                sb.append("			<tr><td colspan='2' style='padding:15px 0 10px;color:#000;font-weight:bold'>???????????????</td></tr>");
                sb.append("			<tr><td colspan='2' style='line-height:180%;color:#0077FF;padding:0'><p style='padding:0;margin:0'>??????????????????????????????????????????????????????</p>");
                sb.append("					<p style='padding:0;margin:0'>?????????????????????????????????????????????????????????????????????????????????????????????Internet Explorer ???????????????????????????????????????http://???????????????????????????????????????????????????</p>");
                sb.append("					<p style='padding:0;margin:0'>???????????????????????????????????????????????????????????????</p>");
                sb.append("					<p style='padding:0;margin:0'>???????????????????????????????????????????????????????????????????????????</p>");
                sb.append("					</td>");
                sb.append("				</tr>");
                sb.append("	</table>");
                
                //sb.append(myurl);
                boolean flag = Email.create(h.community,null,email,"????????????",sb.toString());
                /*if(!flag){
             		out.print("<script>mt.show('?????????????????????');</script>");
             		return;
             	}
                out.print("<script>mt.show('?????????????????????');</script>");*/
                out.print("<script>mt.show('?????????????????????');</script>");
                return;
            }/*else if("successcheckeamil".equals(act)){//??????????????????
            	String sname = "verify";
                if(!h.get("verify1").equalsIgnoreCase((String) session.getAttribute(sname)))
                {
                    out.print("<script>mt.show('???????????????????????????');</script>");
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
                boolean flag = Email.create(h.community,"robot@redcome.com",email,"????????????",sb.toString());
                if(!flag){
             		out.print("<script>mt.show('?????????????????????');</script>");
             		return;
             	}
                out.print("<script>mt.show('?????????????????????');</script>");
                out.print("<script>mt.show('?????????????????????');</script>");
                return;
            }*/else if("replaceemail".equals(act)){//????????????
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
            			//out.print("<script>alert('?????????????????????');</script>");
            		}
				} catch (Exception e) {
				}
            	out.print("<script>location = '/html/folder/14110054-1.htm';</script>");
    			return;
            }else if("mobcheck".equals(act)){//??????????????????
            	String mob = h.get("mob");

            	String sname = "verify";
                if(!h.get("verify").equalsIgnoreCase((String) session.getAttribute(sname)))
                {
                    out.print("<script>mt.show('???????????????????????????');</script>");
                    return;
                }
                String verid = h.get("verid");
                	String code = String.valueOf(session.getAttribute(mob
                			+ "_code"));
                	if(!verid.equals(code)){
                		out.print("<script>mt.show('????????????????????????');</script>");
                		return;
                	}
                	session.setAttribute("emailflag", "1");
                	//out.print("<script>location='/jsp/yl/shopweb/ShopCheckEmailMobile2.jsp?type=mobile';</script>");
                	out.print("<script>mt.show('???????????????',1,'/jsp/yl/shopweb/ShopCheckEmailMobile2.jsp?type=mobile');</script>");
                	//response.sendRedirect("/jsp/yl/shopweb/ShopCheckEmailMobile2.jsp?type=mobile");
                	return;
            }else if("replacemob".equals(act)){//????????????
            	String mob = h.get("mob");
            	int member = h.member;
            	String sname = "verify";
                if(!h.get("verify").equalsIgnoreCase((String) session.getAttribute(sname)))
                {
                    out.print("<script>mt.show('???????????????????????????');</script>");
                    return;
                }
                String verid = h.get("verid");
                	int flag = Profile.count(" AND mobile = "+Database.cite(mob));
                	if(flag>0){
                		out.print("<script>mt.show('?????????????????????');</script>");
                		return;
                	}
                	String code = String.valueOf(session.getAttribute(mob
                			+ "_code"));
                	if(!verid.equals(code)){
                		out.print("<script>mt.show('????????????????????????');</script>");
                		return;
                	}
                Profile.find(member).set("mobile",mob);
                out.print("<script>mt.show('???????????????',1,'/jsp/yl/shopweb/ShopMemberEdit.jsp');</script>");
    			return;
            }else if("yllogin".equals(act)){
            	
            	String member = h.get("username1");
            	String password = h.get("password");
            	String verify = h.get("verify");
                String str = h.getCook("verify",null);
                if((str != null || verify != null) && (str == null || !MT.dec(str).equalsIgnoreCase(verify)))
                {
                    out.print("<script>mt.show('???????????????????????????');</script>");
                    return;
                }
                h.setCook("verify",null,0);
                //
                int eflag = Profile.count(" AND  email = "+Database.cite(member)+" AND password = "+Database.cite(password));
                int mflag = Profile.count(" AND  mobile = "+Database.cite(member)+" AND password = "+Database.cite(password));
                int uflag = Profile.count(" AND  member = "+Database.cite(member)+" AND password = "+Database.cite(password));
                
                if(eflag==0&&mflag==0&&uflag==0)
                {
                    out.print("<script>mt.show('???????????????????????????');</script>");
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
					out.print("<script>mt.show(\"" + Res.get(h.language,"???????????????????????????????????????????????????<br/><br/>?????????????????????{0}????????????</a>","<a href=" + url + " target=_ajax>") + "\");</script>");
					return;
                }
                if(p.deleted){
                	out.print("<script>mt.show('?????????????????????');</script>");
                    return;
                }
                
                if(p.isLocking())
                {
                    out.print("<script>alert('?????????????????????????????????????????????');</script>");
                    return;
                }
                if(MT.f(p.openid).length()>0){
                	String openid = h.getCook("openid", "");
                    if(!"".equals(openid)){
	                	 out.print("<script>alert('?????????????????????????????????????????????');</script>");
	                     return;
                    }
                }else{
                	//??????openid
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
            	//2017-06-05??????????????????????????????yllogin??????????????????????????????????????????????????????????????????????????????????????????
            	String hname=h.get("hname","");
            	String member = h.get("username1");
            	String password = h.get("password");
            	String verify = h.get("verify");
            	
                //String str = h.getCook("verify",null);
            	String str=h.get("pincode");
                if((str != null || verify != null) && (str == null || !str.equals(verify)))
                {
                    out.print("<script>mt.show('???????????????????????????');</script>");
                    return;
                }
                h.setCook("verify",null,0);
                //
                int eflag = Profile.count(" AND  email = "+Database.cite(member)+" AND password = "+Database.cite(password));
                int mflag = Profile.count(" AND  mobile = "+Database.cite(member)+" AND password = "+Database.cite(password));
                int uflag = Profile.count(" AND  member = "+Database.cite(member)+" AND password = "+Database.cite(password));
                
                if(eflag==0&&mflag==0&&uflag==0)
                {
                    out.print("<script>mt.show('???????????????????????????');</script>");
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
					out.print("<script>mt.show(\"" + Res.get(h.language,"???????????????????????????????????????????????????<br/><br/>?????????????????????{0}????????????</a>","<a href=" + url + " target=_ajax>") + "\");</script>");
					return;
                }
                if(p.deleted){
                	out.print("<script>mt.show('?????????????????????');</script>");
                    return;
                }
                
                if(p.isLocking())
                {
                    out.print("<script>alert('?????????????????????????????????????????????');</script>");
                    return;
                }
                Filex.logs("yt_qianshou2.txt", "login:openid==="+p.openid);
                if(MT.f(p.openid).length()>0){
                	//String openid = h.getCook("openid", "");
                	h.setCook("openid", p.openid, -1);
                	/*Filex.logs("yt_qianshou2.txt", "login:openid2==="+openid);
                    if(!"".equals(openid)){
	                	 out.print("<script>alert('?????????????????????????????????????????????');</script>");
	                     return;
                    }*/
                }else{
                	//??????openid
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
            		info = "?????????????????????????????????";
            	}else{
            		p.delete();
            	}
            }else if("bangding_mail".equals(act)){//????????????????????????
                out.println("<script>var mt=parent.parent.mt,doc=parent.parent.document;</script>");
                String message = "?????????????????????";
                String new_mail = h.get("new_mail");
                Object attribute = session.getAttribute(new_mail + "_code");//??????ajax???????????????5?????????????????????session
                System.out.println(attribute);
                String verify = h.get("verify1");//??????????????????????????????
                if(attribute.equals(verify)){//??????
                    int profile = h.getInt("profile");//????????????
                    Profile p = Profile.find(profile);
                    p.setEmail(new_mail);
                    p.set();
                    out.print("<script>mt.show('" + message + "',1,'"+nexturl+"');</script>");
                    return;
                }else {
                    out.print("<script>mt.show('?????????????????????????????????',1,'"+nexturl+"');</script>");
                    return ;
                }
            } else
            {
                String key = h.get("member");
                int member = key.length() < 1 ? 0 : Integer.parseInt(MT.dec(key));
                String[] arr = member < 1 ? h.getValues("members") : new String[]
                               {String.valueOf(member)};
                if("lock".equals(act)) //????????????
                {
                    boolean locking = h.getBool("locking");
                    for(int i = 0;i < arr.length;i++)
                    {
                        Profile p = Profile.find(Integer.parseInt(arr[i]));
                        p.setLocking(locking);
                    }
                } else if("del".equals(act)) //??????????????????
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
                        //??????
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
                    sb.append("????????????" + m.profile);
                    Filex.logs("Members.log",sb.toString());
                }
            }
            out.print("<script>mt.show('" + info + "',1,'" + nexturl + "');</script>");
        } catch(Exception ex)
        {
            out.print("<textarea id='ta'>" + ex.toString() + "</textarea><script>mt.show(document.getElementById('ta').value,1,'?????????????????????');</script>");
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
