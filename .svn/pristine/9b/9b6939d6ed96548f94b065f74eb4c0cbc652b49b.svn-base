<%@page contentType="text/html;charset=UTF-8"  %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="tea.entity.bpicture.*" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="tea.entity.site.*" %>
<%@ page import="tea.db.*" %>
<%@page import="java.awt.image.*" %>
<%@page import="javax.imageio.*" %>
<%@page import="java.math.BigDecimal" %>
<%
TeaSession teasession = new TeaSession(request);
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/Node?node=2198284&language=1");
  return;
}
Community community = Community.find(teasession._strCommunity);
int cwid=0;
if(teasession.getParameter("cwid")!=null && teasession.getParameter("cwid").length()>0)
{
  cwid = Integer.parseInt(teasession.getParameter("cwid"));
  Bimage.enterPrice(cwid,teasession._rv.toString());
}
StringBuffer sql = new StringBuffer("and picprice !=0 and picsalestype=1 and member="+DbAdapter.cite(teasession._rv.toString()));
StringBuffer param=new StringBuffer("?community=").append(teasession._strCommunity).append("&back=").append(request.getParameter("back"));

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


int count=Bimage.countAll(teasession._strCommunity,sql.toString());
%>
<html>
<!-- Stock photography -->
<head>

<title>订单和下载</title>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/res/<%=teasession._strCommunity%>/cssjs/3js.js" type="" ></SCRIPT>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">

<!--Onload="page_onload()"--><!--Uncomment Onload function to start recording thumbsloadtime & htmlLoadtime-->
<a name="top"></a>

<style>
#table002 td{background:#eee;border-bottom:1px solid #ccc;height:30px;padding:6px;}
#table002{width:95%;padding:6px;margin-top:10px;}
#table005{width:95.5%;margin-top:15px;}
#table005 td{background:#eee;padding:6px;}
.ss a{color:0000ff;
	font-family: Verdana, Arial, Helvetica, sans-serif;
}
</style>

</head>
<body style="margin:0;padding:0;">
<%if(request.getParameter("back")!=null){%>
<div id="jspbefore">
  <%=community.getJspBefore(teasession._nLanguage)%>
</div>
 <div style="text-align:left;" id="li_biao">　><a href="http://bp.redcome.com" target="_top">首页</a>>订单和下载</div>
<%}%>

<div id="wai">

<h1>订单和下载</h1>

<table id="table002" border=0 cellpadding=3 cellspacing=0 align="center" >
<tr>
<td nowrap width=40% class=padleft>第&nbsp;<%=pos/10+1%>&nbsp;页&nbsp;&nbsp;&nbsp;共&nbsp;<%=count/10+1%>&nbsp;页</td>
<td width=60% >订单和下载 (<%=count%>)&nbsp;</td>
</tr>
</table>
<form action="?">
<table border="0" cellpadding="0" cellspacing="2" id="table005">
  <tr>
    <td width="5%" align="center" nowrap>订单号</td>
    <td width="10%" align="center" nowrap>日期</td>
    <td width="10%" align="center" nowrap>图片编号</td>
    <td width="10%" align="center" nowrap>图片授权类型</td>
    <td width="10%" align="center" nowrap>图片大小</td>
    <td width="20%" align="center" nowrap>用途</td>
    <td width="10%" align="center" nowrap>价格</td>
    <td width="15%" align="center" nowrap>下载</td>
  </tr>
	<%
  java.util.Enumeration eu = Bimage.findByCommunity(teasession._strCommunity,sql.toString(),0,20);
  while(eu.hasMoreElements())
  {
    int ids = Integer.parseInt(String.valueOf(eu.nextElement()));
    Bimage bi = Bimage.find(ids);
    Baudit ba = Baudit.find(bi.getNode());

    Picture p = Picture.find(bi.getNode());
    Node n = Node.find(bi.getNode());
    String filetype = "";
    if(bi.getPicsize()==1)
    {
      filetype="extralarge";
    }else if(bi.getPicsize()==2)
    {
      filetype="large";
    }else if(bi.getPicsize()==3)
    {
      filetype="medium";
    }else if(bi.getPicsize()==4)
    {
      filetype="smalls";
    }else
    {
      filetype="extrasmall";
    }
    String path = "";
    String property = "";
    String ux = "无使用限制";
    if(ba.getProperty()==1)
    {
      property="免版税（RF）";
      path = "/res/"+teasession._strCommunity+"/salepic/"+ba.getMember()+"/"+ba.getTimes()+"/"+filetype+"/"+bi.getNode()+".jpg";

    }else
    {
      property="版权管理类（RM）";
      ux = "<script type=>document.write(f_find(aU,'"+bi.getImage_use()+"',2));</script>-----<script type=>document.write(f_find(aM,'"+bi.getImage_details()+"',3));</script>";
      path = "/res/"+teasession._strCommunity+"/salepic/"+ba.getMember()+"/"+ba.getTimes()+"/"+p.get_nName();
    }
    java.io.File ff = new java.io.File(application.getRealPath(path));

    %>
    <tr>
    <td align="center" nowrap><%=ids%></td>
      <td align="center" nowrap><%=bi.getPicsalesdateToString()%></td>
      <td align="center" nowrap>&nbsp;<%=bi.getNode()%></td>
      <td align="center" nowrap><%=property%></td>
      <td align="center" nowrap><%=ff.length()/1024/1024%>KB</td>
      <td><%=ux%></td>
      <td align="right" nowrap><%=bi.getPicprice()%></td>
      <td align="center" nowrap><a href="/jsp/include/DownFile.jsp?uri=<%=path%>&name=<%=bi.getNode()+".jpg"%>"><img src="/tea/image/netdisk/jpg.gif" />&nbsp;<%=bi.getNode()%></a></td>
    </tr>
    <%
    }
    %>
     <tr>
      <td colspan="7" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,10)%>
      </td>
    </tr>

    </table>
</form>

</div>
<%if(request.getParameter("back")!=null){%>
<div id="jspafter">
  <%=community.getJspAfter(teasession._nLanguage)%>
</div>
<%}%>

</body>

<!-- Stock photography -->
</html>
