<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
r.add("/tea/resource/TypePicture");
          if(!node.isCreator(teasession._rv))
            {
                 response.sendError(403);
                return;
            }
int id=0;
if(request.getParameter("id")!=null)
id=Integer.parseInt( request.getParameter("id"));
TypePicture typePicture=TypePicture.findByPrimaryKey(id);
           //  TypePicture typePicture[]=TypePicture.findNode(teasession._nNode);
		   String act=request.getParameter("act");
		   if(act==null)
		   act="";
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Pictureview")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"> <%=node.getAncestor(teasession._nLanguage)%></div>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr ID=tableonetr>
    <td><%=r.getString(teasession._nLanguage, "Picture")%></td>
    <td><%=r.getString(teasession._nLanguage, "Path")%></td>
    <td><%=r.getString(teasession._nLanguage, "PictureName")%></td>
    <td>&nbsp;</td>
  </tr>
  <%
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT id,picturePath,pictureName  FROM TypePicture WHERE node=" + teasession._nNode+" order by id asc");
            if(dbadapter.next())
            {{%>
  <tr>
    <td><%=new String(dbadapter.getString(3).getBytes("ISO-8859-1"))%></td>
    <td><%
    java.io.File file=new java.io.File(application.getRealPath("/tea/image/type/"+dbadapter.getString(1)+act+".gif"));
    if(file.exists())
    out.print(new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date(file.lastModified())));
    %></td>
    <td><input type="button" value="<%=r.getString(teasession._nLanguage, "Edit")%>" onclick="window.open('TypePicture.jsp?node=<%=teasession._nNode%>&id=<%=dbadapter.getString(1)%>','_self')" >
      <input type="button" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDeleteTree")%>')){window.open('/servlet/TypePicture?node=<%=teasession._nNode%>&id=<%=dbadapter.getString(1)%>&delete=ON', '_self');}" value="<%=r.getString(teasession._nLanguage, "Delete")%>"></td>
  </tr>
  <%            }}
        } catch (Exception ex)
        {
            ex.printStackTrace();
        } finally
        {
            dbadapter.close();
        }%>
  <%--for(int i=0;typePicture!=null &&i< typePicture.length;i++)
{%>
  <tr>
    <td><img src="<%=getServletContext().getRealPath(typePicture[i].getPicturePath())%>" width="109" height="73"></td>
    <td><%=typePicture[i].getPicturePath()%></td>
    <td><%=typePicture[i].getPictureName()%></td>
    <td><input type="button" value="<%=r.getString(teasession._nLanguage, "Edit")%>"><input type="button" value="<%=r.getString(teasession._nLanguage, "Delete")%>"></td>
  </tr>
<%
}
  --%>
</table>
<form name="form1" method="post" action="/servlet/TypePicture"  ENCtype=multipart/form-data >
  <input type="hidden" value="<%=teasession._nNode%>" name="node"/>
  <input type="hidden" value="<%=id%>" name="id"/>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Picture")%>:</td>
      <td><input name="picture" type="file">
&nbsp;</td>
    </tr>
    <tr>
      <td>大<%=r.getString(teasession._nLanguage, "Picture")%>:</td>
      <td><input name="<%=act%>picture" type="file">
&nbsp;</td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "PictureName")%>:</td>
      <td><input type="text" name="pictureName" value="<%=typePicture.getPictureName()%>"></td>
    </tr>
  </table>
  <input name="Input" type="submit" value="<%=r.getString(teasession._nLanguage,"Submit")%>">
</form>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

