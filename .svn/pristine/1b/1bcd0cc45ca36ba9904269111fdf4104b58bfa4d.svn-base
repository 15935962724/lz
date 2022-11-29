<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.entity.site.*" %><%@page import="tea.entity.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");response.setHeader("Cache-Control", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


Resource r=new Resource();
String member=teasession._rv.toString();

String tmp;

int flow=0,flow2=0;

//flow:菜单中传递此参数////////////
String p_flow=request.getParameter("flow");


String s1=" AND ( flow IN (SELECT flow FROM Flowprocess WHERE member LIKE "+DbAdapter.cite("%/"+teasession._rv._strV+"/%")+"))";
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


ArrayList auo=AdminUnitOrg.find(" AND community="+DbAdapter.cite(teasession._strCommunity),0,100);


String[] TYPE={"待办事宜","待阅事宜","已办事宜","已中止流程"};

%>
<!--
参数说明:
flow: 流程的ID,可支持多个,用逗号分隔.

日期:2010-8-17
尚斌杰 9:02:48
待办事宜、待阅事宜、已办事宜，不要新闻了或放在不重要的位置
--><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<script src="/tea/mt.js"></script>
<script>
function flow_view(flow,flowbusiness)
{
  myleft=(screen.availWidth-500)/2;
  window.open("/jsp/admin/flow/Flowviews.jsp?community=<%=teasession._strCommunity%>&flow="+flow+"&flowbusiness="+flowbusiness,"flow_view","status=0,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes,width=500,height=350,left="+myleft+",top=200");
}
function flow_point(flowbusiness,flowprocess)
{
  myleft=(screen.availWidth-500)/2;
  window.open("/jsp/admin/flow/SetFlowviewPrint.jsp?community=<%=teasession._strCommunity%>&flowbusiness="+flowbusiness+"&flowprocess="+flowprocess,"_blank","status=0,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes,width=500,height=350,left="+myleft+",top=200");
}
function flow_swap(a,b)
{
  var tc=$name(b);
  for(var i=0;i<tc.length;i++)
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

<form name="form_fb" action="/jsp/admin/flow/EditFlowbusiness.jsp">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="flowitem" value="0">
<input type="hidden" name="flowbusiness" value="0">
<input type="hidden" name="flowprocess" value="0">
<input type="hidden" name="dynamic" value="0">
<input type="hidden" name="flow" value="<%=flow%>">
<input type="hidden" name="nexturl" value="<%=request.getRequestURI()+"?"+request.getQueryString()%>">
<%
StringBuffer js=new StringBuffer();
StringBuffer fb01=new StringBuffer();//待办事宜 和 待阅事宜 已经存在的 在 已办事宜 中不显示
for(int i=0;i<4;i++)
{
  StringBuffer sql=new StringBuffer();
  if(i==3)
  sql.append(" AND step<1 AND flowbusiness IN (SELECT flowbusiness FROM Flowview WHERE transactor="+DbAdapter.cite(member)+" AND flowview IN ( SELECT MIN(flowview) FROM Flowview GROUP BY flowbusiness) )");
  else
  {
    sql.append(" AND step>0 AND fb.flowbusiness IN( SELECT flowbusiness FROM Flowview f1 WHERE 1=0");
    if(i!=2)
    {
      //{member}可以办理的事务//
      sql.append(" OR (state<2 AND(transactor="+DbAdapter.cite(member)+" OR consign="+DbAdapter.cite(member)+") AND EXISTS(SELECT * FROM (SELECT flowbusiness,MAX(step) AS step FROM Flowview WHERE flowprocess!=0 GROUP BY flowbusiness) AS f2 WHERE f1.flowbusiness=f2.flowbusiness AND f1.step=f2.step)           )");
    }
    if(i==2)
    {
      //可控流程///控制流程转向///
      sql.append(" OR (flowview IN(SELECT MIN(flowview) FROM Flowview GROUP BY flowbusiness) AND transactor="+DbAdapter.cite(member)+")");//发起人
      sql.append(" OR (flowview IN(SELECT MAX(fv.flowview) FROM Flowview fv INNER JOIN Flow f ON fv.flowprocess=f.mainprocess WHERE f.type=2 GROUP BY fv.flowbusiness) AND (transactor="+DbAdapter.cite(member)+" OR consign="+DbAdapter.cite(member)+") )");//主控人员
      //倒数第二步是{member}办理&&倒数第二步是一个人//最后一步无人办理
      sql.append(" OR (flowview IN(SELECT fv.flowview FROM Flowview fv INNER JOIN (SELECT flowbusiness,MAX(step)-1 step FROM Flowview WHERE flowprocess>0 GROUP BY flowbusiness) ff ON fv.flowbusiness=ff.flowbusiness AND fv.step=ff.step WHERE "+DbAdapter.cite(member)+" IN (transactor,consign) AND (SELECT COUNT(*) FROM Flowview WHERE flowbusiness=ff.flowbusiness AND step=ff.step)=1 ))");//fv.flowbusiness NOT IN (SELECT flowbusiness FROM Flowview WHERE state!=0 AND step=ff.step)
    }
    sql.append(")");
    if(i==2)sql.append(" AND fb.flowbusiness NOT IN(0"+fb01.toString()+")");
  }
  sql.append(" ORDER BY flowbusiness DESC");

  Hashtable auoht=new Hashtable();
  StringBuilder auoh=new StringBuilder();

  out.print("<div class='Office'><div class=left>"+TYPE[i]+"</div></div>");
  StringBuilder tth=new StringBuilder();

  Enumeration efb=Flowbusiness.findByCommunity(teasession._strCommunity,s1+sql.toString(),0,20);
  for(int j=1;efb.hasMoreElements();j++)
  {
    int flowbusiness=((Integer)efb.nextElement()).intValue();
    Flowbusiness fb=Flowbusiness.find(flowbusiness);
    flow=fb.getFlow();
    int step=fb.getStep();
    Flow f=Flow.find(flow);
    Flowprocess fp=Flowprocess.find(fb.getFlow(),step);
    int flowprocess=fp.getFlowprocess();
    Flowview fv=Flowview.find(flowbusiness,flowprocess,member);
    int state=fv.getState();
    boolean manage=f.getType()==2 &&(member.equals(fb.getMainTransactor()) || member.equals(fb.getMainConsign()));
    boolean creator=member.equals(fb.getCreator())||!fv.isExists();
    boolean submit=!manage&&!creator;//是否有权办理/管理者默认没有办理权限////
    //状态//
    StringBuffer sb=new StringBuffer();
    if(manage||creator)
    {
      Enumeration e=Flowview.find(flowbusiness,flowprocess);
      while(e.hasMoreElements())
      {
        int flowview=((Integer)e.nextElement()).intValue();
        Flowview fv2=Flowview.find(flowview);
        sb.append(fv2.getTransactor()+": "+Flowview.STATE_TYPE[fv2.getState()]+"<br>");
        if(!submit)
        {
          submit=member.equals(fv2.getTransactor())||member.equals(fv2.getConsign());
        }
      }
    }else
    {
      sb.append(Flowview.STATE_TYPE[state]);
    }
    //if(submit&&i==1||!submit&&i==0)continue;
    if(i==0&&state!=1||i==1&&state!=0)continue;
    fb01.append(",").append(flowbusiness);
    js.append("case ").append(flowbusiness).append(":");
    js.append("form_fb.dynamic.value=").append(f.getDynamic()).append(";");
    js.append("form_fb.flowbusiness.value=").append(flowbusiness).append(";");
    js.append("form_fb.flowprocess.value=").append(flowprocess).append(";");
    js.append("form_fb.flowitem.value=").append(fb.getFlowitem()).append(";");
    js.append("form_fb.flow.value=").append(fb.getFlow()).append(";");
    js.append("break;\r\n");
    StringBuilder line=new StringBuilder();
    line.append("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>");
    line.append("<td width=20 align=center>"+j);
    //事务名称
    line.append("<td nowrap>");
    {
      line.append("<a href='###' onClick=f_click("+flowbusiness+",'"+(i==2||i==3?"/jsp/admin/flow/FlowbusinessView":"/jsp/admin/xny/FlowbusinessEdit")+".jsp');form_fb.submit();>");
    }
    line.append(MT.f(fb.name,"无")+"</a>");
    if(MT.f(fb.reason).length()>0)line.append("<font color='#999999'>[退回]</font>");
    //

    line.append("<td nowrap>发起人："+fb.getCreator());
    line.append("<td nowrap>"+fb.getFtimeToString());
    //if(i==3)line.append("<td><input type=submit value='删除' onclick=\"return confirm('确认删除吗？')&&f_click("+flowbusiness+",'/servlet/EditFlowdynamicvalue?act=delete');\">");

    //全部待办文件 股份公司 分子公司 其他公司  分类
    StringBuilder h=(StringBuilder)auoht.get(Integer.valueOf(fb.getAdminUnitOrg()));
    if(h==null){h=new StringBuilder();auoht.put(Integer.valueOf(fb.getAdminUnitOrg()),h);}
    h.append(line);
    auoh.append(line);
  }
  out.print("<h2><a href=\"javascript:flow_swap(0,'t_fb_"+i+"')\">全部"+TYPE[i].substring(0,2)+"文件</a> ");
  for(int j=0;j<auo.size();j++)
  {
    AdminUnitOrg o=(AdminUnitOrg)auo.get(j);
    out.print("<a href=\"javascript:flow_swap("+(j+1)+",'t_fb_"+i+"')\">"+o.name+"</a> ");
  }
  out.print("</h2>");
  out.print("<table name='t_fb_"+i+"' border='0' cellpadding='0' cellspacing='0' id='tablecenter'>");
  out.print(tth.toString());
  out.print(auoh.length()<1?"<tr><td colspan='5' align='center'>暂无记录":auoh.toString());
  out.print("</table>");
  for(int j=0;j<auo.size();j++)
  {
    out.print("<table name='t_fb_"+i+"' border='0' cellpadding='0' cellspacing='0' id='tablecenter' style='display:none'>");
    out.print(tth.toString());
    AdminUnitOrg o=(AdminUnitOrg)auo.get(j);
    StringBuilder h=(StringBuilder)auoht.get(Integer.valueOf(o.adminunitorg));
    out.print(h==null?"<tr><td colspan='5' align='center'>暂无记录":h.toString());
    out.print("</table>");
  }
}

%>
<script>
function f_click(i,url)
{
  switch(i)
  {
    <%=js.toString()%>
  }
  if(url)
  {
    form_fb.action=url;
    if(url.indexOf("?")!=-1)
    {
      form_fb.method="post";
    }
  }
}
</script>
</form>
