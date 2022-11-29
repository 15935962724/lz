<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.resource.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.ui.*" %><%@page import="tea.db.DbAdapter" %><% request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

Resource r=new Resource();

String _strId=request.getParameter("id");

StringBuffer sql=new StringBuffer();
StringBuffer param=new StringBuffer();
param.append("?id=").append(_strId);
param.append("&node=").append(teasession._nNode);
param.append("&community=").append(teasession._strCommunity);

int father=0;
int bbs=0;
String _strBbs=request.getParameter("bbs");
if(_strBbs!=null&&_strBbs.length()>0)
{
  father=bbs=Integer.parseInt(_strBbs);
}else
{
  String _strFather=request.getParameter("father");
  if(_strFather!=null&&_strFather.length()>0)
  {
    father=Integer.parseInt(_strFather);
  }
}
if(father>0)
{
  sql.append(" AND father=").append(father);
  param.append("&father=").append(father);
}

String from=request.getParameter("from");
if(from!=null&&from.length()>0)
{
  sql.append(" AND time>="+DbAdapter.cite(from));
  param.append("&from="+from);
}

String to=request.getParameter("to");
if(to!=null&&to.length()>0)
{
  sql.append(" AND time<"+DbAdapter.cite(to));
  param.append("&to="+to);
}

String subject=request.getParameter("subject");
if(subject!=null&&(subject=subject.trim()).length()>0)
{
  sql.append(" AND node IN (SELECT node FROM NodeLayer WHERE subject LIKE "+DbAdapter.cite("%"+subject+"%")+")");
  param.append("&subject="+java.net.URLEncoder.encode(subject,"UTF-8"));
}
param.append("&pos=");

int pos=0;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}

String nexturl=request.getRequestURI()+"?"+request.getQueryString();

%>
<html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1>留言板管理</h1>
    <div id="head6"><img height="6" src="about:blank"></div>
   <br>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>" />
<input type="hidden" name="id" value="<%=_strId%>" />

<table cellspacing="0" cellpadding="0"  id="tablecenter">
<tr>
<!-- 版面: -->
<%
if(bbs==0)
{
  out.print("<td><SELECT NAME=father ><OPTION SELECTED VALUE=\"\">————————</OPTION>");
  DbAdapter db=new DbAdapter();
  try
  {
    db.executeQuery("SELECT n.node FROM Node n INNER JOIN Category c ON n.node=c.node  WHERE n.community="+db.cite(teasession._strCommunity)+" AND n.type=1 AND c.category=73");
    while(db.next())
    {
      int id=db.getInt(1);
      out.print("<option value="+id);
      if(father==id)
      out.print(" SELECTED ");
      out.print(">"+Node.find(id).getSubject(teasession._nLanguage));
    }
  }finally
  {
    db.close();
  }
  out.print("</SELECT></td>");
}
%>
<td>
  FROM:
  <input type="text" name="from" value="<%if(from!=null)out.print(from);%>" readonly size="9">
  <input onclick="showCalendar('form1.from')" type="button" value="...">
</td><td>
  TO:
  <input readonly name="to"  value="<%if(to!=null)out.print(to);%>" type="text" size="9">
  <input  onclick="showCalendar('form1.to')" type="button" value="...">
  </td><td>
  主题:<input name="subject"  value="<%if(subject!=null)out.print(subject);%>" type="text" size="10">
  </td><td>
  <input type="submit" value="GO">
</td></tr></table>
</form>
<br>

<h2>列表(<span id="count">0</span>)</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr ID=tableonetr>
<td width="1">&nbsp;</td>
    <td nowrap>主题</td>
    <td nowrap>内容</td>
    <td nowrap>回复数</td>
    <td nowrap>时间</td>
    <td></td>
  </tr>
  <%
  int count=0;
  DbAdapter db=new DbAdapter();
  try
  {
    count=db.getInt("SELECT COUNT(node) FROM Node WHERE type=73 AND community="+DbAdapter.cite(teasession._strCommunity)+sql.toString());
    db.executeQuery("SELECT node FROM Node WHERE type=73 AND community="+DbAdapter.cite(teasession._strCommunity)+sql.toString()+" ORDER BY node DESC");
    for (int l = 0; l < pos + 25 && db.next(); l++)
    {
      if (l >= pos)
      {
        int id=db.getInt(1);
        Node n=Node.find(id);
        int reply_count=MessageBoardReply.count(id,teasession._nLanguage);
        out.print("<tr onmouseover=\"javascript:this.bgColor='#BCD1E9';\" onMouseOut=\"javascript:this.bgColor='';\" >");
        out.print("<td width=1>"+(1+l)+"</td>");
        out.print("<td>");//<input name=nodes type=checkbox value="+id+" >
        if(n.isHidden())
        out.print("<STRIKE>");
        out.print("<a href=/servlet/Node?node="+id+"&Language="+teasession._nLanguage+" target=_blank >"+n.getSubject(teasession._nLanguage));

        if ((System.currentTimeMillis() - n.getTime().getTime() - 1000 * 60 * 60 * 24L) < 0 ||
                    (reply_count > 0 && (System.currentTimeMillis() - MessageBoardReply.find(MessageBoardReply.findLast(n._nNode, teasession._nLanguage)).getTime().getTime() - 1000 * 60 * 60 * 24L) < 0))
        out.print("<img src=/tea/image/public/new.gif >");
        out.print("</a></STRIKE></td>");
        out.print("<td>&nbsp;");
        String log_content=n.getText(teasession._nLanguage);
        if(log_content!=null)
        {
	        log_content=log_content.replaceAll("<","&lt;");
	        if(log_content.length()>25)
	        out.print("<textarea style=display:none id=content_"+id+" >"+log_content.replaceAll("\r\n","<br/>").replaceAll(" ","&nbsp;")+"</textarea><a href=\"javascript:var obj=window.open('','','height=250,width=500,left=400,top=300,scrollbars=yes,toolbar=no,status=no,menubar=no,location=no,resizable=yes');obj.document.write(document.getElementById('content_"+id+"').value);\" >"+log_content.substring(0,25)+"...</a>");//&#39;
	        else
	        out.print(log_content);
        }
        out.print("</td>");
        out.println("<td>"+reply_count+"</td>");
        out.println("<td nowrap>"+n.getTimeToString()+"</td>");
        out.println("<td nowrap><input type=button value="+r.getString(teasession._nLanguage,"回复管理")+" onClick=\"window.open('/jsp/type/messageboard/MessageBoardReplyManage.jsp?community="+teasession._strCommunity+"&node="+id+"&nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8")+"');\">");
        if(n.isHidden())
        out.println("<input type=button NAME=Grant value="+r.getString(teasession._nLanguage,"Grant")+" onClick=\"window.open('/servlet/GrantNodeRequests?community="+teasession._strCommunity+"&node="+n.getFather()+"&Grant=ON&noderequests="+id+"&nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8")+"','_self');\">");
//        else
//        out.println("<input type=button NAME=Deny value="+r.getString(teasession._nLanguage,"Deny")+" onClick=\"window.open('/servlet/GrantNodeRequests?community="+teasession._strCommunity+"&node="+n.getFather()+"&Deny=ON&noderequests="+id+"&nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8")+"');\">");
        out.println("<input type=button value="+r.getString(teasession._nLanguage,"CBDelete")+" onClick=\"if(confirm('"+r.getString(teasession._nLanguage,"ConfirmDelete")+"')){window.open('/servlet/DeleteNode?community="+teasession._strCommunity+"&node="+id+"&nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8")+"','_self'); this.disabled=true;}\"></td></tr>");
      }
    }
  }finally
  {
    db.close();
  }
  out.print("<script>document.getElementById('count').innerHTML='"+count+"';</script>");
  %>
<tr><!--td colspan="3"><input type="checkbox" onclick="if(form2.nodes){form2.nodes.checked=this.checked;for(var i=form2.nodes.length;i>0;i--)form2.nodes[i-1].checked=this.checked; }" /><%=r.getString(teasession._nLanguage,"全选")%></td --><td colspan="5" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,param.toString(),pos,count)%></td></tr>
</table>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>

