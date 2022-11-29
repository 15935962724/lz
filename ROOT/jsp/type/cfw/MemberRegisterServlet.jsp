<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.ui.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.cfw.*"%>

<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@page import="java.net.URLEncoder"%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);


String act = teasession.getParameter("act");
String nexturl = teasession.getParameter("nexturl");
if("MemberRegister".equals(act))
{

	int mrid = 0;
	if(teasession.getParameter("mrid")!=null && teasession.getParameter("mrid").length()>0)
	{
		mrid = Integer.parseInt(teasession.getParameter("mrid"));
	}
	MemberRegister mrobj = MemberRegister.find(mrid);
		String names=teasession.getParameter("names");
		int gender = Integer.parseInt(teasession.getParameter("gender"));

		Date birthdate = null;
		if(teasession.getParameter("birthdate")!=null&&teasession.getParameter("birthdate").length()>0)
		{
			birthdate = MemberRegister.sdf.parse(teasession.getParameter("birthdate"));
		}

		String occupation = teasession.getParameter("occupation");

		String conporation = teasession.getParameter("conporation");
		String mobile = teasession.getParameter("mobile");
		String tel = teasession.getParameter("tel");
		String email = teasession.getParameter("email");
		String fax = teasession.getParameter("fax");
		String address = teasession.getParameter("address");
		String postalcode = teasession.getParameter("postalcode");
		String favorite = teasession.getParameter("favorite");
		String activity = "/";
		 if(teasession.getParameter("activity")!=null && teasession.getParameter("activity").length()>0)
		  {
			  String bcString [] = teasession.getParameterValues("activity");
			  for(int ii=0;ii<bcString.length;ii++)
			  {
				  activity =activity +bcString[ii]+"/";
			  }
		  }

	    String membersignature = teasession.getParameter("membersignature");
		Date signature = null;
		if(teasession.getParameter("signature")!=null&&teasession.getParameter("signature").length()>0)
		{
			signature = MemberRegister.sdf.parse(teasession.getParameter("signature"));
		}

		if(mrobj.isExists())
		{
			mrobj.set(names,gender,birthdate,occupation,conporation,mobile,tel,email,fax,address,postalcode,activity,membersignature,signature,favorite);
		}else
		{
			MemberRegister.create(names,gender,birthdate,occupation,conporation,mobile,tel,email,fax,address,postalcode,activity,teasession._strCommunity,new Date(),membersignature,signature,favorite);
		}

		StringBuffer sp = new StringBuffer();

		sp.append("<script  language='javascript'>");
		sp.append("alert('");
		sp.append("中国书画艺术沙龙会员登记成功\\n\\n");
		sp.append("银行汇款：\\n");
		sp.append("户名：《中国书画》杂志社\\n开户行：工行陶然亭支行\\n帐号：02000491092000162-71\\n");
		sp.append("邮局汇款：\\n");
		sp.append("北京市海淀区亮甲店130号恩济大厦B座4层 《中国书画》杂志社发行部收 \\n");
		sp.append("邮编：100142\\n");
		sp.append("咨询电话：010-58393995  15910958576");


		sp.append("');");
		sp.append("window.location.href='"+nexturl+"';");
		sp.append("</script> ");

		out.print(sp.toString());


         return;


}
else if("del".equals(act)){
  int mrid = 0;
	if(teasession.getParameter("mrid")!=null && teasession.getParameter("mrid").length()>0)
	{
		mrid = Integer.parseInt(teasession.getParameter("mrid"));
	}
    MemberRegister mrobj = MemberRegister.find(mrid);
    mrobj.delete();
    response.sendRedirect("/jsp/type/cfw/MemberRegisterList.jsp");
}



%>

