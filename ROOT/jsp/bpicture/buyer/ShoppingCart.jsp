<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.entity.bpicture.*" %>
<%@ page import="java.util.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="java.math.BigDecimal" %>
<%@page import="java.io.*" %>
<%@ page import="java.awt.image.*" %>
<%@ page import="javax.imageio.*" %>
<%@page import="tea.db.*" %>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("progma","no-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires",0);
TeaSession teasession =new TeaSession(request);
tea.entity.site.Community community=tea.entity.site.Community.find(teasession._strCommunity);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/Node?node=2198284&language=1");
  return;
}
String member = request.getParameter("member");
if(member == null)
{
  member = teasession._rv._strR;
}

Bperson bp = Bperson.find(Bperson.findId(member));
String lightbox = request.getParameter("lightbox");

if(lightbox==null)
{
  lightbox = bp.getCurrentlightbox();
}

StringBuffer sql = new StringBuffer(" and (isorder != 1 or isorder is null)");

sql.append(" and  picsalestype!=1");
String nexturl = request.getRequestURI();
%>
<html>
<!-- Stock photography -->
<head>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/load.js" type="text/javascript"></SCRIPT>
<script type="">

function c_jax()
{
    currentPos = 'lit_'+document.frm1.nod.value;
    var url = "/jsp/bpicture/Lightbox_ajax.jsp?act=lit&pic="+document.frm1.nod.value;
    url = encodeURI(url);
    send_request(url);
    document.getElementById('light').style.display='none';
}

      function currn_jax(me)
      {
        currentPos = me;
        var url = "/jsp/bpicture/buyer/CurrentLightbox_ajax.jsp?lightbox="+me.value;
        url = encodeURI(url);
        send_request(url);
      }

</script>

  <title>购物车</title>
  <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
</head>

<body style="margin:0;">
<%if(request.getParameter("back")!=null){%>

<div id="jspbefore">
  <%=community.getJspBefore(teasession._nLanguage)%>
</div>
 <div style="text-align:left;" id="li_biao">　><a href="http://bp.redcome.com" target="_top">首页</a>>购物车</div>
<%}%>
<div id="wai">
<h1>购物车</h1>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter002" width="100%">
  <tr class="bg8">
    <td width="90%" nowrap="1" class="padleft"><%if(Bimage.countPic(member,sql.toString())==0){
    out.print("你的购物车暂无图片,马上去<a href='/servlet/Node?node=2199934&language=1' target='_top'>选购图片</a>!");
    }else{%><b>您的购物车包含
      <a href="#top"><%=Bimage.countPic(member,sql.toString())%> 张图片</a>

      共计 <span class="red">RMB  <%if(Bimage.countSumMoney(" and member="+DbAdapter.cite(member)+sql.toString())!=null){out.print(Bimage.countSumMoney(" and member="+DbAdapter.cite(member)+sql.toString()));}else{out.print("0.00");}%></span></b>
      , 还有
      <%=Bimage.countNoPrice(member) %> 张图片 需要定价
    <%}%></td>
    <form Name="pay" Method="POST" Action="?">
    <input type="hidden" name="id" value="<%=request.getParameter("id")%>"/>
    <td width="5%" align="right" class="padright">
        <input type="submit" value="去结帐">
      </td>
    </form>
  </tr>
</table>
<table border="0" cellpadding="0" cellspacing="3" id="tablecenter003" style="width:95%;">
  <tr valign="top" id="lzj_di">
    <td colspan="3"><%if(Bimage.countNoPrice(member)!=0){
    out.print("这些图片需要定价: ");
    Enumeration npi = Bimage.noPriceImage(member,sql.toString());
    if(npi.hasMoreElements())
    {
      while(npi.hasMoreElements())
      {
        int pid = ((Integer)npi.nextElement()).intValue();
        out.print("<a href=#"+pid+"><img width=40 border=0 src=/res/"+teasession._strCommunity+"/picture/small/"+pid+".jpg></a>　");
      }
    }
  }
    %>      </td>
  </tr>

  <%
  Enumeration sc = Bimage.findShopping(" and member="+DbAdapter.cite(member)+sql.toString());
  while(sc.hasMoreElements()){
    int id = ((Integer) sc.nextElement()).intValue();
    Bimage bi = Bimage.find(id);

    int picid = bi.getNode();
    Baudit ba = Baudit.find(picid);
    Profile pro = Profile.find(ba.getMember());
    Picture p = Picture.find(picid);
    String picture ="/res/"+teasession._strCommunity+"/picture/"+picid+".jpg";

    File f=new File(application.getRealPath(picture));
    int width=0,height=0;

    if(f.isFile())
    {
      width=p.getWidth(teasession._nLanguage);
      height=p.getHeight(teasession._nLanguage);
    }

    float filesize=(int)(width*height*3F/(1024*1024));
    Node n = Node.find(picid);

%>
  <tr valign="top" id="lzj_nei">
    <td width="40%" align="right"><a name="<%=picid%>"></a>

      <a href='/jsp/bpicture/ImageInfo.jsp?nodes=<%=picid%>&back=1' target="_blank">
        <img alt="图片信息" height=265 border="0" src="<%=picture%>">      </a>
      <div align="right" >
        <span>最大文件大小:<span>&nbsp;<%=filesize%>&nbsp;MB</span></span>      </div></td>
    <td width="5" align="right">&nbsp;</td>
    <td width="470" class="bg8">
  <table width="95%" class="bgl" border="0" cellspacing="0" cellpadding="0" id="tablecenter004">
  <tr>
    <td valign="middle"><b><%=picid%></b></td>
    <td align="right" valign="middle">
    <%
    if(ba.getProperty() == 1)
    {

      out.print("免版税图片 - <font color=#FE8100>RF</font>");

    }else{

      out.print("版权管理类图片 - <font color=blue>RM</font>");

    }
    %>    </td>
  </tr>
</table>
<table width="95%" border="0" cellpadding="0" cellspacing="5" id="tablecenter005">
  <tr>
    <td width="25%"><table cellspacing="0" cellpadding="0" border="0">
      <tr>
        <td><a href='/jsp/bpicture/ImageInfo.jsp?nodes=<%=picid%>&back=1' target="blank"><img src="/tea/image/bpicture/image_details.gif" alt="图片信息" width="17" height="17" vspace="4" border="0"></a></td>
          <td height="26" nowrap="1"><a href='/jsp/bpicture/ImageInfo.jsp?nodes=<%=picid%>&back=1' target="blank">
            &nbsp;图片信息</a></td>
      </tr>
      <tr>
        <td><span id=lit_<%=picid%>><a href=### onclick='c_seat(lit_<%=picid%>,light,<%=picid%>);'><img src="/tea/image/bpicture/add_lightbox.gif" alt="添加至收藏夹" width=17 height=17 border=0 name=l1></a></td>
          <td height="26" nowrap="1"><a href="###" onclick='c_seat(lit_<%=picid%>,light,<%=picid%>);'>&nbsp;添加至收藏夹</a></td>
      </tr>
      <form method="post" name="form1">
      <tr>
      <td>
        <a href="#" onClick="if(confirm('确定把该图片移出购物车？')){window.location.href='/jsp/bpicture/buyer/AddShopping.jsp?act=del&node=<%=picid%>&nexturl=/jsp/bpicture/buyer/ShoppingCart.jsp';}return false;">
          <img src="/tea/image/bpicture/remove_cart.gif" alt="从购物车中移除" width="17" height="17" vspace="4" border="0"></a>      </td>
        <td height="26" nowrap="1"><a href="#" onClick="if(confirm('确定把该图片移出购物车？')){window.location.href='/jsp/bpicture/buyer/AddShopping.jsp?act=del&node=<%=picid%>&nexturl=/jsp/bpicture/buyer/ShoppingCart.jsp';}return false;">
          &nbsp;从购物车中移除</a></td>
  </tr>
      </form>
      <tr>
        <td width="17"><a href="/jsp/bpicture/buyer/CalPrice.jsp?back=1&id=<%=id%>&nodes=<%=picid%>&nu=<%=nexturl%>">
          <img width="17" height="17" border="0" src="/tea/image/bpicture/cal_price.gif" alt="计算价格"></a></td>
        <td height="26" nowrap="1"><a href="/jsp/bpicture/buyer/CalPrice.jsp?id=<%=id%>&nodes=<%=picid%>&nu=<%=nexturl%>">
        &nbsp;计算价格
    </a></td>
      </tr>
</table></td>
<td width="71%" class="bg9" align="center">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" id="tablecenter006">
  <tr valign="top">
    <td colspan="2" valign="middle" id="wu_01">销售咨询，请与我们联系:</td>
  </tr>
  <tr valign="bottom">
    <td width="30%" valign="middle" nowrap="">Email:<br>
        地址：                              <br>
      联系电话:<br>
      传真：</td>
<td width="70%" nowrap=""><a href="mailto:service@redcome.com">service@redcome.com</a><br>北京朝阳区北苑路傲城融富中心B座1701<br />84909966<br />84909900</td>
  </tr>
</table>    </td>
  <td width="4%" rowspan="6" align="center">&nbsp;</td>
  </tr>
  <tr>
    <td align="right" valign="middle">价格</td>
    <td class="bgw"><strong>&nbsp;&nbsp;RMB  <%if(bi.getPicprice().intValue()==0){%>0.00&nbsp;-&nbsp;<font color="red">这张图片需要计算价格</font><%}else{out.print(bi.getPicprice());}%></strong></td>
    </tr>
  <tr valign="top">
    <td align="right" valign="middle"><strong>图片详细</strong></td>
    <td></td>
    </tr>
  <tr valign="top">
    <td align="right" valign="middle">图片说明</td>
    <td class="bgw">&nbsp;&nbsp;<%=n.getSubject(1)%>&nbsp;</td>
    </tr>
  <tr valign="top">
    <td align="right" valign="middle">摄影师</td>
    <td class="bgw">&nbsp;&nbsp;<%if(pro.getLastName(1)!=null)out.print(pro.getLastName(1));%>&nbsp;</td>
    </tr>
  <tr>
    <td align="right" valign="middle">权利保护</td>
    <td class="bgw" nowrap="1">&nbsp;&nbsp;肖像权:

    <%if(ba.getPhotography()==1){out.print("有");}else if(ba.getPhotography()==2){out.print("没有");}else{out.print("不需要");}%>
    <b>/</b> 物产权:

        <%if(ba.getDesign()==1){out.print("有");}else if(ba.getDesign()==2){out.print("没有");}else{out.print("不需要");}%>   </td>
    </tr>
</table></td>
</tr>
<%}%>
</table>
</div>
<div id="light" style="display:none;border:1px solid #cccccc;width:150px;position:absolute;z-index:99;background-color:#E0EDFE;">

  <form id="frmMain" name="frm1" action="?" method="get">
  <input type="hidden" name="id" value="<%=request.getParameter("id")%>"/>
  <input type="hidden" name="nod"/>
  <table>
    <tr>
      <td align="center"><b>选择收藏夹</b></td>
      </tr>
      <tr>
      <td align="center">
        <select id="Lightboxes" class="lightbox" name="lightbox" onChange="currn_jax(this)" style="WIDTH: 104;">
        <%
        Enumeration e = BLightbox.findLightBox(teasession._rv._strR);
        if(e.hasMoreElements()){
          while(e.hasMoreElements()){
            String elment = e.nextElement().toString();
            if(lightbox.equals(elment)){
              out.print("<option value="+elment+" selected>"+elment+"</option>");
            }else{
              out.print("<option value="+elment+">"+elment+"</option>");
            }
          }
        }
        %>
        </select>
      </td>
    </tr>
    <tr>
    <td align="center"><input type="button" value="收藏" onClick="c_jax()"/></td>
    </tr>
  </table>
</form>
</div>
<%if(request.getParameter("back")!=null){%>
<div id="jspafter">
  <%=community.getJspAfter(teasession._nLanguage)%>
</div>
<%}%>
<script type="">
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
    function c_seat(id,m,ids)
    {
      document.frm1.nod.value=ids;

      m.style.display='none';
      if(id!=cm)
      {
        m.style.display='';
        m.style.pixelLeft = getPos(id,"Left")-25;
        m.style.pixelTop = getPos(id,"Top") + id.offsetHeight+10;
        cm=id;
      }else
      {
        m.style.display='none';
        cm=null;
      }
    }
</script>
</body>

<!-- Stock photography -->
</html>
