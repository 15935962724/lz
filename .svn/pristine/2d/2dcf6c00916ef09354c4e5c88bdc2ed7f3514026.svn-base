<%@page contentType="text/html;charset=UTF-8"  %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="tea.entity.bpicture.*" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="tea.db.*" %>
<%

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);


StringBuffer sql = new StringBuffer(" and member='"+teasession._rv._strR+"'");
StringBuffer param = new StringBuffer("?community="+teasession._strCommunity);

String update= "";
if(request.getParameter("update")!=null&&request.getParameter("update").length()>0)
{
  update = request.getParameter("update");

  sql.append(" and datediff(day,received,"+DbAdapter.cite(update)+")=0");
  param.append("&update=").append(update);
}

String picid= request.getParameter("picid");
if(picid!=null&&picid.length()>0)
{
  sql.append(" and node like ").append("'%"+picid+"%'");
  param.append("&picid=").append(picid);
}

String pass= "";
if(request.getParameter("pass")!=null&&request.getParameter("pass").length()>0&&!request.getParameter("pass").equals("-1"))
{
  pass = request.getParameter("pass");
  sql.append(" and passpage="+pass);
  param.append("&pass=").append(pass);
}

int pos=0;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}
param.append("&pos=").append(pos);


int count=0;
count = Baudit.count(teasession._strCommunity,sql.toString());
%>
<html>
<HEAD>
  <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
  <script> if(parent.lantk) { document.getElementsByTagName("LINK")[0].href="/res/csvclub/cssjs/community_02.css"; } </script>
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="" ></SCRIPT>
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/csvclub/js.js" type=""></SCRIPT>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
      <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
        <META HTTP-EQUIV="Expires" CONTENT="0">
          <title>图片上传信息</title>

<style>
#table001{background:#F6F6F6;border-bottom:10px solid #eee;border-top:10px solid #eee;padding:6px;width:95%;margin-top:10px;}
#table001 td li{line-height:180%;}
#table002 td{background:#eee;}
#tableonetr td{font-weight:bold;text-align:center;}
.bg8 td{background:#eee;border-bottom:1px solid #ccc;}
#table002{width:95%;padding:6px;}
.hide{margin-left:25px;margin-top:5px;}
.lzj_tu{background:url(/res/bigpic/u/0812/081212349.jpg) no-repeat 0 7px;padding-left:12px;}
</style>
</head>

<body style="margin:0;">
<div id="wai">
<div id="li_biao"><a href="http://bp.redcome.com" target="_top">首页</a>&nbsp;>&nbsp;管理中心&nbsp;>&nbsp;图片上传信息</div>

<H1>图片上传信息</H1>
<form action="?" name="form1" method="POST">
<input type="hidden" name="id" value="<%=request.getParameter("id")%>"/>
<table border="0" cellpadding="0" cellspacing="2" id="table002">
  <tr>
    <td>上传日期</td>
    <td width="258"><input id="update" type="text" size="28" name="update" value="<%if(update!=null)out.print(update);%>" readonly="readonly" /><img style="margin-bottom:-8px;" src="/tea/image/bbs_edit/table.gif" onclick="new Calendar('2006', '2010', 0,'yyyy-MM-dd').show(update);" /></td>
    <td>图片名称</td>
    <td><input type="text" size="28" name="picid" value="<%if(picid!=null)out.print(picid);%>"/></td>
    <td>审核情况</td>
    <td><select name="pass">
      <option value="-1" <%if(pass.equals("-1"))out.print("selected");%>>全部</option>
      <option value="0" <%if(pass.equals("0"))out.print("selected");%>>未审核</option>
      <option value="1" <%if(pass.equals("1"))out.print("selected");%>>通过</option>
      <option value="2" <%if(pass.equals("2"))out.print("selected");%>>没通过</option>
</select>
    </td>
    <td width="180"><input type="submit" value="查询"/></td>
  </tr>
</table>
</form>
<h2>信息列表（<%=count%>）</h2>
<table border="0" cellpadding="0" cellspacing="2" id="table002">
  <tr id="tableonetr">
    <td align="center">上传日期</td>
    <td align="center">BP图片名称</td>
    <td align="center">原始图片名称</td>
    <td align="center">上传方式</td>
    <td align="center">错误</td>
    <td align="center">审核情况</td>
    <td align="center">审核日期</td>
    <td align="center">状态</td>
    </tr>
    <%
    java.util.Enumeration  emtimes = Baudit.findByCommunity(teasession._strCommunity,sql.toString(),pos,10);
    if(!emtimes.hasMoreElements())
    {
      %>   <tr><td colspan="10" align="center">暂无信息</td>
      </tr>
      <%
    }
     for(int i=0;emtimes.hasMoreElements();i++)
     {
       int node=Integer.parseInt(emtimes.nextElement().toString());

       Baudit baudit = Baudit.find(node);
       Picture p = Picture.find(node);
       String error = "";
       error = baudit.getError()==1?"有错误":"没有错误";
       String pg = "";
       if(baudit.getPasspage()==1)pg="通过";
       if(baudit.getPasspage()==0)pg="未审核";
       if(baudit.getPasspage()==2)pg="没通过";
       %>
       <tr>
       <td height="19" align="center"><%=baudit.getReceivedtoString()%></td>
       <!--<td align="center"><%if(baudit.getMediaref()!=null && baudit.getMediaref().length()>0){out.print(baudit.getMediaref());}else{out.print("");}%>
         &nbsp;</td>-->
         <td align="center"><%=baudit.getNode()%></td>
         <td align="center"><%=p.get_nName()%></td>
       <td align="center"><%=Baudit.MEDIATYPE[baudit.getMediatype()]%>&nbsp;</td>
       <td align="center"><%=error%></td>
       <td align="center"><%=pg%></td>
       <td align="center"><%=baudit.getDateaudittoString()%>&nbsp;</td>
       <td align="center"><%=Baudit.STATUS[baudit.getStatus()]%>&nbsp;</td>
       </tr>
       <%

     }
    %>
    <tr>
    <td align="center" colspan="9">

      <%if(count>10)
      {
        out.print(new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,10));
      }%>

    </td>
  </tr>
  </TABLE>
 <%@include file="/jsp/include/Canlendar4.jsp" %>
  <!--
<table border="0" cellpadding="0" cellspacing="0" id="table001">
  <TBODY>
  <TR vAlign=top>
    <TD noWrap>
      <H3 class=hide>帮助 </H3>
      <UL>
        <LI class="lzj_tu">理解表：
        <UL>
          <LI type=circle><IMG  src="/res/bigpic/u/0812/08124169.jpg" alt=""> 表明在反对媒体给出的理由。</LI>
          <LI type=circle>如果我们不能一张图片，我们将拒绝所有的图像在所有媒体等待的QC <BR> （它们具有相同的质量日期） 。</LI></UL></LI>
        <LI class="lzj_tu"> <A  href="#">图片上传信息</A>提供的信息：
        <UL>
          <LI type=circle>图像处理和常见的错误。</LI>
          <LI type=circle>为什么我们反对的图像。</LI>
          <LI type=circle>我们的质量控制（ QC ）的政策。</LI>
          <LI type=circle> <A href="#">使用的术语在此网页上。</A>
          </LI></UL></LI></UL></TD>
    <TD>
      <H3 class=hide>下一步如何？ </H3>
      <UL>
        <LI class="lzj_tu">如果您的图片通过质量控制，现在您可以<A href="#">管理您的图像。</A></LI>
		<LI class="lzj_tu">如果您的图片没有质量，请查看我们<A href="#">提出的指导方针</A>，并重新提交。</LI>
		</UL></TD></TR></TBODY></TABLE>-->
</div>
</body>
</html>
