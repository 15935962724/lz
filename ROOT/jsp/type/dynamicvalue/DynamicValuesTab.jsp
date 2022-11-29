<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%

long lo=System.currentTimeMillis();
//r.add("/tea/ui/member/community/EditCommunity");
            String s = request.getParameter("community");
if(s==null)
s=node.getCommunity();

r.add("/tea/resource/Dynamic");
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
String state=request.getParameter("state");
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
  <td><%=r.getString(teasession._nLanguage, "States")%>:<select name="state">
    <option selected value="">------------</option>
    <option value="1"><%=r.getString(teasession._nLanguage, "Auditing")%></option>
    <option value="0"><%=r.getString(teasession._nLanguage, "NoAuditing")%></option>
  </select>
  <td><input name="" type="submit" value="GO">
  </td></tr></table>
</FORM>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <TR id="tableonetr">
    <td><%=r.getString(teasession._nLanguage, "Code")%></td>
    <td><%=r.getString(teasession._nLanguage, "Name")%></td>
    <td id="suoshufenhang"><%=r.getString(teasession._nLanguage, "TheirBranch")%></td>
    <td><%=r.getString(teasession._nLanguage, "Time")%></td>
    <td><%=r.getString(teasession._nLanguage, "MemberId")%></td>
    <td><%=r.getString(teasession._nLanguage, "Template")%></td>
    <td></td>
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
         }else
         {
           if(state!=null&&state.length()>0)
           {
             sql.append(" AND n.node IN (SELECT dv.node FROM DynamicType dt,DynamicValue dv WHERE dv.dynamictype=dt.dynamictype AND dt.type='code' AND "+("1".equals(state)?"DATALENGTH(dv.value)>1":"(dv.value IS NULL OR DATALENGTH(dv.value)<1)")+ ")");
           }
         }

         dbadapter.executeQuery("SELECT DISTINCT n.node FROM Node n,NodeLayer nl WHERE n.hidden=0 AND n.type>=1024 AND n.node=nl.node AND n.community="+dbadapter.cite(s)+sql.toString());
         while(dbadapter.next())
         {
           tea.entity.node.Node nodeobj=           tea.entity.node.Node.find(dbadapter.getInt(1));
           tea.entity.site.Dynamic d=           tea.entity.site.Dynamic.find(nodeobj.getType());
           tea.entity.node.Cebbank cebbankobj= tea.entity.node.Cebbank.find(nodeobj._nNode);

           String unit=null;
           try
           {
             tea.entity.member.Profile pf=tea.entity.member.Profile.find(nodeobj.getCreator()._strR);//,s
             tea.entity.admin.AdminUnit au=tea.entity.admin.AdminUnit.find(pf.getAdminUnit());
             unit=au.getName();
           }catch(Exception e)
           {
             e.printStackTrace();
           }


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
    <td nowrap id="suoshufenhang"><%if(unit!=null)out.print(unit);%></td>
    <td nowrap><%=nodeobj.getTimeToString()%></td>
    <td nowrap><%=nodeobj.getCreator()%></td>
    <td nowrap><%=d.getName(teasession._nLanguage)%></td>
    <td nowrap>
    <%

    if(code.length()>0)
    {
         %>
      <!-- <input type="button" value="<%=r.getString(teasession._nLanguage,"CBDownload")%>" onclick="window.open('/jsp/type/dynamicvalue/CebbankPdfDownload.jsp?node=<%=nodeobj._nNode%>','_self');""/> -->
      <%}else
      if(nodeobj.isLayerExisted(teasession._nLanguage))
      {
      %>
<input type="button" value="<%=r.getString(teasession._nLanguage,"CBDelete")%>" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>')){window.open('/servlet/DeleteNode?node=<%=nodeobj._nNode%>&nexturl='+((self.location+'').replace('?','%3F').replace('?','%3F').replace('?','%3F').replace('=','%3D').replace('=','%3D').replace('=','%3D').replace('=','%3D').replace('=','%3D').replace('&','%26').replace('&','%26').replace('&','%26').replace('&','%26')),'_self');}"/>
<%}%>

<input type="button" value="<%=code.length()>0?r.getString(teasession._nLanguage,"CancelAuditing"):r.getString(teasession._nLanguage,"Auditing")%>" onClick="window.open('/jsp/type/dynamicvalue/EditCebbankTab.jsp?node=<%=nodeobj._nNode%>&community=<%=s%>', '_self');"/>


<!--      <INPUT TYPE=BUTTON VALUE="<%=r.getString(teasession._nLanguage, "CBTalkbacks")%>(<%=tea.entity.node.Talkback.count(nodeobj._nNode)%>)" ID="CBPostTalkback" CLASS="edit_button" onClick="window.open('/jsp/talkback/CebbankTalkbacks.jsp?node=<%=nodeobj._nNode%>', '_self');">-->
  <!--INPUT TYPE=BUTTON VALUE="上传PDF"  CLASS="edit_button" onClick="window.open('/jsp/type/dynamicvalue/EditNodeFile.jsp?node=<%=nodeobj._nNode%>', '_self');"-->
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
<input type="button" onClick="window.open('/servlet/DynamicValueExport?community=<%=s%>','_self');" value="<%=r.getString(teasession._nLanguage,"ExportToExcel")%>"/>
<input type="button" onClick="window.open('/servlet/DynamicValueExport?community=<%=s%>&state=1','_self');" value="<%=r.getString(teasession._nLanguage,"ExportAuditing")%>"/>
<br>
<div id="head6"><img height="6" alt=""></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

