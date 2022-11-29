<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="tea.html.*"%>
<%@ page import="tea.htmlx.*"%>
<%@page import="java.util.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.db.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="java.text.*" %>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");
Node node;
TeaSession teasession= new TeaSession(request);
String community = teasession._strCommunity;
if(teasession._rv == null)
{
response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
return;
}
//
//StringBuffer sql = new StringBuffer();
//sql.append("select * from logo where community = ").append(DbAdapter.cite(community)).append(" and language = ").append(teasession._nLanguage);
//sql.toString();
StringBuffer param=new StringBuffer("?community="+teasession._strCommunity);
param.append("&id=").append(request.getParameter("id"));
param.append("&node=").append(teasession._nNode);
StringBuffer sql=new StringBuffer();

sql.append(" and Logo.node in ( select node from Node where  path like ").append(DbAdapter.cite("%/"+teasession._nNode+"/%")).append(")");

  String subject = request.getParameter("subject");
  String regnum = request.getParameter("regnum");
  String from = request.getParameter("from");
  String to = request.getParameter("to");


  String logotype = request.getParameter("logotype");


  if(logotype!=null && !logotype.equals("")){
    if(logotype.equals("-1")){}
    else{
      sql.append( " AND logotype = ").append(logotype);
      param.append("&logotype=").append(logotype);
    }
  }


  if(subject!=null && !subject.equals(""))
  {
    subject = subject.trim();
    sql.append( " AND subject LIKE ").append(DbAdapter.cite("%"+subject+"%"));
    param.append("&subject=").append(java.net.URLEncoder.encode(subject,"UTF-8"));
  }
  if(regnum!=null && !regnum.equals(""))
  {
    sql.append( " AND regnum = ").append(DbAdapter.cite(regnum));
    param.append("&regnum=").append(regnum);
  }
  if(from!=null && !from.equals(""))
  {
    sql.append( " AND regdate > ").append(DbAdapter.cite(from));
    param.append("&from=").append(from);
  }
  if(to!=null && !to.equals(""))
  {
    sql.append( " AND regdate < ").append(DbAdapter.cite(to));
    param.append("&to=").append(to);
  }


int pos=0;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}
//param.append("&sql=").append(session.getAttribute("sql"));

int count=Logo.count(community,sql.toString());

String act = request.getParameter("act");
if(request.getMethod().equals("GET")){
  if(act != null){
    if(act.equals("del"))
    {
      String fnode = request.getParameter("fnode");
      int nid = Integer.parseInt(teasession.getParameter("logoid"));
      Node nobj = Node.find(nid);
      nobj.delete(teasession._nLanguage);
      Logo lobj = Logo.find(nid);
      lobj.delete();
      response.sendRedirect("/jsp/type/logo/LogoManage.jsp?node="+fnode);
    }
    if("del2".equals(act)){//多项删除
      String[] id = request.getParameterValues("lid");
      String fnode = request.getParameter("fnode");
      for(int i = 0;i < id.length;i++){
        int nid = Integer.parseInt(id[i]);
        Node nobj = Node.find(nid);
        nobj.delete(nid);
        Logo obj = Logo.find(nid);
        obj.delete();
      }
      response.sendRedirect("/jsp/type/logo/LogoManage.jsp?node="+fnode);
    }
  }

}
%>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=UTF-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">

<script src="/tea/tea.js" type="text/javascript"></script>
<script language="javascript" src="/tea/inc/media_<%=teasession._nLanguage%>_39.js?<%=System.currentTimeMillis()%>" type="text/javascript"></script>
<script src="/res/<%=community%>/cssjs/community.js" type="text/javascript" defer="defer"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
function f_del(n)
{
  var rs=window.confirm('您确定删除吗？');
  if(rs){
    form2.act.value = "del";
    form2.logoid.value = n;
    form2.submit();
  }
  else{
    return;
  }
}
function f_del2(){
 var rs=window.confirm('您确定删除吗？');
 if(rs){
   var el = form2.elements;
   var count = el.length;
   var flag = 0;
   for(i=0;i<count;i++)
   {
     if(el[i].type=="checkbox")
     {
       if(el[i].checked == true){
         flag = 1;
       }
     }
   }
   if(flag == 0){
     alert("至少选择一项");
     return;
   }
   form2.act.value = "del2";
   form2.submit();
 }
}
</script>
</HEAD>
<title>商标</title>
<BODY onload="">
<h1>商标管理</h1>
<form name="form1" method="GET" action="?">
<input type="hidden" name="community" value="<%=community%>"/>
<input type="hidden" name="node" value="<%=request.getParameter("node")%>"/>
<input type="hidden" name="id" value="<%=request.getParameter("id")%>">
<table id="tablecenter">
  <tr>
    <td align="right"> 商标类别：</td>
    <td  colspan="3">
    <select name="logotype">
        <option value="-1">--请选择商标类别--</option>
        <%

        for(int i =1;i<Logo.LOGO_TYPE.length;i++)
        {

          out.print("<option value = "+i);
          if(logotype!=null && logotype.length()>0 && Integer.parseInt(logotype)==i)
          {
            out.print(" selected ");
          }
          out.print(">"+Logo.LOGO_TYPE[i]);
          out.print("</option>");
        }
      %>
      </select>
      </td>
</tr>
<tr>
         <td align="right"> 商标名称：</td> <td><input type="text" name="subject" value="<%=Logo.getNULL(subject)%>"></td>


      <td align="right">注册号：</td>
      <td><input type="text" name="regnum" value=<%=Logo.getNULL(regnum)%>></td>
      </tr>
      <tr>
      <td align="right">注册时间：</td>
      <td><input id="from" name="from" value="<%if(from!=null)out.print(from); %>" readonly="readonly" class="date" onclick="mt.date(this)"> 至<input id="to" name="to" value="<%if(to!=null)out.print(to); %>" readonly="readonly" class="date" onclick="mt.date(this)"></td>
    <td colspan="2">  <input type="submit" value="查询"></td>
  </tr>
</table>

</form>
<form name="form2" action="?" method="GET">
<input type="hidden" name="act" value=""/>
<input type="hidden" name="community" value="<%=community%>"/>
<input type="hidden" name="language" value="<%=teasession._nLanguage%>"/>
<input type="hidden" name="id" value="<%=request.getParameter("id")%>"/>
<input type="hidden" name="logoid" value=""/>
<input type="hidden" name="fnode" value="<%=request.getParameter("node")%>"/>
<input type="hidden" name="node" value="<%=teasession._nNode%>"/>
<input type="hidden" name="nexturl"/>
<table id="tablecenter">
  <tr>
    <td colspan="4">
    <font style="font-weight:bold;color='#CE0829'">商标列表（<%=count%>）</font>&nbsp;&nbsp;&nbsp;&nbsp;
    <input type="button" onclick="mt.act('add',<%=teasession._nNode%>)" value="创建商标">
    </td>
  </tr>
     <tr id=tableonetr>
    <td  nowrap>
     序号
    </td>
    <td  nowrap>
      商标名称
    </td>
    <td  nowrap>
     注册时间
    </td>
    <td  nowrap>
      操作
    </td>
  </tr>
<%
  Enumeration e=Logo.find(community,sql.toString(),pos,10);
  if(e.hasMoreElements()){
    for(int i=pos+1;e.hasMoreElements();i++)
    {
      int nid = ((Integer)e.nextElement()).intValue();
      Node enode = Node.find(nid);
      Logo logo = Logo.find(nid);

      %>
      <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
        <td nowrap>
          <input type="checkbox" name="lid" value="<%=nid%>">&nbsp;&nbsp;<%=i%>
        </td>
        <td>
          <%=enode.getSubject(teasession._nLanguage)%>
        </td>
        <td nowrap>
        <%
        Date date1 = logo.getRegdate();
        if(date1 == null || date1.equals("")){
        }
        else{
          SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
          out.print(format.format(date1));
        }
        %>
        </td>
        <td nowrap>
          <input type="button" value="编辑" onclick="mt.act('edit',<%=nid%>)">
          <input type="button" value="删除" onclick="f_del(<%=nid%>);">
        </td>
      </tr>
      <%
      }
    }
    else{
    %>
      <tr>
      <td colspan="4" align="center">
      暂无记录
      </td>
      </tr>
    <%
    }
%>
  <tr>
    <td colspan="4">
      <input type="checkbox" onclick="selectAll(form2.lid ,this.checked);">&nbsp;&nbsp;全选
      &nbsp;<input type="button" value="复制" disabled="disabled">
      &nbsp;<input type="button" value="移动" disabled="disabled">
      &nbsp;<input type="button" value="删除" onclick="f_del2();">
      &nbsp;<input type="button" value="推荐" disabled="disabled">
      &nbsp;<input type="button" value="积分设置" disabled="disabled">
    </td>
  </tr>
</table>
<%=new tea.htmlx.FPNL(teasession._nLanguage,param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,10)%>
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,i)
{
  if(a=='add')
    location='/jsp/type/logo/EditLogo.jsp?NewNode=ON&Type=93&node='+i+'&nexturl='+encodeURIComponent(form2.nexturl.value);
  else if(a=='edit')
    location='/jsp/type/logo/EditLogo.jsp?node='+i+'&nexturl='+encodeURIComponent(form2.nexturl.value);
};
</script>
</BODY>
</HTML>
