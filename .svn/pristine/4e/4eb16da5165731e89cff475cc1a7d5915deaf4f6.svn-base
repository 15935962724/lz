<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.entity.admin.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.resource.Resource" %><%@ page import="tea.entity.site.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

long lo=System.currentTimeMillis();
//r.add("/tea/ui/member/community/EditCommunity");
String s = teasession._strCommunity;

Resource r=new Resource("/tea/resource/Dynamic");


int sort = 0;
if(request.getParameter("sort")!=null && request.getParameter("sort").length()>0)
     sort = Integer.parseInt(request.getParameter("sort"));

String name=request.getParameter("name");
String begin=request.getParameter("begin");
String end=request.getParameter("end");
String cebbank=request.getParameter("cebbank");
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
if(cebbank!=null&&cebbank.length()>0)
{
  sql.append(" AND n.node IN (SELECT dv.node FROM DynamicType dt,DynamicValue dv WHERE dv.dynamictype=dt.dynamictype AND dt.type='code' AND dv.value LIKE "+DbAdapter.cite("%"+cebbank+"%")+")");
}else
{
  if(state!=null&&state.length()>0)
  {
    sql.append(" AND n.node IN (SELECT dv.node FROM DynamicType dt,DynamicValue dv WHERE dv.dynamictype=dt.dynamictype AND dt.type='code' AND "+("1".equals(state)?"DATALENGTH(dv.value)>1":"(dv.value IS NULL OR DATALENGTH(dv.value)<1)")+ ")");
  }
}

String nexturl=java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8");


%><html>
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
<h1><%=r.getString(teasession._nLanguage, "Search")%></h1>
<div id="head6"><img height="6" alt=""></div>
<br>

<FORM name="formform111" METHOD=POST action="<%=request.getRequestURL()%>" >

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
 <!-- <td><%=r.getString(teasession._nLanguage, "Code")%>:<input name="cebbank" type="text">-->
  <td><%=r.getString(teasession._nLanguage, "Name")%>:<input name="name" type="text">
  <td><%=r.getString(teasession._nLanguage, "Time")%>:
  <input name="begin" readonly="readonly" type="text" size="9"><img onClick="td_calendar('formform111.begin');"  align="absmiddle" src="/tea/image/public/Calendar2.gif" style="cursor:hand;" >--
  <input name="end" readonly="readonly" type="text" size="9"><img onClick="td_calendar('formform111.end');" align="absmiddle" style="cursor:hand;"  src="/tea/image/public/Calendar2.gif">
  <td><%=r.getString(teasession._nLanguage, "States")%>:<select name="state">
    <option selected value="">------------</option>
    <option value="1"><%=r.getString(teasession._nLanguage, "Auditing")%></option>
    <option value="0"><%=r.getString(teasession._nLanguage, "NoAuditing")%></option>
  </select>
  <td><input type="submit" value="GO">
  </td>
</tr>
</table>
</FORM>


<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <TR id="tableonetr">
  <td nowrap="nowrap">序号</td>
   <!-- <td><%=r.getString(teasession._nLanguage, "Code")%></td>-->
    <td nowrap><%=r.getString(teasession._nLanguage, "Name")%></td>
    <td nowrap><%=r.getString(teasession._nLanguage, "Time")%></td>
    <td nowrap><%=r.getString(teasession._nLanguage, "MemberId")%></td>
    <td nowrap><%=r.getString(teasession._nLanguage, "Template")%></td>
    <td nowrap>操作</td>
  </tr>
  <%
       DbAdapter db=new DbAdapter();
       try
       {
         db.executeQuery("SELECT DISTINCT n.node FROM Node n,NodeLayer nl WHERE n.hidden=0 AND n.type>=1024 AND n.node=nl.node AND n.community="+db.cite(s)+sql.toString());
        int index=1;
         while(db.next())
         {
           Node nodeobj=Node.find(db.getInt(1));
           Dynamic d=Dynamic.find(nodeobj.getType());
           Cebbank cebbankobj= Cebbank.find(nodeobj._nNode);

           String unit=null;
           try
           {
             Profile pf=Profile.find(nodeobj.getCreator()._strR);
             AdminUnit au=AdminUnit.find(pf.getAdminUnit());
             unit=au.getName();
           }catch(Exception e)
           {
             e.printStackTrace();
           }

           java.util.Enumeration enumer_code=DynamicType.findByDynamic(d.getDynamic(),"code");
           String code="";
           if(enumer_code.hasMoreElements())
           {
             int dt_id=((Integer)enumer_code.nextElement()).intValue();
             //DynamicType dt=DynamicType.find(dt_id)
             DynamicValue dv=DynamicValue.find(nodeobj._nNode,teasession._nLanguage,dt_id);
             code=dv.getValue();
             if(code==null)
             code="";

           }
           Node node_obj = Node.find(nodeobj._nNode);
           Dynamic d_obj=Dynamic.find(node_obj.getType());
           if(d_obj.getSort()==sort){
             %>
             <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
               <td width="20" align="center" nowrap><%out.print(index);
                // out.print("<a href='/jsp/confab/ConfabQrcView.jsp?node="+nodeobj._nNode+"'>"+code+"</a>");
                 %></td>
                 <td nowrap><A href="/jsp/type/dynamicvalue/DynamicValueViewTab.jsp?node=<%=nodeobj._nNode%>" target="_blank"><%=nodeobj.getSubject(teasession._nLanguage)%></A></td>
                 <td nowrap align="center"><%=nodeobj.getTimeToString()%></td>
                 <td align="center" nowrap><%=nodeobj.getCreator()%></td>
                 <td align="center" nowrap><%=d.getName(teasession._nLanguage)%></td>
                 <td align="center" nowrap>
                 <%
                 if(code.length()>0)
                 {
                   //out.print("<input type=button value="+r.getString(teasession._nLanguage,"CBDownload")+" onclick=window.open('/jsp/type/dynamicvalue/CebbankPdfDownload.jsp?node="+nodeobj._nNode+"','_self');>");
                   // out.print("<input type=button value="+r.getString(teasession._nLanguage,"胸卡")+" onclick=window.open('/jsp/confab/ConfabQrcView.jsp?node="+nodeobj._nNode+"','','width=500px,height=300px');>");
                 }else if(nodeobj.isLayerExisted(teasession._nLanguage))
                 {
                   out.print("<input type=button value="+r.getString(teasession._nLanguage,"CBDelete")+" onClick=\"if(confirm('"+r.getString(teasession._nLanguage, "ConfirmDelete")+"')){window.open('/servlet/DeleteNode?node="+nodeobj._nNode+"&nexturl='+encodeURIComponent(self.location.href),'_self');}\">");
                 }
                 %>
                 <input type="button" value="<%=code.length()>0?r.getString(teasession._nLanguage,"CancelAuditing"):r.getString(teasession._nLanguage,"Auditing")%>" onClick="window.open('/jsp/confab/EditConfabAuditing.jsp?node=<%=nodeobj._nNode%>&community=<%=s%>&type=<%=nodeobj.getType()%>&nexturl=<%=nexturl%>', '_self');"/>
                 <!--      <INPUT TYPE=BUTTON VALUE="<%=r.getString(teasession._nLanguage, "CBTalkbacks")%>(<%=Talkback.count(nodeobj._nNode)%>)" ID="CBPostTalkback" CLASS="edit_button" onClick="window.open('/jsp/talkback/CebbankTalkbacks.jsp?node=<%=nodeobj._nNode%>', '_self');">-->
                   <!--INPUT TYPE=BUTTON VALUE="上传PDF"  CLASS="edit_button" onClick="window.open('/jsp/type/dynamicvalue/EditNodeFile.jsp?node=<%=nodeobj._nNode%>', '_self');"-->
                   <%
                   //附件下载
                   java.util.Enumeration enumer_file=DynamicType.findByDynamic(d.getDynamic(),"file");
                   while(enumer_file.hasMoreElements())
                   {
                     int enumer_file_id=((Integer)enumer_file.nextElement()).intValue();
                     DynamicType dt_obj=DynamicType.find(enumer_file_id);
                     DynamicValue dv_obj=DynamicValue.find(nodeobj._nNode,teasession._nLanguage,enumer_file_id);
                     out.print("<INPUT TYPE=BUTTON VALUE="+dt_obj.getName(teasession._nLanguage)+"  onClick=\"window.open('"+dv_obj.getValue()+"', '_self');\">");
                   }
                   %>
               </td>
             </tr>
             <%
             index++;
             }
           }
       }catch(java.lang.Exception ex)
       {
         ex.printStackTrace();
       }finally
       {
         db.close();
       }
%>
</table>

<input type="button" onClick="window.open('/servlet/DynamicValueExport?community=<%=s%>','_self');" value="<%=r.getString(teasession._nLanguage,"ExportToExcel")%>"/>
<input type="button" onClick="window.open('/servlet/DynamicValueExport?community=<%=s%>&state=1','_self');" value="<%=r.getString(teasession._nLanguage,"ExportAuditing")%>"/>

<br>
<div id="head6"><img height="6" alt=""></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
