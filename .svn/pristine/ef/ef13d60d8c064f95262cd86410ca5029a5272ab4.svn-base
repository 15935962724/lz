<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.db.DbAdapter" %><%@page import="jxl.write.*" %><%@page import="tea.resource.Resource" %><%@page import="tea.entity.admin.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.entity.site.*" %><%@page import="java.util.*" %><%@page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

if(request.getParameter("delete")!=null)
{
  int flowbusiness=Integer.parseInt(request.getParameter("flowbusiness"));
  Flowbusiness fb=Flowbusiness.find(flowbusiness);
  fb.delete();
  response.sendRedirect(request.getHeader("referer"));
  return;
}

Resource r=new Resource();

String id=request.getParameter("id");

StringBuffer sql=new StringBuffer();
StringBuffer param=new StringBuffer();
param.append("?id=").append(id);
param.append("&community=").append(teasession._strCommunity);

String tmp;
int workproject=0,flowitem=0,flow2=0;

tmp=request.getParameter("flowitem");
if(tmp!=null&&tmp.length()>0)
{
  flowitem=Integer.parseInt(tmp);
}
sql.append(" AND step!=-1");
if(flowitem>0)
{
  sql.append(" AND flowitem=").append(flowitem);
  param.append("&flowitem=").append(flowitem);
}

int adminunitorg=0;
tmp=request.getParameter("adminunitorg");
if(tmp!=null)
{
  adminunitorg=Integer.parseInt(tmp);
  if(adminunitorg>0)
  {
    sql.append(" AND adminunitorg=").append(adminunitorg);
    param.append("&adminunitorg=").append(adminunitorg);
  }
}

tmp=request.getParameter("workproject");
if(tmp!=null&&tmp.length()>0)
{
  workproject=Integer.parseInt(tmp);
  if(flowitem==0)
  sql.append(" AND flowitem IN ( SELECT flowitem FROM Flowitem WHERE workproject=").append(workproject).append(")");

  param.append("&workproject=").append(workproject);
}

String s1="",s2="";//SQL语句

boolean isCreator=request.getParameter("creator")!=null;
if(isCreator)
{
  sql.append(" AND flowbusiness IN (SELECT flowbusiness FROM Flowview WHERE transactor=").append(DbAdapter.cite(teasession._rv._strR)).append(" AND flowview IN ( SELECT MIN(flowview) FROM Flowview GROUP BY flowbusiness) )");
  param.append("&creator=");
}

//flow:菜单中传递此参数////////////
String flow=request.getParameter("flow");
if(flow!=null&&flow.length()>0)
{
  s1=" AND flow IN("+flow+")";
  param.append("&flow=").append(flow);
}

tmp=request.getParameter("flow2");
if(tmp!=null&&tmp.length()>0)
{
  flow2=Integer.parseInt(tmp);
  s2=" AND flow="+flow2;
  param.append("&flow2=").append(flow2);
}

//保存期限
String dt45=request.getParameter("dynamictype45");
if(dt45!=null&&dt45.length()>0)
{
  sql.append(" AND flowbusiness IN(SELECT -node FROM DynamicValue WHERE dynamictype=45 AND value="+DbAdapter.cite(dt45)+")");
  param.append("&dynamictype45=").append(dt45);
}
//是否受控
String dt46=request.getParameter("dynamictype46");
if(dt46!=null&&dt46.length()>0)
{
  sql.append(" AND flowbusiness IN(SELECT -node FROM DynamicValue WHERE dynamictype=46 AND value="+DbAdapter.cite(dt46)+")");
  param.append("&dynamictype46=").append(dt46);
}

int state=1;
tmp=request.getParameter("state");
if(tmp!=null)
{
  state=Integer.parseInt(tmp);
  param.append("&state=").append(state);
}
if(state>0)
{
  sql.append(" AND step");
  if(state==1)
  {
    sql.append("!");
  }
  sql.append("=0");
}

String _strMember=request.getParameter("member");
String _strFrom=request.getParameter("from");
String _strTo=request.getParameter("to");
boolean _bMember=(_strMember!=null&&(_strMember=_strMember.trim()).length()>0);
boolean _bFrom=(_strFrom!=null&&(_strFrom=_strFrom.trim()).length()>0);
boolean _bTo=(_strTo!=null&&(_strTo=_strTo.trim()).length()>0);
if(_bMember||_bFrom||_bTo)
{
  sql.append(" AND flowbusiness IN ( SELECT flowbusiness FROM Flowview WHERE 1=1");
  if(_bMember)
  {
    sql.append(" AND ( transactor LIKE ").append(DbAdapter.cite("%"+_strMember+"%")).append(" OR consign LIKE ").append(DbAdapter.cite("%"+_strMember+"%")).append(")");
    param.append("&member=").append(java.net.URLEncoder.encode(_strMember,"UTF-8"));
  }
  if(_bFrom)
  {
    sql.append(" AND time >=").append(DbAdapter.cite(_strFrom));
    param.append("&from=").append(_strFrom);
  }
  if(_bTo)
  {
    sql.append(" AND time< ").append(DbAdapter.cite(_strTo));
    param.append("&to=").append(_strTo);
  }
  sql.append(")");
}

String act=request.getParameter("act");
if("excel".equals(act))//导出Excel
{
  response.setContentType("application/x-msdownload");
  response.setHeader("Content-Disposition", "attachment; filename=" +java.net.URLEncoder.encode("EXP.xls","UTF-8"));
  WritableWorkbook ww=jxl.Workbook.createWorkbook(response.getOutputStream());
  WritableCellFormat wcf = new WritableCellFormat(new WritableFont(WritableFont.TIMES,10,WritableFont.BOLD,false));
  wcf.setAlignment(jxl.format.Alignment.CENTRE);
  Enumeration ef=Flow.find(teasession._strCommunity,s1+s2);
  for(int i=1;ef.hasMoreElements();i++)
  {
    int fid=((Integer)ef.nextElement()).intValue();
    Flow f=Flow.find(fid);
    Dynamic d=Dynamic.find(f.getDynamic());
    int dtst=d.getDtst();
    Enumeration e3=Flowbusiness.findByCommunity(teasession._strCommunity," AND flow="+fid+sql.toString()+" ORDER BY flowbusiness DESC",0,Integer.MAX_VALUE);
    if(e3.hasMoreElements())
    {
      int count=Flowbusiness.countByCommunity(teasession._strCommunity," AND flow="+fid+sql.toString());
      WritableSheet ws=ww.createSheet(f.getName(teasession._nLanguage),i);
      Enumeration e4=DynamicType.findByDynamic(f.getDynamic()," AND export=1",0,Integer.MAX_VALUE);
      for(int j=0;e4.hasMoreElements();j++)
      {
        int dtid=((Integer)e4.nextElement()).intValue();
        DynamicType dt=DynamicType.find(dtid);
        ws.setColumnView(j,30);
        ws.addCell(new Label(j, 0,dt.getName(teasession._nLanguage),wcf));
      }
//      ws.setColumnView(0,30);
//      ws.setColumnView(1,20);
//      ws.setColumnView(2,30);
//      ws.setColumnView(3,30);
//      ws.setColumnView(4,30);
//      ws.addCell(new Label(0, 0, "事务名称",wcf));
//      ws.addCell(new Label(1, 0, "发起人",wcf));
//      ws.addCell(new Label(2, 0, "状态",wcf));
//      ws.addCell(new Label(3, 0, "期限",wcf));
//      ws.addCell(new Label(4, 0, "经办人",wcf));
      for(int j=1;e3.hasMoreElements();j++)
      {
        int flowbusiness=((Integer)e3.nextElement()).intValue();
//        Flowbusiness fb=Flowbusiness.find(flowbusiness);
//        int step=fb.getStep();
//        Flowprocess fp=Flowprocess.find(fb.getFlow(),step);
//        ws.addCell(new Label(0, j, fb.getName(teasession._nLanguage)));
//        ws.addCell(new Label(1, j, fb.getCreator()));
//        ws.addCell(new Label(2, j, fb.getStepToString(teasession._nLanguage)));
//        if(dtst>0)//期限
//        {
//          String dv_value=DynamicValue.find(-flowbusiness,teasession._nLanguage,dtst).getValue();
//          if(dv_value!=null)
//          {
//            ws.addCell(new Label(3, j, dv_value));
//          }
//        }
//        StringBuffer sbfv=new StringBuffer();
//        Enumeration e=Flowview.find(flowbusiness,fp.getFlowprocess());
//        while(e.hasMoreElements())
//        {
//          int flowview=((Integer)e.nextElement()).intValue();
//          Flowview fv2=Flowview.find(flowview);
//          sbfv.append(fv2.getTransactor()).append(": ").append(Flowbusiness.STATE_TYPE[fv2.getState()]).append("\r\n");
//        }
//        ws.addCell(new Label(4, j, sbfv.toString()));
          e4=DynamicType.findByDynamic(f.getDynamic()," AND export=1",0,Integer.MAX_VALUE);
          for(int col=0;e4.hasMoreElements();col++)
          {
            int dtid=((Integer)e4.nextElement()).intValue();
            DynamicValue dv=DynamicValue.find(-flowbusiness,teasession._nLanguage,dtid);
            ws.addCell(new Label(col, j,dv.getValue()));
          }
      }
    }
  }
  ww.write();
  ww.close();
  return;
}

//System.out.println(sql.toString());
//System.out.println(s1+s2);

%>
<!--
参数说明:
flow: 流程的ID,可支持多个,用逗号分隔.
creator: 发起人
subor: 0:路桥公司发文 1:下属单位发文
-->
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script>
function flow_view(flow,flowbusiness)
{
  window.showModalDialog("/jsp/admin/flow/Flowviews.jsp?community=<%=teasession._strCommunity%>&flow="+flow+"&flowbusiness="+flowbusiness,self,"dialogWidth:500px;dialogHeight:400px;help:0;status:0;resizable:1;");
}
function f_action(act)
{
  form1.act.value=act;
  form1.submit();
}
</script>
</head>
<body >
<h1>工作查询</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<BR>

<form name="form1" action="?">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="id" value="<%=id%>"/>
<input type="hidden" name="flowbusiness">
<input type="hidden" name="adminunitorg" value="<%=adminunitorg%>">
<input type="hidden" name="flow" value="<%if(flow!=null)out.print(flow);%>">
<input type="hidden" name="act">
<%
if(isCreator)out.print("<input type='hidden' name='creator' >");
%>
  <h2>查询</h2>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
    <%--
      <td>客户<select name="workproject" onChange="f_change(this.value);">
        <option value="">---------</option>
        <%
      StringBuffer sb=new StringBuffer();
      Enumeration e=Workproject.find(teasession._strCommunity,"",0,200);
      while(e.hasMoreElements())
      {
        int i=((Integer)e.nextElement()).intValue();
        out.print("<option value="+i);
        Workproject wp=Workproject.find(i);
        if(workproject==i)
        out.print(" SELECTED ");
        out.print(">"+wp.getName(teasession._nLanguage));

        sb.append("case ").append(i).append(":");
        Enumeration e2=Flowitem.findByWorkproject(i);
        while(e2.hasMoreElements())
        {
          int id2=((Integer)e2.nextElement()).intValue();
          Flowitem fi=Flowitem.find(id2);
          sb.append("op[op.length]=new Option('").append(fi.getName(teasession._nLanguage)).append("','").append(id2).append("');");
        }
        sb.append("break;\r\n");
      }

      sb.append("default:");
      Enumeration e2=Flowitem.find(teasession._strCommunity,"");
      while(e2.hasMoreElements())
      {
        int id2=((Integer)e2.nextElement()).intValue();
        Flowitem fi=Flowitem.find(id2);
        sb.append("op[op.length]=new Option('").append(fi.getName(teasession._nLanguage)).append("','").append(id2).append("');");
      }
      sb.append("break;\r\n");
      %>
        </select>
      </td>
      <td>项目<select name="flowitem">
          <option value="0">---------</option>
        </select>
      <script>
      function f_change(v)
      {
        var op=form1.flowitem.options;
        while(op.length>1)
        {
          op[1]=null;
        }
        switch(parseInt(v))
        {
          <%=sb.toString()%>
        }
      }
      f_change(form1.workproject.value);
      form1.flowitem.value="<%=flowitem%>";
      </script></td>
      --%>
      <td>日期：<input name="from" size="11" value="<%if(_bFrom)out.print(_strFrom);%>"><input onClick="showCalendar('form1.from')" type="button" value="" class="Calendar"> <input name="to" size="11" value="<%if(_bTo)out.print(_strTo);%>"><input onClick="showCalendar('form1.to')" type="button" value="" class="Calendar"></td>
      <%
      Enumeration e2=Flow.find(teasession._strCommunity, s1);
      if(e2.hasMoreElements())
      {
        out.print("<td>流程：<select name='flow2'><option value=''>---------</option>");
        while(e2.hasMoreElements())
        {
          int i=((Integer)e2.nextElement()).intValue();
          out.print("<option value="+i);
          if(flow2==i)
          out.print(" selected='' ");
          out.print(" >"+Flow.find(i).getName(teasession._nLanguage));
        }
        out.print("</select></td>");
      }
      %>
      <td>状态：<select name="state">
        <option value="0">---------</option>
        <option value="1" <%if(state==1)out.print("selected=''");%>>进行中</option>
        <option value="2" <%if(state==2)out.print("selected=''");%>>已结束</option>
        </select>
      </td>
      <td>保存期限：
      <%
      out.print("<select name='dynamictype45'><option value=''>---------</option>");
      DynamicType dt=DynamicType.find(45);
      if(dt.isExists())
      {
        StringTokenizer st = new StringTokenizer(dt.getContent(teasession._nLanguage), "/");
        while(st.hasMoreTokens())
        {
          String str = st.nextToken();
          out.print("<option value=\"" + str + "\"");
          if(str.equals(dt45))
          {
            out.print(" selected='true'");
          }
          out.print(">" + str);
        }
      }
      out.print("</select>");
      %>
      </td></tr>
      <tr>
      <td>是否受控：
      <%
      out.print("<select name='dynamictype46'><option value=''>---------</option>");
      dt=DynamicType.find(46);
      if(dt.isExists())
      {
        StringTokenizer st = new StringTokenizer(dt.getContent(teasession._nLanguage), "/");
        while(st.hasMoreTokens())
        {
          String str = st.nextToken();
          out.print("<option value=\"" + str + "\"");
          if(str.equals(dt46))
          {
            out.print(" selected='true'");
          }
          out.print(">" + str);
        }
      }
      out.print("</select>");
      %>
      </td>
      <td>办理人：<input style="width:80" name="member" value="<%if(_bMember)out.print(_strMember);%>"/></td>
        <td colspan="2"><input type="button" value="查询" onClick="f_action('go')"></td>
    </tr>
  </table>

<br>

<%
boolean none=true;
Enumeration ef=Flow.find(teasession._strCommunity,s1+s2);
for(int i=1;ef.hasMoreElements();i++)
{
  int fid=((Integer)ef.nextElement()).intValue();
  Flow f=Flow.find(fid);
  Dynamic d=Dynamic.find(f.getDynamic());
  int dtst=d.getDtst();
  int pos=0;
  tmp=request.getParameter("pos"+i);
  if(tmp!=null)
  {
    pos=Integer.parseInt(tmp);
  }
  Enumeration e3=Flowbusiness.findByCommunity(teasession._strCommunity," AND flow="+fid+sql.toString()+" ORDER BY flowbusiness DESC",pos,10);
  if(e3.hasMoreElements())
  {
    none=false;
    int count=Flowbusiness.countByCommunity(teasession._strCommunity," AND flow="+fid+sql.toString());
    out.print("<h2>"+f.getName(teasession._nLanguage)+"</h2>");
    out.print("<table border='0' cellpadding='0' cellspacing='0' id='tablecenter'>");
    out.print("<tr id='tableonetr'>");
    out.print("<td nowrap>序号</td>");
    out.print("<td nowrap>事务名称</td>");
    out.print("<td nowrap>发起人</td>");
    out.print("<td nowrap>状态</td>");
    if(dtst>0)out.print("<td nowrap>期限</td>");
    out.print("<td nowrap>经办人</td>");
    out.print("<td></td>");
    out.print("</tr>");
    for(int j=1;e3.hasMoreElements();j++)
    {
      int flowbusiness=((Integer)e3.nextElement()).intValue();
      Flowbusiness fb=Flowbusiness.find(flowbusiness);
      int step=fb.getStep();
      Flowprocess fp=Flowprocess.find(fb.getFlow(),step);
      //Flowitem fi=Flowitem.find(fb.getFlowitem());
      out.print("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>");
      out.print("<td align=center>"+j);
      out.print("<td nowrap><a href='/jsp/admin/flow/FlowbusinessView.jsp?community="+teasession._strCommunity+"&dynamic="+f.getDynamic()+"&flowbusiness="+flowbusiness+"' target='_blank' >"+fb.name+"</a></td>");
      //out.print("<td align="center" nowrap><%if(fi.getName(teasession._nLanguage)!=null && fi.getName(teasession._nLanguage).length()>0){out.print(fi.getName(teasession._nLanguage));}else{out.print("暂无项目");}% ></td>");
      out.print("<td align=center>"+fb.getCreator());
      out.print("<td align=center>"+fb.getStepToString(teasession._nLanguage));
      if(dtst>0)//期限
      {
        out.print("<td align=center>&nbsp;");
        String dv_value=DynamicValue.find(-flowbusiness,teasession._nLanguage,dtst).getValue();
        if(dv_value!=null)out.print(dv_value);
      }
      out.print("<td align=center>&nbsp;");
      Enumeration e=Flowview.find(flowbusiness,fp.getFlowprocess());
      while(e.hasMoreElements())
      {
        int flowview=((Integer)e.nextElement()).intValue();
        Flowview fv2=Flowview.find(flowview);
        out.print(fv2.getTransactor()+": "+Flowview.STATE_TYPE[fv2.getState()]+"<br>");
      }
      out.print("<td><input type=button value=流程图 onClick=flow_view("+fb.getFlow()+","+flowbusiness+");>");
      out.print("<input type=submit name=delete value=删除 onclick=\"if(confirm('确认删除')){form1.flowbusiness.value="+flowbusiness+";}else{return false;}\">");
    }
    out.print("</table>");
    out.print(new tea.htmlx.FPNL(teasession._nLanguage,param.toString()+"&pos"+i+"=",pos,count,10));
  }
}
if(none)
{
  out.print("<table border='0' cellpadding='0' cellspacing='0' id='tablecenter'>");
  out.print("<tr><td align='center'>"+"暂无记录"+"</td></tr>");
  out.print("</table>");
}
%>
<input type='button' onclick=f_action('excel'); value="<%=r.getString(teasession._nLanguage,"导出到Excel")%>"/>
</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>

</body>
</HTML>
