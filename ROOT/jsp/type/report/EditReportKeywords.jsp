<%@page contentType="text/html;charset=utf-8" %>
<%@include file="/jsp/include/Header.jsp"%>
<%@page import="tea.entity.node.*" %>

<%
request.setCharacterEncoding("UTF-8");
String community=node.getCommunity();


if((node.getOptions1()& 1) == 0)
{
  if(teasession._rv==null)
  {
    response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
    return;
  }
  AccessMember obj_am = AccessMember.find(node._nNode, teasession._rv._strV);
  if (!node.isCreator(teasession._rv)&&!obj_am.isProvider(39))
  {
    response.sendError(403);
    return;
  }
}
r.add("/tea/ui/node/type/Report/EditReport");

String subject=request.getParameter("Subject");
String type=request.getParameter("Type");
String media=request.getParameter("media");
String classid=request.getParameter("class");
String from=request.getParameter("from");
String to=request.getParameter("to");

StringBuffer param=new StringBuffer();
StringBuffer sqlfrom=new StringBuffer(" FROM Node n,Report r");
StringBuffer sqlwhere=new StringBuffer(" WHERE n.community="+tea.db.DbAdapter.cite(community)+" AND n.type=39 AND n.node=r.node");
if(subject!=null&&subject.length()>0)
{
  sqlfrom.append(",NodeLayer nl");
  sqlwhere.append(" AND nl.node=n.node AND nl.language="+teasession._nLanguage+" AND nl.subject="+tea.db.DbAdapter.cite(subject));
  param.append("&subject="+subject);
}
if(type!=null&&type.length()>0)
{
  sqlwhere.append(" AND n.father="+type);
  param.append("&Type="+type);
}
if((media!=null&&media.length()>0)||(classid!=null&&classid.length()>0)||(from!=null&&from.length()>0)||(to!=null&&to.length()>0))
{
//  sqlfrom.append(",Report r");
  if(media!=null&&media.length()>0)
  {
    sqlwhere.append(" AND r.media_id="+media);
    param.append("&media="+media);
  }
  if(classid!=null&&classid.length()>0)
  {
    sqlwhere.append(" AND r.class_id="+classid);
    param.append("&class="+classid);
  }
  if(from!=null&&from.length()>0)
  {
    sqlwhere.append(" AND r.issuetime>="+tea.db.DbAdapter.cite(from));
    param.append("&from="+from);
  }
  if(to!=null&&to.length()>0)
  {
    sqlwhere.append(" AND r.issuetime<"+tea.db.DbAdapter.cite(to));
    param.append("&to="+to);
  }
}

int pos=0;

if(request.getParameter("Pos")!=null)
pos=Integer.parseInt(request.getParameter("Pos"));

%>
<html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script type="">
function fnonuse(obj)
{
  var ewebeditor=document.all('eWebEditor1');
  if(obj.checked)
  {
    ewebeditor.src="";
    foNew.Text.style.display="";
    ewebeditor.style.display="none";
    setCookie('jsp.type.report.EditReport.nonuse',obj.checked);
  }else
  {
    removeCookie('jsp.type.report.EditReport.nonuse');
    ewebeditor.style.display="";
    ewebeditor.src="/jsp/include/eWebEditor/eWebEditor.jsp?id=Text&style=standard";
    foNew.Text.style.display="none";
  }
}
function td_calendar(fieldname)
{
  myleft=document.body.scrollLeft+event.clientX-event.offsetX-80;
  mytop=document.body.scrollTop+event.clientY-event.offsetY+140;
  window.showModalDialog("/tea/inc/calendar.jsp?FIELDNAME="+fieldname,self,"edge:raised;scroll:0;status:0;help:0;resizable:1;dialogWidth:280px;dialogHeight:205px;dialogTop:"+mytop+"px;dialogLeft:"+myleft+"px");
}
</script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Report")%><%=r.getString(teasession._nLanguage, "Edit")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

<DIV ID="edit_BodyDiv"><div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%>  </div>
  <FORM name=foNew METHOD=get action=""  >
    <input type='hidden' name=Node VALUE="<%=teasession._nNode%>">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">    <tr>

        <td nowrap><%=r.getString(teasession._nLanguage, "Type")%>:</TD>
        <td nowrap>
          <%
          tea.html.DropDown dropdown_type = new tea.html.DropDown("Type",0);
          dropdown_type.setStyle("width:150px;");
          dropdown_type.addOption("","-------------");
          DbAdapter  dbadapter = new DbAdapter();
             try{
                    dbadapter.executeQuery("SELECT DISTINCT n.node FROM Node n,Category c WHERE c.node=n.node AND c.category=39 AND n.community="+dbadapter.cite(community)+" AND n.type=1");
                    while( dbadapter.next())
                    {
                      int integer =  (dbadapter.getInt(1));
                      Node obj=Node.find(integer);
                      dropdown_type.addOption(integer, obj.getSubject(teasession._nLanguage));
                    }
                }catch(Exception exception3)
                {
                    System.out.print(exception3);
                }finally
                {
                    dbadapter.close();
                }
                out.println(dropdown_type);
%>
 </td>
        <td nowrap><%=r.getString(teasession._nLanguage, "media")%>:</TD>
        <td nowrap>
          <%tea.html.DropDown dropdown = new tea.html.DropDown("media",0);
          dropdown.addOption("","-------------");
java.util.Enumeration _media_enumer=Media.find("",0,Integer.MAX_VALUE);
while(_media_enumer.hasMoreElements())
{
Media media_obj=  Media.find(((Integer) _media_enumer.nextElement()).intValue());
dropdown.addOption(media_obj.getMediaID(),media_obj.getName());
}
 out.println(dropdown);
%>
 </td>
        <td nowrap><%=r.getString(teasession._nLanguage, "class")%>:</TD>
        <td nowrap><%
                tea.html.DropDown dropdown1 = new tea.html.DropDown("class",0);
                dropdown1.addOption("","-------------");
                java.util.Enumeration enumer=Classes.findByCommunity(node.getCommunity(),teasession._nLanguage);
                while(enumer.hasMoreElements())
                {
                  Classes class_obj=  Classes.find(((Integer)enumer.nextElement()).intValue());
                  dropdown1.addOption(class_obj.getId(),class_obj.getName());
                }
%>
          <%=dropdown1%>
</td>
  <td nowrap><%=r.getString(teasession._nLanguage, "Subject")%>:</TD>
        <td nowrap><input name="Subject"  class="edit_input" value="<%//=HtmlElement.htmlToText(getNull(subject))%>"/></td>
        <td nowrap><%=r.getString(teasession._nLanguage, "HappenTime")%>:</TD>
        <td nowrap><input type="text" name="from" size="10"/><img alt="" style="cursor:hand;" onclick="td_calendar('foNew.from');" src="/tea/image/public/Calendar2.gif"/>--<input type="text" name="to" size="10"/><img alt=""  style="cursor:hand;" onclick="td_calendar('foNew.to');"  src="/tea/image/public/Calendar2.gif"/></td>
        <td><input type=SUBMIT name="GoFinish" ID="edit_GoFinish" value="GO"></td>
      </tr>
    </table>

  </FORM>
    <FORM name=foEdit METHOD=POST action="/servlet/EditReport"  >
    <input type='hidden' name=Node VALUE="<%=teasession._nNode%>">
    <input type="hidden" name="EditReportKeywords" value="">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<%
int sum=0;
dbadapter = new DbAdapter();
try{
  sum=dbadapter.getInt("SELECT COUNT(DISTINCT n.node) "+sqlfrom.toString()+sqlwhere.toString());
  dbadapter.executeQuery("SELECT DISTINCT n.node,r.issuetime "+sqlfrom.toString()+sqlwhere.toString()+" ORDER BY r.issuetime DESC");
      for(int index=0;index<pos+15&&dbadapter.next(); index++)
      {
        if(index>=pos)
        {
            int integer =(dbadapter.getInt(1));
            Node obj=Node.find(integer);
            Report r= Report.find(integer,teasession._nLanguage);
            %>
            <tr>
              <td nowrap><input value="<%=integer%>" type="checkbox" name="nodes" <%            if(obj.getKeywords(teasession._nLanguage).indexOf(node.getSubject(teasession._nLanguage))!=-1)out.print(" CHECKED ");%>/></TD>
              <td nowrap><%=Node.find(obj.getFather()).getSubject(teasession._nLanguage)%></TD>
              <td nowrap><%=obj.getSubject(teasession._nLanguage)%></TD>
              <td nowrap><%=r.getIssueTimeToString()%></TD>
            </tr>
            <%
            }
          }
}catch(Exception exception3)
{
  System.out.print(exception3);
}finally
{
  dbadapter.close();
}

%>
  <tr><td nowrap></td>
  <td nowrap colspan="3"><%=new FPNL(teasession._nLanguage, request.getRequestURI()+"?node=" + teasession._nNode+param.toString()+ "&Pos=", pos, sum,15)%></TD> </tr>
  </table>

      <center>
<input type="hidden" name="act" value="">
<input type=SUBMIT name="GoBack" id="edit_GoNext" onclick="foEdit.act.value='GoBack';" class="edit_button" value="<%=r.getString(teasession._nLanguage, "GoBack")%>">
<input type=SUBMIT name="GoFinish" ID="edit_GoFinish"  class="edit_button" value="<%=r.getString(teasession._nLanguage, "Finish")%>">
    </center>

 </FORM>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</DIV>
 <div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

