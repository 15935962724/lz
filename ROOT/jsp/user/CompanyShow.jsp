<%@page contentType="text/html;charset=UTF-8" import="java.util.*" %>
<%@page import="tea.html.*" %>
<%@ page import="tea.htmlx.Languages"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.entity.site.*" %>
<%@page import="tea.entity.node.*" %>
<%@ page import="tea.http.RequestHelper"%>
<%@ page import = "tea.resource.Resource" %>
<%@ page import = "tea.entity.node.Sms" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="java.io.*" %>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.util.*"%>
<%
//            if(!node.isCreator(teasession._rv))
//            {
//                response.sendError(403);
//                return;
//            }
TeaSession teasession = new TeaSession(request);
Resource r = new Resource();
boolean _bNew=request.getParameter("NewNode")!=null;
r.add("/tea/resource/Company");
int node = 0;
if(teasession.getParameter("node")!=null && teasession.getParameter("node").length()>0)
  node = Integer.parseInt(teasession.getParameter("node"));

String nexturl = teasession.getParameter("nexturl");
String role = teasession.getParameter("role");

  Node n = Node.find(node);
  Company c = Company.find(node);

  if("auditing".equals(teasession.getParameter("act")))//审核
  {
    int type = 0;
    if(teasession.getParameter("type")!=null && teasession.getParameter("type").length()>0)
    {
      if(Integer.parseInt(teasession.getParameter("type"))==0)//同意
      {
        n.setHidden(false);

      } else//不同意
      {
        n.setHidden(true);
      }
    }
     out.print("<script>alert('企业审核成功!');</script>");
     out.println("<script type='text/javascript'>self.location='"+nexturl+"'</script>");
     return;
  }
%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/card.js" type="text/javascript"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body >


<h1>公司审核查看</h1>
<div id="head6"><img height="6" src="about:blank"></div>


<FORM    name=form1 METHOD=POST action="?" onSubmit="return CheckForm();">
<input type="hidden" name="node" value="<%=node%>">
<input type="hidden" name="nexturl" value="<%=nexturl%>">
<input type="hidden" name="role" value="<%=role%>"/>
<input type="hidden" name="act" value="auditing"/>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td>企业名称</td>
      <td><%=n.getSubject(teasession._nLanguage) %></td>
    </tr>
    <tr>
      <td>所属行业</td>
<td><%
  Node n1 = Node.find(n.getFather());
  Node n2 = Node.find(n1.getFather());
  out.print(n1.getSubject(teasession._nLanguage)+"&nbsp;");
  out.print(n2.getSubject(teasession._nLanguage));
  %></td>
    </tr>
     <tr>
      <td>所属地区</td>
<td><%= Card.find(c.getCity(teasession._nLanguage)).toString() %></td>
    </tr>
     <tr>
      <td>企业地址</td>
      <td><%=c.getAddress(teasession._nLanguage) %></td>
    </tr>

      <tr>
      <td>邮&nbsp;&nbsp;编</td>
      <td><%=c.getZip(teasession._nLanguage)%></td>
    </tr>
       <tr>
      <td>企业网址</td>
      <td><%=c.getWebPage(teasession._nLanguage)%></td>
    </tr>
      <tr>
      <td>网站说明</td>
      <td><%=c.getCountry(teasession._nLanguage)%></td>
    </tr>
     <tr>
      <td>图片上传:</td>
      <td><%
         if(c.getLicense(teasession._nLanguage)!=null && c.getLicense(teasession._nLanguage).length()>0){
            out.print("<a href ="+c.getLicense(teasession._nLanguage)+" target=_blank>企业图片</a>");
         }
        else{
           out.print("暂无图片");
        }
      %></td>
    </tr>
     <tr>
      <td>联系人:</td>
      <td><%=c .getContact(teasession._nLanguage)%></td>
    </tr>

 <tr>
      <td>电&nbsp;&nbsp;话</td>
      <td><%=c.getTelephone(teasession._nLanguage)%></td>
    </tr>

     <tr>
      <td>传&nbsp;&nbsp;真</td>
      <td><%=c.getFax(teasession._nLanguage) %></td>
    </tr>
     <tr>
      <td>邮&nbsp;&nbsp;箱</td>
      <td><%=c.getEmail(teasession._nLanguage)%></td>
    </tr>

     <tr>
      <td>企业简介</td>
      <td><%=n.getText(teasession._nLanguage)%></td>
    </tr>
     <tr>
      <td colspan="3">
        <input type="radio" name="type" value="0"/>同意&nbsp;&nbsp;
       <input type="radio" name ="type" value="1" checked="checked"/>不同意
</td>
    </tr>
  </table>
<input type="submit" value=" 提 交 ">
<input type=button value="返回" onClick="javascript:history.back()">
</FORM>





<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>
