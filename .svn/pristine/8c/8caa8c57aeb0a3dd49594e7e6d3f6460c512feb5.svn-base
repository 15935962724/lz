<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.*" %><%@page import="tea.entity.node.*" %><%@page import="java.util.*" %>
<%@include file="/jsp/Header.jsp"%>
<%
Http h=new Http(request);

r.add("/tea/ui/node/type/stock/EditStock");
int id=1;
int listing=0;
int iPage=0;

//DbAdapter dbadapter = new DbAdapter();
if (teasession.getParameter("Stockid")!=null)
{
  id=Integer.parseInt(teasession.getParameter("Stockid"));
}
if (teasession.getParameter("Listing")!=null)
{
  listing=Integer.parseInt(teasession.getParameter("Listing"));
}
if (teasession.getParameter("Page")!=null)
{
  iPage=Integer.parseInt(teasession.getParameter("Page"));
}
String stockname,estockname,stockname2,estockname2;
String graphweek=null,graphmonth=null,graphyear=null,graphyet=null;
if( request.getParameter("NewNode")==null)
{
  StockList obj = StockList.find(teasession._nNode,null);
  stockname= obj.getStockName(1);
  estockname= obj.getStockName(0);

  Stock2 obj2 = Stock2.find(teasession._nNode);
  stockname2= obj2.getStockName(1);
  estockname2= obj2.getStockName(0);
  graphweek=obj2.getGraphWeek();
  graphmonth=obj2.getGraphMonth();
  graphyear=obj2.getGraphYear();
  graphyet=obj2.getGraphYet();
}else
{
  stockname=estockname=stockname2=estockname2="";
}

%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" ></SCRIPT>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/mt.js" ></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
function f_del(id)
{
  if(!confirm('确认删除'))return;
  form2.id.value=id;
  form2.submit();
}
</script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "CBEditStock")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
  <FORM name=foEdit METHOD=POST enctype=multipart/form-data action="/servlet/EditStock" target="_ajax" onsubmit="return mt.check(this)">
    <input type="hidden" name="node" value="<%=teasession._nNode%>"/>
    <input type="hidden" name="act" value="list"/>
    <table border="0" cellspacing="0" cellpadding="0" id="tablecenter">
      <tr ID=Tableonetr>
        <td><%=r.getString(teasession._nLanguage,"Date")%></td>
        <td><%=r.getString(teasession._nLanguage,"Previous<br>Closing")%></td>
        <td><%=r.getString(teasession._nLanguage,"Opening<br>Price")%></td>
        <td><%=r.getString(teasession._nLanguage,"High<br>price")%></td>
        <td><%=r.getString(teasession._nLanguage,"Low<br>price")%></td>
        <td><%=r.getString(teasession._nLanguage,"Closing<br>Price")%></td>
        <td><%=r.getString(teasession._nLanguage,"change")%></td>
        <td><%=r.getString(teasession._nLanguage,"Volume")%></td>
      </tr>
      <tr>
        <td><%=new TimeSelection("Issue", null)%></td>
 		<td><input type="TEXT" class="edit_input"  name=datedata VALUE="<%//=dbadapter.getBigDecimal(3, 4).toString()%>" SIZE=8 mask="float" alt="前收盘"></td>
        <td><input type="TEXT" class="edit_input"  name=openingprice VALUE="<%//=dbadapter.getBigDecimal(3, 4).toString()%>" SIZE=8 mask="float" alt="开盘价"></td>
        <td><input type="TEXT" class="edit_input"  name=high VALUE="<%//=dbadapter.getBigDecimal(4, 4).toString()%>" SIZE=8 mask="float" alt="最高价"></td>
        <td><input type="TEXT" class="edit_input"  name=low VALUE="<%//=dbadapter.getBigDecimal(5, 4).toString()%>" SIZE=8 mask="float" alt="最低价"></td>
        <td><input type="TEXT" class="edit_input"  name=closingprice VALUE="<%//=dbadapter.getBigDecimal(6, 4).toString()%>" SIZE=8 mask="float" alt="收盘价"></td>
        <td><input type="TEXT" class="edit_input"  name=percentchange VALUE="<%//=dbadapter.getBigDecimal(7, 4).toString()%>" SIZE=8 mask="float" alt="涨跌幅"></td>
        <td><input type="TEXT" class="edit_input"  name=volume VALUE="<%//=volumn.toString()%>" SIZE=8 mask="float" alt="成交量"></td>
      </tr>
    </table>
<input type="submit" value="提交">
<input type="button" value="返回" onclick="history.back();">
  </form>
  <br/>

  <h2><%=r.getString(teasession._nLanguage, "HistoryStockManage")%></h2>
  <FORM name=form2 action="/servlet/EditStock" target="_ajax" >
    <input type="hidden" name="node" value="<%=teasession._nNode%>"/>
    <input type="hidden" name="act" value="del"/>
    <input type="hidden" name="id" value="0"/>
  <table border="0" cellspacing="0" cellpadding="0" id="tablecenter">
    <tr id="tableonetr">
      <td><%=r.getString(teasession._nLanguage,"Date")%></td>
      <td><%=r.getString(teasession._nLanguage,"Opening<br>Price")%></td>
      <td><%=r.getString(teasession._nLanguage,"Volume")%></td>
      <td></td>
    </tr>
<%
java.util.Vector vector=StockList.find(teasession._nNode,null,null);
int pos=h.getInt("pos");

for(int index=0;index<vector.size()&&index<pos+10;index++)
{
  if(index>=pos)
  {
    int sid=((Integer)vector.get(index)).intValue();
    StockList stock_obj=  StockList.find(sid);
    %>
    <tr onmouseover="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
      <td><%=stock_obj.getDateToString()%></td>
      <td><%=stock_obj.getOpen()%></td>
      <td><%=stock_obj.getVolume()%></td>
      <td>
        <input type="button" value="<%=r.getString(teasession._nLanguage,"Delete")%>" onClick="f_del(<%=sid%>)"/>
      </td>
    </tr>
    <%
    }
  }
  %>
  </table>
  <%=new FPNL(teasession._nLanguage, request.getRequestURI()+("?"+request.getQueryString()).replaceFirst("pos=","")+ "&pos=", pos, vector.size(),10)%>
  <br/>
  <div id="head6"><img height="6" src="about:blank"></div>
    <div id="language"><%=new Languages(teasession._nLanguage, request)%></div>
</body>
</html>

