<%@page contentType="text/html;charset=UTF-8"  %><%@ page import="tea.ui.TeaSession"
import="tea.ui.TeaSession"
import="java.io.*"
import="java.util.*"
import="tea.resource.Resource"
import="tea.entity.node.*"
import="tea.htmlx.*"
import="tea.db.DbAdapter"
import="java.math.BigDecimal"
import="java.text.SimpleDateFormat"%><%

TeaSession teasession = new TeaSession(request);

Resource r =new Resource();
r.add("/tea/ui/node/type/stock/EditStock");

Node node=Node.find(teasession._nNode);
int sid=0;
try
{
  sid=Integer.parseInt(teasession.getParameter("sid"));
}catch(Exception e)
{}

Calendar c=Calendar.getInstance();
int currentlyyear=c.get(java.util.Calendar.YEAR);
int currentlymonth=c.get(java.util.Calendar.MONTH)+1;
int currentlyday=c.get(java.util.Calendar.DAY_OF_MONTH);







String eyear=teasession.getParameter("eyear");
String EMonth=teasession.getParameter("EMonth");
String EDay=teasession.getParameter("EDay");
String syear=teasession.getParameter("syear");
String SMonth=teasession.getParameter("SMonth");
String SDay=teasession.getParameter("SDay");

Date date2 = TimeSelection.makeTime(eyear,EMonth ,EDay );
Date date1 = TimeSelection.makeTime(syear,SMonth ,SDay );



%>

<form name="searcho" method="get" >
<input type="hidden" name="Node" value="<%=teasession._nNode%>"/>

<table border="0" cellspacing="0" cellpadding="0" id="tablecenter" >
  <tr>
    <td><%=r.getString(teasession._nLanguage,"HistoryQuery")%>
      <!--历史股价查询-->
      :</td>
    <td></td>
  </tr>
  <tr>
    <td colspan="2" ><%=r.getString(teasession._nLanguage,"StockName")%>
      <!--股票代码或名称-->
      ：
      <select name="sid">
        <%
        Node node_sid=null;
        Enumeration enumer=Node.findByType(15,node.getCommunity());
        while(enumer.hasMoreElements())
        {
          Node node_temp = Node.find(((Integer)enumer.nextElement()).intValue());
          out.print("<OPTION VALUE="+node_temp._nNode);
          if(sid==0)
          sid=node_temp._nNode;
          if(sid==node_temp._nNode)
          {
            node_sid=node_temp;
            out.print(" SELECTED ");
          }
          //StockList stock=StockList.find(node_temp._nNode,null);
          //out.println(" >"+stock.getStockName(teasession._nLanguage));
          out.println(" >"+node_temp.getSubject(teasession._nLanguage));
        }
        %>
      </select>
    </td>
  </tr>
<%
if(date1==null||date2==null)
{
	DbAdapter db= new DbAdapter();
	try
	{
		db.executeQuery("SELECT MIN(time) FROM StockList where node="+sid);
		if (db.next())
		{
		 date1=db.getDate(1);
		}
		db.executeQuery("SELECT MAX(time) FROM StockList where node="+sid);
		if (db.next())
		{
		  date2=db.getDate(1);
		}
	}finally
	{
		db.close();
	}
}

int npage=1;
if (teasession.getParameter("Page")!=null)
{
  npage=Integer.parseInt(teasession.getParameter("Page"));
}



Vector v_stock=null;
int c_stock=0;
if(teasession.getParameter("Page")==null||session.getAttribute("tea.stock")==null)
{
  v_stock= StockList.find(sid,date1,date2);
  c_stock=StockList.count_s(sid,date1,date2);
  session.setAttribute("tea.stock", v_stock);
  session.setAttribute("tea.c_stock", (new Integer(c_stock)));
  session.setAttribute("tea.date1", date1);
  session.setAttribute("tea.date2", date2);
}else
{
  c_stock = ((Integer)session.getAttribute("tea.c_stock")).intValue();
  v_stock= (Vector)session.getAttribute("tea.stock");
  date1= (Date)session.getAttribute("tea.date1");
  date2= (Date)session.getAttribute("tea.date2");
}
int cpage=0;
if (c_stock%10==0)
  cpage=c_stock/10;
else
  cpage=c_stock/10+1;


%>
  <tr align=left bgcolor="#dddddd">
    <td colspan="2" height="1"></td>
  </tr>
  <tr align=left>
    <td colspan="2" ><%=r.getString(teasession._nLanguage,"BeginDate")%>:
      <select name="syear">
        <%
      for(int index=2001;index<=currentlyyear;index++)
      {
      %>
        <option value="<%=index%>"><%=index%></option>
        <%}%>
      </select><%=r.getString(teasession._nLanguage,"Year")%>
      <select size="1" name="SMonth">
        <option selected value="01">01</option>
        <option  value="02">02</option>
        <option value="03">03</option>
        <option value="04">04</option>
        <option value="05">05</option>
        <option value="06">06</option>
        <option value="07">07</option>
        <option value="08">08</option>
        <option value="09">09</option>
        <option value="10">10</option>
        <option value="11">11</option>
        <option value="12">12</option>
      </select><%=r.getString(teasession._nLanguage,"Month")%>
      <select size="1" name="SDay">
        <option selected value="01">01</option>
        <option value="02">02</option>
        <option value="03">03</option>
        <option value="04">04</option>
        <option value="05">05</option>
        <option value="06">06</option>
        <option value="07">07</option>
        <option value="08">08</option>
        <option value="09">09</option>
        <option value="10">10</option>
        <option value="11">11</option>
        <option value="12">12</option>
        <option value="13">13</option>
        <option value="14">14</option>
        <option value="15">15</option>
        <option value="16">16</option>
        <option value="17">17</option>
        <option value="18">18</option>
        <option value="19">19</option>
        <option value="20">20</option>
        <option value="21">21</option>
        <option value="22">22</option>
        <option value="23">23</option>
        <option value="24">24</option>
        <option value="25">25</option>
        <option value="26">26</option>
        <option value="27">27</option>
        <option value="28">28</option>
        <option value="29">29</option>
        <option value="30">30</option>
        <option value="31">31</option>
      </select><%=r.getString(teasession._nLanguage,"Day")%> </td>
  </tr>
  <tr >
    <td colspan="2" height="1"></td>
  </tr>
  <tr>
    <td width="68%" height="25"  id="unnamed2"><%=r.getString(teasession._nLanguage,"EndDate")%>:
      <select name="eyear">
      <%
      for(int index=2001;index<=currentlyyear;index++)
      {
        out.print("<option selected value="+index+" >"+index);
      }%>
      </select><%=r.getString(teasession._nLanguage,"Year")%>
      <select size="1" name="EMonth">
      <%
      for(int index=01;index<=12;index++)
      {
        out.print("<option ");
        if(currentlymonth==index)
        out.print(" selected ");
        out.print(index+" >"+index);
      }%>
      </select><%=r.getString(teasession._nLanguage,"Month")%>
      <select size="1" name="EDay">
      <%
      for(int index=01;index<=31;index++)
      {
        out.print("<option ");
        if(currentlyday==index)
        out.print(" selected ");
        out.print(index+" >"+index);
      }%>
      </select><%=r.getString(teasession._nLanguage,"Day")%></td>
    <td><input type="submit" value="<%=r.getString(teasession._nLanguage,"Search")%>">
    </td>
  </tr>
  <tr align=left bgcolor="#dddddd">
    <td colspan="2" height="1"></td>
  </tr>
</table>
</form>


<style type="text/css">
<!--

#turnto {font-size: 9pt; line-height: 15pt;color: #990000; position: relative; left: 0; top: 10;text-align: center}

#head_table{font-size: 9pt; line-height: 15pt;color: #990000; position: relative; left: 0; top: 0;width:564;background-color: #BFEBFF;text-align: center}
#head_table_ceon{font-size: 9pt; line-height: 15pt;color: #880000; position: relative; left: 0; top: 0;width:564;background-color: #AAAAAA;text-align: center}
#head_table_0883hk{font-size: 9pt; line-height: 15pt;color: #990000; position: relative; left: 0; top: 0;width:564;background-color: #BBBBBB;text-align: center}
#head_table_2883hk{font-size: 9pt; line-height: 15pt;color: #990000; position: relative; left: 0; top: 0;width:564;background-color: #CCCCCC;text-align: center}

#head_table_600583ss {font-size: 9pt; line-height: 15pt;color: #990000; position: relative; left: 0; top: 0;width:564;background-color: #DDDDDD;text-align: center}

#searchcellhead{
	vertical-align:middle;
	font-size: 9pt;
	background-color: #BFEBFF;
	text-align: center;
}
#searchcellhead1{
	vertical-align:middle;
	font-size: 9pt;
	}
#stocktable{  font-size: 9pt; line-height: 15pt;color: #000000;border: 1 solid #C0C0C0; padding-left: 2; padding-right: 1; padding-top: 1; padding-bottom: 1;width:564}

#searchcell{
	text-align: left;
	font-size: 9pt;
	text-align: center;
}

#outputcell{
	text-align: center;
	font-size: 10pt;
	font-weight: bold;
	color: #003399;
}
#table_page{  font-size: 9pt; line-height: 12pt;color: #000000;border: 1 solid #C0C0C0;;width:564;heiht:20;text-align: center}
#row_page{  font-size: 9pt; line-height: 15pt;color: #000000;border: 1 solid #C0C0C0;text-align: center}
#row_page1{  font-size: 9pt; line-height: 15pt;color: #000000;border: 1 solid #C0C0C0;text-align: center}
.style3 {
	font-size: 9pt;
	font-weight: bold;
}


-->

</style>
<SCRIPT language="Javascript">
function MM_jumpMenu(targ,selObj,restore)
{
  eval(targ+".location='<%=request.getRequestURI()+"?node="+teasession._nNode%>&"+selObj.options[selObj.selectedIndex].value+"'");
if (restore) selObj.selectedIndex=0;
}

</SCRIPT>

<table border="0"  cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td><TABLE ID=table_page CELLSPACING=0 CELLPADDING=0 WIDTH=80% align="center">
        <tr>
          <TD height="27" colspan=6 align ="center" ID=searchcell><%

		if(c_stock>0)
	{
          out.print(node_sid.getSubject(teasession._nLanguage)     );

//out.print(StockList.find(node_sid._nNode,null).getStockName(teasession._nLanguage) );
          %>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; <%=(new SimpleDateFormat("yyyy-MM-dd")).format(date1)%> - <%=(new SimpleDateFormat("yyyy-MM-dd")).format(date2)%> </TD>
        <tr bgcolor="#CCCCCC">
          <TD colspan=6 align ="center" ID=searchcell></TD>
        <tr>
        <TR ID=row_page >
          <TD ID=searchcellhead1><%=tea.http.RequestHelper.format(r.getString(teasession._nLanguage,"AllRecords"),String.valueOf(c_stock))%></TD>
          <TD ID=searchcellhead1><%=r.getString(teasession._nLanguage,"all")%>(<%=cpage%>)<%=r.getString(teasession._nLanguage,"Pages")%></TD>
          <TD ID=searchcellhead1><%=r.getString(teasession._nLanguage,"Current")%>:<%=npage%></TD>
          <TD ID=searchcellhead1><%=r.getString(teasession._nLanguage,"Turn&nbsp;to")%></TD>
          <TD ID=turnto><form name=turnto action="">
              <SELECT NAME=media onChange="MM_jumpMenu('self',this,0)">
<%
for (int ii=1;ii<=cpage ;ii++ )
{
	out.print("<option value='Page="+ii+"&sid="+sid+"'");
	if(npage==ii)
	  out.print(" SELECTED ");
	out.print(">"+ii);
}
%>
              </SELECT>
            </form></TD>
          <TD ID=searchcellhead1><%=r.getString(teasession._nLanguage,"Pages")%> </TD>
        </TR>
      </TABLE>
      <%
 }
 %>
      <TABLE ID=stocktable CELLSPACING=0 CELLPADDING=0 align="center">
        <%
if(c_stock>0)
	{%>
        <TR ID=head_table_<%//=stockid[isid]%>>
          <TD ID=searchcellhead><%=r.getString(teasession._nLanguage,"Date")%></TD>
          <TD ID=searchcellhead><%=r.getString(teasession._nLanguage,"Opening<br>Price")%></TD>
          <TD ID=searchcellhead><%=r.getString(teasession._nLanguage,"High<br>price")%></TD>
          <TD ID=searchcellhead><%=r.getString(teasession._nLanguage,"Low<br>price")%></TD>
          <TD ID=searchcellhead><%=r.getString(teasession._nLanguage,"Closing<br>Price")%></TD>
          <TD ID=searchcellhead><%=r.getString(teasession._nLanguage,"change")%> %</TD>
          <TD ID=searchcellhead><%=r.getString(teasession._nLanguage,"Volume")%></TD>
        </TR>
        <%
}else{
out.print(  r.getString(teasession._nLanguage,"ThereIsNoResult"));

}


int end=npage*10;
if (c_stock<end)
end=c_stock;


	for(int k3=(npage-1)*10;k3<end;k3++)
	{
    	int id = ((Integer)v_stock.elementAt(k3)).intValue();
    	StockList obj=StockList.find(id);
    	out.print("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>");
    	out.print("<td ID=searchcell>"+obj.getDateToString());
    	out.print("<td ID=searchcell>"+obj.getOpen());
    	out.print("<td ID=searchcell>"+obj.getHigh());
 	    out.print("<td ID=searchcell>"+obj.getLow());
 	    out.print("<td ID=searchcell>"+obj.getClosingPrice());
 	    out.print("<td ID=searchcell>"+obj.getChangePercent());
 	    out.print("<td ID=searchcell>"+obj.getVolume());
	}

%>
      </TABLE>
      <%if(c_stock>0)
	{%>
      <TABLE ID=table_page CELLSPACING=0 CELLPADDING=0 WIDTH=80% align="center">
        <TR ID=row_page >
          <TD ID=searchcellhead1><%=tea.http.RequestHelper.format(r.getString(teasession._nLanguage,"AllRecords"),new Integer(c_stock))%></TD>
          <TD ID=searchcellhead1><%=r.getString(teasession._nLanguage,"all")%>(<%=cpage%>)<%=r.getString(teasession._nLanguage,"Pages")%></TD>
          <TD ID=searchcellhead1><%=r.getString(teasession._nLanguage,"Current")%>:<%=npage%></TD>
          <TD ID=searchcellhead1><%=r.getString(teasession._nLanguage,"Turn&nbsp;to")%></TD>
          <TD ID=turnto><form name=turnto action="">
              <SELECT NAME=media onChange="MM_jumpMenu('self',this,0)">
                <%
                for (int ii=1;ii<=cpage ;ii++ )
                {
                	out.print("<OPTION VALUE='Page="+ii+"&sid="+sid+"'");
                	if(npage==ii)
                	out.print(" selected ");
                	out.print(">"+ii);
                }
				%>
              </SELECT>
            </form></TD>
          <TD ID=searchcellhead1><%=r.getString(teasession._nLanguage,"Pages")%> </TD>
        </TR>
      </TABLE>
      <%
 }
 %>
      <TABLE border="0" cellspacing="0" cellpadding="0" id="tablecenter" align="center">
        <TR></TR>
      </TABLE></td>
  </tr>
</table>

