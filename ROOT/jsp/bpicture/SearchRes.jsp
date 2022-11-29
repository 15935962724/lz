<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.entity.bpicture.*" %>
<%@ page import="java.util.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="java.math.BigDecimal" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.db.*" %>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("progma","no-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires",0);
TeaSession teasession =new TeaSession(request);
HttpSession sessions = request.getSession(true);
Community c=Community.find(teasession._strCommunity);

String lightbox = request.getParameter("lightbox");
if(teasession._rv!=null){
  Bperson bp = Bperson.find(Bperson.findId(teasession._rv._strR));
  if(lightbox==null)
  {
    lightbox = bp.getCurrentlightbox();
  }
}


StringBuffer param=new StringBuffer("?community=").append(teasession._strCommunity);
StringBuffer sql=new StringBuffer(" and node in (select node from baudit where  passpage=1 and property!=0) and community=").append(DbAdapter.cite(teasession._strCommunity)).append(" and node not in(2198115,2198116)");

String keywords = request.getParameter("keywords");
String newkey = request.getParameter("newkey");
if(newkey!=null)
{
  keywords += " "+newkey;
}

//结果查询
if(keywords!=null && keywords.length()>0)
{
  sql.append(" and node in (");
  StringBuffer sqlnew = new StringBuffer();
  StringBuffer sqlq = new StringBuffer();
  StringBuffer sqlh = new StringBuffer();
  String[] keyAr = keywords.split(" ");
  if(newkey == null){
    sql.append("select node from nodelayer where subject = "+DbAdapter.cite(keywords));
  }else{
    for(int i = 0; i < keyAr.length; i ++){

      if(i==0){
        sqlnew.append("select node,subject from nodelayer where subject = "+DbAdapter.cite(keyAr[i]));
      }else if(i == 1){
        sqlq.append("select node from (");
        sqlh.append(") t where subject = "+DbAdapter.cite(keyAr[i]));
      }else
      {
        sqlq.append("select node,subject from (");
        sqlh.append(") t where subject = "+DbAdapter.cite(keyAr[i]));
      }
    }

    sql.append(sqlq.toString()).append(sqlnew.toString()).append(sqlh.toString());
  }

  sql.append(")");

//  param.append("&keywords=").append(java.net.URLEncoder.encode(keywords,"UTF-8"));

}
//高级查询关键字
String allkey = request.getParameter("allkey");
String comkey = request.getParameter("comkey");
if(allkey!=null&& allkey.length()>0)
{
  session.setAttribute("allkey",allkey);
  sql.append(" and node in (select node from nodelayer where subject = "+DbAdapter.cite(allkey)+")");
  keywords = allkey;
}
if(comkey!=null&& comkey.length()>0)
{
  session.setAttribute("comkey",comkey);
  sql.append(" and node in (select node from nodelayer where subject = "+DbAdapter.cite(" "+comkey));
  keywords += " '"+comkey +"'";
}
if(keywords!=null&&keywords.length()>0){
  param.append("&keywords=").append(java.net.URLEncoder.encode(keywords,"UTF-8"));
}

//授权类型
String rm = request.getParameter("rm");
String rf = request.getParameter("rf");
if(rm!=null){session.setAttribute("rm",rm);}
if(rf!=null){session.setAttribute("rf",rf);}
if(rm!=null&&rm.length()>0 && rf==null)
{
  sql.append(" and node in (select node from baudit where property=2)");
  param.append("&rm=").append(java.net.URLEncoder.encode(rm,"UTF-8"));
}
if(rf!=null&&rf.length()>0 && rm==null)
{
  sql.append(" and node in (select node from baudit where property in(1,3))");
  param.append("&rf=").append(java.net.URLEncoder.encode(rf,"UTF-8"));
}

//if(rf!=null&&rf.length()>0 &&rm!=null&&rf.length()>0)
//{
  //  sql.append(" and node in (select node from baudit where property in(1,2,3))");
  //  param.append("&rf=").append(java.net.URLEncoder.encode(rf,"UTF-8")).append("&rm=").append(java.net.URLEncoder.encode(rm,"UTF-8"));
  //}

  //权利保护
  String model = request.getParameter("model");
  String pr = request.getParameter("pr");
  if(model!=null&&model.length()>0 && pr==null)
  {
    session.setAttribute("mr",model);
    sql.append(" and node in (select node from baudit where photography=1)");
    param.append("&model=").append(java.net.URLEncoder.encode(model,"UTF-8"));
  }
  if(pr!=null&&pr.length()>0 && model==null)
  {
    session.setAttribute("pr",pr);
    sql.append(" and node in (select node from baudit where design=1)");
    param.append("&pr=").append(java.net.URLEncoder.encode(pr,"UTF-8"));
  }
  if(pr!=null&&pr.length()>0 &&model!=null&&model.length()>0)
  {
    session.setAttribute("pr",pr);
    session.setAttribute("mr",model);
    sql.append(" and node in (select node from baudit where photography=1 and design=1)");
    param.append("&pr=").append(java.net.URLEncoder.encode(pr,"UTF-8")).append("&model=").append(java.net.URLEncoder.encode(model,"UTF-8"));
  }

//分类
String[] ot = request.getParameterValues("ot");
if(ot!=null&&ot.length>0)
{

  sql.append(" and node in (select node from baudit where");
  for(int i = 0; i < ot.length; i ++)
  {
    sessions.setAttribute("ot"+i,ot[i]);
    if(i == 0){
      sql.append(" classific like ").append(DbAdapter.cite("%"+ot[i]+"%"));
    }else{
      sql.append(" or classific like ").append(DbAdapter.cite("%"+ot[i]+"%"));
    }
  }
  sql.append(")");
}
//文件大小
String size = request.getParameter("size");
if(size!=null&&!size.equals("0")){
  sessions.setAttribute("size",size);
  //((int)((widthel*heightel*3F/(1024*1024))*100))/100F
  int isize = Integer.parseInt(size);
  int fsize = (int)(isize*100F/100*1024*1024)/3;
  sql.append(" and node in (select node from picture where width*height>"+fsize+")");
}
String url = request.getRequestURI()+param.toString();

int pos = 0;
if (request.getParameter("pos") != null&&request.getParameter("pos").length()>0) {
  pos = Integer.parseInt(request.getParameter("pos"));
}
int pageSize = 5;
if (request.getParameter("npgs") != null) {
  pageSize = Integer.parseInt(request.getParameter("npgs"));
}
int count = 0;
count = Node.count(sql.toString());
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<title>图片查询</title>
<style type="text/css">
.lzj_a{margin:0 10px;color:#0000CC; text-decoration:none;}
#my-B-picture{color:#000;font-weight:bold;text-decoration:none;margin:0 10px;}
#sear{text-align:left;padding-left:70px;}
#qt{width:210px;height:23px;border:1px solid #809EBA;background:#fff;}
#lzj_bg{font-size:12px;}
#lzj_bg td{padding:3px 0;}
#lzj_bg a{color:#0000cc;}
#lzj_an{width:45px;height:23px;background:url(/res/bigpic/u/0812/081243710.jpg) no-repeat;border:0;margin:0 10px;}
.kuan{border:0;}
#tablecenter001{border-top:1px solid #67A7E4;background:#D6E6FF;font-size:12px;color:#012DA8;}
.padleft{padding-left:10px;}
.top{border-top:1px solid #cccccc;margin-top:15px;}
.top td{font-size:12px;line-height:150%;}
.top a{color:0000cc;}
#lzj_cz{align:left;line-height:150%;}
#lzj_zi{font-weight:bold;}
</style>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/load.js" type="text/javascript"></SCRIPT>
<script type="">
function add_cart(me)
{

  var rv = '<%=teasession._rv%>';

  if(rv == 'null')
  {

    window.location.href='/jsp/user/StartLogin.jsp?nexturl=<%=url%>';
  }else{
    currentPos = 'cart_'+me;
    var url = "/jsp/bpicture/Lightbox_ajax.jsp?act=cart&pic="+me+"&lightbox=<%=lightbox%>";
    url = encodeURI(url);
    send_request(url);
  }
}
function c_jax(me)
{

  var rv = '<%=teasession._rv%>';
  if(rv == 'null')
  {
    window.location.href='/jsp/user/StartLogin.jsp?nexturl=<%=url%>';
  }else{
    currentPos = 'lit_'+me;
    var url = "/jsp/bpicture/Lightbox_ajax.jsp?act=lit&pic="+me;
    url = encodeURI(url);
    send_request(url);
  }
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
<body style="margin:0;padding:0;" id="wai1">
<div style="background:#F6F6F6;padding-bottom:10px;padding-top:8px;"><!--
  <div id="dv1">
    <a title="管理帐户并访问您的形象" href="/jsp/admin" id="my-B-picture">我的B-picture</a>|
    <%
    if(teasession._rv==null){
      %>
      <a class="lzj_a" href="/jsp/bpicture/regist/StartLogin.jsp?nexturl=<%=url%>">登录</a>|
      <a class="lzj_a" title="它是免费的" href="/jsp/bpicture/regist/register.jsp">注册</a>|
      <%}else{%>
      <a class="lzj_a" id="cancels" href="/servlet/Logout?community=<%=teasession._strCommunity%>&node=<%=c.getLogin()%>&nexturl=<%=url%>" target=_top >&nbsp;登出</a>|
      <%}%>
      <a class="lzj_a" title="编辑和管理您的灯箱" href="/jsp/admin/right.jsp?id=130526&node=2198115&community=bigpic">收藏图库</a>|
      <a class="lzj_a" href="/jsp/admin/right.jsp?id=130518&node=2198115&community=bigpic">购物车</a>|
      <a class="lzj_a" title="您的订单，发票和下载图像" href="#">订单</a>|
      <a class="lzj_a" href="#">联系我们</a>|
      <a class="lzj_a" href="#">帮助</a>
  </div>
  -->

  <form action="?" id="sear" name="search" method="get">
  <table width="530" cellpadding="0" cellspacing="0"  id="lzj_bg">
    <tr>
      <td>
        <input type="text" name="keywords" value="<%if(keywords!=null){out.print(keywords);}%>" id="qt" title="输入关键字，名称或参考号码。" /></td>
      <td><input name="submit" type="submit" id="lzj_an" value="搜索"/></td>
      <td>
        <label for="rm" title="查找版权管理类图片">
          <input id="rm" class="kuan" type="checkbox" name="rm" value="2" <%if(rm!=null)out.print("checked");%>/></label>

        <label for="rf" title="查找免版税图片"></label></td>
      <td><label for="label" title="查找版权管理类图片">版权管理类图片(RM)</label></td>
      <td><label for="rf" title="查找免版税图片">
       <input id="rf" class="kuan" type="checkbox" name="rf" value="1" <%if(rf!=null)out.print("checked");%>/>
      </label>
        <label for="rf" title="查找免版税图片"></label></td>
      <td>免版税图片(RF
        <label for="label" title="查找免版税图片"> </label>
        <label for="label" title="查找免版税图片">) </label></td>
    </tr>
    <tr>
      <td colspan="2"><%if(keywords==null){out.print("在结果中搜索");}else{if(keywords.length()==0){out.print("在结果中搜索");}else{%><a href="/servlet/Folder?node=2198223&language=1&keywords=<%=keywords%>&count=<%=count%>">在结果中搜索</a><%}}%>　<a href="/servlet/Folder?node=2198222&language=1" id="advanced">高级搜索</a></td>
    </tr>
  </table>
  </form>
</div>
<DIV style="WIDTH:100%;MARGIN:0 AUTO;text-ALIGN:CENTER;">
<h2><a href="/servlet/Node?node=2198115" >首页</a>  &gt; 搜索结果</h2>
<table align=center cellpadding=2 cellspacing=0 border=0 id="tablecenter001">
  <form name="fm" action="?">
  <input type="hidden" name="keywords" value="<%if(keywords!=null)out.print(keywords);%>"/>
  <!--<input type="hidden" name="rf" value="<%if(rf!=null)out.print(rf);%>"/>
    <input type="hidden" name="rm" value="<%if(rm!=null)out.print(rm);%>"/>-->
    <input type="hidden" name="pos" value="<%if(pos!=0)out.print(pos);%>"/>
    <tr>
      <td width=90% nowrap class="padleft">图片<%if(keywords!=null&&keywords.length()>0){out.print("("+count+")");}%></td>

      <td width=5% nowrap>每页图片数目:</td>
      <td width=5% class="padright"><select name="npgs" class=button onChange="document.fm.submit();">
        <OPTION value="5" <%if(pageSize == 5)out.print("selected");%>>5</OPTION>

        <OPTION value="10" <%if(pageSize == 10)out.print("selected");%>>10</OPTION>
        <OPTION value="20" <%if(pageSize == 20)out.print("selected");%>>20</OPTION>
        <OPTION value="40" <%if(pageSize == 40)out.print("selected");%>>40</OPTION>
</select>
      </td>
    </tr>
  </form>
</table>
<div style="padding-top:10px;text-align:right;">
  <table width="95%" align="center">
    <tr align="center">
    <%
    Enumeration noe = Node.find(sql.toString(),pos,pageSize);
    if(keywords!=null&&keywords.length()>0){
      if(noe.hasMoreElements()){
        for(int i = 0;noe.hasMoreElements(); i++)
        {
          int node = ((Integer) noe.nextElement()).intValue();
          Picture p = Picture.find(node);
          Node n = Node.find(node);
          Baudit ba = Baudit.find(node);
          String rfl = "";
          if(ba.getProperty() == 2)
          {
            rfl="(L)";
          }else{
            rfl="(RF)";
          }
          String picture ="/res/"+teasession._strCommunity+"/picture/"+node+".jpg";

          out.print("<td valign=bottom width=180 nowrap align=center>");
          out.print("<a href=# onclick=window.open('/jsp/bpicture/ImageInfo.jsp?nodes="+node+"','_blank'); ><img src="+picture+" border=0 width=160 /></a><br>"+n.getSubject(1)+"&nbsp;-&nbsp;"+rfl+"<br/>");
          out.print("<a href=# onclick='c_jax("+node+")'><span id=lit_"+node+"><img src=/tea/image/bpicture/add_lightbox.gif alt=添加至图库 width=17 height=17 border=0 name=l1></span></a>");
          out.print("&nbsp;<a href=# onclick='add_cart("+node+")'><span id=cart_"+node+"><img width=17 height=17 border=0 src=/tea/image/bpicture/add_cart.gif alt=放入购物车></span></a>");
          out.print("&nbsp;<a href=/jsp/bpicture/buyer/CalPrice.jsp?nexturl="+request.getRequestURI()+"&nodes="+node+"><img width=17 height=17 border=0 src=/tea/image/bpicture/cal_price.gif alt=计算价格></a>");
          out.print("<td>");
          if((i+1)%5 ==0){
            out.print("</tr><tr>");
          }
        }
      }else{
        out.print("<td colspan=6 id=lzj_cz align=left>找不到和您的查询相符的网页。<br><br/><span id=lzj_zi>建议：</span><br/>　　请检查输入字词有无错误。<br/>　　请换用另外的查询字词。<br/>　　请改用较常见的字词。<br/>　　请减少查询字词的数量。");
      }
    }else
    {
      out.print("<td colspan=6 id=lzj_cz align=left>找不到和您的查询相符的网页。<br><br/><span id=lzj_zi>建议：</span><br/>　　请检查输入字词有无错误。<br/>　　请换用另外的查询字词。<br/>　　请改用较常见的字词。<br/>　　请减少查询字词的数量。");
    }
    %>
    </tr>
    <%


    if(keywords!=null&&keywords.length()>0){
      if(count>pageSize&&keywords!=null){
        %>
        <tr>
          <td colspan="15" align="right" style="padding-right:5px;">
            <%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&npgs="+pageSize+"&pos=",pos,count,pageSize)%>      </td>
        </tr>
        <%}
        }%>
        </table>
</div>
<div style="padding-top:10px;">
<%
if(teasession._rv!=null){
  %>
  <table align="center" cellpadding=2 cellspacing=0 id="tablecenter001" style="border:0;">
    <tr class=bg8>
      <form id="frmMain" name="frm1" action="?" method="get">
      <td width="90%" class="padleft">当前图库</td>
      <td width="10%" class="padright">
        <select id="Lightboxes" class="lightbox" name="lightbox" onChange="currn_jax(this)" style="WIDTH: 264;">
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
      </form>
    </tr>
  </table>
  <%}%>
</div>
</DIV>
</body>
</html>
