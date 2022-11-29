<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.community.*"%><%

Http h=new Http(request,response);


StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
par.append("&community="+h.community);

String medal="|";
String member=h.get("member");
String act=h.get("act");

if("medal".equals(act))
{
  Profile p=Profile.find(member);
  medal=p.getMedal();
  if(medal==null)medal="|";
}

%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<style>
.sel{background:#FFFFCA}
</style>
</head>
<body>

<form name="form2" action="/Members.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="member" value="<%=member%>"/>
<input type="hidden" name="act" value="<%=act%>"/>

<%
Iterator it=Medal.find(sql.toString(),0,200).iterator();
if(!it.hasNext())
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
else
for(int i=1;it.hasNext();i++)
{
  Medal t=(Medal)it.next();
  boolean isSel=medal.indexOf("|"+t.medal+"|")!=-1;
%>
  <span class="<%=isSel?"sel":""%>" onMouseOver="style.background='#FFFFCA'" onMouseOut="if(className)return;style.background=''" style="margin:2px;border:1px solid #CCCCCC;width:100px;height:70px;overflow:hidden">
  <img src="<%=MT.f(t.picture)%>" onload="if(height>50)height=50;"><br><input type="checkbox" name="medals" onclick="parentNode.className=checked?'sel':'';" value="<%=t.medal%>" <%=isSel?" checked":""%> id="_m<%=t.medal%>" /><label for="_m<%=t.medal%>"><%=MT.f(t.name)%></label>
  </span>
<%
}
%>

<br/>
<input type="button" value="确定" onclick="form2.submit();"/>
<input type="button" value="关闭" onclick="parent.mt.close()"/>
</form>

<script>
//form2.nexturl.value=location.pathname+location.search;
function f_act(a,id,b)
{
  form2.submit();
}
</script>
</body>
</html>
