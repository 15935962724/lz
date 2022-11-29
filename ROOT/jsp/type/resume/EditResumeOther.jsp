<%@page contentType="text/html;charset=UTF-8"  %><%@page import="java.util.*" %><%@page import="tea.ui.*" %><%@page import="tea.resource.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.entity.node.*" %><%


TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

Node node=Node.find(teasession._nNode);
if(!node.isCreator(teasession._rv))
{
  response.sendError(403);
  return;
}


String community=teasession._strCommunity;


tea.resource.Resource r=new tea.resource.Resource("/tea/resource/Job");


//tea.entity.member.Profile profile =tea.entity.member.Profile.find(teasession._rv._strR);


String nexturl=request.getParameter("nexturl");


Resume obj=Resume.find(teasession._nNode,teasession._nLanguage);



%>
<HTML>
<HEAD>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
</head>
<body onload="fform111.selfvalue.focus();">
<h1><%=r.getString(teasession._nLanguage,"1167464711468")%><!--自我评价--></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="fform111" method="POST" action="/servlet/EditResume" onsubmit="return submitText(this.selfvalue,'<%=r.getString(teasession._nLanguage,"1167530814843")%>');">
<input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
<input type="hidden" name="community" value="<%=community%>"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="action" value="editresumeother"/>

 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr>
        <td  >*&nbsp;<%=r.getString(teasession._nLanguage,"1167464711468")%><!--自我评价--></td>
        <td><textarea  name="selfvalue" rows="4" cols="60" id="selfvalue"><%if(obj.getSelfvalue()!=null)out.print(obj.getSelfvalue());%></textarea>
          <br>
          <%=r.getString(teasession._nLanguage,"1167530983984")%><!--概述你的职业优势。（限200字。 <a href="javascript:alert(&quot;现已输入了&quot;+document.all['selfvalue'].value.length+&quot;个字！&quot;);">计算字数</a>）-->
          <br>
      </tr>
      <tr>
        <td ><%=r.getString(teasession._nLanguage,"1167464750687")%><!--职业目标--></td>
        <td>
          <textarea  name="selfaim" rows="7" cols="60" id="selfaim"><%if(obj.getSelfaim()!=null)out.print(obj.getSelfaim());%></textarea>
          <br>
          <%=r.getString(teasession._nLanguage,"1167531049843")%><!--让招聘单位了解你的职业方向。（限500字。<a id="linkObjectCN" href="javascript:alert(&quot;现已输入了&quot;+document.all['selfaim'].value.length+&quot;个字！&quot;);">计算字数</a>）-->
          <br>
        </td>
      </tr>
    </table>
 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr>
        <td><%=r.getString(teasession._nLanguage,"1167531093609")%><!--奖励和其它--></td>
        <td><textarea  name="other" rows="5" cols="60" id="textarea"><%if(obj.getOther()!=null)out.print(obj.getOther());%></textarea>
          <br>
          <%=r.getString(teasession._nLanguage,"1167531136796")%><!--概述你的奖励或其它优势。（限200字。 <a href="javascript:alert(&quot;现已输入了&quot;+document.all['other'].value.length+&quot;个字！&quot;);">计算字数</a>）-->
          <br>
</td>
      </tr>
 </table>

 <P ALIGN=CENTER>
<!--上一步-->
<input type="submit"  name="employment" VALUE="<%=r.getString(teasession._nLanguage,"1167472219140")%>" onClick="">
<input type="submit"  name="inhabit" VALUE="<%=r.getString(teasession._nLanguage,"CBNext")%>"  onClick="">

<input type=SUBMIT name="GoFinish" ID="edit_GoFinish"  VALUE="<%=r.getString(teasession._nLanguage, "GoFinish")%>" onClick="">

</p>
</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>

</body>
</HTML>

