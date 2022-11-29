<%@page contentType="text/html;charset=UTF-8" %>
<%//@include file="/jsp/Header.jsp"%>

<%request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
tea.ui.TeaSession teasession = new tea.ui.TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+request.getRequestURI()+"?"+request.getQueryString());
  return;
}
tea.resource.Resource r=new tea.resource.Resource();

String s = request.getParameter("community");
tea.entity.node.Node node;
int father=Integer.parseInt(request.getParameter("father"));

if(request.getMethod().equals("POST")||request.getParameter("delete")!=null)
{
  node=tea.entity.node.Node.find(teasession._nNode);
  if(request.getParameter("delete")!=null)
  {
    node.delete(teasession._nLanguage);
  }else
  {
    int sequence=0;
    int type=Integer.parseInt(request.getParameter("type"));
    int ta=0;
    int options1=node.getOptions1();
    String name=request.getParameter("subject");
    String text=request.getParameter("text");
    if(request.getParameter("EditNode")==null)
    {
      teasession._nNode = tea.entity.node.Node.create(father, sequence, s, teasession._rv, 1, 0, (options1 & 2) != 0, node.getOptions(), options1, node.getDefaultLanguage(), null, null, teasession._nLanguage, name, null, text, null, "", 0, null, "", "", "", "", null,new java.util.Date(),0,0,0,0,"","");
      node.finished(teasession._nNode);
    }else
    {
      node.set(teasession._nLanguage,name,text);
    }
    tea.entity.node.Category category = tea.entity.node.Category.find(teasession._nNode);
    category.set(type, ta, 0);
  }
  response.sendRedirect("/jsp/info/Succeed.jsp?community="+s);
  return;
}



String subject,text;
int type=0;
if(request.getParameter("EditNode")!=null)
{
  node=tea.entity.node.Node.find(teasession._nNode);
  subject=node.getSubject(teasession._nLanguage);
  text=tea.html.HtmlElement.htmlToText(node.getText(teasession._nLanguage));
  tea.entity.node.Category category = tea.entity.node.Category.find(teasession._nNode);
  type=category.getCategory();
}else
subject=text="";


%>
<html>
<head>
<link href="/res/<%=s%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="">
function fc(obj)
{
  obj.value=parseInt(obj.value);
  if(isNaN(obj.value))
  {
    obj.value=0;
  }
}
</script>
</head>
<body onLoad="var index=(document.location+'').indexOf('?');if(index==-1)index=(document.location+'').length;form111_NET.action=(document.location+'').substring(0,index);form111_NET.subject.focus();">
   <h1>商品类别管理</h1>
   <div id="head6"><img height="6" alt=""></div>
   <br>

   <FORM name="form111_NET" METHOD=POST action="<%//=request.getRequestURI()%>" onSubmit="return(submitText(this.subject,'<%=r.getString(teasession._nLanguage, "InvlaidSubject")%>'));">
     <input type=hidden name="community" value="<%=s%>" />
     <input type=hidden name="type" value="34" />
<%
if(request.getParameter("id")!=null)
{
  out.print("<input type=hidden name=id value="+request.getParameter("id")+" />");
}
if(request.getParameter("EditNode")!=null)
{
  out.print("<input type=hidden name=EditNode value=ON />");
}else
{

}
%> <input type=hidden name="father" value="<%=father%>" />
     <input type=hidden name="Node" value="<%=teasession._nNode%>" />
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
       <tr>
         <td><%=r.getString(teasession._nLanguage, "Subject")%>:</td>
         <td><input type="text" name=subject value="<%=subject%>" ></td>
       </tr>
       <tr>
         <td><%=r.getString(teasession._nLanguage, "Text")%>:</td>
         <td><textarea name="text" style="" rows="3" cols="60" class="edit_input"><%=text%></textarea></td>
       </tr>
     </table>
     <input type="submit" value="<%=r.getString(teasession._nLanguage, "Submit")%>"/>
   </FORM>

<br>
<TABLE  cellSpacing="0" cellPadding="0" width="100%"  border="0" id="tablecenter">
				<TR id="tableonetr">
                                <td><%=r.getString(teasession._nLanguage,"Subject")%></td>
                                <td><%=r.getString(teasession._nLanguage,"Text")%></td>
                                <td><%=r.getString(teasession._nLanguage,"Time")%></td>
                                <td></td>
                                </tr>
                                <%
                                //if(dc.getNode()>0)
                                {
                                  java.util.Enumeration enumer=tea.entity.node.Node.findAllSons(father);
                                  while(enumer.hasMoreElements())
                                  {
                                  int node_id=((Integer)  enumer.nextElement()).intValue();
                                  tea.entity.node.Node node_enumer=  tea.entity.node.Node.find(node_id);
                                  %>
                                  <tr>
                                    <td><%=node_enumer.getSubject(teasession._nLanguage)%></td>
                                    <td><%=node_enumer.getText(teasession._nLanguage)%></td>
                                    <td><%=node_enumer.getTimeToString()%></td>
                                    <td>
                                    <input type="button" onClick="window.location='<%=request.getRequestURI()+"?node="+node_id+"&EditNode=ON&"+request.getQueryString()%>';" value="<%=r.getString(teasession._nLanguage,"CBEdit")%>">
                                    <input type="button" onClick="if(confirm('<%=r.getString(teasession._nLanguage,"ConfirmDelete")%>(本类下的所有商品,将被删除.)')){window.location='<%=request.getRequestURI()+"?node="+node_id+"&delete=ON&"+request.getQueryString()%>';}"  value="<%=r.getString(teasession._nLanguage,"CBDelete")%>">
                                    </td>
                                  </tr>
                                  <%
                                  }
                                }
                                %>
                                </table>



<br>
<div id="head6"><img height="6" alt=""></div>

<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>

</body>
</html>

