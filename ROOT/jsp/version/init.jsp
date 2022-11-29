<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="tea.entity.util.*" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page import="tea.service.version.Version" %>

<%@ page import="tea.ui.TeaSession" %>

<% request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);
%>

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

<html>
<head>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<title>初始化 </title>
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
    document.getElementById('agent').innerHTML = "正在进行的工作："+req.responseText;
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
<FORM name=form1 METHOD=POST action="/servlet/InitUpdate" onSubmit="">

           <table class="right" id="tablecenter"   width="800" border="1" cellpadding="0" cellspacing="0"  >
            <tr class="right" >
              <td class="right"  colspan="8">&nbsp;</td>
            </tr>
            <tr class="right" >
              <td class="right"  colspan="8">系统初始化：设定系统客户号，取数据结构，过程时间可能较长，请不要中断
              <div id="agent"></div>
              </td>
              </tr>
            <tr class="right" >
              <td  width="91" class="style1">客户号  </td>
              <td class="right"  width="114" >
                <input name="client" type="text" class="style1" value=""  size="15"/>
                <font color="red">*</font></td>
              </tr>
             <tr class="right" >
              <td  width="91" class="style1">初始版本号</td>
              <td class="right"  width="114" >
                <input name="newversion" type="text" class="style1" value=""  size="15"/>
                <font color="red">*</font></td>
              </tr>

            <tr class="right" >
              <td class="right" >系统说明</td>
              <td class="right"  colspan="7"><input name="introduce" value="" type="text" size="100"></td>
              </tr>

            <tr class="right" >
              <td class="right"  colspan="8"><input type="submit" name="Submit" value="提交"></td>
              </tr>
          </table>
  </form>
</center>
</body>
</html>
