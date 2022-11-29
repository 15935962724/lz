<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.entity.bpicture.*" %>
<%@ page import="java.util.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="java.math.BigDecimal" %>
<%@page import="java.io.*" %>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("progma","no-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires",0);
TeaSession teasession =new TeaSession(request);
tea.entity.site.Community community=tea.entity.site.Community.find(teasession._strCommunity);
if(teasession._rv==null)
{
  response.sendRedirect("/jsp/user/StartLogin.jsp?nexturl="+request.getRequestURI());
}
%>
<HTML>
  <HEAD>
    <title>Customer search activity - your images</title>
   <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<style>
#table002 td{background:#eee;border-bottom:1px solid #ccc;height:30px;padding:6px;}
#table002{width:95%;padding:6px;margin-top:20px;}
#tablecenter0002{width:95%;}
#table005{width:95%;margin-top:15px;}
#table005 td{background:#eee;padding:6px;}
.excel_export{height:35px;line-height:35px;}
#table001{background:#F6F6F6;border-bottom:10px solid #eee;border-top:10px solid #eee;padding:6px;width:95%;margin-top:10px;}
#table001 td{padding:6px 15px;}
#Hyprlnkexprtexcel{display:block;width:100px;height:22px;border:1px solid #7F9DB9;background:#fff;text-align:center;line-height:22px;margin-top:15px;color:#222222;}
#table006 td{background:#F6F6F6;border-bottom:5px solid #eee;height:30px;}
.input_small,#bdpStart,#bdpEnd{height:23px;border:1px solid #7F9DB9;background:#fff;line-height:20px;*line-height:17px;}
.btn_go{height:23px;border:1px solid #7F9DB9;background:#fff;line-height:20px;*line-height:14px;padding-bottom:5px;*paddding-bottom:0;width:35px;}
</style>
  </HEAD>
  <body onLoad="ol('r1')" style="margin:0;">
<div id="wai">

<div id="li_biao"><a href="http://bp.redcome.com">首页</a>&nbsp;>&nbsp;管理中心&nbsp;>&nbsp;摄影师</div>
        <h1>摄影师 - Weijie Li</h1>
        <p>该页显示在特定时间范围内你的图片被客户搜索并看到. 该栏目右边的搜索条件 您图片的显示与其他供应商的图片进行对比。
        </p>
       <form action="?" name="fm" method="POST">

          <table width="500" border="0" cellPadding="2" cellSpacing="0" id="table002">
            <tr>
              <td><input id="r1" type="radio" name="r2" value="r1" onClick="ol(this.id)" checked="checked" /></td>
              <td colSpan="6"><select name="drpDate" id="drpDate">
                <option value="1">昨天</option>
                <option value="2">过去7天</option>
                <option value="3">上周（1-6）</option>
                <option value="4">上个工作周（1-5）</option>
                <option value="5">本月</option>
                <option value="6">上个月</option>

</select></td>
            </tr>
            <tr id="table006">
              <td><input id="r2" type="radio" name="r2" value="r2" onClick="ol(this.id)"/></td>
              <td><input id="bdpStart" name="bdpStart" type="text" value=""   /></td>
                <td><img id="bdpStart_image" class="bdplButton " alt="" onClick="showCalendar(bdpStart,'');" src="/tea/image/bpicture/date.gif"  border="0" /></td>
                  <td><input id="bdpEnd" name="bdpEnd" type="text" value="" /></td>
                  <td><img id="bdpEnd_image" class="bdplButton " alt="" onClick="showCalendar(bdpEnd,'');" src="/tea/image/bpicture/date.gif"  border="0" /></td>
                  <td><input type="submit" name="BtnGo" value="Go" id="BtnGo" class="btn_go" onClick="return isDate('bdpStart','bdpEnd','25-Nov-2008')" /></td>
                  <td width="150%">&nbsp;</td>
            </tr>
          </table>
       </form>

            <table cellSpacing="0" cellPadding="0" border="0" id="table002">
              <tr>
                <td width="30%">每页结果数:
                  <select name="drppagesize" onChange="__doPostBack('drppagesize','')" language="javascript" id="drppagesize" style="font-family:Arial;">
                    <option selected="selected" value="20">20</option>
                    <option value="50">50</option>
                    <option value="100">100</option>

                  </select></td>
                  <td width="21%"><span id="lblPageof" style="background-color:#F9F9F9;"> </span></td>
                  <td width="34%">跳转至:
                <input name="txtGotopage" type="text" maxlength="6" id="txtGotopage" tabindex="1" class="input_small" onKeyDown="if(event.which || event.keyCode){if ((event.which == 13) || (event.keyCode == 13)) {document.getElementById('btnGotopage').click();return false;}} else {return true}; " onKeyPress="return disableEnterKey(event);" />&nbsp;<input type="submit" name="btnGotopage" value="Go" id="btnGotopage" tabindex="2" class="btn_go" OnClick="return Validpageno(0)" /></td>
                    <td width="15%" align="center"><span class="btns_right">< 上一页 | &nbsp;  下一页 >
                      </span></td>
              </tr>
            </table>


                <table class="listingtable" cellspacing="2" rules="all" border="0" id="table005" >
              <tr>
              <td colspan="10">
              CTR=（图片被放大次数&nbsp;/&nbsp;图片被浏览次数 ）*100
              </td>
              </tr>
                <tr class="listingtableheader" >
                  <td nowrap>搜索字词</td>
                  <td nowrap>被浏览过的图片数</td>
                  <td nowrap>Sessions(有效点击?)</td>
                  <td nowrap>图片被放大数</td>
                  <td nowrap>销售数</td>
                  <td nowrap>Your CTR(%)</td>
                  <td nowrap>总浏览数</td>
                  <td nowrap>总放大数</td><td nowrap>Total CTR(%)</td>
                </tr><tr style="color:#000066;">
                  <td align="Left" style="width:25%;">
                    <a id="grdPseudo__ctl2_PseudoLink" href="/jsp/bpicture/saler/Saler_SearchImage.jsp">关键词子页面</a>
                  </td><td align="Right" style="color:Black;">2</td><td align="Right" style="color:Black;">1</td><td align="Right" style="color:Black;">
                    <a id="grdPseudo__ctl2_ZoomLink">0</a>
                  </td><td align="Right" style="color:Black;">
                    <a id="grdPseudo__ctl2_Saleslink">0</a>
                  </td><td align="Right" style="color:Black;">0.00</td><td align="Right" style="color:Black;">1,938</td><td align="Right" style="color:Black;">11</td><td align="Right" style="color:Black;">0.57</td>
                </tr>
  </table>

<div class="excel_export"><a id="Hyprlnkexprtexcel" OnClick="javascript:window.open('PseudoViews.aspx?export=1&amp;pseudo=61599&amp;sdate=27/Oct/2008&amp;edate=25/Nov/2008&amp;hidid={61A07B9C-D56C-48AE-9687-C2A97906494F}')" href="#">导出Excel</a></div>

  <table cellSpacing="2" cellPadding="5" border="0" id="table005">
    <tr>
      <td width="190"><span id="lbltview" style="background-color:#F9F9F9;"> Weijie Li 的总浏览数:</span></td>
      <td width="899" class="txt_bold txt_align_right"><span id="lblTotalViews" style="background-color:#F9F9F9;">18</span></td>
    </tr>
    <tr>
      <td><span id="lbltzooms" style="background-color:#F9F9F9;"> Weijie Li 的总放大数:</span></td>
      <td class="txt_bold txt_align_right"><span id="lblTotalZooms" style="background-color:#F9F9F9;">0</span></td>
    </tr>
    <tr>
      <td nowrap="nowrap"><dfn title="Sum of CTRs / number of search terms">Average CTR</dfn> <span id="lblavgztv" style="background-color:#F9F9F9;"> for Weijie Li:</span></td>
      <td class="txt_bold txt_align_right"><span id="lblRatio" style="background-color:#F9F9F9;">0.00</span></td>
    </tr>
    <tr>
      <td nowrap="nowrap"><dfn title="Total zooms / Total views x 100 for the pseudonym">Total CTR </dfn> <span id="lbltotalztv" style="background-color:#F9F9F9;"> for Weijie Li:</span></td>
      <td class="txt_bold txt_align_right"><span id="lblztvtotalratio" style="background-color:#F9F9F9;">0.00</span></td>
    </tr>
  </table>
  <table class="suffix" cellSpacing="0" cellPadding="5" border="0" id="table001">
    <tr>
      <td height="35"><b>名词解释</b></td>
    </tr>
    <tr>
      <td >L - 版权 </td>
    </tr>
    <tr>
      <td >RF - 免税 </td>
    </tr>
    <tr>
      <td >PR - 产权发布</td>
    </tr>
    <tr>
      <td>MR - 肖像权</td>
    </tr>
    <tr>
      <td >Land - 景观 </td>
    </tr>
    <tr>
      <td >Pt - 肖像 </td>
    </tr>
    <tr>
      <td >Pan - 全景 </td>
    </tr>
    <tr>
      <td >Sq - Square </td>
    </tr>
    <tr>
      <td height="35" >LU - 限用 </td>
    </tr>
  </table>
  <%@include file="/jsp/include/Calendar3.jsp" %>
  <script type="">
  function ol(id){
    if(id =='r2'){
      document.getElementById('drpDate').disabled=true;
      document.getElementById('bdpStart').disabled=false;
      document.getElementById('bdpEnd').disabled=false;
    }
    if(id =='r1'){
      document.getElementById('drpDate').disabled=false;
      document.getElementById('bdpStart').disabled=true;
      document.getElementById('bdpEnd').disabled=true;
    }
  }
   </script>
  </div>
  </body>

</HTML>

