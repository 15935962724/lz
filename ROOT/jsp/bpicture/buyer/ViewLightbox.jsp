<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.entity.bpicture.*" %>
<%@ page import="java.util.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="java.math.BigDecimal" %>
<%@page import="java.io.*" %>
<%@page import="tea.entity.site.*" %>
<%
response.setHeader("progma","no-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires",0);

TeaSession teasession =new TeaSession(request);
Community community = Community.find(teasession._strCommunity);
Resource r = new Resource("/tea/ui/util/SignUp1").add("/tea/htmlx/HtmlX");

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
//Bperson.setCurrn(email,lightbox);
int lbid = BLightbox.findId(member,lightbox);
BLightbox blb = BLightbox.find(lbid);

String picid = blb.getpicid();
String act = request.getParameter("act");




int count = 0;
int pos = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}
int pageSize=2;
if (request.getParameter("npgs") != null) {
  pageSize = Integer.parseInt(request.getParameter("npgs"));
}




%>
<html>
<!-- Stock photography -->
<head>

<title>查看收藏夹</title>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/load.js" type="text/javascript"></SCRIPT>
<script type="">
function c_jax(me)
      {
        currentPos = me;
        var url = "/jsp/bpicture/Lightbox_ajax.jsp?act=cart&pic="+me+"&lightbox=<%=lightbox%>";
        url = encodeURI(url);
        send_request(url);
      }
function s_change(obj)
{

  document.frm1.submit();
}

function k_send(name,pnode)
{
  var lv = document.getElementById(name).value;
  if(lv.length>99){
    alert('图片描述的字数不能多于99');
  }else{
    document.movepic.lbvalue.value = name+","+pnode;
    document.movepic.act.value = 'caption';
    document.movepic.submit();
  }

}

function j_send(name,pnode)
{
  var lv = document.getElementById(name).value;
  var curr = '<%=lightbox%>';
  if(lv == 0)
  {
    alert("请选择一个收藏夹");
  }else if(lv == curr)
  {
    alert("不能选择相同的收藏夹");
  }else
  {
    document.movepic.lbvalue.value = name+","+pnode;
    document.movepic.act.value = 'move';
    document.movepic.submit();
  }
}
</script>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">

<style>
.big{text-align:left;font-size:14px;margin:10 30px;}
#table001{background:#F6F6F6;border-bottom:5px solid #eee;border-top:5px solid #eee;padding:6px;}
#lzj_img img{height:125px;margin-right:10px;}
#email,#firstname,#oldpwd,#newpwd,#confirmpwd{width:300px;height:22px;font-size:12px;line-height:15px;border:1px solid #7F9DB9;}
#submit,.Button{width:70px;height:22px;font-size:12px;line-height:15px;border:1px solid #7F9DB9;background:#fff;}
#table003 td{background:#eee;border-bottom:1px solid #ccc;height:30px;padding:6px;}
#table003{width:95%;padding:6px;margin:10px;}
#lzj_img_01{background:#D6E6FF;}
.lightbox{width:100%;border:1px solid #7F9DB9;background:#fff;height:22px;font-size:12px;line-height:22px;}
.lzj_001{width:100%;border:1px solid #7F9DB9;background:#fff;height:36px;font-size:12px;line-height:150%;padding:3px;}
#table002{margin-top:10px;padding:0;width:600px;}
#table002 td{padding:0;}
.lzj_002{border:1px solid #7F9DB9;background:#fff;height:22px;font-size:12px;line-height:22px;*line-height:18px;padding-bottom:5px;*padding:0;}
</style>
</head>

<body style="margin:0;">
<%if(request.getParameter("back")!=null&&request.getParameter("back").equals("1")){%>
<div id="jspbefore">
  <%=community.getJspBefore(teasession._nLanguage)%>
</div>
 <div style="text-align:left;" id="li_biao">　><a href="http://bp.redcome.com" target="_top">首页</a>>收藏夹</div>
<%}%>
<div id="wai"><!--Onload="page_onload()"--><!--Uncomment Onload function to start recording thumbsloadtime & htmlLoadtime-->
<h1>查看当前收藏夹</h1>

<table width=100% cellpadding=2 cellspacing=0 border=0 id="tablecenter001">
<tr class=bg8>
<td class="padright" colspan="10" align="right">
查看当前收藏夹&nbsp;|&nbsp;<a href="/jsp/bpicture/buyer/CreateLightbox.jsp?back=<%=request.getParameter("back")%>">创建收藏夹</a>&nbsp;|&nbsp;<a href="/jsp/bpicture/buyer/RenameLightbox.jsp?back=<%=request.getParameter("back")%>">收藏夹重命名</a>&nbsp;|&nbsp;<a href="/jsp/bpicture/buyer/DeleteLightbox.jsp?back=<%=request.getParameter("back")%>">删除收藏夹</a>
</td>
</tr>
  <tr class=bg8>
    <form id="frmMain" name="frm1" action="?" method="get">
    <input type="hidden" name="id" value="<%=request.getParameter("id")%>"/>
    <input type="hidden" name="back" value="<%=request.getParameter("back")%>"/>
    <td width="90%" class="padleft">当前收藏夹</td>
    <td width="10%" class="padright">
      <select id="Lightboxes" class="lightbox" name="lightbox" onChange="s_change(this)" style="WIDTH: 264;">
      <%
      Enumeration e = BLightbox.findLightBox(member);
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
    </form>
  </tr>
</table>

<table width=100% cellpadding=2 cellspacing=0 border=0 id="tablecenter002">
  <form name="fm" action="?">
  <input type="hidden" name="id" value="<%=request.getParameter("id")%>"/>
  <input type="hidden" name="back" value="<%=request.getParameter("back")%>"/>
  <tr>
    <td width=90% nowrap class="padleft">创建日期: <%=blb.getCreateTimeToString()%> | 上次访问时间: <%=blb.getAccessTimeToString()%></td>
    <%BLightbox.set(member,lightbox);%>
    <td width=5% nowrap>每页图片数目:</td>
    <td width=5% class="padright"><select name="npgs" class=button language="javascript" onChange="document.fm.submit();">
      <OPTION value="2" <%if(pageSize == 2)out.print("selected");%>>2</OPTION>

      <OPTION value="3" <%if(pageSize == 3)out.print("selected");%>>3</OPTION>
      <OPTION value="4" <%if(pageSize == 4)out.print("selected");%>>4</OPTION>
      <OPTION value="5" <%if(pageSize == 5)out.print("selected");%>>5</OPTION>
      </select>
    </td>
  </tr>
  </form>
</table>

<%
if(picid!=null){
String[] mpid = picid.split(",");
if(mpid.length>0){
  count = mpid.length-1;
}
%>

<table width=100% border=0 cellpadding=3 cellspacing=0 class=bg8 id="table003">
  <tr><td width=15% valign="middle" nowrap class=big>第&nbsp;<font color=red><%=pos/pageSize+1%></font>&nbsp;页&nbsp;&nbsp;&nbsp;共&nbsp;<font color=red><%if(count%pageSize==0){out.print(count/pageSize+1);}else{out.print(count/pageSize+1);}%></font>&nbsp;页</td><td width=70% align=center valign="middle" >&nbsp;<%=lightbox%> (<%=count%>)&nbsp;</td><td nowrap width=15% align=right class=padright>&nbsp;</td></tr></table>

<form action="/servlet/EditMoveLightbox" name="movepic" method="post">
<input type="hidden" name="id" value="<%=request.getParameter("id")%>"/>
<input type="hidden" name="act"/>
<input type="hidden" name="pos" value="<%=pos%>"/>
<input type="hidden" name="lbvalue"/>
<table border="0" cellspacing="0" cellpadding="5" align="center" id="table002"  >
<%

for(int i = 1; i < mpid.length; i ++){
  if(i > pos && i <= pos+pageSize){
    int pnode = Integer.parseInt(mpid[i]);
    Picture p = Picture.find(pnode);
    String picture ="/res/"+teasession._strCommunity+"/picture/"+pnode+".jpg";
    File f=new File(application.getRealPath(picture));
    int width=0,height=0;
    width=p.getWidth(teasession._nLanguage);
    height=p.getHeight(teasession._nLanguage);
    String filesize="";
    Node n = Node.find(pnode);
    Baudit ba = Baudit.find(pnode);
    int lightboxIndex = BLightbox.countLightBox(member);
    if(f.exists())
    {
      filesize=(int)(width*height*3F/(1024*1024))+"MB";
    }

    %>
    <tr>
      <td width="170" rowspan="4" align="center" id="lzj_img">
        <a href="/jsp/bpicture/ImageInfo.jsp?nodes=<%=pnode%>" target="_blank"><img src="<%=picture%>" /></a>
        <div align="center" >
        <span>最大文件大小:<span>&nbsp;<%=filesize%>&nbsp;　</span></span>      </div></td>
      <td height="24" colspan="2" valign="middle" id="lzj_img_01"><table align="center" width="95%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td valign="middle"><a href="/jsp/bpicture/ImageInfo.jsp?nodes=<%=pnode%>" target="_blank"><img width="17" height="17" border="0" src="/tea/image/bpicture/image_details.gif" alt="图片信息"></a> &nbsp;<a href="/jsp/bpicture/buyer/CalPrice.jsp?nodes=<%=pnode%>"><img width="17" height="17" border="0" src="/tea/image/bpicture/cal_price.gif" alt="计算价格"></a> &nbsp;<a href="#" onClick='c_jax(<%=pnode%>);'><span id="<%=pnode%>"><img width="17" height="17" border="0" src="/tea/image/bpicture/add_cart.gif" alt="放入购物车"></span></a> &nbsp;<a href="#" onClick="if(confirm('确定删除该图片？')){window.location.href='/jsp/bpicture/buyer/AddShopping.jsp?lightbox=<%=lightbox%>&act=remove&node=<%=pnode%>&nexturl=/jsp/bpicture/buyer/ViewLightbox.jsp';}return false;"><img width="17" height="17" border="0" src="/tea/image/bpicture/remove_lightbox.gif" alt="从收藏夹中移除"></a> </td>
            <td align="right" valign="middle"><b><%=pnode%></b>-
              <%if(ba.getProperty()==1){out.print("<font color=#FE8100>RF</font>");}else{out.print("<font color=blue>RM</font>");}%></td>
          </tr>
        </table></td>
      </tr>
    <tr>
      <td height="24" colspan="2" valign="middle">描述：</td>
    </tr>
    <tr>
      <td height="40" valign="middle"><textarea id="keywords<%=i%>" cols="0" rows="2" name="keywords<%=i%>" class="lzj_001"><%if(BLightbox.selCaption(pnode,member,lightbox)!=null)out.println(BLightbox.selCaption(pnode,member,lightbox));%>
      </textarea></td>
      <td width="42" align="right" valign="middle"><input name="button2" type="button" onClick="k_send('keywords<%=i%>',<%=pnode%>);" value="保存" class="lzj_002"/></td>
    </tr>
    <%if(lightboxIndex > 1){%>
    <tr>
      <td height="40" valign="middle"><select id="movebox<%=i%>" class="lightbox" name="movebox<%=i%>" >
        <option value="0">----------------------------------------------------</option>
        <%
        Enumeration ee = BLightbox.findLightBox(member);
        if(ee.hasMoreElements()){
          while(ee.hasMoreElements()){
            String elment = ee.nextElement().toString();
            out.print("<option value="+elment+">"+elment+"</option>");
          }
        }
        %>
        </select></td>
        <td align="right" valign="middle"><input name="button" type="button" onClick="j_send('movebox<%=i%>',<%=pnode%>);" value="移动" class="lzj_002"/></td>
    </tr>
    <%}%>
    <tr>
      <td height="10" colspan="3" align="center" id="lzj_img">&nbsp;</td>
      </tr>
    <%
    }
}
if(count==0)
    {
      out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
    }
    %>
</table>
</form>
<table width=100% border=0 cellpadding=3 cellspacing=0 class=bg8 id="table003">
<%if(count>pageSize){
      %>
      <tr>
        <td colspan="10" align="right" style="padding-right:5px;">
          <%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+"?lightbox="+lightbox+"&npgs="+pageSize+"&back="+request.getParameter("back")+"&pos=",pos,count,pageSize)%>      </td>
      </tr>
      <%}%></table>
<%}%></div>

<%if(request.getParameter("back")!=null&&request.getParameter("back").equals("1")){%>
<div id="jspafter">
  <%=community.getJspAfter(teasession._nLanguage)%>
</div>
<%}%>
</body>

<!-- Stock photography -->
</html>
