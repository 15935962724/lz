<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@ page  import="java.util.*" %><%@ page  import="tea.entity.node.*" %><%@ page  import="tea.entity.bbs.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
String act=teasession.getParameter("act");
String nexturl=teasession.getParameter("nexturl");
int bbslevel=Integer.parseInt(teasession.getParameter("bbslevel"));


if("POST".equals(request.getMethod()))
{
  if("def".equals(act))
  {
    BBSLevel.create(teasession._strCommunity);
  }else if("del".equals(act))
  {
    BBSLevel.delete(bbslevel);
  }else
  {
    String name=teasession.getParameter("name");
    int point=Integer.parseInt(teasession.getParameter("point"));
    String picture=teasession.getParameter("picture");
    if(picture==null)picture=teasession.getParameter("file");
    Enumeration e=BBSLevel.find(" AND community="+DbAdapter.cite(teasession._strCommunity)+" AND bbslevel!="+bbslevel+" AND(name="+DbAdapter.cite(name)+" OR point="+point+")",0,1);
    if(e.hasMoreElements())
    {
      out.print("<script>alert('名称或积分重复!');history.back();</script>");
      return;
    }
    if(bbslevel==0)
    {
      BBSLevel.create(teasession._strCommunity,name,picture,point);
    }else
    {
      BBSLevel.set(bbslevel,name,picture,point);
    }
  }
  response.sendRedirect(nexturl);
  return;
}

Resource r=new Resource();

String name=null,picture="/tea/image/bbslevel/null.gif";
int point=0;
Enumeration e=BBSLevel.find(" AND bbslevel="+bbslevel,0,1);
if(e.hasMoreElements())
{
  BBSLevel bt=(BBSLevel)e.nextElement();
  name=bt.getName();
  picture=bt.getPicture();
  point=bt.getPoint();
}

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script>
function f_sel(re)
{
  var isSel=re=='';
  if(isSel)re=window.showModalDialog('/jsp/type/bbs/SelBBSLevelPic.jsp',self,'dialogWidth:280px;dialogHeight:400px;');
  if(re)
  {
    $('view').src=re;
    form1.picture.value=re;
    form1.picture.disabled=!isSel;
  }
}
</script>
</head>
<body onload="form1.name.focus();">

<h1>添加/编辑 论坛等级</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<form name="form1" method="post" action="?" enctype="multipart/form-data" onsubmit="return submitText(this.name,'无效-名称')&&submitInteger(this.point,'无效-积分');">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="act" >
<input type="hidden" name="nexturl" value="<%=nexturl%>" >
<input type="hidden" name="bbslevel" value="<%=bbslevel%>">
<input type="hidden" name="picture" disabled="disabled">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>名称:</td>
    <td><input name="name" value="<%if(name!=null)out.print(name);%>"></td>
  </tr>
  <tr>
    <td>积分下限:</td>
    <td><input name="point" value="<%if(point>0)out.print(point);%>" mask="int"></td>
  </tr>
  <tr>
    <td>图标:</td>
    <td><input type="button" value="选择现有" onclick="f_sel('')"/>
      <input type="button" value="自 定 义" style="position:absolute"><input type="file" name="file" style="position:absolute;width:10;cursor:hand;filter:Alpha(opacity=0)" onchange="f_sel(value);"/>
      <br>
      <img id="view" src="<%=picture%>"/>
    </td>
  </tr>
</table>

<input type="submit" value="<%=r.getString(teasession._nLanguage,"CBSubmit")%>">
<input type="button" value="<%=r.getString(teasession._nLanguage,"CBBack")%>" onclick="history.back();">
</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
