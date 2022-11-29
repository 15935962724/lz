<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter"%><%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.admin.*" %><%@page import="tea.entity.member.*" %>
<%@page import="tea.entity.site.*" %><%@page import="tea.entity.*" %>
<%@page import="tea.entity.node.*" %><%@page import="java.util.*" %><%@page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");
response.setHeader("Cache-Control", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Http h=new Http(request);
Resource r=new Resource();
String member=teasession._rv.toString();

//flow:菜单中传递此参数////////////
String p_flow=request.getParameter("flow");
boolean head=h.getBool("head");

String fsql=p_flow==null?"":" AND flow IN ("+p_flow+")";


StringBuilder ids=new StringBuilder();
ids.append(" flowbusiness IN(");
Enumeration eid=Flowbusiness.findByCommunity(teasession._strCommunity,fsql+" AND step>0");
while(eid.hasMoreElements())
{
  ids.append(((Integer)eid.nextElement()).intValue()).append(",");
}
ids.append("0)");
//ids.setCharAt(ids.length()-1,')');
//ids.append(" 1=1");






StringBuffer sql=new StringBuffer();
sql.append(" AND step>0 AND fb.flowbusiness IN( SELECT flowbusiness FROM Flowview f1 WHERE ");
//{member}可以办理的事务//
sql.append(" (state<2 AND(transactor="+DbAdapter.cite(member)+" OR consign="+DbAdapter.cite(member)+") AND EXISTS(SELECT * FROM (SELECT flowbusiness,MAX(step) AS step FROM Flowview WHERE "+ids.toString()+" AND flowprocess!=0 GROUP BY flowbusiness) AS f2 WHERE f1.flowbusiness=f2.flowbusiness AND f1.step=f2.step)           )");
//可控流程///控制流程转向///
sql.append(" OR (flowview IN(SELECT MIN(flowview) FROM Flowview WHERE "+ids.toString()+" GROUP BY flowbusiness) AND transactor="+DbAdapter.cite(member)+")");//发起人
sql.append(" OR (flowview IN(SELECT MAX(fv.flowview) FROM Flowview fv INNER JOIN Flow f ON fv.flowprocess=f.mainprocess WHERE "+ids.toString()+" AND f.type=2 GROUP BY fv.flowbusiness) AND (transactor="+DbAdapter.cite(member)+" OR consign="+DbAdapter.cite(member)+") )");//主控人员
//倒数第二步是{member}办理&&倒数第二步是一个人//最后一步无人办理
sql.append(" OR (flowview IN(SELECT fv.flowview FROM Flowview fv INNER JOIN (SELECT flowbusiness,MAX(step)-1 step FROM Flowview WHERE "+ids.toString()+" AND flowprocess>0 GROUP BY flowbusiness) ff ON fv.flowbusiness=ff.flowbusiness AND fv.step=ff.step WHERE "+DbAdapter.cite(member)+" IN (transactor,consign) AND (SELECT COUNT(*) FROM Flowview WHERE "+ids.toString()+" AND flowbusiness=ff.flowbusiness AND step=ff.step)=1 ))");//fv.flowbusiness NOT IN (SELECT flowbusiness FROM Flowview WHERE state!=0 AND step=ff.step)
sql.append(")");


String tmp;

int flow=0,flow2=0;


//if(flow>0)
//{
//  sql.append(" AND flow=").append(flow);
//}else
//{
//  tmp=request.getParameter("flow2");
//  if(tmp!=null&&tmp.length()>0)
//  {
//    flow2=Integer.parseInt(tmp);
//    sql.append(" AND flow=").append(flow2);
//  }
//}

String name=request.getParameter("name");
if(name!=null&&name.length()>0)
{
  sql.append(" AND(");
  //sql.append(" flow IN (SELECT flowbusiness FROM FlowbusinessLayer WHERE name LIKE ").append(DbAdapter.cite("%"+name+"%")+") OR ");
  sql.append(" EXISTS (SELECT fp.flow FROM Flowprocess fp INNER JOIN FlowprocessLayer fpl ON fp.flowprocess=fpl.flowprocess WHERE fb.flow=fp.flow AND fb.step=fp.step AND fpl.name LIKE ").append(DbAdapter.cite("%"+name+"%")+")");
  sql.append(")");
}

int flowitem=0;
String _strFlowitem=request.getParameter("flowitem");
if(_strFlowitem!=null&&_strFlowitem.length()>0)
{
  flowitem=Integer.parseInt(_strFlowitem);
  sql.append(" AND flowitem="+flowitem);
}
sql.append(" ORDER BY flowbusiness DESC");

//int state=-1;
//tmp=request.getParameter("state");
//if(tmp!=null&&tmp.length()>0)
//{
//  state=Integer.parseInt(tmp);
//}

String s1=" AND (type=1 OR flow IN (SELECT flow FROM Flowprocess WHERE member LIKE "+DbAdapter.cite("%/"+teasession._rv._strV+"/%")+"))";
//创建按钮: (自由流程 OR 只有在第一步中出现的经办人可以了创建)
String s2=" AND prev=0 AND (type=1 OR flow IN (SELECT flow FROM Flowprocess WHERE step=1 AND member LIKE "+DbAdapter.cite("%/"+teasession._rv._strV+"/%")+") )";
//创建按钮_非顶级流程:
String s3=" AND nextflow>0 AND (nextflow IN (SELECT flow FROM Flow WHERE type=1) OR nextflow IN (SELECT flow FROM Flowprocess WHERE step=1 AND member LIKE "+DbAdapter.cite("%/"+teasession._rv._strV+"/%")+") )";
if(p_flow!=null)
{
  s1=" AND flow IN ("+p_flow+")"+s1;
  s2=" AND flow IN ("+p_flow+")"+s2;
  s3=" AND nextflow IN ("+p_flow+")"+s3;
}



//System.out.println("SELECT * FROM Flowbusiness fb WHERE 1=1"+sql.toString());


ArrayList auo=AdminUnitOrg.find(" AND community="+DbAdapter.cite(teasession._strCommunity),0,100);



%>
<!--
参数说明:
flow: 流程的ID,可支持多个,用逗号分隔.
-->
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
function flow_view(flow,flowbusiness)
{
  window.showModalDialog("/jsp/admin/flow/Flowviews.jsp?community=<%=teasession._strCommunity%>&flow="+flow+"&flowbusiness="+flowbusiness,self,"dialogWidth:500px;dialogHeight:400px;help:0;status:0;resizable:1;");
}
function flow_point(flowbusiness,flowprocess)
{
  myleft=(screen.availWidth-500)/2;
  window.open("/jsp/admin/flow/SetFlowviewPrint.jsp?community=<%=teasession._strCommunity%>&flowbusiness="+flowbusiness+"&flowprocess="+flowprocess,"_blank","status=0,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes,width=500,height=350,left="+myleft+",top=200");
}
function flow_swap(a)
{
  var tc=document.all('tablecenter');
  if(!tc.length)tc=new Array(tc);
  for(var i=0;i<tc.length-1;i++)
  {
    tc[i].style.display="none";
  }
  tc[a].style.display="";
}
</script>
</head>
<body>

<h1>我的工作</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<%--
<h2>查询</h2>
<form name=foEdit action="<%=request.getRequestURI()%>" >
  <input type=hidden name="community" value="<%=teasession._strCommunity%>">
  <input type=hidden name="flow" value="<%=flow%>">
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td>名称
        <input name="name" value="<%if(name!=null)out.print(name);%>"></td>
        <%
        if(flow==0)
        {
          out.print("<td>流程<select name='flow2'><option value=''>-------------");
          Enumeration enumer_flow=Flow.find(teasession._strCommunity,"");
          while(enumer_flow.hasMoreElements())
          {
            int flow_id=((Integer)enumer_flow.nextElement()).intValue();
            out.print("<option value="+flow_id);
            if(flow2==flow_id)
            {
              out.println(" SELECTED ");
            }
            out.println(" >"+Flow.find(flow_id).getName(teasession._nLanguage));
          }
          out.print("</select></td>");
        }%>
        <td>项目
          <select name="flowitem">
            <option value="">---------
           <%
           java.util.Enumeration enumer_fi=Flowitem.find(teasession._strCommunity,"");
           while(enumer_fi.hasMoreElements())
           {
             int id=((Integer)enumer_fi.nextElement()).intValue();
             out.print("<option value="+id);
             if(id==flowitem)
             out.println(" SELECTED ");
             out.println(" >"+Flowitem.find(id).getName(teasession._nLanguage));
           }
           %></select></td>
          <td>状态
         <select name="state">
           <option value="">------------
           <option value="0" <%if(state==0)out.print(" selected ");%>>--未接收--
           <option value="1" <%if(state==1)out.print(" selected ");%>>--已接收--
         </select></td>
         <td><input type="submit" value="查询"/></td></tr>
</table>
</form>
--%>




<form name="form1" action="/jsp/admin/flow/EditFlowbusiness.jsp">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="flowitem" value="<%=flowitem%>">
<input type="hidden" name="flowbusiness" value="0">
<input type="hidden" name="flowprocess" value="0">
<input type="hidden" name="dynamic" value="0">
<input type="hidden" name="flow" value="<%=flow%>">
<input type="hidden" name="nexturl" value="<%=request.getRequestURI()+"?"+request.getQueryString()%>">
<input type="hidden" name="dir" value="cec">
<%
boolean none=true;
StringBuffer js=new StringBuffer();

  Hashtable auoht=new Hashtable();
  StringBuilder auoh=new StringBuilder();

  //列表////
  Enumeration efb=Flowbusiness.findByCommunity(teasession._strCommunity,(p_flow!=null?" AND flow IN("+ p_flow+")":"") + sql.toString());
  if(efb.hasMoreElements())
  {
    none=false;
    boolean th=false;//隐藏标题
    StringBuilder tth=new StringBuilder();
    tth.append("<tr id='tableonetr'>");
    tth.append("<td nowrap>序号</td>");
    tth.append("<td nowrap>事务名称</td>");
    tth.append("<td nowrap>发起人</td>");
    tth.append("<td nowrap>步骤</td>");
    tth.append("<td nowrap>状态</td>");
    tth.append("<td nowrap>操作</td></tr>");
    for(int j=1;efb.hasMoreElements();j++)
    {
      int flowbusiness=((Integer)efb.nextElement()).intValue();
      Flowbusiness fb=Flowbusiness.find(flowbusiness);
      Flow f=Flow.find(fb.getFlow());
      int step=fb.getStep();
      Flowprocess fp=Flowprocess.find(fb.getFlow(),step);
      int flowprocess=fp.getFlowprocess();
      Flowview fv=Flowview.find(flowbusiness,flowprocess,member);
      int state=fv.getState();

      boolean manage=f.getType()==2&&member.equals(MT.f(fb.getMainConsign(),fb.getMainTransactor()));
      boolean creator=member.equals(fb.getCreator())||!fv.isExists();
      boolean submit=!manage&&!creator&&state!=3;//是否有权办理/管理者默认没有办理权限////
      th=th||manage||creator;
      //状态//
      StringBuffer sb=new StringBuffer();
      if(manage||creator)
      {
        Enumeration e=Flowview.find(flowbusiness,flowprocess);
        while(e.hasMoreElements())
        {
          int flowview=((Integer)e.nextElement()).intValue();
          Flowview fv2=Flowview.find(flowview);

          sb.append(fv2.getTransactor());
          if(MT.e(fv2.getConsign()))sb.append("<font color='red'>委托</font>"+fv2.getConsign());
          sb.append(": "+Flowview.STATE_TYPE[fv2.getState()]+"<br>");
          if(!submit)
          {
            submit=member.equals(MT.f(fv2.getConsign(),fv2.getTransactor()));//如果存在'委托',就判断当前会员是否是委托人员
          }
        }
      }else
      {
        sb.append(Flowview.STATE_TYPE[state]);
      }
      js.append("case ").append(j).append(":");
      js.append("form1.dynamic.value=").append(f.getDynamic()).append(";");
      js.append("form1.flowbusiness.value=").append(flowbusiness).append(";");
      js.append("form1.flowprocess.value=").append(flowprocess).append(";");
      js.append("form1.flowitem.value=").append(fb.getFlowitem()).append(";");
      js.append("form1.flow.value=").append(fb.getFlow()).append(";");
      js.append("break;\r\n");
      StringBuilder line=new StringBuilder();
      line.append("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>");
      line.append("<td width=20 align=center>"+j);
      //事务名称
      line.append("<td nowrap>");
      if(submit)
      {
        line.append("<a href='###' onClick=f_click("+j+",'/jsp/admin/cec/FlowbusinessEdit.jsp');form1.submit();>");
      }
      //line.append(fb.getFlow()+"、");
      line.append(MT.f(fb.name,"无")+"</a>");
      if(MT.f(fb.reason).length()>0)line.append("<font color='#999999'>[退回]</font>");
      //
      line.append("<td nowrap>"+fb.getCreator());
      line.append("<td nowrap>第"+step+"步");
      if(f.getType()!=1)//如果不是自由流程才显示，步骤名
      {
        line.append(":"+fp.getName(teasession._nLanguage));
      }
      //状态
      line.append("<td align=center nowrap>"+sb.toString());
      //String v18=DynamicValue.find(-flowbusiness, teasession._nLanguage, 18).getValue();//缓急程度
      //line.append(" 缓急程度:"+MT.f(v18,"无"));
      line.append("<td nowrap>");
      //可控流程 && 当前是分发步骤
      if(f.getType()==2 && flowprocess==f.getDistProcess() && manage)
      {
        line.append("<input type='button' class='butnext' value='补发' onclick=flow_point("+flowbusiness+","+flowprocess+")>");
      }
      if(submit)
      {
        line.append("<input type=submit value=办理 onClick=f_click("+j+",'/jsp/admin/cec/FlowbusinessEdit.jsp');>");
      }else
      {
        line.append("<input type=submit value=查看 onClick=f_click("+j+",'/jsp/admin/flow/FlowbusinessView.jsp');>");
      }
      if(manage&&!submit)
      {
        line.append("<input type=button value=催办 onClick=\"window.showModalDialog('/jsp/admin/flow/EditFlowReminder.jsp?community="+teasession._strCommunity+"&flowbusiness="+flowbusiness+"',self,'dialogWidth=500px;dialogHeight=300px;help:0;status:0;resizable=1'); \">");
      }
      if(!f.isHiddenConsign()&&member.equals(fv.getTransactor())&&state!=3)//有委托功能 && 是经办人.
      {
        String consign=fv.getConsign();
        if(consign!=null&&consign.length()>0)
        {
          line.append("<input type=submit name=recovery value=收回 onclick=\"if(confirm('确认收回委托?')){ f_click("+j+",'/jsp/admin/flow/EditFlowbusinessConsign.jsp'); form1.method='post'; }else{ return false; }\">");
        }else if(fp.getMember().split("/").length>2)//有被委托人,才显示按钮
        {
          line.append("<input type=submit value=委托 onclick=f_click("+j+",'/jsp/admin/flow/EditFlowbusinessConsign.jsp');>");
        }
      }
      line.append("<input type=button class='butview' value=流程图 onClick=flow_view("+fb.getFlow()+","+flowbusiness+");>");
      if(state!=3)
      {
        int last=Flowview.findLast(flowbusiness,flowprocess);
        if(last>0)//当前不是第一步
        {
          if(submit&&Flowview.count(flowbusiness,flowprocess)==1)//&&待办者不是多选
          {
            line.append("<input type=submit class='butback' value=回上一步 onclick=f_click("+j+",'/jsp/admin/flow/EditFlowbusinessBack.jsp');>");
          }else //上步待办者不是多选
          {
            Flowview tmp_fv=Flowview.find(last);
            if(Flowview.count(flowbusiness,tmp_fv.getFlowprocess())==1&&(member.equals(tmp_fv.getTransactor())||member.equals(tmp_fv.getConsign())))
            {
              line.append("<input type=submit class='butcallback' name='callback' value=收回 onClick=f_click("+j+",'/jsp/admin/flow/EditFlowbusinessBack.jsp');>");
            }
          }
        }else
        {
          line.append("<input type=submit value='撤销' onclick=\"return confirm('确认撤销吗？')&&f_click("+j+",'/servlet/EditFlowdynamicvalue?act=delete');\">");
        }
      }
      //可控流程 && 当前是主控步骤
      if(f.getType()==2 && flowprocess==f.getMainProcess() && manage)
      {
        line.append("<input type='submit' class='butnext' value='管理"+f.getName(teasession._nLanguage)+"' onclick=f_click("+j+",'/jsp/admin/cec/EditFlowbusinessNext.jsp');>");
      }else if(submit&&state>0)//未接收，不可传下一步
      {
        line.append("<input type='submit' class='butnext' value='传下一步' onclick=f_click("+j+",'/jsp/admin/cec/EditFlowbusinessNext.jsp');>");
      }
      //
      StringBuilder h2=(StringBuilder)auoht.get(Integer.valueOf(fb.getAdminUnitOrg()));
      if(h2==null){h2=new StringBuilder();auoht.put(Integer.valueOf(fb.getAdminUnitOrg()),h2);}
      h2.append(line);
      auoh.append(line);
    }
    out.print("<h2><a href='javascript:flow_swap(0)'>全部待办文件</a> ");
    for(int j=0;j<auo.size();j++)
    {
      AdminUnitOrg o=(AdminUnitOrg)auo.get(j);
      out.print("<a href='javascript:flow_swap("+(j+1)+")'>"+o.name+"</a> ");
    }
    out.print("</h2>");
    out.print("<table border='0' cellpadding='0' cellspacing='0' id='tablecenter'>");
    out.print(tth.toString());
    out.print(auoh==null?"<tr><td colspan='5' align='center'>暂无记录":auoh.toString());
    out.print("</table>");
    for(int j=0;j<auo.size();j++)
    {
      out.print("<table border='0' cellpadding='0' cellspacing='0' id='tablecenter' style='display:none'>");
      out.print(tth.toString());
      AdminUnitOrg o=(AdminUnitOrg)auo.get(j);
      StringBuilder h2=(StringBuilder)auoht.get(Integer.valueOf(o.adminunitorg));
      out.print(h2==null?"<tr><td colspan='5' align='center'>暂无记录":h2.toString());
      out.print("</table>");
    }
    /*
    if(!th&&(p_flow!=null&&p_flow.indexOf(',')==-1))
    {
    %>
    <script>
    var ts=document.getElementsByTagName('TABLE');
    for(var t=0;t<ts.length;t++)
    {
      trs=ts[t].rows;
      trs[0].style.display='none';
      var rx=0,ry=0;
      for(var i=1;i<trs.length-ry;i++)
      {
        var tds=trs[i].childNodes;
        for(var j=2;j<tds.length;j++)
        {
          tds[j].style.display='none';
        }
        if(tds[4].innerHTML=="已办理")//把 未办理  和 已办理 分开
        {
          ts[t].moveRow(i--,trs.length-1);
          tds[0].innerHTML=++ry;
        }else
        {
          tds[0].innerHTML=++rx;
        }
      }
      if(rx>0)
      {
        var ir=ts[t].insertRow(1);
        ir.className="tableonetr";
        ir.insertCell();
        var ic=ir.insertCell();
        ic.innerHTML="<b>未办理</b>";
        rx++;
      }
      if(ry>0)
      {
        var ir=ts[t].insertRow(rx+1);
        ir.className="tableonetr";
        ir.insertCell();
        var ic=ir.insertCell();
        ic.innerHTML="<b>未发送</b>";
      }
    }
    </script>
    <%
    }*/
  }

if(none)
{
  out.print("<table border='0' cellpadding='0' cellspacing='0' id='tablecenter'>");
  out.print("<tr><td height=100 colspan=10 align=center>您暂无待办工作</td></tr>");
  out.print("</table>");
}

//创建工作铵钮
p_flow="";
Enumeration ef=Flow.find(teasession._strCommunity,s2+" AND flow NOT IN(11,12,13,14)");
while(ef.hasMoreElements())
{
  flow=((Integer)ef.nextElement()).intValue();
  if(p_flow.length()>0)p_flow+=",";
  p_flow+=flow;
}
if(p_flow.length()>0)
{
  out.print("<h2>创建工作列表</h2>");
  out.print("<table border='0' cellpadding='0' cellspacing='0' id='tablecenter'>");
  out.print("<tr><td><input type='button' value='拟稿人拟稿' onclick='f_sel()' />");
  out.print("</table>");
}

%>
</form>

<script>
function f_sel()
{
  var rflow="<%=p_flow%>";
  if(rflow.indexOf(',')!=-1)rflow=window.showModalDialog('/jsp/admin/cec/FlowSel.jsp?community=<%=teasession._strCommunity%>&flow=<%=p_flow%>&t='+new Date().getTime(),self,'dialogWidth:400px;dialogHeight:320px;help:0;status:0;scroll:0;');
  if(!rflow)return;
  location.href="/jsp/admin/cec/FlowbusinessEdit.jsp?flow="+rflow+"&nexturl="+encodeURIComponent(location.pathname+location.search);
}
function f_click(i,url)
{
  switch(i)
  {
    <%=js.toString()%>
  }
  if(url)
  {
    form1.action=url;
    if(url.indexOf("?")!=-1)
    {
      form1.method="post";
    }
  }
}
</script>


<br>
<div id="head6"><img height="6" src="about:blank" ></div>
</body></html>
