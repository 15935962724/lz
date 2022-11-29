<%@ page contentType="text/html;charset=UTF-8" %><%@page import="java.text.*" %>
<%@page import="tea.entity.node.access.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.db.*" %>
<%@ page import="java.lang.*,java.util.*,java.text.SimpleDateFormat" %>
<script language="javascript" type="">
function gotoPage(value)
{
  var obj=form1.month;
  var month=parseInt(obj.value);
  if((month+value<1)||(month+value>12))
  {
    obj.options[obj.options.length]=new Option(month,month+value);
  }
  obj.value=month+value;
  form1.submit();
}

function gotoPageDay(value)
{
  var obj=form1.day;
  var day=parseInt(obj.value);
  if((day+value<1)||(day+value>12))
  {
    obj.options[obj.options.length]=new Option(day,day+value);
  }
  obj.value=day+value;
  form1.submit();
}

</script>
<%


String _strid=request.getParameter("id");

Calendar c = Calendar.getInstance();
c.setTimeInMillis(System.currentTimeMillis());
int cyear=c.get(c.YEAR);
c.set(11, 0);
c.set(12, 0);
c.set(13, 0);
c.set(14, 0);
Date cdate=c.getTime();

String tmp=request.getParameter("month");
if(tmp!=null)
{
  c.set(c.MONTH,Integer.parseInt(tmp)-1);
}else
	c.set(c.MONTH,cdate.getMonth()-1);  //查看前一个月的数据

tmp=request.getParameter("year");
if(tmp!=null)
{
  c.set(c.YEAR,Integer.parseInt(tmp));
}
tmp=request.getParameter("day");
if(tmp!=null)
{
  c.set(c.DATE,Integer.parseInt(tmp));
}else
	 c.set(c.DATE,cdate.getDate());
int rs=cdate.compareTo(c.getTime());
if(rs==-1)
{
  out.print("<script>alert('不能大于当前日期');history.back();</script>");
  return;
}
int year=c.get(c.YEAR);
int month=c.get(c.MONTH)+1;
int day=c.get(c.DATE);
int max=1;
String community=request.getParameter("community");

Properties cache = new Properties();
try {
	cache.load(NodeAccessLast.class.getClassLoader().getResourceAsStream("db.properties"));
} catch (Exception e) {
	e.printStackTrace();
}
String url = cache.getProperty("0Url");
String databaseName = url.substring(url.indexOf("=")+1);
//System.out.print(databaseName);
String columnnodeStr = request.getParameter("columnnode");
int columnnode = columnnodeStr!=null&&!columnnodeStr.equals("")?Integer.parseInt(request.getParameter("columnnode")):0;
String columnodeSql = columnnode>0?" and node in (SELECT node FROM "+databaseName+".dbo.Node where path like '%"+columnnode+"%')":"";

int icount=0;
 
 
 alltotal=tea.entity.node.access.NodeAccessLast.countHotNodesByMonth(community,year,month);
icount=tea.entity.node.access.NodeAccessLast.itemHotNodesByMonth(community,year,month,columnodeSql);
 
int showcount=0;
showcount=icount>100?100:icount;
float k=(float)alltotal/100;

StringBuffer param =new StringBuffer("?node="+teasession._nNode+"&community="+teasession._strCommunity+"&act=hotbymonth");

int pos = 0, pageSize = 20, count = 0;
if (request.getParameter("pos") != null) {
//System.out.println("pos"+request.getParameter("pos"));
 pos = Integer.parseInt(request.getParameter("pos"));
}


%>
<p>
<script src="/tea/tea.js" type="text/javascript"></script>
<table border="0" cellspacing="0" cellpadding="0" id="tablecenter">
  <tr>
    <td> 　<h2>每月热门话题</h2></td>
  </tr>
<tr><td>
  <table border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td align="center">
       <form name="form1" action="?">
  <input type="hidden" name="community" value="<%=community%>" >
  <input type="hidden" name="act" value="<%=act%>" >
  <input type="hidden" name="id" value="<%=_strid%>" >
    
      <a href="javascript:gotoPage(-1);" >&lt;&lt;向前</a>&nbsp;&nbsp;&nbsp;
     
       <%
       Enumeration years=NodeAccessDay.getYears(community);
       Enumeration months=NodeAccessDay.getMonths(community,year);
       
       StringBuffer sql = new StringBuffer();
       sql.append(" AND community=").append("'"+teasession._strCommunity+"'");
       int sum=NodeAccessColumn.count(sql.toString());
       if(sum>0)
       {
           out.print("<select name='columnnode' id='columnnode' onChange='form1.submit();'>");
           out.print("<option value=''>--</option>");
    	   Iterator it=NodeAccessColumn.find(sql.toString(),0,200).iterator();
    	   for(int i=1+pos;it.hasNext();i++)
    	   {
    		   NodeAccessColumn nac=(NodeAccessColumn)it.next();
    		   out.print("<option value="+nac.node);
    		   if(nac.node==columnnode)
    			   out.print(" SELECTED ");
    		   out.print(">"+nac.name+"</option>");
    	   }
    	   out.print("</select>");
       }
       %>
        <select name="year" id="year" onChange="form1.submit();">
          <%
        //  for(int i=2007;i<=cyear;i++)
            while(years.hasMoreElements())
          { int i=((Integer)years.nextElement()).intValue();
        
            out.print("<option value="+i);
            if(i==year)
            out.print(" SELECTED ");
            out.print(">"+i);
          }
          %>
        </select>
        <%=r.getString(teasession._nLanguage,"1215680597991")%>
        <select name="month" id="month" onChange="form1.submit();">
          <%
          //for(int i=1;i<13;i++)
             while(months.hasMoreElements())
          {int i=((Integer)months.nextElement()).intValue();
            out.print("<option value="+i);
            if(i==month)
            out.print(" selected ");
            out.print(">"+i);
          }
          %>
        </select>月

  
内前<%=showcount %>个访问量最高的页面
       &nbsp;&nbsp;&nbsp;  
      <a href="javascript:gotoPage(1);" >向后&gt;&gt;</a>&nbsp;&nbsp;&nbsp;
    
    
      &nbsp;&nbsp;&nbsp; </form></td>
    </tr>
  </table>

</td>
 </tr>
  <tr>
    <td align="left">

        <table border="0" cellspacing="0" cellpadding="0" align="center">
<%
//List list=NodeAccessLast.findHotNodes(community,time_s,time_e,pos,pageSize);
 
List	list=NodeAccessLast.findHotNodesByMonth(community,year,month,columnodeSql,pos,pageSize);
Iterator iter=list.iterator();
int i=0;
while (iter.hasNext())
{
  NodeAccessLast nal=(NodeAccessLast)iter.next();
  int nid=nal.getNode();
  Node n=Node.find(nid);
  Report report=Report.find(nid);

  Media m=Media.find(report.getMedia());
  
  int hits=nal.getCount();
  if(i==0)max=hits;
  i++;

  float p=hits/k;
  float w=hits*100/(float)max;
  out.print("<tr>");
  
  out.print("<td nowap ><a target='_blank' href='/servlet/Node?node="+nid+"'>"+(pos+i)+"."+n.getSubject(teasession._nLanguage)+"</a></td>");
  out.print("<td nowap align='right'>"+df.format(hits)+"</td>");

  out.print("<td nowap align='right'>"+n.getCreator()._strR +"</td>");
  out.print("<td nowap align='right'>"+n.getTimeToString() +"</td>");
  out.print("<td nowap align='left'>"+m.getName(teasession._nLanguage) +"</td>");
 
 out.print("</tr>");
}
if(showcount>0)
{
%>
    <tr><td nowap >
     <%=new tea.htmlx.FPNL(teasession._nLanguage, "/jsp/count/index.jsp?act=hotbymonth&year="+year+"&month="+month+"&day="+day+"&community=" + community + "&pos=", pos,showcount,20)%>
</td></tr>

  <% }
  else
  {out.println("<tr><td nowap > 此时间段内没有访问记录 ！</td></tr>");
  }
  %>
   </table></td>
  </tr>
</table>




