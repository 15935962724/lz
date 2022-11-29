<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.resource.Resource" %><%@ page import="tea.entity.site.*" %><%@ page import="java.util.*" %><%@ page import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
int main=0;
String tmp=request.getParameter("main");
if(tmp!=null)
{
  main=Integer.parseInt(tmp);
}

int flowprocess=Integer.parseInt(request.getParameter("flowprocess"));
Flowprocess obj=Flowprocess.find(main!=0?main:flowprocess);

String nexturl=request.getParameter("nexturl");
if(request.getMethod().equals("POST"))
{
  String dtw=request.getParameter("dtw2");
  String dtr=request.getParameter("dtr2");
  if(main==0)
  {
    obj.setDT(dtw,dtr);
  }else
  {
    obj.setMainDT(dtw,dtr);
  }
  out.print("<script>alert('您的修改信息已成功提交！');window.open('"+nexturl+"','_parent');</script>");
  return;
}

Flow f=Flow.find(obj.getFlow());

tea.resource.Resource r=new tea.resource.Resource();

String dtwrite=null,dtread=null;
if(main==0)
{
  dtwrite=obj.getDTWrite();
  dtread=obj.getDTRead();
}else
{
  dtwrite=obj.getMainDTWrite();
  dtread=obj.getMainDTRead();
}


%><html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<SCRIPT SRC="/tea/mt.js" type="text/javascript"></SCRIPT>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<SCRIPT language="JavaScript">
function f_submit()
{
  var v="/"
  var dtw=form1.dtw.options;
  for(var i=0;i<dtw.length;i++)
  {
    v=v+dtw[i].value+"/";
  }
  form1.dtw2.value=v;
  v="/"
  var dtr=form1.dtr.options;
  for(var i=0;i<dtr.length;i++)
  {
    v=v+dtr[i].value+"/";
  }
  form1.dtr2.value=v;
}
function f_load()
{
  document.form1.dt.focus();
  var dto=form1.dt.options;
  var dtwo=form1.dtw.options;
  var dtro=form1.dtr.options;
  for(var i=0;i<dto.length;i++)
  {
    for(var j=0;j<dtwo.length;j++)
    {
      if(dtwo[j].value==dto[i].value)
      {
        dto[i--]=null;
        break;
      }
    }
    for(var j=0;i>-1&&j<dtro.length;j++)
    {
      if(dtro[j].value==dto[i].value)
      {
        dto[i--]=null;
        break;
      }
    }
  }
}
</SCRIPT>

</head>
<body onLoad="f_load()">
<h1>编辑可写字段</h1>
<div id="head6"><img  height="6"></div>


<form name="form1" action="?" method="post" target="_ajax" onsubmit="return f_submit()">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="nexturl" value="<%=nexturl%>">
<input type="hidden" name="flowprocess" value="<%=flowprocess%>">
<input type="hidden" name="dtw2" value="/">
<input type="hidden" name="dtr2" value="/">

<%
if(flowprocess==f.getMainProcess())
{
  out.print("<select name=main onchange=location.replace('?main='+value+'&'+location.search.substring(1));><option value=0>-----------------------------------");
  Enumeration e=Flowprocess.find(f.getFlow()," AND flowprocess!="+flowprocess);
  while(e.hasMoreElements())
  {
    int fpid=((Integer)e.nextElement()).intValue();
    Flowprocess fp=Flowprocess.find(fpid);
    out.print("<option value="+fpid);
    if(main==fpid)
    {
      out.print(" selected");
    }
    out.print(">"+fp.getStep()+". "+fp.getName(teasession._nLanguage));
  }
  out.print("</select>");
}
%>

<table cellSpacing="0" cellPadding="0" border="0" id="tablecenter">
  <tr id="tableonetr">
    <td nowrap></td>
    <td nowrap>选定字段</td>
    <td></td>
    <td nowrap>备选字段</td>
  </tr>
  <tr>
    <td>可写:</td>
    <td>
      <select name="dtw" size="10" multiple style="WIDTH:140px;" ondblclick="move(form1.dtw,form1.dt,true);" >
      <%
      String dtws[]=dtwrite.split("/");
      for(int i=1;i<dtws.length;i++)
      {
        if("tape".equals(dtws[i]))
        out.print("<option value='"+dtws[i]+"'>发文文件");
        else if("down".equals(dtws[i]))
        out.print("<option value='"+dtws[i]+"'>正文下载");
        else if("print".equals(dtws[i]))
        out.print("<option value='"+dtws[i]+"'>正文打印");
        else
        {
          int dtid=Integer.parseInt(dtws[i]);
          DynamicType dt=DynamicType.find(dtid);
          if(dt.isExists())
          {
            out.print("<option value="+dtid+" >"+dt.getName(teasession._nLanguage));
          }
        }
      }
      %>
      </select></td>
      <td>
        <input onClick="move(form1.dt,form1.dtw,true);" type="button" value=" ← " >
        <br>
        <input onClick="move(form1.dtw,form1.dt,true);" type="button" value=" → " >      </td>
      <td rowspan="2">
        <select ondblclick="move(form1.dt,form1.dtw,true);" multiple style="WIDTH:140px;" size="20" name="dt" >
        <%
        //out.print("<option value='tape'>发文文件");
        out.print("<option value='down'>正文下载");
        out.print("<option value='print'>正文打印");
        java.util.Enumeration enumer=DynamicType.findByDynamic(Flow.find(obj.getFlow()).getDynamic(),"",0,Integer.MAX_VALUE);
        while(enumer.hasMoreElements())
        {
          int dt=((Integer)enumer.nextElement()).intValue();
          out.print("<option value='"+dt+"'>"+DynamicType.find(dt).getName(teasession._nLanguage));
        }
        %>
        </select>
       </td>
      </tr>
      <tr>
        <td>只读</td>
        <td><select name="dtr" size="10" multiple style="WIDTH:140px;" ondblclick="move(form1.dtr,form1.dt,true);" >
        <%
        String dtrs[]=dtread.split("/");
        for(int i=1;i<dtrs.length;i++)
        {
          if("tape".equals(dtrs[i]))
          out.print("<option value='"+dtrs[i]+"'>发文文件");
          else if("down".equals(dtrs[i]))
          out.print("<option value='"+dtrs[i]+"'>正文下载");
          else if("print".equals(dtrs[i]))
          out.print("<option value='"+dtrs[i]+"'>正文打印");
          else
          {
            int dtid=Integer.parseInt(dtrs[i]);
            DynamicType dt=DynamicType.find(dtid);
            if(dt.isExists())
            out.print("<option value="+dtid+" >"+dt.getName(teasession._nLanguage));
          }
        }
        %>
      </select></td>
      <td><input onClick="move(form1.dt,form1.dtr,true);" type="button" value=" ← ">
        <br>
        <input onClick="move(form1.dtr,form1.dt,true);" type="button" value=" → " >
        </td>
      </tr>
</table>

<input type="submit" value="<%=r.getString(teasession._nLanguage,"Submit")%>">
<input type="button" value="返回" onClick="history.back();">
</form>

<div id="head6"><img  height="6"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
