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

if(act!=null)
{
  File file = new File(application.getRealPath("/res/"+teasession._strCommunity+"/picture/"+(request.getParameter("nodes")+".jpg")));
  Baudit.delete(teasession._strCommunity, Integer.parseInt(request.getParameter("nodes")),file);
}

String update= "";
if(request.getParameter("update")!=null&&request.getParameter("update").length()>0)
{
  update = request.getParameter("update");

  sql.append(" and received>"+DbAdapter.cite(update));
  param.append("&update=").append(update);
}

String member= "";
if(teasession.getParameter("member")!=null && teasession.getParameter("member").length()>0)
{
  member = teasession.getParameter("member");
  sql.append(" and  member like ").append(DbAdapter.cite("%"+member+"%"));
  param.append("&member=").append(DbAdapter.cite(member));
}
String firstname="";
if(teasession.getParameter("firstname")!=null && teasession.getParameter("firstname").length()>0)
{
  firstname = teasession.getParameter("firstname");
  sql.append(" and member in (select member from profilelayer where firstname like "+DbAdapter.cite("%"+firstname+"%")+")");
  param.append("&firstname=").append(java.net.URLEncoder.encode(firstname,"UTF-8"));
}
String pg = "-1";
if(teasession.getParameter("passpage")!=null && teasession.getParameter("passpage").length()>0 && !teasession.getParameter("passpage").equals("-1"))
{
  pg = teasession.getParameter("passpage");
  sql.append(" and passpage="+pg);
  param.append("&passpage=").append(pg);
}

String menu_id=(request.getParameter("id"));
if(menu_id!=null&&menu_id.length()>0)
{
  param.append("&id=").append(menu_id);
}

int pos=0;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}
param.append("&pos=").append(pos);

int count=Baudit.count(teasession._strCommunity,sql.toString());


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
  <form action="/jsp/bpicture/AuditPicture.jsp" method="POST">


  <table border="0" cellpadding="0" cellspacing="2" id="table005">
    <tr>
    <td nowrap="nowrap">上传日期</td>
    <td><input id="update" type="text" name="update" value="<%if(update!=null)out.print(update);%>" readonly="readonly" /><img style="margin-bottom:-8px;" src="/tea/image/bbs_edit/table.gif" onclick="new Calendar('2006', '2010', 0,'yyyy-MM-dd').show(update);" /></td>
      <td nowrap="nowrap">会员ID</td>
      <td><input type="text"  name="member" size="27" value="<%=member%>"/></td>
        <td nowrap="nowrap">姓名</td>
        <td><input type="text"  name="firstname" size="27" value="<%=firstname%>"/></td>
        <td nowrap="nowrap">审核情况</td>
        <td>
          <select name="passpage">
            <option value="-1" <%if(pg.equals("-1"))out.print("selected");%>>-------</option>
            <option value="0" <%if(pg.equals("0"))out.print("selected");%>>未审核</option>
            <option value="1" <%if(pg.equals("1"))out.print("selected");%>>通过</option>
            <option value="2" <%if(pg.equals("2"))out.print("selected");%>>未通过</option>
          </select>
        </td>
     <td width=160><input type="submit" value="查询"/></td>
    </tr>

  </table>
  <h2>图片信息列表(<%=count%>)</h2>
  <table border="0" cellpadding="0" cellspacing="2" id="table005">
    <tr>
      <td nowrap="nowrap">上传日期</td><td nowrap="nowrap">会员ID</td><td nowrap="nowrap">姓名</td><td nowrap="nowrap">BP图片名称</td><td nowrap="nowrap">原始图片名称</td><!--<td>媒体引用</td>--><td nowrap="nowrap">上传类型</td><td nowrap="nowrap">错误</td><td nowrap="nowrap">通过</td><td nowrap="nowrap">审核日期</td><td nowrap="nowrap">状态</td><td></td>
    </tr>
    <%
    java.util.Enumeration  enumers = Baudit.findByCommunity(teasession._strCommunity,sql.toString()+"order by received desc",pos,50);
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
        int ee=Integer.parseInt(enumers.nextElement().toString());
        Node node = Node.find(ee);
        Baudit baudit = Baudit.find(ee);
        Picture p = Picture.find(ee);

        String firstnames="";

        if(Profile.isExisted(baudit.getMember()))
        {
          Profile pro = Profile.find(baudit.getMember());
          firstnames  = pro.getFirstName(teasession._nLanguage);
        }
        %>
        <tr>

          <td><%=baudit.getReceivedtoString() %></td>
          <td><%=baudit.getMember()%></td>
          <td><%=firstnames%></td>
          <td><%=baudit.getNode()%></td>
          <td><%=p.get_nName()%></td>
          <!--<td><%=baudit.getMediaref()%></td>-->
          <td><%=Baudit.MEDIATYPE[baudit.getMediatype()]%></td>
          <td><%=Baudit.ERROR[baudit.getError()]%></td>
          <td><%=Baudit.PASSPAGE[baudit.getPasspage()]%></td>
          <td><%=baudit.getDateaudittoString()%></td>
          <td><%=Baudit.STATUS[baudit.getStatus()]%></td>
          <td><input   type="button" class="lzj_001"  onclick="window.open('/jsp/bpicture/EditAuditPicture.jsp?update=<%=update%>&member=<%=member%>&firstname=<%=firstname%>&passpage=<%=pg%>&nodes=<%=ee%>&pos=<%=pos%>','_self')" value="审核" />&nbsp;

          <%
          if(Bimage.falgfind(" node ="+node._nNode))
          {
            %>
            <input type="button" value="删除" class="lzj_001" onClick="if(confirm('此图片已销售，如要删除请慎重考虑！')){window.open('/jsp/bpicture/AuditPicture.jsp?nodes=<%=ee%>&acts=del', '_self');this.disabled=true;};" >
            <%
            }else
            {
              %>
              <input type="button" value="删除" class="lzj_001" onClick="if(confirm('确认删除会员图片！')){window.open('/jsp/bpicture/AuditPicture.jsp?nodes=<%=ee%>&acts=del', '_self');this.disabled=true;};" >
              <%
              }
              %>
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
 <%@include file="/jsp/include/Canlendar4.jsp" %>
</body>
</html>
