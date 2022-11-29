<%@page contentType="text/html;charset=UTF-8"  %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="tea.entity.bpicture.*" %>
<%@ page import="tea.entity.node.*" %>
<%@page import="java.io.File.*" %>
<%@page import="java.io.*" %>
<%@ page import="tea.db.*" %>
<%@ page import="tea.entity.member.*" %>
<%

TeaSession teasession = new TeaSession(request);
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");


StringBuffer sql = new StringBuffer();
StringBuffer param=new StringBuffer("?community=").append(teasession._strCommunity);

String act = request.getParameter("acts");



int pos=0;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}
param.append("&pos=").append(pos);

int count=0;


%>
<html>
<HEAD>
  <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
  <script> if(parent.lantk) { document.getElementsByTagName("LINK")[0].href="/res/csvclub/cssjs/community_02.css"; } </script>
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="" ></SCRIPT>
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/csvclub/js.js" type=""></SCRIPT>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache"/>
  <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"/>
  <META HTTP-EQUIV="Expires" CONTENT="0"/>
  <title>审核图片信息</title>
  <style>
  #table005{width:95%;margin-top:15px;}
  #table005 td{background:#eee;padding:5px 10px;}
  .lzj_001{height:23px;border:1px solid #7F9DB9;background:#fff;line-height:20px;*line-height:14px;padding-bottom:5px;*paddding-bottom:0;}
  </style>
</HEAD>
<body style="margin:0;">
<div id="wai">
  <h1>审核图片信息</h1>
  <form action="?" method="POST">
  <input type="hidden" name="id" value="<%=request.getParameter("id")%>"/>


  <table border="0" cellpadding="0" cellspacing="2" id="table005">
    <tr>
      <td nowrap="nowrap">会员ID</td>
      <td><input type="text"  name="member" size="27" value=""/></td>
      <td nowrap="nowrap">姓名</td>
      <td><input type="text"  name="firstname" size="27" value=""/></td>

      <td width=160><input type="submit" value="查询"/></td>
    </tr>

  </table>
  <h2>人员信息列表(<%=count%>)</h2>
  <table border="0" cellpadding="0" cellspacing="2" id="table005">
    <tr>
      <td nowrap="nowrap" width="5%">序号</td><td nowrap="nowrap" width="15%">会员ID</td><td nowrap="nowrap">姓名</td><td>操作</td>
    </tr>
    <%
    java.util.Enumeration  enumers = Profile.findByCommunity(teasession._strCommunity,sql.toString(),pos,50);
    if(!enumers.hasMoreElements())
    {
      %>
      <tr>
        <td colspan="10" align="center">暂无信息</td>
      </tr>
      <%
      }
      for(int i=0;enumers.hasMoreElements();i++)
      {
        String member=enumers.nextElement().toString();

        Profile pro = Profile.find(member);
        String firstnames  = pro.getFirstName(teasession._nLanguage);

        %>
        <tr>
          <td><%=i%></td>
          <td><%=member%></td>
          <td><%=firstnames%></td>
          <td>
            <input type="button" value="删除会员" class="lzj_001" onClick="if(confirm('彻底删除该会员所有资料，如要删除请慎重考虑！')){window.location.href='/jsp/bpicture/DelManage.jsp?act=delmember';}" >
            <input type="button" value="删除图片" class="lzj_001" onClick="if(confirm('确认删除会员图片！')){window.location.href='';}" >
          </td>
        </tr>
        <%
        }
        %>
        <tr>
          <td colspan="11" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,50)%>
          </td>
        </tr>
  </table>
  </form>
</div>

</body>
</html>
