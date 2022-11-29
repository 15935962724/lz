<%@page contentType="text/html;charset=UTF-8" %>
<%@ include file="/jsp/Header.jsp" %>
<%
tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
String community=node.getCommunity();
if(request.getParameter("Node")!=null&&teasession._rv.isOrganizer(community))
{
  teasession._nNode=Integer.parseInt(request.getParameter("Node"));
  node=tea.entity.node.Node.find(teasession._nNode);
}else
{
  java.util.Enumeration enumer_type=tea.entity.node.Node.findByType(64,community);//查找当前会员的差点节点
  int nodecode=-1;
  boolean bool=false;
  while(enumer_type.hasMoreElements())
  {
    nodecode=((Integer)enumer_type.nextElement()).intValue();
    tea.entity.node.Node node_temp=  tea.entity.node.Node.find(nodecode);
    if(node_temp.getCreator()._strR.equals(teasession._rv._strR))
    {
      bool=true;
      node=node_temp;
      teasession._nNode=nodecode;
    }
  }
  if(!bool)
  {
    out.print(new tea.html.Script("alert('对不起,没有记录.');history.back();"));
    return;
  }
}
tea.entity.member.Profile profile=tea.entity.member.Profile.find(node.getCreator()._strR );
%>
<html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></head>
<body>
<h1><%=r.getString(teasession._nLanguage, "ScoreInfo")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<span style="float:left;color:#FF0000;font-weight:bold;"><img SRC="/tea/image/score/0001.jpg">　个人资料</span>
<span style="float:right;color:#FF0000;font-weight:bold;">你好：
<%

tea.entity.member.Profile profile_obj=tea.entity.member.Profile.find(teasession._rv.toString());
out.println(profile_obj.getLastName(teasession._nLanguage));
out.println(profile_obj.getFirstName(teasession._nLanguage));
%></span>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr ID=tableonetr>
    <td><div align="center">ID</div></td>
    <td><div align="center">姓名</div></td>
    <td><div align="center">当月差点指数</div></td>
    <td><div align="center">临时差点指数</div></td>
    <td><div align="center">产生日期</div></td>
    <td><div align="center">主场</div></td>
  </tr>
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td>&nbsp;<%=node.getCreator()._strR%></td>
    <td>&nbsp;<%=profile.getLastName(teasession._nLanguage)%></td>
    <td><div align="center"><%//tea.entity.node.Score.getMonthlyByNode(teasession._nNode)%></div></td>
    <td><div align="center"><%//tea.entity.node.Score.getTemporarilyByNode(teasession._nNode)%></div></td>
    <td><div align="center"><%=tea.entity.node.Score.getMaxTimesByNode(teasession._nNode)%></div></td>
    <td><div align="center"><%=profile.getCity(teasession._nLanguage)%></div></td>
  </tr>
</table><br>

注：主场是您所在的地区，在您注册成为会员时，选择的地区将决定你的主场是哪里！
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage, request)%></div>
</body>
</html>

