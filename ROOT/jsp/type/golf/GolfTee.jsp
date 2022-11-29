<%@page contentType="text/html;charset=UTF-8"  %><%@include file="/jsp/Header.jsp"%><%


r.add("/tea/resource/Golf");

int gsid = 0;
if(teasession.getParameter("gsid")!=null && teasession.getParameter("gsid").length()>0)
{
	gsid = Integer.parseInt(teasession.getParameter("gsid"));
}
GolfSite obj = GolfSite.find(gsid);

if(!obj.isExists())
{
  out.print("错误! 不存在此场地");
  return;
}

Node n=Node.find(teasession._nNode);

String nexturl=request.getParameter("nexturl");

//Golf obj=Golf.find(teasession._nNode,teasession._nLanguage);

float[] d=obj.difficultys;
float[] g=obj.gradients;
if("POST".equals(request.getMethod()))
{
  for(int i=0;i<5;i++)
  {
    String tmp=teasession.getParameter("difficulty"+i);
    try
    {
      d[i]=Float.parseFloat(tmp);
    } catch(Exception ex)
    {ex.printStackTrace();}
    //
    tmp=teasession.getParameter("gradient"+i);
    try
    {
      g[i]=Float.parseFloat(tmp);
    } catch(Exception ex)
    {ex.printStackTrace();}
  }
  obj.setTee(d,g);
  if(nexturl!=null)
  {
    out.print("<script>alert('信息修改成功!');window.returnValue=1;window.close();</script>");
  }else
  {
    response.sendRedirect("/jsp/info/Succeed.jsp");
  }
  return;
}

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script>
function f_submit()
{
  var arr=document.getElementsByTagName("INPUT");
  for(var i=0;i<arr.length;i++)
  {
    if(arr[i].type=="text")
    {
      if(!submitText(arr[i],"不能为空!"))
      {
        return false;
      }
    }
  }
  return true;
}
</script>
</head>
<body>
<h1>发球台</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" method="post" action="?" onsubmit="return f_submit()">
<input type="hidden" name="gsid" value="<%=gsid%>"/>

<%
if(nexturl!=null)out.print("<input type=hidden name=nexturl value=\""+nexturl+"\"/>");
%>
<h2>场地：<%=obj.getGsname()%></h2> 
<table cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>发球台</td>
    <td><img src="/tea/image/score/01.jpg" width="12" height="12"></td>
    <td><img src="/tea/image/score/02.jpg" width="12" height="12"></td>
    <td><img src="/tea/image/score/03.jpg" width="12" height="12"></td>
    <td><img src="/tea/image/score/04.jpg" width="12" height="12"></td>
    <td><img src="/tea/image/score/05.jpg" width="12" height="12"></td>
  </tr>
  <tr>
    <td>难度系数:</td>
    <td><input name="difficulty0" type="text" id="difficulty0" value="<%=d[0]%>" size="8" mask="float"></td>
    <td><input name="difficulty1" type="text" id="difficulty1" value="<%=d[1]%>" size="8" mask="float"></td>
    <td><input name="difficulty2" type="text" id="difficulty2" value="<%=d[2]%>" size="8" mask="float"></td>
    <td><input name="difficulty3" type="text" id="difficulty3" value="<%=d[3]%>" size="8" mask="float"></td>
    <td><input name="difficulty4" type="text" id="difficulty4" value="<%=d[4]%>" size="8" mask="float"></td>
  </tr>
  <tr>
    <td>坡度系数: </td>
    <td><input name="gradient0" type="text" id="gradient0" value="<%=g[0]%>" size="8" mask="float"></td>
    <td><input name="gradient1" type="text" id="gradient1" value="<%=g[1]%>" size="8" mask="float"></td>
    <td><input name="gradient2" type="text" id="gradient2" value="<%=g[2]%>" size="8" mask="float"></td>
    <td><input name="gradient3" type="text" id="gradient3" value="<%=g[3]%>" size="8" mask="float"></td>
    <td><input name="gradient4" type="text" id="gradient4" value="<%=g[4]%>" size="8" mask="float"></td>
  </tr>
</table> 
<input type="submit" value="提交">
<input type="button" value="重置" onclick="clearFrom(document.form1)">
	<input type="button" value="返回" onclick="window.close();">
</form>
</body>
</html>
