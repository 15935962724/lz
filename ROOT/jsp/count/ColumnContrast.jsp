<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*"%>
<%@page import="tea.entity.node.access.*" %><%@page import="tea.ui.*"%><%@page import="tea.resource.*" %>

<%
r.add("/tea/resource/columnlist");

String community=teasession._strCommunity;

String strPos=request.getParameter("pos");
int pos=0;
if(strPos!=null)
	pos=Integer.parseInt(strPos);

StringBuffer sql = new StringBuffer();
sql.append(" AND community=").append("'"+teasession._strCommunity+"'");
int sum=NodeAccessColumn.count(sql.toString());

int alltotalclick = 0;

Iterator it=null;
if(sum>0){
	alltotalclick = NodeAccessColumn.countByNode(teasession._strCommunity);
}

float total=1F;
float top=1F;
%>

<table border="0" cellspacing="0" cellpadding="0" id="tablecenter">
  <tr>
    <td><h2><%=r.getString(teasession._nLanguage,"ColumnContrast")%></h2></td>
  </tr>
  <%
  if(sum>0&&alltotalclick>0)
  {
  %>
  <tr>
    <td align="center">
      <table border=0 cellpadding=2>
        <%
       
        ArrayList al=new ArrayList();
        	sql.append(" order by nodeclick desc");
        	it=NodeAccessColumn.find(sql.toString(),pos,50).iterator();
        	for(int i=1+pos;it.hasNext();i++)
        	{
        		NodeAccessColumn nac=(NodeAccessColumn)it.next();
        		
        		int nodeclick = nac.nodeclick;
        		total=alltotalclick/100F;
        		float p=nodeclick/total;
        		out.write("<tr valign=bottom >");
	            out.write("<td>"+nac.name);
	            out.write("<td>"+df.format(nodeclick));
	            out.print("<td align='right'>"+df2.format(p)+"%</td>");
	            out.print("<td align=left valign=middle width=200><img src='/tea/image/other/bar2.gif' style='width:"+(p>=0.01?nodeclick/total:0)+"' height=15></td>");
          }
        %>
            </table>
    </td>
        </tr>
  <%
  	if(sum>50)out.print("<tr><td colspan='4' align='center'>"+new tea.htmlx.FPNL(teasession._nLanguage,"/jsp/count/index.jsp?act=ColumnContrast&community=" + community + "&pos=",pos,sum,50)+"</td></tr>");
  }else
  {
    out.print("<tr><td colspan='4' align='center'>暂无栏目节点");
  }
  %>
</table>

<a target="_blank" href="/jsp/count/ipquery.jsp?community=<%=community%>"><%=r.getString(teasession._nLanguage,"1216086965256")%></a>

