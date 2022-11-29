<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.entity.site.*" %><%@ page import="tea.entity.confab.*" %><%@ page  import="tea.resource.Resource" %><%@ page import="java.util.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=request.getParameter("community");

Resource r=new Resource();

String nexturl=request.getParameter("nexturl");
if(nexturl==null)
nexturl=request.getRequestURI()+"?"+request.getQueryString();

int type=0;
if(request.getParameter("type")!=null)
type=Integer.parseInt(request.getParameter("type"));


Confabreception cr_obj=Confabreception.find(teasession._nNode,teasession._nLanguage);
Confabhostel ch_obj=Confabhostel.find(teasession._nNode,teasession._nLanguage);
Node node_obj=Node.find(teasession._nNode);
Dynamic d_obj=Dynamic.find(node_obj.getType());


%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1><%if(type>0)out.print(Dynamic.find(type).getName(teasession._nLanguage));%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>会员ID</td>
    <td><%=node_obj.getCreator()%></td>
  </tr>
  <tr>
    <td>编号</td>
    <td><A href="/jsp/type/dynamicvalue/DynamicValueViewTab.jsp?node=<%=teasession._nNode%>" ><%=d_obj.getType()+"-"+teasession._nNode%></A>
    <%--
    java.util.Enumeration enumer_code=DynamicType.findByDynamic(node_obj.getType(),"code");
    if(enumer_code.hasMoreElements())
    {
      int dt_id=((Integer)enumer_code.nextElement()).intValue();
      //DynamicType dt=DynamicType.find(dt_id)
      DynamicValue dv=DynamicValue.find(teasession._nNode,teasession._nLanguage,dt_id);
      String code=dv.getValue();
      if(code==null||code.length()<1)
      out.print("<input type=button onclick=\" window.open('/jsp/confab/EditConfabDynamicValue.jsp?community="+community+"&node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8")+"','_self'); \" value=编辑 >");
    }
    --%>
</td>
  </tr>
</table>

<DIV id="Confabreception">
<br>
<h2>接待安排</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>接待人:</td>
    <td><%if(cr_obj.getDest()!=null)out.print(cr_obj.getDest());%></td>
  </tr>
  <tr>
    <td>车次航班:</td>
    <td><%if(cr_obj.getFlight()!=null)out.print(cr_obj.getFlight());%></td>
  </tr>
  <tr>
    <td>人数:</td>
    <td><%if(cr_obj.getTime()!=null)out.print(cr_obj.getHuman());%></td>
  </tr>
  <tr>
    <td>时间:</td>
    <td>
    <%
    if(cr_obj.getTime()!=null)
    {
      java.text.SimpleDateFormat sdf=new java.text.SimpleDateFormat("yyyy年 MM月 dd日 HH时 mm分");
      out.print(sdf.format(cr_obj.getTime()));
    }
    %>
    </td>
  </tr>
</table>
</DIV>

<DIV id="Confabhostel">
<br>
<h2>住宿安排</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>联系人:</td>
    <td><%if(ch_obj.getLinkman()!=null)out.print(ch_obj.getLinkman());%></td>
  </tr>
  <tr>
    <td>住宿酒店:</td>
    <td><%if(ch_obj.getCabaret()!=null)out.print(ch_obj.getCabaret());%></td>
  </tr>
  <tr>
    <td>房间号:</td>
    <td><%if(ch_obj.getRoots()!=null)out.print(ch_obj.getRoots());%></td>
  </tr>
  <tr>
    <td>信宿人数:</td>
    <td><%if(ch_obj.getTime1()!=null)out.print(ch_obj.getHuman());%></td>
  </tr>
  <tr>
    <td>信宿天数:</td>
    <td><%if(ch_obj.getTime1()!=null)out.print(ch_obj.getDays());%></td>
  </tr>
  <tr>
    <td>信宿费用:</td>
    <td><%if(ch_obj.getOutlay()!=null)out.print(ch_obj.getOutlay());%></td>
  </tr>
  <tr>
    <td>时间:</td>
    <td><%
    if(ch_obj.getTime1()!=null&&ch_obj.getTime2()!=null)
    {
      java.text.SimpleDateFormat sdf=new java.text.SimpleDateFormat("yyyy年 MM月 dd日");
      out.print(sdf.format(ch_obj.getTime1())+" - "+sdf.format(ch_obj.getTime2()));
    }
    %>
    </td>
  </tr>
</table>
</DIV>


<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>


