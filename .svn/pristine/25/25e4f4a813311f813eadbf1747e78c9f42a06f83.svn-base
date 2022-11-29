<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.io.*" %><%@page import="tea.db.*" %><%@page import="java.net.*" %><%@page import="java.util.*" %><%@page import="java.util.regex.*" %>
<%@page import="tea.entity.site.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.ui.*" %>
<%
request.setCharacterEncoding("UTF-8");


TeaSession teasession=new TeaSession(request);

if("POST".equals(request.getMethod()))
{
  out.print("<span id='p'>准备导入中....</span><script>var p=document.getElementById('p');function f(s){p.innerHTML=s;}</script>");
  out.flush();
  String sql=request.getParameter("sql");
  Node r=Node.find(Integer.parseInt(request.getParameter("father")));
  if(r.getType()!=1)
  {
    out.print("错误!! NODE号不正确.");
    return;
  }
  int suma=0,sumr=0;
  DbAdapter db5=new DbAdapter(5);
  DbAdapter db=new DbAdapter();
  try
  {
    db5.executeQuery(sql);
    for(int i=0;db5.next();i++)
    {
      int newid=db5.getInt(1);
      String title=db5.getString(2);
      String text=db5.getString(3);
      String pic=db5.getString(6);
      if(pic!=null&&pic.length()>0)
      {
        int j=pic.indexOf('|');
        if(j!=-1)pic=pic.substring(0,j);
        pic="/uppic/"+pic;
      }
      Date time=db5.getDate(9);//infotime
      int hits=db5.getInt(10);
      String key=db5.getString(17);
      key=key==null?"":key.replace('|',' ');
      System.out.println(newid+":"+title);
      if(i%10==0)
      {
        out.print("<script>f(\""+i+" "+title+"\");</script>");
        out.flush();
      }
      //
      int nid;
      Enumeration e=Node.find(" AND syncid="+DbAdapter.cite("news."+newid),0,1);
      //.find(" AND time="+DbAdapter.cite(time)+" AND community="+DbAdapter.cite(r.getCommunity())+" AND type=39 AND node IN(SELECT node FROM NodeLayer nl WHERE n.node=nl.node AND nl.subject="+db.cite(title)+")",0,1);
      if(e.hasMoreElements())
      {
        nid=((Integer)e.nextElement()).intValue();
        Node n=Node.find(nid);
        //n.set(teasession._nLanguage,title,text);
        n.move(r._nNode,false);
        sumr++;
      }else
      {
        nid=Node.create(r._nNode,0,r.getCommunity(),r.getCreator(),39,false,r.getOptions(),r.getOptions1(),1,null,null,time,0,0,0,0,"","news."+newid,1,title,key,text,pic,"",0,"","","","","","","");
        r.finished(nid);
        Report.create(nid,0,0,time,1,"","","","","","");
        suma++;
      }
      db.executeUpdate("UPDATE node SET click="+hits+" WHERE node="+nid);
    }
  }finally
  {
    db5.close();
    db.close();
  }
  out.print("<script>alert('导入完成! 添加:"+suma+",替换:"+sumr+".');history.back();</script>");
  return;
}

%>
<html>
<head>
<title>导入</title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>

<body>
<h1>导入</h1>

<form name="form1" action="?" method="post" onsubmit="return submitText(this.sql,'无效-SQL')&&submitText(this.father,'无效-节点');">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="id" value="<%=request.getParameter("id")%>"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>SQL</td>
    <td><textarea name="sql" cols="50"></textarea></td>
    </tr>
  <tr>
    <td>节点</td>
    <td>
      <input type="text" name="father" value=""/>
      <select onchange="form1.father.value=value;">
    <option value="">------------</option>
    <%
    java.util.Enumeration e=Node.find(" AND n.path LIKE '/" + Community.find(teasession._strCommunity).getNode() + "/%' AND node IN(SELECT node FROM Category WHERE category=39)",0,Integer.MAX_VALUE);
    while(e.hasMoreElements())
    {
      int nid=((Integer)e.nextElement()).intValue();
      Node n=Node.find(nid);
      out.print("<option value="+nid+">"+n.getSubject(teasession._nLanguage));
    }
    %>
    </select>
    </td>
    </tr>
  <tr>
    <td>&nbsp;</td>
    <td><input type="submit" value="导入" /></td>
    </tr>
</table>


</form>
</body>
</html>
