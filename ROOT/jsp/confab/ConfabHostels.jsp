<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.entity.confab.*" %><%@ page import="tea.resource.Resource" %><%@ page import="tea.entity.site.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

long lo=System.currentTimeMillis();

String community = request.getParameter("community");


Resource r=new Resource("/tea/resource/Dynamic");

String name=request.getParameter("name");
String begin=request.getParameter("begin");
String end=request.getParameter("end");
String code=request.getParameter("code");
String state=request.getParameter("state");

StringBuffer sql=new StringBuffer();
if(name!=null&&name.length()>0)
{

  sql.append(" AND nl.subject LIKE "+DbAdapter.cite("%"+name+"%"));
}
if(begin!=null&&begin.length()>0)
{
  sql.append(" AND n.time >="+DbAdapter.cite(begin));
}
if(end!=null&&end.length()>0)
{
  sql.append(" AND n.time <"+DbAdapter.cite(end));
}
if(code!=null&&code.length()>0)
{
  sql.append(" AND n.node IN (SELECT dv.node FROM DynamicType dt,DynamicValue dv WHERE dv.dynamictype=dt.dynamictype AND dt.type='code' AND dv.value LIKE "+DbAdapter.cite("%"+code+"%")+")");
}else
{
  if(state!=null&&state.length()>0)
  {
    sql.append(" AND n.node IN (SELECT dv.node FROM DynamicType dt,DynamicValue dv WHERE dv.dynamictype=dt.dynamictype AND dt.type='code' AND "+("1".equals(state)?"DATALENGTH(dv.value)>1":"(dv.value IS NULL OR DATALENGTH(dv.value)<1)")+ ")");
  }
}
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="">
function td_calendar(fieldname)
{
  myleft=document.body.scrollLeft+event.clientX-event.offsetX-80;
  mytop=document.body.scrollTop+event.clientY-event.offsetY+140;
  window.showModalDialog("/jsp/include/Calendar.jsp?FIELDNAME="+fieldname,self,"edge:raised;scroll:0;status:0;help:0;resizable:1;dialogWidth:280px;dialogHeight:205px;dialogTop:"+mytop+"px;dialogLeft:"+myleft+"px");
}
</script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "1215677357850")%></h1>
<div id="head6"><img height="6" alt=""></div>
<br>

<FORM name="formform111" METHOD=POST action="" onSubmit="">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td><%=r.getString(teasession._nLanguage, "Code")%>:<input name="code" type="text">
  <td><%=r.getString(teasession._nLanguage, "Name")%>:<input name="name" type="text">
  <td><%=r.getString(teasession._nLanguage, "Time")%>:
  <input name="begin" readonly="readonly" type="text" size="9">
  <img onClick="td_calendar('formform111.begin');"  align="absmiddle" src="/tea/image/public/Calendar2.gif" style="cursor:hand;" >--
  <input name="end" readonly="readonly" type="text" size="9">
  <img onClick="td_calendar('formform111.end');" align="absmiddle" style="cursor:hand;"  src="/tea/image/public/Calendar2.gif">

  <td><input type="submit" value="GO">
  </td></tr>
</table>
</FORM>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <TR id="tableonetr">
    <td><%=r.getString(teasession._nLanguage, "Code")%></td>
    <td><%=r.getString(teasession._nLanguage, "Name")%></td>
    <td><%=r.getString(teasession._nLanguage, "Time")%></td>
    <td><%=r.getString(teasession._nLanguage, "MemberId")%></td>
    <td><%=r.getString(teasession._nLanguage,"1215677709959")%></td>
    <td></td>
  </tr>
  <%
      DbAdapter dbadapter=new DbAdapter();
       try
       {
         dbadapter.executeQuery("SELECT DISTINCT n.node FROM Node n,NodeLayer nl WHERE n.hidden=0 AND n.type>=1024 AND n.node=nl.node AND n.node IN(SELECT node FROM Confabreception) AND n.community="+dbadapter.cite(community)+sql.toString());
         while(dbadapter.next())
         {
           Node nodeobj=Node.find(dbadapter.getInt(1));
           Dynamic d=Dynamic.find(nodeobj.getType());
           Cebbank cebbankobj= Cebbank.find(nodeobj._nNode);
           Confabhostel ch_obj=Confabhostel.find(nodeobj._nNode,teasession._nLanguage);

           String unit=null;
           try
           {
             tea.entity.member.Profile pf=tea.entity.member.Profile.find(nodeobj.getCreator()._strR);
             tea.entity.admin.AdminUnit au=tea.entity.admin.AdminUnit.find(pf.getAdminUnit());
             unit=au.getName();
           }catch(Exception e)
           {
             e.printStackTrace();
           }

           code=null;
           java.util.Enumeration enumer_code=DynamicType.findByDynamic(d.getDynamic(),"code");
           if(enumer_code.hasMoreElements())
           {
             int dt_id=((Integer)enumer_code.nextElement()).intValue();
             //            DynamicType dt=DynamicType.find(dt_id)
             DynamicValue dv=DynamicValue.find(nodeobj._nNode,teasession._nLanguage,dt_id);
             code=dv.getValue();
           }
           %>
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td nowrap><%

if(code!=null)out.print(code);

            %></td>
    <td nowrap><A href="/jsp/type/dynamicvalue/DynamicValueViewTab.jsp?node=<%=nodeobj._nNode%>" target="_blank"><%=nodeobj.getSubject(teasession._nLanguage)%></A></td>
    <td nowrap><%=nodeobj.getTimeToString()%></td>
    <td nowrap><%=nodeobj.getCreator()%></td>
    <td nowrap><%=ch_obj.getTime1()==null?"否":"是"%></td>
    <td nowrap>

      <input type="button" value="<%=r.getString(teasession._nLanguage,"CBEdit")%>" onClick="window.open('/jsp/confab/EditConfabHostel.jsp?node=<%=nodeobj._nNode%>&community=<%=community%>&code=<%=code%>&nexturl='+encodeURIComponent(self.location+''),'_self');"/>




<%--
//附件下载
java.util.Enumeration enumer_file=DynamicType.findByDynamic(d.getDynamic(),"file");
while(enumer_file.hasMoreElements())
{
  int enumer_file_id=((Integer)enumer_file.nextElement()).intValue();
  DynamicType dt_obj=DynamicType.find(enumer_file_id);
  DynamicValue dv_obj=DynamicValue.find(nodeobj._nNode,teasession._nLanguage,enumer_file_id);
  out.print("<INPUT TYPE=BUTTON VALUE="+dt_obj.getName(teasession._nLanguage)+"  onClick=\"window.open('"+dv_obj.getValue()+"', '_self');\">");
}
--%>
    </td>
  </tr>
  <%
         }
       }catch(java.lang.Exception ex)
       {
         ex.printStackTrace();
       }finally
       {
         dbadapter.close();
       }
       %>
</table>
<br>
<div id="head6"><img height="6" alt=""></div>
<%--<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>
</body>
</html>


