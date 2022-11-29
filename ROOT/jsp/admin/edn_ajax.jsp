<%@page import="tea.entity.yl.shop.ShopHospital"%>
<%@page import="tea.entity.admin.sales.PriceSet"%>
<%@page import="tea.entity.site.Organizer"%>
<%@page import="tea.entity.site.DNS"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="tea.entity.provincecity.Elonglocation"%>
<%@page import="tea.entity.provincecity.Elongcity"%>
<%@page import="tea.entity.admin.mov.UpgradeMember"%>
<%@page import="tea.entity.admin.mov.MemberOrder"%>
<%@page import="java.net.URLDecoder"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="tea.entity.admin.DayOrder"%>
<%@page import="tea.entity.bbs.BBSPoint"%>
<%@page import="tea.entity.westrac.WestracClue"%>
<%@page import="tea.entity.westrac.EventaccoMember"%>
<%@page import="tea.entity.integral.IntegralChange"%>
<%@page import="tea.entity.site.Communityintegral"%>
<%@page import="tea.entity.westrac.WestracIntegralLog"%>
<%@page import="tea.service.SMS"%>
<%@page import="tea.entity.site.Community"%>
<%@page import="tea.entity.integral.IntegralPrize"%>
<%@page import="tea.entity.westrac.Eventregistration"%>
<%@page import="tea.entity.*"%>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.resource.*" %><%@ page import="tea.db.*" %>
<%@ page import="tea.entity.bpicture.*" %>
<%@page import="tea.entity.node.*" %><%@page import="tea.entity.women.*" %>
<%@ page import="java.util.*" %><%@page import="tea.entity.RV" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.entity.admin.*" %>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);


/*


       sendx("/jsp/admin/edn_ajax.jsp?act=login&member="+value1+"&paw="+value2,
		 function(data)
		 {

		  //alert("4444->>>>."+data.length);
		   if(data!=''&&data.length>1)//如果有这个用户  则写入Cookie .trim()
		   {

			   window.location.reload();
		   }
		 }
		 );
*/


String act = request.getParameter("act");

if("meminfo".equals(act))
{
	if(request.getParameter("member") == null)
	{
	  response.sendRedirect("/servlet/StartLogin?node="+request.getParameter("node")+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
	  return;
	}
	int n = 0;
	if(request.getParameter("node")!=null && request.getParameter("node").length()>0)
	{
		n = Integer.parseInt(request.getParameter("node"));
	}

	Node nobj = Node.find(n);

	 MessageBoard obj = MessageBoard.find(n,1);


  out.print("<table><tr><td>留言人：</td><td>"+obj.getName()+"</td></tr><tr><td>国家/地区：</td><td>"+nobj.getSubject(1)+"</td></tr>"+
  "<tr><td>E-mail：</td><td>"+obj.getEmail()+"</td></tr>"+
  "</table>");
	return;
}else if("Dxmeminfo".equals(act))
{
	if(request.getParameter("member") == null)
	{
	  response.sendRedirect("/servlet/StartLogin?node="+request.getParameter("node")+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
	  return;
	}
	int n = 0;
	if(request.getParameter("node")!=null && request.getParameter("node").length()>0)
	{
		n = Integer.parseInt(request.getParameter("node"));
	}

	Node nobj = Node.find(n);

	 MessageBoard obj = MessageBoard.find(n,1);


  out.print("<table><tr><td>留言人：</td><td>"+obj.getName()+"</td></tr><tr><td>所在地区：</td><td>"+obj.getMobile()+"</td></tr>"+
  "<tr><td>邮箱地址：</td><td>"+obj.getEmail()+"</td></tr>"+
  "<tr><td>联系电话：</td><td>"+obj.getPhone()+"</td></tr>"+
  "</table>");
	return;
}
else if("login".equals(act))
{

	//String sv = (String) session.getAttribute("sms.vertify");
	//String vertify = teasession.getParameter("vertify");
	String loginid = teasession.getParameter("loginid");
	String paw = teasession.getParameter("paw");
	 RV rv = new RV(loginid);

	 // if(!vertify.trim().equals(sv))
      //{
      	  //session.removeAttribute("vertify");//退出session
         // out.print("1");
     // }else




      if(Entity.isNumeric(loginid) && loginid!=null && loginid.length()==6)
      {//是纯数字 //说明是会员编号

    	  if(!Profile.isCode(loginid,paw))//说明有这个
    	  {
    		  out.print("3");
    	  }else if(Profile.find(Profile.getMember(loginid)).isLocking())
    	  {
    		  out.print("4");
    	  }

      }else
      {
	      if(!Profile.isPassword(rv._strV,paw))
	      {
	    	  out.print("2");
	      }else if(Profile.find(loginid).isLocking())
    	  {
    		  out.print("4");
    	  }

      }




	  return;
}
else if("zywlogin".equals(act))
{

	String loginid = teasession.getParameter("loginid");
	String paw = teasession.getParameter("paw");
	 RV rv = new RV(loginid);


     /* if(Entity.isNumeric(loginid) && loginid!=null && loginid.length()==6)
      {//是纯数字 //说明是会员编号

    	  if(!Profile.isCode(loginid,paw))//说明有这个
    	  {
    		  out.print("3");
    	  }else if(Profile.find(Profile.getMember(loginid)).isLocking())
    	  {
    		  out.print("4");
    	  }

      }else
      {*/
    	  //2 帐号或密码不正确
    	  ChildMember cm=ChildMember.findChildMember(loginid, teasession._nLanguage);
    	  if(cm.isExist()){



    		  if(paw.length()==0){
    			  if(cm.isclearPwd()){
        			  out.print("1");
        		  }else{
        			  out.print("2");
        		  }
    		  }else if(!paw.equals(cm.getPassword())){
    			  out.print("2");
    		  }else if(!cm.getMembertype()){
    			  out.print("4");
    		  }else {
    			  out.print("1");
    		  }

    	  }else{
    		  out.print("2");
    	  }
	     /* if(!Profile.isPassword(rv._strV,paw))
	      {
	    	  out.print("2");
	      }else if(Profile.find(loginid).isLocking())
    	  {
    		  out.print("4");
    	  }*/






	  return;
}

else if("Tlogin".equals(act))
{


	String loginid = teasession.getParameter("member");






      if(loginid!=null && Entity.isNumeric(loginid) )
      {//是纯数字 //说明是会员编号

    	  if(!Profile.isCode(loginid))//说明有这个
    	  {
    		  out.print("3");
    	  }

      }else
      {
	      if(!Profile.isExisted(loginid))
	      {
	    	  out.print("2");
	      }
      }
	  return;
}else if("replysubmit".equals(act))//英文网 前台评论回复时候
{
	String sv = (String) session.getAttribute("sms.vertify");
	String vertify = teasession.getParameter("vertify");

	if(!vertify.trim().equalsIgnoreCase(sv))
    {
      	  session.removeAttribute("vertify");//退出session
          out.print("1");
      	  return;
    }

	  int trid = 0;
	if(teasession.getParameter("talkbackreply")!=null && teasession.getParameter("talkbackreply").length()>0)
	{
			trid = Integer.parseInt(request.getParameter("talkbackreply"));
	}

	String name = teasession.getParameter("name");
	String country = teasession.getParameter("country");
	String reply = teasession.getParameter("reply");

	   int talkback = 0;
       if(teasession.getParameter("talkback")!=null && teasession.getParameter("talkback").length()>0)
       {
       	talkback = Integer.parseInt(request.getParameter("talkback"));
       }

       String ft = request.getParameter("formattype");
       String text = request.getParameter("reply");

       if (ft == null || ft.length() == 0)
       {
           text = text.replaceAll("\r\n", "<BR>").replaceAll("  ", " &nbsp;");
       }


       String member =session.getId();

       String tourist = teasession.getParameter("tourist2");//是否选中游客评论


       if(tourist!=null && tourist.length()>0 )//选中了直接评论
       {
    	   member="游客";
       }else if( teasession._rv!=null)
       {
       		 member = teasession._rv._strR;
       }else
       {
    	   member="游客";
       }


       text =  Report.getHtml2(text);
       if (trid == 0)
       {
           TalkbackReply.create(talkback, member, text,0,request.getRemoteAddr(),name,country);
       } else
       {
           TalkbackReply objt = TalkbackReply.find(trid);
           objt.set(text);
           objt.setNameCountry(name,country);
       }
       out.print("2");
       return;

}else if("Contributions_delete".equals(act))
{
	String cid = teasession.getParameter("cid");
	tea.entity.women.Contributions cobj = tea.entity.women.Contributions.find(cid);
	cobj.delete();
	out.println("订单删除成功");
	return;
}
else if("CSPAYTYPE".equals(act))//母亲水窖查询
{

//	int type1=0;
//	if(teasession.getParameter("type1")!=null){
//		type1 = Integer.parseInt(teasession.getParameter("type1"));
//	}
//	String name1 = teasession.getParameter("name1");
//	if(name1!=null && name1.length()>0){
//		name1 = name1.trim();
//	}
//	String bh1 = teasession.getParameter("bh1");
//	if(bh1!=null && bh1.length()>0){
//		bh1 = bh1.trim();
//	}
//
//	String name2 = teasession.getParameter("name2");
//	if(name2!=null && name2.length()>0){
//		name2 = name2.trim();
//	}
//	String bh2 = teasession.getParameter("bh2");
//	if(bh2!=null && bh2.length()>0){
//		bh2 = bh2.trim();
//	}
//	String s = "";
//	String cid = null;
//	if(type1==1){
//		cid = tea.entity.women.Contributions.getCid(name1,bh1,type1);
//		s = "姓名";
//	}else if(type1==2){
//		cid = tea.entity.women.Contributions.getCid(name2,bh2,type1);
//		s = "企业/集体名称";
//	}else if(type1==3)
//	{
//		cid = tea.entity.women.Contributions.getCid(name1,bh1);
//	}
//	tea.entity.women.Contributions cobj = tea.entity.women.Contributions.find(cid);
//	if(type1==3)
//	{
//		s = cobj.getCidtype()==1?"姓名":"企业/集体名称";
//	}
//	 //System.out.println(s+"--"+cid+"--"+name1+"--"+bh1);
//	if(!cobj.isExist())
//  {
//		out.print("false");
//		return;
//	}

	Iterator it=Donation.find(" AND invoice="+DbAdapter.cite(teasession.getParameter("bh1")),0,1).iterator();
    if(!it.hasNext())
    {
		out.print("false");
		return;
    }
	Donation t=(Donation)it.next();
%>
<table border="0" cellpadding="0" cellspacing="0" class="Contributions">

 	<tr>
 		<td align="right">捐赠者：</td>
	      <td><%=t.donors%></td>

 		</tr>
 	<tr>
 		<td align="right">收据编号：</td>
 		<td><%=t.invoice%></td>
 	</tr>
 	<tr>
 		<td align="right">接收捐赠时间：</td>
 		<td><%=MT.f(t.dtime)%></td>
 	</tr>
 	<tr>
 		<td align="right">金额：</td>
 		<td><%=MT.f(t.money)%></td>
 	</tr>
 	<tr>
 		<td align="right">落实地点：</td>
 		<td><%=MT.f(t.province)+" "+MT.f(t.city)+" "+MT.f(t.town)+" "+MT.f(t.village)%></td>
 	</tr>
 	<tr>
 		<td align="right">落实图片：</td>
 		<td><%=MT.f(t.photo).length()>0?"<a href='###' onclick=\"mt.img('"+t.photo+"')\"><img src='"+t.photo+"' width='200' /></a>":"暂无"%></td>
 	</tr>
   </table>
     <div class="Tips"><b>温馨提示：</b><br/>
如果您的联系方式有变动，请及时和我们联系。
<br/>
联系电话：65103488 65140471
<br/>
Email：muqinshuijiao@163.com </div>

<%
}else if("WomenMemberEmpty".equals(act)){

	String cwmember = teasession.getParameter("cwmember");
	Profile pobj = Profile.find(cwmember);
	pobj.setPassword("");
	out.print("密码清空成功");
	return;
} else if("BBSMember".equals(act))//论坛版块用户删除
{
	String member = teasession.getParameter("member");
	Profile p = Profile.find(member);
	tea.entity.admin.AdminUsrRole arobj = tea.entity.admin.AdminUsrRole.find(teasession._strCommunity,member);
	p.delete(teasession._nLanguage);
	arobj.delete();
	out.print("true");
	return;
}else if("sequence".equals(act))
{
	//修改节点顺序
	Node nobj = Node.find(teasession._nNode);
	int seq = nobj.getSequence();
	if(teasession.getParameter("seq")!=null && teasession.getParameter("seq").length()>0)
	{
		seq = Integer.parseInt(teasession.getParameter("seq"));
	}
	nobj.setSequence(seq);
	return;
}else if("Chatdelete".equals(act))
{
	//删除聊天室记录
	int cid = Integer.parseInt(teasession.getParameter("cid"));
	Chat cobj  = Chat.find(cid);
	cobj.delete();
	return;

}else if("Chatclear".equals(act))
{
	application.setAttribute("message","管理员在"+Entity.sdf2.format(new Date())+"清空了聊天记录");
	return;
}else if("BjrrocEventdelete".equals(act))
{

		Node nobj = Node.find(teasession._nNode);
		nobj.delete_nodeid(teasession._nLanguage);
		Event eobj = Event.find(teasession._nNode,teasession._nLanguage);
		eobj.delete(teasession._nLanguage);
		return;

}else if("ClssnMember_rem".equals(act))
{
	DbAdapter db = new DbAdapter();
	StringBuffer sp = new StringBuffer();

	try
	{
		db.executeQuery("select remittance from MemberOrder where remittance!=0 and remittance is not null   group by remittance ");
		while(db.next())
		{

			sp.append("<a href =### onclick=form2.remittance2.value="+db.getBigDecimal(1,2)+">"+db.getBigDecimal(1,2)+"</a>");
			sp.append("　");
		}

	}finally
	{
		db.close();
	}
	out.println(sp.toString());
	return;
}else if("WestracEventFB".equals(act))
{
	Node nobj = Node.find(teasession._nNode);
	if(nobj.isHidden())
	{
		nobj.setHidden(false);
		out.print("false");
	}
	else if(!nobj.isHidden())
	{
		nobj.setHidden(true);
		out.print("true");
	}
	return;
}else if("WestracMemberdelete".equals(act))
{
	//威斯特 删除用户
	Profile p = Profile.find(teasession.getParameter("member"));
	p.delete(p.getMember());
	WestracIntegralLog.delete(teasession.getParameter("member"));
	return;
}else if("WestracEventMemberListVerifg".equals(act))
{
	//审核活动报名用户
	int eid = Integer.parseInt(teasession.getParameter("eid"));
	Eventregistration eobj = Eventregistration.find(eid);
	Event evobj = Event.find(eobj.getNode(),teasession._nLanguage);
	Node nobj = Node.find(eobj.getNode());
	Profile pobj = Profile.find(eobj.getMember());
	//审核
	if(eobj.getVerifg()==0)
	{
		eobj.setVerifg(1);
		eobj.setVerifgTime(new Date());
		out.print("true");
		//审核添加积分


		pobj.setMyintegral(pobj.getMyintegral()+evobj.getIntegral());
		WestracIntegralLog.create(eobj.getMember(),7,nobj.getSubject(teasession._nLanguage),eobj.getNode(),evobj.getIntegral(),null,new Date(),0,teasession._strCommunity);





	}else if(eobj.getVerifg()==1)
	{
		eobj.setVerifg(0);
		eobj.setVerifgTime(new Date());


		pobj.setMyintegral(pobj.getMyintegral()-evobj.getIntegral());
		WestracIntegralLog.create(eobj.getMember(),8,nobj.getSubject(teasession._nLanguage),eobj.getNode(),0,null,new Date(),-evobj.getIntegral(),teasession._strCommunity);



		out.print("false");
	}
	return;

}else if("WestracEventMemberListDelete".equals(act))
{
	//删除活动报名用户
	int eid = Integer.parseInt(teasession.getParameter("eid"));
	Eventregistration eobj = Eventregistration.find(eid);
	eobj.delete(eid);
	out.print("true");
	return;
}else if("WestracEventAccompMemberDelete".equals(act))
{
	//删除随行人员 也就是把随行人员信息修

	int eid = Integer.parseInt(teasession.getParameter("eid"));
	EventaccoMember eobj = EventaccoMember.find(eid);
	//eobj.setAcco(1,null, 0,0, 0, null,null);
	eobj.delete();
	out.print("true");
	return;
}else if("ewmxp".equals(act))
{
	int wotype = 1;
	if(teasession.getParameter("wotype")!=null &&teasession.getParameter("wotype").length()>0)
	{
		wotype = Integer.parseInt(teasession.getParameter("wotype"));
	}
	int wid = 0;
	if(teasession.getParameter("wm")!=null && teasession.getParameter("wm").length()>0)
	{
		wid=Integer.parseInt(teasession.getParameter("wm"));
	}
	String igdname = teasession.getParameter("igdname");
	int igdpingpai = 0;
	if(teasession.getParameter("igdpingpai")!=null && teasession.getParameter("igdpingpai").length()>0)
	{
		igdpingpai=Integer.parseInt(teasession.getParameter("igdpingpai"));
	}

	out.print("<select name ="+igdname+">");
	 out.print("<option value = 0>----</option>");

	 if(wid>0){

	 	List catlist = WomenOptions.findByTpyeAndLan(wid,wotype,teasession._nLanguage);
	 	if(catlist!=null && !catlist.isEmpty()){
	 		for(int i = 0;i<catlist.size();i++){
	 			List deList = (List)catlist.get(i);
	 			String id = (String)deList.get(0);
	 			String name = (String)deList.get(1);
	 			 out.print("<option value = "+id);
		         if(igdpingpai==Integer.parseInt(id))
		         {
		        	 out.println(" selected ");
		         }
		         out.print(">"+name);
		         out.print("</option>");
	 		}
	 	}
	 }
     out.println("</select>");
}else if("IntegralPrizeDelete".equals(act))
{
	int ipid = Integer.parseInt(teasession.getParameter("ipid"));
	IntegralPrize.delete(ipid);
	out.print("true");
	return;
}else if("code_memberadd".equals(act))
{
	//前台会员绑定俱乐部会员
	String member = teasession.getParameter("member");
	String membercode = teasession.getParameter("membercode");

	if(Profile.isExisted(member))
	{
		out.println("false1");
	}else if(!membercode.equals(Profile.getMember(membercode)))
	{
		out.println("false2");
	}
	else
	{
		Profile.setMember(member,membercode,teasession._strCommunity);

		Profile pobj = Profile.find(member);

		pobj.setMember(member);

		  RV rv = new RV(member);
		  Community c = Community.find(teasession._strCommunity);
          if(c.isSession())
          {
              session.setAttribute("tea.RV",rv);
          } else
          {

        	  javax.servlet.http.Cookie cs = new javax.servlet.http.Cookie("member",MT.enc(member + ":" + SMS.md5(Integer.toString(pobj.getPassword().hashCode(),36))));
              cs.setPath("/");
              String sn = request.getServerName();
              int j = sn.indexOf(".");
              if(j != -1 && sn.charAt(sn.length() - 1) > 96)
                  cs.setDomain(sn.substring(j));
              response.addCookie(cs);
          }

		out.print("true");


	}
}else if("WestracMemberConsul".equals(act))
{
	//呼叫中心的会员咨询记录添加
	String text = teasession.getParameter("text");
	String code = teasession.getParameter("code");
	ProfileConsulting.create(text,teasession._strCommunity,code,new Date());
	out.print("true");
	return;
}else if("WmemberVerifytype".equals(act))
{
	//act=WmemberVerifytype&memberid="+memt+"&type="+ck审核身份类型
	String memid="";
	int  nt=10;
	if(teasession.getParameter("memberid")!=null&&teasession.getParameter("memberid").length()>0){
		if(teasession.getParameter("type")!=null&&teasession.getParameter("type").length()>0){
			memid=teasession.getParameter("memberid");
			nt=Integer.parseInt(teasession.getParameter("type"));
			Profile pl=Profile.find(memid);
			try{
			pl.setVerifytype(nt);
			}catch(Exception e){
				out.print("false");
				return;
			}finally{
				out.print("true");
				return;
			}

		}
	}
	out.print("false");
	return;
}else if("WmemberVerifytypes".equals(act))
            {
            	//act=WmemberVerifytype&memberid="+memt+"&type="+ck审核身份类型
            	String memid="";
            	String txt="";
            	int  nt=10;
            	if(teasession.getParameter("memberid")!=null&&teasession.getParameter("memberid").length()>0){
            		if(teasession.getParameter("type")!=null&&teasession.getParameter("type").length()>0){
            			memid=teasession.getParameter("memberid");
            			String[] memids=memid.split(";");
            			nt=Integer.parseInt(teasession.getParameter("type"));
            			for(int i=0;i<memids.length;i++){
            				Profile pl=Profile.find(memids[i]);
            			try{
            			pl.setVerifytype(nt);
            			txt="true";
            			}catch(Exception e){

            				txt="false";
            			}
            			}
            		}
            		out.print(txt);
            		return;
            	}else{

            		out.print("false");
    				return;

            	}

            }
else if("WmemberVerifginput".equals(act))
{
	int membertype =2;
	if(teasession.getParameter("membertype")!=null && teasession.getParameter("membertype").length()>0)
	{
		membertype = Integer.parseInt(teasession.getParameter("membertype"));
	}
	String code = (teasession.getParameter("code"));

	Profile pobj = Profile.find(Profile.getMember(code));

	 pobj.setMembertype(membertype);//审核状态


	 pobj.setVerifgmember(teasession._rv.toString());
	 pobj.setVerifgtime(new Date());

	 if(membertype==1)//审核通过加分
	 {
		    Communityintegral cobj = Communityintegral.find(teasession._strCommunity);
		    pobj.setMyintegral(pobj.getMyintegral()+cobj.getRegpoint());
			WestracIntegralLog.create(pobj.getMember(),2,null,0,cobj.getRegpoint(),null,new Date(),0,teasession._strCommunity);

			//审核成功，给邀请会员加分
			if(pobj.getSource()==2&&pobj.getTjmember()!=null && pobj.getTjmember().length()>0)
			{
				   Profile p = Profile.find(pobj.getTjmember());
				    p.setMyintegral(p.getMyintegral()+cobj.getInvitepoint());
				 	WestracIntegralLog.create(pobj.getTjmember(),3,null,0,cobj.getInvitepoint(),null,new Date(),0,teasession._strCommunity);
			}


			//发送短信
				String c = "您好，您已成功注册为履友，您的会员ID是“"+pobj.getCode()+"”，为您增加"+cobj.getRegpoint()+"积分，请登录lvyou.westrac.com.cn,畅游我们的家！";
				if(pobj.getImptype()==1)
				{
					//说明是导入会员
					c = "您好，您成为履友成员，您的ID号是“"+pobj.getCode()+"”,缺省密码是123456，为您增加"+cobj.getRegpoint()+"积分，请登录lvyou.westrac.com.cn绑定用户名,畅游我们的家！";
				}


				SMSMessage.create(teasession._strCommunity,pobj.getMember(),pobj.getMobile(),teasession._nLanguage,c);


			out.println("true");
	 }else if(membertype==3)
	 {
		 out.println("false");
	 }

	 return;


}else if("integralmymember".equals(act))
{
	//用户兑换的确认收货
	int icid = Integer.parseInt(teasession.getParameter("icid"));
	IntegralChange icobj = IntegralChange.find(icid);


	   icobj.updatestatic(4);

	  icobj.updateq(new Date(), teasession._rv.toString());

	  out.print("true");
	  return;


}else if("werq".equals(act))
{
	//动态添加随行人员

	int igd = Integer.parseInt(teasession.getParameter("igd"));
	int regid = Integer.parseInt(teasession.getParameter("regid"));

	int count = EventaccoMember.Count("  and eregid ="+regid);



%>


  				<%

  					Enumeration em =EventaccoMember.find(" and eregid = "+regid,0,Integer.MAX_VALUE );
  				for(int j=1;em.hasMoreElements();j++)
  				{
  					int eid = ((Integer)em.nextElement()).intValue();
  					EventaccoMember emobj = EventaccoMember.find(eid);

  				%>
				  <table border="0" cellpadding="0" cellspacing="0" id="tablecentershow">
					  <tr><td colspan="2">随行人员<%=j%>&nbsp;<a href="###" onclick="f_subdelete('<%=eid%>');">删除</a></td></tr>
					   <tr>
					      <td >姓名：<input type="text" name="acconame<%=j %>" id="acconame<%=j %>"  value="<%=Entity.getNULL(emobj.getAcconame()) %>"></td>
					       <td >性别：
								 <select name="sex<%=j %>" id="sex<%=j %>">
								        	<option value="0" <%if(emobj.getSex()==0){out.print(" selected ");} %>>男</option>
								        	<option value="1" <%if(emobj.getSex()==1){out.print(" selected ");} %>>女</option>
								 </select>
						  </td>
					    </tr>
					    <tr id="SignFrame">
						     <td >关系：
								  <select name="accorel<%=j %>" id="accorel<%=j %>">
						         	<%
						         		for(int i=0;i<Eventregistration.ACCOREL_TYPE.length;i++)
						         		{
						         			out.println("<option value= "+i);
						         			if(emobj.getAccorel()==i)
						         			{
						         				out.println(" selected ");
						         			}
						         			out.println(">"+Eventregistration.ACCOREL_TYPE[i]);
						         			out.println("</option>");
						         		}
						         	%>
					        	 </select>
					         </td>
					          <td >身份证号：<input type="text" name="cadr<%=j %>" id="cadr<%=j %>" value="<%=Entity.getNULL(emobj.getCadr()) %>" maxlength="18"></td>
					    </tr>
				  </table>
  <%
  }

  				int csc = 1;
  				if(count <= igd )
  				{
  					csc = count+1;
  				}
for(int j=csc;j<=igd;j++){

%>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecentershow">
  <tr><td colspan="2">随行人员<%=j %></td></tr>
   <tr>
      <td >姓名：<input type="text" name="acconame<%=j %>" id="acconame<%=j %>" value=""></td>
       <td >性别：
			 <select name="sex<%=j %>" id="sex<%=j %>">
			        	<option value="0" >男</option>
			        	<option value="1" >女</option>
			 </select>
	  </td>
    </tr>
    <tr id="SignFrame">
	     <td >关系：
			  <select name="accorel<%=j %>" id="accorel<%=j %>">
	         	<%
	         		for(int i=0;i<Eventregistration.ACCOREL_TYPE.length;i++)
	         		{
	         			out.println("<option value= "+i);

	         			out.println(">"+Eventregistration.ACCOREL_TYPE[i]);
	         			out.println("</option>");
	         		}
	         	%>
        	 </select>
         </td>
          <td >身份证号：<input type="text" name="cadr<%=j %>" id="cadr<%=j %>"  value="" maxlength="18"></td>
    </tr>
 </table>

<%
}

		return;
}else if("werqdelete".equals(act))
{
	//删除添加的随行人员
	int igd = Integer.parseInt(teasession.getParameter("igd"));
	int regid =Integer.parseInt(teasession.getParameter("regid"));
	Eventregistration regobj = Eventregistration.find(regid);

	EventaccoMember emobj = EventaccoMember.find(igd);
	emobj.delete();

	regobj.setAccoquantity(regobj.getAccoquantity()-1);

	return;
}else if("WestracMemberTJ".equals(act))
{
	//推荐好友
	String member = teasession.getParameter("member");
	Profile pobj = Profile.find(member);
	if(pobj.getRemembertype()==0)
	{
		pobj.setRemembertype(1);
		out.print("推荐会员成功");
	}else if(pobj.getRemembertype()==1)
	{
		pobj.setRemembertype(0);
		out.print("取消推荐成功");
	}
	return;
}else if("WestracMemberOrder".equals(act))
{
	//设置推荐好友顺序
	String member = teasession.getParameter("member");
	int rememberorder = Integer.parseInt(teasession.getParameter("rememberorder"));
	Profile pobj = Profile.find(member);
	pobj.setRememberorder(rememberorder);
	out.print("true");
	return ;
}
else if("WestracEventlogin".equals(act))
{
	//快速注册
	StringBuffer sp =new StringBuffer();
	String mobile = teasession.getParameter("mobile");

	if(Profile.isMobile(teasession._strCommunity,mobile))
	{
		//如果存在

		sp.append("/t");
	}

	sp.append("/");

	out.print(sp);
	return;

}else if("WestracCluewctype".equals(act))
{
	//是否真实的销售线索



	int wcid = Integer.parseInt(teasession.getParameter("wcid"));
	int wctype = Integer.parseInt(teasession.getParameter("wctype"));
	WestracClue wcobj = WestracClue.find(wcid);
	wcobj.setWctype(wctype);
	if(wctype<=2){
		wcobj.setWcmember(teasession._rv.toString());
	}

	if( wcobj.getMember()!=null && wcobj.getMember().length()>0)
	{

		Communityintegral cobj = Communityintegral.find(teasession._strCommunity);
		Profile pobj = Profile.find(wcobj.getMember());

		if(pobj.getMembertype()==1)
		{

					//俱乐部会员

				if(wctype==1)
				{
					//形成线索 加分
					int c = WestracIntegralLog.Count(teasession._strCommunity," and member ="+DbAdapter.cite(wcobj.getMember())+" and  wlogtype=4 and node ="+wcid);
					int c2 = WestracIntegralLog.Count(teasession._strCommunity," and member ="+DbAdapter.cite(wcobj.getMember())+" and  wlogtype=12 and node ="+wcid);
					if(c==c2)
					{
						//第一次积分


						pobj.setMyintegral(pobj.getMyintegral()+cobj.getCluepoint());
						WestracIntegralLog.create(wcobj.getMember(),4,null,wcid,cobj.getCluepoint(),null,new Date(),0,teasession._strCommunity);

						//发送短信加分
						String ctext = "感谢您提供了销售线索，为您增加"+cobj.getCluepoint()+"积分，您目前的总积分为"+pobj.getMyintegral()+"分！希望获得您更多的支持！";
     					SMSMessage.create(teasession._strCommunity,pobj.getMember(),pobj.getMobile(),teasession._nLanguage,ctext);


					}
				}else if(wctype==2)
				{
					//否 //加分
					int c = WestracIntegralLog.Count(teasession._strCommunity," and member ="+DbAdapter.cite(wcobj.getMember())+" and  wlogtype=4 and node ="+wcid);
					int c2 = WestracIntegralLog.Count(teasession._strCommunity," and member ="+DbAdapter.cite(wcobj.getMember())+" and  wlogtype=12 and node ="+wcid);


					if((c-c2)==1)
					{
						//减分
						pobj.setMyintegral(pobj.getMyintegral()-cobj.getCluepoint());

						WestracIntegralLog.create(wcobj.getMember(),12,null,wcid,0,null,new Date(),-cobj.getCluepoint(),teasession._strCommunity);

					}

				}
				/*else if(wctype==3)
				{
					//商机形成
					//形成线索 加分
					int c = WestracIntegralLog.Count(teasession._strCommunity," and member ="+DbAdapter.cite(wcobj.getMember())+" and  wlogtype=5 and node ="+wcid);
					int c2 = WestracIntegralLog.Count(teasession._strCommunity," and member ="+DbAdapter.cite(wcobj.getMember())+" and  wlogtype=13 and node ="+wcid);
					if(c==c2)
					{
						//第一次积分


						pobj.setMyintegral(pobj.getMyintegral()+cobj.getBuspoint());
						WestracIntegralLog.create(wcobj.getMember(),5,null,wcid,cobj.getBuspoint(),null,new Date(),0,teasession._strCommunity);

					}
				}else if(wctype==4)
				{
					//商机修改 减分
					//否
					int c = WestracIntegralLog.Count(teasession._strCommunity," and member ="+DbAdapter.cite(wcobj.getMember())+" and  wlogtype=5 and node ="+wcid);
					int c2 = WestracIntegralLog.Count(teasession._strCommunity," and member ="+DbAdapter.cite(wcobj.getMember())+" and  wlogtype=13 and node ="+wcid);


					if((c-c2)==1)
					{
						//减分
						pobj.setMyintegral(pobj.getMyintegral()-cobj.getBuspoint());

						WestracIntegralLog.create(wcobj.getMember(),13,null,wcid,0,null,new Date(),-cobj.getBuspoint(),teasession._strCommunity);

					}
				}
					*/
		}else if(pobj.getMembertype()==0)
		{
			//普通会员
			if(wctype==1)
			{
				//形成线索 加分
				int c = BBSPoint.count(" and member ="+DbAdapter.cite(wcobj.getMember())+" and  type=11 and node ="+wcid);
				int c2 = BBSPoint.count(" and member ="+DbAdapter.cite(wcobj.getMember())+" and  type=13 and node ="+wcid);
				if(c==c2)
				{
					//第一次积分


					pobj.setMyintegral(pobj.getMyintegral()+cobj.getCluepoint());


					 BBSPoint bp = new BBSPoint(0);
                     bp.member = wcobj.getMember();
                     bp.point = (int)cobj.getCluepoint();
                     bp.node = wcid;
                     bp.type = 11;
                     bp.set();

                   //发送短信加分
						String ctext = "感谢您提供了销售线索，为您增加"+cobj.getCluepoint()+"积分，您目前的总积分为"+pobj.getIntegral()+"分！希望获得您更多的支持！";
  					SMSMessage.create(teasession._strCommunity,pobj.getMember(),pobj.getMobile(),teasession._nLanguage,ctext);


				}
			}else if(wctype==2)
			{
				//否
				int c = BBSPoint.count(" and member ="+DbAdapter.cite(wcobj.getMember())+" and  type=11 and node ="+wcid);
				int c2 = BBSPoint.count(" and member ="+DbAdapter.cite(wcobj.getMember())+" and  type=13 and node ="+wcid);


				if((c-c2)==1)
				{
					//减分
					pobj.setMyintegral(pobj.getMyintegral()-cobj.getCluepoint());


					 BBSPoint bp = new BBSPoint(0);
                     bp.member = wcobj.getMember();
                     bp.point = -((int)cobj.getCluepoint());
                     bp.node = wcid;
                     bp.type = 13;
                     bp.set();

				}

			}
			/*
			else if(wctype==3)
			{
				//商机形成
				int c = BBSPoint.count(" and member ="+DbAdapter.cite(wcobj.getMember())+" and  type=12 and node ="+wcid);
				int c2 = BBSPoint.count(" and member ="+DbAdapter.cite(wcobj.getMember())+" and  type=14 and node ="+wcid);
				if(c==c2)
				{
					//第一次积分


					pobj.setMyintegral(pobj.getMyintegral()+cobj.getBuspoint());
					WestracIntegralLog.create(wcobj.getMember(),4,null,wcid,cobj.getBuspoint(),null,new Date(),0,teasession._strCommunity);

					 BBSPoint bp = new BBSPoint(0);
                     bp.member = wcobj.getMember();
                     bp.point = (int)cobj.getBuspoint();
                     bp.node = wcid;
                     bp.type = 12;
                     bp.set();


				}
			}else if(wctype==4)
			{
				//商机修改 减分
				//否
				int c = BBSPoint.count(" and member ="+DbAdapter.cite(wcobj.getMember())+" and  type=12 and node ="+wcid);
				int c2 = BBSPoint.count(" and member ="+DbAdapter.cite(wcobj.getMember())+" and  type=14 and node ="+wcid);


				if((c-c2)==1)
				{
					//减分
					pobj.setMyintegral(pobj.getMyintegral()-cobj.getBuspoint());


					 BBSPoint bp = new BBSPoint(0);
                     bp.member = wcobj.getMember();
                     bp.point = -((int)cobj.getBuspoint());
                     bp.node = wcid;
                     bp.type = 14;
                     bp.set();

				}
			}
			*/



		}
	}


	out.print("true");

	return;

}else if("WestracCluewctype2".equals(act))
{
	//商机判断

	int wcid = Integer.parseInt(teasession.getParameter("wcid"));
	int wctype = Integer.parseInt(teasession.getParameter("wctype"));
	WestracClue wcobj = WestracClue.find(wcid);
	wcobj.setWctype2(wctype);


	out.print("true");

	return;
}

else if("WestracCluewDelete".equals(act))
{

	int wcid = Integer.parseInt(teasession.getParameter("wcid"));

	WestracClue wcobj = WestracClue.find(wcid);
	wcobj.delete();
	out.print("true");

	return;
}else if("WestracMemberPG".equals(act))
{
	StringBuffer sql=new StringBuffer(" and membertype=1 AND community="+DbAdapter.cite(teasession._strCommunity));
	java.util.Enumeration e = Profile.find(sql.toString(),0,Integer.MAX_VALUE);
	Date t =Entity.Months(new Date() ,-3);
	for(int i=1;e.hasMoreElements();i++)
	{
		String member =((String)e.nextElement());
	    Profile pobj = Profile.find(member);


	    int logint =Logs.count(teasession._strCommunity," AND rmember = "+DbAdapter.cite(member)+" AND time >= "+DbAdapter.cite(t)); //登陆次数
	    int wcing =WestracClue.count(teasession._strCommunity," AND wctype =1 and member= "+DbAdapter.cite(member)+" AND times >= "+DbAdapter.cite(t));//提供销售线索条数;
	    int eventing=Eventregistration.Count(teasession._strCommunity," AND member="+DbAdapter.cite(member)+" AND verifg=1 AND times >= "+DbAdapter.cite(t));//参加活动次数
	    int tjint = Profile.count(" and tjmember="+DbAdapter.cite(member)+" AND time >= "+DbAdapter.cite(t));//推荐会员数

	    if(logint<=5 || wcing <=5 || eventing<=1 || tjint<=1)
	    {
	    	pobj.setActives(1);
	    }else if(logint>=5 || wcing >= 5 || eventing >= 1 || tjint >= 1)
	    {
	    	pobj.setActives(2);
	    }else if(logint>=15 || wcing >= 15 || eventing >= 5 || tjint >= 5)
	    {
	    	pobj.setActives(3);
	    }
        System.out.println(member+"："+logint+" "+wcing+" "+eventing+" "+tjint+" 活跃度："+pobj.getActives());
	}
	out.println("活跃度评估完成");
	return;
}
else if("WestracEvent_login".equals(act))
{
  //登陆
  String username=teasession.getParameter("mobile").trim();
  String paw=teasession.getParameter("paw").trim();

  DbAdapter db=new DbAdapter();
  try
  {
    db.executeQuery("SELECT member FROM Profile WHERE " + DbAdapter.cite(username) + " IN(member,mobile,email)");
    if(db.next())
    {
      username=db.getString(1);
    }else
    {
      out.print("2");
      return;
    }
  }finally
  {
    db.close();
  }

  String sc = "1";
  Profile p=Profile.find(username);
  if(!Profile.isPassword(username,paw))
  {
    sc="2";
  }else if(p.isLocking())
  {
    sc="4";
  }else
  {
    //RV rv = new RV(username);
    //OnlineList.create(session.getId(),teasession._strCommunity,username,request.getRemoteAddr());
    //Logs.create(teasession._strCommunity,rv,1,teasession._nNode,request.getRemoteAddr());
    //
    //h.setCook("member",MT.enc(p.toString()),h.getInt("expiry",-1));
    session.setAttribute("member",p.getProfile());
    /* if(session.getAttribute("point")!=null)
    {
      p.setCoordinate((String)session.getAttribute("point"));
    } */
  }
  out.print(sc);
  return;

}else if("WRegcadr".equals(act))
{
	//判断身份证不能重复

	String card = teasession.getParameter("card");
	if(Profile.isCard(teasession._strCommunity,card))
	{
		out.print("true");
	}else
	{
		out.print("false");
	}
	return ;

}else if("WRegmobile".equals(act))
{
//判断手机是否重复

	String mobile = teasession.getParameter("mobile");
	if(Profile.isMobile(teasession._strCommunity,mobile))
	{
		out.print("true");
	}else
	{
		out.print("false");
	}
	return ;
}else if("DxDayOrder".equals(act))
{
	//道教的日历
	Date ymd = null;
	if(teasession.getParameter("ymd")!=null && teasession.getParameter("ymd").length()>0)
	{
		ymd = Entity.sdf.parse(teasession.getParameter("ymd"));
	}
	String affaircontent = URLDecoder.decode(teasession.getParameter("affaircontent"),"UTF-8");//teasession.getParameter("affaircontent");
	affaircontent =affaircontent.replaceAll("\\n","<br>");
	DayOrder dobj = DayOrder.find(DayOrder.getId(teasession._strCommunity,ymd));
	if(DayOrder.getId(teasession._strCommunity,ymd)>0)
	{
		dobj.set(affaircontent);
	}else
	{
		DayOrder.create(affaircontent,ymd,teasession._strCommunity,teasession._rv.toString());
	}
	out.println("true");
	return;
}else if("ClssnMember_Determine".equals(act))
{
	String porders = teasession.getParameter("porders");

	if(porders!=null && porders.length()>0)
	{
		int invoicetype = Integer.parseInt(teasession.getParameter("invoicetype"));
		for(int i=1;i<porders.split("/").length;i++)
		{
			String memberorder = porders.split("/")[i];



		    MemberOrder  moobj = MemberOrder.find(memberorder);
		    UpgradeMember umobj = UpgradeMember.find(0);

			 Enumeration e = UpgradeMember.find(teasession._strCommunity," and member= "+DbAdapter.cite(moobj.getMember())+" ORDER BY becometime DESC ",0,1);
			   if(e.hasMoreElements())
			   {
				    int u = ((Integer)e.nextElement()).intValue();
				     umobj = UpgradeMember.find(u);
			   }

			   umobj.setInvoice(invoicetype);
			   moobj.setInvoice(invoicetype);

		}
	}
	out.println("邮寄状态修改成功!");
	return;
}else if("editpassword".equals(act))
{
	String member = teasession.getParameter("member");
	Profile p = Profile.find(member);
	p.setPassword("111111");
	out.println("密码重置成功，重置后密码为“111111”");
	return;
}else if("dels".equals(act)){
	String member = teasession.getParameter("members");
	String[] mems=member.split("/");
	for(int i=1;i<mems.length;i++){
		Profile p=Profile.find(mems[i]);
		p.deleteall();
	}
	//AdminUsrRole aur=AdminUsrRole.find(teasession._strCommunity, member);
/* 	if(aur!=null){
		aur.setRole("/");
		aur.delete();
	}
	Profile p = Profile.find(member);
	p.delete(); */
	 out.print("删除成功！");
	return;
}else if("Genergydelete".equals(act))
{
	// 删除用户
	Profile p = Profile.find(teasession.getParameter("member"));

	p.deleteall();
	WestracIntegralLog.delete(teasession.getParameter("member"));
	out.print("true");
	return;
}else if("setprice".equals(act))
{
	int price = Integer.parseInt(teasession.getParameter("price"));
	int node = Integer.parseInt(teasession.getParameter("node"));
	PriceSet p=PriceSet.find(node);
	p.price=price;
	p.set();
	out.print("true");
	return;
}else if("deleteNightShop".equals(act))
{
	Node.find(teasession._nNode).delete(teasession._nLanguage);
	NightShop.find(teasession._nNode, teasession._nLanguage).delete(teasession._nNode);

	return;
}else if("addCity".equals(act))
{
	String country = teasession.getParameter("country");//国家
	String provinceName_CN = teasession.getParameter("provinceName_CN");//中文省份
	String provinceName_EN = teasession.getParameter("provinceName_EN");//英文省份
	String cityid = teasession.getParameter("cityid");
	String hotcitys = teasession.getParameter("hotcity");//是否热门城市
	int hotcity=0;
	if(hotcitys!=null&&(("1").equals(hotcitys.trim()))){
		hotcity=1;
	}
	   Elongcity eobj=Elongcity.find(cityid);
	   if(eobj.isExists())
	   {
		   //修改
		   eobj.set(country, provinceName_CN, provinceName_EN,hotcity);
	   }else
	   {
		   //添加
		   String maxcityid = Elongcity.getMaxcityid();
		   int maxprovinceId = Elongcity.getMaxprovinceIdint();
		   int provinceIdint = maxprovinceId;
		   cityid =maxcityid;
		   String p = String.valueOf(maxprovinceId).substring(0,String.valueOf(maxprovinceId).length()-2);

		    if(Integer.parseInt(p)<10)
		    {
		    	p = "0"+p;
		    }


		   maxcityid = maxcityid.substring(p.length(),maxcityid.length());

		   if((p+"01").equals(maxcityid))
		   {
	   cityid = String.valueOf(Integer.parseInt(Elongcity.getMaxcityid())+1);
		   }else
		   {
	   cityid = (String.valueOf(Integer.parseInt(p)+1))+"01";
	   provinceIdint = provinceIdint+100;
		   }


		   Elongcity.create(country, provinceName_CN, provinceName_EN, null, null, cityid, provinceIdint,hotcity);

	   }
	   out.println("操作成功");
	   return;

}else if("addProvincelist".equals(act))
{
	String country = teasession.getParameter("country");//国家
	String provinceName_CN = teasession.getParameter("provinceName_CN");//中文省份
	String provinceName_EN = teasession.getParameter("provinceName_EN");//英文省份
	String cityid = teasession.getParameter("cityid");
	String hotcitys = teasession.getParameter("hotcity");//是否热门城市
	int hotcity=0;
	if(hotcitys!=null&&(("1").equals(hotcitys.trim()))){
		hotcity=1;
	}
	   Elongcity eobj=Elongcity.find(cityid);
	   if(eobj.isExists())
	   {
		   //修改
		   eobj.set(country, provinceName_CN, provinceName_EN,hotcity);
	   }else
	   {
		   //添加
		   String maxcityid = Elongcity.getMaxcityid();
		   int maxprovinceId = Elongcity.getMaxprovinceIdint();
		   int provinceIdint = maxprovinceId;
		   cityid =maxcityid;
		   String p = String.valueOf(maxprovinceId).substring(0,String.valueOf(maxprovinceId).length()-2);

		    if(Integer.parseInt(p)<10)
		    {
		    	p = "0"+p;
		    }


		   maxcityid = maxcityid.substring(p.length(),maxcityid.length());

		   if((p+"01").equals(maxcityid))
		   {
	   cityid = String.valueOf(Integer.parseInt(Elongcity.getMaxcityid())+1);
		   }else
		   {
	   cityid = (String.valueOf(Integer.parseInt(p)+1))+"01";
	   provinceIdint = provinceIdint+100;
		   }


		   Elongcity.create(country, provinceName_CN, provinceName_EN, null, null, cityid, provinceIdint,hotcity);

	   }
	   out.println("操作成功");
	   return;

}else if("deleteProvincelist".equals(act))
{
	String cityid = teasession.getParameter("cityid");
	Elongcity eobj=Elongcity.find(cityid);
	eobj.delete();

	return;
}else if("addCitylist".equals(act))
{
	String cityid = teasession.getParameter("cityid");
	String cityName_CN = teasession.getParameter("cityName_CN");
	String cityName_EN = teasession.getParameter("cityName_EN");
	int provinceid = Integer.parseInt(teasession.getParameter("provinceid"));
	String hotcitys = teasession.getParameter("hotcity");//是否热门城市
	int hotcity=0;
	if(hotcitys!=null&&(("1").equals(hotcitys.trim()))){
		hotcity=1;
	}
	 Elongcity eobj=Elongcity.find(cityid);

	   if(eobj.isExists())
	   {
		   //修改
		   eobj.setCity(provinceid, cityName_CN, cityName_EN,hotcity);
	   }else
	   {
		   String maxcityid = Elongcity.getMincityid(provinceid);//0201
		   int maxprovinceId = provinceid;//200

		   String p = String.valueOf(maxprovinceId).substring(0,String.valueOf(maxprovinceId).length()-2);//2

		    if(Integer.parseInt(p)<10)
		    {
		    	p = "0"+p;//02
		    }
		   maxcityid = maxcityid.substring(p.length(),maxcityid.length());//01

		  		if (("01").equals(maxcityid))//如果有01 修改
			{
				cityid = p + "01";
				Elongcity eobj2 = Elongcity.find(cityid);
				if (eobj2.getCityName_CN() != null
						&& eobj2.getCityName_CN().length() > 0) {
					String pci = p + "01";
					Elongcity eobj3 = Elongcity.find(pci);

					cityid = String.valueOf(Integer.parseInt(Elongcity
							.getMaxcityid(provinceid)) + 1);
					Elongcity.create(eobj3.getCountry(),
							eobj3.getProvinceName_CN(),
							eobj3.getProvinceName_EN(), cityName_CN,
							cityName_EN, cityid, provinceid,hotcity);
				} else {
					eobj2.setCity(provinceid, cityName_CN, cityName_EN,hotcity);
				}
			} else {
				// cityid = (String.valueOf(Integer.parseInt(p)+1))+"01";
				// provinceIdint = provinceIdint+100;
				String pci = p + "01";
				Elongcity eobj3 = Elongcity.find(pci);

				cityid = String.valueOf(Integer.parseInt(Elongcity
						.getMaxcityid(provinceid)) + 1);
				Elongcity.create(eobj3.getCountry(),
						eobj3.getProvinceName_CN(),
						eobj3.getProvinceName_EN(), cityName_CN,
						cityName_EN, cityid, provinceid,hotcity);
			}

		}

		out.println("操作成功");
		return;
	} else if ("deleteCity".equals(act)) {//删除2级类
		String cityid = teasession.getParameter("cityid");
		int provinceid = Integer.parseInt(teasession
				.getParameter("provinceid"));
		String maxcityid = cityid;//0201
		int maxprovinceId = provinceid;//200

		String p = String.valueOf(maxprovinceId).substring(0,
				String.valueOf(maxprovinceId).length() - 2);//2

		if (Integer.parseInt(p) < 10) {
			p = "0" + p;//02
		}
		maxcityid = maxcityid.substring(p.length(), maxcityid.length());//01

		if (("01").equals(maxcityid))//如果有01 修改
		{
			cityid = p + "01";
			Elongcity eobj2 = Elongcity.find(cityid);

			eobj2.setCity(provinceid, null, null,eobj2.getHotcity());
			Elonglocation.delete(cityid);

		} else {
			// cityid = (String.valueOf(Integer.parseInt(p)+1))+"01";
			// provinceIdint = provinceIdint+100;

			Elongcity eobj3 = Elongcity.find(cityid);
			eobj3.delete();
			Elonglocation.delete(cityid);

		}
		out.print("删除成功");
 		return;

	} else if ("addElongLocationlist".equals(act)) {


		String Name_CN = teasession.getParameter("Name_CN");
		String Name_EN = teasession.getParameter("Name_EN");

		String locationtype = teasession.getParameter("locationtype");


		String cityid = teasession.getParameter("cityid");
		String elid = teasession.getParameter("elid");




		Elonglocation eobj = Elonglocation.find(elid, cityid);

		if(eobj.isExists())
		{
			if(Elonglocation.isName("Name_CN", Name_CN, locationtype, cityid))
			{
				out.println("您的中文名称已经存在,请换个名称");
				return;
			}
			if(Elonglocation.isName("Name_CN", Name_CN, locationtype, cityid))
			{
				out.println("您的英文名称已经存在,请换个名称");
				return;
			}
		}else
		{
			if(!Name_CN.equals(eobj.getName_CN()))
			{
				if(Elonglocation.isName("Name_CN", Name_CN, locationtype, cityid))
				{
					out.println("您的中文名称已经存在,请换个名称");
					return;
				}
				if(Elonglocation.isName("Name_CN", Name_CN, locationtype, cityid))
				{
					out.println("您的英文名称已经存在,请换个名称");
					return;
				}
			}
		}



		if (eobj.isExists()) {
			eobj.set(Name_CN, Name_EN, locationtype, cityid);
		} else {

			DecimalFormat df = new java.text.DecimalFormat("0000"); // DateFormat.getDateInstance();

			if (locationtype.equals("district")) {
				String maxid = Elonglocation.getEid(cityid);//获取最大
				if (maxid != null && maxid.length() > 0) {
					//有记录
					elid = df.format(Double.parseDouble(String
							.valueOf(Integer.parseInt(maxid
									.replaceFirst("^0*", "")) + 1)));
				} else {
					elid = "0001";
				}

			} else if (locationtype.equals("commercial")) {
				String maxid = Elonglocation.getEid(locationtype,
						cityid);//获取最大010101
				if (maxid != null && maxid.length() > 0) {
					int sss = Integer.parseInt(maxid.substring(
							cityid.length(), maxid.length())
							.replaceFirst("^0*", "")) + 1;
					elid = cityid + String.valueOf(sss);
				} else {
					elid = cityid + "01";
				}

			} else if (locationtype.equals("Landmark")) {
				String maxid = Elonglocation.getEid(cityid);//获取最大
				if (maxid != null && maxid.length() > 0) {
					//有记录
					elid = df.format(Double.parseDouble(String
							.valueOf(Integer.parseInt(maxid
									.replaceFirst("^0*", "")) + 1)));
				} else {
					elid = "0001";
				}
			}

			Elonglocation.create(Name_CN, Name_EN, locationtype,
					cityid, elid);
		}
		out.print("操作成功");
		return;
	} else if ("deleteElongLocationlist".equals(act)) {
		String cityid = teasession.getParameter("cityid");
		String elid = teasession.getParameter("elid");
		Elonglocation eobj = Elonglocation.find(elid, cityid);
		eobj.delete();
		out.println("删除成功");
		return;
	}else if ("linkmen".equals(act)) {
		StringBuffer sb=new StringBuffer("");
		int pro=teasession.getParameter("workproject")==null?0:Integer.parseInt(teasession.getParameter("workproject"));
		java.util.Enumeration e2=Worklinkman.find(teasession._strCommunity,"  AND workproject="+Flowitem.find(pro).getWorkproject(),0,Integer.MAX_VALUE);
        while(e2.hasMoreElements())
        {
          String member_e=((String)e2.nextElement());
          //Worklinkman worklinkman_obj=Worklinkman.find(teasession._strCommunity,member_e);
          sb.append("<option value='"+member_e+"'>"+member_e+"</option>");
        }
        out.print(sb.toString().length()>0?sb.toString():"<option>-------------</option>");
		return;
	}else if ("selhos".equals(act)) {
		StringBuffer sb=new StringBuffer("<option value='-1'>请选择</option>");
		sb.append("<option value='1'>代理商</option>");
		int hosid=teasession.getParameter("hosid")==null?0:Integer.parseInt(teasession.getParameter("hosid"));
		List<ShopHospital> shlist = ShopHospital.find("", 0, 500);
		for(int i=0;i<shlist.size();i++){
			ShopHospital sh = shlist.get(i);
			sb.append("<option "+(sh.getId()==hosid?" selected='selected'":"")+" value='"+sh.getId()+"'>"+sh.getName()+"</option>");
		}
		out.print(sb.toString());
		return;
	}else if ("selhosmember".equals(act)) {
		StringBuffer sb=new StringBuffer("<option value='-1'>--请选择--</option>");
		int hosid=teasession.getParameter("hosid")==null?0:Integer.parseInt(teasession.getParameter("hosid"));
		List<ShopHospital> shlist = ShopHospital.find("", 0, Integer.MAX_VALUE);
		for(int i=0;i<shlist.size();i++){
			ShopHospital sh = shlist.get(i);
			sb.append("<option "+(sh.getId()==hosid?" selected='selected'":"")+" value='"+sh.getId()+"'>"+sh.getName()+"</option>");
		}
		out.print(sb.toString());
		return;
	}else if ("seltype".equals(act)) {
		StringBuffer sb=new StringBuffer("<option value='-1'>请选择</option>");
		int typeid=teasession.getParameter("typeid")==null?0:Integer.parseInt(teasession.getParameter("typeid"));
		if(typeid==0){
			for(int i=1;i<4;i++){
				sb.append("<option value='"+i+"'>"+Profile.MEMBER_TYPE[i]+"</option>");
			}
		}else{
			for(int i=4;i<Profile.MEMBER_TYPE.length;i++){
				sb.append("<option value='"+i+"'>"+Profile.MEMBER_TYPE[i]+"</option>");
			}
		}
		out.print(sb.toString());
		return;
	} else if ("ispass".equals(act)) {
		Http h=new Http(request,response);
		//登陆
		String username = teasession.getParameter("mobile").trim();
		String paw = teasession.getParameter("paw").trim();

		DbAdapter db = new DbAdapter();
		try {
			db.executeQuery("SELECT member FROM Profile WHERE "
					+ DbAdapter.cite(username)
					+ " IN(member,mobile,email)");
			if (db.next()) {
				username = db.getString(1);
			} else {
				out.print("2");
				return;
			}
		} finally {
			db.close();
		}

		String sc = "1";
		Profile p = Profile.find(username);
		if (!Profile.isPassword(username, paw)) {
			sc = "2";
		} else if (p.isLocking()) {
			sc = "4";
		} else {
			String myact = teasession.getParameter("myact");
			String mob = teasession.getParameter("mob");

			String sql = " AND ";
			if (myact.equals("qq")) {
				sql += "openid is not null AND ";
			} else if (myact.equals("wx")) {
				sql += "wxopenid is not null AND ";
			} else if (myact.equals("wb")) {
				sql += "wbuid is not null AND ";
			}
			sql += mob + " IN(member,mobile,email)";
			int count = Profile.count(sql);
			if (count == 0) {
				RV rv = new RV(p.member);
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
			} else {
				sc = "6";
			}
		}
		out.print(sc);
		return;
	}else if("byopenidlogin".equals(act)){
		Http h=new Http(request,response);
		String openid = teasession.getParameter("openid").trim();
		boolean flag = Profile.flagopenid(openid);
		if(flag){
			Profile p = Profile.find(0);
           	ArrayList al = Profile.find1(" AND openid=" +Database.cite(openid) ,0,1);
            p = al.size() < 1 ? Profile.find(0) : (Profile) al.get(0);
            
			String auto = h.get("autologin","");
            if(auto.length()>0){
            	h.setCook("autologin",MT.enc(p.getLogint() + "|" + p.getMember() + "|" + p.getPassword()),7*60*24);
            }
            RV rv = new RV(p.getMember());
            Logs.create(h.community,rv,1,h.node,request.getRemoteAddr());
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
            
			out.print("succ");
			return;
		}else{
			out.print("err");
			return;
		}
	}
%>
