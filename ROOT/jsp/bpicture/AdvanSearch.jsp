<%@page contentType="text/html;charset=UTF-8"  %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="tea.entity.bpicture.*" %>
<%@ page import="tea.entity.node.*" %>
<%@page import="tea.entity.site.*" %>
<%

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");
TeaSession teasession = new TeaSession(request);
HttpSession sessions = request.getSession(true);

Community c=Community.find(teasession._strCommunity);
String url = request.getRequestURI()+request.getQueryString();
String keywords = request.getParameter("bp_keywords");
%>


<HEAD>
  <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
  <title>高级搜索</title>
  <style type="text/css">


  </style>
</head>
<body style="margin:0;padding:0;">

<!--<h2><a href="/jsp/bpicture/" >首页</a>  &gt; 高级搜索</h2>-->

<span id="bph12"><h1>高级搜索</h1>
<h2><a href="/servlet/Node?node=<%=c.getNode()%>" >首页</a>  &gt; 高级搜索</h2></span>
<form name="advanSearch" action="/servlet/Folder" method="get" >
<input type="hidden" name="node" value="2198224"/>
<input type="hidden" name="language" value="1"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" id="lzj_table">

  <tr class="bg2">
    <td>&nbsp;选择先进的搜索选项，并点击<b>高级搜索</b>...</td>
    <td align="right"><input type="submit" value="高级搜索"></td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" style="" id="lzj_table">
  <tr class="bg2">
    <td width="27%" align="right" ><strong>搜索项</strong></td>
    <td width="10%"  align="right">&nbsp;</td>
    <td colspan="2"  align="right">&nbsp;</td>
  </tr>
  <tr class="bg2">
    <td align="right"></td>
    <td colspan="3" class="bg2"><input type="text" size="29" id="kuan" name="bp_keywords" value="<%--if(keywords!=null){out.print(keywords);}else{if(session.getAttribute("allkey")!=null)out.print(session.getAttribute("allkey"));}--%>">和下列<b>全部</b>字词有关系</td>
  </tr>
  <!--tr class="bg2">
    <td align="right"></td>
    <td colspan="3" class="bg2"><input type="text" size="29" id="kuan" name="comkey" value="<%--if(session.getAttribute("comkey")!=null)out.print(session.getAttribute("comkey"));--%>">关键字中包含精确的短语/词组</td>
  </tr-->
  <tr>
    <td align="right" nowrap></td>
    <td colspan="3" class="bg2"><input type="text" size="29" id="kuan" name="onlykey" value="">只要和下列的<b>任何一个</b>字词有关系</td>
</tr>
<tr class="bg2">
  <td align="right"></td>
  <td colspan="3" class="bg2"><input type="text" size="29" id="kuan" name="notkey" value="">和下列字词<b>无关</b></td>
</tr>

<tr id="bg3">
  <td width="27%" align="right" valign="top" class="bg2"><strong>授权类型</strong></td>

  <td colspan="3"  align="right">
  <table align="left" cellpadding="0" cellspacing="0" id="lzj_fu">
  <tr>
    <td width="1%" align="right" id="bg3"><input id="l" type="checkbox" name="rm" value="1" checked<%--if(session.getAttribute("rm")!=null)out.print("checked");--%>></td>
      <td><label for="l"> 版权管理类图片</label> - <span class="l"><font color="#FE8100">RM</font></span></td>
</tr>
<tr>
  <td align="right" id="bg3"><input type="checkbox" name="rf" id="rf" value="1" checked<%--if(session.getAttribute("rf")!=null)out.print("checked");--%> ></td>
  <td width="99%" ><label for="rf"> 免版税图片</label> - <span class="rf"><font color="blue">RF</font></span></td>
</tr></table>
</td>
</tr>

<tr>
  <td align="right" valign="top" class="bg2"><strong>许可</strong></td>

  <td  valign="top" colspan="3">&nbsp;<input id="mr" type="checkbox" name="model" value="1" >
    <label for="mr">肖像权许可</label>
    <br>
     &nbsp;<input id="pr" type="checkbox" name="pr" value="1" >
    <label for="pr">物产权许可</label>
    <input type="hidden" name="ns" value="1"></td>
</tr>

<tr>
  <td width="27%" align="right" valign="top" class="bg2"><strong>分类</strong></td>


  <td colspan="3" align="right">
<table align="left" cellpadding="0" cellspacing="0" id="lzj_fu">
  <tr>
<td align="right" id="bg3"><input id="jg" type="checkbox" checked="checked" name="ot1" value="1" <%--if(session.getAttribute("ot1")!=null)out.print("checked");--%>></td>
  <td>
  <label for="jg">横图</label>
   </td>
</tr>
<tr>
  <td align="right" id="bg3"><input id="rx" type="checkbox" checked="checked" name="ot2" value="2" <%--if(session.getAttribute("ot2")!=null)out.print("checked");--%>></td>
  <td width="62%" ><label for="rx">竖图</label></td>
</tr>
<tr>
  <td align="right" id="bg3"><input id="qj" type="checkbox" checked="checked" name="ot3" value="3" <%--if(session.getAttribute("ot3")!=null)out.print("checked");--%>></td>
  <td><label for="qj">正图</label></td>
</tr>
<tr>
  <td align="right" id="bg3"><input id="gc" type="checkbox" checked="checked" name="ot4" value="4" <%--if(session.getAttribute("ot4")!=null)out.print("checked");--%>></td>
  <td nowrap> <label for="gc">全景图</label></td></tr></table>

	</td>
  </tr>


<tr>
  <td width="27%" align="right" valign="top" class="bg2"><strong>显示的照片不能小于 </strong></td>
  <%
  String size="0";
  if(session.getAttribute("size")!=null){
    size = session.getAttribute("size").toString();
  }

  %>

  <td colspan="3">
  <table align="left" cellpadding="0" cellspacing="0" id="lzj_fu">
  <tr>
<td width="14%" id="bg3"><input id="size70" type="radio" name="size" value="70" <%if(size.equals("70"))out.print("checked");%>></td>
  <td><label for="size70">70 MB</label></td>
</tr>
<tr>
  <td id="bg3"><input id="size48" type="radio" name="size" value="48" <%if(size.equals("48"))out.print("checked");%>></td>
  <td width="86%" ><label for="size48">48 MB</label></td>
</tr>
<tr>
  <td id="bg3"><input id="size24" type="radio" name="size" value="24" <%if(size.equals("24"))out.print("checked");%>></td>
  <td width="86%" ><label for="size24">24 MB</label></td>
</tr>
<tr>
  <td id="bg3"><input id="size15" type="radio" name="size" value="15" <%if(size.equals("15"))out.print("checked");%>></td>
  <td width="86%" ><label for="size15">15 MB</label></td>
</tr>
<tr>
  <td id="bg3"><input id="size5" type="radio" name="size" value="5" <%if(size.equals("5"))out.print("checked");%>></td>
  <td width="86%" ><label for="size5">5 MB</label></td>
</tr>
<tr>
  <td id="bg3"><input id="size1" type="radio" name="size" value="1" <%if(size.equals("1"))out.print("checked");%>></td>
  <td width="86%" ><label for="size1">1 MB</label></td>
</tr>
<tr>
  <td id="bg3"><input id="size0" type="radio" name="size" value="0" <%if(size.equals("0"))out.print("checked");%>></td>
  <td width="86%" ><label for="size0">显示所有文件的大小</label></td>
</tr>
</table></td>
</tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" id="lzj_table1">
  <tr>
    <td height="31">&nbsp;选择先进的搜索选项，并点击<b>高级搜索</b>...</td>
    <td align="right"><input type="submit" value="高级搜索"></td>
  </tr>
</table>
</form>


</body>


