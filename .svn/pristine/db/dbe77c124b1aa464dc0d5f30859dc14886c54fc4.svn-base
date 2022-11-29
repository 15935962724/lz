<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.Resource"  %>
<%@ page  import="tea.entity.csvclub.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import ="tea.entity.member.*" %>
<%@ page import ="tea.entity.node.*" %>
<%@ page import="tea.entity.site.*" %>
<%@ page import="tea.entity.admin.mov.*" %>
<%@ page import="tea.entity.integral.*" %>

<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

Resource r=new Resource();
String community = teasession._strCommunity;
String nexturl = request.getRequestURI()+"?"+request.getContextPath();

CommunityPoints cp= CommunityPoints.find(CommunityPoints.getIgid(teasession._strCommunity));
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<script>

//修改的积分




//修改用户登录的积分
function f_reg(zd)
{
 var fieldvalude = document.all(zd).value;//修改的数值

  sendx("/jsp/integral/integral_ajax.jsp?community="+form1.community.value+"&act=MemberType&field="+zd+"&fieldvalude="+fieldvalude,
  function(data)
  {}
  );
}
//类别积分设置
function f_cljf(clid,zd)
{
  var fieldvalue = document.all(zd+clid).value;
  sendx("/jsp/integral/integral_ajax.jsp?community="+form1.community.value+"&act=CLicense&clid="+clid+"&field="+zd+"&fieldvalude="+fieldvalue,
  function(data)
  {
   // alert(data);
  }
  );
}
//动态类积分设置
function f_tajf(taid,tatype,zd)
{
   var fieldvalue = document.all(zd+taid).value;
    sendx("/jsp/integral/integral_ajax.jsp?community="+form1.community.value+"&act=TypeAlias&taid="+taid+"&field="+zd+"&fieldvalude="+fieldvalue+"&tatype="+tatype,
  function(data)
  {
    // alert(data);
  }
  );
}
</script>
<body bgcolor="#ffffff" >


<h1>积分系统管理平台</h1>
<form action="/servlet/EditIntegral" method="POST" name="form1">
<input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="act" value="Integral" />

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
  </tr>
 <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
     <td>
      注册普通会员加分:&nbsp;<input type="text" name="pthyjf" value="<%=cp.getPthyjf() %>"  size="5"  onkeyup="f_reg('pthyjf');" >&nbsp;&nbsp;
      普通会员升级积分限定:&nbsp;<input type="text" name="sjhyjf" value="<%=cp.getSjhyjf() %>" size="5"  onkeyup="f_reg('sjhyjf');" >&nbsp;&nbsp;
     邀请会员加分:&nbsp;<input type="text" name="yqhyjf" value="<%=cp.getYqhyjf() %>"  size="5"  onkeyup="f_reg('yqhyjf');" >&nbsp;&nbsp;
    医生升级为高级会员加分:&nbsp;<input type="text" name="yshyjf" value="<%=cp.getYshyjf() %>"  size="5"  onkeyup="f_reg('yshyjf');" >&nbsp;&nbsp;
     会员登陆加分:&nbsp;<input type="text" name="dlhyjf" value="<%=cp.getDlhyjf() %>"  size="5"  onkeyup="f_reg('dlhyjf');" >&nbsp;&nbsp;
    </td>
  </tr>
</table>

<!-- table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">

  </tr>
  <%
       java.util.Enumeration e = MemberType.find(teasession._strCommunity,"",0,Integer.MAX_VALUE);
       while(e.hasMoreElements())
       {
         int mtid = ((Integer)e.nextElement()).intValue();
         MemberType mtobj = MemberType.find(mtid);
  %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td ><b><%=mtobj.getMembername()%></b></td>
    <td>
      设置注册积分:&nbsp;<input type="text" name="register<%=mtid%>" value="<%=mtobj.getRegister()%>"     size="5"  onkeyup="f_reg('<%=mtid%>','register');" >&nbsp;&nbsp;
      设置登录次数:&nbsp;<input type="text" name="logincount<%=mtid%>" value="<%=mtobj.getLogincount()%>" size="5"  onkeyup="f_reg('<%=mtid%>','logincount');" >&nbsp;&nbsp;
      每次登录积分:&nbsp;<input type="text" name="loginjifen<%=mtid%>" value="<%=mtobj.getLoginjifen()%>" size="5"  onkeyup="f_reg('<%=mtid%>','loginjifen');" >
    </td>
  </tr>
  <%  } %>
</table-->






<h2>网站类别  积分设置</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<%
String cl[] =CLicense.find(teasession._strCommunity).getType().split("/");
for(int i =1;i<cl.length;i++)
{
int intcl = Integer.parseInt(cl[i]);
StringBuffer typename = new StringBuffer();
StringBuffer typename2 = new StringBuffer();
if(intcl<1024)
{
  typename.append(r.getString(teasession._nLanguage,Node.NODE_TYPE[intcl]));
  typename2.append("<font color=\"a0a040\">标准类别</font>");
}else
{
  Dynamic obj=Dynamic.find(intcl);
  typename.append(obj.getName(teasession._nLanguage));
  typename2.append("<font color=ffa040>动态类别</font>");
}
Integral iobj = Integral.find(Integral.getIgid(teasession._strCommunity,intcl,0));

%>
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
  <td  nowrap align="right"><b><%=typename%></b></td>
  <td><%=typename2%></td>
  <td>
  &nbsp;上传文章加分:&nbsp;<input type=text name="scwz<%=intcl%>" value="<%=iobj.getScwz()%>" onkeyup="f_cljf('<%=intcl%>','scwz');" >
  &nbsp;上传资源加分:&nbsp;<input type=text name="sczy<%=intcl%>" value="<%=iobj.getSczy()%>"  onkeyup="f_cljf('<%=intcl%>','sczy');" >
  &nbsp; 资源被下载积分:&nbsp;<input type=text name="zybxz<%=intcl%>" value="<%=iobj.getZybxz()%>"  onkeyup="f_cljf('<%=intcl%>','zybxz');" >
  <br/>
&nbsp; 文章被浏览加分:&nbsp;<input type=text name="wzbll<%=intcl%>" value="<%=iobj.getWzbll()%>"  onkeyup="f_cljf('<%=intcl%>','wzbll');" >
  &nbsp; 浏览文章减分:&nbsp;<input type=text name="llwz<%=intcl%>" value="<%=iobj.getLlwz()%>"  onkeyup="f_cljf('<%=intcl%>','llwz');" >
  &nbsp;下载资源减分:&nbsp;<input type=text name="xzzy<%=intcl%>" value="<%=iobj.getXzzy()%>"  onkeyup="f_cljf('<%=intcl%>','xzzy');" >
  </td>
  </tr>
    <%
    }
    %>
</table>

<h2>别名类别  积分设置</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

<%
java.util.Enumeration  tae =TypeAlias.find(0, 100);
while(tae.hasMoreElements())
{
  int taid = ((Integer)tae.nextElement()).intValue();
  TypeAlias taobj = TypeAlias.find(taid);
  StringBuffer typename = new StringBuffer();
  StringBuffer typename2 = new StringBuffer();

  if(taobj.getType()<1024)
  {
    typename.append(r.getString(teasession._nLanguage,Node.NODE_TYPE[taobj.getType()]));
    typename2.append("<font color=\"a0a040\">标准类别</font>");
  }else
  {
    Dynamic obj=Dynamic.find(taobj.getType());
    typename.append(obj.getName(teasession._nLanguage));
    typename2.append("<font color=ffa040>动态类别</font>");
  }
 Integral iobj = Integral.find(Integral.getIgid(teasession._strCommunity,taobj.getType(),taid));
  %>
  <tr  onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td  nowrap align="right"><b><%=taobj.getName(teasession._nLanguage)%></b></td>
    <td>所属类别:&nbsp;<b><font color="60a0ff"><%=typename %></font></b>&nbsp;<%=typename2 %></td>
    <td>


 &nbsp;上传文章加分:&nbsp;<input type=text name="scwz<%=taid%>" value="<%=iobj.getScwz()%>" onkeyup="f_tajf('<%=taid%>','scwz');" >
  &nbsp;上传资源加分:&nbsp;<input type=text name="sczy<%=taid%>" value="<%=iobj.getSczy()%>"  onkeyup="f_tajf('<%=taid%>','sczy');" >
 <br/>
  &nbsp; 资源被下载积分:&nbsp;<input type=text name="zybxz<%=taid%>" value="<%=iobj.getZybxz()%>"  onkeyup="f_tajf('<%=taid%>','zybxz');" >

 &nbsp; 文章被浏览加分:&nbsp;<input type=text name="wzbll<%=taid%>" value="<%=iobj.getWzbll()%>"  onkeyup="f_tajf('<%=taid%>','wzbll');" >

 <br/>
 &nbsp; 浏览文章减分:&nbsp;<input type=text name="llwz<%=taid%>" value="<%=iobj.getLlwz()%>"  onkeyup="f_tajf('<%=taid%>','llwz');" >
  &nbsp;下载资源减分:&nbsp;<input type=text name="xzzy<%=taid%>" value="<%=iobj.getXzzy()%>"  onkeyup="f_tajf('<%=taid%>','xzzy');" >



    </td>
   </tr>
    <%
    }

    %>
</table>

</form>
</div>
</body>
</html>
