<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.entity.node.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.ui.TeaSession" %>
<% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

int id=Integer.parseInt(teasession.getParameter("id"));
int dynamictype=Integer.parseInt(teasession.getParameter("dynamictype"));

if("POST".equals(request.getMethod()))
{
  Date starttime=null,endtime=null;
  String tmp=request.getParameter("starttime");
  if(tmp.length()>0)
  {
    starttime=DynamicCsign.sdf.parse(tmp);
  }
  String unit=request.getParameter("unit");
  int comment=Integer.parseInt(request.getParameter("comment"));
  String content=request.getParameter("content");
  String sign=request.getParameter("sign");
  tmp=request.getParameter("endtime");
  if(tmp.length()>0)
  {
    endtime=DynamicCsign.sdf.parse(tmp);
  }
  DynamicCsign dc=DynamicCsign.find(id,dynamictype,teasession._rv._strV);
  dc.set(starttime,unit,comment,content,sign,endtime);
}


Resource r=new Resource();

String member=request.getParameter("member");

ProfileBBS pb = ProfileBBS.find(teasession._strCommunity, teasession._rv._strV);
String isign = pb.getISign(teasession._nLanguage);

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/tea/tea.js" type="text/javascript"></script>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<OBJECT ID="key" CLASSID="CLSID:B28C4E2A-D306-4743-BBE4-91B1E994E54A" CODEBASE="/tea/applet/key/HaiKey.cab#version=1,0,0,0" style="display:none"></OBJECT>
<script type="">
function f_open(v)
{
  window.open("?community=<%=teasession._strCommunity%>&id=<%=id%>&dynamictype=<%=dynamictype%>&member="+encodeURIComponent(v),"","width=500,height=300");
}
var ofc=opener.form1.content;
function f_save()
{
  ofc.value=content.value;
  window.close();
}
function f_select(obj)
{
  for(var i=0;i<form1.comment.length;i++)
  {
    form1.comment[i].checked=false;
  }
  obj.checked=true;
}
function f_sign(obj)
{
  <%
  String sn=pb.getSerialNum();
  if(sn!=null&&sn.length()>0)
  {
    %>
    try
    {
      var sn=key.GetSerialNum();
      if(!sn)return;
      if(sn!="<%=sn%>")
      {
        alert('请插入自已的Key');
        return;
      }
      var pwd=window.prompt('请输入你的Key密码:','');
      if(pwd==null)
      {
        return;
      }
      if(!key.VerifyUserPIN(pwd))
      {
        alert('密码错误');
        f_sign(obj);
        return;
      }
    }catch(ex)
    {
      alert('必须启用ActionX控件');
      return;
    }
    <%
  }
  %>
  form1.sign.value="<%=isign%>";
  var img=document.getElementById("img");
  img.src=form1.sign.value;
  img.style.display="";
  obj.style.display="none";
}
</script>
</head>
<body onload="">
<h1>会签意见栏</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<%
if(member!=null)
{
  String content="";
  DynamicCsign dc=DynamicCsign.find(id,dynamictype,member);
  if(dc.isExists())
  {
    content=dc.getContent();
  }
%>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td><textarea id="content" cols="50" rows="10"><%=content%></textarea></td>
    </tr>
  </table>
  <%
  if(member.equals(teasession._rv._strV))
  {
    out.print("<input type=submit value=提交 onclick=f_save()>");
    out.print("<script>content.value=ofc.value;</script>");
  }
  %>
  <input type="button" value="关闭" onClick="window.close();">
<%
}else
{
%>

<form name="form1" action="?" method="post" >
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="id" value="<%=id%>">
<input type="hidden" name="dynamictype" value="<%=dynamictype%>">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td>送签时间</td>
    <td>会签部门/人员</td>
    <td>会签意见</td>
    <td>签名</td>
    <td>签出日期</td>
  </tr>
<%
Enumeration e=DynamicCsign.find(id,dynamictype);
while(e.hasMoreElements())
{
  String m=(String)e.nextElement();
  if(!m.equals(teasession._rv._strV))
  {
    DynamicCsign dc=DynamicCsign.find(id,dynamictype,m);
    out.print("<tr>");
    out.print("<td>"+dc.getStartTimeToString());
    out.print("<td>"+dc.getUnit());
    out.print("<td>"+DynamicCsign.COMMENT_TYPE[dc.getComment()]);
    if(dc.getComment()==2)
    {
      out.print("<a href=javascript:f_open('"+m+"');>打开</a>");
    }
    out.print("<td><img src="+dc.getSign()+" onload=this.style.display=''; style=display:none>");
    out.print("<td>"+dc.getStartTimeToString());
  }
}

String starttime,unit="",content="",sign="";
DynamicCsign dc=DynamicCsign.find(id,dynamictype,teasession._rv._strV);
if(dc.isExists())
{
  starttime=dc.getStartTimeToString();
  unit=dc.getUnit();
  content=dc.getContent();
  sign=dc.getSign();
}else
{
  if(id<0)
  {
    id=-id;
  }
  Flowbusiness f=Flowbusiness.find(id);
  Flowprocess fp=Flowprocess.find(f.getFlow(),f.getStep());
  int flowview=Flowview.findLast(id,fp.getFlowprocess());
  Flowview fv=Flowview.find(flowview);
  starttime=fv.getTimeToString();
  //部门
  AdminUsrRole aur=AdminUsrRole.find(teasession._strCommunity,teasession._rv._strV);
  AdminUnit au=AdminUnit.find(aur.getUnit());
  unit=au.getName();
}


%>
<tr>
  <td><input type="text" name="starttime" value="<%=starttime%>" size="12" style="background-color:#CCCCCC" readonly><!--<a href="###" onclick="showCalendar('form1.starttime');"><img src="/tea/image/public/Calendar2.gif"></a>--></td>
  <%
  out.print("<td><input type=text name=unit value=\""+unit+"\" style=background-color:#CCCCCC readonly></td>");
  out.print("<td>");
  for(int i=0;i<DynamicCsign.COMMENT_TYPE.length;i++)
  {
    out.print("<input type=checkbox name=comment onclick=f_select(this); value="+i);
    if(i==dc.getComment())
    {
      out.print(" checked ");
    }
    out.print(">"+DynamicCsign.COMMENT_TYPE[i]);
  }
  %>
  <textarea name="content" style="display:none"><%=content%></textarea>
  <a href="javascript:f_open('<%=teasession._rv._strV%>');">打开</a></td>
  <td>
  <input type="hidden" name="sign" value="<%=sign%>">
  <%
  if(sign!=null&&sign.length()>0)
  {
    out.print("<img src="+sign+" >");
  }else
  {
    out.print("<input type=button value=签字 onclick=\"");
    if (isign == null || isign.length() == 0)
    {
      out.print("alert('您还没有上传你的签名.')");
    } else
    {
      out.print("f_sign(this)");
    }
    out.print("\">");
    out.print("<img id=img src=about:blank style=display:none>");
  }
  %>
  </td>
  <td><input type="text" name="endtime" value="<%=dc.getEndTimeToString()%>" size="12" style="background-color:#CCCCCC" readonly><!-- <a href="###" onclick="showCalendar('form1.endtime');"><img src="/tea/image/public/Calendar2.gif" ></a> --></td>
</tr>
</table>

<input type="submit" value="提交">
<input type="button" value="关闭" onClick="window.close();">

</form>
<%}%>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
