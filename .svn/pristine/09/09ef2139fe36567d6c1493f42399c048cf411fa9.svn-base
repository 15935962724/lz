<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.resource.Resource" %><%@ page import="tea.entity.site.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

int type=Integer.parseInt(request.getParameter("type"));

String s = request.getParameter("community");


Resource r=new Resource("/tea/resource/Dynamic");


java.util.Enumeration enumer=DynamicType.findByDynamic(type,"code");
if(!enumer.hasMoreElements())
{
  response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("模板没有定义,编号类型.","UTF-8"));
  return;
}

String nexturl=request.getParameter("nexturl");

%>
<html>
<head>
<link href="/res/<%=s%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script type="">
function td_calendar(fieldname)
{
  myleft=document.body.scrollLeft+event.clientX-event.offsetX-80;
  mytop=document.body.scrollTop+event.clientY-event.offsetY+140;
  window.showModalDialog("/jsp/include/Calendar.jsp?FIELDNAME="+fieldname,self,"edge:raised;scroll:0;status:0;help:0;resizable:1;dialogWidth:280px;dialogHeight:205px;dialogTop:"+mytop+"px;dialogLeft:"+myleft+"px");
}
function fonclick(checkbox,text)
{
  text.disabled=!checkbox.checked;
}
  //submitIdentifier
</script>
</head>
<body >
<h1><%=r.getString(teasession._nLanguage,"Auditing")%></h1>
<div id="head6"><img height="6" alt=""></div>
<br>
<%

Dynamic d=Dynamic.find(type);


int dt_id=((Integer)enumer.nextElement()).intValue();

DynamicValue dv=DynamicValue.find(teasession._nNode,teasession._nLanguage,dt_id);

if(request.getMethod().equals("POST"))
{
//  String code=d.getType()+"-"+request.getParameter("assignee")+c.get(java.util.Calendar.YEAR)+obj.getPid();
  if(request.getParameter("GoGrant")!=null)
  {
    dv.set(teasession._nNode,teasession._nLanguage,d.getType()+"-"+teasession._nNode);
    /*
    System.out.println(node._nNode);
    out.print(r.getString(teasession._nLanguage,"MakePdf")+"<br/>");
    out.flush();

    java.io.File bmp=java.io.File.createTempFile("edn",".bmp");
    boolean bool=tea.ui.util.XToX.htmlToBmp("http://"+request.getServerName()+":"+request.getServerPort()+"/jsp/type/dynamicvalue/DynamicValuePdfView.jsp;jsessionid="+session.getId()+"?node="+node._nNode,bmp.getAbsolutePath());
    for(int index=0;!bool&&index<10;index++)
    {
      bmp=java.io.File.createTempFile("edn",".bmp");
      bool=tea.ui.util.XToX.htmlToBmp("http://"+request.getServerName()+":"+request.getServerPort()+"/jsp/type/dynamicvalue/DynamicValuePdfView.jsp;jsessionid="+session.getId()+"?node="+node._nNode,bmp.getAbsolutePath());
    }
    if(bool)
    {
      tea.entity.site.Pdf pdf = tea.entity.site.Pdf.find(s);

      java.io.ByteArrayOutputStream baos=new java.io.ByteArrayOutputStream();
      bool=tea.ui.util.XToX.bmpToPdf(bmp.getAbsolutePath(),baos,application.getRealPath(pdf.getHeader()),application.getRealPath(pdf.getFooter()));
      if(bool)
      {
        node.setFile(baos.toByteArray(),teasession._nLanguage);
        out.print(r.getString(teasession._nLanguage,"MakePdfSucceed")+"<SCRIPT>setInterval(\"window.location.replace('/jsp/type/dynamicvalue/DynamicValues.jsp?node="+teasession._nNode+"&community="+s+"');\",3000);</SCRIPT>");
        return;
      }
    }
    out.print(r.getString(teasession._nLanguage,"MakePdfLost")+"<a onclick=\"javascript:location.reload()\" href='javascript:;'>"+r.getString(teasession._nLanguage,"Reload")+"</a>.");
    return;*/
  }else
  {
    dv.set(teasession._nNode,teasession._nLanguage,"");
  }
  response.sendRedirect("/jsp/info/Succeed.jsp?info="+java.net.URLEncoder.encode(r.getString(teasession._nLanguage,"UpdateSuccessful"),"UTF-8")+"&nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8"));
  return;
}


%>

<FORM name="formform111" METHOD=POST action="<%=request.getRequestURI()%>" onSubmit="">
<input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
<input type="hidden" name="type" value="<%=type%>"/>
<input type="hidden" name="community" value="<%=s%>"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>


      <%
      if(dv.getValue()!=null&&dv.getValue().length()>0)
      {%>


  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td><%=r.getString(teasession._nLanguage,"Code")%></td>
      <td><%=dv.getValue()%></td>
    </tr>
  </table>
  <input name="GoDeny" type="submit" value="<%=r.getString(teasession._nLanguage,"CancelAuditing")%>">
  <input name="Back" type="button" value="<%=r.getString(teasession._nLanguage,"CBBack")%>" onClick="window.history.back();">

<%

}else{


  %>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td><%=r.getString(teasession._nLanguage,"Code")%></td>
      <td>
        <%=d.getType()%>-<%=teasession._nNode%>
      </td>
    </tr>
  </table>
  <input name="GoGrant" type="submit" value="<%=r.getString(teasession._nLanguage,"CBGrant")%>" onClick="">
  <input name="Back" type="button" value="<%=r.getString(teasession._nLanguage,"CBBack")%>" onClick="window.history.back();">

<%}%>

</FORM>
<br>
<div id="head6"><img height="6" alt=""></div>

<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>

</body>
</html>


