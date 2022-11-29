<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.resource.*"%><%@ page import="tea.entity.node.*"%>
<%request.setCharacterEncoding("UTF-8");
String community=request.getParameter("community");
if(community==null)
community="Home";
tea.ui.TeaSession teasession = new tea.ui.TeaSession(request);
int language=255;

//tea.entity.node.Node node=tea.entity.node.Node.find(teasession._nNode);
tea.resource.Resource r = new tea.resource.Resource();
r.add("/tea/resource/AmityLink");
if(request.getMethod().equals("POST"))
{
  String text=request.getParameter("text").replaceAll("<","&lt;").replaceAll("<","&gt;");
  String subject=request.getParameter("subject");
  String url=request.getParameter("url");
  String logo=request.getParameter("logo");
  String name=request.getParameter("name");
  String email=request.getParameter("email");
  String password=request.getParameter("password");
  boolean linkType=Boolean.valueOf(request.getParameter("LinkType")).booleanValue();
  int classes=Integer.parseInt(request.getParameter("classes"));
  int node_id;
  if (teasession.getParameter("NewNode") != null)
  {/*
    node_id=teasession._nNode;
    if (teasession._rv == null)
    {
      teasession._rv = new tea.entity.RV("ANONYMITY");
    }
    int sequence = tea.entity.node.Node.getMaxSequence(teasession._nNode) + 10;
    int options = node.getOptions(), options1 = node.getOptions1();
    String community = node.getCommunity();
    tea.entity.node.Category cat = tea.entity.node.Category.find(teasession._nNode);
    int defautllangauge = node.getDefaultLanguage();
    teasession._nNode = tea.entity.node.Node.create(teasession._nNode, sequence, community, teasession._rv, 78, cat.getTypeAlias(), (options1 & 2) != 0, options, options1, defautllangauge, null, null, teasession._nLanguage, subject, subject, text, null, "", 0, null, "", "", "", "", null);
    */
    tea.entity.node.AmityLink.create(AmityLink.getIdentity(),language,url,logo,name,email,password,linkType,classes,request.getRemoteAddr(),subject,text);
    //node.finished(teasession._nNode);
  } else
  {
    tea.entity.node.AmityLink al_obj=tea.entity.node.AmityLink.find(teasession._nNode,language);
    if(al_obj.getPassword().equals(password))
    {
      //System.out.println(new String(text.getBytes("ISO-8859-1"),"UTF-8"));
      if(request.getParameter("delete")!=null)
      {
        al_obj.delete();
      }else
      {
//        node.setText(text, teasession._nLanguage);
//        node.setSubject(subject, teasession._nLanguage);
        al_obj.set(url,logo,name,email,password,linkType,classes,request.getRemoteAddr(),subject,text);
      }
//      node_id=node.getFather();
    }else
    {
      out.print(r.getString(teasession._nLanguage,"PasswordError"));
      return;
    }
  }
//  new java.io.File(application.getRealPath("/tea/node/"+node.getCommunity()+"/N"+node_id+"L"+teasession._nLanguage+"Pnull.html")).delete();
  response.sendRedirect("/jsp/info/Succeed.jsp?info="+java.net.URLEncoder.encode(r.getString(teasession._nLanguage,"SaveSucceed")+"<br/><meta http-equiv=refresh content=3;URL=http://link.form111.net/ >","UTF-8"));
  return ;
}

%>
<html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "CBNewAmityLink")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%//=node.getAncestor(teasession._nLanguage)%> </div>
<form method="post" name="AddLink"  action="/jsp/type/amitylink/EditAmityLink2.jsp" onSubmit="return(submitText(this.subject, '<%=r.getString(teasession._nLanguage, "InvalidSubject")%>')&&submitText(this.url, '<%=r.getString(teasession._nLanguage, "URL")%>')&&submitText(this.logo, 'Logo')&&submitText(this.name, '<%=r.getString(teasession._nLanguage, "Name")%>')&&submitEmail(this.email, 'E-Mail')&&submitText(this.password, '<%=r.getString(teasession._nLanguage, "Password")%>')&&submitEqual(this.password,this.SitePwdConfirm, '<%=r.getString(teasession._nLanguage, "Password")%>'));">
  <%
boolean LinkType=false;
String subject=null,url=null,logo=null,name=null,email=null,password=null,text=null;
int classes=0;
boolean _bNew=request.getParameter("NewNode")!=null;
if(_bNew)
{
  out.print("<input type='hidden' name=NewNode value=ON>");
  logo=url="http://www.";
}else
{
  tea.entity.node.AmityLink al_obj=tea.entity.node.AmityLink.find(teasession._nNode,language);
  LinkType=al_obj.isType();
  classes=al_obj.getClasses();
  subject=al_obj.getSubject();
  url=al_obj.getUrl();
  logo=al_obj.getLogo();
  name=al_obj.getName();
  email=al_obj.getEmail();
  password=al_obj.getPassword();
  //text=tea.html.HtmlElement.htmlToText(node.getText(teasession._nLanguage));
  text=(al_obj.getContent());
}
%>
  <input type='hidden' name=Node value="<%=teasession._nNode%>">
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td align="right"><%=r.getString(teasession._nLanguage,"LinkType")%>：</td>
      <td><input name="LinkType"  id="radio" type="radio" value="true" checked >
        <%=r.getString(teasession._nLanguage,"LogoLink")%>
        <input  id="radio" type="radio" name="LinkType"  value="false" <%if(!LinkType)out.print(" checked ");%>>
        <%=r.getString(teasession._nLanguage,"CharLink")%> </td>
    </tr>
    <tr>
      <td align="right" valign="middle"><%=r.getString(teasession._nLanguage,"Subject")%>：</td>
      <td><input name="subject" title="" value="<%if(subject!=null)out.print(subject);%>" size="30"  maxlength="200">
        <font color="#FF0000"> *</font></td>
    </tr>
    <tr>
      <td align="right"><%=r.getString(teasession._nLanguage,"URL")%>：</td>
      <td><input name="url" size="30"  maxlength="50" type="text"  value="<%=url%>" title="">
        <font color="#FF0000">*</font></td>
    </tr>
    <tr>
      <td align="right">Logo：</td>
      <td><input name="logo" size="30"  maxlength="100" type="text"  value="<%=logo%>" title="">
        100 X 32 </td>
    </tr>
    <tr>
      <td align="right">E-Mail：</td>
      <td><input name="email" type="text" title="" value="<%if(email!=null)out.print(email);%>" size="30"  maxlength="80">
        <font color="#FF0000">*</font></td>
    </tr>
    <tr>
      <td align="right"><%=r.getString(teasession._nLanguage,"Username")%>：</td>
      <td><input name="name" type="text"  title="" value="<%if(name!=null)out.print(name);%>" size="30"  maxlength="50">
        <font color="#FF0000">*</font> <%=r.getString(teasession._nLanguage,"Note")%></td>
    </tr>
    <tr>
      <td align="right"><%=r.getString(teasession._nLanguage,"Password")%>：</td>
      <td><input name="password" type="password" id="SitePassword3" value="<%//if(password!=null)out.print(password);%>" size="20" maxlength="20">
        <font color="#FF0000">*</font> <%=r.getString(teasession._nLanguage,"Note")%></td>
    </tr>
    <tr>
      <td align="right"><%=r.getString(teasession._nLanguage,"ConfirmPassword")%>：</td>
      <td><input name="SitePwdConfirm" type="password" id="SitePwdConfirm" size="20" maxlength="20">
        <font color="#FF0000">*</font> </td>
    </tr>
        <tr>
      <td align="right"><%=r.getString(teasession._nLanguage,"Type")%>：</td>
      <td valign="middle">
        <%
        tea.html.DropDown dd=new tea.html.DropDown("classes",classes);
        for(int index=0;index<AmityLink.CLASSES_TYPE.length;index++)
        {
          dd.addOption(index,AmityLink.CLASSES_TYPE[index]);
        }
        out.println(dd.toString());
        %></td>
    </tr>
    <tr>
      <td align="right"><%=r.getString(teasession._nLanguage,"Text")%>：</td>
      <td valign="middle"><textarea name="text" cols="40" rows="5" id="SiteIntro" title=""><%if(text!=null)out.print(text);%>
</textarea></td>
    </tr>
    <tr>
      <td colspan="2" align="center"><input type="Submit" value="<%=r.getString(teasession._nLanguage,"Submit")%>" name="cmdOk"  onClick="">
&nbsp;
        <input type="reset" value="<%=r.getString(teasession._nLanguage,"Reset")%>" name="cmdReset">
&nbsp;
        <%if(!_bNew){%>
        <input type="Submit" value="<%=r.getString(teasession._nLanguage,"Delete")%>" name="delete"  onClick="return confirm('<%=r.getString(teasession._nLanguage,"ConfirmDelete")%>');">
        <%}%>
      </td>
    </tr>
  </table>
</form>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

