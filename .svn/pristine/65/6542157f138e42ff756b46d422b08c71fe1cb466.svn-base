<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.db.*" %>
<%@page import="tea.resource.*" %>
<%@page import="java.util.*" %>
<%@page import="java.io.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.util.*" %>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

teasession._strCommunity=teasession._rv._strR;

Community community=Community.find(teasession._strCommunity);
int root=community.getNode();
if(root==0)
{
  response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("还没有开通第一站.","UTF-8"));
  return;
}

String pause=community.getPause(teasession._nLanguage);
if(pause!=null&&pause.length()>0)
{
  out.print(pause);
  return;
}

Node h=Node.find(root);
Company c = Company.find(root);

int node=teasession._nNode;
int lang=teasession._nLanguage;
String como=java.net.URLEncoder.encode(teasession._strCommunity,"UTF-8");
Node n = Node.find(node);

String adlink[]=c.getAdLink(lang);
String adpic[]=c.getAdPic(lang);

int father34=Category.find(teasession._strCommunity,34);//产品
int folder34=Node.find(father34).getFather();

Node n34=Node.find(folder34);
int father39=Category.find(teasession._strCommunity,39);
int father50=Category.find(teasession._strCommunity,50);//职位
int father73=Category.find(teasession._strCommunity,73);//售后服务
int father78=Category.find(teasession._strCommunity,78);//链接
int father87=Category.find(teasession._strCommunity,87);//公告
String url=teasession.getParameter("url");
if(url==null)
{
  url="";
}
WindowsBox wbs[]=new WindowsBox[30];
for(int i=0;i<wbs.length;i++)
{
  wbs[i]=WindowsBox.find(root,i);
}

int pos=0;
String tmp=request.getParameter("pos");
if(tmp!=null)
{
  pos=Integer.parseInt(tmp);
}

String nu=request.getParameter("nexturl");

Resource r = new Resource("/tea/resource/Windows");

CommunityOption co = CommunityOption.find(teasession._strCommunity);
String et=co.get("eyptemplate");
String es=co.get("eypstyle");
String ehm=co.get("eyphitsmember");
String eht=co.get("eyphitstime");

String q=request.getParameter("q");

///
int home21;
DbAdapter db=new DbAdapter();
try
{
  home21=db.getInt("SELECT node FROM Node WHERE vcreator="+DbAdapter.cite(teasession._strCommunity)+" AND type=21");
}finally
{
  db.close();
}
Node hn21=Node.find(home21);
Company hc21=Company.find(home21);

/////edit
String strid=request.getParameter("id");

String domain=request.getServerName();
Enumeration edns=DNS.findByCommunity(teasession._strCommunity,teasession._nStatus);
if(edns.hasMoreElements())
{
  domain=(String)edns.nextElement();
}

%>
<!--<%=root%>-->
<html>
<head>
<script type="text/javascript" src="/tea/tea.js"></script>
<link type="text/css" rel="stylesheet" href="/tea/image/eyp/style/<%=es%>.css">
<link type="text/css" rel="stylesheet" href="/tea/image/eyp/Style01_Edit.css">
<link type="text/css" rel="stylesheet" href="/tea/image/eyp/template/<%=et%>.css">
<link type="text/css" rel="stylesheet" href="/tea/image/eyp/<%=et%>_Edit.css">
<link type="text/css" rel="stylesheet" href="/tea/image/eyp/union/<%=es+et%>.css">
<script>
function f_upload(act)
{
  window.open("/jsp/type/company/windows/SetCompanyUpload.jsp?community=<%=teasession._strCommunity%>&act="+act,"_blank","width=400px,height=120px");
}
function f_open(url,txt)
{
  if(txt&&!confirm(txt))
  {
    return;
  }
  var nu=location.href;
  var j=nu.indexOf("&nexturl=");
  if(j!=-1)
  {
    nu=nu.substring(0,j);
  }
  var target="_self";
  if(url.indexOf(".?")==0)//浏览
  {
    url="/jsp/type/company/windows/"+url;
    target="_blank";
  }else
  if(url.indexOf("?url=")==0)
  {
    url="/jsp/type/company/windows/Edit.jsp"+url;
  }else
  if(url.indexOf("?act=")==0)
  {
    url="/servlet/EditCompanyWindows"+url;
  }
  window.open(url+"&community=<%=como%>&id=<%=strid%>&nexturl="+encodeURIComponent(nu),target);
}
</script>
</head>
<body>




<DIV id="body">

<DIV ID=header>
  <div id="header_top">
    <div>
      <input type="button" value="<%=r.getString(lang,"fj12hq3u")%>" onClick="f_open('?url=Templates');" />
      <input type="button" value="<%=r.getString(lang,"fj12hq3v")%>" onClick="f_open('?url=Styles');"/>
      <input type="button" value="<%=r.getString(lang,"fj12hq3w")%>" onClick="f_open('?url=EditDNS');"/>
      <a href="http://<%=domain%>" target="_blank">预览我的第一站（http://<%=domain%>）</a>  <a href="http://www.qiqiwang.com/servlet/Folder?node=2197067&language=1">第一站</a> | <a href="http://www.qiqiwang.com/servlet/Folder?node=2197244&language=1" target="_blank">帮助</a> | <a href="/jsp/user/StartLogin.jsp?node=<%=root%>&nexturl=/">登陆</a>
      <script type="" src="/jsp/im/Msns.jsp?style=0&member=<%=como%>"></script>
    </div>
  </div>

  <table id="header_logo">
    <tr>
      <td id="header_logo_td01"><img src="<%String clogo=c.getLogo(lang); out.print(clogo!=null?clogo:"/tea/image/eyp/images/logo.jpg");%>" width="80"/></td>
      <td id="header_logo_td02"><%=h.getSubject(teasession._nLanguage)%><input type="button" value="<%=r.getString(lang,"fj12hq3x")%>" onClick="f_upload('logo');" /></td>
      <td id="header_logo_td03"></td>
      <td id="header_logo_td04"><a href="###" onClick="location=location.search.replace('&language=','&')+'&language=1';">中文</a>　<a href="###"  onclick="location=location.search.replace('&language=','&')+'&language=0';">English</a></td>
    </tr>
  </table>

  <div id="banner_top"><img src="<%=c.getBanner(lang)%>" width="800" height="120"/>
    <input type="button" id="input04" value="<%=r.getString(lang,"fj12hq3x")%>" onClick="f_upload('banner');" />
  </div>
  <div id="nav_edit">
    <input type="button" id="input05" value="<%=r.getString(lang,"fj12hq41")%>" onClick="f_open('?url=WindowsBoxs')" />
  </div>
  <table id="nav">
    <tr>
      <td>
      <%
      out.print("<a href=\"javascript:f_open('?url=');\">"+r.getString(lang,"fj0vgqw1")+"</a>");
      if(!wbs[18].isHidden())
      {
        out.print("　|　<a href=javascript:f_open('?url=Reports');>"+wbs[18].getName(lang)+"</a>");
      }
      if(!wbs[14].isHidden())
      {
        out.print("　|　<a href=javascript:f_open('?url=Goodss');>"+wbs[14].getName(lang)+"</a>");
      }
      if(!wbs[19].isHidden())
      {
        out.print("　|　<a href=javascript:f_open('?url=EditCompany0');>"+wbs[19].getName(lang)+"</a>");
      }
      if(!wbs[9].isHidden())
      {
        out.print("　|　<a href=javascript:f_open('?url=Jobs');>"+wbs[9].getName(lang)+"</a>");
      }
      if(!wbs[20].isHidden())
      {
        out.print("　|　<a href=javascript:f_open('?url=MessageBoards');>"+wbs[20].getName(lang)+"</a>");
      }
      if(!wbs[4].isHidden())
      {
        out.print("　|　<a href=javascript:f_open('?url=EditCompany4');>"+wbs[4].getName(lang)+"</a>");
      }
      %>
      </td>
    </tr>
  </table>

</div>




<DIV ID="content">
<%
//公告板
if("BulletinBoards".equals(url))
{
%>
<%@include file="/jsp/type/company/windows/edit/BulletinBoards.jsp" %>
<%
}else
if("EditBulletinBoard".equals(url))
{
%>
<%@include file="/jsp/type/company/windows/edit/EditBulletinBoard.jsp" %><%
}else
//公司
if("EditCompany0".equals(url))
{
%><%@include file="/jsp/type/company/windows/edit/EditCompany0.jsp" %><%
}else if("EditCompany1".equals(url))
{
%><%@include file="/jsp/type/company/windows/edit/EditCompany1.jsp" %><%
}else if("EditCompany2".equals(url))
{
%><%@include file="/jsp/type/company/windows/edit/EditCompany2.jsp" %><%
}else if("EditCompany3".equals(url))
{
%><%@include file="/jsp/type/company/windows/edit/EditCompany3.jsp" %><%
}else if("EditCompany4".equals(url))
{
%><%@include file="/jsp/type/company/windows/edit/EditCompany4.jsp" %><%
}else
//新闻
if("Reports".equals(url))
{
%><%@include file="/jsp/type/company/windows/edit/Reports.jsp" %><%
}else if("EditReport".equals(url))
{

%><%@include file="/jsp/type/company/windows/edit/EditReport.jsp" %><%
}else
//职位
if("Jobs".equals(url))
{
%><%@include file="/jsp/type/company/windows/edit/Jobs.jsp" %><%
}else if("EditJob".equals(url))
{
%><%@include file="/jsp/type/company/windows/edit/EditJob.jsp" %><%
}else
//产品
if("Goodss".equals(url))
{
%><%@include file="/jsp/type/company/windows/edit/Goodss.jsp" %><%
}else if("GoodsCategory".equals(url))
{
%><%@include file="/jsp/type/company/windows/edit/GoodsCategory.jsp" %><%
}else if("EditGoods".equals(url))
{
%><%@include file="/jsp/type/company/windows/edit/EditGoods.jsp" %><%
}else if("Talkbacks".equals(url))
{
%><%@include file="/jsp/type/company/windows/edit/Talkbacks.jsp" %><%
}else
//链接
if("AmityLinks".equals(url))
{
%><%@include file="/jsp/type/company/windows/edit/AmityLinks.jsp" %><%
}else if("EditAmityLink".equals(url))
{
%><%@include file="/jsp/type/company/windows/edit/EditAmityLink.jsp" %><%
}else
//服务
if("MessageBoards".equals(url))
{
%><%@include file="/jsp/type/company/windows/edit/MessageBoards.jsp" %><%
}else if("EditMessageBoard".equals(url))
{
%><%@include file="/jsp/type/company/windows/edit/EditMessageBoard.jsp" %><%
}else
//
if("WindowsBoxs".equals(url))
{
%><%@include file="/jsp/type/company/windows/edit/WindowsBoxs.jsp" %><%
}else
//
if("Templates".equals(url))
{
%><%@include file="/jsp/type/company/windows/edit/Templates.jsp" %><%
}else if("Styles".equals(url))
{
%><%@include file="/jsp/type/company/windows/edit/Styles.jsp" %><%
}else if("EditDNS".equals(url))
{
%><%@include file="/jsp/type/company/windows/edit/EditDNS.jsp" %><%
}else
{
%><%@include file="/jsp/type/company/windows/edit/index.jsp" %><%
}
%>
</div>

<DIV ID=Footer>

<%
if(url==null||url.length()<1)
{
%>
<!--合作伙伴/客户-->
  <div id="Links_edit"><input type="button" value="<%=r.getString(lang,"fj12hq3y")%>" onClick="f_open('?url=EditAmityLink')"><input type="button" value="<%=r.getString(lang,"fj12hq3z")%>" onClick="f_open('?url=AmityLinks')"><input type="button" value="<%=wbs[17].isHidden()?r.getString(lang,"fj12hq42"):r.getString(lang,"fj12hq40")%>" onClick="f_open('?act=hidden17')" /></div>
    <div id="Links">
      <div id="Links_top"><%=wbs[17].getName(lang)%></div>
      <ul id="links_ul" info="<%=r.getString(lang,"fj0vgqx5")%>">
      <%
      Enumeration e78=Node.find(" AND father="+father78+" AND type=78",pos,6);
      while(e78.hasMoreElements())
      {
        int n78=((Integer)e78.nextElement()).intValue();
        Node o78=Node.find(n78);
        AmityLink al78=AmityLink.find(n78,lang);
        out.print("<li><img src="+al78.getLogo()+"><br><a href="+al78.getUrl()+" target=_blank>"+o78.getSubject(lang)+"</a></li>");
      }
      %>
      </ul>
  </div>
<%}%>

<script src="/jsp/type/company/windows/script.js"></script>

  <div id="footer_nav">
    <div id="footer_nav_nei">
      <table cellspacing="0" cellpadding="0" id="footer_nav_table">
        <tr>
          <td id="footer_nav_td_left" rowspan="3"><img src="/tea/image/eyp/images/no1.gif"></td>
            <td id="footer_nav_td_right_01">
            <%
            out.print("<a href=\"javascript:f_open('?url=');\">"+r.getString(lang,"fj0vgqw1")+"</a>");
            if(!wbs[18].isHidden())
            {
              out.print("　|　<a href=javascript:f_open('?url=Reports');>"+wbs[18].getName(lang)+"</a>");
            }
            if(!wbs[14].isHidden())
            {
              out.print("　|　<a href=javascript:f_open('?url=Goodss');>"+wbs[14].getName(lang)+"</a>");
            }
            if(!wbs[19].isHidden())
            {
              out.print("　|　<a href=javascript:f_open('?url=EditCompany0');>"+wbs[19].getName(lang)+"</a>");
            }
            if(!wbs[9].isHidden())
            {
              out.print("　|　<a href=javascript:f_open('?url=Jobs');>"+wbs[9].getName(lang)+"</a>");
            }
            if(!wbs[20].isHidden())
            {
              out.print("　|　<a href=javascript:f_open('?url=MessageBoards');>"+wbs[20].getName(lang)+"</a>");
            }
            if(!wbs[4].isHidden())
            {
              out.print("　|　<a href=javascript:f_open('?url=EditCompany4');>"+wbs[4].getName(lang)+"</a>");
            }
            %>
            </td>
        </tr>
        <tr>
          <td id="footer_nav_td_right"><%=hn21.getSubject(lang)%>  版权所有 1997-2008  联系电话:<%=hc21.getTelephone(lang)%></td>
        </tr>
        <tr>
          <td id="footer_nav_td_right">技术支持：中龙网库科技有限公司</td>
        </tr>
      </table>
    </div>
  </div>
</DIV>

<div id="ad0" style=Z-INDEX:10;LEFT:1px;POSITION:absolute;TOP:80px;><a href="<%=adlink[0]!=null?adlink[0]:"/"%>" target=blank><img src="<%=adpic[0]%>" width="80" height="200"></a><br><input type="button" value="<%=r.getString(lang,"fj12hq3z")%>" onclick=f_upload('ad0');><input type='button' value='<%=wbs[10].isHidden()?r.getString(lang,"fj12hq42"):r.getString(lang,"fj12hq40")%>' onclick=f_open('?act=hidden10')></div>
<script>var ad0=document.getElementById("ad0");setInterval('ad0.style.top=document.body.scrollTop+80;',100);</script>
<div id="ad1" style=Z-INDEX:10;RIGHT:1px;POSITION:absolute;TOP:80px;><a href="<%=adlink[1]!=null?adlink[1]:"/"%>" target=blank><img src="<%=adpic[1]%>" width="80" height="200"></a><br><input type="button" value="<%=r.getString(lang,"fj12hq3z")%>" onclick=f_upload('ad1');><input type='button' value='<%=wbs[11].isHidden()?r.getString(lang,"fj12hq42"):r.getString(lang,"fj12hq40")%>' onclick=f_open('?act=hidden11')></div>
<script>var ad1=document.getElementById("ad1");setInterval('ad1.style.top=document.body.scrollTop+80;',100);</script>

</body>
</html>
