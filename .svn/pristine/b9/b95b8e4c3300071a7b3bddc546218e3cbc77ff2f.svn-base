<%@page contentType="text/html;charset=UTF-8" %><%@page import="jxl.*" %><%@page import="jxl.write.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.entity.admin.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.db.DbAdapter" %><%@page import="tea.resource.Resource" %><%@page import="java.util.*" %><%@page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=teasession._strCommunity;
String strid=request.getParameter("id");

Resource r=new Resource("/tea/resource/Dynamic");

int dynamic=Integer.parseInt(request.getParameter("dynamic"));
boolean isExpall=request.getParameter("expall")!=null;//导出所有项//////
boolean isExp=request.getParameter("exp")!=null;//导出Excel////////////

//先把列放到数组中,以备后面的循环
ArrayList al=new ArrayList();
String tmp=" AND dynamic="+dynamic;
if(!isExpall||!isExp)
{
  tmp=" AND need=1";
}
Enumeration e=DynamicType.findByDynamic(dynamic,tmp,0,Integer.MAX_VALUE);
while(e.hasMoreElements())
{
  al.add(e.nextElement());
}


WritableWorkbook wwb=null;
WritableSheet ws=null;
if(isExp)
{
  response.setContentType("application/x-msdownload");
  response.setHeader("Content-Disposition", "attachment; filename=exp.xls");
  wwb=Workbook.createWorkbook(response.getOutputStream());
  ws=wwb.createSheet("Sheet1",1);
}

StringBuffer sql=new StringBuffer();
sql.append(" AND community=").append(DbAdapter.cite(community));
sql.append(" AND type=").append(dynamic);

//权限///
AdminUsrRole aur=AdminUsrRole.find(community,teasession._rv._strV);
String rs[]=aur.getRole().split("/");
String us[]=aur.getClasses().split("/");
int unit=aur.getUnit();
sql.append(" AND ( node NOT IN ( SELECT node FROM DynamicSafety ) OR node IN ( SELECT node FROM DynamicSafety WHERE");
sql.append(" unit LIKE ").append(DbAdapter.cite("%/"+unit+"/%"));
for(int i=1;i<rs.length;i++)
{
  sql.append(" OR role LIKE ").append(DbAdapter.cite("%/"+rs[i]+"/%"));
}
for(int i=1;i<us.length;i++)
{
  sql.append(" OR unit LIKE ").append(DbAdapter.cite("%/"+us[i]+"/%"));
}
sql.append("))");

StringBuffer param=new StringBuffer();
param.append("?community=").append(community);
param.append("&dynamic=").append(dynamic);
param.append("&id=").append(strid);

StringBuffer search=new StringBuffer();
StringBuffer title=new StringBuffer();

for(int i=0;i<al.size();i++)
{
  int id=((Integer)al.get(i)).intValue();
  DynamicType obj=DynamicType.find(id);

  String vlaue=request.getParameter("dynamictype"+id);
  search.append("<SPAN ID=search"+id+">"+obj.getName(teasession._nLanguage));
  if("radio".equals(obj.getType())||"select".equals(obj.getType()))
  {
    search.append(obj.getText(teasession));
    //如果默认值是5的话,将会有两个下接菜单.
    String dt2=request.getParameter("dt2"+id);
    if(dt2!=null)
    {
      param.append("&dt2").append(id).append("=").append(dt2);
      search.append("<script>form1.dt2"+id+".value=\"").append(dt2).append("\";</script>");
    }
  }else if("date".equals(obj.getType()))
  {
    String start=request.getParameter("start"+id);
    String end=request.getParameter("end"+id);
    //开始时间//////
    search.append("<input name=start"+id);
    if(start!=null&&start.length()>0)
    {
      sql.append(" AND node IN ( SELECT DISTINCT node FROM DynamicValue WHERE dynamictype=").append(id).append(" AND value>=").append(DbAdapter.cite(start)).append(" ) ");
      param.append("&start").append(id).append("=").append(start);
      search.append(" value=").append(start);
    }
    search.append(" readonly size=11><a href=### onclick=showCalendar(\"document.all('start" + id + "')\")><img src=/tea/image/public/Calendar2.gif></a>");
    //结束时间//////
    search.append("<input name=end"+id);
    if(end!=null&&end.length()>0)
    {
      sql.append(" AND node IN ( SELECT DISTINCT node FROM DynamicValue WHERE dynamictype=").append(id).append(" AND value<").append(DbAdapter.cite(end)).append(" ) ");
      param.append("&end").append(id).append("=").append(end);
      search.append(" value=").append(end);
    }
    search.append(" readonly size=11><a href=### onclick=showCalendar(\"document.all('end" + id + "')\")><img src=/tea/image/public/Calendar2.gif></a>");
  }else
  {
    search.append("<input name=dynamictype"+id+">");
  }

  if(isExp)
  {
    ws.addCell(new Label(i,0,obj.getName(teasession._nLanguage)));
  }else
  {
    title.append("<td>"+obj.getName(teasession._nLanguage));
  }
  if(vlaue!=null&&vlaue.length()>0)
  {
    sql.append(" AND node IN ( SELECT DISTINCT node FROM DynamicValue WHERE dynamictype=").append(id).append(" AND value LIKE ").append(DbAdapter.cite("%"+vlaue+"%")).append(")");
    param.append("&dynamictype").append(id).append("=").append(java.net.URLEncoder.encode(vlaue,"UTF-8"));
    search.append("<script>form1.dynamictype"+id+".value=\"").append(vlaue).append("\";</script>");
  }
  search.append("</SPAN>");
}


if(isExp)
{
  Enumeration e2=Node.find(sql.toString(),0,Integer.MAX_VALUE);
  for(int i=1;e2.hasMoreElements();i++)
  {
    int node=((Integer)e2.nextElement()).intValue();
    for(int j=0;j<al.size();j++)
    {
      int id=((Integer)al.get(j)).intValue();
      DynamicValue dv=DynamicValue.find(node,teasession._nLanguage,id);
      String value=dv.getValue();
      ws.addCell(new Label(j,i,value));
    }
  }
  wwb.write();
  wwb.close();
  return;
}


param.append("&pos=");

int pos=0,count=Node.count(sql.toString());
tmp=request.getParameter("pos");
if(tmp!=null)
{
  pos=Integer.parseInt(tmp);
}



//System.out.println("SQL: "+sql.toString());

%><html>
<head>
<!--
参数:
dynamic: 动态类的ID,即:节点类型
expall: 导出所有,默认只导必填项
-->
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<style>
.dt_button { display:none; }
</style>
</head>
<body>

<h1>搜索</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>搜索</h2>
<form name="form1" action="?">
<%
if(isExpall)
{
  out.print("<input type=hidden name=expall value=on>");
}
%>
<input type="hidden" name="dynamic" value="<%=dynamic%>">
<input type="hidden" name="id" value="<%=strid%>">
<input type="hidden" name="community" value="<%=community%>">

<table cellspacing="0" cellpadding="0" id="tablecenter">
  <tr><td><%=search.toString()%><td><input type="submit" value="GO"/></tr>
</table>

<h2>列表 ( <%=count%> ) </h2>
<table cellspacing="0" cellpadding="0" id="tablecenter">
<tr id="tableonetr">
  <td width="30" nowrap>序号</td>
  <%=title.toString()%>
</tr>
<%

  if(count>0)
  {
    Enumeration e2=Node.find(sql.toString(),pos,10);
    for(int i=pos+1;e2.hasMoreElements();i++)
    {
      int node=((Integer)e2.nextElement()).intValue();
      out.print("<tr onMouseOver=javascript:this.bgColor='#BCD1E9' onMouseOut=javascript:this.bgColor=''><td wdith=1>"+i);
      for(int j=0;j<al.size();j++)
      {
        int id=((Integer)al.get(j)).intValue();
        DynamicValue dv=DynamicValue.find(node,teasession._nLanguage,id);
        String value=dv.getValue();
        out.print("<td id=dynamictype"+id+">&nbsp;");
        if(j==0)
        {
          out.print("<a href=/jsp/type/dynamicvalue/DynamicValueViewTab.jsp?community=roadbridge&node="+node+">");
        }
        if(value!=null)
        out.print(value);
      }
    }
  }else
  {
  	out.print("<tr><td colspan=25 align=center>暂无记录</td></tr>");
  }


%>
<tr><td colspan="25" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,param.toString(),pos,count,10)%></td></tr>

</table>
<input type="submit" name="exp" value="导出Excel" id="dce">
</form>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
