<%@page contentType="text/html;charset=UTF-8"  %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="tea.entity.bpicture.*" %>
<%@ page import="tea.entity.node.*" %>
<%@page import="java.awt.image.*" %>
<%@page import="javax.imageio.*" %>
<%@page import="java.math.BigDecimal" %>
<%@ page import="tea.html.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.io.*"%>
<%@ page import="tea.htmlx.*"%>
<%@page import="tea.entity.site.*" %>
<%

TeaSession teasession = new TeaSession(request);
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

StringBuffer sql = new StringBuffer();
StringBuffer param = new StringBuffer();
int nodes = 0;
if(teasession.getParameter("nodes")!=null && teasession.getParameter("nodes").length()>0)
{
  nodes = Integer.parseInt(teasession.getParameter("nodes"));
}
String nexturl = request.getParameter("nexturl");
Node node = Node.find(nodes);
if (teasession._rv == null)
{
  response.sendRedirect("/servlet/Node?node=2198284&language=1");
  return;
}



int ids = 0;
if(teasession.getParameter("id")!=null && teasession.getParameter("id").length()>0)
{
  ids= Integer.parseInt(teasession.getParameter("id"));
  if(ids!=0)
  {
    Bimage bm = Bimage.find(ids);
    bm.getPicsize();
  }
}
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
String picMember= "";
boolean isSalerDel = false;
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
  width=p.getWidth(teasession._nLanguage);
  height=p.getHeight(teasession._nLanguage);
  price=p.getPrice(teasession._nLanguage);
  picture="/res/"+node.getCommunity()+"/picture/"+nodes+".jpg";
  small="/res/"+node.getCommunity()+"/picture/small/"+nodes+".jpg";
  typepic=p.getPictype(teasession._nLanguage);
  Baudit ba = Baudit.find(nodes);

picMember = ba.getMember();
if(!tea.entity.member.Profile.isExisted(picMember)){
  isSalerDel = true;
}

  if((typepic==1) &&(ba.getProperty()==1))
  {
    //,extralarge,extrasmall,large,smalls,medium
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
      ExifReader erm= new ExifReader(application.getRealPath(medium));
      numm =  Integer.parseInt(erm.getResolution());
    }

    File sm = new File(application.getRealPath(smalls));
    if(sm.isFile())
    {
      lens=sm.length();
      BufferedImage bis = ImageIO.read(sm);
      widths = bis.getWidth();
      heights = bis.getHeight();
      ExifReader ers= new ExifReader(application.getRealPath(smalls));
      nums =  Integer.parseInt(ers.getResolution());
    }
    File es = new File(application.getRealPath(extrasmall));
    if(es.isFile())
    {
      lenes=es.length();
      BufferedImage bies = ImageIO.read(es);
      widthes = bies.getWidth();
      heightes = bies.getHeight();
      ExifReader eres= new ExifReader(application.getRealPath(extrasmall));
      numes =  Integer.parseInt(eres.getResolution());
    }

  }
  else if ((typepic==1) &&(ba.getProperty()>1))
  {

    response.sendRedirect("/jsp/bpicture/buyer/CalPriceRM.jsp?id="+ids+"&nodes="+nodes+"&back="+request.getParameter("back"));
    return;
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
int pos=0;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}
param.append("&pos=").append(pos);
int count=0;
Community c=Community.find(teasession._strCommunity);
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
  <title>图片价格</title>
  <script type="">
  function chuansun(cc)
  {
    form1.picsize.value=cc;
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
  function c_jax()
  {
    currentPos = 'lit_'+document.frm1.nod.value;
    var url = "/jsp/bpicture/Lightbox_ajax.jsp?act=lit&pic="+document.frm1.nod.value;
    url = encodeURI(url);
    send_request(url);
    document.getElementById('light').style.display='none';
  }
  function add_jax(me)
  {
    currentPos = me;
    var url = "/jsp/bpicture/Lightbox_ajax.jsp?act=cart&pic="+me;
    url = encodeURI(url);
    send_request(url);
  }
  function currn_jax(me)
  {
    currentPos = me;
    var url = "/jsp/bpicture/buyer/CurrentLightbox_ajax.jsp?lightbox="+me.value;
    url = encodeURI(url);
    send_request(url);
  }
  </script>
  <style>
  /*头部样式*/
  #dv1{width:95%;text-align:right;font-size:12px;height:40px;background:url(/res/bigpic/u/0812/081247284.jpg) no-repeat 10 2;color:#0000CC;}
  .lzj_a{margin:0 10px;color:#0000CC; text-decoration:none;}
  #my-B-picture{color:#000;font-weight:bold;text-decoration:none;margin:0 10px;}
  #sear{text-align:left;padding-left:70px;}
  #qt{width:210px;height:23px;border:1px solid #809EBA;background:#fff;}
  #lzj_bg{font-size:12px;}
  #lzj_bg a{color:#0000cc;}
  .top{border-top:1px solid #cccccc;margin-top:15px;}
  .top td{font-size:12px;line-height:150%;}
  .top a{color:0000cc;}
  .kuan{border:0;}
  /**/
  #tablecenter003{width:95%;font-size:12px;border-top:10px solid #eee;border-bottom:10px solid #eee;background:#F6F6F6;margin-top:10px;}
  #tablecenter003 td{padding:5px 15px;}
  #tablecenter008{width:95%;font-size:12px;border-top:1px solid #ccc;border-left:1px solid #ccc;border-right:1px solid #ccc;}
  #tablecenter008 td{padding:5px 15px;border-bottom:1px solid #cccccc;}
  #lzj_zong{border-top:1px solid #67A7E4;padding-top:25px;padding-bottom:25px;}
  #lzj_img{border-right:1px solid #ccc;padding-top:15px;}
  #lzj_img img{width:300px;margin-top:10px;}
  </style>
  <script type="">
  function che_jg()
  {
    var bol = false;
    for(var i = 1; i < 6; i ++)
    {
      if(document.getElementById('jg'+i).checked)
      {
        return true;
        break;
      }
    }
    alert('请选择图片价格');
    document.getElementById('jg1').focus();
    return false;
  }
  </script>
  </head>
  <body style="margin:0;padding:0;">
  <%if(request.getParameter("back")!=null){%>
  <div id="jspbefore">
    <%=c.getJspBefore(teasession._nLanguage)%>
  </div>
  <%}%>
  <div id="wai">
    <div id="li_biao"><a href="http://bp.redcome.com" target="_top">首页</a>&nbsp;>&nbsp;管理中心&nbsp;>&nbsp;计算价格</div>
    <h1>计算价格</h1>
    <%if(request.getParameter("back")==null){%>

    <%}%>
    <%
    if(typepic==1)
    {
      %>
      <div id="light" style="display:none;width:150px;position:absolute;z-index:99;background-color:#E0EDFE;">

        <form id="frmMain" name="frm1" action="?" method="get">
        <input type="hidden" name="id" value="<%=request.getParameter("id")%>"/>
        <input type="hidden" name="nod"/>
        <table>
          <tr>
            <td align="center"><b>选择收藏夹</b></td>
          </tr>
          <tr>
            <td align="center">
              <select id="Lightboxes" class="lightbox" name="lightbox" style="WIDTH: 104;">
              <%
              Enumeration e = BLightbox.findLightBox(teasession._rv._strR);
              if(e.hasMoreElements()){
                while(e.hasMoreElements()){
                  String elment = e.nextElement().toString();

                  out.print("<option value="+elment+">"+elment+"</option>");

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
      <div id="lzj_zong">
        <form name="form1" action="/servlet/EditBPperson" method="get" onSubmit="return che_jg();">
        <input type="hidden" name="act" value="calprice">
        <input type="hidden" name="picsize" value="0">
        <input type="hidden" name="back" value="<%if(request.getParameter("back")!=null){out.print(request.getParameter("back"));}%>"/>
        <input type="hidden"  name="id" value="<%=ids%>"/>
        <input type="hidden" name="nexturl" value="<%=request.getParameter("nu")%>"/>
        <table border="0" cellpadding="0" cellspacing="0" id="tablecenter008">
          <input name="nodes" value="<%=nodes%>" type="hidden">
          <input name="typepic" value="<%=typepic%>" type="hidden">
          <tr>
            <td rowspan="15" align="right" valign="top" id="lzj_img"><img src="<%=picture%>" alt="" /></td>
              <td colspan="2"><%=subject%>（<font color="#FE8100">RF</font>）</td>
              <td width="42">&nbsp;</td>
              <td colspan="3" nowrap>免税版</td>
          </tr>
          <tr>
            <td align="right" nowrap><span id=lit_<%=nodes%>><a href=# onclick='c_seat(lit_<%=nodes%>,light,<%=nodes%>);'><img src="/tea/image/bpicture/add_lightbox.gif" alt="添加至收藏夹" width=17 height=17 border=0 name=l1></a></span><a href="#" onclick='c_seat(lit_<%=nodes%>,light,<%=nodes%>);'>&nbsp;添加至收藏夹</a></td>
              <td colspan="5"><b>联系我们</b></td>
          </tr>
          <tr>
            <td height="20" align="right"><span id="<%=nodes%>"><a href="#" onClick='add_jax(<%=nodes%>);'><img width="17" height="17" border="0" src="/tea/image/bpicture/add_cart.gif" alt="放入购物车"></a></span><a href="#" onClick='add_jax(<%=nodes%>);'>&nbsp;放进购物车</a></td>
              <td colspan="5">　　　　销售咨询电子邮件：<a href="mailto:edn@redcome.com">edn@redcome.com</a></td>
          </tr>
          <tr>
            <td height="20" align="right"><span style="margin-right:12px;"><a href='/jsp/bpicture/ImageInfo.jsp?nodes=<%=nodes%>&back=1'><img src="/tea/image/bpicture/image_details.gif" alt="图片信息" width="17" height="17" border="0"></a>
              <a href='/jsp/bpicture/ImageInfo.jsp?nodes=<%=nodes%>&back=1'>图片信息</a></span></td>
              <td colspan="5">　　　　　　　联系电话☎：010-8870799</td>
          </tr>
          <tr>

            <td colspan="6">
              <%
              String deldates = "";
              Calendar cal = Calendar.getInstance();
              if(Bperson.delTime(picMember)!=null){
                Date deldate = Bperson.delTime(picMember);
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                cal.setTime(deldate);//设置日历时间
                cal.add(Calendar.MONTH,1);
                deldates = sdf.format(cal.getTime());
              }
              if(isSalerDel){
                %>
              提示：该图片将在&nbsp;<font color="red"><%=deldates%></font>&nbsp;被移除,预购从速!
              <%}%>&nbsp;
            </td>
          </tr>
          <tr>
            <td>标题</td>
            <td colspan="5">&nbsp;</td>
          </tr>
          <tr>
            <td>图片尺寸</td>
            <td colspan="5">&nbsp;</td>
          </tr>
          <tr>

            <td colspan="6">请从下面的列表中选择您需要的图片尺寸</td>
          </tr>

          <tr>
            <td>&nbsp;</td>
            <td nowrap="nowrap">文件大小</td>
            <td align="center">MB</td>
            <td width="62" align="center">像素</td>
            <td align="center"  nowrap>价格(元)</td>
            <td align="center"  nowrap>您的选择</td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td nowrap>大</td>
            <td align="center"><%=(int)(widthel*heightel*3F/(1024*1024))%>MB</td>
            <td align="center"  nowrap><%=widthel%>×<%=heightel%></td>
            <td align="center"><%=(new BigDecimal(widthel)).multiply(new BigDecimal(heightel)).divide(new BigDecimal(1024),2,BigDecimal.ROUND_HALF_UP)%></td>
            <td align="center"><input id="jg1" type="radio" name="jiage"
            <%
            if(ids!=0)
            {
              Bimage bm = Bimage.find(ids);
              bm.getPicsize();
              if(bm.getPicsize()!=0)
              {
                if(bm.getPicsize()==1)
                {
                  out.print(" checked ");
                }
              }

            }
            %> value="<%=(new BigDecimal(widthel)).multiply(new BigDecimal(heightel)).divide(new BigDecimal(1024),2,BigDecimal.ROUND_HALF_UP)%>" onClick="chuansun(1)"/></td>
            </tr>
            <%if(widthl!=widthel&&heightl!=heightel){%>
            <tr>
              <td>&nbsp;</td>
              <td>较大</td>
              <td align="center"><%=(int)(widthl*heightl*3F/(1024*1024))%>MB</td>
              <td align="center"><%=widthl%>×<%=heightl%></td>
              <td align="center"><%=(new BigDecimal(widthl)).multiply(new BigDecimal(heightl)).divide(new BigDecimal(1024),2,BigDecimal.ROUND_HALF_UP)%></td>
              <td align="center"><input id="jg2" type="radio" name="jiage"  <%
              if(ids!=0)
              {
                Bimage bm = Bimage.find(ids);
                bm.getPicsize();
                if(bm.getPicsize()!=0)
                {
                  if(bm.getPicsize()==2)
                  {
                    out.print(" checked ");
                  }
                }

              }
              %> value="<%=(new BigDecimal(widthl)).multiply(new BigDecimal(heightl)).divide(new BigDecimal(1024),2,BigDecimal.ROUND_HALF_UP)%>" onClick="chuansun(2)" /></td>
              </tr>
              <%} if(widthl!=widthm&&heightl!=heightm){%>
              <tr>
                <td>&nbsp;</td>
                <td>中</td>
                <td align="center"><%=(int)(widthm*heightm*3F/(1024*1024))%>MB</td>
                <td align="center"><%=widthm%>×<%=heightm%></td>
                <td align="center"><%=(new BigDecimal(widthm)).multiply(new BigDecimal(heightm)).divide(new BigDecimal(1024),2,BigDecimal.ROUND_HALF_UP)%></td>
                <td align="center"><input id="jg3" type="radio" name="jiage" <%
                if(ids!=0)
                {
                  Bimage bm = Bimage.find(ids);
                  bm.getPicsize();
                  if(bm.getPicsize()!=0)
                  {
                    if(bm.getPicsize()==3)
                    {
                      out.print(" checked ");
                    }
                  }
                }
                %> value="<%=(new BigDecimal(widthm)).multiply(new BigDecimal(heightm)).divide(new BigDecimal(1024),2,BigDecimal.ROUND_HALF_UP)%>" onClick="chuansun(3)"/></td>
                </tr>
                <%} if(widths!=widthm&&heights!=heightm){%>
                <tr>
                  <td>&nbsp;</td>
                  <td>较小</td>
                  <td align="center"><%=(int)(widths*heights*3F/(1024*1024))%>MB</td>
                  <td align="center"><%=widths%>×<%=heights%></td>
                  <td align="center"><%=(new BigDecimal(widths)).multiply(new BigDecimal(heights)).divide(new BigDecimal(1024),2,BigDecimal.ROUND_HALF_UP)%></td>
                  <td align="center"><input id="jg4" type="radio" name="jiage" <%
                  if(ids!=0)
                  {
                    Bimage bm = Bimage.find(ids);
                    bm.getPicsize();
                    if(bm.getPicsize()!=0)
                    {
                      if(bm.getPicsize()==4)
                      {
                        out.print(" checked ");
                      }
                    }
                  }
                  %> value="<%=(new BigDecimal(widths)).multiply(new BigDecimal(heights)).divide(new BigDecimal(1024),2,BigDecimal.ROUND_HALF_UP)%>" onClick="chuansun(4)"/></td>
                  </tr>
                  <%} if(widths!=widthes&&heights!=heightes){%>
                  <tr>
                    <td>&nbsp;</td>
                    <td>小</td>
                    <td align="center"><%=(int)(widthes*heightes*3F/(1024*1024))%>MB</td>
                    <td align="center"><%=widthes%>×<%=heightes%></td>
                    <td align="center"><%=(new BigDecimal(widthes)).multiply(new BigDecimal(heightes)).divide(new BigDecimal(1024),2,BigDecimal.ROUND_HALF_UP)%></td>
                    <td align="center"><input id="jg5" type="radio" name="jiage" <%
                    if(ids!=0)
                    {
                      Bimage bm = Bimage.find(ids);
                      bm.getPicsize();
                      if(bm.getPicsize()!=0)
                      {
                        if(bm.getPicsize()==5)
                        {
                          out.print(" checked ");
                        }
                      }

                    }
                    %> value="<%=(new BigDecimal(widthes)).multiply(new BigDecimal(heightes)).divide(new BigDecimal(1024),2,BigDecimal.ROUND_HALF_UP)%>" onClick="chuansun(5)"/></td>
                    </tr>
                    <%}%>

        </table>
        <input  type="submit"  value="提交" id="lzj_an1" >&nbsp;
        </form>


        <%
        }
        else
        {
          %>

          <form name="frmGotoCart" action="/servlet/EditBPperson" method="get">
          <input type="hidden" name="act" value="calprice">
          <input type="hidden" name="picsize" value="0">
          <input name="typepic" value="<%=typepic%>" type="hidden">
          <input type="hidden" name="nodes" value="<%=nodes%>">
          <table id="tablecenter003">
            <tr>
              <td width=10% align=right nowrap="nowrap">图片用途</td>
              <td width=90% colspan=5>
                <select name="image_use" onChange="redirec(document.frmGotoCart.image_use.options.selectedIndex)">
                  <option selected>请选择</option>
                  <option value="1">广告/推广</option>
                  <option value="2">消费品</option>
                  <option value="3">直邮/手册</option>
                  <option value="3">显示</option>
                  <option value="3">编辑</option>
                  <option value="3">多媒体</option>
                  <option value="3">内部业务使用</option>
                </select>
              </td>
            </tr>

            <tr>
              <td width=10% align=right>详细用途</td>
              <td width=90% colspan=5>
                <select name="image_details">
                  <option value="请选择" selected>请选择</option>
                </select>
              </td>
            </tr>

            <tr>
              <td width=10% align=right>图片大小</td>
              <td width=90% colspan=5>
                <select name="image_size" onChange="CalculatePrice(1);" style="WIDTH:280">
                  <option selected value="1">1</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                </select>
              </td>
            </tr>


            <tr>
              <td width=10% align=right>印数</td>
              <td width=90% colspan=5>
                <select name="image_print" onChange="CalculatePrice(1);" style="WIDTH:280">
                  <option selected value="1">1</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                </select>
              </td>
            </tr>

            <tr>
              <td width=10% align=right>插入物</td>
              <td width=90% colspan=5>
                <select name="inserts" onChange="CalculatePrice(1);" style="WIDTH:280">
                  <option selected value="1">1</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                </select>
              </td>
            </tr>

            <tr>
              <td width=10% align=right>排名</td>
              <td width=90% colspan=5>
                <select name="placement" onChange="CalculatePrice(1);" style="WIDTH:280">
                  <option selected value="1">1</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                </select>
              </td>
            </tr>

            <tr>
              <td width=10% align=right>开始日期</td>
              <td width=90% colspan=5>
                <table border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td class="eleven" width="10">
                      <select name="selStartingDay" onChange="bPastLicenseDateAlerted = false; CalculatePrice(1);">
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                        <option value="6">6</option>
                        <option value="7">7</option>
                        <option value="8">8</option>
                        <option value="9">9</option>
                        <option value="10">10</option>
                        <option value="11">11</option>
                        <option value="12">12</option>
                        <option value="13">13</option>
                        <option value="14">14</option>
                        <option value="15">15</option>
                        <option value="16">16</option>
                        <option value="17">17</option>
                        <option value="18">18</option>
                        <option value="19">19</option>
                        <option value="20">20</option>
                        <option value="21">21</option>
                        <option value="22">22</option>
                        <option value="23">23</option>
                        <option value="24">24</option>
                        <option value="25">25</option>
                        <option value="26">26</option>
                        <option value="27">27</option>
                        <option value="28">28</option>
                        <option value="29">29</option>
                        <option value="30">30</option>
                        <option value="31">31</option>
                      </select>
                    </td>
                    <td class="eleven" width="10">
                      <select name="selStartingMonth" onChange="bPastLicenseDateAlerted = false; CalculatePrice(1);">
                        <option value="1">January</option>
                        <option value="2">February</option>
                        <option value="3">March</option>
                        <option value="4">April</option>
                        <option value="5">May</option>
                        <option value="6">June</option>
                        <option value="7">July</option>
                        <option value="8">August</option>
                        <option value="9">September</option>
                        <option value="10">October</option>
                        <option value="11">November</option>
                        <option value="12">December</option>
                      </select>
                    </td>
                    <td class="eleven" width="10">
                      <select name="selStartingYear" onChange="bPastLicenseDateAlerted = false; CalculatePrice(1);">
                        <option value="2008">2008</option><option value="2009">2009</option><option value="2010">2010</option><option value="2011">2011</option><option value="2012">2012</option>
                      </select>
                    </td>
                  </tr>
                </table>

              </td>
            </tr>

            <tr>
              <td width=10% align=right>时间</td>
              <td width=90% colspan=5>
                <select name="duration" onChange="CalculatePrice(1);" style="WIDTH:280">
                  <option selected value="1">1</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                </select>
              </td>
            </tr>

            <tr>
              <td width=10% align=right>领土</td>
              <td width=90% colspan=5>
                <select name="territory" onChange="SelectValue(6); CalculatePrice(1);" style="WIDTH:280">
                  <option selected value="1">1</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>

                </select>
              </td>
            </tr>
            <tr>
              <td width=10% align=right>国家</td>
              <td width=90% colspan=5><input type="hidden" name="txtCountry" id="txtCountry" value=''><input type="hidden" name="txtCountryFactor" id="txtCountryFactor" value=""><div width="280" id="divCountry" name="divCountry">

                <select id="selCountry" name="country" onChange="SetCountryInfo(this); CalculatePrice(1); " style="WIDTH:280">
                  <option selected value="1">1</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>

                </select></div>
              </td>
            </tr>
            <tr>
              <td width=10% align=right>产品行业</td>
              <td width=90% colspan=5>
                <select name="product_industry" onChange="SelectValue(9); CalculatePrice(1);" style="WIDTH:280">
                  <option selected value="1">1</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                </select>
              </td>
            </tr>

            <tr>
              <td width=10% align=right>行业详细</td>
              <td width=90% colspan=5>
                <select name="industry_details" onChange="CalculatePrice(1);" style="WIDTH:280">
                  <option selected value="1">1</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                  <option>----------------------Select One----------------------</option>
                </select>
              </td>
              <input type="hidden" name="selAdditionalDetails" id="selAdditionalDetails" value="">
              <tr>
                <td colspan=6><img src="/images/spacer.gif" width="1" height="1"></td>
              </tr>
              <tr>
                <td width=10% align=right>价格 (USD)</td>
                <td class=bgw height=25 colspan=5><img name="picprice" src="images/spacer.gif" width="1" height="1" align="texttop"><span class=big><span class=red><strong><div id="lyPrice"></div></strong></span></span></td>
              </tr>
              <tr>
                      <td width=10% align=right></td><td class=bgw height=25 colspan=5 id="otherfa"><input type="button" value="订购其他尺寸图片" onclick="c_seat(otherfa,othero);"/></td>


                    </tr>
              <tr>
                <td width=10% align=right></td>
                <td width=90% colspan=5>
                  <input  type="submit"  value="提交">&nbsp;
                </td>
              </tr>
              <input type="hidden" name="LicenseType" value="4">
          </table></form>
          <form name="ordering" action="?" method="POST">
        <div id="othero" style="display:none;width:300px;height:170px;border:1px solid #ccc;position:absolute;z-index:99;background-color:#E0EDFE;">
          <table >
            <tr>
              <td colspan="2"><b>注意：</b></td>
            </tr>
            <tr>
              <td colspan="2">　　订购其他尺寸图片需要额外支付一部分费用。</td>
            </tr>
            <tr>
              <td colspan="2"></td>
            </tr>
            <tr>
              <td align="right">请输入您需要的图片大小：</td><td><input type="text" name="psize" size="10"/>&nbsp;MB</td>
            </tr>
            <tr>
              <td colspan="2">
              </td>
            </tr>
            <tr>
              <td align="right"><input type="button" value="计算价格"/></td><td><input type="text" name="pri" size="10"/>&nbsp;RMB</td>
            </tr>

            <tr>
              <td colspan="2">&nbsp;
              </td>
            </tr>
            <tr>
              <td colspan="2" align="center"><input type="button" value="订购" onclick="ordered();"/></td>
            </tr>
          </table>


        </div>
        </form>
          <%

        }
        %>
        </div>

        <%if(request.getParameter("back")==null){%>

        <%}%></div>
         <script type="">
        function ordered()
        {

          if(submitText(ordering.psize,'无效-图片大小')&&submitInteger(ordering.psize,'无效-图片大小')&&submitText(ordering.pri,'无效-价格'))
          {
            currentPos = 'othero';
            var url = "/jsp/bpicture/Lightbox_ajax.jsp?act=ordering&psize="+document.ordering.psize.value+"&pri="+document.ordering.pri.value+"&pic=<%=nodes%>";
            url = encodeURI(url);
            send_request(url);
          }
        }

        function sad()
        {
          if(document.getElementById('othero').style.display=='none')
          {
            document.getElementById('othero').style.display='';
          }else
          {
            document.getElementById('othero').style.display='none';
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
        function c_seat(id,m)
        {

          m.style.display='none';
          if(id!=cm)
          {
            m.style.display='';
            m.style.pixelLeft = getPos(id,"Left");
            m.style.pixelTop = getPos(id,"Top") + id.offsetHeight;
            cm=id;
          }else
          {
            m.style.display='none';
            cm=null;
          }

        }
        </script>
        <%if(request.getParameter("back")!=null){%>
        <div id="jspafter">
  <%=c.getJspAfter(teasession._nLanguage)%>
</div>
<%}%>
  </body>
</html>
