<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.entity.admin.orthonline.*"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.*"%>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
TeaSession teasession = new TeaSession(request);

String nexturl = request.getRequestURI()+"?"+request.getQueryString();
StringBuffer sql = new StringBuffer(" and type=1 ");
StringBuffer param = new StringBuffer();
param.append("?id=").append(request.getParameter("id"));
param.append("&community=").append(teasession._strCommunity);

int shenheids=0;
if(teasession.getParameter("shenheids")!=null && teasession.getParameter("shenheids").length()>0)
{
  shenheids = Integer.parseInt(teasession.getParameter("shenheids"));
  CaseCollection.setType(shenheids,1);

}

int type = 0;
if(teasession.getParameter("type")!=null && teasession.getParameter("type").length()>0)
{
  type = Integer.parseInt(teasession.getParameter("type"));
  if(type==0)
  {
    sql.append(" and type=0");
  }
  else if(type==1)
  {
    sql.append(" and type=1");
  }
  param.append("&type=").append(type);
}

String casename = "",time_k="",time_j="",tel="";
if(teasession.getParameter("time_k")!=null && teasession.getParameter("time_k").length()>0)
{
  time_k= teasession.getParameter("time_k");
  sql.append("  and  regtime>").append(DbAdapter.cite(time_k));
  param.append("&time_k=").append(time_k);

}
if(teasession.getParameter("time_j")!=null && teasession.getParameter("time_j").length()>0)
{
  time_j= teasession.getParameter("time_j");
  sql.append("  and  regtime<").append(DbAdapter.cite(time_j));
  param.append("&time_j=").append(time_j);

}
Date datetime =new Date();
int pos = 0, pageSize = 30, count = 0;

count = CaseCollection.count(teasession._strCommunity,sql.toString());

if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}
String o=request.getParameter("o");
if(o==null)
{
  o="regtime";
}
boolean aq=Boolean.parseBoolean(request.getParameter("aq"));
sql.append(" ORDER BY ").append(o).append(" ").append(aq?"ASC":"DESC");
param.append("&o=").append(o).append("&aq=").append(aq);


//全部
%>
<script type="">
function f_order(v)
{
  var aq=form1.aq.value=="true";
  if(form1.o.value==v)
  {
    form1.aq.value=!aq;
  }else
  {
    form1.o.value=v;
  }
  form1.action="?";
  form1.submit();
}
</script>

<form action="" name="form1">
<input type="hidden" name="o" VALUE="<%=o%>">
<input type="hidden" name="aq" VALUE="<%=aq%>">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="id" value="<%=request.getParameter("id")%>" >
<div id="zhe000"><span id="zhe001">病例总数（<%=count%>）</span><span id="zhe002"><a href="javascript:f_order('diannum');">点击次数（<%=CaseCollection.sun(" and type=1")%>）</a><%
  if(o.equals("diannum"))
  {
    if(aq)
    out.print("↓");
    else
    out.print("↑");
  }
  %></span><span id="zhe003"><a href="javascript:f_order('regtime');">提交时间</a>
  <%
  if(o.equals("regtime"))
  {
    if(aq)
    out.print("↓");
    else
    out.print("↑");
  }
  %></span>
  </Div>
<%


Enumeration eu = CaseCollection.findByCommunity(teasession._strCommunity,sql.toString(),pos,40);
if(!eu.hasMoreElements())
{
  %>
<li>暂无消息</li><%
}
for(int i=0;eu.hasMoreElements();i++)
{
  int ccid = ((Integer)eu.nextElement()).intValue();//Integer.parseInt(String.valueOf(eu.nextElement()));

  CaseCollection ccobj = CaseCollection.find(ccid);
  %>
  <li> <span id="id1"><a href="/servlet/Node?node=2198563&language=1&ids=<%=ccid%>" target="_blank"><%if(ccobj.getCasename()!=null)out.print(ccobj.getCasename());%></a></span>
    <span id="id2"><%=ccobj.getRegtimetoString()%>
     <%
    CaseCollection.sdf.format(datetime);
    if(CaseCollection.sdf.format(datetime).equals(ccobj.getRegtimetoString()))
    {
      %>
      <img alt="" src="/tea/image/public/new.gif" />
      <%
    }

    %>
    </span>
    <span id="id3">点击次数：<%=ccobj.getDiannum()%></span>

    <%
    if(ccobj.getZhuanjiadp()!=null && ccobj.getZhuanjiadp().length()>0)
    {
      %>
       <span id="id3"> <a href="/jsp/admin/orthonline/CaseCollectionInfo.jsp?zj=zj&&ids=<%=ccid%>"><font color="red"><b>专家评论</b></font></a>　</span>
      <%
    }
    %>
  </li>
  <%
}
if(count>5)
{
  %>
  <tr><td colspan="13"  align="center" style="padding-right:5px;"> <%=new tea.htmlx.FPNL(teasession._nLanguage,param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,40)%></td></tr>
  <%
}
%>
</form>
