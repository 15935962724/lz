<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
long lo=System.currentTimeMillis();
//r.add("/tea/ui/member/community/EditCommunity");
            String s = request.getParameter("community");
if(s==null)
s=node.getCommunity();
/*
                boolean flag = s == null;
                if(!flag && !teasession._rv.isWebMaster() && !teasession._rv.isOrganizer(s))
                {
                    response.sendError(403);
                    return;
                }
*/
String name=request.getParameter("name");
String begin=request.getParameter("begin");
String end=request.getParameter("end");
String cebbank=request.getParameter("cebbank");
r.add("/tea/resource/Dynamic");
tea.entity.site.DCommunity dc=tea.entity.site.DCommunity.find(s);
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
        </script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Search")%></h1>
<div id="head6"><img height="6" alt=""></div>
<br>
<FORM name="formform111" METHOD=POST action="" onSubmit="">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td><%=r.getString(teasession._nLanguage, "Code")%>:<input name="cebbank" type="text">
  <td><%=r.getString(teasession._nLanguage, "Name")%>:<input name="name" type="text">
  <td><%=r.getString(teasession._nLanguage, "Time")%>:
  <input name="begin" readonly="readonly" type="text" size="9">
  <img onClick="td_calendar('formform111.begin');"  align="absmiddle" src="/tea/image/public/Calendar2.gif" style="cursor:hand;" >--
  <input name="end" readonly="readonly" type="text" size="9">
  <img onClick="td_calendar('formform111.end');" align="absmiddle" style="cursor:hand;"  src="/tea/image/public/Calendar2.gif">
  <td><input name="" type="submit" value="GO">
  </td></tr></table>
</FORM>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <TR id="tableonetr">
    <td><%=r.getString(teasession._nLanguage, "Code")%></td>
    <td><%=r.getString(teasession._nLanguage, "Name")%></td>
    <td><%=r.getString(teasession._nLanguage, "Template")%></td>
    <td><%=r.getString(teasession._nLanguage, "States")%></td>
    <td><%=r.getString(teasession._nLanguage, "Time")%></td>
    <td><%//=r.getString(teasession._nLanguage, "MemberId")%></td>
  </tr>
  <%
       tea.db.DbAdapter dbadapter=new tea.db.DbAdapter();
       try
       {
         StringBuffer sql=new StringBuffer();
         if(name!=null&&name.length()>0)
         {
           sql.append(" AND nl.subject LIKE "+dbadapter.cite("%"+name+"%"));
         }
         if(begin!=null&&begin.length()>0)
         {
           sql.append(" AND n.time >="+dbadapter.cite(begin));
         }
         if(end!=null&&end.length()>0)
         {
           sql.append(" AND n.time <"+dbadapter.cite(end));
         }
         if(cebbank!=null&&cebbank.length()>0)
         {
           sql.append(" AND n.node IN (SELECT dv.node FROM DynamicType dt,DynamicValue dv WHERE dv.dynamictype=dt.dynamictype AND dt.type='code' AND dv.value LIKE "+dbadapter.cite("%"+cebbank+"%")+")");
         }
         dbadapter.executeQuery("SELECT DISTINCT n.node,n.time FROM Node n,NodeLayer nl WHERE n.type>=1024 AND n.node=nl.node AND rcreator="+dbadapter.cite(teasession._rv._strR)+" AND vcreator="+dbadapter.cite(teasession._rv._strV)+" AND n.community="+dbadapter.cite(s)+sql.toString()+" ORDER BY n.time");
         while(dbadapter.next())
         {
           tea.entity.node.Node nodeobj=           tea.entity.node.Node.find(dbadapter.getInt(1));
           tea.entity.site.Dynamic d=           tea.entity.site.Dynamic.find(nodeobj.getType());
           tea.entity.node.Cebbank cebbankobj= tea.entity.node.Cebbank.find(nodeobj._nNode);

           java.util.Enumeration enumer_code=tea.entity.site.DynamicType.findByDynamic(d.getDynamic(),"code");
           String code="";
           if(enumer_code.hasMoreElements())
           {
             int dt_id=((Integer)enumer_code.nextElement()).intValue();
             //            tea.entity.site.DynamicType dt=tea.entity.site.DynamicType.find(dt_id)
             tea.entity.node.DynamicValue dv=tea.entity.node.DynamicValue.find(nodeobj._nNode,teasession._nLanguage,dt_id);
             code=dv.getValue();
             if(code==null)
             code="";
           }
           %>
  <tr>
    <td nowrap><%
             out.print(code);
            %></td>
    <td nowrap><A href="/jsp/type/dynamicvalue/DynamicValueViewTab.jsp?node=<%=nodeobj._nNode%>" target="_blank"><%=nodeobj.getSubject(teasession._nLanguage)%></A></td>
    <td nowrap><%=d.getName(teasession._nLanguage)%></td>
    <td nowrap><%=r.getString(teasession._nLanguage, nodeobj.isHidden()?"SaveNoUp":((code.length()>0)?"Auditing":"UpNoAuditing"))%></td>
    <td nowrap><%=nodeobj.getTimeToString()%></td>
    <td ><%
         if(code.length()>0)
         {
         %>
      <!-- input type="button" value="<%=r.getString(teasession._nLanguage,"CBDownload")%>" onclick="window.open('/jsp/type/dynamicvalue/CebbankPdfDownload.jsp?node=<%=nodeobj._nNode%>','_self');""/-->
      <%}else{%>
      <input type="button" value="<%=r.getString(teasession._nLanguage,"CBEdit")%>"  onclick="window.open('/jsp/type/dynamicvalue/EditCebbankDynamicValue.jsp?node=<%=nodeobj._nNode%>&nexturl='+((self.location+'').replace('?','%3F').replace('?','%3F').replace('?','%3F').replace('=','%3D').replace('=','%3D').replace('=','%3D').replace('=','%3D').replace('=','%3D').replace('&','%26').replace('&','%26').replace('&','%26').replace('&','%26')),'_self');"/>

<%
if(nodeobj.isLayerExisted(teasession._nLanguage))
{
%>
<input type="button" value="<%=r.getString(teasession._nLanguage,"CBDelete")%>" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>')){window.open('/servlet/DeleteNode?node=<%=nodeobj._nNode%>&nexturl='+((self.location+'').replace('?','%3F').replace('?','%3F').replace('?','%3F').replace('=','%3D').replace('=','%3D').replace('=','%3D').replace('=','%3D').replace('=','%3D').replace('&','%26').replace('&','%26').replace('&','%26').replace('&','%26')),'_self');}"/>
<%}%>

      <%}%>
<!--      <INPUT TYPE=BUTTON VALUE="<%=r.getString(teasession._nLanguage, "CBTalkbacks")%>(<%=tea.entity.node.Talkback.count(nodeobj._nNode)%>)" ID="CBPostTalkback" CLASS="edit_button" onClick="window.open('/jsp/talkback/CebbankTalkbacks.jsp?node=<%=nodeobj._nNode%>', '_self');">-->
<%
//附件下载
java.util.Enumeration enumer_file=tea.entity.site.DynamicType.findByDynamic(d.getDynamic(),"file");
while(enumer_file.hasMoreElements())
{
  int enumer_file_id=((Integer)enumer_file.nextElement()).intValue();
  tea.entity.site.DynamicType dt_obj=tea.entity.site.DynamicType.find(enumer_file_id);
  tea.entity.node.DynamicValue dv_obj=tea.entity.node.DynamicValue.find(nodeobj._nNode,teasession._nLanguage,enumer_file_id);
  out.print("<INPUT TYPE=BUTTON VALUE="+dt_obj.getName(teasession._nLanguage)+"  onClick=\"window.open('"+dv_obj.getValue()+"', '_self');\">");
}
%>
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
<div id="dynamicvaluesmembertab_new">
<h1><%=r.getString(teasession._nLanguage, "New")%></h1>
<div id="head6"><img height="6" alt=""></div>
<FORM name="form2" METHOD=POST action="/jsp/type/dynamicvalue/EditDynamicValue.jsp" onSubmit="">
  <input type="hidden" name="NewNode" value="ON"/>
  <%
if(dc.getNode()<=0)
{
  out.println(r.getString(teasession._nLanguage, "ErrorNoFather"));
  return;
}
java.util.Enumeration enumer=tea.entity.node.Node.findAllSons(dc.getNode());
if(!enumer.hasMoreElements())
{
  out.println(r.getString(teasession._nLanguage, "ErrorNoCategory"));
  return;
}
while(enumer.hasMoreElements())
{
  int node_id=((Integer)  enumer.nextElement()).intValue();
  tea.entity.node.Node node_enumer=  tea.entity.node.Node.find(node_id);
  tea.entity.node.Category c=tea.entity.node.Category.find(node_id);

  %>
  <!--input  id="radio" type="radio" name="Node" value="<%=node_id%>"/><%//=node_enumer.getSubject(teasession._nLanguage)%>-->
  <input type="button" value="<%=r.getString(teasession._nLanguage,"CBNew")%>-<%=node_enumer.getSubject(teasession._nLanguage)%>" onClick="window.open('/jsp/type/dynamicvalue/EditCebbankDynamicValue.jsp?node=<%=node_id%>&NewNode=ON&Type=<%=c.getCategory()%>&nexturl='+((self.location+'').replace('?','%3F').replace('?','%3F').replace('?','%3F').replace('=','%3D').replace('=','%3D').replace('=','%3D').replace('=','%3D').replace('=','%3D').replace('&','%26').replace('&','%26').replace('&','%26').replace('&','%26')),'_self');"/>
  <%}%>
</FORM>
</div>
<div id="head6"><img height="6" alt=""></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
<br>
</body>
</html>

