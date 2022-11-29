<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.net.*" %>
<%@page import="java.util.*" %>
<%@page import="java.math.*" %>
<%@page import="tea.entity.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.ui.TeaSession" %>
<% request.setCharacterEncoding("UTF-8");
response.setHeader("Cache-Control", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
Profile p=Profile.find(teasession._rv._strR);

String member = teasession._rv._strR;
int folder=0;
if(teasession.getParameter("folder")!=null && teasession.getParameter("folder").length()>0){
	folder = Integer.parseInt(teasession.getParameter("folder"));
}

StringBuffer sql=new StringBuffer();
StringBuffer par=new StringBuffer();
par.append("?community=").append(teasession._strCommunity);
par.append("&id=").append(request.getParameter("id"));

sql.append(Message.sql(folder,p.getProfile()));
int newcount=Message.count(sql.toString()+" AND reader NOT LIKE " + DbAdapter.cite("%|" + p.getProfile() + "|%"));

int count = Message.count(sql.toString());

String o=request.getParameter("o");
if(o==null)
{
  o="time";
}
boolean a=Boolean.parseBoolean(request.getParameter("a"));
sql.append(" ORDER BY ").append(o).append(" ").append(a?"ASC":"DESC");
par.append("&o=").append(o).append("&a=").append(a);

int size = 10;
int pos=0;
String tmp=request.getParameter("pos");
if(tmp!=null)
{
  pos=Integer.parseInt(tmp);
  par.append("&pos=");
}



%>

<HTML>
<HEAD>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</HEAD>
<script>
function f_act(v)
{
	  if(!submitCheckbox(form1.messages,'请选中操作数据'))return;
  var bool=true;
  if(v=='Delete')
  {
    bool=confirm('您确定要删除选中数据吗?');
  }
  form1.action="/servlet/EditMessage";
  if(bool)
  {
	  form1.nexturl.value=location.pathname+location.search;
    form1.act.value=v;
    form1.submit();
  }
}
</script>
<body class="membercenter">
<table class="membertable" border="0" cellpadding="0" cellspacing="0">
<tr class="top"><td class="memberleft"></td><td class="membercenter2"></td><td class="memberright"></td></tr>
<tr class="middle"><td class="memberleft"></td><td class="membercenter2">
<h1><span><%out.print("收件箱");%></span></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<FORM name="form1" action="?">
<input type="hidden" name="community" VALUE="<%=teasession._strCommunity%>">
<input type="hidden" name="o" VALUE="<%=o%>">
<input type="hidden" name="nexturl">
<input type="hidden" name="a" VALUE="<%=a%>">
<input type="hidden" name="id" VALUE="<%=request.getParameter("id")%>">
<input type="hidden" name="act" VALUE="">
<input type="hidden" name="folder" VALUE="<%=folder%>">

<!--<h2>个人信箱列表&nbsp;(&nbsp;<%out.print(newcount+" / "+count); %>&nbsp;)</h2>-->


<table border="0" cellpadding="0" cellspacing="0" id="EmailOptions">
<tr>
	<td class="td01"><a href="?id=<%=request.getParameter("id") %>&folder=0">收件箱</a></td>
	<td class="td02"><a href="?id=<%=request.getParameter("id") %>&folder=1">发件箱</a></td>
	<td class="td03"><a href="/jsp/message/EditMemberMailbox.jsp?nexturl=/jsp/message/MemberMailbox.jsp?folder=<%=folder %>">新建信息</a></td>
</tr>
</table>


<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	<tr ID=tabletwotr>
    <td colspan="6"><input name='multi' type=BUTTON VALUE=删除 ID=CBTrash onClick=f_act('Delete');></td></tr>
    <tr>
	   <td nowrap>序号</td>
       <td nowrap><input type=checkbox onClick="selectAll(form1.elements,this.checked);"></td>
		<td><%
			if(folder==0)out.print("发件人");
			else if(folder==1)out.print("收件人");
		%></td>
		<td>主题</td>
		<td>时间</td>
		<%if(folder==0){ %><td>操作</td><%} %>
	</tr>

	<%


	 ArrayList al  = Message.find(sql.toString(), pos, size);
	  int index=pos+1;
	  if(al.size()==0)
	   {
	       out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
	   }
	for(int i=0;i<al.size();i++)
	  {
	    int id =((Integer)al.get(i)).intValue();

	    Message obj = Message.find(id);
	%>
	 <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
	 	 <td width=20 id=sequence><%=index %></td>
     	<td width=1 id=checkbox><input type='checkbox' name='messages' value="<%=id %>"></td>
	 	<td><%
	 	if(folder==0)
        {
	 		out.print(obj.getFrName(teasession._nLanguage));
	 	}else if(folder==1)
        {
          out.print(obj.getToName(teasession._nLanguage));
	 	}
	 	%></td>
	 	<td><%
	 	out.print("<a href=/jsp/message/MemberMailboxShow.jsp?folder="+folder+"&message="+id+" >");
	 	 if(!obj.isReader(p.getProfile()))//是否已读///
        {
          out.print("<b>"+obj.subject.replaceAll("允许你的节点请求: ", "")+"</b> &nbsp; <img src=/tea/image/public/new.gif>");
        }else
        {
          out.print("&nbsp;"+obj.subject.replaceAll( "允许你的节点请求: ", ""));
        }
	 	 out.print("</a>");
	 	%></td>
	 	<td><%=MT.f(obj.time,1)%></td>
	 		<td>
	 		<%
	 	out.print("<a href=/jsp/message/MemberMailboxShow.jsp?folder="+folder+"&message="+id+" >");
	 	 if(!obj.isReader(p.getProfile()))//是否已读///
        {
          out.print("<b>阅读</b>");
        }else
        {
          out.print("&nbsp;阅读");
        }
	 	 out.print("</a>");
	 	%>
	 	<%if(folder==0){ %>
	 <a href="/jsp/message/EditMemberMailbox.jsp?message=<%=id %>&act=re&to=<%=URLEncoder.encode(Profile.find(member).getMember(),"UTF-8") %>&nexturl=/jsp/message/MemberMailbox.jsp?folder=<%=folder %>">回复</a>
	 	<%} %>
	 	</td>
	 </tr>
<%index++;}
	  if(count>size)
	  {
	     out.print("<tr><td colspan=6 align=center>"+new tea.htmlx.FPNL(teasession._nLanguage,par.toString().replace("&pos=","&")+"&o="+o+"&a="+a+"&pos=",pos,count,size)+"</td></tr>");
	  }
	  %>

</table>

</FORM>

</td><td class="memberright"></td></tr>
<tr class="bottom"><td class="memberleft"></td><td class="membercenter2"></td><td class="memberright"></td></tr>

</table>
</body>
</HTML>
