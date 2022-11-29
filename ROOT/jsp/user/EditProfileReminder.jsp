<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.resource.Resource" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=teasession._strCommunity;

ProfileBBS pb=ProfileBBS.find(teasession._strCommunity,teasession._rv._strV);

if(request.getMethod().equals("POST")||request.getParameter("delete")!=null)
{
  boolean message=Boolean.parseBoolean(request.getParameter("message"));
  int callsound=Integer.parseInt(request.getParameter("callsound"));
  pb.set(message,callsound);

  response.sendRedirect("/jsp/info/Succeed.jsp");
  return;
}


Resource r=new Resource();



%><html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script>
function defaultfocus()
{
  form1.callsound.focus();
}
</script>
</head>
<body onLoad="defaultfocus();">

<h1>短信息提醒设置</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
<form name="form1" action="<%=request.getRequestURI()%>" method="post" >
<input type=hidden name="community" value="<%=community%>"/>

     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
       <tr>
        <td>短信息提醒窗口弹出方式</td>
         <td nowrap><input name="message" type="radio" value="true" checked>是 <input name="message" type="radio" value="false" <%if(!pb.isMessage())out.print("checked");%> >否</td>
       </tr>
       <tr>
         <td>短信息提示音</td>
         <td nowrap><select name="callsound">
           <%
           for(int index=0;index<ProfileBBS.CALL_SOUND.length;index++)
           {
            out.print("<option value="+index);
            if(index==pb.getCallSound())
            out.println(" SELECTED ");
            out.println(" >"+ProfileBBS.CALL_SOUND[index]);
           }
           %></select>
         </td>
       </tr>
  </table>
           <input type="submit" value="提交">
           <input type="reset" value="重置" onClick="defaultfocus();">
</form>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

