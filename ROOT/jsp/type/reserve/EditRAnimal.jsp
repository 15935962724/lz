<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.node.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node);
  return;
}

int node=h.getInt("node");
Node n=Node.find(node);

Animal t=null;
String subject=null,content=null;
if(n.getType()==1)
{
  t=new Animal(0);
}else
{
  subject=n.getSubject(h.language);
  content=n.getText(h.language);

  t=Animal.find(h.node);
}


%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>添加/编辑——动物</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/Animals.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="node" value="<%=node%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl","")%>"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td class="th">保护区：</td>
    <td><select name="reserve"><option value="0">--</option><%
    Enumeration e=Node.find(" AND type=102",0,Integer.MAX_VALUE);
    while(e.hasMoreElements())
    {
      int nid=((Integer)e.nextElement()).intValue();
      out.print("<option value="+nid);
      if(nid==t.reserve)out.print(" selected");
      out.print(">"+Node.find(nid).getSubject(h.language));
    }
    %></select></td>
  </tr>
  <tr>
    <td class="th">物种代码：</td>
    <td><input name="code" value="<%=MT.f(t.code)%>"/></td>
  </tr>
  <tr>
    <td class="th">属名：</td>
    <td><input name="genus" value="<%=MT.f(t.genus)%>"/></td>
  </tr>
  <tr>
    <td class="th">种名(英)：</td>
    <td><input name="species0" value="<%=MT.f(t.species[0])%>"/></td>
  </tr>
  <tr>
    <td class="th">种名(中)：</td>
    <td><input name="species1" value="<%=MT.f(t.species[1])%>"/></td>
  </tr>
  <tr>
    <td class="th">科名(英)：</td>
    <td><input name="family0" value="<%=MT.f(t.family[0])%>"/></td>
  </tr>
  <tr>
    <td class="th">科名(中)：</td>
    <td><input name="family1" value="<%=MT.f(t.family[1])%>"/></td>
  </tr>
  <tr>
    <td class="th">目名(英)：</td>
    <td><input name="order0" value="<%=MT.f(t.order[0])%>"/></td>
  </tr>
  <tr>
    <td class="th">目名(中)：</td>
    <td><input name="order1" value="<%=MT.f(t.order[1])%>"/></td>
  </tr>
  <tr>
    <td class="th">国家重点保护野生动物等级：</td>
    <td><input name="alevel" value="<%=MT.f(t.alevel)%>"/></td>
  </tr>
  <tr>
    <td class="th">中国动物CITES公约名录等级：</td>
    <td><input name="cites" value="<%=MT.f(t.cites)%>"/></td>
  </tr>
  <tr>
    <td class="th">红色名录等级：</td>
    <td><input name="rlevel" value="<%=MT.f(t.rlevel)%>"/></td>
  </tr>
  <tr>
    <td class="th">picture</td>
    <td><input type="file" name="picture" value="<%=MT.f(t.picture)%>"/></td>
  </tr>
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onclick="history.back();"/>
</form>

<script>mt.focus();</script>
</body>
</html>
