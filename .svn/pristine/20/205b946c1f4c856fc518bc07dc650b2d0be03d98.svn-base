<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.*" %><%@page import="tea.resource.*" %><%@page import="java.util.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.ui.*" %><%@page import="tea.db.DbAdapter" %><% request.setCharacterEncoding("UTF-8");

Http h=new Http(request);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

Resource r=new Resource();

String _strId=request.getParameter("id");

StringBuffer sql=new StringBuffer(),par=new StringBuffer();

sql.append(" AND type=73 AND finished=1 AND community="+DbAdapter.cite(h.community));
par.append("?id="+_strId);
par.append("&node="+h.node);
par.append("&community="+h.community);

int father=h.getInt("father");
int father2=h.getInt("father2");
if(father>0)
{
  sql.append(" AND father="+father);
  par.append("&father="+father);
}else
{
  if(father2>0)
  {
    sql.append(" AND father="+father2);
    par.append("&father2="+father2);
  }
}

Date from=h.getDate("from");
if(from!=null)
{
  sql.append(" AND time>="+DbAdapter.cite(from));
  par.append("&from="+MT.f(from));
}

Date to=h.getDate("to");
if(to!=null)
{
  sql.append(" AND time<"+DbAdapter.cite(to));
  par.append("&to="+MT.f(to));
}

String q=h.get("q","");
if(q.length()>0)
{
  sql.append(" AND node IN (SELECT node FROM NodeLayer WHERE subject LIKE "+DbAdapter.cite("%"+q+"%")+")");
  par.append("&q="+Http.enc(q));
}

par.append("&pos=");
int pos=h.getInt("pos"),size=20;

int sum=Node.count(sql.toString());

sql.append(" ORDER BY node DESC");


%>
<!--
参数:
father: 父节点
-->
<html>
<head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body id="bodynone">
<h1>留言板管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>


<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>" />
<input type="hidden" name="id" value="<%=_strId%>" />

<table cellspacing="0" cellpadding="0"  id="tablecenter">
<tr>
<!-- 版面: -->
<%
if(father<1)
{
  out.print("<td><SELECT NAME=father2 ><OPTION SELECTED VALUE=''>-----------------------</OPTION>");
  DbAdapter db=new DbAdapter();
  try
  {
    db.executeQuery("SELECT n.node FROM Node n INNER JOIN Category c ON n.node=c.node  WHERE n.community="+db.cite(h.community)+" AND n.type=1 AND c.category=73");
    while(db.next())
    {
      int id=db.getInt(1);
      out.print("<option value="+id);
      if(father2==id)
      out.print(" SELECTED ");
      out.print(">"+Node.find(id).getSubject(h.language));
    }
  }finally
  {
    db.close();
  }
  out.print("</SELECT></td>");
}
%>
  <td class="th">主题：</td><td><input name="q" value="<%=MT.f(q)%>"></td>
  <td class="th">时间：</td><td><input name="from" value="<%=MT.f(from)%>" readonly class="date" onclick="mt.date(this)">-<input readonly name="to"  value="<%=MT.f(to)%>" class="date" onclick="mt.date(this)"></td>
  <td><input type="submit" value="查询"></td>
</tr>
</table>
</form>
<br>

<h2>列表 ( <%=sum%> )</h2>
<form name="form2" method="post">
<input type="hidden" name="operate" value="delByCb"/>
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="node"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr id=tableonetr>
  <td width="1"><input type="checkbox" onclick="mt.select(form2.cb,checked)" /></td>
  <td nowrap>序号</td>
  <td nowrap>主题</td>
  <td nowrap>内容</td>
  <td nowrap>回复数</td>
  <td nowrap>时间</td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Enumeration e=Node.find(sql.toString(),pos,size);
  for(int i=pos+1;e.hasMoreElements();i++)
  {
    int id=((Integer)e.nextElement()).intValue();
    Node n=Node.find(id);
    int reply_count=MessageBoardReply.count(id,h.language);
    String subject=n.getSubject(h.language);
    out.print("<tr>");
    out.print("<td width=1><input name='cb' type='checkbox' value="+id+" ></td>");
    out.print("<td>"+i+"</td>");
    out.print("<td><a href='/html/"+h.community+"/messageboard/"+id+"-"+h.language+".htm' target='_blank'>"+MT.red(subject,q)+"</a>");
    if ((System.currentTimeMillis() - n.getTime().getTime() - 1000 * 60 * 60 * 24L) < 0 ||  (reply_count > 0 && (System.currentTimeMillis() - MessageBoardReply.find(MessageBoardReply.findLast(n._nNode, h.language)).getTime().getTime() - 1000 * 60 * 60 * 24L) < 0))
    out.print("<img src=/tea/image/public/new.gif>");
    out.print("<td>&nbsp;");
    String log_content=n.getText(h.language);
    if(log_content!=null)
    {
      log_content=Report.getHtml2(log_content);//log_content.replaceAll("<","&lt;");  log_content.replaceAll("\r\n","<br/>").replaceAll(" ","&nbsp;")
      if(log_content!=null && log_content.length()>25)
      {
        out.print("<textarea style=display:none id=content_"+id+" ><!---->"+log_content+"</textarea><a href=### onclick=mt.show(document.getElementById('content_"+id+"').value,1,'留言内容',400)>"+log_content.replaceAll("&nbsp;","").substring(0,25)+"...</a>");//&#39;
      }else
      {
        out.print(log_content);
      }
    }
    out.println("<td>"+reply_count+"</td>");
    out.println("<td nowrap>"+Node.sdf2.format(n.getTime())+"</td>");
    out.println("<td nowrap><a href=javascript:mt.act('reply',"+id+") >"+r.getString(h.language,"回复管理")+"</a>");
    if(n.isHidden())
    {
      out.println("<a href='###' onClick=\"window.open('/servlet/GrantNodeRequests?Grant=true&community="+h.community+"&node="+n.getFather()+"&Grant=ON&nodes="+id+"&nexturl='+encodeURIComponent(form2.nexturl.value),'_self');\">"+r.getString(h.language,"Grant")+"</a>");
    }
    //        else
    //        out.println("<input type=button NAME=Deny value="+r.getString(h.language,"Deny")+" onClick=\"window.open('/servlet/GrantNodeRequests?community="+h.community+"&node="+n.getFather()+"&Deny=ON&noderequests="+id+"&nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8")+"');\">");
    out.println("<a href='###' onClick=\"if(confirm('"+r.getString(h.language,"ConfirmDelete")+"')){window.open('/servlet/DeleteNode?community="+h.community+"&node="+id+"&nexturl='+encodeURIComponent(form2.nexturl.value),'_self'); this.disabled=true;}\">"+r.getString(h.language,"CBDelete")+"</a>");
  }
  if(sum>size)out.print("<tr><td colspan='50'>"+new tea.htmlx.FPNL(h.language,par.toString(),pos,sum,size));
}
%>
</table>
<input type='button' name='multi' value='批量删除' onClick="mt.act('del')" >
</form>



<script>
form2.nexturl.value=location.pathname+location.search;
mt.disabled(form2.cb);
mt.act=function(a,id)
{
  form2.node.value=id;
  if(a=='del')
  {
    mt.show('<%=r.getString(h.language,"您确定删除吗？")%>',2,"form2.action='/servlet/DeleteNode';form2.submit();");
  }else if(a=='reply')
  {
    form2.action='/jsp/type/messageboard/MessageBoardReplyManage.jsp';
    form2.method='';
    form2.submit();
  }
};
</script>

<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
