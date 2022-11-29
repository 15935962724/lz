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
Community c=Community.find(teasession._strCommunity);
StringBuffer sql = new StringBuffer();
StringBuffer param = new StringBuffer();
int nodes = 0;
if(teasession.getParameter("nodes")!=null && teasession.getParameter("nodes").length()>0)
{
  nodes = Integer.parseInt(teasession.getParameter("nodes"));
}
Node node = Node.find(nodes);
String lightbox = request.getParameter("lightbox");
String member= request.getParameter("member");
if(teasession._rv!=null){
  member=teasession._rv._strR;
}
Bperson bp = Bperson.findmember(member);
if(lightbox==null)
  {
    lightbox = bp.getCurrentlightbox();
  }
//if (teasession._rv == null)
//{
//  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
//  return;
//}
//Baudit.addZoom(nodes);//放大
boolean _bNew =request.getParameter("NewNode")!=null;

int j1 = 0;
Date date = null;
String subject,keywords,text;
String s2 ;
int s4=0 ;
String s5 ;
String s6 ;
String s7 ;
String picture,small,extralarge,extrasmall,large,smalls,medium;
String s8 ;
BigDecimal price = new BigDecimal(1);
long lenpic=0,lentbn=0,lenel=0,lenes=0,lenl=0,lens=0,lenm=0;

int width=0,height=0;

int widthel=0,heightel=0,numel=0;
int widthl=0,heightl=0,numl=0;
int widthm=0,heightm=0,numm=0;
int widths=0,heights=0,nums=0;
int widthes=0,heightes=0,numes=0;

int typepic=0;
  String mainkey="";
  String bpseudonym = "";
  Baudit ba = Baudit.find(nodes);


  node.click();
if(!_bNew)
{
  Picture p=Picture.find(nodes);
  keywords=node.getKeywords(teasession._nLanguage);
  subject=node.getSubject(teasession._nLanguage);
  text=HtmlElement.htmlToText(node.getText(teasession._nLanguage));
  s2=p.getAuthor(teasession._nLanguage);
  date=p.getDate(teasession._nLanguage);
  s4=p.getClass(teasession._nLanguage);
  s5=p.getAddress(teasession._nLanguage);
  s6=p.getNote(teasession._nLanguage);
  s7=p.getSave(teasession._nLanguage);
  s8=p.getCode(teasession._nLanguage);
//2198201
  width=p.getWidth(teasession._nLanguage);
  height=p.getHeight(teasession._nLanguage);
  price=p.getPrice(teasession._nLanguage);
  picture="/res/"+node.getCommunity()+"/picture/"+nodes+".jpg";
  small="/res/"+node.getCommunity()+"/picture/small/"+nodes+".jpg";

  typepic=p.getPictype(teasession._nLanguage);

  if(typepic==1)
  {

    mainkey = ba.getMainKey();
    int bps = ba.getBpseudonymid();
    Bpseudonym bm = Bpseudonym.find(bps);
    bpseudonym = bm.getName();
    extralarge="/res/"+node.getCommunity()+"/salepic/"+ba.getMember()+"/"+ba.getTimes() +"/extralarge/"+nodes+".jpg";
    large="/res/"+node.getCommunity()+"/salepic/"+ba.getMember()+"/"+ba.getTimes()+"/large/"+nodes+".jpg";
    medium="/res/"+node.getCommunity()+"/salepic/"+ba.getMember()+"/"+ba.getTimes()+"/medium/"+nodes+".jpg";
    smalls="/res/"+node.getCommunity()+"/salepic/"+ba.getMember()+"/"+ba.getTimes()+"/smalls/"+nodes+".jpg";
    extrasmall="/res/"+node.getCommunity()+"/salepic/"+ba.getMember()+"/"+ba.getTimes()+"/extrasmall/"+nodes+".jpg";

    File exla=new File(application.getRealPath(extralarge));
    if(exla.isFile())
    {
      lenel=exla.length();
      BufferedImage bi = ImageIO.read(exla);
      widthel = bi.getWidth();
      heightel = bi.getHeight();

      ExifReader erel = new ExifReader(application.getRealPath(extralarge));
      numel =  Integer.parseInt(erel.getResolution());

    }

     File la=new File(application.getRealPath(large));
     if(la.isFile())
     {
       lenl=exla.length();
       BufferedImage bil = ImageIO.read(la);
       widthl = bil.getWidth();
       heightl = bil.getHeight();
       ExifReader erla= new ExifReader(application.getRealPath(large));
       numl =  Integer.parseInt(erla.getResolution());
     }

     File me=new File(application.getRealPath(medium));
     if(me.isFile())
     {
       lenm=me.length();
       BufferedImage bim = ImageIO.read(me);
       widthm = bim.getWidth();
       heightm = bim.getHeight();
     }

     File sm = new File(application.getRealPath(smalls));
     if(sm.isFile())
     {
       lens=sm.length();
       BufferedImage bis = ImageIO.read(sm);
       widths = bis.getWidth();
       heights = bis.getHeight();
     }

     File es = new File(application.getRealPath(extrasmall));
     if(es.isFile())
     {
       lenes=es.length();
       BufferedImage bies = ImageIO.read(es);
       widthes = bies.getWidth();
       heightes = bies.getHeight();
     }
  }

  lenpic=new File(application.getRealPath(picture)).length();
  lentbn=new File(application.getRealPath(small)).length();
}else
{
  subject=keywords=text = "";
  s2 = "";
  s5 = "";
  s6 = "";
  s7 = "";
  s8 = String.valueOf(System.currentTimeMillis());
  picture=small="";
}
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

#li_biao{height:35px;*height:25px;line-height:35px;padding-left:15px;font-size:12px;background-color:#D6E6FF;border-top:1px solid #67A7E4;}
#dv1{width:70%;float:right;text-align:right;color:#0000CC;font-size:12px;height:40px;}
.lzj_a{margin:0 10px;color:#0000CC; text-decoration:none;}
#my-B-picture{color:#000;font-weight:bold;text-decoration:none;margin:0 10px;}
#sear{text-align:left;padding-left:70px;}
#qt{width:210px;height:23px;border:1px solid #809EBA;background:#fff;}
#lzj_bg{font-size:12px;}
#lzj_bg a{color:#0000cc;}
#lzj_an{width:45px;height:23px;background:url(/res/bigpic/u/0811/08111256.jpg) no-repeat;border:0;margin:0 10px;}
.kuan{border:0;}
.lzj_logo{width:60px;float:left;background:url(/res/bigpic/u/0812/081243711.jpg) no-repeat 10px 2px;}
.lzj_logo a{display:block;width:160px;height:40px;}

</style>
<script type="">
function add_cart(me)
      {
        var rv = '<%=teasession._rv%>';
        if(rv == 'null')
        {
          window.location.href='/servlet/Folder?node=2198284&language=1';
        }else{
          currentPos = 'cart_'+me;
          var url = "/jsp/bpicture/Lightbox_ajax.jsp?act=cart&pic="+me+"&lightbox=<%=lightbox%>";
          url = encodeURI(url);
          send_request(url);
        }
      }
function c_jax()
{
  var rv = '<%=teasession._rv%>';
  if(rv == 'null')
  {
    window.location.href='/servlet/Folder?node=2198284&language=1';
  }else{
    currentPos = 'lit_'+document.frm1.nod.value;
    var url = "/jsp/bpicture/Lightbox_ajax.jsp?imginfo=1&&act=lit&pic="+document.frm1.nod.value+"&lightbox="+document.frm1.lightbox.value;
    url = encodeURI(url);
    send_request(url);
  }
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
</head>

<body style="margin:0;padding:0;">

<div style="background: #f6f6f6; padding-bottom: 10px; padding-top: 8px;height:40px;">
<div class="lzj_logo"><a href="/servlet/Folder?node=2198115&language=1"></a></div>
<div id="dv1"><a id="my-B-picture" title="B-picture管理平台" href="/jsp/bpicture/index.jsp">我的B-picture</a>|
<%if(teasession._rv==null){%>
<a class="lzj_a" href="/servlet/Folder?node=2198284&language=1">登录</a>| <a class="lzj_a" title="免费注册" href="/servlet/Node?node=2201051&language=1">注册</a>|
<%}else{%>
<a class="lzj_a" id="cancels" href="/servlet/Logout?community=bigpic&node=2198115" target=_top >&nbsp;退出</a>|
<%}%>
  <a class="lzj_a" title="编辑和管理您的收藏夹" href="/jsp/bpicture/buyer/ViewLightbox.jsp?back=1">收藏夹</a>| <a class="lzj_a" href="/jsp/bpicture/buyer/ShoppingCart.jsp?back=1">购物车</a>| <a class="lzj_a" title="订单和下载" href="/jsp/bpicture/buyer/OrderAndDown.jsp?back=1">订单</a>| <a class="lzj_a" href="/servlet/Node?node=2198272&amp;language=1">联系我们</a>| <a class="lzj_a" href="/servlet/Folder?node=2198279&amp;language=1">帮助</a></div>
</div>
<div id="wai">
<h1>图片信息</h1>

<div id="lzj_zong">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter003">
  <tr>
    <td colspan="3" id="lzj_zdi"><%=nodes%> 　<%if(ba.getProperty()==1){out.print("免版税图片　(<font color=#FE8100>RF</font>)");}else if(ba.getProperty()==2){out.print("版权管理类图片  (<font color=blue>RM</font>)");}%></td>
    <td width="650" rowspan="13" align="left" valign="top" scope="col">
      <!--<a href="#" onClick="window.showModalDialog('/jsp/bpicture/saler/SalerBigPictrue.jsp?nodes=<%=nodes%>','_blank','dialogWidth:<%=width%>px;dialogHeight:<%=height%>px;dialogLeft:200px;dialogTop:100px;scrollbars:no;toolbar:no;status:yes;menubar:no;location:yes;resizable:yes');"></a>-->
      <img alt="" src="<%=picture%>"  />    </td>
  </tr>
  <tr>
    <td colspan="3" scope="col">&nbsp;</td>
  </tr>
   <tr>
    <td colspan="3">图片描述：<%=node.getSubject(1)%></td>
  </tr>
  <tr>
    <td colspan="3">肖像权：&nbsp;&nbsp;&nbsp;
    <%if(ba.getPhotography()==1){out.print("有");}else if(ba.getPhotography()==2){out.print("没有");}else {out.print("不需要");}%>
    <b>　　/　　</b> 物产权：
        <%if(ba.getDesign()==1){out.print("有");}else if(ba.getDesign()==2){out.print("没有");}else{out.print("不需要");}%> </td>
  </tr>

  <tr>
    <td colspan="3">最大文件大小： <%=((int)((width*height*3F/(1024*1024))*100))/100F%>MB</td>
  </tr>
  <tr>
    <td colspan="3">要下载计算机中，右键点击图片，并点击图片另存为...</td>
  </tr>
  <tr id="lzj_kong">
    <td width="200">&nbsp;</td>
    <td width="200">&nbsp;</td>
    <td width="200">&nbsp;</td>
  </tr>
  <tr id="lzj_kong">
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr id="lzj_kong">
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr id="lzj_kong">
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr id="lzj_kong">
    <td><span id="lit_<%=nodes%>"><a href=# onclick="c_seat(lit_<%=nodes%>,light,<%=nodes%>);"><img src="/tea/image/bpicture/add_lightbox.gif" alt=添加至收藏夹 width=17 height=17 border=0 name=l1 alt="">&nbsp;添加至收藏夹</a></span></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr id="lzj_kong">
    <td><a href=# onclick='add_cart(<%=nodes%>)'><span id="cart_<%=nodes%>"><img width=17 height=17 border=0 src="/tea/image/bpicture/add_cart.gif" alt=放入购物车"></span>&nbsp;放入购物车</a></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><a href="/jsp/bpicture/buyer/CalPrice.jsp?nexturl=<%=url%>&nodes=<%=nodes%>&back=1"><img width=17 height=17 border=0 src="/tea/image/bpicture/cal_price.gif" alt=计算价格">&nbsp;计算价格</a></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>

<form name="search" action="/servlet/Folder?node=2198224" method="POST" target="blank">
<input type="hidden" name="bp_keywords"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0" id="tablecenter003">
  <tr>
    <td width="17%" id="lzj_zdi">摄影师</td>
    <td width="17%">
      <%
      String photoer = ba.getMember();
      tea.entity.member.Profile pro = tea.entity.member.Profile.find(photoer);
      if(pro.getLastName(teasession._nLanguage)!=null){
        out.print("<a href=/servlet/Folder?node=2198224&bp_keywords="+java.net.URLEncoder.encode(ba.getMember(),"utf-8")+" target=top>"+java.net.URLEncoder.encode(pro.getLastName(teasession._nLanguage),"utf-8")+" </a>");
      }

      %>
   &nbsp;</td>
    <td width="17%">&nbsp;</td>
    <td width="17%">&nbsp;</td>
    <td width="17%">&nbsp;</td>
    <td width="17%">&nbsp;</td>
  </tr>
  <tr>
    <td width="17%" id="lzj_zdi">关键词</td>
    <td colspan="3" nowrap="nowrap">
      <%
      String[] maink = null;
      if(mainkey!=null)
      {
        maink = mainkey.split(",");
        out.print("<table><tr>");
        for(int i = 0; i < maink.length; i ++)
        {

          if(maink[i].length()>0){
            out.print("<td nowrap><input id=che"+i+" type=checkbox name=che"+i+" value="+maink[i]+" />&nbsp;<a href='/servlet/Folder?node=2198224&bp_keywords="+java.net.URLEncoder.encode(maink[i],"utf-8")+"' target=_blank>"+maink[i]+"</a></label></td>");
          }
          if(i!=0 && i%8 == 0){
            out.print("</tr><tr>");
          }
        }
        out.print("</tr></table>");
      }
      %>

    </td>
    <td colspan="2"><input style="width:50px;height:25px" type="submit" size="80" value="GO" <%if(mainkey.length()<2)out.print("disabled");%> onclick="che_key()"/></td>

  </tr>

  <tr>
    <td width="17%" rowspan="7" id="lzj_zdi">图片尺寸</td>
    <td width="17%">文件大小</td>
    <td width="17%">像素</td>
    <td width="17%">厘米*</td>
    <td width="17%">英寸*</td>
    <td width="17%">&nbsp;</td>
  </tr>
  <%
  if(ba.getProperty()==1){
  %>
  <tr>
    <td width="17%"><%=(int)(widthel*heightel*3F/(1024*1024))%>MB</td>
    <td><%=widthel%> × <%=heightel%></td>
    <td><%=((int)((widthel*1F/119)*100))/100F%> × <%=((int)((heightel*1F/119)*100))/100F%></td>
    <td><%=((int)((widthel*1F/302)*100))/100F%> × <%=((int)((heightel*1F/302)*100))/100F%></td>
    <td width="17%">&nbsp;</td>
  </tr>
  <%if(widthl!=widthel&&heightl!=heightel){%>
  <tr>
    <td><%=(int)(widthl*heightl*3F/(1024*1024))%>MB</td>
    <td><%=widthl%> × <%=heightl%></td>
    <td><%=((int)((widthl*1F/119)*100))/100F%> × <%=((int)((heightl*1F/119)*100))/100F%></td>
    <td><%=((int)((widthl*1F/302)*100))/100F%> × <%=((int)((heightl*1F/302)*100))/100F%></td>
    <td width="17%">&nbsp;</td>
  </tr>
  <%}%>
  <%if(widthl!=widthm&&heightl!=heightm){%>
  <tr>
    <td><%=(int)(widthm*heightm*3F/(1024*1024))%>MB</td>
    <td><%=widthm%> × <%=heightm%></td>
    <td><%=((int)((widthm*1F/119)*100))/100F%> × <%=((int)((heightm*1F/119)*100))/100F%></td>
    <td><%=((int)((widthm*1F/302)*100))/100F%> × <%=((int)((heightm*1F/302)*100))/100F%></td>
    <td width="17%">&nbsp;</td>
  </tr>
  <%}%>
  <%if(widths!=widthm&&heights!=heightm){%>
  <tr>
    <td><%=(int)(widths*heights*3F/(1024*1024))%>MB</td>
    <td><%=widths%> × <%=heights%></td>
    <td><%=((int)((widths*1F/119)*100))/100F%> × <%=((int)((heights*1F/119)*100))/100F%></td>
    <td><%=((int)((widths*1F/302)*100))/100F%> × <%=((int)((heights*1F/302)*100))/100F%></td>
    <td width="17%">&nbsp;</td>
  </tr>
  <%}%>
  <%if(widths!=widthes&&heights!=heightes){%>
  <tr>
    <td><%=(int)(widthes*heightes*3F/(1024*1024))%>MB</td>
    <td><%=widthes%> × <%=heightes%></td>
    <td><%=((int)((widthes*1F/119)*100))/100F%> × <%=((int)((heightes*1F/119)*100))/100F%></td>
    <td><%=((int)((widthes*1F/302)*100))/100F%> × <%=((int)((heightes*1F/302)*100))/100F%></td>
    <td width="17%">&nbsp;</td>
  </tr>
  <%}
  }else if(ba.getProperty()==2){%>
  <tr>
    <td><%=(int)(width*height*3F/(1024*1024))%>MB</td>
    <td><%=width%> × <%=height%></td>
    <td><%=((int)((width*1F/119)*100))/100F%> × <%=((int)((height*1F/119)*100))/100F%></td>
    <td><%=((int)((width*1F/302)*100))/100F%> × <%=((int)((height*1F/302)*100))/100F%></td>
    <td width="17%">&nbsp;</td>
  </tr>
  <%} %>
  <tr>
    <td colspan="7"><%BExifParam bep = BExifParam.find(nodes); String solution = bep.getXresolution().length()>1?"*图像精度&nbsp;"+bep.getXresolution()+"&nbsp;dpi":""; out.print(solution);%></td>

  </tr>


</table>
</form>
</div>
<div id="light" style="display:none;border:1px solid #cccccc;width:214px;position:absolute;z-index:88;background-color:#F6F6F6;">
  <%
  if(teasession._rv!=null){
    %>
    <form id="frmMain" name="frm1" action="?" method="get">
    <input type="hidden" name="id" value="<%=request.getParameter("id")%>"/>
    <input type="hidden" name="nod"/>
    <table>
      <tr >

        <td width="35%" class="padleft" valign="baseline"><b>选择收藏夹:</b></td>
        <td class="padright">
          <select id="Lightboxes" class="lightbox" name="lightbox" style="WIDTH: 104;">
          <%
          Enumeration e1 = BLightbox.findLightBox(teasession._rv._strR);
          if(e1.hasMoreElements()){
            while(e1.hasMoreElements()){
              String elment = e1.nextElement().toString();
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
        <td></td><td><input type="button" value="收藏" onclick="c_jax()"/></td>
      </tr>
    </table>
    </form>
    <%}%>
  </div>
</div>
<div id="jspafter">
  <%=c.getJspAfter(teasession._nLanguage)%>
</div>
<script type="">
function che_key()
{
  document.search.bp_keywords.value='';
  for(var i =1; i <<%=maink.length%>;i++)
  {
    if(document.getElementById('che'+i).checked)
    {
      document.search.bp_keywords.value+=document.getElementById('che'+i).value+" ";
    }
  }
}

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
  var rv = '<%=teasession._rv%>';

  if(rv == 'null')
  {
    window.location.href='/servlet/Folder?node=2198284&language=1';
  }else{
    document.frm1.nod.value=ids;

    m.style.display='none';
    if(id!=cm)
    {
      m.style.display='';
      m.style.pixelLeft = getPos(id,"Left")-10;
      m.style.pixelTop = getPos(id,"Top") + id.offsetHeight-90;
      cm=id;
    }else
    {
      m.style.display='none';
      cm=null;
    }
  }
}

</script>
</body>
</html>
