<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.lang.*,java.util.*,java.text.SimpleDateFormat,java.text.DateFormat" %>
<%
tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);

String strPos=request.getParameter("pos");
int pos=0;
if(strPos!=null)
pos=Integer.parseInt(strPos);

String community=request.getParameter("community");
String domain=request.getParameter("domain");

	int MaxValue=tea.entity.node.NodeAccessReferer.getCountMax(community,1),sHeight;
        int sumMax=tea.entity.node.NodeAccessReferer.getSumMax(community,1),sumHeight;


	double vPoint,sumPoint;

	if (MaxValue == 0)
			 	MaxValue = 1;
			vPoint = 200.0/MaxValue;
            sumPoint=200.0/sumMax;





%>

<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
</head>
<body>
<table border="0" cellspacing="0" cellpadding="0" id="tablecenter">
  <tr>
    <td> 　
    <h2>访问来源统计图表</h2></td>
  </tr>
  <tr>
    <td align="center"><table width=100% border=0 cellpadding=2>

        <tr>
          <td align=center><table align=center>
                    <tr><td>
          <td align=center>今天统计</td><td>
                    <td align=center>总统计</td>
        </tr>
              <%
java.util.Enumeration enumer=tea.entity.node.NodeAccessReferer.findByCommunity(community,domain,pos,25);
while(enumer.hasMoreElements())
{
String referer=(String)enumer.nextElement();
tea.entity.node.NodeAccessReferer nar=tea.entity.node.NodeAccessReferer.find(community,referer);
				sHeight = (int) (nar.getCount()*vPoint);
                sumHeight = (int) (nar.getSum()*sumPoint);

%>
              <tr valign=bottom >
                <td nowap><A  TARGET="_blank" href="<%=referer%>">
                  <%
                if(referer.length()==0)
                out.print("直接输入网址进入的");
                else
                if(referer.length()>25)
                out.print(referer.substring(0,25)+"...");
                else
                out.print(referer);
                %>
                  </A></td>
                <td align=left  valign=middle width=200><img src="/tea/image/other/bar2.gif" width="<%=sHeight%>" height=15  title="访问量：<%=nar.getCount()%>" ></td>
                <td nowap><%=nar.getCount()%></td>
                  <td align=left  valign=middle width=200><img src="/tea/image/other/bar2.gif" width="<%=sumHeight%>" height=15  title="访问量：<%=nar.getSum()%>" ></td>
                <td nowap><%=nar.getSum()%></td>
              </tr>
              <%
			}
            %>
            </table></td>
        </tr>
		<tr><td align="center">
         <%=new tea.htmlx.FPNL(teasession._nLanguage, "/jsp/count/referer1.jsp?community="+community+"&domain="+domain+"&pos=", pos, tea.entity.node.NodeAccessReferer.countByCommunity(community,domain))%>
      </table></td>
  </tr>
</table>


