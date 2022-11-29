<%@page contentType="text/html;charset=UTF-8"  %>
<%@page import="java.io.*" %>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.ui.*"%><%@page import="tea.db.*"%>
<%@page import="java.util.*"%>
<%@page import="tea.htmlx.*"%><%@page import="java.net.URLEncoder"%>

<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");


TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+request.getRequestURI()+"?"+request.getQueryString());
  return;
}

Resource r = new Resource("/tea/ui/node/talkback/Talkbacks");

String menuid=request.getParameter("id");
String q=request.getParameter("q");
int pos=0,size=15;
String tmp=request.getParameter("pos");
if(tmp!=null)
{
  pos=Integer.parseInt(tmp);
}
Community c=Community.find(teasession._strCommunity);
StringBuilder sql=new StringBuilder();
StringBuilder par=new StringBuilder();
sql.append(" AND node IN(SELECT node FROM Node WHERE path LIKE '/"+c.getNode()+"/%')");
par.append("?id=").append(menuid);
if(q!=null&&q.length()>0)
{
  sql.append(" AND content LIKE ").append(DbAdapter.cite("%"+q+"%"));
  par.append("&q=").append(java.net.URLEncoder.encode(q,"UTF-8"));
}
String subjectnode = teasession.getParameter("subjectnode");
if(subjectnode!=null && subjectnode.length()>0)
{
	subjectnode = subjectnode.trim();
	sql.append(" and node in (select node from NodeLayer where subject like "+DbAdapter.cite("%"+subjectnode+"%")+" )");
	 par.append("&subjectnode=").append(java.net.URLEncoder.encode(subjectnode,"UTF-8"));
}

//时间
String time_c = teasession.getParameter("time_c");
if(time_c!=null && time_c.length()>0)
{
  sql.append(" AND time >=").append(DbAdapter.cite(time_c+" 00:00"));
  par.append("&time_c=").append(time_c);
}

String time_d = teasession.getParameter("time_d");
if(time_d!=null && time_d.length()>0)
{
  sql.append(" AND time <=").append(DbAdapter.cite(time_d+" 23:59"));
  par.append("&time_d=").append(time_d);
}
String member = teasession.getParameter("member");
if(member!=null && member.length()>0)
{
	sql.append(" and rmember like ").append(DbAdapter.cite("%"+member+"%"));
	par.append("&member=").append(URLEncoder.encode(member,"UTF-8"));
}

int k = Talkback.count(sql.toString());
sql.append(" ORDER BY talkback DESC");
par.append("&pos=");
Enumeration e = Talkback.find(sql.toString(), pos, size);

//http://127.0.0.1/jsp/talkback/TalkbackLists.jsp?node=8973
%><html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script type="">
function f_act(act)
{
  if(submitCheckbox(form1.talkback,"<%=r.getString(teasession._nLanguage, "InvalidSelect")%>"))
  {
    form1.nexturl.value=location.pathname+location.search;
    form1.act.value=act;
    form1.submit();
  }
}
</script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage,"评论管理")%></h1>
<div id="head6"><img height="6" src="about:blank" alt=""></div>


<h2><%=r.getString(teasession._nLanguage, "查询")%></h2>
<form name="formgo" action="?" >
<input type="hidden" name="node" value="<%=teasession._nNode%>">
<input type="hidden" name="id" value="<%=menuid%>">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
  <td align="right">文章标题:</td><td><input type="text" name="subjectnode" value="<%if(subjectnode!=null)out.print(subjectnode);%>"/></td>
  <td align="right">评论内容:</td><td><input type="text" name="q" value="<%if(q!=null)out.print(q);%>"/></td>
 <td align="right">时间:</td><td>
 从&nbsp;
        <input id="time_c" name="time_c" size="7"  value="<%if(time_c!=null)out.print(time_c);%>"  style="cursor:pointer" readonly="readonly" onclick="new Calendar().show('formgo.time_c');">
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"  style="cursor:pointer" onclick="new Calendar().show('formgo.time_c');" />
        &nbsp;到&nbsp;
        <input id="time_d" name="time_d" size="7"  value="<%if(time_d!=null)out.print(time_d);%>"  style="cursor:pointer" readonly="readonly" onclick="new Calendar().show('formgo.time_d');" >
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"   style="cursor:pointer" onclick="new Calendar().show('formgo.time_d');" />

 </td>
 </tr>
 <tr>
  <td align="right">创建者:</td><td><input type="text" name="member" value="<%if(member!=null)out.print(member);%>"/></td>

  <td><input type="submit" value="<%=r.getString(teasession._nLanguage, "Submit")%>"/></td>
</tr>
</table>
</form>

<h2><%=r.getString(teasession._nLanguage, "列表")+" - "+k%></h2>
<form name="form1" action="/servlet/DeleteTalkback" >
<input type="hidden" name="node" value="<%=teasession._nNode%>">
<input type="hidden" name="nexturl" value="">
<input type="hidden" name="id" value="<%=menuid%>">
<input type="hidden" name="act" value="">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td width="1"><%out.println("<input type='checkbox' title='全选' style='cursor:pointer' onclick='selectAll(form1.talkback,this.checked)'>");//+r.getString(teasession._nLanguage, "SelectAll") %></td>
    <td id=subid><%=r.getString(teasession._nLanguage,"Subject")%></td>
    <td><%=r.getString(teasession._nLanguage,"文章标题")%></td>
     <td><%=r.getString(teasession._nLanguage,"评论内容")%></td>
    <td><%=r.getString(teasession._nLanguage,"Creator")%></td>
    <td><%=r.getString(teasession._nLanguage,"Time")%></td>
    <td><%=r.getString(teasession._nLanguage,"Revert")%></td>
  </tr>
<%
if(k<1)
{
  out.print("<tr><td colspan='5' align='center'>暂无记录</td></tr>");
}else
{
  for(int i=pos+1;e.hasMoreElements();i++)
  {
    int l = ((Integer)e.nextElement()).intValue();
    Talkback obj = Talkback.find(l);
    int nodeid=obj.getNode();
    RV rv = obj.getCreator();
    String subject=obj.getSubject(teasession._nLanguage);
    String creator=rv._strR;
    String trtext=obj.getContent(teasession._nLanguage);
    if (creator==null)creator="";

   	if(creator!=null && creator.length()==32)
   	{
   		creator = "游客";
   	}
    out.print("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''><td width=1>");
    out.print("<input  style='cursor:pointer' title='单击选择'  width=1 type=checkbox name=talkback value="+l+">");
    out.print("<td id=subid><span id=hintid><img src='/tea/image/hint/"+obj.getHint()+".gif'></span>"+obj.getAnchor(teasession._nLanguage));
    out.print("<td>"+Node.find(nodeid).getAnchor(teasession._nLanguage));
    out.print("<td>");
    if(trtext!=null && trtext.length()>0){
		trtext=Report.getHtml2(trtext);
		if(trtext.length()>25){
			out.print("<a href=\"/jsp/talkback/Talkback.jsp?node="+nodeid+"&talkback="+l+"\">"+trtext.replaceAll("&nbsp;","").substring(0,25)+"...</a>");
			//out.print("<textarea style=display:none id=content_"+l+" >"+trtext+"</textarea><a href=\"javascript:var obj=window.open('','','height=250,width=500,left=400,top=300,scrollbars=yes,toolbar=no,status=no,menubar=no,location=no,resizable=yes');obj.document.write(document.getElementById('content_"+l+"').value);\" >"+trtext.replaceAll("&nbsp;","").substring(0,25)+"...</a>");//&#39;
		}else{
			out.print(trtext);
		}
	}
    out.print("</td>");
    out.print("<td>"+creator);
    out.print("<td>"+obj.getTimeToString());
    out.print("<td><a href=\"/jsp/talkback/Talkback.jsp?node="+nodeid+"&talkback="+l+"\">"+TalkbackReply.countByTalkback(l)+"</a>");
  }
  out.println("<tr><td>");
  out.println("<input type='checkbox' title='全选' style='cursor:pointer' onclick='selectAll(form1.talkback,this.checked)'>");//+r.getString(teasession._nLanguage, "SelectAll")
  out.println("</td>");
  out.println("<td>");
  out.println("<input type='button' value="+r.getString(teasession._nLanguage, "Hide")+" onclick=f_act('hidden');>");
  out.println("<input type='button' value="+r.getString(teasession._nLanguage, "Show")+" onclick=f_act('show');>");
  out.println("<input type='button' value="+r.getString(teasession._nLanguage, "CBDelete")+" onclick=if(confirm('"+r.getString(teasession._nLanguage, "ConfirmDelete")+"')){f_act('delete');}>");
  out.println("<td colspan='5' align='right'>"+new tea.htmlx.FPNL(teasession._nLanguage,par.toString(),pos,k,size));
}
%>
</table>

</form>

<div id="head6"><img height="6" src="about:blank" alt=""></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>
