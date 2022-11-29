<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="java.util.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.ui.*"%>
<%
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource();

String nexturl=request.getParameter("nexturl");
int role=Integer.parseInt(request.getParameter("role"));

Calendar ca=Calendar.getInstance();
ca.add(Calendar.YEAR,1);
Date time=ca.getTime();

Node n=Node.find(teasession._nNode);
String com=n.getCreator()._strV;
Profile p=Profile.find(com);
if("POST".equals(request.getMethod()))
{
  Date stop=Community.sdf.parse(teasession.getParameter("timeYear")+"-"+teasession.getParameter("timeMonth")+"-"+teasession.getParameter("timeDay"));
  String domain=request.getParameter("domain");
  ///
  String sub=n.getSubject(teasession._nLanguage);
  Community cobj=Community.find(teasession._strCommunity);
  int root=Community.create(com,1,com,1,sub,cobj.getTerm(teasession._nLanguage),cobj.getWelcome(teasession._nLanguage),null,cobj.getEmail(),cobj.getSmtp(),cobj.getSmtpName(),cobj.getSmtpUser(),cobj.getSmtpPassword(),cobj.getCss(),cobj.filtrate,false,false,false,cobj.getMailBefore(teasession._nLanguage),cobj.getMailAfter(teasession._nLanguage),cobj.getJspBefore(teasession._nLanguage),cobj.getJspAfter(teasession._nLanguage),null,"",null);
  //Node.create(0,0,com,n.getCreator(),0,false,0,0,1,null,null,new Date(),0,0,0,0,null,null,1,sub,null,null,null,null,0,null,null,null,null,null,null,null);
  Company obj = Company.find(root);
  obj.set(1,"","","","",0,"","","","","","","","");
  int f34=Node.create(root,0,com,n.getCreator(),0,false,1325957184,0,1,null,null,new Date(),0,0,0,0,null,null,1,"商品",null,null,null,null,0,null,null,null,null,null,null,null);
  int nid=Node.create(f34,0,com,n.getCreator(),1,false,1325957184,0,1,null,null,new Date(),0,0,0,0,null,null,1,"我的分类",null,null,null,null,0,null,null,null,null,null,null,null);
  Category.find(nid).set(34,0,0,null);
  int cs[]={39,50,73,78,87};
  for(int i=0;i<cs.length;i++)
  {
    nid=Node.create(root,0,com,n.getCreator(),1,false,0,0,1,null,null,new Date(),0,0,0,0,null,null,1,"",null,null,null,null,0,null,null,null,null,null,null,null);
    Category.find(nid).set(cs[i],0,0,null);
  }
  //
  AdminUsrRole aur=AdminUsrRole.find(teasession._strCommunity,com);
  aur.setRole(aur.getRole()+role+"/");
  Organizer.create(com,com);
  AccessMember.create(root,com,com,2,3,true,"/1/21/34/39/50/73/78/87/","/34/39/50/73/78/87/");
  //
  Community c=Community.find(com);
  c.setStopTime(stop);
  //
  DNS.find(domain).set(com,teasession._nStatus,"/jsp/type/company/windows/",root,true);//
  //
  response.sendRedirect(nexturl);
  return;
}

String domain=request.getServerName();
Enumeration e=DNS.findByCommunity("Home",teasession._nStatus);
if(e.hasMoreElements())
{
  domain=(String)e.nextElement();
}
String suffix=domain.substring(domain.indexOf('.'));

if(domain.startsWith("www."))
{
  domain=domain.substring(3);
}
domain=p.getProfile()+domain;


%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body onLoad="form1.domain.focus();">
<h1><%=r.getString(teasession._nLanguage, "未开通第一站的企业")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="?" method="POST" onSubmit="">
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>">
  <input type="hidden" name="node" value="<%=teasession._nNode%>">
  <input type="hidden" name="nexturl" value="<%=nexturl%>">
  <input type="hidden" name="domain" value="<%=domain%>">
  <input type="hidden" name="role" value="<%=role%>">

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td>名称:</td>
      <td><%=n.getSubject(teasession._nLanguage)%></td>
    </tr>
    <tr>
      <td>会员:</td>
      <td><%=n.getCreator()%></td>
    </tr>
    <tr>
      <td>有效期:</td>
      <td><%=new tea.htmlx.TimeSelection("time",time)%></td>
    </tr>
    <tr>
      <td>将开通域名:</td>
      <td>该第一站将开通的域名是：<%=domain%>
    </tr>
<!--
    <tr>
      <td>企业自有域名:</td>
      <td><p>
        <input name="domain" type="text" size="40">
        <br>
        如果该企业注册过域名，请在此指定，如：www<%=suffix%><br>
        并把域名的DNS服务器设置为：ns<%=suffix%></p>
      </td>
    </tr>
-->
    <tr>
      <td>金额:</td>
      <td><input type="text" name="charges"></td>
        <tr>
          <td></td>
          <td>
            <input type="submit" value="提交">
            <input type="button" value="返回" onClick="history.back()">
          </td>
        </tr>
  </table>
</form>

<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
