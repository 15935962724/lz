<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.Resource"  %>
<%@ page  import="tea.entity.csvclub.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import ="tea.entity.member.*" %>
<%@ page import ="tea.entity.node.*" %>
<%@ page import="tea.entity.site.*" %>
<%@ page import="tea.entity.admin.mov.*" %>
<%@ page import="tea.entity.integral.*" %>

<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

Resource r=new Resource();
String community = teasession._strCommunity;
String nexturl = request.getRequestURI()+"?"+request.getContextPath();

CommunityPoints cp= CommunityPoints.find(CommunityPoints.getIgid(teasession._strCommunity));
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<script>

//修改的积分




//修改用户登录的积分
function f_reg(zd)
{
 var fieldvalude = document.getElementById(zd).value;//修改的数值

  sendx("/jsp/integral/integral_ajax.jsp?community="+form1.community.value+"&act=MemberType&field="+zd+"&fieldvalude="+fieldvalude,
  function(data)
  { 

	 document.getElementById(zd+'span').innerHTML='<font color=red>添加成功</font>';

  }
  );
}


</script>
<body bgcolor="#ffffff" >


<h1>投稿积分设置</h1>
<form action="/servlet/EditIntegral" method="POST" name="form1">
<input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="act" value="Integral" />

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
 <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
     <td align="right" nowrap><div align="left">投稿加分：</div></td>
     <td><input type="text" name="tgjf" value="<%=cp.getTgjf() %>"  size="5"  onkeyup="f_reg('tgjf');" >&nbsp;<span id=tgjfspan>&nbsp;</span></td>
  </tr>
   <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
     <td align="right" nowrap><div align="left">稿件被采用加分：</div></td>
     <td><input type="text" name="cyjf" value="<%=cp.getCyjf() %>"  size="5"  onkeyup="f_reg('cyjf');" >&nbsp;<span id=cyjfspan>&nbsp;</span></td>
  </tr>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
     <td align="right" nowrap><div align="left">聚焦稿件加分：</div></td>
     <td><input type="text" name="jjjf" value="<%=cp.getJjjf() %>"  size="5"  onkeyup="f_reg('jjjf');" >&nbsp;id：<input type=text size=2 name="mark" value="<%=cp.getMark() %>"  onkeyup="f_reg('mark');" />
     &nbsp;<span id=jjjfspan>&nbsp;</span>     </td>
  </tr>
   <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
     <td align="right" nowrap><div align="left">头条1稿件加分：</div></td>
     <td><input type="text" name="ttjf1" value="<%=cp.getTtjf1() %>"  size="5"  onkeyup="f_reg('ttjf1');" >&nbsp;id：<input type=text size=2 name="mark1" value="<%=cp.getMark1() %>"  onkeyup="f_reg('mark1');" />
     &nbsp;<span id=ttjf1span>&nbsp;</span></td>
  </tr>
   <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
     <td align="right" nowrap><div align="left">头条2稿件加分：</div></td>
     <td><input type="text" name="ttjf2" value="<%=cp.getTtjf2() %>"  size="5"  onkeyup="f_reg('ttjf2');" >&nbsp;id：<input type=text size=2 name="mark2" value="<%=cp.getMark2() %>"  onkeyup="f_reg('mark2');" />
     &nbsp;<span id=ttjf2span>&nbsp;</span></td>
  </tr>
   <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
     <td align="right" nowrap><div align="left">头条3稿件加分：</div></td>
     <td><input type="text" name="ttjf3" value="<%=cp.getTtjf3() %>"  size="5"  onkeyup="f_reg('ttjf3');" >&nbsp;id：<input type=text size=2 name="mark3" value="<%=cp.getMark3() %>"  onkeyup="f_reg('mark3');" />
     &nbsp;<span id=ttjf3span>&nbsp;</span></td>
  </tr>
   <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
     <td align="right" nowrap><div align="left">退稿减分：</div></td>
     <td><input type="text" name="tgjianf" value="<%=cp.getTgjianf() %>"  size="5"  onkeyup="f_reg('tgjianf');" >&nbsp;<span id=tgjianfspan>&nbsp;</span></td>
  </tr>
</table>
