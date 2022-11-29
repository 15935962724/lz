<%@page contentType="text/html;charset=UTF-8"%>
<%@include file="/jsp/Header.jsp"%>
<%!
java.text.DecimalFormat df=new java.text.DecimalFormat ("#,##0.00");
String contextPath;
int formsyear;
boolean _bEdit=false;
public java.math.BigDecimal[] recursion (java.io.Writer jw,int id,int step)throws Exception
{
  java.math.BigDecimal total[]={new java.math.BigDecimal(0D),new java.math.BigDecimal(0D)};
  java.util.Enumeration enumer = tea.entity.admin.SubsidyMenu.findByFather(id);
  while (enumer.hasMoreElements()) {
    int sm_id = ((Integer) enumer.nextElement()).intValue();
    tea.entity.admin.SubsidyMenu sm_obj = tea.entity.admin.SubsidyMenu.find(sm_id);
    tea.entity.admin.SubsidyYear sy_obj = tea.entity.admin.SubsidyYear.find(formsyear,sm_id);
    //tea.html.Form form=new tea.html.Form("form111"+sm_id,"POST",contextPath+"/jsp/admin/schoolfinance/EditSubsidyOutlay.jsp");
    //form.setOnSubmit("return submitFloat(form111"+sm_id+".balance,'无效参数')&&submitFloat(form111"+sm_id+".subsidy,'无效参数')");
    tea.html.Row tr=new tea.html.Row();
    tea.html.Cell td=    new tea.html.Cell();
    for(int loop=1;loop<step;loop++)
    {
      td.add(new  tea.html.Image(contextPath+"/tea/image/tree/tree_line.gif","",1));//  align=absmiddle
    }
    if(step>0)td.add(new  tea.html.Image(contextPath+"/tea/image/tree/tree_blank.gif","",1));
    if (sm_obj.isType()) {
      td.add(new tea.html.HiddenField("subsidymenu",sm_id));
      td.add(new tea.html.Text(sm_obj.getName(teasession._nLanguage)));
      tr.add(td);
      if(_bEdit)
      {
        tr.add(new tea.html.Cell(new tea.html.TextField("balance"+sm_id,sy_obj.getBalance())));
        tr.add(new tea.html.Cell(new tea.html.TextField("subsidy"+sm_id,sy_obj.getSubsidy())));
      }else
      {
          tr.add(new tea.html.Cell(df.format(sy_obj.getBalance())));
          tr.add(new tea.html.Cell(df.format(sy_obj.getSubsidy())));
      }
      tr.add(new tea.html.Cell(df.format(sy_obj.getSubsidy().add(sy_obj.getBalance()))));
      //tr.add(new tea.html.Cell(new tea.html.Button(r.getString(teasession._nLanguage,"Submit"))));
      total[0]=total[0].add(sy_obj.getBalance());
      total[1]=total[1].add(sy_obj.getSubsidy());
    }else
    {
      //tea.html.Image img=      new tea.html.Image(contextPath+"/tea/image/tree/tree_plus.gif");
      //img.setId("img"+sm_id);
      //td.add(new tea.html.Anchor("#",img,"if(document.all('"+sm_id+"').style.display==''){document.all('"+sm_id+"').style.display='none';document.all('img"+sm_id+"').src='"+contextPath+"/tea/image/tree/tree_plus.gif';}else{document.all('"+sm_id+"').style.display='';document.all('img"+sm_id+"').src='"+contextPath+"/tea/image/tree/tree_minus.gif';}"));
      td.add(new tea.html.HiddenField("subsidymenu_total",sm_id));
      td.add(new tea.html.Text(sm_obj.getName(teasession._nLanguage)));
      tr.add(td);
    }

    jw.write(tr.toString());
    if (!sm_obj.isType())
    {
      java.math.BigDecimal total_return[]=recursion(jw,sm_id,++step);
      total[0]=total[0].add(total_return[0]);
      total[1]=total[1].add(total_return[1]);
      step--;
    }
  }

    tea.html.Row tr=new tea.html.Row();
    tea.html.Cell td=   new tea.html.Cell();
    for(int loop=1;loop<step;loop++)
    {
      td.add(new  tea.html.Image(contextPath+"/tea/image/tree/tree_line.gif","",1));//  align=absmiddle
    }
    if(step>0)td.add(new  tea.html.Image(contextPath+"/tea/image/tree/tree_blank.gif","",1));
    td.add(new tea.html.Text("总数"));
    tr.add(td);
    tr.add(new tea.html.Cell(df.format(total[0])));
    tr.add(new tea.html.Cell(df.format(total[1])));
    tr.add(new tea.html.Cell(df.format(total[0].add(total[1]))));
    jw.write(tr.toString());
  return total;
}%>

<%
java.util.Calendar c=java.util.Calendar.getInstance();

String _strFormsyear=request.getParameter("formsyear");
if(_strFormsyear!=null)
formsyear=Integer.parseInt(_strFormsyear);
else
{
  formsyear= c.get(java.util.Calendar.YEAR);
}

tea.entity.admin.SubsidyTime st_obj=tea.entity.admin.SubsidyTime.find(node.getCommunity());
int month=c.get(java.util.Calendar.MONTH)+1;
int day=c.get(java.util.Calendar.DAY_OF_MONTH);

//_bEdit=  formsyear== c.get(java.util.Calendar.YEAR)&&monTD>=st_obj.getStartSubsidyMonth()&&month<=st_obj.getStopSubsidyMonth()&&day>=st_obj.getStartSubsidyDay()&&day<st_obj.getStopSubsidyDay();

boolean _bPrint=request.getParameter("print")!=null;

java.util.Calendar c_start=  java.util.Calendar.getInstance();
c_start.set(java.util.Calendar.YEAR,formsyear);
c_start.set(java.util.Calendar.MONTH,st_obj.getStartSubsidyMonth()-1);
c_start.set(java.util.Calendar.DAY_OF_MONTH,st_obj.getStartSubsidyDay());

java.util.Calendar c_stop=  java.util.Calendar.getInstance();
c_stop.set(java.util.Calendar.YEAR,formsyear);
c_stop.set(java.util.Calendar.MONTH,st_obj.getStopSubsidyMonth()-1);
c_stop.set(java.util.Calendar.DAY_OF_MONTH,st_obj.getStopSubsidyDay());

_bEdit=c.getTime().compareTo(c_start.getTime())>=0&&c.getTime().compareTo(c_stop.getTime())<0&&!_bPrint;



if(_bEdit&&request.getMethod().equals("POST"))
{
  tea.entity.admin.FormsYear fm_obj=  tea.entity.admin.FormsYear.find(formsyear);
  fm_obj.set(teasession._rv._strR);

  String subsidymenus[]= request.getParameterValues("subsidymenu");
  for(int index=0;index<subsidymenus.length;index++)
  {
    int subsidymenu=Integer.parseInt(subsidymenus[index]);
    tea.entity.admin.SubsidyYear sy_obj = tea.entity.admin.SubsidyYear.find(formsyear,subsidymenu);
    java.math.BigDecimal balance= new java.math.BigDecimal(request.getParameter("balance"+subsidymenu).replaceAll(",",""));
    java.math.BigDecimal subsidy=new java.math.BigDecimal(request.getParameter("subsidy"+subsidymenu).replaceAll(",",""));
    sy_obj.set(balance,subsidy,balance.add(subsidy));
  }

  subsidymenus= request.getParameterValues("subsidymenu_total");
  for(int index=0;index<subsidymenus.length;index++)
  {
    int subsidymenu=Integer.parseInt(subsidymenus[index]);
    java.math.BigDecimal balance=new     java.math.BigDecimal(0D);
    java.math.BigDecimal subsidy=new     java.math.BigDecimal(0D);
    java.util.Enumeration enumer=tea.entity.admin.SubsidyMenu.findSon(subsidymenu);
    while(enumer.hasMoreElements())
    {
      int sm_id=((Integer)      enumer.nextElement()).intValue();
      tea.entity.admin.SubsidyMenu sm_obj=tea.entity.admin.SubsidyMenu.find(sm_id);
      if(sm_obj.isType())
      {
        tea.entity.admin.SubsidyYear sy_obj = tea.entity.admin.SubsidyYear.find(formsyear,sm_id);
        balance=balance.add(sy_obj.getBalance());
        subsidy=subsidy.add(sy_obj.getSubsidy());
      }
    }
    tea.entity.admin.SubsidyYear sy_obj = tea.entity.admin.SubsidyYear.find(formsyear,subsidymenu);
    sy_obj.set(balance,subsidy,balance.add(subsidy));
  }
  response.sendRedirect("InfoSuccess.jsp?node="+teasession._nNode);
  return;
}
contextPath=request.getContextPath();
int rootid = tea.entity.admin.SubsidyMenu.getRootId(node.getCommunity());
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script type="">
function fcheck()
{
  for(var index=0;index<form111.elements.legnth;index++)
  {
    if(form111.elements[index].type=="text")
    {
      if(!submitFloat(form111.elements[index],'无效参数'))
      {
        return false;
      }
    }
  }
  return true;
}
</script>
</head>
<body>
    <h1><%=formsyear+"-"+(formsyear+1)%>年度津贴单位组别及总数</h1>
<div id="head6"><img height="6" alt=""></div>
<h2></h2>
<form NAME=form111 METHOD=POST ACTION="/jsp/admin/schoolfinance/EditSubsidyOutlay.jsp?node=<%=teasession._nNode%>" onSubmit="return fcheck()">
<input type="hidden" name="formsyear" value="<%=formsyear%>"/>
<table border="0" cellPadding="0" cellSpacing="0" id="tablecenter">
<TR id="tableonetr">
    <td>项目</td>
    <td>往年余额</td>
    <td>本年教统局津贴</td>
    <td>总额</td>
  </tr>
  <input TYPE="HIDDEN" NAME="subsidymenu_total" VALUE="<%=rootid%>"/>
<%recursion(out,rootid,0);%>

</table>
<%
    if(_bEdit)
    {
    %>
    <input type="submit" value="<%=r.getString(teasession._nLanguage,"Submit")%>"/>
<%      }%>
<input type="button" id="buttonprint" onClick="window.open('<%=request.getRequestURI()+"?"+request.getQueryString()%>&print=ON');" value="打印"/>

</form>

<br/>
  <div id="note">
  注:<%=st_obj.getStartSubsidyMonth()%>月<%=st_obj.getStartSubsidyDay()%>日-<%=st_obj.getStopSubsidyMonth()%>月<%=st_obj.getStopSubsidyDay()%>日 时才可以新提交或修改数据
</div>
<%
if(_bPrint)
{
   tea.entity.admin.FormsYear fm_obj=  tea.entity.admin.FormsYear.find(formsyear);
  java.text.SimpleDateFormat sdf=new java.text.SimpleDateFormat("yyyy-MM-dd hh:mm");
  %>
  打印者:<%=teasession._rv%> 打印时间:<%=sdf.format(new java.util.Date())%> 提交者:<%=fm_obj.getMember()%> 提交时间:<%if(fm_obj.getTime()!=null)out.print(sdf.format(fm_obj.getTime()));%>
  <%
}
%>
<br/>
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
  window.close();
  </script>
  <%
}%>

<%--


  <tr>
    <td><%=sm_obj.getName(teasession._nLanguage)%>    </td>
  <%if (sm_obj.isType()) {  %>
    <td>
      <input type="text" name="textfield">
    </td>
    <td>
      <input type="text" name="textfield">
    </td>
    <td>&nbsp;</td>
    <td>
      <input type="submit" name="Submit" value="Submit">
    </td>
  <%}  %>
  </tr>
</form>
--%>



