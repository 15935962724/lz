<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
r.add("/tea/resource/Dynamic");
String community=node.getCommunity();
%>
<html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/tea/tea.js" type="text/javascript"></script>

</head>
<body onLoad="form1.subject.focus();">
<!--
<h1><%=r.getString(teasession._nLanguage, "BargainManage")%></h1>
-->
<div id="head6"><img height="6" src="about:blank"></div>
<!-- <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>-->
<form name=form1 action="/servlet/EditDynamicValue" method="post" enctype=multipart/form-data onSubmit="javascript:return fcheck();">
  <%
    String parameter=teasession.getParameter("nexturl");
    boolean parambool=(parameter!=null&&!parameter.equals("null"));
    if(parambool)
    out.print("<input type='hidden' name=nexturl value="+parameter+">");
int type;
    String subject="";
    String keywords="";
    Date issueDate=null;
    String text="";
   long lensmaill=0,lenbig=0,lenrecommend=0;
   if(request.getParameter("NewNode")!=null)
   {
     out.println("<INPUT TYPE=hidden NAME=NewNode VALUE=ON>");
     type=Integer.parseInt(request.getParameter("Type"));
   }else
   {
     subject=node.getSubject(teasession._nLanguage);
     keywords=node.getKeywords(teasession._nLanguage);
     issueDate=node.getTime();
     text=HtmlElement.htmlToText(node.getText(teasession._nLanguage));
     type=node.getType();
   }
   StringBuffer sbcheck=new StringBuffer();



            %>
  <input type="hidden" name="Node" value="<%=teasession._nNode%>">
  <input type="hidden" name="EditCebbankDynamicValue" value="<%=session.getId()%>">
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td><%=r.getString(teasession._nLanguage, "FileName")%>:</td>
      <td nowrap class=huititable ><input name="subject" class="edit_input" onKeyDown="if(event.keyCode==13){event.keyCode=9;}" type="text" value="<%=subject%>" size="25" maxlength="100">
      </td>
    </tr>

    <%
    if(type!=1025)
   {
     out.print("<tr id=dynamicvalue_mainbargain ><td>"+r.getString(teasession._nLanguage, "MainBargain")+":</td><td nowrap class=huititable >");
     tea.html.DropDown select=new tea.html.DropDown("keywords",keywords);
     select.addOption("","-----------");/*
     java.util.Enumeration enumer=tea.entity.node.Node.findByType(1025,community);
     while(enumer.hasMoreElements())
     {
       int nodeid=((Integer)enumer.nextElement()).intValue();
       tea.entity.node.Node nodeobj=tea.entity.node.Node.find(nodeid);
       select.addOption(nodeid,nodeobj.getSubject(teasession._nLanguage));
     }
    */
     DbAdapter dbadapter = new DbAdapter();
     try
     {
       dbadapter.executeQuery("SELECT n.node FROM Node n WHERE n.type=1025 AND n.rcreator="+dbadapter.cite(teasession._rv._strR));
       if (dbadapter.next())
       {
         int nodeid=dbadapter.getInt(1);
         tea.entity.node.Node nodeobj=tea.entity.node.Node.find(nodeid);
         select.addOption(nodeid,nodeobj.getSubject(teasession._nLanguage));
       }
     } catch (Exception exception)
     {
       exception.printStackTrace();
     } finally
     {
       dbadapter.close();
     }
     out.print(select.toString());
     out.print("</td></tr>");
     sbcheck.append("&&submitSelect(form1.keywords, '"+r.getString(teasession._nLanguage, "InvalidSelect")+"')");
   }%>

       <tr style="display:none ">
         <td><%=r.getString(teasession._nLanguage,"Time")%>:</td>
    <td nowrap class=huititable  ><%=new TimeSelection("Issue", issueDate)%> </td>
    </tr>
  </table >
  <%
           java.util.Enumeration enumeration=DynamicType.findByDynamic(type);
        int id=0;
     while(enumeration.hasMoreElements())
     {
       id=((Integer)enumeration.nextElement()).intValue();
       tea.entity.site.DynamicType obj=tea.entity.site.DynamicType.find(id);
       if(obj.isHidden())
       {
    %>
  <%
           if(obj.isNeed())
         {
           sbcheck.append("&&submitText(form1.dynamictype"+id+", '"+r.getString(teasession._nLanguage, "InvalidParameter")+"-"+obj.getName(teasession._nLanguage)+"')");
           out.print("*&#12288;");
         }
         //out.print(obj.getName(teasession._nLanguage));
         %><%=obj.getText(application,r,teasession._nNode,teasession._nLanguage)%>
  <%}
        }%>
  <script type="">
        function fcheck()
        {
          return submitText(form1.subject, '<%=r.getString(teasession._nLanguage, "InvalidSubject")%>')<%=sbcheck.toString()%>;
        }
        </script>
  <div align="center">
    <!--INPUT TYPE=SUBMIT NAME="GoBack"  ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Super")%>"-->
    <INPUT TYPE=SUBMIT NAME="GoSave"  ID="EditCebbankDynamicValue_GoSave" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "CBSave")%>">
    <INPUT TYPE=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "CBFinishedUp")%>">
  </div>
</form>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

