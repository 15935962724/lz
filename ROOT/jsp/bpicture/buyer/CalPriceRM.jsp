<%@page contentType="text/html;charset=UTF-8"  %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="tea.entity.bpicture.*" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="java.awt.image.*" %>
<%@ page import="javax.imageio.*" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="tea.html.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.io.*"%>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.entity.site.*" %>
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
Node node = Node.find(nodes);
String nexturl = request.getParameter("nexturl");
if (teasession._rv == null)
{
  response.sendRedirect("/servlet/Node?node=2198284&language=1");
  return;
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
  File fp=new File(application.getRealPath(picture));
  if(fp.isFile())
  {
    lenel=fp.length();
    BufferedImage bi = ImageIO.read(fp);
    widthel = bi.getWidth();
    heightel = bi.getHeight();
    ExifReader erel = new ExifReader(application.getRealPath(picture));
    numel =  Integer.parseInt(erel.getResolution());
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




/**设置限定*/
//StringBuffer x_territory=new StringBuffer();//
//StringBuffer x_country=new StringBuffer();
StringBuffer x_image_use=new StringBuffer();
StringBuffer x_image_details=new StringBuffer();
StringBuffer x_product_industry=new StringBuffer();
//StringBuffer x_industry_details=new StringBuffer();
StringBuffer x_showinfo=new StringBuffer();

java.util.Enumeration reeb=Blimit.findByCommunity(teasession._strCommunity," and node ="+nodes,0,Integer.MAX_VALUE);
if(!reeb.hasMoreElements())
{

}
for(int jx=0;reeb.hasMoreElements();jx++)
{
  int idx =Integer.parseInt(String.valueOf(reeb.nextElement()));
  Blimit bt = Blimit.find(idx);
  if(bt.getImage_details().equals("0") && bt.getImage_use()!="0")
  {
    x_image_use.append("/").append(bt.getImage_use());
  }
  if(bt.getProduct_industry().equals("0") &&  bt.getImage_details()!="0")
  {
    x_image_details.append("/").append(bt.getImage_details());
  }else
  {
    x_product_industry.append("/").append(bt.getProduct_industry());
  }
}

x_image_use.append("/");
x_image_details.append("/");
x_product_industry.append("/");


%>
<html>
<HEAD>
  <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
  <script type=""> if(parent.lantk) { document.getElementsByTagName("LINK")[0].href="/res/csvclub/cssjs/community_02.css"; } </script>
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/load.js" type="" ></SCRIPT>
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="" ></SCRIPT>
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="/res/<%=teasession._strCommunity%>/cssjs/3js.js" type="" ></SCRIPT>
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
  function load()////图片用途 显示
  {
    var j=1;
    for (i=0;i < aU.length; i++)
    {
      document.form1.image_use.options[j++] = new Option(aU[i][2],aU[i][0]);
    }
    document.getElementById('tr_mailing').style.display="none";
  }
  function image_use_f(Id)////图片用途 点击
  {
    var j=1;
    var op= document.form1.image_details.options;
    while(op.length>1)
    {
      op[1]=null;
    }
    var op3= document.form1.image_size.options;
    while(op3.length>1)
    {
      op3[1]=null;
    }

    for (i=0;i < aM.length; i++)
    {
      if(aM[i][1]==Id)//类型
      document.form1.image_details.options[j++] = new Option(aM[i][3],aM[i][0]);
    }
    document.getElementById('tr_mailing').style.display="none";
  }
  function image_details_f(Id)///详细用途 点击
  {
    var j=1;
    var op3= document.form1.image_size.options;
    while(op3.length>1)
    {
      op3[1]=null;
    }
    for (i=0;i < aM.length; i++)
    {
      if(aM[i][0]==Id)
      {
        for (k=0;k < aI.length; k++)
        {
          if(aI[k][0]==aM[i][5])//类型
          document.form1.image_size.options[j++] = new Option(aI[k][3],aI[k][1]);
        }
      }
    }
    document.getElementById('tr_mailing').style.display="none";
  }
  //新添
  function image_size_f(Id)
  {
    for (i=0;i < aM.length; i++)
    {
      if(aM[i][0]==Id)
      {
        for (k=0;k < aP.length; k++)
        {
          if(aP[k][0]==aM[i][6])//类型
          document.form1.image_size.options[j++] = new Option(aP[k][3],aP[k][1]);
        }
      }
    }
    if(Id==23||Id==16||Id==15)
    {
      document.getElementById('tr_mailing').style.display="";
    }
    else
    {
      document.getElementById('tr_mailing').style.display="none";
    }
  }
  function getprice()
  {
    if(submitInteger(document.form1.image_print,'无效-数量')){
      var nm = parseInt(document.form1.image_print.value);
      if(nm < 1)
      {
        alert('无效-数量');
        document.form1.image_print.focus();

        return false;
      }
    }
    var num=0;
    var numsize=0;
    var numprice=0;
    var numprice=0;
    for(i=0;i<aM.length;i++)//详细用途
    {
      if(aM[i][0]==document.form1.image_details.value)
      {
        num=parseFloat(num) +parseFloat(aM[i][2]);
      }
    }
    for(i=0;i<aI.length;i++)//图片大小
    {
      if(aI[i][1]==document.form1.image_size.value)
      {
        num=parseInt(num) +parseInt(aI[i][2]);
        numsize=parseInt(aI[i][4]);
        numprice=parseInt(aI[i][5]);
      }
    }
    if(document.form1.image_print.value>numsize)
    {
      num=parseInt(num) +(parseInt(document.form1.image_print.value)-parseInt(numsize))*numprice;
    }


    if(document.form1.inserts.value!=null && document.form1.inserts.value!="")
    {
      if(document.form1.image_size.value==23)
      {
        if(parseInt(document.form1.inserts.value)<5)
        {
          num=num+500*parseInt(document.form1.inserts.value)*0.25;
        }
        else if(parseInt(document.form1.inserts.value)>4)
        {
          num=num+500;
        }
      }else if(document.form1.image_size.value==15)
      {
        num=num+500*parseInt(document.form1.inserts.value/3)*0.5;
      }else if(document.form1.image_size.value==16)
      {
        num=num+2000*parseInt(document.form1.inserts.value/3);
      }
    }
    document.form1.pcprice.value=num;

  }

  function f_delete()
  {
    str="<%=x_image_use.toString()%>";
    var op=form1.image_use;
    for(var i=0;i<op.length;i++)
    {
      if(str.indexOf("/"+op[i].value+"/")!=-1)
      {
        op[i--]=null;
      }
    }
    str="<%=x_image_details.toString()%>";
    var op=form1.image_details;
    for(var i=0;i<op.length;i++)
    {
      if(str.indexOf("/"+op[i].value+"/")!=-1)
      {
        op[i--]=null;
      }
    }
    str="<%=x_product_industry.toString()%>";
    var op=form1.image_size;
    for(var i=0;i<op.length;i++)
    {
      if(str.indexOf("/"+op[i].value+"/")!=-1)
      {
        op[i--]=null;
      }
    }
  }
  window.setInterval(f_delete,500);//定时器

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
    currentPos = 'lit_'+document.form1.nodes.value;
    var url = "/jsp/bpicture/Lightbox_ajax.jsp?act=lit&pic="+document.form1.nodes.value;
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
  </script>
  <style>
  #table001{background:#F6F6F6;border-bottom:10px solid #eee;border-top:10px solid #eee;padding:6px;width:95%;margin-top:10px;}
  #table001 td{padding:5px;}
  #lzj_img td{padding:15px;}
  .lzj_001{height:23px;border:1px solid #7F9DB9;background:#fff;line-height:20px;*line-height:14px;padding-bottom:5px;*paddding-bottom:0;}
  </style>
</HEAD>
<body style="margin:0;" onLoad="load()">
<%if(request.getParameter("back").equals("1")){%>
<div id="jspbefore">
  <%=c.getJspBefore(teasession._nLanguage)%>
</div>
<%}%>
<div id="wai">
  <div id="li_biao"><a href="http://bp.redcome.com" target="_top">首页</a>&nbsp;>&nbsp;管理中心&nbsp;>&nbsp;计算价格</div>
  <h1>计算价格</h1>

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
          <select id="Lightboxes" class="lightbox" name="lightbox"  style="WIDTH: 104;">
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

  <form name="form1" action="/servlet/EditBPperson" method="get">
  <input type="hidden" name="act" value="calprice">
  <input type="hidden" name="picsize" value="0">
  <input type="hidden" name="back" value="<%if(request.getParameter("back")!=null){out.print(request.getParameter("back"));}%>"/>
  <input type="hidden" name="id" value="<%=ids%>" />
  <input name="typepic" value="2" type="hidden">
  <input type="hidden" name="nodes" value="<%=nodes%>">
  <table border="0" cellpadding="3" cellspacing="0" id="table001">
    <tr id="lzj_img">
      <td rowspan="19" align=right valign="top" nowrap="nowrap"><img src="<%=picture%>" width="150" ></td>
        <td  ><%=subject%>（<font color="blue">RM</font>）</td>
        <td colspan="5">版权管理类图片</td>
    </tr>
    <tr>
      <td nowrap><span id=lit_<%=nodes%> ><a href=# onclick='c_seat(lit_<%=nodes%>,light,<%=nodes%>);'><img src="/tea/image/bpicture/add_lightbox.gif" alt="添加至收藏夹" width=17 height=17 border=0 name=l1></a></span><a href="#" onclick='c_seat(lit_<%=nodes%>,light,<%=nodes%>);'>&nbsp;添加至收藏夹</a></td>
        <td colspan="5">联系我们-销售咨询电子邮件edn@redcome.com或电话：</td>
    </tr>
    <tr>
      <td height="20"><span id="<%=nodes%>"><a href="#" onClick='add_jax(<%=nodes%>);'><img width="17" height="17" border="0" src="/tea/image/bpicture/add_cart.gif" alt="放入购物车"></a></span><a href="#" onClick='add_jax(<%=nodes%>);'>&nbsp;放进购物车</a></td>
        <td colspan="5">联系电话☎：12345678912</td>
    </tr>
    <tr>
      <td height="20"><span style="margin-right:12px;"><a href='/jsp/bpicture/ImageInfo.jsp?nodes=<%=nodes%>&back=1'><img src="/tea/image/bpicture/image_details.gif" alt="图片信息" width="17" height="17" border="0"></a>
        <a href='/jsp/bpicture/ImageInfo.jsp?nodes=<%=nodes%>&back=1'>图片信息</a></span></td>
        <td colspan="5">联系电话☎：13131345431</td>
    </tr>
    <tr>
      <td height="20">  </td>
      <td >联系电话☎：010-8870799</td>
    </tr>
    <tr>
    <td>&nbsp;</td><td>
    <%
    String deldates = "";
    Calendar cal = Calendar.getInstance();
    if(Bperson.delTime(picMember)!=null){
      Date deldate = Bperson.delTime(picMember);
      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
      cal.setTime(deldate);//设置日历时间
      cal.add(Calendar.MONTH,1);//删除摄影师后一个月的日期
      deldates = sdf.format(cal.getTime());
    }
    if(isSalerDel){
      %>
      提示：该图片将在&nbsp;<font color="red"><%=deldates%></font>&nbsp;被移除,预购从速!
      <%}%>&nbsp;
    </td>
    </tr>
    <tr>
      <td align=right nowrap="nowrap">&nbsp;</td>
      <td >标题：<%=node.getSubject(teasession._nLanguage)%></td>
    </tr>
    <tr>
      <td align=right nowrap="nowrap">&nbsp;</td>
      <td >最大文件大小：<%=(int)(widthel*heightel*3F/(1024*1024))%>MB   <%=widthel%> x <%=heightel%></td>
    </tr>
    <tr>
      <td align=right nowrap="nowrap">图片用途</td>
      <td>
        <select name="image_use" onChange="image_use_f(value)">
          <option selected value="0">-------</option>
        </select>        </td>
    </tr>

    <tr>
      <td align=right>详细用途</td>
      <td>
        <select name="image_details" onChange="image_details_f(document.form1.image_details.options[document.form1.image_details.selectedIndex].value)">
          <option selected value="0">-------</option>
        </select>        </td>
    </tr>
    <tr>
      <td align=right>用途分类<!--图片大小--></td>
      <td>
        <select name="image_size" onChange="image_size_f(document.form1.image_size.options[document.form1.image_size.selectedIndex].value)" style="WIDTH:280">
          <option selected value="0">-------</option>
        </select>        </td>
    </tr>
    <tr>
      <td align=right>数量<!--印数--></td>
      <td>
        <input name="image_print"  style="WIDTH:280" value="">（广告块数、网站发布数量、应用的报纸种类）
      </td>
    </tr>
    <tbody  id="tr_mailing" style="display:none">
      <tr>
        <td></td>
        <td align=right>网站使用月份 或 报纸应用的语言种类<!--插入物--></td>
        <td>
          <input name="inserts" title="" value="" >*</td>
      </tr>
    </tbody>
    <tr>
      <td></td> <td align="right">价格</td>
      <td><input type="text" name="pcprice" readonly="readonly"/></td>
    </tr>
    <tr>
      <td></td><td align="right"></td><td id="otherfa"><input type="button" value="订购其他尺寸图片" onclick="c_seat(otherfa,othero);"/></td>
    </tr>
    <tr>
      <td width=36 align=right>&nbsp;</td>
      <td align=right>&nbsp;<input  type="button" class="lzj_001" onClick="getprice()"  value="计算价格">
        &nbsp;</td>
        <td><input  type="submit" class="lzj_001"  value="提交"">
        &nbsp;
        </td>
    </tr>
    <input type="hidden" name="LicenseType" value="4">
  </table>
  </form>
</div>
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
        <%if(request.getParameter("back").equals("1")){%>
        <div id="jspafter">
          <%=c.getJspAfter(teasession._nLanguage)%>
        </div>
        <%}%>
</body>
</html>
