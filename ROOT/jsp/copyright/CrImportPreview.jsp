<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource"  %>
<%@page import="tea.entity.copyright.*" %>
<%@page import="tea.entity.*"%>
<%@page import="java.util.*"%>
<%@page import="tea.ui.TeaSession" %>
<%@page import="jxl.*"%>
<%@page import="java.io.*"%><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

String nexturl=teasession.getParameter("nexturl");
String act=teasession.getParameter("act");


String title=null;
if("crcourtclose".equals(act))//法院查封公告信息
{
  title=("<tr id=tableonetr><td nowrap>序号</td><td nowrap>登记号</td><td nowrap>执行法院</td><td nowrap>涉及公司或者个人</td><td nowrap>软件名称</td><td nowrap>查封日期</td><td nowrap>查封年限</td><td nowrap>解封日期</td><td nowrap>撤销日期</td><td nowrap>原文路径</td></tr>");
}else if("crupdate".equals(act))//变更补充公告信息
{
  title=("<tr id=tableonetr><td nowrap>序号</td><td nowrap>证明编号</td><td nowrap>登记号</td><td nowrap>申请者</td><td nowrap>软件名称</td><td nowrap>简称</td><td nowrap>版本号</td><td nowrap>变更类别</td><td nowrap>变更项目</td><td nowrap>变前内容</td><td nowrap>变后内容</td><td nowrap>出证日期</td><td nowrap>原文路径</td></tr>");
}else if("crallow".equals(act))//许可合同公告信息
{
  title=("<tr id=tableonetr><td nowrap>序号</td><td nowrap>编号</td><td nowrap>登记号</td><td nowrap>软件名称</td><td nowrap>软件名称字体号</td><td nowrap>合同登记人</td><td nowrap>合同登记人字体号</td><td nowrap>权利范围</td><td nowrap>地域范围</td><td nowrap>地域范围字体号</td><td nowrap>授权期限始</td><td nowrap>授权期限终</td><td nowrap>授权许可方</td><td nowrap>授权许可方字体号</td><td nowrap>被授权许可方</td><td nowrap>被授权许可方字体号</td><td nowrap>发证日期</td><td nowrap>原文路径</td></tr>");
}else if("crimpawn".equals(act))//质押公告信息
{
  title=("<tr id=tableonetr><td nowrap>序号</td><td nowrap>编号</td><td nowrap>登记号</td><td nowrap>软件名称</td><td nowrap>简称</td><td nowrap>出质人</td><td nowrap>质权人</td><td nowrap>版本号</td><td nowrap>出证日期</td><td nowrap>注销撤消日期</td><td nowrap>状态</td><td nowrap>原文路径</td></tr>");
}else if("crcancel".equals(act))//计算机软件著作权登记撤销公告
{
  title=("<tr id=tableonetr><td nowrap>序号</td><td nowrap>编号</td><td nowrap>登记号</td><td nowrap>原登记者</td><td nowrap>软件名称</td><td nowrap>简称</td><td nowrap>版本号</td><td nowrap>决定理由</td><td nowrap>撤消日期</td><td nowrap>原文路径</td></tr>");
}else if("crtransfercontract".equals(act))//转让合同公告信息
{
  title=("<tr id=tableonetr><td nowrap>序号</td><td nowrap>编号</td><td nowrap>登记号</td><td nowrap>软件名称</td><td nowrap>软件名称字体号</td><td nowrap>合同登记人</td><td nowrap>合同登记人字体号</td><td nowrap>转让权利</td><td nowrap>转让人</td><td nowrap>转让人字体号</td><td nowrap>受让人</td><td nowrap>受让人字体号</td><td nowrap>发证日期</td><td nowrap>原文路径</td></tr>");
}else if("crbookin".equals(act))//计算机软件著作权登记公告
{
  title=("<tr id=tableonetr><td nowrap>序号</td><td nowrap>登记号</td><td nowrap>分类号</td><td nowrap>软件名称</td><td nowrap>简称</td><td nowrap>著作权人姓名</td><td nowrap>著作权人国籍</td><td nowrap>软件首次发表日期</td><td nowrap>软件首次发表地区</td><td nowrap>软件零售价（￥）</td><td nowrap>软件零售价（$）</td><td nowrap>版本登记号</td><td nowrap>批准日期</td><td nowrap>备注1</td><td nowrap>备注2</td></tr>");
}

boolean isImport=teasession.getParameter("import")!=null;

%>
<%!
public String cellToString(Cell c)
{
  String str=c.getContents();
  if(str==null||"null".equals(str))
  {
    str="";
  }
  return str;
}
public Date cellToDate(Cell c)
{
  String str=c.getContents();
  if(str==null||"null".equals(str))
  {
    return null;
  }
  java.util.Date d=null;
  try
  {
    d=Entity.sdf2.parse(str);
  }catch(Exception ex)
  {
    try
    {
      d=Entity.sdf.parse(str);
    }catch(Exception ex2)
    {
      java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy年MM月dd日");
      try
      {
        d=sdf.parse(str);
      }catch(Exception ex3)
      {
        sdf = new java.text.SimpleDateFormat("dd/MM/yyyy");
        try
        {
          d=sdf.parse(str);
        }catch(Exception ex4)
        {

        }
      }
    }
  }
  return d;
}
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script>

<!-- 进度条----------------------------------------------------------------------------------------------------- -->
function ProgressBar()
{
  document.write("<div id=ProgressBar align=center >");
  document.write("数据导入中,请等待...<br>");
  document.write("<input id=chart style='border:1px solid #CCCCCC; font-family:Arial;' size=55 readonly><br>");//
  document.write("<span id=percent>0%</span>");
  document.write("</div>");
  var prd=1.0;
  ProgressBar.setMax=function(max)
  {
    prd=max/100;
  }
  ProgressBar.setValue=function(v)
  {
    var bar="";
    v=(v/prd).toFixed(2);
    for(var i=0;i<v;i++)
    {
      bar=bar+"|";
    }
    chart.value=bar;
    percent.innerHTML=v+"%";
    if(v>99)
    {
      body.style.display="";
      ProgressBar.style.display="none";
    }
  }
}
</script>
</head>
<body>
<%

byte by[]=teasession.getBytesParameter("file");
if(by==null)
{
  out.print("<table border=0 cellpadding=0 cellspacing=0 id=tablecenter>");
  out.print(title);
  out.print("</table>");
}else
{
  ByteArrayInputStream bais=new ByteArrayInputStream(by);
  try
  {
    Workbook wb=Workbook.getWorkbook(bais);
    Sheet s=wb.getSheet(0);

    if(isImport)
    {
      int result[]=new int[2];
      out.println("<script>ProgressBar(); ProgressBar.setMax("+s.getRows()+"); </script> <br><br>总记录数:<span>"+s.getRows()+"</span><br>  添加:<span id=insert></span><br>  修改:<span id=update></span>");
      out.flush();
      if("crcourtclose".equals(act))//法院查封公告信息
      {
        for(int i=1;i<s.getRows();i++)
        {
          String scrbid=null;
          String court=null;
          String author=null;
          String name=null;
          String close=null;
          String year=null;
          String open=null;
          String cancel=null;
          String path=null;
          for(int j=1;j<s.getColumns();j++)
          {
            switch(j)
            {
              case 1:
              scrbid=cellToString(s.getCell(j,i));
              break;
              case 2:
              court=cellToString(s.getCell(j,i));
              break;
              case 3:
              author=cellToString(s.getCell(j,i));
              break;
              case 4:
              name=cellToString(s.getCell(j,i));
              break;
              case 5:
              close=cellToString(s.getCell(j,i));
              break;
              case 6:
              year=cellToString(s.getCell(j,i));
              break;
              case 7:
              open=cellToString(s.getCell(j,i));
              break;
              case 8:
              cancel=cellToString(s.getCell(j,i));
              break;
              case 9:
              path=cellToString(s.getCell(j,i));
              break;
            }
          }
          int id=Crcourtclose.find(scrbid);
          if(id<1)
          {
            Crcourtclose.create(teasession._strCommunity, scrbid, court, author, name, close, year, open, cancel, path);
            result[0]++;
          }else
          {
            Crcourtclose obj=Crcourtclose.find(id);
            obj.set(court, author, name, close, year, open, cancel, path);
            result[1]++;
          }
          if(i%10==0)
          {
            out.print("<script>ProgressBar.setValue("+(i+1)+"); insert.innerHTML="+result[0]+"; update.innerHTML="+result[1]+";</script>");
            out.flush();
          }
        }
      }else if("crupdate".equals(act))//变更补充公告信息
      {
        for(int i=1;i<s.getRows();i++)
        {
          String proving=null;
          String scrbid=null;
          String applicant=null;
          String name=null;
          String shortname=null;
          String ver=null;
          String type=null;
          String item=null;
          String beforeitem=null;
          String afteritem=null;
          String time=null;
          String path=null;
          for(int j=1;j<s.getColumns();j++)
          {
            switch(j)
            {
              case 1:
              proving=cellToString(s.getCell(j,i));
              break;
              case 2:
              scrbid=cellToString(s.getCell(j,i));
              break;
              case 3:
              applicant=cellToString(s.getCell(j,i));
              break;
              case 4:
              name=cellToString(s.getCell(j,i));
              break;
              case 5:
              shortname=cellToString(s.getCell(j,i));
              break;
              case 6:
              ver=cellToString(s.getCell(j,i));
              break;
              case 7:
              type=cellToString(s.getCell(j,i));
              break;
              case 8:
              item=cellToString(s.getCell(j,i));
              break;
              case 9:
              beforeitem=cellToString(s.getCell(j,i));
              break;
              case 10:
              afteritem=cellToString(s.getCell(j,i));
              break;
              case 11:
              time=cellToString(s.getCell(j,i));
              break;
              case 12:
              path=cellToString(s.getCell(j,i));
              break;
            }
          }
          int id=Crupdate.find(scrbid);
          if(id<1)
          {
            Crupdate.create(teasession._strCommunity,scrbid, proving,applicant,name,shortname,ver,type,item,beforeitem,afteritem,time,path);
            result[0]++;
          }else
          {
            Crupdate obj=Crupdate.find(id);
            obj.set(proving,applicant,name,shortname,ver,type,item,beforeitem,afteritem,time,path);
            result[1]++;
          }
          if(i%10==0)
          {
            out.print("<script>ProgressBar.setValue("+(i+1)+"); insert.innerHTML="+result[0]+"; update.innerHTML="+result[1]+";</script>");
            out.flush();
          }
        }
      }else if("crallow".equals(act))//许可合同公告信息
      {
        for(int i=1;i<s.getRows();i++)
        {
          String code=null;
          String scrbid=null;
          String name=null;
          String font1=null;
          String author=null;
          String font2=null;
          String droit=null;
          String area=null;
          String font3=null;
          String starttime=null;
          String endtime=null;
          String host=null;
          String font4=null;
          String user=null;
          String font5=null;
          String time=null;
          String path=null;
          for(int j=1;j<s.getColumns();j++)
          {
            switch(j)
            {
              case 1:
              code=cellToString(s.getCell(j,i));
              break;
              case 2:
              scrbid=cellToString(s.getCell(j,i));
              break;
              case 3:
              name=cellToString(s.getCell(j,i));
              break;
              case 4:
              font1=cellToString(s.getCell(j,i));
              break;
              case 5:
              author=cellToString(s.getCell(j,i));
              break;
              case 6:
              font2=cellToString(s.getCell(j,i));
              break;
              case 7:
              droit=cellToString(s.getCell(j,i));
              break;
              case 8:
              area=cellToString(s.getCell(j,i));
              break;
              case 9:
              font3=cellToString(s.getCell(j,i));
              break;
              case 10:
              starttime=cellToString(s.getCell(j,i));
              break;
              case 11:
              endtime=cellToString(s.getCell(j,i));
              break;
              case 12:
              host=cellToString(s.getCell(j,i));
              break;
              case 13:
              font4=cellToString(s.getCell(j,i));
              break;
              case 14:
              user=cellToString(s.getCell(j,i));
              break;
              case 15:
              font5=cellToString(s.getCell(j,i));
              break;
              case 16:
              time=cellToString(s.getCell(j,i));
              break;
              case 17:
              path=cellToString(s.getCell(j,i));
              break;
            }
          }
          int id=Crallow.find(scrbid);
          if(id<1)
          {
            Crallow.create(teasession._strCommunity,code, scrbid, name, font1, author, font2, droit, area, font3, starttime,endtime, host, font4, user, font5, time, path);
            result[0]++;
          }else
          {
            Crallow obj=Crallow.find(id);
            obj.set(code,name, font1, author, font2, droit, area, font3, starttime,endtime, host, font4, user, font5, time, path);
            result[1]++;
          }
          if(i%10==0)
          {
            out.print("<script>ProgressBar.setValue("+(i+1)+"); insert.innerHTML="+result[0]+"; update.innerHTML="+result[1]+";</script>");
            out.flush();
          }
        }
      }else if("crimpawn".equals(act))//质押公告信息
      {
        for(int i=1;i<s.getRows();i++)
        {
          String code=null;
          String scrbid=null;
          String name=null;
          String shortname=null;
          String mortgagor=null;//出质人
          String pawnee=null;//质权人
          String ver=null;
          String time=null;
          String cancel=null;
          String states=null;
          String path=null;
          for(int j=1;j<s.getColumns();j++)
          {
            switch(j)
            {
              case 1:
              code=cellToString(s.getCell(j,i));
              break;
              case 2:
              scrbid=cellToString(s.getCell(j,i));
              break;
              case 3:
              name=cellToString(s.getCell(j,i));
              break;
              case 4:
              shortname=cellToString(s.getCell(j,i));
              break;
              case 5:
              mortgagor=cellToString(s.getCell(j,i));
              break;
              case 6:
              pawnee=cellToString(s.getCell(j,i));
              break;
              case 7:
              ver=cellToString(s.getCell(j,i));
              break;
              case 8:
              time=cellToString(s.getCell(j,i));
              break;
              case 9:
              cancel=cellToString(s.getCell(j,i));
              break;
              case 10:
              states=cellToString(s.getCell(j,i));
              break;
              case 11:
              path=cellToString(s.getCell(j,i));
              break;
            }
          }
          int id=Crimpawn.find(scrbid);
          if(id<1)
          {
            Crimpawn.create(teasession._strCommunity,code, scrbid, name, shortname, mortgagor, pawnee, ver, time, cancel, states,path);
            result[0]++;
          }else
          {
            Crimpawn obj=Crimpawn.find(id);
            obj.set(code, name, shortname, mortgagor, pawnee, ver, time, cancel, states,path);
            result[1]++;
          }
          if(i%10==0)
          {
            out.print("<script>ProgressBar.setValue("+(i+1)+"); insert.innerHTML="+result[0]+"; update.innerHTML="+result[1]+";</script>");
            out.flush();
          }
        }
      }else if("crcancel".equals(act))//计算机软件著作权登记撤销公告
      {
        for(int i=1;i<s.getRows();i++)
        {
          String code=null;
          String scrbid=null;
          String author=null;
          String name=null;
          String shortname=null;
          String ver=null;
          String reason=null;
          Date canceldate=null;
          String path=null;
          for(int j=1;j<s.getColumns();j++)
          {
            switch(j)
            {
              case 1:
              code=cellToString(s.getCell(j,i));
              break;
              case 2:
              scrbid=cellToString(s.getCell(j,i));
              break;
              case 3:
              author=cellToString(s.getCell(j,i));
              break;
              case 4:
              name=cellToString(s.getCell(j,i));
              break;
              case 5:
              shortname=cellToString(s.getCell(j,i));
              break;
              case 6:
              ver=cellToString(s.getCell(j,i));
              break;
              case 7:
              reason=cellToString(s.getCell(j,i));
              break;
              case 8:
              canceldate=cellToDate(s.getCell(j,i));
              break;
              case 9:
              path=cellToString(s.getCell(j,i));
              break;
            }
          }
          int id=Crcancel.find(scrbid);
          if(id<1)
          {
            Crcancel.create(teasession._strCommunity, code, scrbid, author, name, shortname, ver, reason, canceldate, path);
            result[0]++;
          }else
          {
            Crcancel obj=Crcancel.find(id);
            obj.set(code,author, name, shortname, ver, reason, canceldate, path);
            result[1]++;
          }
          if(i%10==0)
          {
            out.print("<script>ProgressBar.setValue("+(i+1)+"); insert.innerHTML="+result[0]+"; update.innerHTML="+result[1]+";</script>");
            out.flush();
          }
        }
      }else if("crtransfercontract".equals(act))//转让合同公告信息
      {
        for(int i=1;i<s.getRows();i++)
        {
          String code=null;
          String scrbid=null;
          String name=null;
          String font1=null;
          String author=null;
          String font2=null;
          String droit=null;
          String assignor=null;
          String font3=null;
          String alienee=null;
          String font4=null;
          String time=null;
          String path=null;
          for(int j=1;j<s.getColumns();j++)
          {
            switch(j)
            {
              case 1:
              code=cellToString(s.getCell(j,i));
              break;
              case 2:
              scrbid=cellToString(s.getCell(j,i));
              break;
              case 3:
              name=cellToString(s.getCell(j,i));
              break;
              case 4:
              font1=cellToString(s.getCell(j,i));
              break;
              case 5:
              author=cellToString(s.getCell(j,i));
              break;
              case 6:
              font2=cellToString(s.getCell(j,i));
              break;
              case 7:
              droit=cellToString(s.getCell(j,i));
              break;
              case 8:
              assignor=cellToString(s.getCell(j,i));
              break;
              case 9:
              font3=cellToString(s.getCell(j,i));
              break;
              case 10:
              alienee=cellToString(s.getCell(j,i));
              break;
              case 11:
              font4=cellToString(s.getCell(j,i));
              break;
              case 12:
              time=cellToString(s.getCell(j,i));
              break;
              case 13:
              path=cellToString(s.getCell(j,i));
              break;
            }
          }
          int id=Crtransfercontract.find(scrbid);
          if(id<1)
          {
            Crtransfercontract.create(teasession._strCommunity, code, scrbid, name, font1, author, font2, droit, assignor, font3, alienee, font4, time, path);
            result[0]++;
          }else
          {
            Crtransfercontract obj=Crtransfercontract.find(id);
            obj.set(code, name, font1, author, font2, droit, assignor, font3, alienee, font4, time, path);
            result[1]++;
          }
          if(i%10==0)
          {
            out.print("<script>ProgressBar.setValue("+(i+1)+"); insert.innerHTML="+result[0]+"; update.innerHTML="+result[1]+";</script>");
            out.flush();
          }
        }
      }else if("crbookin".equals(act))//计算机软件著作权登记公告
      {
        for(int i=1;i<s.getRows();i++)
        {
          String scrbid=null;
          String classno=null;
          String swname=null;
          String shortname=null;
          String version=null;
          String author=null;
          String nation=null;
          String pubarea=null;
          Date pubdate=null;
          String price=null;
          String pricedollar=null;
          Date passdate=null;
          String remark1=null;
          String remark2=null;
          for(int j=1;j<s.getColumns();j++)
          {
            switch(j)
            {
              case 1:
              scrbid=cellToString(s.getCell(j,i));
              break;
              case 2:
              classno=cellToString(s.getCell(j,i));
              break;
              case 3:
              swname=cellToString(s.getCell(j,i));
              break;
              case 4:
              shortname=cellToString(s.getCell(j,i));
              break;
              case 5:
              author=cellToString(s.getCell(j,i));
              break;
              case 6:
              nation=cellToString(s.getCell(j,i));
              break;
              case 7:
              pubdate=cellToDate(s.getCell(j,i));
              break;
              case 8:
              pubarea=cellToString(s.getCell(j,i));
              break;
              case 9:
              price=cellToString(s.getCell(j,i));
              break;
              case 10:
              pricedollar=cellToString(s.getCell(j,i));
              break;
              case 11:
              version=cellToString(s.getCell(j,i));
              break;
              case 12:
              passdate=cellToDate(s.getCell(j,i));
              break;
              case 13:
              remark1=cellToString(s.getCell(j,i));
              break;
              case 14:
              remark2=cellToString(s.getCell(j,i));
              break;
            }
          }
          int id=Crbookin.find(scrbid);
          if(id<1)
          {
            Crbookin.create(teasession._strCommunity, scrbid, classno, swname, shortname, version, author, nation, pubarea, pubdate, price, pricedollar, passdate, remark1, remark2);
            result[0]++;
          }else
          {
            Crbookin obj = Crbookin.find(id);
            obj.set(classno, swname, shortname, version, author, nation, pubarea, pubdate, price, pricedollar, passdate, remark1, remark2);
            result[1]++;
          }
          if(i%10==0)
          {
            out.print("<script>ProgressBar.setValue("+(i+1)+"); insert.innerHTML="+result[0]+"; update.innerHTML="+result[1]+";</script>");
            out.flush();
          }
        }
      }
      out.print("<script>window.open('/jsp/info/Succeed.jsp?nexturl='+encodeURIComponent(\""+nexturl+"\"),'_parent');</script>");
    }else
    {
      out.print("<table border=0 cellpadding=0 cellspacing=0 id=tablecenter>");
      out.print(title);
      for(int i=0;i<s.getRows()&&i<21;i++)
      {
        out.print("<tr onMouseOver=this.bgColor='#BCD1E9' onMouseOut=this.bgColor=''>");
        for(int j=0;j<s.getColumns();j++)
        {
          String str=s.getCell(j,i).getContents();
          out.print("<td>"+("null".equals(str)?"&nbsp;":str));
        }
        out.print("</tr>");
        if(i==20)
        {
          out.print("<tr><td colspan=8>总行数为:"+s.getRows()+".   只显示前20行.......</td></tr>");
        }
      }
      out.print("</table>");
    }
    wb.close();
  }catch(Exception ex)
  {
    out.print("<table style=color:#FF0000 border=0 cellpadding=0 cellspacing=0 id=tablecenter>");
    out.print("<tr><td>错误:  可能有以下原因导致</td></tr>");
    out.print("<tr><td>1.文件格式错误</td></tr>");
    out.print("<tr><td>2.列没有匹配,请按照预览的格式进行调整.</td></tr>");
    out.print("<tr><td>&nbsp;</td></tr>");
    out.print("<tr><td>描述:</td></tr>");
    out.print("<tr><td>"+ex.getMessage()+"</td></tr>");
    out.print("</table>");
    ex.printStackTrace();
    //		response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("文件格式错误.","UTF-8"));
  }finally
  {
    bais.close();
  }
}

%>

</body>
</html>
