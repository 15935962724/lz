<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="java.util.*"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.netdisk.*" %>
<jsp:directive.page import="java.math.BigDecimal"/>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");
TeaSession teasession = new TeaSession(request);
if (teasession._rv == null) {
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}

String community = teasession._strCommunity;

int flowitem = 0;
if (request.getParameter("flowitem") != null && request.getParameter("flowitem").length() > 0){
  flowitem = Integer.parseInt(request.getParameter("flowitem"));
}
  Flowitem fobj = Flowitem.find(flowitem);
Workproject wobj = Workproject.find(fobj.getWorkproject());

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
        <body >
        <h1>客户项目详细信息</h1>
        <div id="head6">
          <img height="6" src="about:blank">
        </div>
        <br/>
        <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
          <tr>
            <td nowrap>客户</td>
            <td> <%=wobj.getName(teasession._nLanguage) %> </td>
          </tr>
          <tr>
            <td nowrap>项目名称</td>
            <td ><%=fobj.getName(teasession._nLanguage) %> </td>
          </tr>
          <tr>
            <td nowrap> 项目说明</td>
            <td ><%=fobj.getContent(teasession._nLanguage)%> </td>
          </tr>
          <tr>
            <td nowrap>项目经理</td>
            <td >
            <%
            if(fobj.getManager()!=null){
              String str[] = fobj.getManager().split("/");
              for (int i = 1; i < str.length; i++) {
                Profile p = Profile.find(str[i]);
                out.print(p.getLastName(teasession._nLanguage) + p.getFirstName(teasession._nLanguage)+"，");
              }
            }
            %>
            </td>
          </tr>
          <tr>
            <td nowrap>项目参与者</td>
            <td >


            <%
            if(fobj.getMember()!=null){
              String str2[] = fobj.getMember().split("/");
              for (int i = 1; i < str2.length; i++) {
                Profile p = Profile.find(str2[i]);
                out.print(p.getLastName(teasession._nLanguage) + p.getFirstName(teasession._nLanguage)+"，");
              }
            }
            %>
            </td>
          </tr>
          <tr>
            <td nowrap>预计完成时间</td>
            <td >    <%=fobj.getFtimeToString()%>  </td>
          </tr>
          <!--项目类型-->
          <tr>
            <td nowrap>项目类型</td>
            <td ><%=Flowitem.ITEMGENRE_TYPE[fobj.getItemgenre()]%></td>
          </tr>
          <tr>
            <td nowrap>预计成本:</td>
            <td ><%=fobj.getCost()%></td>
          </tr>
          <tr>
            <td nowrap>项目总金额:</td>
            <td ><%=fobj.getOverallmoney()%></td>
          </tr>
          <tr>
            <td nowrap>合同号:</td>
            <td ><%=fobj.getPact()%></td>
          </tr>
          <tr>
            <td nowrap>合同截止时间：</td>
            <td> <%=fobj.getPacttimeToString()%></td>
          </tr>
          <tr>
          <td nowrap>合同附件：</td>
          <td>
          <%
          int maplen = 0;
          if(fobj.getPactfile()!=null)
          {
            maplen=(int)new java.io.File(application.getRealPath(fobj.getPactfile())).length();
          }
           if(maplen>0){
             out.print("<a href=/jsp/include/DownFile.jsp?uri="+java.net.URLEncoder.encode(fobj.getPactfile(),"UTF-8")+"&name="+java.net.URLEncoder.encode(fobj.getPactfilename(),"UTF-8")+">"+fobj.getPactfilename()+"</a>");
           }
          %>
          </td>
          </tr>
          <tr>
            <td nowrap>合同归档目录:</td>
            <td ><%
            if(fobj.getFilecenter()>0){
              FileCenter fcobj=FileCenter.find(fobj.getFilecenter());
              out.print(fcobj.getSubject());
            }
            %></td>
          </tr>
          <tr>
            <td nowrap>维护费:</td>
            <td ><%=fobj.getVindicate()%></td>
          </tr>
          <tr>
            <td nowrap>维护交费周期：</td>
            <td><%if(fobj.getPeriod()==0){out.print("年");}else if(fobj.getPeriod()==1){out.print("月");}else if (fobj.getPeriod()==2){out.print("一次性");} %> </td>
          </tr>
          <tr>
            <td nowrap>交费日期:</td>
            <td ><%=fobj.getNextcosttimeToString()%> </td>
          </tr>
          <tr>
        </table>
        <br>
        <input type="button" value="返回" onClick="history.back();">

        <br>
        <div id="head6">
          <img height="6" src="about:blank">
        </div>
        </body>
</html>



