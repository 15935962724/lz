<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.ui.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.entity.*" %>
<%@page import="tea.entity.admin.cebbank.*" %>
<%@page import="tea.resource.*"%>
<%@page import="java.net.URLEncoder"%><%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

Resource r=new Resource("/tea/resource/Annuity");

Community community=Community.find(teasession._strCommunity);

String code=(String)session.getAttribute("code");
if(code==null)
{
  response.sendRedirect("/jsp/info/Alert.jsp?community="+teasession._strCommunity+"&info="+URLEncoder.encode(r.getString(teasession._nLanguage,"1186555649328"),"UTF-8")+"&nexturl=/servlet/Node%3FNode%3D"+teasession._nNode);
  return;
}

String user=(String)session.getAttribute("user");

RV rv;
if(user!=null)
{
  rv=new RV(Annuity.R,code+"."+user);
}else
{
  rv=new RV(Annuity.R,code);
}


%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
</head>
<body id="right_con">

<div id="topmnue">
  <div id="topmnueleft"></div>
  <div id="topmnueright">
<%

Boolean if_tip=(Boolean)session.getAttribute("if_tip");
if(if_tip!=null&&if_tip.booleanValue())
{
  out.print(Annuity.Annuity_0008(session,code,user,teasession._strCommunity,teasession._nLanguage));
  //out.print("<span id=go_ann><input type=submit value=GO onclick=\"return f_0008_submit();\"></span>");
  out.print("<span id=xiug_mm><a href=/jsp/admin/cebbank/Annuity.jsp?community="+teasession._strCommunity+"&tn="+Annuity.des("8003")+" target=_blank>修改密码</a></span>");
}
if(user==null)
{
  out.print(Annuity.Annuity_1013(session,teasession._strCommunity,teasession._nLanguage));//参加的企业
  out.print("<span id=t_p></span>");//个人登陆才有这个span//
}
%>
<!--
<span><a href="###"><%=r.getString(teasession._nLanguage,"1186540383046")%></a></span>
<span><a href="###"><%=r.getString(teasession._nLanguage,"1186540432515")%></a></span>
<span><a href="###"><%=r.getString(teasession._nLanguage,"1186540473750")%></a></span>
-->
<span id="tuic_dl"><a href="/servlet/EditAnnuity?community=<%=teasession._strCommunity%>&tn={0}" target="_top"><%=r.getString(teasession._nLanguage,"1186540514468")%></a></span></div>
</div>

<div id="Path">
  <div id="path_zong"><Span ID=PathID1><A HREF="/servlet/Folder?node=<%=community.getNode()%>" target="_top"><%=r.getString(teasession._nLanguage,"1186540578484")%></A></Span>
  <Span ID=PathID2>&nbsp;/&nbsp;<%=r.getString(teasession._nLanguage,"1186540625500")%></Span></div>
  <div id="shangc_dl"><%=r.getString(teasession._nLanguage,"1186541289046")%>：<%=Annuity.sdf2.format(Log.getLastTime(rv))%></div></div>


      <div style="width:100%; overflow: auto;" >
      <!--/res/eacebbank/u/0704/070415249.jpg-->
        <div id="bgwai">
        <!-- /res/eacebbank/u/0704/070415247.jpg -->
          <div id="bgnei">

<%
if(user!=null)
{

%>
            <div id="dengl_top">
              <div id="dengl_top_01"><b><span id=corp_name ></span></b>　<b><%=user%></b>　<%=r.getString(teasession._nLanguage,"1186540709296")%></div>
              <div id="dengl_top_02"><%=r.getString(teasession._nLanguage,"1186540787921")%> <%=Log.countByRV(rv)%> <%=r.getString(teasession._nLanguage,"1186540831218")%></div>
            </div>
            <div id="dengl_bottom">
              <div id="dengl_bottom_01"><%=r.getString(teasession._nLanguage,"1186540882718")%><b><%=r.getString(teasession._nLanguage,"1186540942500")%></b><%=r.getString(teasession._nLanguage,"1186541006859")%></div>
              <div  id="dengl_bottom_01">
                <p><%=r.getString(teasession._nLanguage,"1186541095125")%><b><%=r.getString(teasession._nLanguage,"1186541163500")%></b><%=r.getString(teasession._nLanguage,"1186541231437")%></p>
                <p align="left"><%=Annuity.Annuity_0010(session,teasession._nLanguage)%></p>
                <p>&nbsp;</p>
              </div>
            </div>
<%}else
{
	String name=(String)session.getAttribute("name");
%>
            <div id="dengl_top">
              <div id="dengl_top_01"><b><%if(name!=null)out.print(name);%></b>　<%=r.getString(teasession._nLanguage,"1186540709296")%></div>
              <div id="dengl_top_02"><%=r.getString(teasession._nLanguage,"1186540787921")%> <%=Log.countByRV(rv)%> <%=r.getString(teasession._nLanguage,"1186540831218")%></div>
            </div>
            <div id="dengl_bottom">
              <div id="dengl_bottom_01"><%=r.getString(teasession._nLanguage,"1186540882718")%><b><%=r.getString(teasession._nLanguage,"1186541474812")%></b><%=r.getString(teasession._nLanguage,"1186541006859")%></div>
              <div id="dengl_bottom_02">
                <p><%=r.getString(teasession._nLanguage,"1186541095125")%><b><%=r.getString(teasession._nLanguage,"1186541572437")%></b><%=r.getString(teasession._nLanguage,"1186541231437")%></p>
                <p><%=Annuity.Annuity_1008(session,teasession._nLanguage)%></p>
              </div>
            </div>
<%}%>
          </div>
        </div>
      </div>

</body>
</html>



