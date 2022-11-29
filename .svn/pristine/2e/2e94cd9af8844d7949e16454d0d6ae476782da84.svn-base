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


String[] TYPE={"待办事宜","待阅事宜","已办事宜"};

//ArrayList dest=new ArrayList();//待阅的事务

%>
<!--
参数说明:
flow: 流程的ID,可支持多个,用逗号分隔.

日期:2010-8-17
尚斌杰 9:02:48
待办事宜、待阅事宜、已办事宜，不要新闻了或放在不重要的位置
-->
<script src="/tea/mt.js"></script>
<script src="/jsp/admin/flow/flow.js"></script>
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
  for(var i=0;i<tc.length;i++){tc[i].style.display="none";}
  var ta=$name('a'+b);
  for(var i=0;i<tc.length;i++){ta[i].className="";}
  ta[a].className="sel";
  tc[a].style.display="";
}
</script>

<div class="qiehuan"><a href="javascript:f_swap(0)" name="a_swap" class="swap">事宜</a> <a href="javascript:f_swap(1)" name="a_swap">文件</a></div>
<div name="t_swap">
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
for(int i=0;i<3;i++)
{
  StringBuffer sql=new StringBuffer();
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
  sql.append(" ORDER BY flowbusiness DESC");

  Hashtable auoht=new Hashtable();
  StringBuilder auoh=new StringBuilder();

  out.print("<div class='Office'><div class=left>"+TYPE[i]+"</div><div class=right><a href='/jsp/admin/xny/IgFlowbusinessMore.jsp?flow="+p_flow+"'></a></div></div>");

  StringBuilder tth=new StringBuilder();
  Enumeration efb=Flowbusiness.findByCommunity(teasession._strCommunity,s1+sql.toString());
  for(int j=1,seq=0;seq<4&&efb.hasMoreElements();j++)
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
    seq++;
    fb01.append(",").append(flowbusiness);
    js.append("case ").append(flowbusiness).append(":");
    js.append("form_fb.dynamic.value=").append(f.getDynamic()).append(";");
    js.append("form_fb.flowbusiness.value=").append(flowbusiness).append(";");
    js.append("form_fb.flowprocess.value=").append(flowprocess).append(";");
    js.append("form_fb.flowitem.value=").append(fb.getFlowitem()).append(";");
    js.append("form_fb.flow.value=").append(fb.getFlow()).append(";");
    js.append("break;\r\n");
//    if(f.getDistProcess()==flowprocess&&i==1)//待阅事宜 如果 是分发 移到 待阅文件 中
//    {
//      dest.add(fb);
//      continue;
//    }
    StringBuilder line=new StringBuilder();
    //事务名称
    line.append("<li><a href='###' onClick=f_click("+flowbusiness+",'"+(i==2?"/jsp/admin/flow/FlowbusinessView":"/jsp/admin/xny/FlowbusinessEdit")+".jsp');form_fb.submit();>");
    line.append(MT.f(fb.name,"无")+"</a>");
    if(MT.f(fb.reason).length()>0)line.append("<font color='#999999'>[退回]</font>");
    //
    line.append("　发起人："+fb.getCreator());
    line.append("　"+fb.getFtimeToString()+"<br/>");
    /*
    line.append("<td nowrap>第"+step+"步");
    if(f.getType()!=1)//如果不是自由流程才显示，步骤名
    line.append(":"+fp.getName(teasession._nLanguage));
    //状态
    line.append("<td align=center nowrap>"+sb.toString());
    String v18=DynamicValue.find(-flowbusiness, teasession._nLanguage, 18).getValue();//缓急程度
    line.append(" 缓急程度:"+MT.f(v18,"无"));
    line.append("<td nowrap>");
    //可控流程 && 当前是分发步骤
    if(f.getType()==2 && flowprocess==f.getDistProcess() && manage)
    {
      line.append("<input type='button' class='butnext' value='补发' onclick=flow_point("+flowbusiness+","+flowprocess+")>");
    }
    if(submit)
    {
      line.append("<input type=submit value=办理 onClick=f_click("+flowbusiness+",'/jsp/admin/flow/EditFlowdynamicvalue.jsp');>");
    }else
    {
      line.append("<input type=submit value=查看 onClick=f_click("+flowbusiness+",'/jsp/admin/flow/FlowbusinessView.jsp');>");
    }
    if(manage)
    {
      line.append("<input type=button value=催办 onClick=\"window.open('/jsp/admin/flow/EditFlowReminder.jsp?community="+teasession._strCommunity+"&flowbusiness="+flowbusiness+"','','width=500,height=300,resizable=1'); \">");
    }
    if(!f.isHiddenConsign()&&member.equals(fv.getTransactor()))//有委托功能 && 是经办人.
    {
      String consign=fv.getConsign();
      if(consign!=null&&consign.length()>0)
      {
        line.append("<input type=submit name=recovery value=收回 onclick=\"if(confirm('确认收回委托?')){ f_click("+flowbusiness+",'/jsp/admin/flow/EditFlowbusinessConsign.jsp'); form_fb.method='post'; }else{ return false; }\">");
      }else
      {
        line.append("<input type=submit value=委托 onclick=f_click("+flowbusiness+",'/jsp/admin/flow/EditFlowbusinessConsign.jsp');>");
      }
    }
    line.append("<input type=button class='butview' value=流程图 onClick=flow_view("+fb.getFlow()+","+flowbusiness+");>");


    int last=Flowview.findLast(flowbusiness,flowprocess);
    if(last>0)//当前不是第一步
    {
      if(submit&&Flowview.count(flowbusiness,flowprocess)==1)//&&待办者不是多选
      {
        line.append("<input type=submit class='butback' value=回上一步 onclick=f_click("+flowbusiness+",'/jsp/admin/flow/EditFlowbusinessBack.jsp');>");
      }else //上步待办者不是多选
      {
        Flowview tmp_fv=Flowview.find(last);
        if(Flowview.count(flowbusiness,tmp_fv.getFlowprocess())==1&&(member.equals(tmp_fv.getTransactor())||member.equals(tmp_fv.getConsign())))
        {
          line.append("<input type=submit class='butcallback' name='callback' value=收回 onClick=f_click("+flowbusiness+",'/jsp/admin/flow/EditFlowbusinessBack.jsp');>");
        }
      }
    }
    //可控流程 && 当前是主控步骤
    if(f.getType()==2 && flowprocess==f.getMainProcess() && manage)
    {
      line.append("<input type='submit' class='butnext' value='管理"+f.getName(teasession._nLanguage)+"' onclick=f_click("+flowbusiness+",'/jsp/admin/flow/EditFlowbusinessNext.jsp');>");
    }else if(submit&&state>0)//未接收，不可传下一步
    {
      line.append("<input type='submit' class='butnext' value='传下一步' onclick=f_click("+flowbusiness+",'/jsp/admin/flow/EditFlowbusinessNext.jsp');>");
    }
    */
    //全部待办文件 股份公司 分子公司 其他公司  分类
    StringBuilder h=(StringBuilder)auoht.get(Integer.valueOf(fb.getAdminUnitOrg()));
    if(h==null){h=new StringBuilder();auoht.put(Integer.valueOf(fb.getAdminUnitOrg()),h);}
    h.append(line);
    auoh.append(line);
  }
  out.print("<h2 class='h2'><a href='###' name='at_fb_"+i+"' class='sel' onclick=\"flow_swap(0,'t_fb_"+i+"')\">全部"+TYPE[i].substring(0,2)+"文件</a> ");
  for(int j=0;j<auo.size();j++)
  {
    AdminUnitOrg o=(AdminUnitOrg)auo.get(j);
    out.print("<a href='###' name='at_fb_"+i+"' onclick=\"flow_swap("+(j+1)+",'t_fb_"+i+"')\">"+o.name+"</a> ");
  }
  out.print("</h2>");
  out.print("<div name='t_fb_"+i+"'>");
  out.print(tth.toString());
  out.print("<ul class='list'>");
  out.print(auoh.length()<1?"<li>暂无记录":auoh.toString());
  out.print("</ul></div>");
  for(int j=0;j<auo.size();j++)
  {
    out.print("<div name='t_fb_"+i+"' style='display:none'>");
    out.print(tth.toString());
    out.print("<ul class='list'>");
    AdminUnitOrg o=(AdminUnitOrg)auo.get(j);
    StringBuilder h=(StringBuilder)auoht.get(Integer.valueOf(o.adminunitorg));
    out.print(h==null?"<li>暂无记录":h.toString());
    out.print("</ul></div>");
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
</div>

<div name="t_swap" style="display:none">
<%
for(int i=0;i<3;i+=2)
{
  String url="/jsp/admin/xny/Flowreadings.jsp?community="+teasession._strCommunity+"&state="+i;
  out.println("<div class='Office'><div class=left>"+(i==0?"待阅":"阅毕")+"文件</div><div class=right><a href='"+url+"'></a></div></div><ul class='list'>");
  Iterator it=Flowreading.find(" AND member="+DbAdapter.cite(member)+" AND EXISTS(SELECT flowview FROM Flowview fv WHERE fv.flowview=fr.flowview AND state="+i+")",0,20).iterator();
  if(!it.hasNext())
  out.println("<li>暂无记录</li>");
  else while(it.hasNext())
  {
    Flowreading t=(Flowreading)it.next();
    Flowbusiness fb=Flowbusiness.find(t.flowbusiness);
    out.print("<li><a href='/jsp/admin/xny/FlowbusinessEdit.jsp?community="+teasession._strCommunity+"&flow="+fb.getFlow()+"&flowbusiness="+t.flowbusiness+"&flowview="+t.flowview+"&nexturl="+Http.enc(url)+"'>"+MT.f(t.name)+"</a>　"+MT.f(Flowview.find(t.flowview).getTime())+"</li>");
  }
  out.print("</ul>");
}
%>
</div>


