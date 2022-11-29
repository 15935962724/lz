<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.site.*" %><%@page import="java.io.*" %><%@page import="java.util.*" %><%@page import="tea.html.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.entity.admin.*" %><%@page import="java.math.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.db.DbAdapter"%><%@page import="tea.resource.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.ui.*" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String member=teasession._rv._strV;
String dtw=teasession.getParameter("dtw");
int flowbusiness=Integer.parseInt(request.getParameter("flowbusiness"));
int dt[][]={{937,953,939},{938,952,940},{943,954,944},//发文
{927,948,1023},{1042,1043,1044},{1051,1052,1053},{1056,1057,1058}//收文
};

ProfileBBS pb = ProfileBBS.find(teasession._strCommunity, member);
if("POST".equals(request.getMethod()))
{
  for(int i=0;i<dt.length;i++)
  {
    if(dtw.indexOf("/"+dt[i][0]+"/")!=-1)
    {
      for(int j=0;j<dt[i].length;j++)
      {
        String v=request.getParameter("dynamictype"+dt[i][j]);
        if(v!=null)
        {
          DynamicValue dv = DynamicValue.find(-flowbusiness, teasession._nLanguage, dt[i][j]);
          DynamicType d=DynamicType.find(dt[i][j]);
          if(d.getFather()>0)
          {
            dv.setMulti(-1, member, v);
          }else
          {
            dv.set(v);
          }
        }
      }
    }
  }
  out.println("<script>window.close();</script>");
  return;
}

Resource r=new Resource("/tea/resource/Dynamic");


%><html>
<head>
<title>填写意见</title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script src="/tea/tea.js" type="text/javascript"></script>
<script LANGUAGE=JAVASCRIPT src="/tea/applet/key/key.js" type="text/javascript"></script>
<style type="text/css">
<!--
body
{
 margin-left: 0px;
 margin-top: 0px;
 margin-right: 0px;
 margin-bottom: 0px;
 border:0px;
 background-color:menu;
}
-->
</style>
<script>

var opener=opener?opener:dialogArguments;
function f_submit()
{}
function f_key(obj)
{
  var ta=document.getElementsByTagName('TEXTAREA')[0];
  ta.value=obj.value;
}
function f_load()
{
  var ta=document.getElementsByTagName('TEXTAREA')[0];
//  if(ta.value=="")
//  {
//    f_key(form1.key[0]);
//  }
  ta.focus();
}
</script>
</head>
<body onLoad="f_load()">
<form name="form1" action="?" method="post" onSubmit="f_submit();">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="flowbusiness" value="<%=flowbusiness%>">
<input type="hidden" name="dtw" value="<%=dtw%>">
<!--
<div  class="Views_div">
<input name="key" type="radio" onClick="f_key(this)" value="同意" checked="checked" id="key0"><label for="key0">同意</label>
<input name="key" type="radio" onClick="f_key(this)" value="签发" id="key1"><label for="key1">签发</label>
<input name="key" type="radio" onClick="f_key(this)" value="审核" id="key2"><label for="key2">审核</label>
</div>
-->
<table class="Views">
<%
for(int i=0;i<dt.length;i++)
{
  if(dtw.indexOf("/"+dt[i][0]+"/")!=-1)
  {
    String v[]=new String[3];
    v[2]=DynamicValue.sdf.format(new Date());
    for(int j=0;j<v.length;j++)
    {
      DynamicType d=DynamicType.find(dt[i][j]);
      DynamicValue dv = DynamicValue.find(-flowbusiness, teasession._nLanguage, dt[i][j]);
      if(d.getFather()>0)
      {
        Enumeration e=dv.findMulti(" AND member="+DbAdapter.cite(member),0,1);
        if(e.hasMoreElements())
        {
          DynamicValue.Multi m = (DynamicValue.Multi) e.nextElement();
          v[j] = m.getValue();
        }
      }else
      if(dv.isExists())
      {
        v[j]=dv.getValue();
      }
    }
    out.print("<tr><td colspan='2'><textarea class='con' name='dynamictype"+dt[i][0]+"' cols='60' rows='5'>");
    if(v[0]!=null)out.print(v[0]);
    out.print("</textarea></td></tr>");
    out.print("<tr><td>");
    if(v[1]!=null&&v[1].length()>0)
    {
      out.print("<img src='"+v[1]+"' oncontextmenu='return false' height='30' />");
    }else
    {
      out.print("<input type='hidden' name='dynamictype"+dt[i][1]+"'><img id=img"+dt[i][1]+" src='about:blank' style='display:none' onload=style.display=''; oncontextmenu='return false' height='30'><input type='button' name=dynamictype_button"+dt[i][1]+" value='签字'");
      String isign = pb.getISign(teasession._nLanguage);
      String sn=pb.getSerialNum();
      out.print(" onclick=\"if(confirm('确认签字?')){ ");
      if (isign == null || isign.length() == 0)
      {
        out.print("alert('您还没有上传你的签名.')");
      } else
      {
        out.print("var key=new Key(); if(key.check('"+sn+"')){ var img=previousSibling; img.previousSibling.value='" + isign + "'; style.display='none'; img.src='" + isign + "'; img.style.display=''; }");
      }
      out.print(" }\" />");
    }
    out.print("<td class='Date'><input name='dynamictype"+dt[i][2]+"' type='text' onclick='showCalendar(this)' readonly='true' value=\"");
    if(v[2]!=null)
    {
      out.print(v[2]);
    }
    out.print("\" />");
  }
}
%>
</table>
<input type="submit" value=" 确 定 "/>
<input type="button" value=" 取 消 " onClick="window.close();"/>
</form>

</body>
</html>
