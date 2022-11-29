<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
Blog blog=Blog.find(node.getCommunity(),teasession._rv._strR);
if(request.getMethod().equals("POST"))
{
  String subject=teasession.getParameter("subject");
  String text=teasession.getParameter("text");
  int node_code=Integer.parseInt(teasession.getParameter("Node"));
  if("new".equals(teasession.getParameter("act")))
  {
    //teasession._nNode = Node.create(node_code,0,node.getCommunity(),teasession._rv,1,false,node.getOptions(),0,1,null,null,new java.util.Date(),0,0,0,0,"",null,teasession._nLanguage,subject,subject,text,null,"",0,null,"","","","",null,null);
    teasession._nNode = Node.create(node_code,0,node.getCommunity(),teasession._rv,1,false,node.getOptions(),0,1,null,null,new Date(),0,0,0,0,"",teasession._nLanguage,subject,subject,"",text,"","",0,"","","","","","","");
    node.finished(teasession._nNode);
    //类别
    Category category = Category.find(teasession._nNode);
    category.set(Integer.parseInt(request.getParameter("type")), 0, 0);
  }else
  {
    node.set(teasession._nLanguage,subject,text);
    Category category = Category.find(teasession._nNode);
    category.set(Integer.parseInt(request.getParameter("type")), 0, 0);
  }
  response.sendRedirect(request.getRequestURI()+"?node="+teasession._nNode);
  return;
}
%>







<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></head>
<body>
<h1><%=r.getString(teasession._nLanguage, "WeblogEditNode")%></h1>
  <div id="head6"><img height="6" src="about:blank" alt=""></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td>栏目可以很好的组织文章，您应当为您的栏目取上一个贴切而又有针对性的名称， 使访问者能够很清楚栏目的内容；通过描述你可以更详细说明该栏目下的内容；选择分类做为该栏目下文章的默认分类， 这样你不用每次撰写文章时重新选择分类，当然这里选择的栏目分类并不会完全限制住文章的分类，实际发布时还可以根据需要选择其他分类。 删除栏目通常用做废除无用的栏目，为了保证数据的安全性，系统规定只有在栏目为空的情况下（即栏目下无文章）才可以删除栏目。
</td></tr></table>

   <h2>栏目管理</h2>
       <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
         <tr ID=tableonetr>
           <td nowrap style="text-align:center">栏目名称</td>
           <td nowrap>类型</td>
           <td nowrap>内容数量</td>
           <td nowrap>创建时间</td>
           <td>操作</td>
         </tr>
         <%
            tea.db.DbAdapter dbadapter=new tea.db.DbAdapter();
            try
            {
              dbadapter.executeQuery("SELECT node FROM Node WHERE father!= 0 and father="+blog.getHome()+" AND rcreator="+dbadapter.cite(teasession._rv._strR)+" AND vcreator="+dbadapter.cite(teasession._rv._strV));
              while(dbadapter.next())
              {
                Node cj_obj=Node.find(dbadapter.getInt(1));
                Category category = Category.find(cj_obj._nNode);

                %>
         <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
           <td><%= cj_obj.getSubject(teasession._nLanguage)%></td>
           <td><%
                  switch(category.getCategory())
                  {
                    case 82:
                    out.print("文章");
                    break;
                    case 34:
                    out.print("产品");
                    break;
                  }
                  %></td>
           <td><%=cj_obj.countSons(cj_obj._nNode,teasession._rv)%></td>
           <td><%=cj_obj.getTimeToString()%></td>
           <td><input type="BUTTON" value="编辑" id="CBDelete" class="CB" onClick="form1.Node.value='<%=cj_obj._nNode%>';form1.act.value='';form1.subject.value='<%= HtmlElement.htmlToText(cj_obj.getSubject(teasession._nLanguage))%>';form1.text.value='<%= HtmlElement.htmlToText(cj_obj.getText(teasession._nLanguage))%>'; form1.type.value='<%=category.getCategory()%>';"/>
               <input type="BUTTON" value="删除" id="CBDelete" class="CB" onClick="if(confirm('确认删除')){window.open('/servlet/DeleteNode?node=<%=cj_obj._nNode%>', '_self')};"/>
           </td>
         </tr>
         <% }
              }catch(Exception e)
              {
              }finally
              {
                dbadapter.close();
              }
              %>
       </table>
       <form action="<%=request.getRequestURI()%>" method="POST" name="form1">
      <input type="hidden" name="Node" value="<%=blog.getHome()%>">
      <input type="hidden" name="act" value="new"/>
      <H2>新增栏目</H2>
      <input type="hidden" name="type" value="82">
      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr><td>栏目名称：</td><td><input type="text" name="subject" class="edit_input" value="" size="50"></td></tr>
 <tr style="display:none"><td>栏目类型：</td><td>
  <select name="type">
  <option selected value="82">文章</option>
  <option  value="34" >产品</option>
  </select>
  </td></tr>

<tr><td>描述:</td><td><textarea name="text" rows="8" cols="70" class="edit_input"><%//=HtmlElement.htmlToText(s6)%></textarea>
</td></tr>
 <tr><td colspan="2">         <input  class="edit_button" value="新增" type="submit">
</td></tr>
</table>
    </FORM>

<div id="head6"><img height="6" src="about:blank" alt=""></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

