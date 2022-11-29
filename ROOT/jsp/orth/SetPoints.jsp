<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@page import="tea.entity.admin.orthonline.*" %>
<%@ page  import="tea.resource.Resource"  %><%@page  import="tea.entity.site.*" %><%@page  import="tea.entity.node.*" %><%@ page import="tea.ui.*" %><%@ page import="java.util.*" %><%
request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);

Resource r=new Resource("/tea/resource/Report");

	 float scwz=0;
	 float llwz=0;
	 float sczy=0;
	 float xzzy=0;
	 float wzbll=0;
	 float zybxz=0;
int nid=Integer.parseInt(teasession.getParameter("nodeid"));
if(nid!=0){
NodePoints np=NodePoints.get(nid);
      scwz=np.getScwz();
	  llwz=np.getLlwz();
	  sczy=np.getSczy();
	  xzzy=np.getXzzy();
	  wzbll=np.getWzbll();
	  zybxz=np.getZybxz();
}

%>
<html>
<head>
<title>积分设置</title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/tea/tea.js" type="text/javascript"></script>
<script type="">
var doc=dialogArguments.document;
function f_submit(obj)
{

    var h="";

    h+=form1.scwz.value;
    h+=","+form1.llwz.value;
    h+=","+form1.sczy.value;
    h+=","+form1.xzzy.value;
    h+=","+form1.wzbll.value;
	h+=","+form1.zybxz.value;

    window.returnValue=h;
    window.close();
    return false;
}
</script>
<style type="text/css">
#nt_step_2{ padding-left:20px; }
#nt_step_3{ padding-left:40px; }
</style>
</head>
<body >

<form name="form1" method="post" action="?" onSubmit="return f_submit(this);">
<input type='hidden' name="community" value="<%=teasession._strCommunity%>">
<input type='hidden' name="node">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

  <tr>
    <td colspan="2">
      积分设置:<br>
  </td>
  </tr>
 <tr>
 <td >
      上传文章加积分:
   </td>
    <td>
     <input type="text"  name="scwz" value="<%=scwz %>"/>
    </td>
 </tr>
<tr>
 <td >
      上传资源加积分:
   </td>
    <td>
     <input type="text"  name="sczy" value="<%=sczy %>"/>
    </td>
 </tr>
<tr>
 <td >
      上传 文章被浏览加积分:
   </td>
    <td>
     <input type="text"  name="wzbll" value="<%=wzbll %>"/>
    </td>
 </tr>

<tr>
 <td >
      上传资源被下载加积分:
   </td>
    <td>
     <input type="text"  name="zybxz" value="<%=zybxz %>"/>
    </td>
 </tr>

<tr>
 <td >
     浏览文章扣积分:
   </td>
    <td>
     <input type="text"  name="llwz" value="<%=llwz %>"/>
    </td>
 </tr>

<tr>
 <td >
      下载资源扣积分:
   </td>
    <td>
     <input type="text"  name="xzzy" value="<%=xzzy %>"/>
    </td>
 </tr>



</table>

<input type="submit" class="edit_button" value="<%=r.getString(teasession._nLanguage, "CBSubmit")%>" >
<input type="button" class="edit_button" value="<%=r.getString(teasession._nLanguage, "CBClose")%>" onclick="window.close()">
</form>

</body>
</html>
