<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
String tmp = request.getParameter("ading");
int ading=0;
if(tmp!=null)
{
  ading=Integer.parseInt(tmp);
}
int i = teasession._nNode;
if(ading>0)
{
  i = Ading.find(ading).getNode();
}
Node node = Node.find(i);

if((!node.isCreator(teasession._rv) || !teasession._rv.isAdManager())&&AccessMember.find(teasession._nNode,teasession._rv._strV).getPurview()<2)
{
  response.sendError(403);
  return;
}
boolean flag1 = teasession._rv.isOrganizer(node.getCommunity());
boolean flag2 = teasession._rv.isWebMaster();
int style = 0;
int l = 0;
BigDecimal bigdecimal = new BigDecimal(0.0D);
Date date = null;
Date date2 = null;
String s1 = "";
String imgSize="";
int position=0;
int sequence=0;
int styletype=0,stylecategory=0,ectypal=0;
String beforeItem,afterItem,picturepath;
if(ading>0)
{
  Ading ad = Ading.find(ading);
  style = ad.getStyle();
  styletype=ad.getStyleType();
  stylecategory=ad.getStyleCategory();
  l = ad.getCurrency();
  bigdecimal = ad.getCpm();
  date = ad.getStartTime();
  date2 = ad.getStopTime();
  s1 = ad.getName(teasession._nLanguage);
  position=ad.getPosition();
  sequence=ad.getSequence();
  beforeItem=ad.getBeforeItem(teasession._nLanguage);
  afterItem=ad.getAfterItem(teasession._nLanguage);
  picturepath=ad.getPicture(teasession._nLanguage);
  ectypal = ad.getEctypal();
  imgSize = ad.getImgSize(teasession._nLanguage);
}else
{
  beforeItem=afterItem=picturepath="";
}
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script>
function f_load()
{
  f_change();
  form1.type.onchange=f_change;
}
function f_change()
{
  var o1=form1.type.options;
  var sc=form1.stylecategory;
  var o2=form1.stylecategory.options;
  if(form1.type.value=="1")
  {
    sc.style.display="";
  }else
  {
    sc.style.display="none";
  }
  if(o2.length==0)
  {
    for(var i=0;i<o1.length;i++)
    {
      var v=o1[i].value;
      if(v!="255"&&v!="0"&&v!="1")
      {
        o2[o2.length]=new Option(o1[i].text,v);
      }
    }
    if(<%=stylecategory%>!=0)
    sc.value="<%=stylecategory%>";
  }
}
</script>
</head>
<body onload="f_load()">
<h1><%=r.getString(teasession._nLanguage, "Aded")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
<form name="form1" action="/servlet/EditAding" METHOD=POST enctype="multipart/form-data" onSubmit="return(submitFloat(this.CPM,'<%=r.getString(teasession._nLanguage, "InvalidCPM")%>')&&submitText(this.name,'<%=r.getString(teasession._nLanguage, "InvalidName")%>'))">
<input type='hidden' name="community" value="<%=teasession._strCommunity%>" />
<input type='hidden' name="node" value="<%=teasession._nNode%>" />
<input type='hidden' name="ading" value="<%=ading%>" />
<input type='hidden' name="repository" value="ading">
<input type='hidden' name="watermark" value="false">

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Position")%>:</td>
      <td><%
        for (int j4 = 0; j4 < tea.entity.node.Section.SECTION_TYPE.length; j4++)
        {
          if(j4<1||j4>4)
          {
            out.print(new Radio("position", j4, j4 == position));
            out.println(r.getString(teasession._nLanguage, Section.SECTION_TYPE[j4]));
          }
        }
        //out.print(new tea.htmlx.StyleSelection(teasession._nLanguage, j,styleRoot, flag1, flag2));
        %>
        </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage,"Style")%>:</td>
      <td>
        <input id="radio" type="radio" name="style" value="0" <%if(style==0)out.print(" checked ");%>><%=r.getString(teasession._nLanguage, "ThisNode")%>
        <input id="radio" type="radio" name="style" value="2" <%if(style==2)out.print(" checked ");%>><%=r.getString(teasession._nLanguage, "1206432316359")%>
        <%=new tea.htmlx.TypeSelection(node.getCommunity(),teasession._nLanguage, styletype)%>
        <select name="stylecategory" style="display:none"></select>
    </td>
    </tr>
    <tr>
        <%
        out.print(new CurrencySelection(teasession._nLanguage, l, false));
        out.print("<tr><td>"+r.getString(teasession._nLanguage, "CPM") + ":<td><input type=TEXT class=edit_input  name=CPM value="+bigdecimal+">");
        out.println("<tr><td>"+r.getString(teasession._nLanguage, "Options") + ":");
        %>
      <td><input  id="CHECKBOX" type="CHECKBOX" name=AdingOForever <%=getCheck(date == null)%> ><%=r.getString(teasession._nLanguage, "AdingOForever")%></td>
    </tr>
    <tr>
        <td>副本ID号:</td>
      <td><input type="text" name="ectypal" value="<%=ectypal %>" ></td>
    </tr>
    
    
    
<%
    if(date == null)
    {
      Date date4 = new Date(System.currentTimeMillis());
      date = date4;
      date2 = date4;
    }
    out.println("<tr><td>"+r.getString(teasession._nLanguage, "StartTime") + ":<td>");
    out.println((new TimeSelection("Start", date)));

    out.println("<tr><td>"+r.getString(teasession._nLanguage, "StopTime") + ":<td>");
    out.println((new TimeSelection("Stop", date2)));
%>
<tr>
  <td><%=r.getString(teasession._nLanguage, "Name")%>:</td>
  <td><input type="TEXT" class="edit_input"  name="name" value="<%=s1%>" SIZE=40 MAXLENGTH=40></td>
</tr>
<tr>
  <td>尺寸:</td>
  <td><input type="TEXT" class="edit_input"  name="imgSize" value="<%=imgSize%>" SIZE=40 MAXLENGTH=40></td>
</tr>

<tr>
  <td><%=r.getString(teasession._nLanguage, "Before")%>:</td>
  <td><TEXTAREA name=beforeitem ROWS=6 class="edit_input"  cols="75"><%out.println(HtmlElement.htmlToText(beforeItem));%></TEXTAREA></td>
</tr>
<tr>
  <td><%=r.getString(teasession._nLanguage, "After")%>:</td>
  <td><TEXTAREA name="afteritem" class="edit_input" ROWS="6"  cols="75"><%out.println(HtmlElement.htmlToText(afterItem));%></TEXTAREA></td>
</tr>
<tr>
  <td><%=r.getString(teasession._nLanguage, "Sequence")%>:</td>
  <td><input type="TEXT" class="edit_input"  name=sequence value="<%=sequence%>"></td>
</tr>
<tr>
  <td><%=r.getString(teasession._nLanguage, "Default")%><%=r.getString(teasession._nLanguage, "Picture")%>:</td>
  <td><input type="file" class="edit_input" onDblClick="window.showModalDialog('<%=picturepath%>');"  name=picture value="<%=picturepath%>">
  OR
  <input type="TEXT" class="edit_input" size="50"  name=picturepath value="<%=picturepath%>"></td>
</tr>
  </table>
  <input type="submit" class="edit_button" id="edit_submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>">
  <input type="button" class="edit_button" id="edit_submit"  value="<%=r.getString(teasession._nLanguage, "CBBack")%>" onclick="history.back()">
</FORM>

<SCRIPT>document.form1.name.focus();</SCRIPT>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>
