<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page import="java.util.*" %><%@ page import="tea.resource.Resource" %><%@ page import="tea.entity.confab.*" %><%@ page import="tea.entity.site.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource("tea/resource/Dynamic");

String community=request.getParameter("community");

Node node=Node.find(teasession._nNode);

%>
<HTML>
<HEAD>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<link rel="stylesheet" href="/jsp/include/word_edit/word_edit.css" type="text/css" media="all" />
<script type="text/javascript" src="/jsp/include/word_edit/word_edit.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body onLoad="try{ form1.subject.focus(); }catch(ex){}">
<!--
<h1><%=r.getString(teasession._nLanguage, "BargainManage")%></h1>
-->
<div id="head6"><img height="6" src="about:blank"></div>

<form name=form1 action="/servlet/EditDynamicValue" method="post" enctype=multipart/form-data onSubmit="javascript:return fcheck(this);">
  <%
    String parameter=teasession.getParameter("nexturl");
    boolean parambool=(parameter!=null&&!parameter.equals("null"));
    if(parambool)
    out.print("<input type='hidden' name=nexturl value="+parameter+">");
    int type;
    String subject="";
    String keywords="";
    Date issueDate=null;
    String text="";
   long lensmaill=0,lenbig=0,lenrecommend=0;
   if(request.getParameter("NewNode")!=null)
   {
     out.println("<INPUT TYPE=hidden NAME=NewNode VALUE=ON>");
     type=Integer.parseInt(request.getParameter("Type"));
   }else
   {
     subject=node.getSubject(teasession._nLanguage);
     keywords=node.getKeywords(teasession._nLanguage);
     issueDate=node.getTime();
     text=tea.html.HtmlElement.htmlToText(node.getText(teasession._nLanguage));
     type=node.getType();
   }
   StringBuffer sbcheck=new StringBuffer();



   %>
  <input type="hidden" name="node" value="<%=teasession._nNode%>">
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td><%
      Category c_obj=Category.find(node._nNode);
      Dynamic d_obj=Dynamic.find(c_obj.getCategory());
      if(d_obj.getName(teasession._nLanguage)!=null)
      {
        out.print(d_obj.getName(teasession._nLanguage));
      } else
      {
        Node nobj = Node.find( node.getFather());
        out.print(nobj.getSubject(teasession._nLanguage));
      }
      %>名称:</td>
      <td nowrap class=huititable ><input name="subject" class="edit_input" onKeyDown="if(event.keyCode==13){event.keyCode=9;}" type="text" value="<%=subject%>" size="25" maxlength="100">
      （*请您填写一个名称，以快速识辨您的内容）
      </td>
    </tr>
    <tr style="display:none ">
      <td><%=r.getString(teasession._nLanguage,"Time")%>:</td>
      <td nowrap class=huititable  ><%=new tea.htmlx.TimeSelection("Issue", issueDate)%> </td>
    </tr>
  </table >
  <%
  java.util.Enumeration enumeration=DynamicType.findByDynamic(type);
  int id=0;
  while(enumeration.hasMoreElements())
  {
    id=((Integer)enumeration.nextElement()).intValue();
    DynamicType obj=DynamicType.find(id);
    if(obj.isHidden())
    {
      if(obj.isNeed())
      {
        sbcheck.append("&&submitText(form1.dynamictype"+id+", '"+r.getString(teasession._nLanguage, "InvalidParameter")+"-"+obj.getName(teasession._nLanguage)+"')");
        ///out.print("*&#12288;");
      }
      //out.print(obj.getName(teasession._nLanguage));
      // out.print("test:"+id);
      out.print(obj.getText(teasession,teasession._nNode,0));
    }
}%>
<script type="">
function fcheck()
{
  // alert(sbcheck.toString());
  return submitText(form1.subject, '<%=r.getString(teasession._nLanguage, "InvalidSubject")%>')<%=sbcheck.toString()%>;
}
</script>
<div align="center">
    <!--INPUT TYPE=SUBMIT NAME="GoBack"  ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Super")%>"-->
    <INPUT TYPE=SUBMIT NAME="GoSave"  ID="EditCebbankDynamicValue_GoSave" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "CBSave")%>">
    <INPUT TYPE=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "CBFinishedUp")%>">
    <input class="edit_button" type="button" value="返回" onClick="history.back();">
  </div>
</form>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
