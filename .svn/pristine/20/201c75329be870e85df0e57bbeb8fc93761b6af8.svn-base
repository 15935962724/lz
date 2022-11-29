<%@page contentType="text/html;charset=UTF-8" %><%@page import="jxl.*" %><%@page import="jxl.write.*" %><%@page import="java.io.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.entity.admin.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.db.DbAdapter" %><%@page import="tea.resource.Resource" %><%@page import="java.util.*" %><%@page import="tea.ui.TeaSession" %><%
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

int flow=Integer.parseInt(request.getParameter("flow"));

Flow f=Flow.find(flow);
int dynamic=f.getDynamic();
Dynamic d=Dynamic.find(dynamic);

//先把列放到数组中,以备后面的循环
ArrayList al=new ArrayList();
Enumeration e=DynamicType.findByDynamic(dynamic," AND dynamic="+dynamic+" AND qrc=1",0,Integer.MAX_VALUE);
while(e.hasMoreElements())
{
  al.add(e.nextElement());
}

//导出Excel////////////
boolean isExp=request.getParameter("exp")!=null;
WritableWorkbook wwb=null;
WritableSheet ws=null;
if(isExp)
{
  response.setContentType("application/x-msdownload");
  response.setHeader("Content-Disposition", "attachment; filename=exp.xls");
  Workbook wb=Workbook.getWorkbook(new File(application.getRealPath(d.getTemplate(teasession._nLanguage))));
  wwb=Workbook.createWorkbook(response.getOutputStream(),wb);
  ws=wwb.getSheet(0);
}

StringBuffer sql=new StringBuffer();
sql.append(" AND flow=").append(flow);

StringBuffer param=new StringBuffer();
param.append("?community=").append(community);
param.append("&flow=").append(flow);
param.append("&id=").append(strid);

StringBuffer search=new StringBuffer();
StringBuffer title=new StringBuffer();

for(int i=0;i<al.size();i++)
{
  int id=((Integer)al.get(i)).intValue();
  DynamicType obj=DynamicType.find(id);

  String vlaue=request.getParameter("dynamictype"+id);
  search.append("<span>"+obj.getName(teasession._nLanguage));
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
      sql.append(" AND flowbusiness IN ( SELECT DISTINCT -node FROM DynamicValue WHERE dynamictype=").append(id).append(" AND value>=").append(DbAdapter.cite(start)).append(" ) ");
      param.append("&start").append(id).append("=").append(start);
      search.append(" value=").append(start);
    }
    search.append(" readonly size=11><a href=### onclick=showCalendar(\"document.all('start" + id + "')\")><img src=/tea/image/public/Calendar2.gif></a>");
    //结束时间//////
    search.append("<input name=end"+id);
    if(end!=null&&end.length()>0)
    {
      sql.append(" AND flowbusiness IN ( SELECT DISTINCT -node FROM DynamicValue WHERE dynamictype=").append(id).append(" AND value<").append(DbAdapter.cite(end)).append(" ) ");
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
    ws.addCell(new Label(i,3,obj.getName(teasession._nLanguage)));
  }else
  {
    title.append("<td>"+obj.getName(teasession._nLanguage));
  }
  if(vlaue!=null&&vlaue.length()>0)
  {
    //库里写的是负数,所以前面要加-,负负行正
    sql.append(" AND flowbusiness IN ( SELECT DISTINCT -node FROM DynamicValue WHERE dynamictype=").append(id).append(" AND value LIKE ").append(DbAdapter.cite("%"+vlaue+"%")).append(")");
    param.append("&dynamictype").append(id).append("=").append(java.net.URLEncoder.encode(vlaue,"UTF-8"));
    search.append("<script>form1.dynamictype"+id+".value=\"").append(vlaue).append("\";</script>");
  }
}


if(isExp)
{
  Enumeration e2=Flowbusiness.findByCommunity(teasession._strCommunity,sql.toString(),0,Integer.MAX_VALUE);
  for(int i=4;e2.hasMoreElements();i++)
  {
    int node=((Integer)e2.nextElement()).intValue();
    ws.insertRow(i);
    for(int j=0;j<al.size();j++)
    {
      int id=((Integer)al.get(j)).intValue();
      DynamicValue dv=DynamicValue.find(-node,teasession._nLanguage,id);
      String value=dv.getValue();
      ws.addCell(new Label(j,i,value));
    }
  }
  wwb.write();
  wwb.close();
  return;
}


param.append("&pos=");

int pos=0,count=Flowbusiness.countByCommunity(teasession._strCommunity,sql.toString());
String tmp=request.getParameter("pos");
if(tmp!=null)
{
  pos=Integer.parseInt(tmp);
}


int csign=0;
e=DynamicType.findByDynamic(dynamic,"csign");
if(e.hasMoreElements())
{
  csign=((Integer)e.nextElement()).intValue();
}

//System.out.println("SQL: "+sql.toString());

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>

<h1>搜索</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>搜索</h2>
<form name="form1" action="?">
<input style="width:80" type="hidden" name="community" value="<%=community%>">
<input style="width:80" type="hidden" name="flow" value="<%=flow%>">
<input style="width:80" type="hidden" name="id" value="<%=strid%>">

<table cellspacing="0" cellpadding="0" id="tablecenter">
  <tr><td><%=search.toString()%><td><input type="submit" value="检索"/></tr>
</table>

<h2>列表</h2>
<table cellspacing="0" cellpadding="0" id="tablecenter">
<tr id="tableonetr">
  <td width="1">&nbsp;</td><%=title.toString()%>
  <td>&nbsp;</td>
</tr>
<%
if(count>0)
{
  DbAdapter db=new DbAdapter();
  try
  {
    Enumeration e2=Flowbusiness.findByCommunity(teasession._strCommunity,sql.toString(),pos,25);
    for(int i=1;e2.hasMoreElements();i++)
    {
      int bid=((Integer)e2.nextElement()).intValue();
      out.print("<tr onMouseOver=javascript:this.bgColor='#BCD1E9' onMouseOut=javascript:this.bgColor=''><td wdith=1>"+i);
      for(int j=0;j<al.size();j++)
      {
        int id=((Integer)al.get(j)).intValue();
        DynamicValue dv=DynamicValue.find(-bid,teasession._nLanguage,id);
        String value=dv.getValue();
        out.print("<td>&nbsp;");
        if(value!=null)
        out.print(value);
      }
      out.print("<td><input type=button value=详细信息 onclick=window.open('/jsp/admin/flow/FlowbusinessView.jsp?community="+teasession._strCommunity+"&dynamic="+dynamic+"&flowbusiness="+bid+"')>");
      if(csign>0)
      {
        out.print("<input type=button value=会签信息 onclick=window.open('/jsp/admin/flow/DynamicCsignView.jsp?community="+teasession._strCommunity+"&id=-"+bid+"&dynamictype="+csign+"','','width=600,height=600')>");
      }
    }
  }finally
  {
    db.close();
  }
}
if(count>25)
{
%>
<tr><td colspan="25" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,param.toString(),pos,count)%></td></tr>
<%}%>
</table>
<input type="submit" name="exp" value="导出Excel">
</form>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
