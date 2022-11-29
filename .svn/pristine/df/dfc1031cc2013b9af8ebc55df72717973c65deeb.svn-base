<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%

String s = request.getParameter("community");
if(s==null)
s=node.getCommunity();

tea.entity.site.DCommunity dc=  tea.entity.site.DCommunity.find(s);
if(request.getMethod().equals("POST"))
{
  int nodex=Integer.parseInt(request.getParameter("nodex"));
  if(dc.isExists())
  {
    dc.set(nodex);
  }else
  {
    dc.create(s,nodex);
  }
  response.sendRedirect("/jsp/info/Succeed.jsp");
  return;
}

String info=request.getParameter("info");
if(info==null)
info=r.getString(teasession._nLanguage, "合同模板类别");

%>
<html>
<head>
<link href="/res/<%=s%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="">
function fc(obj)
{
  obj.value=parseInt(obj.value);
  if(isNaN(obj.value))
  {
    obj.value=0;
  }
}
</script>
</head>
<body onLoad="form111_NET.nodex.focus();">

   <h1><%=info%></h1>
   <div id="head6"><img height="6" alt=""></div>
   <br>
   <FORM name="form111_NET" METHOD=POST action="" onSubmit="return(submitInteger(this.nodex,'<%=r.getString(teasession._nLanguage, "InvlaidNode")%>'));">
     <input type=hidden name="community" value="<%=s%>" />
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
       <tr>
         <td><%=r.getString(teasession._nLanguage, "Node")%>:</td>
         <td><input type="text" name=nodex onKeyUp="fc(this);" value="<%=dc.getNode()%>" > </td>
       </tr>
     </table>
     <input type="submit" value="<%=r.getString(teasession._nLanguage, "Submit")%>"/>
   </FORM>

<br>
<div id="head6"><img height="6" alt=""></div>

<%--<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>

</body>
</html>


