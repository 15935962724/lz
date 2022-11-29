<%@page contentType="text/html;charset=utf-8" %>
<%@include file="/jsp/include/Header.jsp"%>

<%

String community=node.getCommunity();
if(teasession._rv==null)
{
  if((node.getOptions1()& 1) == 0)
  {
    response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
    return;
  }
}else
{
  if (!node.isCreator(teasession._rv)&&!AccessMember.find(node._nNode, teasession._rv._strV).isProvider(81))
  {
    response.sendError(403);
    return;
  }
}
r.add("/tea/resource/Landscape");


%>
<html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script type="text/JAVASCRIPT" src="LandscapeArea.js"></script>
<script type="">
function fnonuse(obj)
{
  var ewebeditor=document.all('word_body');
  if(obj.checked)
  {
    foNew.Text.style.display="";
    ewebeditor.style.display="none";
    setCookie('jsp.type.report.EditReport.nonuse',obj.checked);
  }else
  {
    removeCookie('jsp.type.report.EditReport.nonuse');
    ewebeditor.style.display="";
    foNew.Text.style.display="none";
  }
}
function fload(from1)
{
  from1.subject.focus();

//setCountryList('UCTGuideSearch1_SelCountry');
}
</script>
</head>
<body onLoad="fload(foNew);">
<h1><%=r.getString(teasession._nLanguage, "CBNewLandscape")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%> </div>
  <FORM name=foNew METHOD=POST action="/servlet/EditLandscape"  enctype=multipart/form-data onSubmit="return submitText(this.subject, '<%=r.getString(teasession._nLanguage, "InvalidSubject")%>')&&submitInteger(this.weather, '<%=r.getString(teasession._nLanguage, "Weather")%>')" >
    <%
          String parameter=teasession.getParameter("nexturl");
    boolean   parambool=(parameter!=null&&!parameter.equals("null"));
    if(parambool)
    out.print("<input type='hidden' name=nexturl value="+parameter+">");
    String text,subject,keywords;
java.util.Date date=null;
     int distinction=0;
     int weather=0;
     boolean homeland=true;
     int area1=0;
     int area2=0;
     int style=0;
     long l2=0;
    String picture=null,logograph=null;
            if(request.getParameter("NewNode")!=null)
            {
              logograph=picture=text=subject=keywords="";
              out.println("<INPUT TYPE=hidden NAME=NewNode VALUE=ON>");
            }else
              {
                text=node.getText(teasession._nLanguage);
                subject=tea.html.HtmlElement.htmlToText(node.getSubject(teasession._nLanguage));
                keywords=node.getKeywords(teasession._nLanguage);
                date=node.getTime();

                tea.entity.node.Landscape  obj=tea.entity.node.Landscape.find(teasession._nNode);
                distinction=obj.getDistinction();
                weather=obj.getWeather();
                homeland=obj.isHomeland();
                area1=obj.getArea1();
                area2=obj.getArea2();
                style=obj.getStyle();
                logograph=tea.html.HtmlElement.htmlToText(obj.getLogograph(teasession._nLanguage));
                picture=obj.getPicture(teasession._nLanguage);
                if(picture!=null)
                {
                  l2=new java.io.File(application.getRealPath(picture)).length();
                }
              }
            %>
    <input type='hidden' name=Node VALUE="<%=teasession._nNode%>">
    <table cellspacing="0" cellpadding="0" border="0" id="tablecenter">
      <tr>
        <td>*<%=r.getString(teasession._nLanguage, "Subject")%>:</TD>
        <td><input name="subject"  size=70 maxlength=255 class="edit_input" value="<%=((subject))%>"/></td>
      </tr>
            <tr>
        <td><%=r.getString(teasession._nLanguage, "Keywords")%>:</TD>
        <td><input name="keywords"  size=70 maxlength=255 class="edit_input" value="<%=((keywords))%>"/></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Distinction")%>:</TD>
        <td>
          <select name="distinction">
            <option value="0" selected >--------------</option>
            <option value="1" <%=getSelect(distinction==1)%>>☆</option>
            <option value="2" <%=getSelect(distinction==2)%>>☆☆</option>
            <option value="3" <%=getSelect(distinction==3)%>>☆☆☆</option>
            <option value="4" <%=getSelect(distinction==4)%>>☆☆☆☆</option>
            <option value="5" <%=getSelect(distinction==5)%>>☆☆☆☆☆</option>

        </select></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Style")%>:</TD>
        <td><select name="style">
            <option value="0" selected >--------------</option>
                                        <option value="1" <%=getSelect(style==1)%>><%=r.getString(teasession._nLanguage, "Style.1")%></option>
                                        <option value="2" <%=getSelect(style==2)%>><%=r.getString(teasession._nLanguage, "Style.2")%></option>
                                        <option value="3" <%=getSelect(style==3)%>><%=r.getString(teasession._nLanguage, "Style.3")%></option>
                                        <option value="4" <%=getSelect(style==4)%>><%=r.getString(teasession._nLanguage, "Style.4")%></option>
                                        <option value="5" <%=getSelect(style==5)%>><%=r.getString(teasession._nLanguage, "Style.5")%></option>
                                        <option value="6" <%=getSelect(style==6)%>><%=r.getString(teasession._nLanguage, "Style.6")%></option>
                                        <option value="7" <%=getSelect(style==7)%>><%=r.getString(teasession._nLanguage, "Style.7")%></option>
                                        <option value="8" <%=getSelect(style==8)%>><%=r.getString(teasession._nLanguage, "Style.8")%></option>
                                        <option value="9" <%=getSelect(style==9)%>><%=r.getString(teasession._nLanguage, "Style.9")%></option>
                                        <option value="10" <%=getSelect(style==10)%>><%=r.getString(teasession._nLanguage, "Style.10")%></option>
                                        <option value="11" <%=getSelect(style==11)%>><%=r.getString(teasession._nLanguage, "Style.11")%></option>
                                        <option value="12" <%=getSelect(style==12)%>><%=r.getString(teasession._nLanguage, "Style.12")%></option>
                                        <option value="13" <%=getSelect(style==13)%>><%=r.getString(teasession._nLanguage, "Style.13")%></option>
                                        <option value="14" <%=getSelect(style==14)%>><%=r.getString(teasession._nLanguage, "Style.14")%></option>
                                        <option value="15" <%=getSelect(style==15)%>><%=r.getString(teasession._nLanguage, "Style.15")%></option>
                                        <option value="16" <%=getSelect(style==16)%>><%=r.getString(teasession._nLanguage, "Style.16")%></option>
                                        <option value="17" <%=getSelect(style==17)%>><%=r.getString(teasession._nLanguage, "Style.17")%></option>
                                        <option value="18" <%=getSelect(style==18)%>><%=r.getString(teasession._nLanguage, "Style.18")%></option>

        </select></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Picture")%>:</TD>
        <td><input TYPE=FILE NAME="picture" onDblClick="<%if(l2>0)out.print("window.open('"+picture+"');");%>" class="edit_input">
          <%if(l2 != 0) out.print(l2 + r.getString(teasession._nLanguage, "Bytes"));%>
          <input  id="CHECKBOX" type="CHECKBOX" NAME=ClearPicture onClick="foNew.picture.disabled=this.checked">
          <%=r.getString(teasession._nLanguage, "Clear")%> </td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Weather")%>:</TD>
        <td><input name="weather" size="50"  class="edit_input" value="<%=weather%>"/></td>
      </tr>
      <tr>
        <TD><%=r.getString(teasession._nLanguage, "Type")%>:</TD>
        <td><input name="homeland"  id="radio" type="radio" value="true" checked="checked" onClick="setProvinceList('area1');while(foNew.area2.lengTD>1)foNew.area2.options[1]=null;"><%=r.getString(teasession._nLanguage, "Homeland")%>
          <input name="homeland"  id="radio" type="radio" value="false" <%if(!homeland)out.print("checked");%> onClick="setCountryList('area1');while(foNew.area2.lengTD>1)foNew.area2.options[1]=null;"><%=r.getString(teasession._nLanguage, "External")%>
        </td>
      </tr>
	        <tr>
        <TD><%=r.getString(teasession._nLanguage, "Area")%>:</TD>
        <td><select name="area1" onChange="setSceneryList('area1','area2',foNew.homeland[0].checked?'SceneryList':'ForeignSceneryList')">
          <option value="0" selected >--------------</option>
</select>
<select name="area2" >
  <option value="0" selected >--------------</option>
</select>
<script type="">
<%=homeland?"setProvinceList('area1');":"setCountryList('area1');"%>;
for(var index=0;index<foNew.area1.length;index++)
{
if( foNew.area1.options[index].value==<%=area1%>)
{
  foNew.area1.options[index].selected=true;
  foNew.area1.onchange();
  break;
}
}
for(var index=0;index<foNew.area2.length;index++)
{
if( foNew.area2.options[index].value==<%=area2%>)
{
  foNew.area2.options[index].selected=true;
  break;
}
}
</script>
        </td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Logograph")%>:</TD>
        <td><textarea name="logograph" rows="6" cols="80" class="edit_input"><%=logograph%></textarea>
        </td>
      </tr>
      <tr>
        <td> </TD>
        <td>
          <%--<input  id="radio" type="radio" name=TextOrHtml value=2 <%=getCheck((j1 & 0x20) != 0)%> >JSP--%>
          <input type="button" name="Pictureview" id="Pictureview" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Pictureview")%>" onClick="window.open('/servlet/InsertPicture?node=<%=teasession._nNode%>', '_blank');">
          <input  id="CHECKBOX" type="CHECKBOX" name="nonuse"  id="nonuse" value="checkbox" onclick="fnonuse(this)">
          <label for="nonuse"><%=r.getString(teasession._nLanguage, "NonuseEditor")%></label>
        </td>
      </tr>
      </table>

<table border="0" cellpadding="0" cellspacing="0" id="tableword">
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Text")%>:</TD>
        <td><textarea style="display:none"  name="Text" rows="8" cols="80" class="edit_input"><%=(text)%></textarea>

<script language="JavaScript" type="text/javascript" src="/jsp/include/word_edit/word_edit.js"></script>
<link rel="Stylesheet" href="/jsp/include/word_edit/word_edit.css" type="text/css" media="all" />
<script type="text/javascript">
document.write("<div id=\"word_body\" ></div>");
et = new word("word_body", foNew.Text );
foNew.attachEvent("onsubmit", et.save);
</script>


          <script>
          foNew.nonuse.checked=getCookie('jsp.type.report.EditReport.nonuse','');
          fnonuse(foNew.nonuse);
          </script>
        </td>
      </tr>
      </table>
      <table cellspacing="0" cellpadding="0" border="0" id="tablecenter">
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Time")%>:</TD>
        <td><%=new TimeSelection("Issue", date)%></td>
      </tr>
    </table>
    <center>
      <input type="hidden" name="act" value="">
      <input type=SUBMIT name="GoFinish" ID="edit_GoFinish"  onClick="act.value='finish';" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Finish")%>">
	  <input type=SUBMIT name="GoNext" id="edit_GoNext" onClick="act.value='next';" class="edit_button" value="<%=r.getString(teasession._nLanguage, "CBNext")%>">
      <input type=SUBMIT name="GoBackSuper" id="edit_GoNext" onClick="act.value='back';" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Super")%>">
    </center>
  </FORM>
  <div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

