<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.ui.*" %><%@page import="java.util.*" %><%@page import="tea.entity.admin.cebbank.*" %><%@page import="tea.resource.*"%><%@page import="java.net.URLEncoder"%><%
//response.setHeader("Expires", "0");
//response.setHeader("Cache-Control", "no-cache");
//response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

/////Annuity_1011.jsp/////////////////////////////////

TeaSession teasession=new TeaSession(request);

Resource r=new Resource("/tea/resource/Annuity");

String code=(String)session.getAttribute("code");
String user=(String)session.getAttribute("user");

if(code==null||user==null)
{
	response.sendRedirect("/jsp/info/Alert.jsp?community="+teasession._strCommunity+"&info="+URLEncoder.encode(r.getString(teasession._nLanguage,"1186555649328"),"UTF-8")+"&nexturl=/servlet/Node%3FNode%3D"+teasession._nNode);
	return;
}
ArrayList atn=(ArrayList)session.getAttribute("annuity.trade_no");
if(atn==null||atn.indexOf("1011")==-1)
{
  response.sendError(403);
  return;
}

//文件下载/////////
String pk_corpaccountreport=request.getParameter("pk_corpaccountreport");
String filename=request.getParameter("filename");
if(pk_corpaccountreport!=null)
{
  Map m=new HashMap();
  m.put("trade_no","1012");
  m.put("pk_corpaccountreport",pk_corpaccountreport);

  m=(Map)Annuity.conn(m);

  String ec = (String) m.get("error_code");
  if (!Annuity.EC_0000.equals(ec))
  {
    out.print("<script>alert('" +r.getString(teasession._nLanguage,"Annuity.error_code."+ec)+"');</script>");
  }else
  {
    byte al[]=(byte[])m.get("result");
    response.setContentType("application/x-msdownload");
    response.setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode(filename, "UTF-8"));
    try
    {
      java.io.OutputStream os=response.getOutputStream();
      os.write(al);
      os.close();
    }catch(Exception ex)
    {
    }
    return;
  }
}
//

short period=-1;
String tmp=request.getParameter("period");
if(tmp!=null)
{
  period=Short.parseShort(tmp);
}

Map m=new HashMap();
m.put("trade_no","1011");
m.put("code",code);
if(period!=-1)
{
  m.put("period",new Short(period));
}

int pos=0,size=10;
tmp=request.getParameter("pos");
if(tmp!=null)
{
  pos=Integer.parseInt(tmp);
}

StringBuffer param=new StringBuffer();
param.append("?community=").append(teasession._strCommunity);
param.append("&period=").append(period);

String info=request.getParameter("info");
param.append("&info=").append(URLEncoder.encode(info,"UTF-8"));

param.append("&pos=");
%>
<jsp:include page="/jsp/admin/cebbank/AnnuityFrame.jsp" >
<jsp:param name="frame" value="mainheader"/>
</jsp:include>

<div id="new"></div>

<div style="width:100%;overflow: auto;">
  <div id="neirong">






<form name="form1" action="?" onsubmit="return submitText(this.period,'<%=r.getString(teasession._nLanguage,"1186568245875")%>');">
<input type=hidden name=community value="<%=teasession._strCommunity%>">
<input type=hidden name=info value="<%=info%>">

<div id="neibiao">
  <span id="biaol"></span>
  <span id="neibiaozi"><%=r.getString(teasession._nLanguage,"Annuity.1011")%></span>
  <span id="biaor"></span>
</div>
<table border="0" cellspacing="0" cellpadding="0" style="border-collapse:collapse">
  <tr>
    <td class="zuoge"><%=r.getString(teasession._nLanguage,"报告周期")%>：</td>
    <td align="left">
      <select name="period" style="width:100px">
        <option value="0">月</option>
        <option value="1" <%if(1==period)out.print(" SELECTED ");%>>季</option>
        <option value="2" <%if(2==period)out.print(" SELECTED ");%>>年</option>
      </select>
    </td>
  </tr>
</table>
<input class="bdanniu" type="submit" value="<%=r.getString(teasession._nLanguage,"1186542726218")%>" onclick="form1.action='?'" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input class="bdanniu" type="button" value="<%=r.getString(teasession._nLanguage,"1186542790281")%>" onclick="clearFrom(form1);"/>

</form>

<%
if(period!=-1)
{
  ArrayList al=null;
  if(pos==0)
  {
    m=(Map)Annuity.conn(m);

    String ec = (String) m.get("error_code");
    if (!Annuity.EC_0000.equals(ec))
    {
      out.print("<script>alert('" +r.getString(teasession._nLanguage,"Annuity.error_code."+ec)+"');</script>");
      return;
    }
     al=(ArrayList)m.get("result");
     session.setAttribute("annuity.result1011",al);
  }else
  {
    al=(ArrayList)session.getAttribute("annuity.result1011");
  }

%>

<div id="neibiao"><span id="biaol"></span><span id="neibiaozi"><%=r.getString(teasession._nLanguage,"Annuity.1011")%> ( <%=al.size()%> )</span><span id="biaor"></span></div>
  <table style="border-collapse:collapse" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td><%=r.getString(teasession._nLanguage,"文件名")%></td>
      <td><%=r.getString(teasession._nLanguage,"报告周期")%></td>
      <td><%=r.getString(teasession._nLanguage,"报告年度")%></td>
      <td><%=r.getString(teasession._nLanguage,"报告期起始时间")%></td>
      <td><%=r.getString(teasession._nLanguage,"报告期终止时间")%></td>
      <td><%=r.getString(teasession._nLanguage,"账期")%></td>
      <td><%=r.getString(teasession._nLanguage,"下载")%></td>
    </tr>
<%
if(al.size()==0)
{
  out.println("<tr><td colspan=7>没有查到任何记录</td></tr>");
}else
for(int i=pos;i<(pos+size)&&i<al.size();i++)
{
  Map v=(Map)al.get(i);
  filename=(String)v.get("filename");
  pk_corpaccountreport=(String)v.get("pk_corpaccountreport");
  filename=filename.trim();
%>
    <tr>
      <td><%=filename%></td>
      <td><%=Annuity.d(v.get("preiod"))%></td>
      <td><%=Annuity.d(v.get("report_year"))%></td>
      <td><%=Annuity.d(v.get("report_start_date"))%></td>
      <td><%=Annuity.d(v.get("report_end_date"))%></td>
      <td><%=Annuity.d(v.get("reoprt"))%></td>
      <td><a href="?community=<%=teasession._strCommunity%>&pk_corpaccountreport=<%=pk_corpaccountreport%>&filename=<%=java.net.URLEncoder.encode(filename, "UTF-8")%>"><%=r.getString(teasession._nLanguage,"下载")%></a></td>
    </tr>
<%
}%>
</table>
<div style="text-align:right;">[<%=r.getString(teasession._nLanguage,"1186536885171")%><%=al.size()%><%=r.getString(teasession._nLanguage,"1186536939078")%>] <%= new tea.htmlx.FPNL(teasession._nLanguage,param.toString(),pos,al.size(),size)%></div>
<%
}%>




</div>

<jsp:include page="/jsp/admin/cebbank/AnnuityFrame.jsp" >
<jsp:param name="frame" value="mainfooter"/>
</jsp:include>

</div>






