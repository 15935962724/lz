<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="tea.ui.TeaSession"%>
<%@ page import="org.apache.lucene.index.*"%>
<%@ page import="org.apache.lucene.search.*"%>
<%@ page import="tea.entity.util.*"%>
<%@ page import="tea.entity.node.*"%>
<%@page import="org.apache.lucene.queryParser.*" %>
<%@page import="org.apache.lucene.analysis.standard.*" %>
<%@page import="org.apache.lucene.document.*" %>
<%@ page import="java.util.*"%>
<%@ page import="tea.entity.site.*"%>
<%@ page import="tea.entity.bpicture.*" %>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("progma","no-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires",0);
TeaSession teasession=new TeaSession(request);
//HttpSession sessions = request.getSession(true);

String community=teasession._strCommunity;
Community c = Community.find(teasession._strCommunity);
String lightbox = request.getParameter("lightbox");
if(teasession._rv!=null){
  Bperson bp = Bperson.find(Bperson.findId(teasession._rv._strR));
  if(lightbox==null)
  {
    lightbox = bp.getCurrentlightbox();
  }
}
tea.resource.Resource r=new tea.resource.Resource("/tea/resource/Lucene");

java.io.File f=new java.io.File(application.getRealPath("/res/" + community + "/searchindex/bpickey_1"));
if(!f.exists())
{
  response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode(r.getString(teasession._nLanguage,"1169017432031"),"UTF-8"));//没有发现索引文件
  return;
}

int status=teasession._nStatus;

long lo=System.currentTimeMillis();

//各种关键字
String searchtype = "1";
String keywords = "";
//结果中搜索

String newkey = "";
if(teasession.getParameter("searchtype")!=null){
  searchtype = teasession.getParameter("searchtype");
}
if(searchtype.equals("2"))
{
  newkey = teasession.getParameter("bp_keywords");
  keywords = teasession.getParameter("nkey");
  if(newkey==null)
  newkey="";
  else
  if((newkey=newkey.trim()).length()>64)
  {
    newkey=newkey.substring(0,64);
  }
}else{
  keywords = teasession.getParameter("bp_keywords");
}

String comkey = request.getParameter("comkey");
String onlykey = request.getParameter("onlykey");
String notkey = request.getParameter("notkey");

if(keywords==null)
keywords="";
else
if((keywords=keywords.trim()).length()>64)
{
  keywords=keywords.substring(0,64);
}


if(comkey==null)
comkey="";
else{
  if((comkey=comkey.trim()).length()>64)
  {
    comkey=comkey.substring(0,64);
  }
  if(keywords.length()==0)
  {
    keywords = comkey.replaceAll("'","");
  }else
  {
    keywords += " "+comkey.replaceAll("'","");
  }
}

if(onlykey==null)
onlykey="";
else
if((onlykey=onlykey.trim()).length()>64)
{
  keywords += " "+onlykey.substring(0,64);
}else
{
  keywords += " "+onlykey;
}

if(notkey==null)
notkey="";
else{
  notkey = notkey.replace("NOT","");
  notkey = notkey.replace("'","");
  if((notkey=notkey.trim()).length()>64)
  {
    notkey=notkey.substring(0,64);
  }
}

StringBuffer param=new StringBuffer(request.getRequestURI());
param.append("?node=").append(teasession._nNode);
param.append("&community=").append(community);
param.append("&bp_keywords=").append(java.net.URLEncoder.encode(keywords,"UTF-8"));

int type=0;
if("1".equals(request.getParameter("type")))
type=1;

param.append("&type=").append(type);

int pos=0;
if(request.getParameter("pos")!=null){
  pos=Integer.parseInt(request.getParameter("pos"));
}

int sum=0;
org.apache.lucene.search.Hits hits=null;
org.apache.lucene.search.Searcher searcher=null;
int sum1=0;
org.apache.lucene.search.Hits hits1=null;


searcher = new org.apache.lucene.search.IndexSearcher(f.getAbsolutePath());
BooleanQuery bq = new BooleanQuery();
BooleanQuery bq1 = new BooleanQuery();

//  bq.setMaxClauseCount(Integer.MAX_VALUE);

String rm = request.getParameter("rm");
String rf = request.getParameter("rf");
String size = request.getParameter("size");
//版权
String property = "0";

if(rm==null&&rf==null)
{
  rm = "2";
  rf = "1";
}
if(rm!=null&&rf==null)
{
  property = "2";
}
if(rf!=null&&rm==null)
{
  property = "1";
}
String classific = "";

//肖像 &物权
String model = request.getParameter("model");
String pr = request.getParameter("pr");

if(model==null&&pr==null)
{
  model = "2";
  pr = "2";
}else
if(model!=null&&pr==null)
{
  model = "1";
  pr = "2";
}else
if(pr!=null&&model==null)
{
  pr = "1";
  model = "2";
}else
{
  model = "1";
  pr = "1";
}
String nksearch = "";//结果查询关键字字符串
try
{

  if(keywords.length()>0)
  {
    //正常查询

    bq.add(LuceneList.createQuery(keywords,BooleanClause.Occur.SHOULD),BooleanClause.Occur.MUST);
    if(notkey.length()>0)
    {
      bq.add(LuceneList.createQuery(notkey,BooleanClause.Occur.SHOULD),BooleanClause.Occur.MUST_NOT);
    }

    //版权
    if(!property.equals("0"))
    {
      Query proper=new QueryParser("bp_property",new StandardAnalyzer()).parse(property);
      bq.add(proper,BooleanClause.Occur.MUST);
    }

    //肖像&物权

    if(!(model.equals("2"))||!(pr.equals("2")))
    {
      Query mdl=new QueryParser("bp_model",new StandardAnalyzer()).parse(model);
      bq.add(mdl,BooleanClause.Occur.MUST);
      Query prl=new QueryParser("bp_pr",new StandardAnalyzer()).parse(pr);
      bq.add(prl,BooleanClause.Occur.MUST);
    }

    //分类
    for(int i = 1; i < 5; i ++)
    {
      if(request.getParameter("ot"+i)!=null)
      {
        classific = request.getParameter("ot"+i);
        Query clas=new QueryParser("bp_classific",new StandardAnalyzer()).parse(classific);
        bq.add(clas,BooleanClause.Occur.MUST);
      }
    }

    //文件大小
    if(size!=null&&!size.equals("0"))
    {
      Term begin = new Term("bp_size",size);
      Term end = new Term("bp_size","99");
      bq.add(new RangeQuery(begin, end, true),BooleanClause.Occur.MUST);
    }
  }else
  {
    //查找关键字///
    if(keywords==null)keywords="";
  }

  if(newkey.length()>0)
  {
    //结果中查询
    if(teasession.getParameter("nksearch")!=null){
      nksearch = teasession.getParameter("nksearch");
    }
    nksearch = nksearch + newkey + ",";
    String[] arrNkSearch = nksearch.split(",");
    for(int i = 0; i < arrNkSearch.length; i ++){

      bq.add(LuceneList.createQuery(arrNkSearch[i].toString(),BooleanClause.Occur.SHOULD),BooleanClause.Occur.MUST);

    }

  }

  hits =searcher.search(bq);
  sum=hits.length();

  //
  if(keywords.length()>0&&request.getParameter("similar")==null)
  {
    if(comkey.length()>0)
    {
      String[] kw = keywords.split(" ");
      keywords = kw[0]+" '"+kw[1]+"'";
    }

    if(notkey.length()>0)
    {
      keywords += " NOT '"+notkey+"'";
    }

    if(keywords.contains("@"))
    {
      String[] kw = keywords.split("@");
      keywords = kw[0].toString();
    } 

    Keywords k=Keywords.find(community,keywords);
    k.set(sum,request.getRemoteAddr());
  }
}catch(org.apache.lucene.queryParser.ParseException pe)
{
  pe.printStackTrace();
  System.out.println(keywords);
}
String url = request.getRequestURI();

int pageSize = 100;
if (request.getParameter("npgs") != null) {
  pageSize = Integer.parseInt(request.getParameter("npgs"));
  param.append("&npgs=").append(pageSize);
}

//关键字路径
StringBuffer kwsb = new StringBuffer();
String kwds = "";

if(keywords!=null&&keywords.length()>0&&request.getParameter("similar")==null){
  kwds=">&nbsp;"+keywords;
  if(searchtype!=null){
    if(searchtype.equals("1"))
    {
      kwsb.delete(0,kwsb.length());
    }else{
      if(teasession.getParameter("keyroot")!=null){
        kwsb.append(teasession.getParameter("keyroot"));
      }
      kwsb.append("&nbsp;>&nbsp;").append(newkey);
    }
  }
}


%>


<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<title>图片查询</title>
<style type="text/css">
</style>

<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/load.js" type="text/javascript"></SCRIPT>

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
    var url = "/jsp/bpicture/Lightbox_ajax.jsp?act=lit&pic="+document.frm1.nod.value+"&lightbox="+document.frm1.lightbox.value;
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

function check()
{
  if(document.getElementById('noblank').checked&&document.searchform1.bp_keywords.value.length==0)
  {
    alert('请输入关键字！');
    return false;
  }
  return true;
}

</script>
</head>
<body style="margin:0;padding:0;" id="wai1">
<div id="bpsear" style="background:#F6F6F6;padding-bottom:10px;padding-top:8px;">


  <script src="/tea/tea.js" type=""></script>

  <form name="searchform1" action="?" id="sear" onsubmit="return check();">
  <input type="hidden" name="node" value="<%=teasession._nNode%>"/>
  <input type="hidden" name="community" value="<%=community%>"/>

  <table width="530" cellpadding="0" cellspacing="0" id="lzj_bg" >
    <tr>
      <td width="109">
        <input type="text" name="bp_keywords" value="<%if(searchtype!=null&&searchtype.equals("2")){if(newkey!=null)out.print(newkey);}else{if(keywords!=null&&request.getParameter("similar")==null)out.print(keywords);}%>" id="qt" /></td>
        <input type="hidden" name="nkey" value="<%=keywords%>">
        <input type="hidden" name="keyroot" value="<%=kwsb.toString()%>">
        <input type="hidden" name="nksearch" value="<%=nksearch%>">
        <td width="109"><input type="submit" name="Submit" value="搜索" id="jians"></td>

          <td width="20">
            <input id="rm" class="kuan" type="checkbox" name="rm" value="2" <%if(rm!=null)out.print("checked");%> />          </td>
            <td width="126" nowrap><label for="rm" title="查找版权管理类图片">版权管理类图片(<font color="blue">RM</font>)</label></td>
            <td width="20"><input class="kuan" id="mr" type="checkbox" name="model" value="1" <%if(model.equals("1"))out.print("checked");%> >
            </td>
            <td width="144" nowrap><label for="mr">肖像权许可</label></td>
    </tr>
    <tr>
      <td><input type="radio" checked="checked" class="kuan" name="searchtype" id="r1" value="1" onclick="document.searchform1.bp_keywords.value='<%=keywords%>';"/>&nbsp;<label for="r1">新搜索</label>　　　
        <input id="noblank" type="radio" <%if(searchtype!=null&&searchtype.equals("2")){out.print("checked");}%> onclick="document.searchform1.bp_keywords.value='';" class="kuan" name="searchtype" value="2"/>&nbsp;<label for="noblank">在结果中搜索</label></td>
        <td align="center">&nbsp;<a href="/jsp/bpicture/AdvanSearch.jsp" id="advanced">高级搜索</a></td>
        <td width="20"><input id="rf" class="kuan" type="checkbox" name="rf" value="1" <%if(rf!=null)out.print("checked");%> /></td>
          <td width="126" nowrap><label for="rf" title="查找免版税图片">免版税图片(<font color="#FE8100">RF</font>) </label></td>

          <td width="20"><input class="kuan" id="pr" type="checkbox" name="pr" value="1" <%if(pr.equals("1"))out.print("checked");%> ></td>
            <td width="126" nowrap><label for="pr">物产权许可</label>
              <input type="hidden" name="ns" value="1"></td>
    </tr>
    <tr>
      <td colspan="4"></td>
    </tr>
  </table>

  <script type="">
  searchform1.bp_keywords.focus();
  </script>

  </form>
</div>

<DIV style="WIDTH:100%;MARGIN:0 AUTO;text-ALIGN:CENTER;">

  <span id="bph2"><h2><a href="/servlet/Node?node=<%=c.getNode()%>" >首页</a>  <img alt="" src="/tea/image/netdisk/search.gif" width="15" /> 搜索结果　<%=kwds+kwsb.toString()%></h2></span>
  <table width=100% border=0 align="center" cellpadding=2 cellspacing=0 id="tablecenter001">
    <form name="fm" action="?">
    <input type="hidden" name="nkey" value="<%=keywords%>">
    <input type="hidden" name="keyroot" value="<%=kwsb.toString()%>">
    <input type="hidden" name="nksearch" value="<%=nksearch%>">
    <input type="hidden" name="bp_keywords" value="<%if(searchtype!=null&&searchtype.equals("2")){if(newkey!=null)out.print(newkey);}else{if(keywords!=null)out.print(keywords);}%>"/>
    <input type="hidden" name="pos" value="<%if(pos!=0){out.print(pos);}else{out.print("0");}%>"/>
    <input type="hidden" name="node" value="<%=teasession._nNode%>"/>
    <input type="hidden" name="community" value="<%=community%>"/>
    <input type="hidden" name="keywords" value="<%if(newkey!=null)out.print(newkey);%>"/>
    <input type="hidden" name="comkey" value="<%if(comkey!=null)out.print(comkey);%>"/>
    <input type="hidden" name="notkey" value="<%if(notkey!=null)out.print(notkey);%>"/>
    <input type="hidden" name="rm" value="<%if(rm!=null)out.print(rm);%>"/>
    <input type="hidden" name="rf" value="<%if(rf!=null)out.print(rf);%>"/>
    <input type="hidden" name="size" value="<%if(size!=null)out.print(size);%>"/>
    <tr>
      <td width=90% nowrap class="padleft">图片<%="("+sum+")"%></td>

      <td width=5% nowrap>每页图片数目:</td>
      <td width=5% class="padright"><select name="npgs" class=button onChange="document.fm.submit();">
        <OPTION value="20" <%if(pageSize == 20)out.print("selected");%>>20</OPTION>
        <OPTION value="40" <%if(pageSize == 40)out.print("selected");%>>40</OPTION>
        <OPTION value="60" <%if(pageSize == 60)out.print("selected");%>>60</OPTION>
        <OPTION value="100" <%if(pageSize == 100)out.print("selected");%>>100</OPTION>

</select>
      </td>
    </tr>
    </form>
  </table>
  <%

  out.print("<div id='searchdiv' style='margin-left:50px;padding-top:10px;width:100%'><table width='95%' border='1' align='center'>");
  try
  {
    if(hits == null||sum==0)
    {
      out.print("<tr><td><br/><br/>"+tea.http.RequestHelper.format(r.getString(teasession._nLanguage,"Lucene.NotMatch"),keywords)+"<br/><br/>"+r.getString(teasession._nLanguage,"Suggestions")+"<br/></td></tr>");
    }else
    {
      out.print("<table border='0' align='left' style=\"magin-left:30px\">");
      int a = 0;
      for (int i=pos;i<(pos+pageSize)&&i<sum;i++)
      {
        Document doc = hits.doc(i);
        int node=Integer.parseInt(doc.get("bp_index"));

        int id = 0;
        if(teasession._rv!=null){
          Enumeration e = Bimage.findShopping(" and node="+node+" and member='"+teasession._rv._strR+"'");
          while(e.hasMoreElements())
          {
            id = ((Integer) e.nextElement()).intValue();
          }
        }
        Node n=Node.find(node);
        if(n.getTime()==null)//如果节点已被删除
        {
          continue;
        }
        String subject=doc.get("bp_subject");
        subject=n.getSubject(teasession._nLanguage);
        Picture p = Picture.find(node);
        Baudit ba = Baudit.find(node);
        String rfl = "";

        String simkey = "";
        if(ba.getMainKey().length()>1||ba.getBasicKey().length()>1||ba.getInteKey().length()>1)
        {
          simkey = ba.getMainKey()+" "+ba.getBasicKey()+" "+ba.getInteKey();
        }
        if(ba.getProperty() == 2)
        {
          rfl="(<font color=blue>RM</font>)";
        }else{
          rfl="(<font color=#FE8100>RF</font>)";
        }
        String picture = "/res/"+teasession._strCommunity+"/picture/small/"+node+".jpg";

        //            out.print("<div id=sear1>");
        //            out.print("<span id=sear2><a href=# onclick=window.open('/jsp/bpicture/ImageInfo.jsp?nodes="+node+"','_blank'); ><img src="+picture+" border=0 /></a></span><span id=sear2>"+n.getSubject(1)+"&nbsp;-&nbsp;"+rfl+"</span>");
        //            out.print("<span id=sear2><span id=lit_"+node+"><a href=# onclick=c_seat(lit_"+node+",light,"+node+");><img src=/tea/image/bpicture/add_lightbox.gif alt=添加至图库 width=17 height=17 border=0 name=l1></a></span>");
        //            out.print("&nbsp;<a href=# onclick='add_cart("+node+")'><span id=cart_"+node+"><img width=17 height=17 border=0 src=/tea/image/bpicture/add_cart.gif alt=放入购物车></span></a>");
        //            out.print("&nbsp;<a href=/jsp/bpicture/buyer/CalPrice.jsp?nexturl="+request.getRequestURI()+"&nodes="+node+"><img width=17 height=17 border=0 src=/tea/image/bpicture/cal_price.gif alt=计算价格></a>");
        //            out.print("</span></div>");

        if(a%6==0){
          out.print("<tr valign=bottom>");
        }

        out.print("<td width=200px ><span id=sear2><a href=# onclick=window.open('/jsp/bpicture/ImageInfo.jsp?nodes="+node+"','_blank'); onmouseover=showPic("+node+"); onmousemove=\"canmove();setTimeout('movePic()',10);\" onmouseout=hidPic();><img src="+picture+" border=0 /></a></span><span id=sear2>"+node+"&nbsp;-&nbsp;"+rfl+"&nbsp;-&nbsp;<a href=/servlet/Folder?node=2198224&similar=1&bp_keywords="+java.net.URLEncoder.encode(simkey.replaceAll(","," "),"utf-8")+" target='blank'><font color=red>相似图片</font></a></span>");
        out.print("<span id=sear2><span id=lit_"+node+"><a href=### onclick=c_seat(lit_"+node+",light,"+node+");><img src=/tea/image/bpicture/add_lightbox.gif alt=添加至收藏夹 width=17 height=17 border=0 name=l1></a></span>");
        out.print("&nbsp;<a href=# onclick='add_cart("+node+")'><span id=cart_"+node+"><img width=17 height=17 border=0 src=/tea/image/bpicture/add_cart.gif alt=放入购物车></span></a>");
        out.print("&nbsp;<a href=/jsp/bpicture/buyer/CalPrice.jsp?id="+id+"&nodes="+node+"&back=1><img width=17 height=17 border=0 src=/tea/image/bpicture/cal_price.gif alt=计算价格></a></span></td>");

        a++;
      }
      out.print("</table>");
    }
    if(searcher!=null)
    searcher.close();
  }catch(Exception ex)
  {
    ex.printStackTrace();
  }
  out.print("</table></div><div id = 'ali' align='center'>"+new tea.htmlx.FPNL(teasession._nLanguage,param.toString()+"&pos=",pos,sum,pageSize) );

  out.print("</div>");

  %>
  <div id="cba" style="display:none;position:absolute;z-index:99;padding:5px 5px 2px 5px;background-color:white;border:1px solid #000000;">

  </div>
  <div id="light" style="display:none;border:1px solid #cccccc;width:214px;position:absolute;z-index:88;background-color:#E0EDFE;">
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
        <td></td><td><input type="button" value="收藏" onclick="c_jax()"/></td>
      </tr>
    </table>
    </form>
    <%}%>
  </div>
</DIV>
<script type="">
var x=0;
var y=0;
var can = false;

function canmove()
{
  x=document.body.scrollLeft+event.clientX; //获取当前鼠标位置的X坐标

  y=document.body.scrollTop+event.clientY; //获取当前鼠标位置的Y坐标
  can=true; //设置为可以移动
}

function movePic()
{
  if(navigator.appName.indexOf("Microsoft")!=-1){
    if(can)
    {
      cba.style.left=x+5; //设置图层位置的X坐标
      cba.style.top=y+8;
    }
  }
}

function showPic(nod)
{
  if(navigator.appName.indexOf("Microsoft")!=-1){
    currentPos = 'cba';
    var url = "/jsp/bpicture/PicShow.jsp?pic="+nod;
    url = encodeURI(url);
    send_request(url);

    stid = setTimeout('cba.style.display=\"\";',1000);
  }

}

function hidPic()
{
  if(navigator.appName.indexOf("Microsoft")!=-1){
    clearTimeout(stid);
    cba.style.display='none';
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
      m.style.left = getPos(id,"Left")-80;
      m.style.top = getPos(id,"Top") + id.offsetHeight;
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

