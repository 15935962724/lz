<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.node.*"%><%@page import="tea.entity.custom.mzb.*"%><%@page import="java.io.*"%><%@page import="tea.entity.*"%><%@page import="java.util.regex.*"%><%@page import="java.awt.image.*"%><%@page import="java.awt.color.*"%><%@page import="java.util.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.ui.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.site.*"%><%@page import="tea.entity.member.*"%><%

//http://www.mzzjw.cn/zgmzb/html/2001-06/05/node_2.htm
//

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}


CommunityOption co=CommunityOption.find(h.community);
String path=co.get("e-news.path");
int node=co.getInt("e-news.node");

if("POST".equals(request.getMethod()))
{
  for(int j=0;j<20;j++)out.write("// 显示进度条  \n");
  out.print("<script>var mt=parent.mt,$=parent.$;</script>");
  E_News t=new E_News(h.community);
  String act=h.get("act");
  if("index".equals(act))
  {
    t.index(out);
  }else
  {
    node=h.node;
    path=h.get("path");
    File dir=new File(path);
    if(!dir.exists())
    {
      out.print("<script>mt.show('“路径”不存在！');</script>");
      return;
    }
    co.set("e-news.path",path);
    co.set("e-news.node",String.valueOf(node));
    out.print("<script>var s=$('dialog_content');</script>");
    t.imp(out);
  }
  out.print("<script>mt.show('操作完成！',1,'location.reload()');</script>");
  return;
}

File dir=new File(application.getRealPath("/res/"+h.community+"/searchindex/e_news"));

String tmp=h.get("id");
int menu=tmp==null?0:Integer.parseInt(tmp);

int root=Community.find(h.community).getNode();


%><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>

<body>
<h1>导入电子报</h1>
<div id="head6"><img height="6" src="about:blank" alt=""></div>

<form action="?" method="post" target="_ajax" onsubmit="return mt.check(this)&&mt.show(null,0)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menu%>"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>电子报纸的发布路径:</td>
    <td><input name="path" type="text" size="50" value="<%if(path!=null)out.print(path);%>" alt="路径" /></td>
  </tr>
  <tr>
    <td>复制到那个页面:</td>
    <td>
      <select name="node" alt="节点">
      <option value="">-------------------</option>
      <%
Enumeration e=Node.find(" AND path LIKE '/"+root+"/%' AND type=0",0,200);
while(e.hasMoreElements())
{
  int id=((Integer)e.nextElement()).intValue();
  Node n=Node.find(id);
  out.print("<option value="+id);
  if(node==id)out.print(" selected='true'");
  out.print(">"+n.getSubject(h.language));
}
      %>
      </select>
    </td>
  </tr>
</table>

<input type="submit" value="提交">
</form>

<form name="form1" action="?" method="post" target="_ajax" onsubmit="mt.show('提交中，请稍等。。。',0)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menu%>"/>
<input type="hidden" name="act" value="index"/>
<table id="tablecenter">
  <tr>
    <td>索引大小：</td>
    <td><%=MT.f(Filex.size(dir)/1024)%>K</td>
  </tr>
  <tr>
    <td>索引日期：</td>
    <td><%=MT.f(new Date(new File(dir,"segments.gen").lastModified()),1)%></td>
  </tr>
</table>

<br/>
<%
if(new File(dir,"write.lock").exists())
  out.print("索引在正生成中...<img src='/tea/mt/progress.gif'/><meta http-equiv='refresh' content='5' />");
else
  out.print("<input type='submit' value='更新索引' />");
%>
</form>

</body>
</html>
