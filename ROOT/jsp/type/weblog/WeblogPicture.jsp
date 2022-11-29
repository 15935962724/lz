<%@page contentType="text/html;charset=utf-8" %>
<%
tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
tea.entity.node.Node node=tea.entity.node.Node.find(teasession._nNode);
String member=node.getCreator()._strV;
tea.entity.member.BLOGProfile bp=tea.entity.member.BLOGProfile.find(member);
String picture=bp.getPicture();
if(picture==null||picture.length()==0)
{
  tea.entity.site.BLOGCommunity bc=  tea.entity.site.BLOGCommunity.find(member);
  picture=bc.getPicture();
}
picture=picture;
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script src="/tea/tea.js" type="text/javascript"></script>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style></head>
<body>
<div align="center"><img alt=""  name="picture_weblogpicture" src="<%=picture%>"  />
    <script type="">
setSize(document.all['picture_weblogpicture'],180,120);
  </script>
</div>
</body>
</html>

