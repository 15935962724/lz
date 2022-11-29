<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.util.*" %>
<%@page import="java.math.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.entity.*" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.entity.site.*" %>
<% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?Node="+teasession._nNode);
  return;
}

String _strId=request.getParameter("id");

StringBuffer param=new StringBuffer();
param.append("&community=").append(teasession._strCommunity);
param.append("&id=").append(_strId);

String member=request.getParameter("member");
if(member!=null)
{
  param.append("&member=").append(java.net.URLEncoder.encode(member,"UTF-8"));

  ///String referer=request.getParameter("referer");
  //if(referer==null)
  //{
   // response.sendError(404,request.getRequestURI());
   // return;
  //}
}else
{
  member=teasession._rv._strV;
}

StringBuffer sql=new StringBuffer();


String _strTrade=request.getParameter("trade");
String _strTime_from=request.getParameter("time_from");
String _strTime_to=request.getParameter("time_to");

if(_strTrade!=null&&(_strTrade=_strTrade.trim()).length()>0)
{
  sql.append(" AND trade LIKE ").append(DbAdapter.cite("%"+_strTrade+"%"));
  param.append("&trade=").append(_strTrade);
}

if(_strTime_from!=null&&(_strTime_from=_strTime_from.trim()).length()>0)
{
  sql.append(" AND time>=").append(DbAdapter.cite(_strTime_from));
  param.append("&time_from=").append(_strTime_from);
}
if(_strTime_to!=null&&(_strTime_to=_strTime_to.trim()).length()>0)
{
  sql.append(" AND time < ").append(DbAdapter.cite(_strTime_to));
  param.append("&time_to=").append(_strTime_to);
}


int count=Point.countByMember(member,sql.toString());

String order=request.getParameter("order");
if(order==null)
order="point";
param.append("&order=").append(order);

String desc=request.getParameter("desc");
if(desc==null)
desc="desc";
param.append("&desc=").append(desc);

sql.append(" ORDER BY ").append(order).append(" ").append(desc);

param.append("&pos=");

Resource r=new Resource();

Community community=Community.find(teasession._strCommunity);

int pos=0;
String _strPos=request.getParameter("pos");
if(_strPos!=null&&_strPos.length()>0)
{
  pos=Integer.parseInt(_strPos);
}


%><HTML>
<HEAD>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script type="">
function f_edit(t)
{
  form2.action='/jsp/order/EditSaleConfirmed.jsp';
  form2.method='GET';
  form2.trade.value=t;
  form2.submit();
}
</script>
</HEAD>
<body id="bodynone">

<div id="jspbefore" style="display:none">
<script>if(top.location==self.location)jspbefore.style.display='';</script>
<%=community.getJspBefore(teasession._nLanguage)%>
</div>

<div id="tablebgnone">
<div id="huiyuanjifen">
<div style="display:none"><h1><%=r.getString(teasession._nLanguage, "会员积分")%></h1></div>
<div id="head6"><img height="6" src="about:blank"></div>

<FORM name=form1 METHOD=get action="?">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="id" value="<%=_strId%>"/>
<div id="zh-head"><h2>积分查询</h2></div>
<div style="display:none"><h2>查询</h2></div>
<table cellpadding="0" cellspacing="0" bordercolor="0" class="zh-chaxun" id="tablecenter">
<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor='' valign="middle">
<td>时间：  <input type="text" name="time_from" size="15" value="<%if(_strTime_from!=null)out.print(_strTime_from);%>"></td>
<td><img src="/tea/image/public/Calendar2.gif" onClick="showCalendar('form1.time_from');"></td>
<td><input type="text" name="time_to" size="15" value="<%if(_strTime_to!=null)out.print(_strTime_to);%>"></td>
<td><img src="/tea/image/public/Calendar2.gif" onClick="showCalendar('form1.time_to');"></td>
</tr>
<tr><td align="center" colspan="4"><input name="submit" type="submit" onClick="" value="查询" id="zh-chaxun"/></td></tr>
</table>
</form><br>
您的积分来源记录：<br>
<FORM name=form2 METHOD=POST action="/servlet/EditTrade">
<script>document.write('<input type=hidden name=nexturl value='+location+'>');</script>
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="act" value="salerollback"/>
<input type="hidden" name="trade" value=""/>
<div style="display:none"><h2>列表 <%=count%></h2></div>
<table border="0" cellpadding="0" cellspacing="0" class="zh-liebiao" id="tablecenter">
<div id="zh-lbtou">
<%
  out.print("<tr ID=tableonetr><td width=1 align='center'>序号</td><td align='center'>");
  if("time".equals(order))
  {
    out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+pos+" >"+r.getString(teasession._nLanguage, "Time")+" "+("desc".equals(desc)?"▼":"▲")+"</a>");
  }else
  {
    out.print("<A href=?order=time"+param.toString()+pos+" >"+r.getString(teasession._nLanguage, "Time")+"</a>");
  }
  out.print("</td><td  align='center'>相关订单</td><td align='center'>");
  if("changes".equals(order))
  {
    out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+pos+" >变化 "+("desc".equals(desc)?"▼":"▲")+"</a>");
  }else
  {
    out.print("<A href=?order=changes"+param.toString()+pos+" >变化</a>");
  }
  out.print("</td><Td align='center'>积分来源</td><td align='center'>");
  if("balance".equals(order))
  {
    out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+pos+" >"+r.getString(teasession._nLanguage, "积分")+" "+("desc".equals(desc)?"▼":"▲")+"</a>");
  }else
  {
    out.print("<A href=?order=balance"+param.toString()+pos+" >"+r.getString(teasession._nLanguage, "积分")+"</a>");
  }
  out.print("</td></tr>");


Enumeration e=Point.findByMember(member,sql.toString(),pos,10);
for(int i=1;e.hasMoreElements();i++)
{
  int id=((Integer)e.nextElement()).intValue();
  Point obj=Point.find(id);
  %>
  </div>
  <tr onMouseOver="bgColor='#BCD1E9'" onMouseOut="bgColor=''">
    <td width="1" align='center'><%=i%></td>
    <td nowrap align='center'><%=obj.getTimeToString()%></td>
    <td align="center"><%
    if(obj.getSourceOrder()!="")
    {
    	out.print(obj.getSourceOrder());
    }else{
    	out.print("无");
    }
    %></td>
    <td nowrap align="center"><%=obj.getChanges()%></td>
    <td align="center">
    <% if(obj.getChangeReason()!="")
    {
    	out.print(obj.getChangeReason());
    }else{
    	out.print("无");
    } %></td>
    <td nowrap align="center"><%=obj.getBalance()%></td>
  </tr>
<%
}
%>
<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>
<td colspan="6" ><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+"?"+param.toString(),pos,count)%></td>
</tr><tr><td colspan="6" >您现在拥有: <span class="jusec"><%=Point.getLastPoint(teasession._rv._strV)%></span>点　积分</td>
</tr>
</table>
</FORM>
<div id="head6"><img height="6" src="about:blank"></div>

<div id="jspafter" style="display:none">
<script>if(top.location==self.location)jspafter.style.display='';</script>
<%=community.getJspAfter(teasession._nLanguage)%>
</div></div></div>
</body>
</HTML>
