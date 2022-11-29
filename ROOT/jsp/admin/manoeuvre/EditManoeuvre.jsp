<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.Resource"  %>
<%@ page  import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="java.util.*" %>
<%@ page import ="java.io.*" %>
<%@ page import="java.net.*" %>

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
int manoeuvre =0;
if(request.getParameter("manoeuvre")!=null && request.getParameter("manoeuvre").length()>0)
   manoeuvre  = Integer.parseInt(request.getParameter("manoeuvre"));
Manoeuvre mobj = Manoeuvre.find(manoeuvre);

String manmember =null,content=null,formerduty=null,backduty=null,audmamber=null,mantime=null;

if(manoeuvre>0)
{
   manmember =mobj.getManmember();
   content=mobj.getContent();
   formerduty=mobj.getFormerduty();
   backduty=mobj.getBackduty();
   audmamber=mobj.getAudmamber();
   mantime=mobj.getMantimeToString();
}

%>

<html>
  <head>
    <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
    <script src="/tea/tea.js" type="text/javascript"></script>
    <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/image/ig/ig_iframe.js" type="text/javascript"></SCRIPT>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
        <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
          <META HTTP-EQUIV="Expires" CONTENT="0">

  </head>
  <body>
  <script language="javascript" type="text/javascript">

  function loadTo()
  {
    var loc_x=document.body.scrollLeft+event.clientX-event.offsetX-100;
    var loc_y=document.body.scrollTop+event.clientY-event.offsetY+140;
    window.showModalDialog('/jsp/sms/psmanagement/FrameGU.jsp?community=<%=teasession._strCommunity%>&type=3&field=member&index=form1.manmember',self,'edge:raised;scroll:0;status:0;help:0;resizable:1;dialogWidth:450px;dialogHeight:300px;dialogTop:'+loc_y+'px;dialogLeft:'+loc_x+'px');

  }
  function loadTo2()
  {
    var loc_x=document.body.scrollLeft+event.clientX-event.offsetX-100;
    var loc_y=document.body.scrollTop+event.clientY-event.offsetY+140;
    window.showModalDialog('/jsp/sms/psmanagement/FrameGU.jsp?community=<%=teasession._strCommunity%>&type=3&field=member&index=form1.audmamber',self,'edge:raised;scroll:0;status:0;help:0;resizable:1;dialogWidth:450px;dialogHeight:300px;dialogTop:'+loc_y+'px;dialogLeft:'+loc_x+'px');
  }


  function clear_dept1()
  {
    document.form1.manmember.value="";
  }
  function clear_dept2()
  {
    document.form1.audmamber.value="";
  }

  function sub (){
    if(form1.manmember.value=="")
    {
       alert("请选择调动人员！");
       return false;
    }
    if(form1.formerduty.value=="")
    {
       alert("请填写原职务！");
       return false;
    }
    if(form1.backduty.value=="")
    {
       alert("请填写调动后职务！");
       return false;
    }
    if(form1.mantime.value=="")
    {
      alert("请填写调动时间！");
      return false;
    }
    if(form1.audmamber.value=="")
    {
      alert("请选择审核人员！");
      return false;
    }

  }
  </script>
  <h1>新建文件会签</h1>
  <div id="head6"><img height="6" src="about:blank" alt=""></div>
    <br>

    <form  name="form1" METHOD="post" action="/servlet/EditManoeuvre" onSubmit="return sub(this);">
      <input  type="hidden" name="nexturl" value="<%=nexturl%>"/>
      <input type="hidden" name="act" value="EditManoeuvre"/>
      <input type="hidden" name="manoeuvre" value="<%=manoeuvre%>"/>


      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
        <tr>
          <td>调动人员：</td><td><input type="text" name="manmember" value="<%if(manmember!=null)out.print(manmember);%>" size=20>
            <input type="button" name="" value="添加" onClick="loadTo();" >
            <input type="button" name="" value="清空" onClick="clear_dept1();">


          </td>
        </tr>
       <tr>
          <tr>
          <td>调动原因：</td><td><textarea name="content" cols=60 rows=10 ><%if(content!=null)out.print(content);%></textarea> </td>
        </tr>
	   <tr>
          <td>职务变动：</td><td>原职务<input type="text" name="formerduty" value="<%if(formerduty!=null)out.print(formerduty);%>" size=20>-
            调动后职务<input type="text" name="backduty" value="<%if(backduty!=null)out.print(backduty);%>" size=20></td>
        </tr>
       <tr>
       <td>调动时间:</td><td><input type="text" value="<%if(mantime!=null)out.print(mantime);%>" name="mantime"/><A href="###"><img onclick="showCalendar('form1.mantime');" src="/tea/image/public/Calendar2.gif" align="top"/></a></td>
       </tr>
        <tr>
          <td>审核人员：</td><td><input type="text" name="audmamber" value="<%if(audmamber!=null)out.print(audmamber);%>" size=20>
            <input type="button" name="" value="添加" onClick="loadTo2();" >
            <input type="button" name="" value="清空" onClick="clear_dept2();">

          </td>
        </tr>

      </table>
      <br>
      <input type="Submit" name="" value="发布"><input type="reset" name="" value="重填" >
      <input type="button" name="" value="返回" onClick="location='/jsp/admin/manoeuvre/manoeuvre.jsp'" >
    </FORM>

    <br>
   <div id="head6"><img height="6" src="about:blank" alt=""></div>
  </body>
</html>




