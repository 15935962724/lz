<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="tea.db.DbAdapter"%><%@page import="tea.resource.Resource" %><%@page import="java.util.*" %><%@ page import="tea.entity.csvclub.*" %><%@ page import="tea.ui.TeaSession" %>
<jsp:directive.page import="java.math.BigDecimal"/><% request.setCharacterEncoding("UTF-8");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}
Resource r=new Resource();
int csvdogservice = 0;
if(request.getParameter("csvdogservice")!=null && request.getParameter("csvdogservice").length()>0)
csvdogservice = Integer.parseInt(request.getParameter("csvdogservice"));

String nexturl=request.getParameter("nexturl");

String content=null,principal=null,sort=null;
int type=-1,sequence=0,servicefrist=0,name=0;
java.math.BigDecimal outlay=null;
java.util.Date time=null;
java.math.BigDecimal registeroutlay =null;
Node noobj = Node.find(csvdogservice);
Csvdogservice obj=Csvdogservice.find(csvdogservice);
if(csvdogservice>0)
{
  name=obj.getName();
  type=obj.getType();
  sequence=obj.getSequence();
  outlay=obj.getOutlay();
  content=obj.getContent();
  time=obj.getTime();
  registeroutlay= obj.getRegisteroutlay();
  sort = obj.getSort();
  servicefrist = obj.getServicefrist();

}

if(request.getParameter("delete")!=null)
{
  obj.delete();
  noobj.delete(teasession._nLanguage);
  response.sendRedirect("/jsp/type/csvservice/Csvdogservices.jsp");
  return;
}

%>
<html>
  <head>
    <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
    <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js"></SCRIPT>
    <SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/csvclub/js.js"></SCRIPT>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
        <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
          <META HTTP-EQUIV="Expires" CONTENT="0">
            <script>
            function defaultfocus()
            {
              form1.name.focus();
            }
            function sub()
            {
              if(form1.name.value=="")
              {
                alert("服务名称不能为空!");
                return false;
              }
              if(form1.time.value=="")
              {
                alert("时间不能为空!");
                return false;
              }
            }
            </script>
            </head>
            <body onLoad="defaultfocus();">

            <h1>创建/编辑 服务</h1>
            <br>
            <br/>
              <form name="form1" action="/servlet/editcsvdog" method="post"  onSubmit="return sub(this);">
              <input type=hidden name="Node" value="<%=teasession._nNode%>"/>
              <input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
              <input type=hidden name="nexturl" value="<%=nexturl%>"/>
              <input type=hidden name="act" value="editcsvdogservice"/>
              <input type="hidden" name ="csvdogservice" value="<%=csvdogservice %>">
              <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
                <tr>
                  <td>服务名称</td>
                  <td nowrap>
                    <select name="name">
                    <%
                    for(int j =0;j<Csvdogservice.FU_NAME.length;j++)
                    {
                      out.print("<option value="+j);
                      if(j==name)
                      out.print(" selected");
                      out.print(">"+Csvdogservice.FU_NAME[j]+"</option>");
                    }
                    %>
                    </tr>
                    <tr>
                      <td>注册费用</td>
                      <td nowrap><input name="outlay" type="text" value="<%if(outlay==null)out.print("0.00");else out.print(outlay);%>" >
                        元/终身</td>
                    </tr>
                    <tr>
                      <td>服务费用</td>
                      <td nowrap><input name="registeroutlay" type="text" value="<%if(registeroutlay!=null){out.print(registeroutlay);}else{out.print("0.00");}%>" >
                        元/年.</td>
                    </tr>
                    <tr>
                      <td>顺序</td>
                      <td nowrap><input name="sequence" type="text" value="<%=noobj.getSequence()%>" ></td>
                    </tr>
                    <tr>
                      <td>备注</td>
                      <td nowrap><textarea name="content" cols="50" rows="5"><%if(noobj.getText(teasession._nLanguage)!=null)out.print(noobj.getText(teasession._nLanguage).replaceAll("</","&lt;/"));%></textarea></td>
                    </tr>
                    <tr>
                      <td >时间:</td>
                      <td>
                        <input name="time" size="7"  value="<%if(noobj.getTime()!=null)out.print(noobj.getTimeToString()); %>"><A href="###"><img onclick="showCalendar('form1.time');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
                      </td>
                    </tr>
                    <tr>
                      <td>&nbsp;</td>
                      <td nowrap>
                        <input type="submit" name="Submitdogservice" value="提交">
                        <input type="reset" name="Submit2" value="重置" onClick="defaultfocus();">
                        <input type="button" value="返回" onClick="history.back();">
                      </td>
                    </tr>
              </table>
              </form>
              <br>
            </body>
</html>



