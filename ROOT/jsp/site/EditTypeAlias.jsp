<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.resource.Resource" %><%@ page import="tea.ui.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.entity.site.*" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+request.getRequestURI()+"?"+request.getQueryString());
  return;
}

if(!teasession._rv.isReal())
{
  response.sendError(403);
  return;
}

String community=request.getParameter("community");

CLicense cl=CLicense.find(community);
String licensetype= cl.getType();
String nts[]=licensetype.split("/");

Resource r=new Resource();

int typealias = Integer.parseInt(teasession.getParameter("typealias"));

int type = 2;
String name =null,alt =null,picture=null;
int picturelen=0;
if(typealias>0)
{
  TypeAlias obj = TypeAlias.find(typealias);
  type = obj.getType();
  name = obj.getName(teasession._nLanguage);
  alt = obj.getAlt(teasession._nLanguage);
  picture=obj.getPicture(teasession._nLanguage);
  if(picture!=null&&picture.length()>0)
  {
    picturelen=(int)new java.io.File(application.getRealPath(picture)).length();
  }
}else
{
  if(nts.length>1)
  {
    type= Integer.parseInt(nts[1]);
  }
}

%>
<html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "New")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<FORM name=form1 METHOD=POST action="/servlet/EditTypeAlias" ENCtype="multipart/form-data" onsubmit="return mt.check(this);">
<input type='hidden' name="community" VALUE="<%=community%>">
<input type='hidden' name="typealias" VALUE="<%=typealias%>">

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td nowrap><%=r.getString(teasession._nLanguage,"Type")%>:</td>
      <td><table>
      <%
      for(int len=1;len<nts.length;len++)
      {
        int j=Integer.parseInt(nts[len]);
        if((len-1)%8==0)out.print("<tr>");
        out.print("<td><input type=radio name=type value="+nts[len]);
        if(j==type)out.print(" CHECKED ");
        out.print(" />");
        if(j<1024)
        {
          out.print(r.getString(teasession._nLanguage,Node.NODE_TYPE[j]));
        }else
        {
          Dynamic dynamic = Dynamic.find(j);
          out.print(dynamic.getName(teasession._nLanguage));
        }
      }
      %></table></td>
    </tr>
    <tr>
      <td nowrap><%=r.getString(teasession._nLanguage,"Name")%>:</td>
      <td><input type="TEXT" class="edit_input"  name="name" VALUE="<%if(name!=null)out.print(name);%>" alt="<%=r.getString(teasession._nLanguage,"Name")%>"></td>
    </tr>
    <tr>
      <td nowrap><%=r.getString(teasession._nLanguage, "Picture")%>:</td>
      <td COLSPAN=6><input type="file" name="picture" class="edit_input" />
      <%
      if(picturelen>0)
      {
        out.print("<a href="+picture+" target=_blank>"+picturelen + r.getString(teasession._nLanguage, "Bytes")+"</a>");
        out.print("<input id=CHECKBOX type=CHECKBOX name=clear onclick=form1.picture.disabled=checked;>"+r.getString(teasession._nLanguage, "Clear"));
      }
      %>
      </td>
    </tr>
    <tr>
      <td nowrap><%=r.getString(teasession._nLanguage, "Alt")%>:</td>
      <td><input type="TEXT" class="edit_input" name="alt" VALUE="<%if(alt!=null)out.print(alt);%>"></td>
    </tr>
    <tr>
      <td nowrap>&nbsp;</td>
      <td>
        <input type="submit" class="edit_button" id="edit_submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>">
        <input type="button" onclick="javascript:window.history.back();" value="<%=r.getString(teasession._nLanguage, "CBBack")%>"/>
      </td>
    </tr>
  </table>
</FORM>

<SCRIPT>document.form1.name.focus();</SCRIPT>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
