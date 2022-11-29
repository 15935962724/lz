<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="tea.html.*" %><%@ page import="java.math.*" %><%@page import="tea.ui.node.general.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.*" %><%@ page import="tea.entity.site.*" %><%@ page import="tea.entity.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.*" %><% request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");


TeaSession teasession=new TeaSession(request);

int listing=Integer.parseInt(request.getParameter("listing"));
int picknode=Integer.parseInt(request.getParameter("picknode"));
Node node = Node.find(teasession._nNode);
int k = 0;
int type = 255;
int j1 = 0;
int l1 = 0;
String s2 =node.getCreator()._strR;
String s3 = node.getCreator()._strV;
int k2 = 0;
int l2 = 0;
int j3 = 0;
int l3 = 0;
int bbstype=0;
String parameter=null;
if(picknode>0)
{
  PickNode obj = PickNode.find(picknode);
  listing=obj.listing;

  k = obj.nodeStyle;
  type = obj.type;
  l1 = obj.creatorStyle;
  s2 = obj.rcreator;
  s3 = obj.vcreator;
  k2 = obj.startStyle;
  l2 = obj.startTerm;
  j3 = obj.stopStyle;
  l3 = obj.stopTerm;
  bbstype=obj.bbstype;
  parameter=obj.parameter;
}

int realnode= Listing.find(listing).getNode();
if(realnode>0&&!Node.find(realnode).isCreator(teasession._rv)&&AccessMember.find(realnode,teasession._rv).getPurview()<2)
{
	response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}




Resource r=new Resource("/tea/ui/node/listing/EditPickNode");

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script type="">
function f_change()
{
  cs1.style.display="none";
  cs2.style.display="none";
  var cs=parseInt(form1.CreatorStyle.value);
  if(cs==1||cs==3)cs1.style.display="";
  if(cs==2||cs==3)cs2.style.display="";
}
</script>
</head>
<body onload="f_change()">
<h1><%=r.getString(teasession._nLanguage, "PickNode")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
<FORM name=form1 METHOD=POST action="/servlet/EditPickNode" onSubmit="return(submitInteger(this.StartTerm,'<%=r.getString(teasession._nLanguage, "InvalidStartTerm")%>')&&submitInteger(this.StopTerm,'<%=r.getString(teasession._nLanguage, "InvalidStopTerm")%>'))">
  <INPUT type='hidden' name="node" value="<%=teasession._nNode%>">
  <INPUT type='hidden' name="listing" value="<%=listing%>">
  <input type='hidden' name="picknode" value="<%=picknode%>">

  <TABLE border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <Td align="right"><%=r.getString(teasession._nLanguage, "NodeStyle")%>：</Td>
      <td><SELECT name=NodeStyle>
          <OPTION <%if(k==0)out.print(" selected='true'");%> VALUE="0"><%=r.getString(teasession._nLanguage, PickNode.NODE_STYLE[0])%></OPTION>
          <OPTION <%if(k==1)out.print(" selected='true'");%> VALUE="1"><%=r.getString(teasession._nLanguage, PickNode.NODE_STYLE[1])%></OPTION>
          <OPTION <%if(k==2)out.print(" selected='true'");%> VALUE="2"><%=r.getString(teasession._nLanguage, PickNode.NODE_STYLE[2])%></OPTION>
          <OPTION <%if(k==3)out.print(" selected='true'");%> VALUE="3"><%=r.getString(teasession._nLanguage, PickNode.NODE_STYLE[3])%></OPTION>
        </SELECT></td>
    </tr>
    <tr>
      <Td  align="right" ID=RowHeader><%=r.getString(teasession._nLanguage, "Type")%>：</Td>
      <td><%=new tea.htmlx.TypeSelection(teasession._strCommunity,teasession._nLanguage, type)%>
      &nbsp;如果是贴子类可以显示:&nbsp;&nbsp;<input type="radio" name="bbstype" value="0" <%if(bbstype==0){out.print(" checked ");} %> >&nbsp;全部&nbsp;&nbsp;
      <input type="radio" name="bbstype" value="1"  <%if(bbstype==1){out.print(" checked ");} %> >&nbsp;精华
      </td>
    </tr>
    <tr>
      <Td  align="right" ID=RowHeader><%=r.getString(teasession._nLanguage, "CreatorStyle") %>：</Td>
      <td><SELECT name=CreatorStyle onchange="f_change()">
          <OPTION <%if(l1==0)out.print(" selected='true'");%> VALUE="0"><%=r.getString(teasession._nLanguage, PickNode.CREATOR_STYLE[0])%></OPTION>
          <OPTION <%if(l1==1)out.print(" selected='true'");%> VALUE="1"><%=r.getString(teasession._nLanguage, PickNode.CREATOR_STYLE[1])%></OPTION>
          <OPTION <%if(l1==2)out.print(" selected='true'");%> VALUE="2"><%=r.getString(teasession._nLanguage, PickNode.CREATOR_STYLE[2])%></OPTION>
          <OPTION <%if(l1==3)out.print(" selected='true'");%> VALUE="3"><%=r.getString(teasession._nLanguage, PickNode.CREATOR_STYLE[3])%></OPTION>
        </SELECT>
      </td>
    </tr>
    <tr id="cs1" style="display:none">
      <Td  align="right" ID=RowHeader><%=r.getString(teasession._nLanguage, "RCreator")%>：</Td>
      <td><INPUT type="text" class="edit_input" <%if(s2.length()<=0)out.print("disabled");%> name=RCreator VALUE="<%=s2%>">
        <input <%if(s2.length()<=0)out.print(" checked='true'");%> onClick="form1.RCreator.disabled=this.checked;"  id="CHECKBOX" type="CHECKBOX" name="CurrentMember"/>
        <%=r.getString(teasession._nLanguage, "CurrentMember")%></td>
    </tr>
    <tr id="cs2" style="display:none">
      <Td  align="right" ID=RowHeader><%=r.getString(teasession._nLanguage, "VCreator")%>：</Td>
      <td><INPUT type="text" class="edit_input" name=VCreator VALUE="<%=s3%>"></td>
    </tr>
    <tr>
      <Td  align="right" ID=RowHeader><%=r.getString(teasession._nLanguage, "StartStyle")%>：</td>
      <td><SELECT name=StartStyle>
          <OPTION  VALUE="0" <%if(k2==0)out.print(" selected ");%>><%=r.getString(teasession._nLanguage, PickNode.TERM_STYLE[0])%></OPTION>
          <OPTION  VALUE="1" <%if(k2==1)out.print(" selected ");%>><%=r.getString(teasession._nLanguage, PickNode.TERM_STYLE[1])%></OPTION>
          <OPTION  VALUE="2" <%if(k2==2)out.print(" selected ");%>><%=r.getString(teasession._nLanguage, PickNode.TERM_STYLE[2])%></OPTION>
        </SELECT>
        <INPUT type="text" name=StartTerm VALUE="<%=l2%>" SIZE=3>
        <%=r.getString(teasession._nLanguage, "Hours")%></td>
    </tr>
    <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "StopStyle")%>：</Td>
      <td><SELECT name=StopStyle>
          <OPTION <%if(j3==0)out.print(" selected ");%> VALUE="0"><%=r.getString(teasession._nLanguage, PickNode.TERM_STYLE[0])%></OPTION>
          <OPTION <%if(j3==1)out.print(" selected ");%> VALUE="1"><%=r.getString(teasession._nLanguage, PickNode.TERM_STYLE[1])%></OPTION>
          <OPTION <%if(j3==2)out.print(" selected ");%> VALUE="2"><%=r.getString(teasession._nLanguage, PickNode.TERM_STYLE[2])%></OPTION>
        </SELECT>
        <INPUT type="text" name=StopTerm VALUE="<%=l3%>" SIZE=3>
        <%=r.getString(teasession._nLanguage, "Hours")%></td>
    </tr>
    <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "参数名")%>：</Td>
      <td><input name="parameter" value="<%=MT.f(parameter)%>"/> 多个参数用“,”分隔</td>
    </tr>
  </TABLE>

  <INPUT TYPE=SUBMIT  class="edit_button" id="edit_next"  NAME="GoNext" VALUE="<%=r.getString(teasession._nLanguage, "CBNext")%>">
  <INPUT type="SUBMIT" class="edit_button" id="edit_submit" VALUE="<%=r.getString(teasession._nLanguage, "Submit")%>">
</FORM>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage, request)%></div>
</body>
</html>
