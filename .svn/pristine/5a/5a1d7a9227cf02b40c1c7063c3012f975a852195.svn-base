<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.cluster.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.entity.admin.*"%><%

Http h=new Http(request,response);
//if(h.member<1)
//{
//  response.sendRedirect("/servlet/StartLogin?community="+h.community);
//  return;
//}
int menuid=h.getInt("id");

if("POST".equals(request.getMethod()))
{
  out.println("<script>var mt=parent.mt;</script>");
  int opid=h.getInt("opid");
  String path=Node.find(opid).getPath();
  Enumeration e=Node.find(" AND path LIKE "+DbAdapter.cite(path+"_%")+" AND finished=2",0,Integer.MAX_VALUE);
  for(int i=0;e.hasMoreElements();i++)
  {
    int node=((Integer)e.nextElement()).intValue();
    ArrayList al=DML.find(" AND opid="+node+" AND content NOT LIKE 'DELETE FROM %' ORDER BY time,dml",0,Integer.MAX_VALUE);
    out.print("<script>mt.progress(" + i + "," + i + ",'1编号："+node+"　条数："+al.size()+"');</script>");
    out.flush();
    for(int j=0;j<al.size();j++)
    {
      DML t=(DML)al.get(j);
      DbAdapter db=new DbAdapter();
      try
      {
        db.executeUpdate(t.opid,t.content);
      }finally
      {
        db.close();
      }
      t.set("state","|");
    }
  }
  out.print("<script>mt.show('操作执行成功！');</script>");
  return;
}

%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1><%=AdminFunction.find(menuid).getName(h.language)%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form2" action="?" method="post" target="_ajax" onsubmit="mt.show(null,0)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <th>代码:</th><td><input name="opid" /></td>
  <td><input type="submit" value="提交"/></td>
</tr>
</table>
</form>

</body>
</html>
