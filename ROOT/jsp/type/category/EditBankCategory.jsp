<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.entity.site.*" %><%@ page import="java.util.*" %><%//@include file="/jsp/Header.jsp"%><%
request.setCharacterEncoding("UTF-8");

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

int sort = 1;
String tmp=request.getParameter("sort");
if(tmp!=null && tmp.length()>0)
{
  sort = Integer.parseInt(tmp);
}
String s = teasession._strCommunity;

DCommunity dc=DCommunity.find(s);
if(dc.getNode()<=0)
{
  response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("对不起,您还没有设置所属文件夹","UTF-8"));
  return;
}


if(request.getMethod().equals("POST")||request.getParameter("delete")!=null)
{
  Node node=Node.find(teasession._nNode);
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
    if(request.getParameter("editnode")==null)
    {
      //teasession._nNode = Node.create(teasession._nNode, sequence, s, teasession._rv, 1, (options1 & 2) != 0, node.getOptions(), options1, node.getDefaultLanguage(), null, null,new java.util.Date(),0,0,0,0,null,null, teasession._nLanguage, name, null,"", text, null, "", 0, null, "", "", "", "", null,null);
        teasession._nNode = Node.create(teasession._nNode,sequence,s,teasession._rv,1,false,node.getOptions(),options1,node.getDefaultLanguage(),null,null,new Date(),0,0,0,0,"",teasession._nLanguage,"",name,"",text,"","",0,"","","","","","","");
      node.finished(teasession._nNode);
    }else
    {
      node.set(teasession._nLanguage,name,text);
    }
    Category category = Category.find(teasession._nNode);
    //category.set(type, ta, 0,"");
    category.set(type,ta,0,"",0);
  }
  response.sendRedirect("/jsp/info/Succeed.jsp?community="+s);
  return;
}



String subject,text;
int type=0;
if(request.getParameter("editnode")!=null)
{
  Node node=Node.find(teasession._nNode);
  subject=node.getSubject(teasession._nLanguage);
  text=tea.html.HtmlElement.htmlToText(node.getText(teasession._nLanguage));
  Category category = Category.find(teasession._nNode);
  type=category.getCategory();
}else
{
  subject=text="";
}

String strid=request.getParameter("id");

String info=request.getParameter("info");
if(info==null)
{
  info=r.getString(teasession._nLanguage, "Categoty");
}

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
   <h1><%=info%></h1>
   <div id="head6"><img height="6" alt=""></div>
   <br>

<FORM name="form111_NET" METHOD=POST action="?" onSubmit="return(submitText(this.subject,'<%=r.getString(teasession._nLanguage, "InvlaidSubject")%>')&&submitText(this.type,'<%=r.getString(teasession._nLanguage, "Type")%>'));">
<input type=hidden name="community" value="<%=s%>">
<input type=hidden name="id" value="<%=strid%>">
<%
if(request.getParameter("editnode")!=null)
{
  out.print("<input type=hidden name=editnode value=ON />");
}else
{
    teasession._nNode=dc.getNode();
}
%>
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
       <tr>
       <td><%=r.getString(teasession._nLanguage, "Type")%>:</td>
         <td>
       <%
        tea.html.DropDown dropdown = new tea.html.DropDown("type", type);
        dropdown.addOption("","--------------------");
        for(Enumeration enumeration = Dynamic.findByCommunity(s,sort); enumeration.hasMoreElements(); )
        {
          int id = ((Integer)enumeration.nextElement()).intValue();
          Dynamic dynamic = Dynamic.find(id);
          dropdown.addOption(id,dynamic.getName(teasession._nLanguage));
        }
        //dropdown.sort();
        out.println(dropdown.toString());
       %>
       </td>
     </table>
     <input type="submit" value="<%=r.getString(teasession._nLanguage, "Submit")%>"/>
   </FORM>

<br>
<TABLE  cellSpacing="0" cellPadding="0" width="100%"  border="0" id="tablecenter">
  <TR id="tableonetr">
  <td>Node ID</td>
    <td><%=r.getString(teasession._nLanguage,"Subject")%></td>
    <td><%=r.getString(teasession._nLanguage,"Text")%></td>
    <td><%=r.getString(teasession._nLanguage,"Time")%></td>
    <td></td>
  </tr>
  <%
  java.util.Enumeration enumer=Node.findAllSons(dc.getNode());
  while(enumer.hasMoreElements())
  {
    int node_id=((Integer)  enumer.nextElement()).intValue();
    Category c=Category.find(node_id);
    if(c.getCategory()>=1024)
    {
      Node node_enumer=  Node.find(node_id);
      Dynamic dynamic = Dynamic.find(c.getCategory());
      if(dynamic.getSort()==sort)
      {
        %>
        <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
          <td><%=node_id%></td>
          <td><%=node_enumer.getSubject(teasession._nLanguage)%></td>
          <td><%=node_enumer.getText(teasession._nLanguage)%></td>
          <td><%=node_enumer.getTimeToString()%></td>
          <td>
            <input type="button" onClick="window.location='<%="?id="+strid+"&node="+node_id+"&editnode=ON&"+request.getQueryString()%>';" value="<%=r.getString(teasession._nLanguage,"CBEdit")%>">
            <input type="button" onClick="if(confirm('<%=r.getString(teasession._nLanguage,"ConfirmDelete")%>')){window.location='<%="?id="+strid+"&node="+node_id+"&delete=ON&"+request.getQueryString()%>'; this.disabled=true;}"  value="<%=r.getString(teasession._nLanguage,"CBDelete")%>">
          </td>
        </tr>
        <%
      }
    }
  }
%>
</table>



<br>
<div id="head6"><img height="6" alt=""></div>

<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>

</body>
</html>
