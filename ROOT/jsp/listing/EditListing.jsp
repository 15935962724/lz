<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.*"%><%@ page import="java.util.*" %><%@ page import="tea.html.*" %><%@ page import="java.math.*" %><%@page import="tea.ui.node.general.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.*" %><%@ page import="tea.entity.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.entity.site.*" %><%@ page import="tea.ui.*" %><% request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);

if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource("/tea/ui/node/listing/Listings");

Listing obj=null;
int realnode=teasession._nNode;
int listing=Integer.parseInt(teasession.getParameter("listing"));
int status=0;
if(listing!=0)
{
  obj=Listing.find(listing);
  realnode = obj.getNode();
  status=obj.getStatus();
}else
{
  status=Integer.parseInt(request.getParameter("status"));
}
AccessMember am=AccessMember.find(realnode,teasession._rv);

if(realnode>0&&!Node.find(realnode).isCreator(teasession._rv)&&am.getPurview()<2)
{
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}

Http h=new Http(request,response);


Node node = Node.find(teasession._nNode);

String s1 = node.getCommunity();
int j = 0;
int l = 1;
int j1 = 0,styletype=255,stylecategory=39;
int l1 = 0;
int j2 = 2;
int l2 = 0;
int j3 = 6;
int l3 = 3;
int j4 = 0;
int l4 = 1;
int j5 = 525;//525;
int l5 = 0;
int j6 = 0;
int l6 = 30;
String s2 ;
String s4 ;
String s6 ;
String s8 ;
String s10 ;
String s12 ;
String s14 ;
int j7 = 0;
String s16;
String s18;
String s20;
String s22;
String s24;
String s26;
String s28;
String s30;
String s32;
String s34;
String s36;
int k7 = 0;
String s38 ;
String s39 ;
int i8 = 0;
int j8 = 0;
String s42 ;
java.util.Date date_l=null;
String target;
int hidden=3;
String columnafter;
String mark=null;
int term=0;
int archive;
int ectypal=0;
int termdate = 0;
int isshowlayer=0;
if(listing!=0)
{
  j = obj.getType();
  l = obj.getPick();
  j1 = obj.getStyle();
  styletype=obj.getStyleType();
  stylecategory=obj.getStyleCategory();
  l1 = obj.getSequence();
  j2 = obj.getPosition();
  l2 = obj.getVisible();
  j3 = obj.getQuantity();
  l3 = obj.getSonQuantity();
  l4 = obj.getColumns();
  j5 = obj.getOptions();
  mark=obj.getMark();
  j4 = obj.getDetailOptions();
  l5 = obj.getSortType();
  j6 = obj.getSortDir();
  l6 = obj.getUpdateGap();
  target=obj.getTarget();

  term=obj.getTerm();
  s2 = obj.getName(teasession._nLanguage);
  s4 = obj.getMore(teasession._nLanguage);
  s6 = obj.getTalkbacks(teasession._nLanguage);
  s8 = obj.getEditTalkback(teasession._nLanguage);
  s10 = obj.getChatRoom(teasession._nLanguage);
  s12 = obj.getForwardNode(teasession._nLanguage);
  s14 = obj.getReplyNode(teasession._nLanguage);
  String bip=obj.getBeforeItemPicture(teasession._nLanguage);
  if(bip!=null&&bip.length()>0)
  j7 = (int)new java.io.File(application.getRealPath(bip)).length();
  s16 = HtmlElement.htmlToText(obj.getBeforeItem(teasession._nLanguage));
  s18 = HtmlElement.htmlToText(obj.getAfterItem(teasession._nLanguage));
  s22 = obj.getSeparatorDetail(teasession._nLanguage);
  s36 = MT.f(obj.getBeforeListing(teasession._nLanguage));
  s38 = obj.getAlt(teasession._nLanguage);
  s39 = obj.getClickUrl(teasession._nLanguage);
  i8 = obj.getPicturePosition(teasession._nLanguage);

  //k7 = obj.getPictureLen(teasession._nLanguage);
  j8 = obj.getAlign(teasession._nLanguage);
  date_l=obj.getTime();
  s42 = HtmlElement.htmlToText(obj.getAfterListing(teasession._nLanguage));
  columnafter=obj.getColumnAfter(teasession._nLanguage);
  archive=obj.getArchive();
  ectypal=obj.getEctypal();
  termdate=obj.getTermdate();

  Listinghide ch=Listinghide.find(listing,teasession._nNode);
  hidden=ch.getHiden();
  isshowlayer=obj.getIsshowlayer(teasession._nLanguage);
}else
{
  l1=Listing.getMaxSequence(teasession._nNode)+10;
  target="_self";
  s2 = "";
  s4 = "";
  s6 = "";
  s8 = "";
  s10 = "";
  s12 = "";
  s14 = "";
  s16 = "";
  s18 = "";
  s20 = "";
  s22 = "";
  s24 = "";
  s26 = "";
  s28 = "";
  s30 = "";
  s32 = "";
  s34 = "";
  s36 = "";
  s38 = "";
  s39 = "";
  s42 = "";
  columnafter="";
  archive=0;
}

String title=r.getString(teasession._nLanguage, "Listing")+" ( "+listing+" )";
%>
<html>
<head>
<title><%=title%></title>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script>
function f_load()
{
  f_change();
  form1.type.onchange=f_change;
  form1.GoNext.disabled=false;
  form1.GoFinish.disabled=false;
  form1.Name.focus();
}
function f_change()
{
  var o1=form1.type.options;
  var sc=form1.stylecategory;
  var o2=sc.options;
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
function checkIsshowlayer(){
	form1.isshowlayer.cheked=!form1.isshowlayer.cheked;
	if(form1.isshowlayer.cheked){
		form1.isshowlayer.value="1";
	}else{
		form1.isshowlayer.value="0";
	}
}

</script>
</head>
<body onLoad="f_load()">
<%=tea.ui.node.general.NodeServlet.getButton(node,h, am,request)%>
<h1><%=title%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<FORM name=form1 METHOD=POST action="/servlet/EditListing" ENCtype=multipart/form-data onSubmit="mt.storage(this,true);return(submitInteger(this.Sequence,'<%=r.getString(teasession._nLanguage, "InvalidSequence")%>')&&submitInteger(this.Quantity,'<%=r.getString(teasession._nLanguage, "InvalidSequence")%>')&&submitInteger(this.SonQuantity,'<%=r.getString(teasession._nLanguage, "InvalidSonQuantity")%>')&&submitInteger(this.Columns,'<%=r.getString(teasession._nLanguage, "InvalidColumns")%>')&&submitInteger(this.UpdateGap,'<%=r.getString(teasession._nLanguage, "InvalidUpdateGap")%>')&&submitText(this.Name,'<%=r.getString(teasession._nLanguage, "InvalidName")%>')&&mt.show(null,0))">
<input type='hidden' name="node" VALUE="<%=teasession._nNode%>">
<input type='hidden' name="status" VALUE="<%=status%>">
<input type='hidden' name="listing" VALUE="<%=listing%>">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td nowrap><%=r.getString(teasession._nLanguage, "Name")%>:</td>
    <td><input name="Name" VALUE="<%=s2%>" SIZE=40 MAXLENGTH=40 class="edit_input">
    <input type="checkbox" name="isshowlayer" value="<%=isshowlayer %>" onclick="checkIsshowlayer()" <%if(isshowlayer==1)out.print(" checked='true' "); %> ><label for="isshowlayer"><%=r.getString(teasession._nLanguage, "后台发表文章显示") %></label></td>
  </tr>
    <tr>
      <td nowrap><%=r.getString(teasession._nLanguage, "Position")%>:</td>
      <td><span><input  id="radio" type="radio" name="Position" VALUE=0 <%if(j2==0)out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Body")%>1</span>
        <span><input  id="radio" type="radio" name="Position" VALUE=1 <%if(j2==1)out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Body")%>2</span>
        <span><input  id="radio" type="radio" name="Position" VALUE=2 <%if(j2==2)out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Body")%>3</span>
 <%--       <span><input  id="radio" type="radio" name="Position" VALUE=3 <%if(j2==3)%>><%=r.getString(teasession._nLanguage, "Footer")%></span>
           <span><input  id="radio" type="radio" name="Position" VALUE=4 <%if(j2==4)%>>
          <%=r.getString(teasession._nLanguage, "AdRight")%></span>--%>
        <span><input  id="radio" type="radio" name="Position" VALUE=5 <%if(j2==5)out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Header")%></span>
        <span><input  id="radio" type="radio" name="Position" VALUE=6 <%if(j2==6)out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Footer")%></span>
      </td>
    </tr>
    <tr>
      <td nowrap><%=r.getString(teasession._nLanguage, "Style")%>:</td>
      <td>
        <input  id="radio" type="radio" name="Style" VALUE=0 <%if(j1==0)out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "ThisNode")%>
        <input id="radio" type="radio" name="Style" VALUE=2 <%if(j1==2)out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "1206432316359")%>
        <%=new tea.htmlx.TypeSelection(teasession._strCommunity,teasession._nLanguage, styletype)%>
        <select name="stylecategory" style="display:none"></select>
        <%--
        <span><input  id="radio" type="radio" name="Style" VALUE=1 <%if(j1==1)%>><%=r.getString(teasession._nLanguage, "ThisTreeThisType")%></span>
        <span><input  id="radio" type="radio" name="Style" VALUE=2 <%if(j1==2)%>><%=r.getString(teasession._nLanguage, "ThisTreeAllNodes")%></span>
        <span><input  id="radio" type="radio" name="Style" VALUE=3 <%if(j1==3)%>><%=r.getString(teasession._nLanguage, "ThisCommThisType")%></span>
        <span><input  id="radio" type="radio" name="Style" VALUE=4 <%if(j1==4)%>><%=r.getString(teasession._nLanguage, "ThisCommAllNodes")%></span>
        <span><input  id="radio" type="radio" name="Style" VALUE=5 <%if(j1==5)%>><%=r.getString(teasession._nLanguage, "AllCommsThisType")%></span>
        <span><input  id="radio" type="radio" name="Style" VALUE=6 <%if(j1==6)%>><%=r.getString(teasession._nLanguage, "AllCommsAllNodes")%></span>
        <span><input  id="radio" type="radio" name="Style" VALUE=7 <%if(j1==7)%>><%=r.getString(teasession._nLanguage, "ThisRootThisType")%><input type="text" value="<%=root%>" name="root"  class="edit_input" size="5"></span>
        --%>
      </td>
    </tr>
    <tr>
      <td nowrap><%=r.getString(teasession._nLanguage, "Options")%>:</td>
      <td>
<%
String name[]={"ListingOShowAlways","ListingOShowNewest","ListingOCurrentNode","显示引用","More","DeleteFormat","ListingHidenNode","MatchLanguage","1204170772187","1228286239082","1204170786671","1204170811171"};
int value[]={1,4,0x10,0x80,0x20,0x40,0x100,0x400,0x800,0x200,0x1000,0x2000};
for(int i=0;i<name.length;i++)
{
  out.print("<input type='checkbox' id='options"+i+"' name='options' value='"+value[i]+"'");
  if((j5&value[i])!=0)out.print(" checked='true'");//&value[i]!=512

  out.println(" /><label for='options"+i+"'>"+r.getString(teasession._nLanguage, name[i])+"</label>");
}
%>
<%=Mark.toHtml(teasession._strCommunity,-1,mark)%>
<%--
        <span><input name=ListingOShowAlways  id="CHECKBOX" type="CHECKBOX" value=null  <%if((j5 & 1) != 0)%>><%=r.getString(teasession._nLanguage, "ListingOShowAlways")%></span>
        <span><input name=ListingOShowNewest  id="CHECKBOX" type="CHECKBOX" value=null  <%if((j5 & 4) != 0)%>><%=r.getString(teasession._nLanguage, "ListingOShowNewest")%></span>
        <!-- <span><input  id="CHECKBOX" type="CHECKBOX" name=ListingOShowSons value=null  <%if((j5 & 8) != 0)%>><%=r.getString(teasession._nLanguage, "ListingOShowSons")%>
          </span>
          <span><input  id="CHECKBOX" type="CHECKBOX" name=ListingONewWindow value=null <%if((j5 & 2) != 0)%>><%=r.getString(teasession._nLanguage, "ListingONewWindow")%>
          </span>-->
        <span>
        <input  id="CHECKBOX" type="CHECKBOX" name=ListingOCurrentNode value=null <%if((j5 & 0x10) != 0)%>><%=r.getString(teasession._nLanguage, "ListingOCurrentNode")%> </span>
        <!--		  <span><input  id="CHECKBOX" type="CHECKBOX" name=Divide value=null   <%if((j4 & 16) != 0)%>><%=r.getString(teasession._nLanguage, "Divide")%>
          </span>-->
        <span>
        <input  id="CHECKBOX" type="CHECKBOX" name=More value=null   <%if((j5 & 0x20) != 0)%>><%=r.getString(teasession._nLanguage, "More")%> </span>
        <span>
        <input  id="CHECKBOX" type="CHECKBOX" name="DeleteFormat" <%if((j5 & 0x40) != 0)%>/><%=r.getString(teasession._nLanguage, "DeleteFormat")%> </span>
<!--        <span><input  id="CHECKBOX" type="CHECKBOX" name="Export" <%if((j5 & 0x80) != 0)%>/><%=r.getString(teasession._nLanguage, "Export")%></span>
-->
        <span><input  id="CHECKBOX" type="CHECKBOX" name="ListingHidenNode" <%if((j5 & 0x100) != 0)%>/><%=r.getString(teasession._nLanguage, "ListingHidenNode")%> </span>
        <span>
        <input  type="CHECKBOX" id="MatchLanguage" name="MatchLanguage" <%if((j5 & 0x400) != 0)%>/><label for="MatchLanguage"><%=r.getString(teasession._nLanguage, "MatchLanguage")%></label>
        </span>
        <input type="CHECKBOX" name="Mostly" <%if((j5 & 0x800) != 0)%>><%=r.getString(teasession._nLanguage, "1204170772187")%>
        <input type="CHECKBOX" name="Mostly3" <%if((j5 & 0x200) != 0)%>><%=r.getString(teasession._nLanguage, "1228286239082")%>
        <input type="CHECKBOX" name="Mostly1" <%if((j5 & 0x1000) != 0)%>><%=r.getString(teasession._nLanguage, "1204170786671")%>
        <input type="CHECKBOX" name="Mostly2" <%if((j5 & 0x2000) != 0)%>><%=r.getString(teasession._nLanguage, "1204170811171")%>
--%>

      </td>
    </tr>
    <tr>
      <td nowrap><%=r.getString(teasession._nLanguage, "BeforeListing")%>:</td>
      <td><TEXTAREA name=BeforeListing style="" ROWS=8 class="edit_input"  cols="75"><%=(s36)%></TEXTAREA>
      </td>
    </tr>
    <tr>
      <td nowrap><%=r.getString(teasession._nLanguage, "AfterListing")%>:</td>
      <td><TEXTAREA name="AfterListing"  style="" class="edit_input" ROWS="8"  cols="75"><%=(s42)%></TEXTAREA>
        <br/><a href="javascript:mt.storage(form1,true)">保存数据</a> <a href="javascript:mt.storage(form1,false)">恢复数据</a>
      </td>
    </tr>
  </table>
  <input type=SUBMIT disabled="disabled"  name="GoNext" id="edit_GoNext" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "CBNext")%>">
  <input type=SUBMIT disabled="disabled"  name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Finish")%>">
  <%
  if(realnode>0)
  {
    out.print("<input name='example' type='submit' id='edit_submit' class='edit_button'  VALUE="+r.getString(teasession._nLanguage, "同时存为模板")+" />");
  }
  %>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td nowrap><%=r.getString(teasession._nLanguage, "Target")%>:</td>
      <td><input type="TEXT" class="edit_input" maxlength="15"  name=target VALUE="<%=target%>"></td>
    </tr>
    <tr>
      <td nowrap><%=r.getString(teasession._nLanguage, "Sequence")%>:</td>
      <td><input type="TEXT" class="edit_input" name=Sequence VALUE="<%=l1%>" mask="int"></td>
    </tr>
    <tr>
      <TD nowrap><%=r.getString(teasession._nLanguage, "Quantity")%>:</TD>
      <td><input type="TEXT" class="edit_input"  name=Quantity VALUE="<%=j3%>" mask="int"></td>
    </tr>
    <tr>
      <td nowrap><%=r.getString(teasession._nLanguage, "SonQuantity")%>:</td>
      <td><input name=SonQuantity VALUE="<%=l3%>" size="20" class="edit_input" mask="int"></td>
    </tr>
    <tr>
      <td nowrap><%=r.getString(teasession._nLanguage, "Columns")%>:</td>
      <td><input name=Columns VALUE="<%=l4%>" size="20" class="edit_input">
        <input type="text" name="columnafter"  class="edit_input" value="<%if(columnafter!=null)out.print(columnafter);%>"></td>
    </tr>
    <tr>
      <td nowrap><%=r.getString(teasession._nLanguage, "UpdateGap")%>:</td>
      <td><input name=UpdateGap VALUE="<%=l6%>" size="20" class="edit_input"></td>
    </tr>
    <tr>
      <td nowrap><%=r.getString(teasession._nLanguage, "SortType")%>:</td>
    <td><%--<SELECT name=SortType>
            <OPTION <%=getSelect(l5==0)%> VALUE="0"><%=r.getString(teasession._nLanguage, "CreateTime")%></OPTION>
            <OPTION <%=getSelect(l5==1)%>VALUE="1"><%=r.getString(teasession._nLanguage, "ViewCount")%></OPTION>
            <OPTION <%=getSelect(l5==2)%>VALUE="2"><%=r.getString(teasession._nLanguage, "TalkbackCount")%></OPTION>
            <OPTION <%=getSelect(l5==3)%>VALUE="3"><%=r.getString(teasession._nLanguage, "PollCount")%></OPTION>
            <OPTION <%=getSelect(l5==4)%>VALUE="4"><%=r.getString(teasession._nLanguage, "BuyCount")%></OPTION>
            <OPTION <%=getSelect(l5==5)%>VALUE="5"><%=r.getString(teasession._nLanguage, "BidCount")%></OPTION>
            <OPTION <%=getSelect(l5==6)%>VALUE="6"><%=r.getString(teasession._nLanguage, "BargainCount")%></OPTION>
            <OPTION <%=getSelect(l5==7)%>VALUE="7"><%=r.getString(teasession._nLanguage, "ChatCount")%></OPTION>
            <OPTION <%=getSelect(l5==8)%>VALUE="8"><%=r.getString(teasession._nLanguage, "NewsIssueTime")%></OPTION>
            <OPTION <%=getSelect(l5==9)%>VALUE="9"><%=r.getString(teasession._nLanguage, "Sequence")%></OPTION>
          </SELECT>--%>
          <%
          DropDown dropdown = new DropDown("SortType", l5);
          for (int l9 = 0; l9 < Listing.LISTING_SORTTYPE.length; l9++)
          {
            dropdown.addOption(l9, r.getString(teasession._nLanguage, Listing.LISTING_SORTTYPE[l9]));
          }
          out.print(dropdown);
          %>
          <input type="text" name="term" value="<%=term%>">
      </td>
    </tr>
    <tr>
      <td nowrap><%=r.getString(teasession._nLanguage, "SortDir")%>:</td>
      <td>
        <input  id="radio" type="radio" name=SortDir VALUE=0 <%if( 0 == (j6 & 1))out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Ascending")%>
        <input  id="radio" type="radio" name=SortDir VALUE=1 <%if( 1 == (j6 & 1))out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Descending")%>
      </td>
    </tr>
     <tr>
      <td nowrap><%=r.getString(teasession._nLanguage, "列举时间")%>:</td>
      <td><input type="text" name="termdate" value="<%=termdate%>">&nbsp;(说明：只能填写数值，例如如果是显示发布日期的前一天不显示，则填写-1，如果是后一天不显示则填写1，0默认不判断显示) </td>
    </tr>
    <tr>
      <td nowrap><%=r.getString(teasession._nLanguage, "SonSortDir")%>:</td>
      <td>
        <input  id="radio" type="radio" name=SonSortDir VALUE=0 <%if(0 == (j6 / 2))out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Ascending")%>
        <input  id="radio" type="radio" name=SonSortDir VALUE=1 <%if(1 == (j6 / 2))out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Descending")%>
      </td>
    </tr>
    <tr>
      <td nowrap><%=r.getString(teasession._nLanguage, "CBArchive")%>:</td>
      <td><input type="text" name="archive" value="<%=archive%>"  class="edit_input"></td>
    </tr>
    <tr>
      <td nowrap><%=r.getString(teasession._nLanguage, "BeforeItemPicture")%>:</td>
      <td COLSPAN=6><input type=FILE name=BeforeItemPicture class="edit_input"><input  id="CHECKBOX" type="CHECKBOX" name=ClearBeforeItemPicture value=null><%=r.getString(teasession._nLanguage, "Clear")%></td>
    </tr>
    <tr>
      <td nowrap><%=r.getString(teasession._nLanguage, "BeforeItem")%>:</td>
      <td><TEXTAREA name=BeforeItem ROWS=2 COLS=60 class="edit_input"><%=(s16)%></TEXTAREA></td>
    </tr>
    <tr>
      <td nowrap><%=r.getString(teasession._nLanguage, "AfterItem")%>:</td>
      <td><TEXTAREA name=AfterItem ROWS=2 COLS=60 class="edit_input"><%=(s18)%></TEXTAREA></td>
    </tr>
    <%--
      <tr>
        <td><%=r.getString(teasession._nLanguage, "BeforeDetail")%>:</td>
        <td><TEXTAREA name=BeforeDetail ROWS=2 COLS=60 class="edit_input"><%=HtmlElement.htmlToText(s20)%></TEXTAREA></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "SeparatorDetail")%>:</td>
        <td><TEXTAREA name=SeparatorDetail ROWS=2 COLS=60 class="edit_input"><%=HtmlElement.htmlToText(s22)%></TEXTAREA></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "AfterDetail")%>:</td>
        <td><TEXTAREA name=AfterDetail ROWS=2 COLS=60 class="edit_input"><%=HtmlElement.htmlToText(s24)%></TEXTAREA></td>
      </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "BeforeChild")%>:</td>
      <td><TEXTAREA name=BeforeChild ROWS=2 COLS=60 class="edit_input"><%=(s26)%></TEXTAREA></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "AfterChild")%>:</td>
      <td><TEXTAREA name=AfterChild ROWS=2 COLS=60 class="edit_input"><%=(s28)%></TEXTAREA></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "BeforeChildDetail")%>:</td>
      <td><TEXTAREA name=BeforeChildDetail ROWS=2 COLS=60 class="edit_input"><%=(s30)%></TEXTAREA></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "SeparatorChildDetail")%>:</td>
      <td><TEXTAREA name=SeparatorChildDetail ROWS=2 COLS=60 class="edit_input"><%=(s32)%></TEXTAREA></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "AfterChildDetail")%>:</td>
      <td><TEXTAREA name=AfterChildDetail ROWS=2 COLS=60 class="edit_input"><%=(s34)%></TEXTAREA></td>
    </tr>
    --%>
  </table>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td nowrap><%=r.getString(teasession._nLanguage, "Type")%>: </td>
      <td><%
      for(int i9 = 0; i9 < Listing.LISTING_TYPE.length; i9++)
      {
        out.print("<input id='radio' type='radio' name='ltype' value='"+i9+"'");
        if(j==i9)out.print(" checked='true'");
        out.print(">"+r.getString(teasession._nLanguage, Listing.LISTING_TYPE[i9]));
      }
      %>
      </td>
    </tr>
    <tr>
      <td nowrap><%=r.getString(teasession._nLanguage, "Pick")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name=PickManual  <%if(l == 0)out.print(" checked='true'");%> >
        <%=r.getString(teasession._nLanguage, "PickManual")%>

        <%=r.getString(teasession._nLanguage, "Ectypal")%><input name="ectypal" type="text" value="<%=ectypal%>">
      </td>
    </tr>
    <%
    ListingDetail obj_ld= ListingDetail.find(listing,-1,teasession._nLanguage);
    int ckhref=0;
    for(int len=0;len<Listing.SHARE_DETAIL.length;len++)
    {
      int istype=0,seq=len+1,anchor=0,quantity=0;
      String bi="",ai="";
      Date time=null;
      if(obj_ld.isExists(Listing.SHARE_DETAIL[len]))
      {
        istype=obj_ld.getIstype(Listing.SHARE_DETAIL[len]);
        bi=HtmlElement.htmlToText(obj_ld.getBeforeItem(Listing.SHARE_DETAIL[len]));
        ai=HtmlElement.htmlToText(obj_ld.getAfterItem(Listing.SHARE_DETAIL[len]));
        seq=obj_ld.getSequence(Listing.SHARE_DETAIL[len]);
        anchor=obj_ld.getAnchor(Listing.SHARE_DETAIL[len]);
        quantity=obj_ld.getQuantity(Listing.SHARE_DETAIL[len]);
        time=obj_ld.getTime(Listing.SHARE_DETAIL[len]);
        ckhref=obj_ld.getCkhref(Listing.SHARE_DETAIL[len]);
      }
      out.print("<tr><td>");
      if(len>5&&len<11)out.print("　");
      out.print(r.getString(teasession._nLanguage, Listing.SHARE_DETAIL[len]));
      out.print("<td><select name="+Listing.SHARE_DETAIL[len]+">");//<input id=CHECKBOX type=CHECKBOX name="+Listing.SHARE_DETAIL[len]
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==istype)out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      out.print("</select>");
      out.println(r.getString(teasession._nLanguage, "Before")+"<input name="+Listing.SHARE_DETAIL[len]+"_1 value=\""+bi+"\" mask=max class=edit_input size=25 >");
      out.println(r.getString(teasession._nLanguage, "After")+"<input name="+Listing.SHARE_DETAIL[len]+"_2 value=\""+ai+"\" mask=max class=edit_input size=25 >");
      out.println(r.getString(teasession._nLanguage, "Sequence")+"<input name="+Listing.SHARE_DETAIL[len]+"_3 value="+seq+" class=edit_input size=3 >");
      if(len<2||len==6||len==7||len==21||len==26||len==29 )
      {
        if(len==29)
        {
          out.print("<select name="+Listing.SHARE_DETAIL[len]+"_4 >");
          out.print("<option value=0 >-----------");
          out.print("<option value=1 "+(anchor==1?" selected='true'":"")+">节点");
          out.print("<option value=2 "+(anchor==2?" selected='true'":"")+">大图");
          out.print("</select>");
        }
        else
        {
          out.print("<input type=checkbox name="+Listing.SHARE_DETAIL[len]+"_4 value=1 "+(anchor>0?" checked='true'":"")+">");
        }
        out.println(r.getString(teasession._nLanguage, "Anchor"));
        if(len<2||len==26)
        {
          if(len==1){
        	  out.println("<input type=checkbox name='ckhref' "+(ckhref>0?" checked=true ":" ")+">"+r.getString(teasession._nLanguage,"过滤html标签"));
          }
          out.println(r.getString(teasession._nLanguage, "Quantity")+"<input type=text size=3 name="+Listing.SHARE_DETAIL[len]+"_5 value="+quantity+" />");
        }
      }
      if(len==38)
      {
          out.println(r.getString(teasession._nLanguage, "英文分页"));
          out.print("<input type=checkbox name="+Listing.SHARE_DETAIL[len]+"_4 value=1 "+(anchor>0?" checked='true'":"")+">");
      }

      if(len==26)
      out.print(new tea.htmlx.TimeSelection(Listing.SHARE_DETAIL[len]+"_6",time));
    }
    %>



    <tr>
      <td nowrap><%=r.getString(teasession._nLanguage, "Access")%>:</td>
      <td><span><input  id="radio" type="radio" name="visible" VALUE=0 <%if(l2==0)out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Always")%> </span>
        <span><input  id="radio" type="radio" name="visible" VALUE=1 <%if(l2==1)out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "BeforeLogin")%> </span><span>
        <input  id="radio" type="radio" name="visible" VALUE=2 <%if(l2==2)out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "AfterLogin")%> </span><span>
        <input  id="radio" type="radio" name="visible" VALUE=3 <%if(l2==3)out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "BeforeAccess")%> </span><span>
        <input  id="radio" type="radio" name="visible" VALUE=4 <%if(l2==4)out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "AfterAccess")%> </span><span>
        <input  id="radio" type="radio" name="visible" VALUE=5 <%if(l2==5)out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "SectionCreator")%> </span><span>
        <input  id="radio" type="radio" name="visible" VALUE=6 <%if(l2==6)out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "NodeCreator")%></span>
      </td>
    </tr>
    <%--
      <tr>
        <td><%=r.getString(teasession._nLanguage, "PicturePosition")%>:</td>
        <td><input  id="radio" type="radio" name=PicturePosition VALUE=0 CHECKED>
          <%=r.getString(teasession._nLanguage, "TOP")%>
          <input  id="radio" type="radio" name=PicturePosition VALUE=1>
          <%=r.getString(teasession._nLanguage, "BOTTOM")%>
          <input  id="radio" type="radio" name=PicturePosition VALUE=2>
          <%=r.getString(teasession._nLanguage, "LEFT")%>
          <input  id="radio" type="radio" name=PicturePosition VALUE=3>
          <%=r.getString(teasession._nLanguage, "RIGHT")%></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "ClickUrl")%>:</td>
        <td><input type="TEXT" class="edit_input"  name=ClickUrl VALUE="" size="40" MAXLENGTH="255"></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Alt")%>:</td>
        <td><input type="TEXT" class="edit_input"  name=Alt VALUE="" size="40" MAXLENGTH="255"></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Picture")%>:</td>
        <td><input type="file" name="Picture" class="edit_input"/>
          <input  id="CHECKBOX" type="CHECKBOX" name=ClearPicture value=null>
          <%=r.getString(teasession._nLanguage, "Clear")%></td>
      </tr>

      <tr>
        <td><%=r.getString(teasession._nLanguage, "Align")%>:</td>
        <td><span><input  id="radio" type="radio" name=Align VALUE=0 CHECKED>
          <%=r.getString(teasession._nLanguage, "DEFAULT")%>
          </span><span><input  id="radio" type="radio" name=Align VALUE=1>
          <%=r.getString(teasession._nLanguage, "LEFT")%>
          </span><span><input  id="radio" type="radio" name=Align VALUE=2>
          <%=r.getString(teasession._nLanguage, "CENTER")%>
          </span><span><input  id="radio" type="radio" name=Align VALUE=3>
          <%=r.getString(teasession._nLanguage, "RIGHT")%>
         </span><span> <input  id="radio" type="radio" name=Align VALUE=4>
          <%=r.getString(teasession._nLanguage, "TOP")%>
          </span><span><input  id="radio" type="radio" name=Align VALUE=5>
          <%=r.getString(teasession._nLanguage, "BOTTOM")%></span></td>
      </tr>--%>
    <tr>
      <td nowrap><%=r.getString(teasession._nLanguage, "IssueTime")%>:</td>
      <td><%=new tea.htmlx.TimeSelection("Issue",date_l)%> </td>
    </tr>
    <tr>
      <td nowrap><%=r.getString(teasession._nLanguage, "HidenStyle")%>:
      <td><%
	for(int hsty = 0; hsty< Listing.LISTING_HideSyle.length; hsty++)
	{
          out.print("<input type=radio name=hiden value="+hsty);
          if(hsty == hidden)
          out.print(" CHECKED ");
          out.print(">"+r.getString(teasession._nLanguage, Listing.LISTING_HideSyle[hsty]));
        }
      %>
  </table>
</FORM>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
