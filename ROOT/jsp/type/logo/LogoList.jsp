<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="tea.html.*"%>
<%@ page import="tea.htmlx.*"%>
<%@page import="java.util.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.db.*" %>
<%@page import="tea.entity.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="java.text.*" %>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");
Node node;
TeaSession teasession;
teasession = new TeaSession(request);
String community = teasession._strCommunity;
//if(teasession._rv == null)
//{
//response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
//return;
//}
StringBuffer param=new StringBuffer("?community="+teasession._strCommunity);

param.append("&node=").append(teasession._nNode);

StringBuffer sql=new StringBuffer();


if(teasession._nNode>0)
{
	sql.append(" and  Logo.node in (select node from Node where father = "+teasession._nNode+"  ) ");

}

  String logotype = request.getParameter("logotype");
  String subject = request.getParameter("subject");
  String regnum = request.getParameter("regnum");
  String from = request.getParameter("from");
  String to = request.getParameter("to");

  if(logotype!=null && !logotype.equals("")){
    if(logotype.equals("-1")){}
    else{
      sql.append( " AND logotype = ").append(logotype);
      param.append("&logotype=").append(logotype);
    }
  }
  if(subject!=null && !subject.equals(""))
  {
    subject = subject.trim();
    sql.append( " AND subject LIKE ").append(DbAdapter.cite("%"+subject+"%"));
    param.append("&subject=").append(java.net.URLEncoder.encode(subject,"UTF-8"));
  }
  if(regnum!=null && !regnum.equals(""))
  {
    sql.append( " AND regnum = ").append(DbAdapter.cite(regnum));
    param.append("&regnum=").append(regnum);
  }
  if(from!=null && !from.equals(""))
  {
    sql.append( " AND regdate > ").append(DbAdapter.cite(from));
    param.append("&from=").append(from);
  }
  if(to!=null && !to.equals(""))
  {
    sql.append( " AND regdate < ").append(DbAdapter.cite(to));
     param.append("&to=").append(to);
  }

int pos=0;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}

int count=Logo.count(community,sql.toString());
%>


<script src="/tea/tea.js" type="text/javascript"></script>
<script language="javascript" src="/tea/inc/media_<%=teasession._nLanguage%>_39.js?<%=System.currentTimeMillis()%>" type="text/javascript"></script>
<script src="/res/<%=community%>/cssjs/community.js" type="text/javascript" defer="defer"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<script type="text/javascript">

</script>
<form name="form1" method="GET" action="?">
<input type=hidden name="node" value="<%=teasession._nNode %>"/>
<input type="hidden" name="community" value="<%=community%>"/>
<table id="tablecenter">
  <tr>
    <td align="right"> 商标类别：</td>
    <td  colspan="3">
    <select name="logotype">
        <option value="-1">--请选择商标类别--</option>
        <%

        for(int i =1;i<Logo.LOGO_TYPE.length;i++)
        {

          out.print("<option value = "+i);
          if(logotype!=null && logotype.length()>0 && Integer.parseInt(logotype)==i)
          {
            out.print(" selected ");
          }
          out.print(">"+Logo.LOGO_TYPE[i]);
          out.print("</option>");
        }
      %>
      </select>
      </td>
</tr>
<tr>
         <td align="right"> 商标名称：</td> <td><input type="text" name="subject" value="<%=Logo.getNULL(subject)%>"></td>


      <td align="right">注册号：</td>
      <td><input type="text" name="regnum" value=<%=Logo.getNULL(regnum)%>></td>
      </tr>
      <tr>
      <td align="right">注册时间：</td>
      <td>
	      <input id="from" name="from" size="7"  value="<%if(from!=null)out.print(from); %>" readonly="readonly">
		  <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.from');" />
	      &nbsp;&nbsp;至
	      &nbsp;&nbsp;
	      <input id="to" name="to" size="7"  value="<%if(to!=null)out.print(to); %>" readonly="readonly">
	      <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.to');" />

    </td>
    <td colspan="2">  <input type="submit" value="查  询"></td>
  </tr>
</table>



</form>
<div style="margin:5px 0px 5px 0px;display: block;padding-left:10px;vertical-align:middle;text-align:left;width:90%;">
  <br>
  <div align="center"><font style="font-weight:bold;color='#CE0829'">查询结果</font></div><br>
<%
if(request.getParameter("logotype") != null && request.getParameter("logotype") .length()>0){
  int lt = Integer.parseInt(request.getParameter("logotype"));
  for(int i = 0;i < Logo.LOGO_TYPE.length;i++){
    if(lt==i){
      out.print("<font style='font-weight:bold'>" + Logo.LOGO_TYPE[i] + "</font>" + "&nbsp;&nbsp;描述：" + Logo.LOGO_CONTENT[i]);
    }
  }

}
%>
</div>
<h2><font style="font-weight:bold;color='#CE0829'">商标列表（<%=count%>）</font></h2>
<table id="tablecenter">
  <tr>
    <td  nowrap>
      <font style="font-weight:bold;">序号</font>
    </td>
    <td  nowrap>
      <font style="font-weight:bold;">商标类别</font>
    </td>
    <td  nowrap>
      <font style="font-weight:bold;">商标名称</font>
    </td>
    <td  nowrap>
      <font style="font-weight:bold;">商标图样</font>
    </td>
    <td  nowrap>
      <font style="font-weight:bold;">核定使用商品</font>
    </td>
    <td  nowrap>
      <font style="font-weight:bold;">注册号</font>
    </td>
    <td  nowrap>
      <font style="font-weight:bold;">注册时间</font>
    </td>
  </tr>
<%
  Enumeration e=Logo.find(community,sql.toString(),pos,10);

	 /* if(!e.hasMoreElements())
	   {
	       out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
	   }
*/
int i =1;
    while(e.hasMoreElements())
    {
	      int logoid = ((Integer)e.nextElement()).intValue();
	      Node enode = Node.find(logoid);
	      Logo logo = Logo.find(logoid);

      %>
      <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
        <td  nowrap style="display: block"> <%=i+pos%></td>
        <td ><%if(logo.getLogotype()!=null && logo.getLogotype().length()>0){out.print(Logo.LOGO_TYPE[Integer.parseInt(logo.getLogotype())]);} %></td>
        <td  nowrap><%=enode.getSubject(logoid)%></td>
        <td>
	        <%if(logo.getLogoimage()==null){
	          out.print("暂无商标图形");
	        }
	        else{
	          out.print("<img src='"+logo.getLogoimage()+"' width='100'>");
	        }
	        %>
        </td>
        <td  ><%if(logo.getLogouse()!=null && logo.getLogouse().length()>0){out.print(logo.getLogouse());}%></td>
        <td  nowrap><%=logo.getRegnum()%> </td>
	        <td  nowrap>
	         <%
	        Date date1 = logo.getRegdate();
	        if(date1 == null || date1.equals("")){
	        }
	        else{
	          SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
	          out.print(format.format(date1));
	        }
	        %>
	        </td>
      </tr>
      <%
      i++;}
    %>


</table>
<%=new tea.htmlx.FPNL(teasession._nLanguage,param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,10)%>
