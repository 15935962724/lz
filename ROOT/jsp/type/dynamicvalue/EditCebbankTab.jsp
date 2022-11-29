<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
long lo=System.currentTimeMillis();
//r.add("/tea/ui/member/community/EditCommunity");
String s = request.getParameter("community");
if(s==null)
s=node.getCommunity();

r.add("/tea/resource/Dynamic");
%>
<html>
<head>
<link href="/res/<%=s%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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


tea.entity.node.Cebbank obj=tea.entity.node.Cebbank.find(teasession._nNode);
tea.entity.site.Dynamic d=tea.entity.site.Dynamic.find(node.getType());
java.util.Enumeration enumer=tea.entity.site.DynamicType.findByDynamic(node.getType(),"code");
if(!enumer.hasMoreElements())
{
  response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("模板没有定义 合同类型或合同编号","UTF-8"));
  return;
}

int dt_id=((Integer)enumer.nextElement()).intValue();
tea.entity.node.DynamicValue dv=tea.entity.node.DynamicValue.find(node._nNode,teasession._nLanguage,dt_id);

if(request.getMethod().equals("POST"))
{
//  String code=d.getType()+"-"+request.getParameter("assignee")+c.get(java.util.Calendar.YEAR)+obj.getPid();
  if(request.getParameter("GoGrant")!=null)
  {
    java.util.Calendar c=java.util.Calendar.getInstance();
    String code=obj.set(d.getType(),request.getParameter("assignee"),c.get(java.util.Calendar.YEAR) ,teasession._rv.toString(),s);
    dv.set(node._nNode,teasession._nLanguage,code);
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
    obj.delete();
    dv.set(node._nNode,teasession._nLanguage,"");
  }
  response.sendRedirect("/jsp/info/Succeed.jsp?info="+java.net.URLEncoder.encode(r.getString(teasession._nLanguage,"UpdateSuccessful")+"<SCRIPT>setInterval(\"window.location.replace('/jsp/type/dynamicvalue/DynamicValuesTab.jsp?node="+teasession._nNode+"&community="+s+"');\",3000);</SCRIPT>","UTF-8"));
  return;
}


%>

<FORM name="formform111" METHOD=POST action="" onSubmit="">
      <%if(dv.getValue()!=null&&dv.getValue().length()>0)
      {%>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td><%=r.getString(teasession._nLanguage,"Code")%></td>
      <td>
        <%=dv.getValue()%>
              </td>
    </tr>
  </table>
  <input name="GoDeny" type="submit" value="<%=r.getString(teasession._nLanguage,"CancelAuditing")%>">
  <input name="Back" type="button" value="<%=r.getString(teasession._nLanguage,"CBBack")%>" onclick="window.history.back();">
<%      }else{
        %>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td><%=r.getString(teasession._nLanguage,"Code")%></td>
      <td>
        <%=d.getType()%>
      <select name="assignee">
      <option value="A">企业年金理事会</option>
      <option value="B">法人受托机构</option>
      </select>
      <%
      tea.entity.admin.AdminUnit au = tea.entity.admin.AdminUnit.findByPid(obj.getPid(), s);
      int serial = (au.getSerial()) + 1;
      java.text.DecimalFormat df = new java.text.DecimalFormat("0000");
      String str = df.format((long) serial);

     java.util.Calendar c=    java.util.Calendar.getInstance();
     out.print(c.get(java.util.Calendar.YEAR));
      %>
      <%=obj.getPid()%>
      <%=str%>
         </td>
    </tr>
  </table>
    <input name="GoGrant" type="submit" value="<%=r.getString(teasession._nLanguage,"CBGrant")%>" onclick="">
  <input name="Back" type="button" value="<%=r.getString(teasession._nLanguage,"CBBack")%>" onclick="window.history.back();">
        <%}%>

</FORM>
<br>
<div id="head6"><img height="6" alt=""></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>

</body>
</html>

