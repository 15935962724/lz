<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.entity.bpicture.*" %>
<%@ page import="java.util.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="java.math.BigDecimal" %>
<%@page import="java.io.*" %>
<%@ page import="java.awt.image.*" %>
<%@ page import="javax.imageio.*" %>
<%@page import="tea.db.*" %>
<%@page import="tea.entity.member.*" %>
<%

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);


StringBuffer sql = new StringBuffer(" and isorder=1");
StringBuffer param = new StringBuffer("?community="+teasession._strCommunity);

String update= "";
if(request.getParameter("update")!=null&&request.getParameter("update").length()>0)
{
  update = request.getParameter("update");

  sql.append(" and datediff(day,orderdate,"+DbAdapter.cite(update)+")=0");
  param.append("&update=").append(update);
}

String picid= request.getParameter("picid");
if(picid!=null&&picid.length()>0)
{
  sql.append(" and node like ").append("'%"+picid+"%'");
  param.append("&picid=").append(picid);
}

int pos=0;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}
param.append("&pos=").append(pos);

String audit = request.getParameter("audit");

if(audit!=null)
{
  int iaudit = Integer.parseInt(audit);
  String saler = teasession.getParameter("saler");

    Profile p = Profile.find(saler);
  try
  {
    tea.service.SendEmaily se = new tea.service.SendEmaily(teasession._strCommunity);
    String sexs =p.isSex()? "女士" : "先生";
    StringBuffer sb = new StringBuffer();
    if(iaudit == 1){
    sb.append("尊敬的&nbsp;" + p.getFirstName(teasession._nLanguage) + sexs + "&nbsp;您好:<br/>　　B-picture中有你需要的编号为"+teasession.getParameter("nod")+"，图片大小为"+teasession.getParameter("psize")+"，价格为"+teasession.getParameter("price")+"元，如需购买请您尽快与我们联系！<br/>");
    }
    else{
    sb.append("尊敬的&nbsp;" + p.getFirstName(teasession._nLanguage) + sexs + "&nbsp;您好:<br/>　　B-picture暂时无法提供您需要的图片，如有会及时通知。<br/>");
    }
    se.sendEmail(saler,"B-picture商业图片网审核消息",sb.toString());

  } catch(Exception ex)
  {
    ex.printStackTrace();
    String url = "/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("邮件发送失败,请检查是否存在该邮箱！","UTF-8");
    response.sendRedirect(url);
    return;
  }finally{

  }
}


int count=0;
count = Bimage.countOrfer(sql.toString());
%>
<html>
<HEAD>
  <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
  <script> if(parent.lantk) { document.getElementsByTagName("LINK")[0].href="/res/csvclub/cssjs/community_02.css"; } </script>
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="" ></SCRIPT>
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/csvclub/js.js" type=""></SCRIPT>
    <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/load.js" type="text/javascript"></SCRIPT>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
      <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
        <META HTTP-EQUIV="Expires" CONTENT="0">
          <title>图片订购</title>

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
<div id="li_biao"><a href="http://bp.redcome.com">首页</a>&nbsp;>&nbsp;管理中心&nbsp;>&nbsp;图片订购</div>

<H1>图片订购</H1>
<form action="?" name="form1" method="POST">
<input type="hidden" name="id" value="<%=request.getParameter("id")%>"/>
<table border="0" cellpadding="0" cellspacing="2" id="table002">
  <tr>
    <td>订购日期</td>
    <td width="258"><input type="text" size="28" name="update" value="<%if(update!=null)out.print(update);%>" readonly="readonly" onclick="new Calendar('2006', '2010', 0,'yyyy-MM-dd').show(this);"/></td>
    <td>图片名称</td>
    <td><input type="text" size="28" name="picid" value="<%if(picid!=null)out.print(picid);%>"/></td>
    <td width="180"><input type="submit" value="查询"/></td>
  </tr>
</table>
</form>
<h2>订购列表（<%=count%>）</h2>
<table border="0" cellpadding="0" cellspacing="2" id="table002">
  <tr id="tableonetr">
  <td align="center" width="20%">订购日期</td>
    <td align="center" width="265">会员ID</td>
    <td align="center" width="15%">手机</td>
    <td align="center" width="15%">图片名称</td>
    <td align="center" width="10%">订购尺寸</td>
    <td align="center" width="10%">价格</td>
    <td align="center">操作</td>
    </tr>
    <%
    Enumeration emtimes = Bimage.findShopping(sql.toString());
    if(!emtimes.hasMoreElements())
    {
      %>   <tr><td colspan="10" align="center">暂无信息</td>
      </tr>
      <%
    }
    while(emtimes.hasMoreElements()){
      int id = ((Integer) emtimes.nextElement()).intValue();
    Bimage bi = Bimage.find(id);
    Bperson b = Bperson.findmember(bi.getMember());
       %>
       <tr>
       <td align="center"><%=bi.getOrderToString() %></td>
       <td id="mem<%=id%>" align="center"><a href="###" onclick="c_seat(mem<%=id%>,othe,'<%=bi.getMember()%>');"><%=bi.getMember()%></a></td>
       <td align="center"><%=b.getMobile() %></td>
       <td align="center"><a href="/jsp/bpicture/ImageExifParam.jsp?nodes=<%=bi.getNode()%>"><%=bi.getNode()%></a></td>
       <td align="center"><%=bi.getPsize()%>MB</td>
       <td align="center"><%=bi.getPicprice()%></td>
       <td align="center"><input type="button" value="符合条件" onClick="window.location.href='/jsp/bpicture/OrderingImage.jsp?saler=<%=b.getMember()%>&nod=<%=bi.getNode()%>&psize=<%=bi.getPsize()%>&price=<%=bi.getPicprice()%>&audit=1&pos=<%=pos%>';"/>
         <input type="button" value="暂无此图" onClick="window.location.href='/jsp/bpicture/OrderingImage.jsp?saler=<%=b.getMember()%>&audit=0&pos=<%=pos%>';"/></td>
       </tr>
<%} %>
    <tr>
    <td align="center" colspan="7">

      <%if(count>10)
      {
        out.print(new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,10));
      }%>

    </td>
  </tr>
  </TABLE>
 <%@include file="/jsp/include/Canlendar4.jsp" %>
<div id="othe" style="display:none;width:275px;height:170px;border:1px solid #ccc;position:absolute;z-index:99;background-color:#E0EDFE;">
    </div>
</div>

    <script type="text/javascript"">
    var cm = null;

    function getPos(el,sProp)
    {
      var iPos = 0 ;
      　　while (el!=null)   　　
      {
        iPos+=el["offset" + sProp];
        　el = el.offsetParent;
      }
      　　return iPos;
    }
    function c_seat(id,m,mem)
    {
      currentPos = 'othe';
      var url = "/jsp/bpicture/Lightbox_ajax.jsp?act=meminfo&member="+mem;
      url = encodeURI(url);
      send_request(url);

      m.style.display='none';
      if(id!=cm)
      {
        m.style.display='';
        m.style.pixelLeft = getPos(id,"Left");
        m.style.pixelTop = getPos(id,"Top") + id.offsetHeight+3;
        cm=id;
      }else
      {
        m.style.display='none';
        cm=null;
      }
    }
    </script>
</body>
</html>
