<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
Blog blog=Blog.find(node.getCommunity(),teasession._rv._strR);
node=Node.find(blog.getHome());
if(request.getMethod().equals("POST"))
{
    CssJs cssjs_obj=CssJs.find(Integer.parseInt(teasession.getParameter("cssJs")));
    String css=request.getParameter("css");
    String js=request.getParameter("js");
    tea.db.DbAdapter dbadapter=new tea.db.DbAdapter();
    try
    {
      dbadapter.executeQuery("SELECT TOP 1 CssJs.cssjs FROM CssJs WHERE CssJs.node="+node._nNode);
      if(dbadapter.next())
      {
        int cssjs=dbadapter.getInt(1);
        CssJs cj_obj=CssJs.find(cssjs);
        //cj_obj.set(2,node._nNode,3,teasession._nLanguage,"",css,js);
        cj_obj.set(2,node._nNode,3,false,"",teasession._nLanguage,"",css,js);
      }else
      {
        //CssJs.create(0,2,255,3,node._nNode,teasession._nLanguage,css,js,"");
        CssJs.create(0,2,255,3,node._nNode,false,"",teasession._nLanguage,"",css,js);
        dbadapter.executeUpdate("CssJsHiden " + cssjs_obj.getCssJs() + ", " + node._nNode + ", " + 0);//0 在本树隐藏
      }
      out.print(new tea.html.Script("alert('修改成功');history.back();"));
      return;
    }catch(Exception e)
    {
      e.printStackTrace();
    }finally
    {
      dbadapter.close();
    }
}
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "CSS/JS")%></h1>
<div id="head6"><img height="6" alt=""></div>
<%
    tea.db.DbAdapter dbadapter=new tea.db.DbAdapter();
    try
    {
      CssJs cj_obj=null; int cssjs=0;
      dbadapter.executeQuery("SELECT TOP 1 CssJs.cssjs FROM CssJs WHERE CssJs.node="+blog.getHome());
      if(dbadapter.next())
      {
         cssjs=dbadapter.getInt(1);
        cj_obj=CssJs.find(cssjs);
      }else
      {
         dbadapter.executeQuery("SELECT TOP 1 CssJs.cssjs FROM CssJs WHERE CssJs.node=" + Node.find(blog.getHome()).getFather() + " AND style=2");
         if (dbadapter.next())
         {
           cssjs = dbadapter.getInt(1);
           cj_obj = CssJs.find(cssjs);
         }
      }
%>
<form name="form1" method="post" action="<%=request.getRequestURI()%>">
  <input type=hidden name=node value="<%=node._nNode%>">
  <input type=hidden name=cssJs value="<%=cssjs%>">

<table  border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr ID=tableonetr>
      <td hu="hu" colspan="20">CSS\JS DIY</td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage,"Edit")%>CSS:</td>
      <td><textarea  class="edit_input" name="css" cols="80" rows="12"><%if(cj_obj!=null&&cj_obj.isExists())out.print(cj_obj.getCss(teasession._nLanguage));%></textarea>
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage,"Edit")%>JS:</td>
      <td> <textarea class="edit_input"  name="js" cols="80" rows="12"><%if(cj_obj!=null&&cj_obj.isExists())out.print(cj_obj.getJs(teasession._nLanguage));%>
</textarea> </td>
    </tr>
  </table>
  <input type="hidden" name="style" VALUE=2 >
  <input type="hidden" NAME=hiden VALUE=3 >
  <input type="hidden" NAME=name VALUE="" >
  <input type="button" name="Pictureview" id="Pictureview" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Pictureview")%>" onClick="window.open('/servlet/InsertPicture?node=<%=teasession._nNode%>', '_blank');">
  <input type="SUBMIT" id="edit_submit" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Submit")%>">
</form>
<%
    }catch(Exception e)
    {
      e.printStackTrace();
    }finally
    {
      dbadapter.close();
    }
%>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

