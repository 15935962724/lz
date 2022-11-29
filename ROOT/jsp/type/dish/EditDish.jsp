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

Dish dish = Dish.find(teasession._nNode);

String subject="";
if(node.getType()>1)
{
  subject=node.getSubject(teasession._nLanguage);
}
String picture=dish.getPicture();



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
</script>
</head>

<body>
<h1><%=r.getString(teasession._nLanguage, "EditDish")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

  <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>

  <FORM name=foEdit METHOD=POST action="/servlet/EditDish" enctype="multipart/form-data">
<%
String parameter=teasession.getParameter("nexturl");
boolean parambool=(parameter!=null&&!parameter.equals("null"));
if(parambool)
out.print("<input type='hidden' name=nexturl value="+parameter+">");
%>
    <input type='hidden' name=node VALUE="<%=teasession._nNode%>">
    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr><TD>*<%=r.getString(teasession._nLanguage, "DishName")%>: </TD>
        <td><input type="TEXT" class="edit_input"  name=_nName SIZE=40 VALUE="<%=subject%>" MAXLENGTH=40></td>
</tr>

<tr><TD><%=r.getString(teasession._nLanguage, "Primarydata")%>: </TD>
  <td>
  <%
  for(int i=0;i<Dish.PRIMARYDATA.length;i++)
  {
    if(Dish.PRIMARYDATA.length/2==i)
    out.print("<br>");
    out.print("<input type=checkbox name='_nPrimarydata"+i+"' value="+Dish.PRIMARYDATA[i]);
    if(dish.get_nPrimarydata()!=null)
    {

       if(dish.get_nPrimarydata().toString().indexOf(","+Dish.PRIMARYDATA[i]+",")!=-1)
      {
         out.print(" checked='checked'　");
      }
    }
    out.print(" />"+Dish.PRIMARYDATA[i]+"　");
  }
  %></td>
</tr>

<tr><TD><%=r.getString(teasession._nLanguage, "Cuisines")%>: </TD>
  <td>  <%
  for(int i=0;i<Dish.CUISINES.length;i++)
  {
    if(Dish.CUISINES.length/2==i)
    out.print("<br>");
    out.print("<input type=radio name='_nCuisines' VALUE="+Dish.CUISINES[i]);
     if(dish.get_nCuisines()!=null)
    {

       if(dish.get_nCuisines().toString().indexOf(Dish.CUISINES[i])!=-1)
      {
         out.print(" checked='checked'　");
      }
    }
    out.print(" />"+Dish.CUISINES[i]+"　");
  }
  %></td>
</tr>

<tr><TD><%=r.getString(teasession._nLanguage, "Taste")%>: </TD>
  <td><%
  for(int i=0;i<Dish.TASTE.length;i++)
  {
    if(Dish.TASTE.length/2==i)
    out.print("<br>");
    out.print("<input type=radio name='_nTaste' VALUE="+Dish.TASTE[i]);
     if(dish.get_nTaste()!=null)
    {

       if(dish.get_nTaste().toString().indexOf(Dish.TASTE[i])!=-1)
      {
         out.print(" checked='checked'　");
      }
    }
    out.print(" />"+Dish.TASTE[i]+"　");
  }
  %></td>
</tr>

<tr><TD><%=r.getString(teasession._nLanguage, "country")%>: </TD>
  <td><%
  for(int i=0;i<Dish.COUNTRY.length;i++)
  {
    if(Dish.COUNTRY.length/2==i)
    out.print("<br>");
    out.print("<input type=radio name='_ncountry' VALUE="+Dish.COUNTRY[i]);
    if(dish.get_ncountry()!=null)
    {

      if(dish.get_ncountry().toString().indexOf(Dish.COUNTRY[i])!=-1)
      {
        out.print(" checked='checked'　");
      }
    }
    out.print(" />"+Dish.COUNTRY[i]+"　");
  }
  %></td>
</tr>

<tr><TD><%=r.getString(teasession._nLanguage, "Nutrient")%>:</TD>
  <td><textarea cols="48" rows="3" name="_nNutrient"><%if(dish.get_nNutrient()!=null){out.print(dish.get_nNutrient());}else{out.print("");}%></textarea></td>
</tr>

<tr><TD><%=r.getString(teasession._nLanguage, "Efficacity")%>: </TD>
  <td><textarea cols="48" rows="3" name="_nEfficacity"><%if(dish.get_nEfficacity()!=null){out.print(dish.get_nEfficacity());}else{out.print("");}%></textarea></td>
</tr>

<tr><TD><%=r.getString(teasession._nLanguage, "method")%>: </TD>
  <td>
     <%
  for(int i=0;i<Dish.METHOD.length;i++)
  {
    if(Dish.METHOD.length/2==i)
    out.print("<br>");
    out.print("<input type=checkbox name='_nmethod"+i+"' VALUE="+Dish.METHOD[i]);
     if(dish.get_nmethod()!=null)
    {

      if(dish.get_nmethod().toString().indexOf(Dish.METHOD[i])!=-1)
      {
        out.print(" checked='checked'　");
      }
    }
    out.print("  />"+Dish.METHOD[i]+"　");
  }
  %>
   </td>
</tr>
<tr>
  <td><%=r.getString(teasession._nLanguage, "Picture")%>:</td>
  <td COLSPAN=6><input type="file" name="picture" size="40">

    <!--img width="100" id="view" src="<%=picture%>" style="display:<%if(picture!=null){out.print("");}else{out.print("none");}%>" -->
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

<tr>
  <td><%=r.getString(teasession._nLanguage, "Picture")%>:</td>
  <td COLSPAN=6><input type="file" name="picture" size="40">

    <!--img width="100" id="view" src="<%=picture%>" style="display:<%if(picture!=null){out.print("");}else{out.print("none");}%>" -->
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

<tr><TD><%=r.getString(teasession._nLanguage, "mouthfeel")%>: </TD>
  <td><input name="mouthfeel" value="" /><%if(dish.get_mouthfeel()!=null && dish.get_mouthfeel().length()>0 ){out.print(dish.get_mouthfeel());}%></td>
</tr>

<tr><TD><%=r.getString(teasession._nLanguage, "content")%>: </TD>
  <td><textarea cols="48" rows="3" name="content"><%if(node.getText(teasession._nLanguage)!=null){out.print(node.getText(teasession._nLanguage));}else{out.print("");}%></textarea></td>
</tr>

<tr><TD><%=r.getString(teasession._nLanguage, "houseprice")%>: </TD>
  <td><input type="TEXT" class="edit_input"  name=price SIZE=10 VALUE="<%if(dish.getDishprice()!=null){out.print(dish.getDishprice());}else{out.print("");}%>" MAXLENGTH=40 mask="float"></td>
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

