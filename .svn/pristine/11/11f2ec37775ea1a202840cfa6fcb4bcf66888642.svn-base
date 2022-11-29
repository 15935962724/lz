<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.node.*" %>
<%@include file="/jsp/Header.jsp"%>
<%


Node node=Node.find(teasession._nNode);
String community=node.getCommunity();
int options1=node.getOptions1();
if(node.getType()==1)//如果是编辑就取父节点的选项,即：类别
{
  options1=Node.find(node.getFather()).getOptions1();
}
if((options1& 1) == 0)
{
  if(teasession._rv==null)
  {
    response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
    return;
  }
  int type=node.getType();
  if(type==1)
  {
    Category category = Category.find(teasession._nNode);//显示类别中的内容
    type=category.getCategory();
  }
  if (!node.isCreator(teasession._rv)&&!AccessMember.find(node._nNode, teasession._rv._strV).isProvider(type))
  {
    response.sendError(403);
    return;
  }
}

Movie movie = Movie.find(teasession._nNode);

String subject="";
if(node.getType()>1)
{
  subject=node.getSubject(teasession._nLanguage);
}
String picture=movie.getMvpic();

java.util.Date date_r=null;
if(node.getTime()!=null)
{
  date_r=node.getTime();
}
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script type="">
function f_click(obj)
{
  var view=document.getElementById("view");
  view.src=obj.value;

  document.getElementById("view").style.display="";
}
function   isFloat(){

  var   f2   =   foEdit._nName.value;//------------a   为某组件的name，这里是个文本框
  if   (foEdit._nName.value=="" || f2==null)
  {
    alert("菜品名称不能为空！");
    return   false;
  }
  var   f   =   document.all.dishprice.value;//------------a   为某组件的name，这里是个文本框
  var   j=0   ;
          if   (f==""){
      alert("价格不能为空！");
      return   false;
  }
  if(f.charAt(0)=="0"){
      alert("价格：第一位不能为0！");
      return   false;
  }
  if(f.charAt(f.length-1)=="."){
      alert("价格：最后一位不能是小数点！");
      return   false;
  }
  for(var   i   =   0;i<f.length;i++){
      if(f.charAt(i)=="."){
  if(i==0){
      alert("价格：第一位不能是小数点！");
      return   false;
  }
          j=j+1;
      }
      if(j>1){
          alert("价格：小数点个数有误！");
  return   false;
      }
  }
  for(var   i   =   0;i<f.length;i++){
      if(f.charAt(i)<"0"||f.charAt(i)>"9"){
                  if(f.charAt(i)!="."){
      alert("价格：只能是整数或小数！");
      return   false;
  }
      }
  }
  return   true;
      }
  //-->
  </script>
</head>

<body>
<h1><%=r.getString(teasession._nLanguage, "EditMovie")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

  <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>

  <FORM name=foEdit METHOD=POST action="/servlet/EditMovie" enctype="multipart/form-data">
<%
String parameter=teasession.getParameter("nexturl");
boolean parambool=(parameter!=null&&!parameter.equals("null"));
if(parambool)
out.print("<input type='hidden' name=nexturl value="+parameter+">");
%>
    <input type='hidden' name=node VALUE="<%=teasession._nNode%>">
    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr><TD>*<%=r.getString(teasession._nLanguage, "mvname")%>: </TD>
        <td><input type="TEXT" class="edit_input"  name=subject SIZE=40 VALUE="<%=subject%>" MAXLENGTH=40></td>
</tr>
<tr>
  <td><%=r.getString(teasession._nLanguage, "mvpic")%>:</td>
  <td COLSPAN=6><input type="file" name="mvpic" size="40">
    <%
    if(picture!=null)
    {
       long lenpic=new File(application.getRealPath(picture)).length();
      out.print("<a target='_blank' href="+picture+" >"+lenpic+r.getString(teasession._nLanguage,"Bytes")+"</a>");
      out.print("<input type='CHECKBOX' name='clearpicture' onClick='foEdit.picture.disabled=checked' />"+r.getString(teasession._nLanguage, "Clear"));
    }
    %>
  </td>
</tr>
<tr><TD><%=r.getString(teasession._nLanguage, "performer")%>:</TD>
  <td><textarea cols="48" rows="3" name="performer"><%if(movie.getPerformer()!=null){out.print(movie.getPerformer());}else{out.print("");}%></textarea></td>
</tr>

<tr><TD><%=r.getString(teasession._nLanguage, "direct")%>: </TD>
  <td><textarea cols="48" rows="3" name="direct"><%if(movie.getDirect()!=null){out.print(movie.getDirect());}else{out.print("");}%></textarea></td>
</tr>

<tr><TD><%=r.getString(teasession._nLanguage, "mvcountry")%>: </TD>
  <td><input  name="country" value="<%if(movie.getCountry()!=null){out.print(movie.getCountry());}else{out.print("");}%>"></td>
</tr>
<tr><TD><%=r.getString(teasession._nLanguage, "mvtype")%>: </TD>
  <td><select name="mvtype"><%
  for(int i=0;i<Movie.MVTYPE.length;i++)
  {
    out.print("<option value="+Movie.MVTYPE[i]);
    if(movie.getMvtype()!=null)
    {
      if(movie.getMvtype().toString().equals(Movie.MVTYPE[i]))
      {
        out.print(" selected　");
      }
    }
    out.print(" />"+Movie.MVTYPE[i]+"</option>");
  }
  %></select>  </td>
</tr>
<tr><TD><%=r.getString(teasession._nLanguage, "mvmaking")%>: </TD>
  <td><textarea cols="48" rows="3" name="mvmaking"><%if(movie.getMvmaking()!=null){out.print(movie.getMvmaking());}else{out.print("");}%></textarea></td>
</tr>
<tr><TD><%=r.getString(teasession._nLanguage, "mvgrade")%>: </TD>
  <td><textarea cols="48" rows="3" name="mvgrade"><%if(movie.getMvgrade()!=null){out.print(movie.getMvgrade());}else{out.print("");}%></textarea></td>
</tr>
<tr><TD><%=r.getString(teasession._nLanguage, "publisher")%>: </TD>
  <td><textarea cols="48" rows="3" name="publisher"><%if(movie.getPublisher()!=null){out.print(movie.getPublisher());}else{out.print("");}%></textarea></td>
</tr>
<tr><TD><%=r.getString(teasession._nLanguage, "mvyear")%>: </TD>
  <td><select name="mvyear">
  <%
  Calendar cal = Calendar.getInstance();
  int year = cal.get(Calendar.YEAR);
  for(int i=1985;i<=year;i++)
  {
    out.print("<option value="+i);
    if(movie.getMvyear()==i)
    {
      out.print("   selected  ");
    }
      out.print(">"+i+"</option>");
  }

  %></select></td>
</tr>
<tr><TD><%=r.getString(teasession._nLanguage, "mvaward")%>: </TD>
  <td><textarea cols="48" rows="3" name="mvaward"><%if(movie.getMvaward()!=null){out.print(movie.getMvaward());}else{out.print("");}%></textarea></td>
</tr>
<tr><TD><%=r.getString(teasession._nLanguage, "behindcontent")%>: </TD>
  <td><textarea cols="48" rows="3" name="behindcontent"><%if(movie.getBehindcontent()!=null){out.print(movie.getBehindcontent());}else{out.print("");}%></textarea></td>
</tr>
<tr><TD><%=r.getString(teasession._nLanguage, "feature")%>: </TD>
  <td><textarea cols="48" rows="3" name="feature"><%if(movie.getFeature()!=null){out.print(movie.getFeature());}else{out.print("");}%></textarea></td>
</tr>

<tr><TD><%=r.getString(teasession._nLanguage, "languagetype")%>: </TD>
  <td><input  name="languagetype" value="<%if(movie.getLanguagetype()!=null){out.print(movie.getLanguagetype());}else{out.print("");}%>"></td>
</tr>
<tr><TD><%=r.getString(teasession._nLanguage, "mvcontent")%>: </TD>
  <td><textarea cols="48" rows="3" name="content"><%if(node.getText(teasession._nLanguage)!=null){out.print(node.getText(teasession._nLanguage));}else{out.print("");}%></textarea></td>
</tr>

<tr><TD><%=r.getString(teasession._nLanguage, "mvprice")%>: </TD>
  <td><input type="TEXT" class="edit_input"  name=mvprice SIZE=10 VALUE="<%if(movie.getMvprice()!=null){out.print(movie.getMvprice());}else{out.print("");}%>" MAXLENGTH=40 mask="float"></td>
</tr>
<tr><TD><%=r.getString(teasession._nLanguage, "mvpath")%>: </TD>
  <td><input  name="mvpath" value="<%if(movie.getMvpath()!=null){out.print(movie.getMvpath());}else{out.print("");}%>"></td>
</tr>
<tr id="EditReport_12">
    <td nowrap><%=r.getString(teasession._nLanguage, "发布时间")%>:</TD>
    <td nowrap><%=new tea.htmlx.TimeSelection("Issue", date_r)%></td>
  </tr>
</table>
  <P ALIGN=CENTER>

    <input type=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Finish")%>" onclick="return isFloat()">
     <input type="submit" name="GoBack" id="edit_GoBack" class="edit_button" VALUE="高级"  >
  </P>
</form>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>

</body>
</html>

