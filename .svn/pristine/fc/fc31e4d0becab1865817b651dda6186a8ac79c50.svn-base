<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="tea.entity.util.*" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page import="tea.service.version.Version" %>

<%@ page import="tea.ui.TeaSession" %>

<% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
/*if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}*/
String confirm=request.getParameter("confirm");
String path=request.getSession().getServletContext().getRealPath("/");
String filename=path+"\\update\\"+confirm+"\\db.sql";
         StringBuffer   buf   =   new   StringBuffer();
try{
          RandomAccessFile   fileIn=new   RandomAccessFile(filename,"r");
          String   s;

          while((s=fileIn.readLine())!=null)
                buf.append(s+"\n");
                fileIn.close();
  }catch(IOException   e){
          e.printStackTrace();
  }


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
<title>确认升级包</title>
<style type="text/css">
<!--
.style1 {font-size: 12px}
-->
</style>
</head>


<body bgColor=#fffde8 ><center>

<FORM name=form1 METHOD=POST action="/servlet/ConfirmUpdate" onSubmit="">

           <table class="right" id="tablecenter"   width="800" border="1" cellpadding="0" cellspacing="0"  >
            <tr class="right" >
              <td class="right"  colspan="8">&nbsp;</td>
            </tr>
            <tr class="right" >
              <td class="right"  colspan="8">升级包</td>
              </tr>
             <tr class="right" >
              <td  width="91" class="style1">升级文件 </td>
              <td class="right"  width="114" >
                <input readonly name="filename" type="text" class="style1" value="<%=confirm%>"  size="15"/>
                <font color="red">*</font></td>
              </tr>
            <tr class="right" >
              <td class="right" >sql文件 </td>
              <td class="right"  colspan="7">
              <textarea name="sql" cols="100" rows="30"><%=buf.toString()%></textarea>
              </td>
              </tr>

            <tr class="right" >
              <td class="right"  colspan="8"><input type="submit" name="Submit" value="提交"></td>
              </tr>
          </table>
  </form>
</center>
</body>
</html>
