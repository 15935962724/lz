<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.ui.*" %><%@page import="jxl.write.*" %><%@page import="tea.entity.*" %><%@page import="java.util.*" %><%@page import="java.text.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.entity.node.*" %><%@page import="java.io.*" %><%@page import="java.net.*" %><%@page import="tea.db.*" %><%

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Http h=new Http(request,response);
boolean empty=h.getBool("empty");
if("POST".equals(request.getMethod()))
{
  String act=h.get("act"),table=h.get("table");
  if("clear".equals(act))
  {
    DbAdapter db=new DbAdapter();
    try
    {
      db.executeUpdate("TRUNCATE TABLE "+table);
    }finally
    {
      db.close();
    }
  }else if("exp".equals(act))
  {
    response.setContentType("application/octet-stream");
    response.setHeader("Content-Disposition","attachment; filename=" + new String("导出.xls".getBytes("GBK"),"ISO-8859-1"));
    WritableWorkbook wwb = jxl.Workbook.createWorkbook(response.getOutputStream());
    WritableSheet ws = wwb.createSheet("工作表",0);
    ws.setColumnView(0,20);
    ws.setColumnView(1,20);
    ws.setColumnView(2,20);
    ws.setColumnView(3,20);
    ws.setRowView(0,500);
    ws.mergeCells(0,0,4,0);
    WritableCellFormat cf = new WritableCellFormat(new WritableFont(WritableFont.ARIAL,20,WritableFont.BOLD));
    ws.addCell(new Label(0,0,"表空间大小查看",cf));
    int j = 0,i=2;
    cf = new WritableCellFormat();
    cf.setBackground(Colour.GRAY_25);
    ws.addCell(new Label(j++,1,"表名",cf));
    ws.addCell(new Label(j++,1,"行数",cf));
    ws.addCell(new Label(j++,1,"数据空间KB",cf));
    ws.addCell(new Label(j++,1,"索引空间KB",cf));
    ws.addCell(new Label(j++,1,"剩余空间KB",cf));
    DbAdapter db=new DbAdapter(),db2=new DbAdapter();
    try
    {
      db.executeQuery(h.key);
      while(db.next())
      {
        String name=db.getString(1);
        db2.executeQuery("sp_spaceused "+name);
        db2.next();
        name=db2.getString(1).trim();
        int row=db2.getInt(2);
        String tmp=db2.getString(3);
        int reserved=Integer.parseInt(tmp.substring(0,tmp.length()-3));
        tmp=db2.getString(4);
        int data=Integer.parseInt(tmp.substring(0,tmp.length()-3));
        tmp=db2.getString(5);
        int index_size=Integer.parseInt(tmp.substring(0,tmp.length()-3));
        tmp=db2.getString(6);
        int unused=Integer.parseInt(tmp.substring(0,tmp.length()-3));
        if(row<1&&empty)continue;
        j = 0;
        ws.addCell(new Label(j++,i,name));
        ws.addCell(new jxl.write.Number(j++,i,row));
        ws.addCell(new jxl.write.Number(j++,i,data));
        ws.addCell(new jxl.write.Number(j++,i,index_size));
        ws.addCell(new jxl.write.Number(j++,i,unused));
        i++;
      }
    }finally
    {
      db.close();
      db2.close();
    }
    ws.addCell(new Label(1,i,"=SUM(B3:B"+i+")"));
    wwb.write();
    wwb.close();
    return;
  }
  out.print("<script>parent.location.reload();</script>");
  return;
}
int menuid=h.getInt("id");

int i=0,rows=0,datas=0,indexs=0,unuseds=0;
DecimalFormat df=new DecimalFormat("#,###");

String name=h.get("name","");
StringBuilder sql=new StringBuilder();
sql.append("SELECT name FROM sysobjects WHERE type='U'");
if(name.length()>0)
{
  sql.append(" AND name LIKE "+DbAdapter.cite("%"+name+"%"));
}
Date t0=h.getDate("t0");
if(t0!=null)
{
  sql.append(" AND crdate>"+DbAdapter.cite(t0));
}
Date t1=h.getDate("t1");
if(t1!=null)
{
  sql.append(" AND crdate<"+DbAdapter.cite(t1));
}

sql.append(" ORDER BY name");

%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
<style>
#tableonetr td{text-align:right}
</style>
</head>
<body>
<h1>表空间大小管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td>名称:<input name="name" value="<%=name%>"/></td>
  <td>时间:<input name="t0" value="<%=MT.f(t0)%>" onclick="mt.date(this)" size="10"/> - <input name="t1" value="<%=MT.f(t1)%>" onclick="mt.date(this)" size="10"/></td>
  <td><input type="checkbox" name="empty" <%=empty?" checked":""%> id="empty"/><label for="empty">忽略空表</label></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<form name="form2" method="post" action="?" target="_ajax">
<input type="hidden" name="id" value="<%=menuid%>"/>
<input type="hidden" name="table"/>
<input type="hidden" name="act"/>
<input type="hidden" name="empty" value="<%=empty%>"/>
<input type="hidden" name="key" value="<%=MT.enc(sql.toString())%>"/>
<table id='tablecenter'>
<tr id="tableonetr">
  <td></td>
  <td style="text-align:left">表名</td>
  <td>行数</td>
  <td>数据空间KB</td>
  <td>索引空间KB</td>
  <td>剩余空间KB</td>
  <td>操作</td>
</tr>
<%
DbAdapter db=new DbAdapter(),db2=new DbAdapter();
try
{
  db.executeQuery(sql.toString());
  while(db.next())
  {
    name=db.getString(1);
    db2.executeQuery("sp_spaceused "+name);
    if(db2.next())
    {
      name=db2.getString(1).trim();
      int row=db2.getInt(2);
      String tmp=db2.getString(3);
      int reserved=Integer.parseInt(tmp.substring(0,tmp.length()-3));
      tmp=db2.getString(4);
      int data=Integer.parseInt(tmp.substring(0,tmp.length()-3));
      tmp=db2.getString(5);
      int index_size=Integer.parseInt(tmp.substring(0,tmp.length()-3));
      tmp=db2.getString(6);
      int unused=Integer.parseInt(tmp.substring(0,tmp.length()-3));
      if(row<1)
      {
        db2.executeUpdate("TRUNCATE TABLE "+name);
        if(empty)continue;
      }
      out.print("<tr><td>"+(++i)+"<td>"+name);
      out.print("<td align='right'>"+df.format(row));
      //out.print("<td align='right'>"+reserved);
      out.print("<td align='right'>"+df.format(data));
      out.print("<td align='right'>"+df.format(index_size));
      out.print("<td align='right'>"+df.format(unused));
      out.print("<td><a href=javascript:mt.act('clear','"+name+"')>清空</a>");
      rows+=row;
      datas+=data;
      indexs+=index_size;
      unuseds+=unused;
    }
  }
}finally
{
  db.close();
  db2.close();
}
%>
<tr><td><td>总计
<td align='right'><%=df.format(rows)%>
<td align='right'><%=df.format(datas)%>
<td align='right'><%=df.format(indexs)%>
<td align='right'><%=df.format(unuseds)%>
<td>
</table>
<input type="button" value="导出" onclick="mt.act('exp')"/>


<h2>库</h2>
<table id='tablecenter'>
<tr id="tableonetr">
  <td></td>
  <td style="text-align:left">库名</td>
  <td>大小</td>
  <td>创建日期</td>
</tr>
<%
i=0;
db=new DbAdapter();
try
{
  db.executeQuery("sp_helpdb");
  while(db.next())
  {
    out.print("<tr><td>"+(++i)+"<td>"+db.getString(1));
    out.print("<td align='right'>"+db.getString(2));
    out.print("<td align='right'>"+MT.f(new Date(db.getString(5).replace(' ','/'))));
  }
}finally
{
  db.close();
}
%>
</table>

</form>

<script>
mt.act=function(a,t)
{
  form2.act.value=a;
  form2.table.value=t;
  if(a=='clear')
  mt.show("确认要清空吗？",2,"form2.submit()");
  else
  form2.submit();
}
</script>
</body>
</html>
