<%@page import="tea.entity.Entity"%>
<%@page import="tea.entity.admin.mov.UpgradeMember"%>
<%@page import="tea.entity.admin.mov.MemberOrder"%>
<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="java.util.*" %>
<%@page import="java.io.*" %>
<% request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


if("POST".equals(request.getMethod()))
{
	String 	becometime =  teasession.getParameter("becometime");
	String  consign = teasession.getParameter("consign");
	if(consign!=null && consign.length()>0)
	{
		for(int i=1;i<consign.split("/").length;i++)
		{
			String memberorder = consign.split("/")[i];
			
		    MemberOrder  moobj = MemberOrder.find(memberorder);
		    UpgradeMember umobj = UpgradeMember.find(0);
			 
			 Enumeration e = UpgradeMember.find(teasession._strCommunity," and member= "+DbAdapter.cite(moobj.getMember())+" ORDER BY becometime DESC ",0,1);
			   if(e.hasMoreElements())
			   {
				    int u = ((Integer)e.nextElement()).intValue();
				     umobj = UpgradeMember.find(u);
			   }
			   
			   umobj.setBecometime(Entity.sdf.parse(becometime));
			   moobj.setBecometime(Entity.sdf.parse(becometime));
			   
			
		}
	}
	out.print("<script>alert('金牌会员有效期设置成功！');window.returnValue=1;window.close();</script>");
	 return;   
	
}


%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<SCRIPT language="JavaScript">
window.name='tar';
function CheckForm()
{
	
	if(form1.becometime.value=='')
	{
		alert("请选中阅读有效期.");
		form1.becometime.focus();
		return false;
	}
	
	
	  var consign="/";
	  var op=form1.role1.options;
	  for(var i=0;i<op.length; i++)
	  {
	    consign=consign+op[i].value+"/";
	  }
	  form1.consign.value=consign;
	  form1.submit();
	
  
  
}
</script>
</head>
<BODY>
<h1>金牌会员设置</h1>



<form name="form1" method="POST" action="?"  target="tar" >
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
  <input type="hidden" name="consign">

  <table cellSpacing="0" cellPadding="0" border="0" id="tablecenter">
  <tr id=tableonetr> 
  			 <td align="right">阅读有效期：</td>
  			 <td><input id="time_c" name="becometime" size="7"  value=""  style="cursor:pointer" readonly="readonly" onclick="new Calendar().show('form1.becometime');"> 
	        <img style="margin-bottom:-8px;cursor:pointer;"  src="/tea/image/bbs_edit/table.gif"   onclick="new Calendar().show('form1.becometime');" /></td>
  		</tr>
    
    <tr align="center">
      <td align="right">选定金牌会员</td>
      <td>&nbsp;</td>
      <td >备选金牌会员</td>
    </tr>
    <tr>
      <td  align="right">
      <select name="role1" size="12" multiple style="WIDTH:200px;"  ondblclick="move(form1.role1,form1.role2,true);">
      <%
     
      %>
    </select>
    </td> 
    <td  align="center">
    <input type="button" value=" ← " onClick="move(form1.role2,form1.role1,true);" >
    <br>
    <input type="button" value=" → "  onClick="move(form1.role1,form1.role2,true);">    </td>
    <td>
    <select name="role2" ondblclick="move(form1.role2,form1.role1,true);" multiple style="WIDTH:200px;" size="12">
    <%
    
    String sql = " AND p.member !=N'webmaster' and m.period > 0 ORDER BY times DESC ";
    java.util.Enumeration e = MemberOrder.findMP(teasession._strCommunity,sql,0,Integer.MAX_VALUE);
	
	for(int i=1;e.hasMoreElements();i++)
	{
		String memberorder =((String)e.nextElement());
	    MemberOrder  moobj = MemberOrder.find(memberorder);
	  
	    out.print("<option value="+memberorder+" >"+moobj.getMember()+"</option>");
	}
      %>
    </select>
    </td>
    </tr>
  </table>
  <BR>

  <input type="button" value="　提交　" onclick="CheckForm();">&nbsp;

   <input type="button" value="　关闭　"  onClick="javascript:window.close();">

</FORM>


</BODY>
</HTML>
