<%@page contentType="text/html;charset=UTF-8"  %><%

%>
<script type="">
function fchangetitle()
{
  window.document.title=window.m.document.title;
}
window.setInterval("fchangetitle();",1000);
</script>
<html>
<frameset id="frame" rows="80,*"  frameborder="NO" border="0" framespacing="0">
    <frame name="MenuFrame" src="<%=tree%>" style="border-right: 1 solid #666666">
    <frame name="MenuFrame2" src="leftup2.jsp?node=<%=teasession._nNode%>&community=<%=community%>" style="border-right: 1 solid #666666">
</frameset>
</html>

