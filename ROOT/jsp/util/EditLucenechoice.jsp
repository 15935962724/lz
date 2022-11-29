<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="tea.entity.*" %><%@ page import="tea.entity.util.*" %><%@ page import="java.math.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

Resource r=new Resource("/tea/resource/Lucene");

int lucene=h.getInt("lucene");
int pos=h.getInt("pos");
int sum=Lucenechoice.count(" AND lucene="+lucene);


%><html>
<head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body onload="form1.label.focus();">
<h1><%=r.getString(h.language, "1167881089765")%></h1>
<div id="head6"><img height="6" alt=""></div>
<br>

<form name=form1 METHOD=POST action="/Lucenes.do" target="_ajax">
<input type="hidden" name="lucene" value="<%=lucene%>"/>
<input type="hidden" name="lucenechoice" value="0"/>
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="nexturl" value="<%=request.getRequestURI()+"?"+request.getQueryString()%>"/>
<input type="hidden" name="act" value="cedit"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td><%=r.getString(h.language,"Subject")%></td><td><input name="label" type="text" value="" alt="<%=r.getString(h.language,"Subject")%>"></td>
  </tr>
  <tr>
    <td><%=r.getString(h.language,"1167881546515")%></td><td><input name="value" type="text" alt="<%=r.getString(h.language,"1167881546515")%>"></td>
  </tr>
  <tr>
    <td><%=r.getString(h.language,"Sequence")%></td><td><input name="sequence" type="text" value="0" mask="int"></td>
  </tr>
</table>
<input type="submit" value="<%=r.getString(h.language,"Submit")%>" onclick="return mt.check(form)">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id=tableonetr>
    <td><%=r.getString(h.language, "Subject")%></td>
    <td><%=r.getString(h.language, "1167881546515")%></td>
    <td><%=r.getString(h.language, "Sequence")%></td>
    <td></td>
  </tr>
<%
Iterator it=Lucenechoice.find(" AND lucene="+lucene+" ORDER BY sequence",pos,25).iterator();
while(it.hasNext())
{
  Lucenechoice obj=(Lucenechoice)it.next();
  int id=obj.lucenechoice;
  String label=obj.getLabel(h.language);
  String value=obj.getValue(h.language);
  %><tr onmouseover="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
    <td><%=label%></td>
    <td><%=value%></td>
    <td><%=obj.sequence%></td>
    <td>
    <textarea name="label_<%=id%>" style="display:none"><%=label%></textarea>
    <textarea name="value_<%=id%>"  style="display:none"><%=value%></textarea>
<script type="">
function fclick_<%=id%>()
{
  form1.label.value=form1.label_<%=id%>.value;
  form1.value.value=form1.value_<%=id%>.value;
  form1.lucenechoice.value="<%=id%>";
  form1.sequence.value="<%=obj.sequence%>";
  form1.label.focus();
}
</script>
      <a href="javascript:fclick_<%=id%>()"><%=r.getString(h.language,"CBEdit")%></a>
      <%
      if(obj.isLayerExists(h.language))
      {
        out.print("<a href=javascript:mt.act('cdel',"+id+")>"+r.getString(h.language,"CBDelete")+"</a>");
      }
      %>
</td>
</tr>
  <%
}
if(sum>25)out.print("<tr><td colspan='4' align='center'>"+new tea.htmlx.FPNL(h.language,"?community="+h.community+"&lucene="+lucene+"&pos=",pos,sum));
%>
</table>


<h2><%=r.getString(h.language,"1167904108625")%><!--附助添加--></h2>
<div id="head6"><img height="6" alt=""></div>
<!--媒体标志-->
<input type="submit" name="media" value="<%=r.getString(h.language,"1167904002656")%>"/>
<!--媒体类别-->
<input type="submit" name="class" value="<%=r.getString(h.language,"1167904621015")%>"/>
</form>

<script>
mt.act=function(a,i)
{
  form1.act.value=a;
  form1.lucenechoice.value=i;
  if(a=='cdel')
  {
    mt.show('<%=r.getString(h.language,"ConfirmDeleteTree")%>',2,'form1.submit()');
  }
};
</script>
<div id="head6"><img height="6" alt=""></div>
<div id="language"><%=new tea.htmlx.Languages(h.language,request)%></div>
</body>
</html>
