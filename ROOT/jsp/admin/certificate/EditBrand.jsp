
<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.Resource"  %>
<%@ page  import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="java.util.*" %>
<%@ page import ="java.io.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="tea.entity.member.*" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="tea.entity.site.*" %>
<%@ page import="tea.entity.confab.*" %>

<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String nexturl = request.getParameter("nexturl");
int sort =7;
if(request.getParameter("sort")!=null && request.getParameter("sort").length()>0)
     sort = Integer.parseInt(request.getParameter("sort"));
String community = teasession._strCommunity;
boolean _bCount=request.getParameter("count")!=null;
boolean _bFather=request.getParameter("father")!=null;
int father=0;
if(_bFather)
father=Integer.parseInt(request.getParameter("father"));

DCommunity dc=DCommunity.find(community);
if(father==0)
{
  father=dc.getNode();
}






 %>

<html>
  <head>
    <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
    <script src="/tea/tea.js" type="text/javascript"></script>

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
        <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
          <META HTTP-EQUIV="Expires" CONTENT="0">

  </head>

  <script language="javascript" type="">



  function sub()
  {
//    if(form1.labnames.value=='')
//    {
//      alert("请填写员工姓名！");
//      return false;
//    }

  }





  </script>
    <body>
      <h1>品牌申请</h1>
  <div id="head6"><img height="6" src="about:blank" alt=""></div>
    <br>

    <form name="form1" METHOD="post" enctype="multipart/form-data" action="/servlet/EditCertificate" onSubmit="return sub(this);">
      <input  type="hidden" name="nexturl" value="<%=nexturl%>"/>
      <input type="hidden" name="act" value="EditCertificate"/>

      <input type="hidden" name ="certificate" value ="">

<table border="0" cellspacing="0" cellpadding="0" width="100%"  id="tablecenter">
<tr>
    <td colspan="3"><p>集团基础设施事业部：</p>      </td>
  </tr>
  <tr>
    <td>我单位联系的</td>
    <td>
    <select name="">
    <option value="0">----------</option>

      <%

      DbAdapter db=new DbAdapter();
try
{
  db.executeQuery("SELECT node FROM Node WHERE type>=1024 AND community="+db.cite(community)+" AND path LIKE "+db.cite("%/"+father+"/%")+" AND vcreator="+db.cite(teasession._rv._strV));
  while(db.next())
  {
    int node_id=db.getInt(1);
    Node node_obj=Node.find(node_id);
    Dynamic d_obj=Dynamic.find(node_obj.getType());
    Category c=Category.find(node_id);
    Dynamic dynamic = Dynamic.find(c.getCategory());
    if(d_obj.getSort()==sort){

     out.print("<option value="+node_id);
     out.print(">"+node_obj.getSubject(teasession._nLanguage));
      out.print("</option>");
   }
  }
}finally
{
  db.close();
}
%>
       </select><span id="show"><input type="text" name="" value=""> </span></td>
    <td>（工程项目名称）</td>
  </tr>
  <tr>
    <td>目前正处在</td>
    <td><input type="text" name="textfield2"></td>
    <td>（投标报名/资格预审/投标）阶段。</td>
  </tr>
  <tr>
  <td>现申请使用</td>
    <td><select name=""> <option value="0">----------</option>
    <%
    java.util.Enumeration e1 = Certificate.find(teasession._strCommunity," and type=1",0,Integer.MAX_VALUE);
    while(e1.hasMoreElements())
    {
      int id1 =((Integer)e1.nextElement()).intValue();
      Certificate obj1 = Certificate.find(id1);
      out.print("<option value="+id1);
      out.print(">"+obj1.getNames());
      out.print("</option>");
    }
    %>
</select></td>
    <td>（集团公司或路桥公司）品牌进行跟踪，</td>
  </tr>
  <tr>
    <td>并申请使用</td>
    <td><select name=""> <option value="0">----------</option>
    <%
    java.util.Enumeration e2 = Certificate.find(teasession._strCommunity," and type=2",0,Integer.MAX_VALUE);
    while(e2.hasMoreElements())
    {
      int id2 =((Integer)e2.nextElement()).intValue();
      Certificate obj2 = Certificate.find(id2);
      out.print("<option value="+id2);
      out.print(">"+obj2.getNames());
      out.print("</option>");
    }
    %>
</select></td>
    <td><p>（施工资质类型），请予审批。 </p></td>
  </tr>
</table>



      <br>
   <input type="Submit" name="Submit1" value="保存"><input type="reset" name="" value="重填" >
      <input type="button" name="" value="返回" onClick="location='<%=nexturl%>'" >
    </FORM>

    <br>
   <div id="head6"><img height="6" src="about:blank" alt=""></div>
  </body>
</html>
