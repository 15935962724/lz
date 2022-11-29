<%@page import="tea.entity.westrac.IntegralMyScore"%>
<%@page import="tea.entity.integral.IntegralPrize"%>
<%@page import="tea.entity.integral.IntegralChange"%>
<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="tea.entity.westrac.Eventregistration"%>
<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.node.Event"%>
<%@page import="tea.entity.node.Node"%>
<%@page import="tea.entity.admin.AdminRole"%>
<%@page import="tea.entity.admin.AdminUnit"%>
<%@page import="tea.entity.admin.AdminUsrRole"%>
<%@page import="java.net.URLEncoder"%>
<%@ page import="tea.resource.Resource" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.*"%><%@page import="tea.entity.volunteer.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.resource.*" %><%@page import="java.io.*" %>
<%@page import="java.util.*"%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
String community=teasession._strCommunity;



if(teasession._rv==null)
{
	out.println("您还没有登录，没有权限查看，请登录");
	return;
}


int icid = Integer.parseInt(teasession.getParameter("icid"));
IntegralChange icobj = IntegralChange.find(icid);

if(!icobj.getApplymember().equals(teasession._rv.toString()))
{
	out.println("您没有权限评论");
	return;
}





if("POST".equals(request.getMethod()))
{
	
	

	int score = 0;
	if(teasession.getParameter("score")!=null && teasession.getParameter("score").length()>0)
	{
		score = Integer.parseInt(teasession.getParameter("score"));
	}
    	String value[] = request.getParameterValues("ipid");
      if(value != null && score > 0)
      {
      
          for(int index = 0;index < value.length;index++)
          {

             int ipid =Integer.parseInt(value[index]);

			IntegralMyScore imobj = IntegralMyScore.find(IntegralMyScore.getImid(teasession._strCommunity,teasession._rv.toString(),ipid));
			if(imobj.isExists())
			{
				imobj.set(score);
			}else
			{
				IntegralMyScore.create(teasession._rv.toString(),ipid,score,teasession._strCommunity,new Date());	
			}
          }
		
	 }
          out.print("<script>alert('您的评论成功');window.close();</script>");
	out.print("<script>parent.ymPrompt.close();</script>");
	return;
}
      




%>
<html>
<base target="tar"/>
<title>我要评价</title>
<HEAD>
  <link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
  <link href="/tea/CssJs/Home.css" rel="stylesheet" type="text/css">
  <script src="/tea/tea.js" type="text/javascript"></script>
  <script src="/tea/mt.js" type="text/javascript"></script>
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/ym/ymPrompt.js" type=""></SCRIPT>
<link href="/tea/ym/skin/dmm-green/ymPrompt.css" rel="stylesheet" type="text/css">
  <script src="/tea/city.js"></script>
</HEAD>



<body topmargin="0" leftmargin="0" marginheight="0" marginwidth="0" scroll="yes">
<script type="text/javascript">
window.name='tar';
function f_sub()
{
	if(submitCheckbox(form1.ipid,'请选择要评论的商品'))
	{
		form1.submit();	
	}else
	{
		return  false;
	}
}
</script> 

<h2>我要评价</h2>
<form name="form1" action="?" method="POST" target="tar" onsubmit="return f_sub();" >



<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="icid" value="<%=icid%>">


<input type="hidden" name="act" >





<table border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
 <tr id="tableonetr">
 
      <td nowrap >感谢您对商品的支持，请对此次商品进行评价</td>
</tr>



 <tr id="tableonetr">
 
      <td nowrap >请选择兑换的商品</td>
      
</tr>
<%
boolean b = false;
if(icobj.getPresent()!=null && icobj.getPresent()!="/")
{
  String pp = icobj.getPresent();
  if(pp.indexOf("/")!=-1)
  {
   int  sumshop = 0;
    String pps[] = pp.split("/");
    for(int i =1;i<pps.length;i++)
    {
      int j = Integer.parseInt(pps[i]);
      IntegralPrize intprize = IntegralPrize.find(j);
     
      IntegralMyScore imobj = IntegralMyScore.find(IntegralMyScore.getImid(teasession._strCommunity,teasession._rv.toString(),j));
  	
      if(imobj.getIpid()==0)
      {
    	  b =true;
      }
      
      out.print("<tr>");
      out.print("<td>");
      out.print("<input type=\"checkbox\" name=\"ipid\" ");
      	
      if(imobj.getIpid()==j)
      {
    	  out.print(" checked ");
      }
      out.print("value="+j+">");
      out.print(intprize.getShopping());
      out.print("</td>");
      out.print("</tr>");
      
    }
  }
}
	
	 %>
	
	
	<%if(b){ %>
 <tr id="tableonetr">
 
      <td nowrap ><%
      
      	for(int i=1;i<Eventregistration.SCORE_TYPE.length;i++)
      	{
      		out.print("<input type=radio name=score value="+i);
      	
      		out.print(">"+Eventregistration.SCORE_TYPE[i]);
      		out.print("&nbsp;");
      	}
      %></td>

</tr>
 <tr id="tableonetr">
 
      <td nowrap align="center" ><input type="submit""  value="提交"></td>

</tr>
<%}else{ %>
 <tr id="tableonetr">
 
      <td nowrap align="center" >您已经对上面商品评价，不能重复评价！</td>

</tr>
<%} %>
</form>
</body>
</html>
