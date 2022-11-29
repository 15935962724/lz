<%@ page contentType="text/html; charset=UTF-8" %>
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

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>Customer search activity  -  your images</title>
		  <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
	<style>
	#table001{background:#F6F6F6;border-bottom:10px solid #eee;border-top:10px solid #eee;padding:6px;width:95%;margin-top:10px;}
    #table001 td{padding:6px 15px;}
	#table005{width:95%;margin-top:15px;}
  #table005 td{background:#eee;padding:3px 10px 0 10px;}
  #table002 td{background:#eee;border-bottom:1px solid #ccc;height:30px;padding-top:6px;padding-bottom:6px;}
  #table002{width:95%;padding:6px;margin-top:20px;}
   #table007 td{background:#eee;border-bottom:1px solid #ccc;height:30px;padding:6px 15px;font-weight:bold;}
  #table007{width:95%;padding:6px;margin-top:20px;}
  #table006 td{background:#F6F6F6;border-bottom:5px solid #eee;height:30px;}
  #yi{padding-left:15px;}
  #yi1{padding-right:15px;}
  #yi2{border-bottom:1px solid #ccc;}
  #table008{width:95%;border:1px solid #ccc;MARGIN-top:25px;}
  #table008 td{padding:5px;}
  #txtGotopage{height:20px;border:1px solid #7F9DB9;background:#fff;line-height:20px;*line-height:14px;}
  #btnGotopage{height:20px;border:1px solid #7F9DB9;background:#fff;*line-height:12px;padding-bottom:3px;*paddding-bottom:0;width:35px;}
	</style>
  </HEAD>
<body style="margin:0;">
<div id="wai">
<div id="li_biao"><a href="http://bp.redcome.com">首页</a>&nbsp;>&nbsp;管理中心&nbsp;>&nbsp;关键词子页面</div>
      <h1>关键词子页面</h1>

      <table width="100%" border="0" cellspacing="0" cellpadding="0" id="table007">
        <tr>
          <td>Weijie Li-中国地下广场</td>
          <td align="right"> [&nbsp;27-10-2008 - 25-11-2008&nbsp;]</td>
        </tr>
      </table>


    <p>本页显示在这条搜索字体中图片的被浏览数和放大数，点击图片可修改图片中的关键字与之相关的信息。</p>
    <div class="symbols">
      <table width="0" border="0" cellspacing="2" cellpadding="0" id="table005">
        <tr>
          <td width="0" valign="middle">
            <img src="/tea/image/bpicture/zoom.gif" alt="Zoomed" width="37" height="23">          </td>
          <td>被放大 - 在此关键字中你的图片被大方的次数</td>
        </tr>
        <tr>
          <td valign="middle">
            <img src="/tea/image/bpicture/sold.gif" width="37" height="23">          </td>
          <td width="99%">销售 - 在此关键字中图片的销售数</td>
        </tr>
        <tr>
          <td valign="middle">
            <img src="/tea/image/bpicture/sales.gif" width="37" height="23">          </td>
          <td>这一时期的销售总额 - 在此关键字中图片的销售总数</td>
        </tr>
        <tr>
          <td valign="middle">
            <img src="/tea/image/bpicture/views.gif" width="37" height="23">          </td>
          <td>每张图片的总浏览数 - 在此关键字下图片被浏览的次数</td>
        </tr>
      </table>
      <p>图片被点击以蓝色突出显示e</p>
    </div>
	
    <table width="100%" border="0" cellspacing="0" cellpadding="0" id="table002">
      <tr>
        <td width="13%" id="yi">过滤显示条件 :</td>
        <td colspan="6"><select name="drpSortby" id="drpSortby" size="1" onChange="javascript:return ValidSortby();">
          <option value="0"> -- 请选择 -- </option>
          <option value="0" selected="1"> 所有被浏览过的图片 </option>
          <option value="1"> 被放大的图片 </option>
          <option value="2"> 销售的图片 </option>
          <option value="3"> Total sales for this period </option>
        </select>        </td>
      </tr>
      <tr id="table006">
        <td nowrap id="yi"><span class="thumbnail_sort_pagination">每页显示结果数:</span></td>
        <td width="5%"><span class="thumbnail_sort_pagination"><span class="nouline">
          <select name="drppagesize" id="drppagesize" size="1" onChange="javascript:this.form.submit();">
            <option value="6"> 6 </option>
            <option value="12"> 12 </option>
            <option value="18"> 18 </option>
            <option value="24"> 24 </option>
            <option value="48"> 48 </option>
            <option value="60"> 60 </option>
            <option value="84"> 84 </option>
            <option value="102" selected="1"> 102 </option>
          </select>
        </span></span></td>
        <td width="29%" align="center"><span class="thumbnail_sort_pagination">&nbsp;&nbsp; </span></td>
        <td width="1%" nowrap><span class="thumbnail_sort_pagination">跳转至</span></td>
        <td width="27%" nowrap>
          <input name="txtGoto" type="text" id="txtGotopage" class="input_small" maxlength="6" onKeyDown="javascript:return enterbutton();">
          <span class="thumbnail_sort_pagination">
          &nbsp;
          <input type="submit" name="btnGotopage" value="Go" id="btnGotopage" onClick="javascript:return Validpageno(1);">
        </span>        </td>
        <td width="1%">&nbsp;</td>
        <td width="24%" align="right" nowrap  id="yi1"><span class="thumbnail_sort_pagination">&nbsp;<span class="nouline">&lt;</span> 上一页

                  |

  下一页 <span class="nouline">&gt;</span></span></td>
      </tr>
    </table>
   <table width="100" border="0" cellspacing="0" cellpadding="2" id="table008">
            <tr>
            <td align="center" valign="bottom">
            <a href="#"><img src=" http://www.alamy.com/thumbs/2/9C3E869D-DD8B-4DA9-8BC2-27E197B806D7/B3HNGA.jpg "></a>            </td>
            </tr>
            <tr>
            <td align="center" id="yi2">
            B3HNGA            </td>
            </tr>
            <tr>
              <td align="center"><table border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td><img src="/tea/image/bpicture/zoom.gif" title="被放大"></td>
                  <td>:0 </td>
                  <td><img src="/tea/image/bpicture/sold.gif" title="销售"></td>
                  <td>:0 </td>
                  <td><img src="/tea/image/bpicture/sales.gif" title="这一时期的销售总额"></td>
                  <td>:0 </td>
                  <td><img src="/tea/image/bpicture/views.gif"title="每张图片的总浏览数"></td>
                  <td>:1</td>
                </tr>
              </table></td>
            </tr>
            </table>
		</form>
</div>
	</body>
</HTML>
