<%@page contentType="text/html;charset=UTF-8"  %>
<%@page import="tea.entity.node.*" %><%@page import="tea.entity.*" %>
<%@page import="tea.resource.Resource" %>
<%@page import="java.util.*" %>
<%@page import="tea.db.*" %>
<%
Http h=new Http(request,response);
response.setHeader("Cache-Control","no-cache");
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community+"&nexturl="+Http.enc(request.getRequestURI()+"?"+request.getQueryString()));
  return;
}

int media =Integer.parseInt(h.get("media"));
int type=Integer.parseInt(request.getParameter("type"));
String name=null,logo=null,url=null;
int len=0;
if (media>0)
{
  Media obj=Media.find(media);
  name=obj.getName(h.language);
  logo=obj.getLogo(h.language);
  url=obj.getUrl(h.language);
  if(logo!=null&&logo.length()>0)
  {
    len=(int)new java.io.File(application.getRealPath(logo)).length();
  }
}

Resource r = new Resource("/tea/resource/Media");
String title=r.getString(h.language, "EditMedia");

%>
<html>
<head>
<title><%=title%></title>
<base target="dialog"/>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body onload="form1.name.focus();">
<h1><%=title%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<FORM NAME=form1 METHOD=POST action="/servlet/EditMedia" target="_ajax" ENCTYPE=multipart/form-data onsubmit="return submitText(this.name,'<%=r.getString(h.language, "Media")%>');">
<input type="hidden" name="community" value="<%=h.community%>">
<input type="hidden" name="nexturl" value="<%=request.getParameter("nexturl")%>">
<input type="hidden" name="media" value="<%=media%>">
<input type="hidden" name="type" value="<%=type%>">

<table id="tablecenter">
  <tr>
    <td ID=RowHeader><%=r.getString(h.language, "Media")%>:</td>
    <td><input type=TEXT name="name" value="<%=MT.f(name)%>" size="40"></td>
  </tr>
  <tr>
    <td ID=RowHeader><%=r.getString(h.language, "Picture")%>:</td>
    <td COLSPAN=6>
      <input type=FILE name=picture>
      <%
      if(len>0)
      {
        out.print("<a href="+logo+" target=_blank>"+len+ r.getString(h.language, "Bytes")+"</a>");
        out.print("<input type=checkbox name=clear onclick='form1.picture.disabled=this.checked'>"+r.getString(h.language, "Clear"));
      }
      %>
      </td>
  </tr>
  <tr>
    <td ID=RowHeader>网址:</td>
    <td><input type=TEXT name="url" value="<%=MT.f(url)%>" size="40"></td>
  </tr>
</TABLE>


<input type=SUBMIT value="<%=r.getString(h.language, "Finish")%>">
<input type=button onClick="window.open('<%=h.get("nexturl")%>','dialog')" value="<%=r.getString(h.language,"返回")%>">

</FORM>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(h.language,request)%></div>
</body>
</html>
