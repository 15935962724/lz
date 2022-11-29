<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %>
<%@page  import="tea.entity.node.*" %><%@page  import="tea.entity.site.*" %><%@ page import="java.util.*" %><%@ page import="java.io.*" %>
<%@ page import="tea.ui.*" %><%@ page import="tea.html.*" %>
<%@ page import="tea.htmlx.*"%>
<%

request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);

if (teasession._rv == null) {
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}



String nexturl=teasession.getParameter("nexturl");
String act = teasession.getParameter("act");

int  psid = 0;
if(teasession.getParameter("psid")!=null && teasession.getParameter("psid").length()>0)
{
  psid = Integer.parseInt(teasession.getParameter("psid"));
}
int disid2 = 0;
if(teasession.getParameter("disid2")!=null && teasession.getParameter("disid2").length()>0)
{
	 disid2 = Integer.parseInt(teasession.getParameter("disid2"));
}

Discoun discounobj = Discoun.find(disid2);


if("EditDiscoun".equals(act))
{
	int voteid =   Integer.parseInt(teasession.getParameter("voteid"));
	float disprice = Float.parseFloat(teasession.getParameter("disprice"));
	Date timek =   TimeSelection.makeTime(teasession.getParameter("timekYear"),teasession.getParameter("timekMonth"),teasession.getParameter("timekDay"),teasession.getParameter("timekHour"),teasession.getParameter("timekMinute"));
	Date timej =   TimeSelection.makeTime(teasession.getParameter("timejYear"),teasession.getParameter("timejMonth"),teasession.getParameter("timejDay"),teasession.getParameter("timejHour"),teasession.getParameter("timejMinute"));
	
  if(discounobj.isExist()) 
  {
   		discounobj.set(psid,voteid,disprice,timek,timej,teasession._rv.toString(),teasession._strCommunity);
  }else
  {
       Discoun.create(psid,voteid,disprice,timek,timej,teasession._rv.toString(),teasession._strCommunity);
  }
  
  out.print("<script>alert('打折设置成功！');</script>");
}else if("delete".equals(act))
{
	discounobj.delete(); 
	out.println("<script>alert('您已经删除这个打折设置!');</script>");
}
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<script>
window.name='tar';
function f_submit()
{
  if(form1.voteid.value==0)
  {
    alert('请选择票种!');
    document.form1.voteid.focus();
    return false;
  } 
  if(form1.disprice.value==0)
  {
  	alert('请选择折扣!');
  	form1.disprice.focus();
  	return false;
  }
}
//编辑票种
function f_edit(igd)
{
  form1.disid2.value=igd;
  form1.act.value='';
  form1.submit();
  
} 
//删除票种
function f_delete(igd)
{
	form1.disid2.value=igd;
	form1.act.value='delete';
	form1.submit();
}
</script>
<h1>演出管理--场次设置--打折设置</h1>
<div id="head6"><img height="6" src="about:blank"></div>

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
    <td  align="left" colspan=10><%=PerformStreak.find(psid).getPsname() %></td>
	</tr>
  <form name="form1" method="post" action="?"   target="tar"   onSubmit="return f_submit();">
  <input type="hidden" name="act" value="EditDiscoun">
  <input type="hidden" name="psid" value="<%=psid %>">
  <input type="hidden" name="community" value="<%=teasession._strCommunity %>">
 <input type="hidden" name="disid2" value="<%=disid2 %>">
  
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id="tableonetr">
      <td nowrap >序号</td>
      <TD nowrap>打折票种</TD>
      <TD nowrap>开始时间</TD>
      <TD nowrap>截止时间</TD>
      <TD nowrap>折扣</TD>
      <TD nowrap>操作</TD>
    </tr>  
	<%
	    Enumeration e = Discoun.find(teasession._strCommunity," and psid = "+psid,0,Integer.MAX_VALUE);
		  if(!e.hasMoreElements())
	       {
	      		 out.print("<tr><td colspan=10 align=center>暂无打折信息</td></tr>");
	       }
	    for(int j = 1;e.hasMoreElements();j++)
	    {
	    	int did = ((Integer)e.nextElement()).intValue();
	    	Discoun dobj = Discoun.find(did);
	 %>
   <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td><%=j %></td>
	<td><%=Vote.find(dobj.getVoteid()).getVotename() %></td>
	<td><%=dobj.getTimekToString() %></td>
	<td><%=dobj.getTimejToString() %></td>
	<td><%=dobj.getDisprice() %></td>
	<td><a href="#" onclick="f_edit('<%=did %>');">编辑</a>&nbsp;<a href="#" onclick="f_delete('<%=did %>');">删除</a></td>
	</tr>
<%} %>
  </table>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td nowrap align="right">票种：</td>
      <TD nowrap>
		<select name="voteid">
 			<option value="0">--请选择票种--</option>
			<%
				Enumeration e1 = Vote.find(teasession._strCommunity,"",0,Integer.MAX_VALUE);
				while(e1.hasMoreElements())
				{
					int vid = ((Integer)e1.nextElement()).intValue();
					Vote vobjss = Vote.find(vid);
					out.print("<option value="+vid);
					if(discounobj.getVoteid()==vid)
					{
						out.print(" selected ");
					}
					out.print(">"+vobjss.getVotename());
					out.print("</option>");
				}
			 %>
        </select>
      </TD>
    </tr> 
    <tr>
      <td nowrap align="right">折扣设置：</td>
	  <td>
 			<select name="disprice">
 			<option value="0">--请选择折扣--</option>
			<%
				for(int i=1;i<Discoun.DISPRICE_TYPE.length;i++)
				{
					out.print("<option value="+Discoun.DISPRICE_TYPE[i]);
					if(discounobj.getDisprice()==Float.parseFloat(Discoun.DISPRICE_TYPE[i]))
					{
						out.print(" selected");
					}
					out.print(">"+Discoun.DISPRICE_TYPE[i]);
					out.print("</option>");
				}
			 %>
        </select>
      </td>
    </tr> 
  <tr>
      <td nowrap align="right" >开始时间：</td>
      <td ><%=new tea.htmlx.TimeSelection("timek",discounobj.getTimek(),true,true)%></td>
    </tr> 
  <tr>
      <td nowrap  align="right" >结束时间：</td>
      <td ><%=new tea.htmlx.TimeSelection("timej",discounobj.getTimej(),true,true)%></td>
    </tr> 

  </table>
  <br>
  <INPUT TYPE=SUBMIT NAME="GoBack"  ID="edit_GoFinish" class="edit_button" VALUE="添加折扣">&nbsp;
  <input type="button" value="关闭"  onClick="javascript:window.close();">

  </form>


  <div id="head6"><img height="6" src="about:blank"></div>


</body>
</html>

