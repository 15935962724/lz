<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%
//request.setCharacterEncoding("gb2312");
r.add("/tea/ui/node/aded/EditAded");

/*
if(!teasession._rv.isAdManager())
{
  response.sendError(403);
  return;
}
*/


String s = teasession.getParameter("aded");
boolean flag = s == null;
if(!flag)
{
  Aded aded = Aded.find(Integer.parseInt(s));
 // if(!aded.isCreator(teasession._rv))
 // {
   // response.sendError(403);
   // return;
 // }
}
int i = 0;
int k = 0;
Date date1 = null;
Date date3 = null;
int i1 = 0;
String s2 = "";
String s4 = "";
String s6 = "";
int j1 = 0;
String picture;
if(!flag)
{
  int l1 = Integer.parseInt(s);
  tea.entity.node.Aded aded2 = tea.entity.node.Aded.find(l1);
  i = aded2.getAding();
  k = aded2.getOptions();
  date1 = aded2.getStartTime();
  date3 = aded2.getStopTime();
  i1 = aded2.getExpectedImpression() / 1000;
  s2 = aded2.getAlt(teasession._nLanguage);
  s4 = aded2.getClickUrl(teasession._nLanguage);
  s6 = aded2.getPictureUrl(teasession._nLanguage);
  //                  j1 = aded2.getPictureLen(teasession._nLanguage);
  picture=aded2.getPicture(teasession._nLanguage);
} else
{
  i = Integer.parseInt(request.getParameter("Ading"));
  picture="";
}
Ading ading = Ading.find(i);
int j2 = ading.getNode();
int l2 = ading.getStyle();
Date date4 = ading.getStartTime();
Date date5 = ading.getStopTime();
String s7 = ading.getName(teasession._nLanguage);

%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "CBAdeds")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
  <%if(flag){%>
  <FORM name=foEdit METHOD=POST action="/servlet/EditAded" ENCtype=multipart/form-data onSubmit="return(submitInteger(this.ExpectedImpression,'<%=r.getString(teasession._nLanguage, "InvalidExpectedImpression")%>'))">
  <%}else{%>
  <FORM name=foEdit METHOD=POST action="/servlet/EditAded" ENCtype=multipart/form-data >
    <%}%>
    <input type='hidden' name="community" value="<%=teasession._strCommunity%>" />
      <input type='hidden' name="repository" value="ading"/>
      <input type='hidden' name="watermark" value="false"/>
      <input type='hidden' name="node" VALUE="<%=teasession._nNode%>"/>
    <%if(!flag){%>
    <input type='hidden' name=Aded VALUE="<%=s%>">
    <%}%>
    <input type='hidden' name=Ading VALUE="<%=i%>">

   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Name")%>:</td>
        <td><%=s7%> </td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "AdingNode")%>:</td>
        <td><%--<A href="/servlet/Folder?node=<%=teasession._nNode%>">home</A>--%>
          <%=tea.entity.node.Node.find(j2).getAnchor(teasession._nLanguage)%> </td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Style")%>:</td>
        <td><%=r.getString(teasession._nLanguage, Section.APPLY_STYLE[l2])%></td>
      </tr>
      <tr>
        <td>终端位置:</td>
        <td><%=(ading.status==0?"电脑端":"手机端")%></td>
      </tr>
      <!-- 
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Options")%>:</td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name=AdedONewWindow value=null <%=getCheck((k & 1) != 0)%>>
          <%=r.getString(teasession._nLanguage, "AdedONewWindow")%>
          <input  id="CHECKBOX" type="CHECKBOX" name=AdedOPublic value=null <%=getCheck((k & 2) != 0)%>>
          <%=r.getString(teasession._nLanguage, "AdedOPublic")%> </td>
      </tr>
       -->
      <tr>
        <%--
if(date4 != null)
{%><td><%=r.getString(teasession._nLanguage, "StartTime")%>:</td>
<td>
<%=new Text("" + (new SimpleDateFormat("yyyy.MM.dd hh:mm")).format(date4) + "")%>

<tr><td><%=r.getString(teasession._nLanguage, "StopTime")%>:</td>
<td>
<%=new Text("" + (new SimpleDateFormat("yyyy.MM.dd hh:mm")).format(date5) + "")%>
<%
} <tr>
--%>
<td><%=r.getString(teasession._nLanguage, "StartTime")%>:</td>
        <td>
          <%boolean bool=false;
          if(date1 == null)
                {bool=true;
                    Date date6 = new Date(System.currentTimeMillis());
                    date1 = date6;
                    date3 = date6;
                }
                //cell4.add(new TimeSelection("Start", date1));

               // Row row7 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "StopTime") + ":"), true));
                //row7.add(new Cell(new TimeSelection("Stop", date3)));
%>          <%=new TimeSelection("Start", date1)%>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "StopTime")%>:</td>
        <td><%=new TimeSelection("Stop", date3)%>
      <tr>
        <td> </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name=AdingOForever  <%=getCheck(bool)%>>
          <%=r.getString(teasession._nLanguage, "AdingOForever")%> </td>
      </tr>
      <!-- 
      <tr>
        <td><%=r.getString(teasession._nLanguage, "ExpectedImpression")%>:</td>
        <td><%
if(flag)
{%>
          <input type="TEXT" class="edit_input"  name=ExpectedImpression VALUE="<%=Integer.toString(i1)%>">
          <%}else
{%>
          <%=Integer.toString(i1)%>
          <%}
%>
          <%=r.getString(teasession._nLanguage, "KiloTimes")%> </td>
      </tr>
       -->
       <!-- 期望显示次数 -->
       <input type="hidden" class="edit_input"  name=ExpectedImpression VALUE="0">
       
       
      <tr>
        <td><%=r.getString(teasession._nLanguage, "ClickUrl")%>:</td>
        <td><input type="TEXT" class="edit_input"  name=ClickUrl VALUE="<%=s4%>" SIZE=70 MAXLENGTH=255>
        </td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Alt")%>:</td>
        <td><input type="TEXT" class="edit_input"  name=Alt VALUE="<%=s2%>" SIZE=70 MAXLENGTH=255>
        </td>
      </tr>
      <input type="hidden" class="edit_input"  name=PictureUrl VALUE="">
      <!--tr>
        <td><%=r.getString(teasession._nLanguage, "PictureUrl")%>:</td>
        <td><input type="TEXT" class="edit_input"  name=PictureUrl VALUE="<%=s6%>" SIZE=70 MAXLENGTH=255>
        </td>
      </tr-->
      <tr><%//=new FileInput(teasession._nLanguage, "Picture", j1)%>
       <td><%=r.getString(teasession._nLanguage, "Picture")%>:</td>
<td COLSPAN=6>
<input type="file" name="Picture" class="edit_input"/><%--if(j1 > 0)out.print(j1 +r.getString(teasession._nLanguage, "Bytes"));%>
<input  id="CHECKBOX" type="CHECKBOX" name=ClearPicture value=null><%=r.getString(teasession._nLanguage, "Clear")--%>
<%=r.getString(teasession._nLanguage, "Or")%><input type="text" name="PictureName" value="<%=picture%>" size="28" maxlength="128">
        </td>
      </tr>
    </table>
    <input type="submit" class="edit_button" id="edit_submit" value="<%=r.getString(teasession._nLanguage, "Submit")%>">
    <input type="button" value="<%=r.getString(teasession._nLanguage,"Back")%>" onclick="history.back();"/>
  </form>
  <div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>


</body></html>
