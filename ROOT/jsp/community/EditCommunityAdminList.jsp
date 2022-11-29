<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="java.util.*" %>
<% request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


if("POST".equals(request.getMethod()))
{
  int type=Integer.parseInt(request.getParameter("type"));
  String field=request.getParameter("field");
  String sorttype=request.getParameter("sorttype");
  boolean sortdir="1".equals(request.getParameter("sortdir"));

  CommunityAdminList cal=CommunityAdminList.find(teasession._strCommunity,type);
  cal.set(field,sorttype,sortdir);
  response.sendRedirect("/jsp/info/Succeed.jsp?community="+teasession._strCommunity);
  return;
}


Resource r=new Resource("/tea/resource/AdminList");

String strid=request.getParameter("id");

CLicense obj=CLicense.find(teasession._strCommunity);
String nts[]=obj.getType().split("/");

//基本字段///
StringBuffer comm=new StringBuffer();
String s[]=CommunityAdminList.ALL_FIELD[0].split("/");
for(int j=1;j<s.length;j++)
{
  if(j>1)
  {
    comm.append(",");
  }
  comm.append("new Array('").append(s[j]).append("','").append(r.getString(teasession._nLanguage,"Node."+s[j])).append("')");
}

StringBuffer s0=new StringBuffer();
StringBuffer s1=new StringBuffer();
StringBuffer s2=new StringBuffer();
StringBuffer s3=new StringBuffer();
for (int i = 1; i < nts.length; i++)
{
  int t=Integer.parseInt(nts[i]);
  String name;
  if(t<1024)
  {
    name=r.getString(teasession._nLanguage,Node.NODE_TYPE[t]);
  }else
  {
    Dynamic d=Dynamic.find(t);
    if(!d.isExists())
    {
      continue;
    }
    name=d.getName(teasession._nLanguage);
  }
  s0.append("<option value="+t+">"+name);

  //System.out.println(t);
  CommunityAdminList cal=CommunityAdminList.find(teasession._strCommunity,t);
  s1.append("var f1_").append(t).append("='").append(cal.getField()).append("';\r\n");
  s3.append("var f3_").append(t).append("=new Array('").append(cal.getSortType()).append("',").append(cal.isSortDir()?1:0).append(");");

  s2.append("var f2_").append(t).append("=new Array(").append(comm);
  if(t<1024)
  {
    s=CommunityAdminList.ALL_FIELD[t].split("/");
    for(int j=1;j<s.length;j++)
    {
      s2.append(",new Array('"+s[j]+"','"+r.getString(teasession._nLanguage,Node.NODE_TYPE[t]+"."+s[j])+"')");
    }
  }else
  {
    Enumeration e=DynamicType.findByDynamic(t);
    while(e.hasMoreElements())
    {
      int dtid=((Integer)e.nextElement()).intValue();
      DynamicType dt=DynamicType.find(dtid);
      s2.append(",new Array('"+dtid+"','"+dt.getName(teasession._nLanguage)+"')");
    }
  }
  s2.append("); \r\n");
}



%><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT language="JavaScript">
function f_submit()
{
  var f="/";
  var op=form1.field1.options;
  for(var i=0;i<op.length; i++)
  {
    f=f+op[i].value+"/";
  }
  form1.field.value=f;
}
<%=s1.toString()+s2.toString()+s3.toString()%>
function f_change()
{
  var v=form1.type.value;
  var f1=eval("f1_"+v);
  var o1=form1.field1.options;
  while(o1.length>0)
  {
    o1[0]=null;
  }

  var f3=eval("f3_"+v);
  form1.sorttype.value=f3[0];
  form1.sortdir[f3[1]].checked=true;

  var f2=eval("f2_"+v);
  var o2=form1.field2.options;
  while(o2.length>0)
  {
    o2[0]=null;
  }


  for(var i=0;i<f2.length;i++)
  {
    o2[o2.length]=new Option(f2[i][1],f2[i][0]);
  }


  var fs=f1.split("/");
  for(var i=1;i<fs.length;i++)
  {
    for(var j=0;j<o2.length;j++)
    {
      if(fs[i]==o2[j].value)
      {
        o1[o1.length]=new Option(o2[j].text,o2[j].value);
        o2[j]=null;
        break;
      }
    }
  }
}
</script>
</HEAD>
<BODY onload="f_change();">
<h1><%=r.getString(teasession._nLanguage, "定制列表栏目")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<FORM name="form1" action="?" method="POST" onsubmit="f_submit()" >
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="id" value="<%=strid%>">
<input type="hidden" name="field" value="/">

<table cellSpacing="0" cellPadding="0" border="0" id="tablecenter">
<tr>
  <td></td>
  <td>
  <select name="type" onchange="f_change()">
  <%=s0.toString()%>
  </select>
  </td>
</tr>
<tr id="tableonetr">
  <td align="right">选定</td>
  <td>&nbsp;</td>
  <td>备选</td>
</tr>
<tr>
  <td align="right">
    <select name="field1" size="12" multiple style="WIDTH:140px;" ondblclick="move(form1.field1,form1.field2,true);">
    </select>
  </td>
  <td align="center">
    <input type="button" value=" ← " onClick="move(form1.field2,form1.field1,true);" >
    <br>
    <input type="button" value=" → "  onClick="move(form1.field1,form1.field2,true);">
    <br><br>
    <input type="button" value=" ↑ " onClick="move(form1.field1,null,true);" >
    <br>
    <input type="button" value=" ↓ "  onClick="move(form1.field1,null,false);">
    </td>
    <td>
      <select name="field2" size="12" multiple style="WIDTH:140px;" ondblclick="move(form1.field2,form1.field1,true);">
      </select>
    </td>
</tr>
<tr>
  <td>排序类型</td>
  <td>
    <select name="sorttype">
    <option value="node">------------------</option>
    <option value="time">时间</option>
    <option value="sequence">顺序</option>
    </select>
  </td>
</tr>
<tr>
  <td>排序方向</td>
  <td>
    <input name="sortdir" type="radio" value="0" />升序
    <input name="sortdir" type="radio" value="1" />降序
  </td>
</tr>
</table>

<INPUT type="submit" value="<%=r.getString(teasession._nLanguage,"Submit")%>">
<!--
<INPUT type="button" value="<%=r.getString(teasession._nLanguage,"CBBack")%>" onclick="history.back();">
-->
</FORM>

<BR>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</BODY>
</HTML>
