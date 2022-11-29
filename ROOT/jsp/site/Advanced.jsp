<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.io.*"%><%@page import="java.util.*"%><%@page import="tea.ui.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.db.*"%><%@page import="java.sql.SQLException"%>
<%@page import="tea.entity.site.*"%><%!

public static String getPath(DbAdapter db, int nNode) throws SQLException
{
  int nFather = 0;
  db.executeQuery("SELECT father FROM Node WHERE node=" + nNode);
  if (db.next())
  {
    nFather = db.getInt(1);
  }
  if (nFather == 0)
  {
    return "/" + nNode + "/";
  } else
  {
    return getPath(db, nFather) + nNode + "/";
  }
}
%><%

Http h=new Http(request,response);
TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
//h.member=teasession._rv.toString();

int menuid=h.getInt("menuid");
if("POST".equals(request.getMethod()))
{
  out.println("<script>var mt=parent.mt,doc=parent.document;</script>");

  for(int j = 0;j < 20;j++)
  out.write("// 显示进度条  \n");

  String sql="";
  int sum=Node.count(""),correct=0;
  DbAdapter db1 = new DbAdapter(),db2 = new DbAdapter();
  try
  {
    db1.executeQuery("SELECT node,path FROM Node ORDER BY node");
    for (int i=0;db1.next();i++)
    {
      int nid = db1.getInt(1);
      String path=getPath(db2, nid);
      if(!path.equals(db1.getString(2)))
      {
        correct++;
        sql="UPDATE Node SET path=" + DbAdapter.cite(path) + " WHERE node=" + nid;
        db2.executeUpdate(sql);
      }
      //进度
      if(i % 200 == 0)
      {
        out.print("<script>mt.progress(" + i + "," + sum + ",'进度：" + i+"/"+sum + "　编号：" + nid + "　纠正：" + correct + "');</script>");
        out.flush();
      }
    }
    out.print("<script>mt.show('操作执行成功！');</script>");
  } catch (Throwable ex)
  {
    out.print("<textarea id='ta'>"+sql+ ex.toString() + "</textarea><script>mt.show(document.getElementById('ta').value,1,'出现未知错误！');</script>");
    ex.printStackTrace();
  }finally
  {
    db1.close();
    db2.close();
  }
  Node._cache.clear();
  return;
}



%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>刷新路径</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/jsp/site/Advanced.jsp" method="post" target="_ajax" onsubmit="mt.show(null,0)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="act" />
<input type="hidden" name="id" value="<%=menuid%>"/>


<input type="submit" value="刷新路径"/>


</form>

<script>

</script>
</body>
</html>
