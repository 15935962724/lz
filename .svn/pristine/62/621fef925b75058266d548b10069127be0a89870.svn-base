<%@page contentType="text/html;charset=UTF-8"  %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="tea.entity.bpicture.*" %>
<%@ page import="tea.entity.node.*" %>
<%@page import="java.awt.image.*" %>
<%@page import="javax.imageio.*" %>
<%@page import="java.math.BigDecimal" %>
<%@ page import="tea.html.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="tea.htmlx.*"%>
<%@page import="tea.entity.site.*" %>
<%

TeaSession teasession = new TeaSession(request);
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

Community community=Community.find(teasession._strCommunity);
StringBuffer sql = new StringBuffer();
StringBuffer param = new StringBuffer();
int nodes = 0;
if(teasession.getParameter("nodes")!=null && teasession.getParameter("nodes").length()>0)
{
  nodes = Integer.parseInt(teasession.getParameter("nodes"));
}
Node node = Node.find(nodes);
BExifParam bep = BExifParam.find(nodes);
String picture="/res/"+node.getCommunity()+"/picture/"+nodes+".jpg";
String url = request.getRequestURI()+param.toString();
%>
<html>
<HEAD>
  <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
  <script> if(parent.lantk) { document.getElementsByTagName("LINK")[0].href="/res/csvclub/cssjs/community_02.css"; } </script>
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="" ></SCRIPT>
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/load.js" type="text/javascript"></SCRIPT>
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/csvclub/js.js" type=""></SCRIPT>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache"/>
  <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"/>
  <META HTTP-EQUIV="Expires" CONTENT="0"/>
  <title>图片信息</title>
<script language="javascript" type="">
//function open_Dialog(url,str)
//{
//    var title="模式窗口";
//
//    alert(11111);
//    var return_Value;
//    if (document.all&&window.print)
//    {
//    return_Value = window.showModalDialog(url,window,str);
//    alert(return_Value);
//    }
//    else
//    window.open(url,"","width=" + Width + "px,height=" + Height + "px,resizable=1,scrollbars=1");
//}
</script>

<style>
/*
.top{border-top:1px solid #cccccc;margin-top:15px;}
.top td{font-size:12px;line-height:150%;}
.top a{color:0000cc;}
#dv1{width:100%;text-align:right;font-size:12px;height:40px;background:url(/res/bigpic/u/0812/081247284.jpg) no-repeat 10 2;color:#0000CC;}
.lzj_a{margin:0 10px;color:#0000CC; text-decoration:none;}
#my-B-picture{color:#000;font-weight:bold;text-decoration:none;margin:0 10px;}
#sear{text-align:left;padding-left:70px;}
#qt{width:210px;height:23px;border:1px solid #809EBA;background:#fff;}
#lzj_bg{font-size:12px;}
#lzj_bg a{color:#0000cc;}
#lzj_an{width:45px;height:23px;background:url(/res/bigpic/u/0811/08111256.jpg) no-repeat;border:0;margin:0 10px;}
.kuan{border:0;}
*/
#lzj_zong{border-top:1px solid #67A7E4;padding-top:25px;padding-bottom:80px;}
#tablecenter003{width:100%;font-size:12px;}
#tablecenter003 td{border-bottom:1px solid #cccccc;padding:5px 15px;}
#lzj_zdi{background:#F6F6F6;}
#lzj_kong td{border:0;}
</style>
</head>

<body style="margin:0;padding:0;">

<div id="wai">
<h1>图片数码信息</h1>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter003">
<tr>
<td width="20%" align="right">图片名称</td>
<td><%=nodes%></td>
<td width="50%" rowspan="20" align="left" valign="top"><img alt="" src="<%=picture%>"  /></td>
</tr>
<tr>
<td align="right">图片作者</td>
<td><%if(bep.getArtist()!=null)out.print(bep.getArtist());%>&nbsp;</td>
</tr>
<tr>
<td align="right">相机品牌</td>
<td><%if(bep.getMake()!=null)out.print(bep.getMake());%>&nbsp;</td>
</tr>
<tr>
<td align="right">相机型号</td>
<td><%if(bep.getModel()!=null)out.print(bep.getModel());%>&nbsp;</td>
</tr>
<tr>
<td align="right">拍摄时间</td>
<td><%if(bep.getDatetimeToString()!=null)out.print(bep.getDatetimeToString());%>&nbsp;</td>
</tr>
<tr>
<td align="right">光圈系数</td>
<td><%if(bep.getFnumber()!=null)out.print(bep.getFnumber());%>&nbsp;</td>
</tr>
<tr>
<td align="right">GPS定位</td>
<td><%if(bep.getgpsinfo()!=null)out.print(bep.getgpsinfo());%>&nbsp;</td>
</tr>
<tr>
<td align="right">曝光补偿</td>
<td><%if(bep.getExposurebasvalue()!=null)out.print(bep.getExposurebasvalue());%>&nbsp;</td>
</tr>
<tr>
<td align="right">最大光圈</td>
<td><%if(bep.getMaxaperturevalue()!=null)out.print(bep.getMaxaperturevalue());%>&nbsp;</td>
</tr>
<tr>
<td align="right">测光方式</td>
<td><%if(bep.getMeteringmode()!=null)out.print(bep.getMeteringmode());%>&nbsp;</td>
</tr>
<tr>
<td align="right">光源</td>
<td><%if(bep.getLightsource()!=null)out.print(bep.getLightsource());%>&nbsp;</td>
</tr>
<tr>
<td align="right">焦距</td>
<td><%if(bep.getFocallength()!=null)out.print(bep.getFocallength());%>&nbsp;</td>
</tr>
</table>
</div>

</body>
</html>
