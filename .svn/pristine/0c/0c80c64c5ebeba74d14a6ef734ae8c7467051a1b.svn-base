<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.site.*" %><%@page import="java.io.*" %><%@page import="java.util.*" %><%@page import="tea.html.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.entity.*" %>
<%@page import="java.math.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.ui.TeaSession" %>
<% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}



String community=teasession._strCommunity;
String nexturl=request.getParameter("nexturl");
int dynamic=Integer.parseInt(request.getParameter("dynamic"));
int dynamictype=Integer.parseInt(request.getParameter("dynamictype"));
String name="",content="",type="text",before="",after="";
int sequence=0,defaultvalue=0,filecenter=0,big=0,binding=0;
boolean sync=false,show=true,need=false;
if(dynamictype!=0)
{
  DynamicType dt=DynamicType.find(dynamictype);
  name=dt.getName(teasession._nLanguage);
  content=HtmlElement.htmlToText(dt.getContent(teasession._nLanguage));
  type=dt.getType();
  sequence=dt.getSequence();
  before=HtmlElement.htmlToText(dt.getBefore(teasession._nLanguage));
  after=HtmlElement.htmlToText(dt.getAfter(teasession._nLanguage));
  show=dt.isHidden();
  need=dt.isNeed();
  defaultvalue=dt.getDefaultvalue();
  filecenter=dt.getFilecenter();
  sync=dt.isSync();
  binding=dt.getBinding();
  if(binding>0)
  {
    big=DynamicType.find(binding).getDynamic();
  }
}else
{
  sequence=DynamicType.getMaxSequence(dynamic)+10;
}

Http h=new Http(request);
h.debug=h.debug||"127.0.0.1".equals(request.getRemoteAddr());

%><%!
Resource r=new Resource("/tea/resource/Dynamic");
private String html(Http h,int dynamic,int father,int lang)throws Exception
{
  StringBuffer htm=new StringBuffer();
  Enumeration e=DynamicType.findByDynamic(dynamic," AND father="+father,0,Integer.MAX_VALUE);
  while(e.hasMoreElements())
  {
    int id=((Integer)e.nextElement()).intValue();
    DynamicType obj=DynamicType.find(id);
    int dv=obj.getDefaultvalue();
    String type=obj.getType();

    htm.append("<input type='hidden' name=dynamictypes value="+id+">");
    htm.append("<input type='hidden' name=name_"+id+" value="+obj.getName(lang)+">");
    htm.append("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>");
    htm.append("<td");
    if(father>0)htm.append(" align='right'");
    htm.append(">"+obj.getSequence()+"</td>");
    htm.append("<td>"+(h.debug?id+"、":"")+obj.getName(lang)+"</td>");
    htm.append("<td><input name=before_"+id+" mask='max' value=\""+HtmlElement.htmlToText(obj.getBefore(lang))+"\" type=text></td><td>");
    if("csign".equals(type))
    htm.append("『会签』");
    else if(dv==0 || dv==5 || dv==6)
    htm.append("<textarea name=content_"+id+">"+HtmlElement.htmlToText(obj.getContent(lang))+"</textarea>");
    else
    htm.append(DynamicType.DEFAULTVALUE_TYPE[dv]);
    htm.append("</td><td><input name=after_"+id+" mask='max' value=\""+HtmlElement.htmlToText(obj.getAfter(lang))+"\" type=text></td>");
    htm.append("<td><input type=button onclick=f_act('edit',"+id+") value="+r.getString(lang, "CBEdit")+"><input type=button onclick=f_act('delete',"+id+") value="+r.getString(lang, "CBDelete")+"></td></tr>");
    if(type.equals("folder"))
    {
      htm.append(html(h,dynamic,id,lang));
    }
  }
  return htm.toString();
}
%>
<HTML>
<HEAD>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script type="">
function f_act(a,dt)
{
  if(a=="delete")
  {
    if(!confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>'))
    return;
  }else
  {
    fo.action='/jsp/community/EditDynamicType.jsp';
    //fo.method="get";//加上报错//
  }
  fo.act.value=a;
  fo.dynamictype.value=dt;
  fo.submit();
}
</script>
</HEAD>

<body>

<h1><%=r.getString(teasession._nLanguage, "AttributeManage")%>(<A href="/jsp/community/DynamicTypeView.jsp?dynamic=<%=dynamic%>" target="_blank" ><%=r.getString(teasession._nLanguage, "Preview")%></A>)</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<FORM name="fo" method="post" action="/servlet/EditDynamicType" >
<input type='hidden' name="nexturl" value="<%=nexturl%>">
<input type='hidden' name="community" value="<%=community%>">
<input type='hidden' name="dynamic" value="<%=dynamic%>">
<input type='hidden' name="dynamictype" value="0">
<input type='hidden' name="act">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr ID=tableonetr>
    <TD><%=r.getString(teasession._nLanguage, "Sequence")%></TD>
    <td width="100"><%=r.getString(teasession._nLanguage, "Name")%></TD>
    <td><%=r.getString(teasession._nLanguage, "Before")%></TD>
    <td width="100"><%=r.getString(teasession._nLanguage, "默认值")%></TD>
    <td><%=r.getString(teasession._nLanguage, "After")%></TD>
    <td width="80"><%=r.getString(teasession._nLanguage, "operation")%></td>
  </tr>
  <%=html(h,dynamic,0,teasession._nLanguage)%>
</table>
<input type="button" onclick=f_act('edit',0) value="<%=r.getString(teasession._nLanguage, "CBNew")%>">
<input type="submit" name="edit" value="<%=r.getString(teasession._nLanguage, "Submit")%>" class="edit_button" id="edit_submit" >
</form>

<input name="Submit" type="button" class="edit_button" value="<%=r.getString(teasession._nLanguage, "GoBack")%>" onclick="window.open('/jsp/community/EditDynamic.jsp?community=<%=community%>&dynamic=<%=dynamic%>&nexturl=<%=java.net.URLEncoder.encode(nexturl, "UTF-8")%>','_self');">
<input type="button" onclick="window.open('/jsp/community/SetDynamicDtfb.jsp?dynamic=<%=dynamic%>','','width=500,height=300');" value="<%=r.getString(teasession._nLanguage, "1218512944875")%>">
<input name="button" type="button" class="edit_button" value="<%=r.getString(teasession._nLanguage, "GoFinish")%>" onclick="window.open('<%=nexturl%>','_self');">

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
