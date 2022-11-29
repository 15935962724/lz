<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="tea.entity.util.*" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page import="tea.service.version.Version" %>

<%@ page import="tea.ui.TeaSession" %>




<% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
session.setAttribute("currentjob","");
/*if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}*/

 Version v=new Version();
  String updatetime ="";
  String curversion="";

  String root=request.getSession().getServletContext().getRealPath("/");
  String vi= v.getversion(root+"\\version.properties");
  if (vi!=null)
  {
  updatetime =v.getUpdatetime();
  curversion=v.getCurversion();
  }else
  {
  updatetime ="2008-06-11";
  curversion="0.0.0.0";
  }

String community=teasession._strCommunity;
DbAdapter db=new DbAdapter();
 String name=community;
 //String introduce="";
 try{
 db.executeQuery("select name,introduce from clientcode");
 if(db.next())
  {
    name=db.getString(1);
  }
}catch (Exception e){
  e.printStackTrace();
  }
  //db.close();
String version ="";
 try{
 db.executeQuery("select top 1 version from version order by id desc");
 if(db.next())
  {
    version=db.getString(1);
  }
}catch (Exception e){
  e.printStackTrace();
  }
  db.close();

  if (curversion.equals(version))
  {
%>


<html>
<head>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<title>升级</title>
<style type="text/css">
<!--
.style1 {font-size: 12px}
-->
</style>


<script type="text/javascript">
function getResult(){
  var url = "/jsp/version/currentjob.jsp";
  if (window.XMLHttpRequest) {
    req = new XMLHttpRequest();
  }else if (window.ActiveXObject){
    req = new ActiveXObject("Microsoft.XMLHTTP");
  }

  if(req){
     req.open("GET",url, true);
     req.onreadystatechange = complete;
     req.send(null);
    }
}

function complete(){
  if (req.readyState == 4) {
    if (req.status == 200) {
    var str=req.responseText;
    document.getElementById('agent').innerHTML = req.responseText;
        }
  }
}



/*分析返回的文本文档*/

 function MyShow(){//2秒自动刷新一次,2秒取得一次数据.
  timer = window.setInterval("getResult()",2000);
  }
</script>
</head>


<body bgColor=#fffde8 onload="MyShow()"><center>

<FORM name=form1 METHOD=POST action="/servlet/CreateUpdate" onSubmit="">

           <table class="right" id="tablecenter"   width="800" border="1" cellpadding="0" cellspacing="0"  >
            <tr class="right" >
              <td class="right"  colspan="8">&nbsp;</td>
            </tr>
            <tr class="right" >
              <td class="right"  colspan="8">升级包 : <div id="agent"></div></td>
              </tr>
            <tr class="right" >
              <td  width="91" class="style1">客户号  </td>
              <td class="right"  width="114" >
                <input name="client" readonly type="text" class="style1" value="<%=name%>"  size="15"/>
                <font color="red">*</font></td>
              </tr>
             <tr class="right" >
              <td  width="91" class="style1">当前版本号</td>
              <td class="right"  width="114" >
                <input readonly name="curversion" type="text" class="style1" value="<%=curversion%>"  size="15"/>
                <font color="red">*</font></td>
              </tr>
               <tr class="right" >
              <td  width="91" class="style1">新版本号 </td>
              <td class="right"  width="114" >
                <input name="newversion" type="text" class="style1" value=""  size="15"/>
                <font color="red">*</font></td>
              </tr>
            <tr class="right" >
              <td class="right" >升级说明</td>
              <td class="right"  colspan="7">
                <textarea cols="60" rows="5" name="introduce"></textarea></td>
              </tr>
           <tr class="right" >
              <td class="right" >扫描数据库</td>
              <td class="right"  colspan="7"><input name="scandb" value="" type="checkbox" ></td>
              </tr>
            <tr class="right" >
              <td class="right"  colspan="8"><input type="submit"  name="Submit" value="提交" ></td>
              </tr>
          </table>
  </form>
</center>
</body>
</html>
<%}else
{
  %>
  <html>
  数据库与当前系统版本号不一致，请检查系统，或重新进行初始化！<a href="/jsp/version/init.jsp">初始化</a>
  </html>

  <%}%>
