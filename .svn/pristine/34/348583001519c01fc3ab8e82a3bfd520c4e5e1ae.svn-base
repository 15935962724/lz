<%@page contentType="text/html;charset=UTF-8"%>
<%@include file="/jsp/Header.jsp"%>
<%!
boolean _bEdit=false;
java.text.DecimalFormat df=new java.text.DecimalFormat ("#,##0.00");
java.text.DecimalFormat df2=new java.text.DecimalFormat("0");
String contextPath;
java.util.Date formsmonth=null;
java.lang.StringBuffer script=new java.lang.StringBuffer ();
public java.math.BigDecimal[] recursion (java.io.Writer jw,int id,int step)throws Exception
{
  java.math.BigDecimal total[]={new java.math.BigDecimal(0D),new java.math.BigDecimal(0D)};
  java.util.Enumeration enumer = tea.entity.admin.SubsidyMenu.findByFather(id);
  while (enumer.hasMoreElements()) {
    int sm_id = ((Integer) enumer.nextElement()).intValue();
    tea.entity.admin.SubsidyMenu sm_obj = tea.entity.admin.SubsidyMenu.find(sm_id);
 tea.entity.admin.SubsidyMonth smonth_obj = tea.entity.admin.SubsidyMonth.find(sm_id,formsmonth);
jw.write(
"    <tr>                                                                                                       "+
"      <td  >");
    for(int loop=1;loop<step;loop++)
    {
      jw.write("<IMG BORDER=0 SRC=\""+contextPath+"/tea/image/tree/tree_line.gif\" ALT=\"\" ALIGN=\"LEFT\"/>");
    }
    if(step>0)jw.write(new  tea.html.Image(contextPath+"/tea/image/tree/tree_blank.gif","",1).toString());
    if (sm_obj.isType()) {
      script.append("!submitInteger(form111.useper"+sm_id+",'无效参数')||!submitFloat(form111.earning"+sm_id+",'无效参数')||!submitFloat(form111.totalearning"+sm_id+",'无效参数')||!submitFloat(form111.payout"+sm_id+",'无效参数')||!submitFloat(form111.totalpayout"+sm_id+",'无效参数')||!submitFloat(form111.reality"+sm_id+",'无效参数')||");
      java.math.BigDecimal total_temp=sm_obj.getSubsidy().add(sm_obj.getBalance());
      java.math.BigDecimal total_temp2=total_temp.multiply(new java.math.BigDecimal(smonth_obj.getUseper())).divide(new java.math.BigDecimal(100),java.math.BigDecimal.ROUND_HALF_EVEN);
      jw.write(sm_obj.getName(teasession._nLanguage));
      if(_bEdit)
{
  jw.write(" <input TYPE=\"HIDDEN\" NAME=\"subsidymenu\" VALUE="+sm_id+">   </td>       "+
"      <td align=right>"+df.format(sm_obj.getBalance())+"</td>                               "+
"      <td align=right>"+df.format(sm_obj.getSubsidy())+"</td>                               "+
"      <td align=right>"+df.format(total_temp )+"</td>                                                                                            "+
"      <td>X<input NAME=\"useper"+sm_id+"\" TYPE=\"TEXT\" VALUE=\""+smonth_obj.getUseper()+"\" size=\"5\">%</td>                                  "+
"      <td align=right>"+df.format(total_temp2)+"</td>                                                                                            "+
"      <td><input NAME=\"extendmonth"+sm_id+"\" TYPE=\"TEXT\" VALUE=\""+smonth_obj.getExtendMonth(teasession._nLanguage)+"\" size=\"15\"></td>                                 "+
"      <td><input NAME=\"earning"+sm_id+"\" TYPE=\"TEXT\" VALUE=\""+smonth_obj.getEarning()+"\" size=\"15\"></td>                               "+
"      <td><input NAME=\"totalearning"+sm_id+"\" TYPE=\"TEXT\" VALUE=\""+df.format(smonth_obj.getTotalearning())+"\" size=\"15\"></td>                          "+
"      <td><input NAME=\"payout"+sm_id+"\" TYPE=\"TEXT\" VALUE=\""+df.format(smonth_obj.getPayout())+"\" size=\"15\"></td>                                "+
"      <td><input NAME=\"totalpayout"+sm_id+"\" TYPE=\"TEXT\" VALUE=\""+df.format(smonth_obj.getTotalpayout())+"\" size=\"15\"></td>                           "+
"      <td><input NAME=\"reality"+sm_id+"\" TYPE=\"TEXT\" VALUE=\""+df.format(smonth_obj.getReality())+"\" size=\"15\"></td>                               "+
"      <td>"+df2.format(smonth_obj.getTotalpayout().floatValue()/total_temp2.floatValue()*100)+"%</td>                                                                                                "+
"      <td><input NAME=\"text"+sm_id+"\" TYPE=\"TEXT\" VALUE=\"");
if(smonth_obj.getText(teasession._nLanguage)!=null)
jw.write(smonth_obj.getText(teasession._nLanguage));
jw.write("\" size=\"15\"></td>                               "+
"    </tr>                                                                                                      ");
}else
{
jw.write("   </td>       "+
"      <td align=right>"+df.format(sm_obj.getBalance())+"</td>                               "+
"      <td align=right>"+df.format(sm_obj.getSubsidy())+"</td>                               "+
"      <td align=right>"+df.format(total_temp )+"</td>                                                                                            "+
"      <td>X"+smonth_obj.getUseper()+"%</td>                                  "+
"      <td align=right>"+df.format(total_temp2)+"</td>                                                                                            "+
"      <td>"+smonth_obj.getExtendMonth(teasession._nLanguage)+"</td>                                 "+
"      <td>"+smonth_obj.getEarning()+"</td>                               "+
"      <td>"+df.format(smonth_obj.getTotalearning())+"</td>                          "+
"      <td>"+df.format(smonth_obj.getPayout())+"</td>                                "+
"      <td>"+df.format(smonth_obj.getTotalpayout())+"</td>                           "+
"      <td>"+df.format(smonth_obj.getReality())+"</td>                               "+
"      <td>"+df2.format(smonth_obj.getTotalpayout().floatValue()/total_temp2.floatValue()*100)+"%</td>                                                                                                "+
"      <td>");
if(smonth_obj.getText(teasession._nLanguage)!=null)
jw.write(smonth_obj.getText(teasession._nLanguage));
jw.write("</td>                               "+
"    </tr>                                                                                                      ");
}
//System.out.println(sm_obj.getTotalpayout().multiply(new java.math.BigDecimal(100D)).divide(total_temp2,java.math.BigDecimal.ROUND_UP   ));

      total[0]=total[0].add(sm_obj.getBalance());
      total[1]=total[1].add(sm_obj.getSubsidy());
    }else
    {
     jw.write(sm_obj.getName(teasession._nLanguage)+"</td></tr>");
    }
         if (!sm_obj.isType())
         {
          java.math.BigDecimal total_return[]=recursion(jw,sm_id,++step);
          total[0]=total[0].add(total_return[0]);
          total[1]=total[1].add(total_return[1]);
           step--;
         }
  }
jw.write("<tr><td>");
    for(int loop=1;loop<step;loop++)
    {
      jw.write(new  tea.html.Image(contextPath+"/tea/image/tree/tree_line.gif","",1).toString());//  align=absmiddle
    }
    if(step>0) jw.write(new  tea.html.Image(contextPath+"/tea/image/tree/tree_blank.gif","",1).toString());
    jw.write("总数</td><td align=right>"+df.format(total[0])+"</td><td align=right>"+df.format(total[1])+"</td><td align=right>"+df.format(total[0].add(total[1]))+"</td></tr>");
  return total;
}%>
<%
String _strFormsmonth=request.getParameter("formsmonth");
if(_strFormsmonth==null)
{
  formsmonth=new java.util.Date();
  _strFormsmonth=tea.entity.admin.FormsMonth.sdf.format(formsmonth);
}//else
formsmonth=tea.entity.admin.FormsMonth.sdf.parse(_strFormsmonth);

java.util.Calendar c=java.util.Calendar.getInstance();


tea.entity.admin.SubsidyTime st_obj=tea.entity.admin.SubsidyTime.find(node.getCommunity());

boolean _bPrint=request.getParameter("print")!=null;

int year_currently =c.get(java.util.Calendar.YEAR);
int month_currently =c.get(java.util.Calendar.MONTH);
int day_currently=c.get(java.util.Calendar.DAY_OF_MONTH);
/*
java.util.Calendar c_start=  java.util.Calendar.getInstance();
c_start.set(java.util.Calendar.YEAR,year);
c_start.set(java.util.Calendar.MONTH,month);
c_start.set(java.util.Calendar.DAY_OF_MONTH,st_obj.getStartMonth());

java.util.Calendar c_stop=  java.util.Calendar.getInstance();
c_stop.set(java.util.Calendar.YEAR,year);
c_stop.set(java.util.Calendar.MONTH,month);
c_stop.set(java.util.Calendar.DAY_OF_MONTH,st_obj.getStopMonth());
System.out.println(c.getTime());
System.out.println(c_start.getTime());
System.out.println(c_stop.getTime());
*/
c.setTime(formsmonth);
int year=c.get(java.util.Calendar.YEAR);
int month=c.get(java.util.Calendar.MONTH);

_bEdit=year_currently==year&&month==month_currently&&day_currently>=st_obj.getStartMonth()&&day_currently<st_obj.getStopMonth()&&!_bPrint;//c.getTime().compareTo(c_start.getTime())>=0&&c.getTime().compareTo(c_stop.getTime())<0;


if(_bEdit&&request.getMethod().equals("POST"))
{
String subsidymonths[]=  request.getParameterValues("subsidymenu");
for(int index=0;index<subsidymonths.length;index++)
{
  tea.entity.admin.FormsMonth fm_obj = tea.entity.admin.FormsMonth.find(formsmonth);
  fm_obj.set(teasession._rv._strR);

  int subsidymonth=Integer.parseInt(subsidymonths[index]);
  tea.entity.admin.SubsidyMonth sm_obj = tea.entity.admin.SubsidyMonth.find(subsidymonth,formsmonth);
  int useper=Integer.parseInt(request.getParameter("useper"+subsidymonth));
  String extendmonth=request.getParameter("extendmonth"+subsidymonth);
  java.math.BigDecimal earning=new java.math.BigDecimal(request.getParameter("earning"+subsidymonth).replaceAll(",",""));
  java.math.BigDecimal totalearning=new java.math.BigDecimal(request.getParameter("totalearning"+subsidymonth).replaceAll(",",""));
  java.math.BigDecimal payout=new java.math.BigDecimal(request.getParameter("payout"+subsidymonth).replaceAll(",",""));
  java.math.BigDecimal totalpayout=new java.math.BigDecimal(request.getParameter("totalpayout"+subsidymonth).replaceAll(",",""));
  java.math.BigDecimal reality=new java.math.BigDecimal(request.getParameter("reality"+subsidymonth).replaceAll(",",""));
  String text=request.getParameter("text"+subsidymonth);
  sm_obj.set(subsidymonth,formsmonth,useper,extendmonth,earning,totalearning,payout,totalpayout,reality,teasession._rv._strR,text,teasession._nLanguage);
}
  response.sendRedirect("InfoSuccess.jsp?node="+teasession._nNode);
  return;
}
contextPath=request.getContextPath();
int rootid = tea.entity.admin.SubsidyMenu.getRootId(node.getCommunity());
%>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script type="">
function check()
{
    if(<%=script.toString()%>false)
    return false;
    return true;
}
</script>
</head>
<body>
    <h1><%=_strFormsmonth%>月财政报告</h1>
<div id="head6"><img height="6" alt=""></div>
<h2></h2>

<form NAME=form111 METHOD=POST ACTION="<%=contextPath%>/jsp/admin/schoolfinance/EditSubsidyForms.jsp?node=<%=teasession._nNode%>" onSubmit="return check();" >
<input type="hidden" name="formsmonth" value="<%=_strFormsmonth%>"/>

<table border="0" height="100%" width="800"  cellPadding="0" cellSpacing="0" id="tablecenter"  >
<TR id="tableonetr">
    <td nowrap="nowrap">项目</td>
    <td nowrap="nowrap">往年余额</td>
    <td nowrap="nowrap">本年度<br/>教统局津贴</td>
    <td nowrap="nowrap">总额</td>
    <td nowrap="nowrap">使用率</td>
    <td nowrap="nowrap">预算支出总额</td>
    <td nowrap="nowrap">发放津贴月份</td>
    <td nowrap="nowrap">本月津贴收入/<br/>户口利息收入</td>
    <td nowrap="nowrap">直到本月的<br/>累计津贴收入</td>
    <td nowrap="nowrap">本月支出</td>
    <td nowrap="nowrap">直到本月的<br/>累计支出</td>
    <td nowrap="nowrap">现时结余</td>
    <td nowrap="nowrap">现时的<br/>使用率</td>
    <td nowrap="nowrap">注解</td>
  </tr>
  <%recursion(out,rootid,0);%>
  <tr><td colspan="20">
<%if(_bEdit){%>
<input type="submit" value="<%=r.getString(teasession._nLanguage,"Submit")%>"/>
<%  }%>
<input type="button" id="buttonprint" onClick="window.open('<%=request.getRequestURI()+"?"+request.getQueryString()%>&print=ON');" value="打印"/>
</td></tr>
 
  </table>
 </FORM>


<br/>
  <div id="note">
注:<%=st_obj.getStartMonth()%>日-<%=st_obj.getStopMonth()%>日 时才可以新提交或修改数据
</div>
<br/>
<%
if(_bPrint)
{
   tea.entity.admin.FormsMonth fm_obj=  tea.entity.admin.FormsMonth.find(formsmonth);
  java.text.SimpleDateFormat sdf=new java.text.SimpleDateFormat("yyyy-MM-dd hh:mm");
  %>
  打印者:<%=teasession._rv%> 打印时间:<%=sdf.format(new java.util.Date())%> 提交者:<%=fm_obj.getMember()%> 提交时间:<%=sdf.format(fm_obj.getTime())%>
  <%
}
%>
<div id="head6"><img height="6" src="about:blank"></div>


   <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
   </body>
</html>




<%
if(_bPrint)
{
  %>
  <style type="text/css">
    #buttonprint,#language,#note
    {
    display:none ;
    }
  </style>
  <object ID='WebBrowser' WIDTH=0 HEIGHT=0 CLASSID='CLSID:8856F961-340A-11D0-A96B-00C04FD705A2'></object>
  <script type="">
  WebBrowser.ExecWB(7,1);
  window.opener=null;window.close();
  </script>
  <%
}%>



