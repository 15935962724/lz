<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.node.*" %><%@include file="/jsp/Header.jsp"%>
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

Car car = Car.find(teasession._nNode);

String subject="";
if(node.getType()>1)
{
  subject=node.getSubject(teasession._nLanguage);
}
String picture=car.getCarpic();

String carpic=""; //汽车图片
int carstatic=0; //车况（新/旧）
int carclass=0; //汽车品牌（国内/进口）
int carbrand=0; //汽车品牌
int cartype=0; //车型
BigDecimal carprice= new BigDecimal("0"); //汽车价格
String carmiles=""; //首保里程
String caroil=""; //油耗
String caremission=""; //排放指标
String carshape=""; //外型 尺寸(cm)
String wheelbase=""; //轴距(cm)
String maxoutput=""; //最大功率(KW)
String outcapacity=""; //排量(毫升)
String engine=""; //发动机型式
String acrotorque=""; //最大扭矩(N.m)
String speedchanger=""; //变速器型式
String drive=""; //驱动形式
String volume=""; //后备箱体积(升)
String production=""; //生产状态

if(subject!=null && subject.length()>0)
{
  carstatic=car.getCarstatic();
  carclass=car.getCarclass();
  carbrand=car.getCarbrand();
  cartype=car.getCartype();
  carmiles=car.getCarmiles(); //首保里程
  caroil=car.getCaroil(); //油耗
  caremission=car.getCaremission(); //排放指标
  carshape=car.getCarshape(); //外型 尺寸(cm)
  wheelbase=car.getWheelbase(); //轴距(cm)
  maxoutput=car.getMaxoutput(); //最大功率(KW)
  outcapacity=car.getOutcapacity(); //排量(毫升)
  engine=car.getEngine(); //发动机型式
  acrotorque=car.getAcrotorque(); //最大扭矩(N.m)
  speedchanger=car.getSpeedchanger(); //变速器型式
  drive=car.getDrive(); //驱动形式
  volume=car.getVolume(); //后备箱体积(升)
  production=car.getProduction(); //生产状态

}
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
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/type/car/carbrand.js" type="text/javascript"></SCRIPT>
<script type="">
function usecar(Id)////图片用途 点击
{
  var j=1;
  var op= document.form1.carbrand.options;
  while(op.length>1)
  {
    op[1]=null;
  }

  for (i=0;i < aC.length; i++)
  {

    if(aC[i][0]==Id)//类型
    document.form1.carbrand.options[j++] = new Option(aC[i][1],aC[i][2]);
  }
}

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
<h1><%=r.getString(teasession._nLanguage, "EditCar")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

  <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>

  <FORM name=form1 METHOD=POST action="/servlet/EditCar" enctype="multipart/form-data">
  <%
  String parameter=teasession.getParameter("nexturl");
  boolean parambool=(parameter!=null&&!parameter.equals("null"));
  if(parambool)
  out.print("<input type='hidden' name=nexturl value="+parameter+">");
  %>
  <input type='hidden' name=node VALUE="<%=teasession._nNode%>">
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr><TD>*<%=r.getString(teasession._nLanguage, "CarName")%>: </TD>
      <td><input type="TEXT" class="edit_input"  name=_nName SIZE=40 VALUE="<%=subject%>" MAXLENGTH=40></td>
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
  <TD>*<%=r.getString(teasession._nLanguage, "carstatic")%>: </TD>
  <td><select name="carstatic"><%
  for(int i=0;i<Car.CARSTATE.length;i++)
  {
    out.print("<option value="+i);
    if(carstatic==i)
    {
      out.print(" selected ");
    }
    out.print(">"+Car.CARSTATE[i]+"</option>");
  }
  %></select></td>
  </tr>

  <tr>
    <TD>*<%=r.getString(teasession._nLanguage, "carclass")%>: </TD>
    <td><select name="carclass" onClick="usecar(this.value)"><%
    for(int i=0;i<Car.CARCLASS.length;i++)
    {
      out.print("<option value=");
      if(i==0)
      {
        out.print("0");
      }else if(i==1)
      {
        out.print("1");
      }
      if(carclass==i)
      {
        out.print(" selected ");
      }
      out.print(">"+Car.CARCLASS[i]+"</option>");
    }
    %></select></td>
    </tr>

    <tr>
      <TD>*<%=r.getString(teasession._nLanguage, "carbrand")%>: </TD>
      <td><select name="carbrand"><option value="<%=carbrand%>">
        <%
        if(subject!=null && subject.length()>0)
        {
          if(carclass == 0)
          {
            out.print(Car.CARBRANDG[carbrand]);
          } else
          {
            out.print(Car.CARBRANDJ[carbrand]);
          }
        }
        else
        {
          out.print("-----------");
        }


        %></option></select></td>
    </tr>
    <tr>
      <TD>*<%=r.getString(teasession._nLanguage, "cartype")%>: </TD>
      <td><select name="cartype"><%
      for(int i=0;i<Car.CARTYPE.length;i++)
      {
        out.print("<option value="+i);
        if(cartype==i)
        {
          out.print(" selected ");
        }
        out.print(">"+Car.CARTYPE[i]+"</option>");
      }
      %></select></td>
      </tr>

      <tr>
        <TD>*<%=r.getString(teasession._nLanguage, "carmiles")%>: </TD>
        <td><input type="TEXT" class="edit_input"  name=carmiles SIZE=40 VALUE="<%=carmiles%>" MAXLENGTH=40></td>
      </tr>
      <tr>
        <TD>*<%=r.getString(teasession._nLanguage, "caroil")%>: </TD>
        <td><input type="TEXT" class="edit_input"  name=caroil SIZE=40 VALUE="<%=caroil%>" MAXLENGTH=40></td>
      </tr>
      <tr>
        <TD>*<%=r.getString(teasession._nLanguage, "caremission")%>: </TD>
        <td><input type="TEXT" class="edit_input"  name=caremission SIZE=40 VALUE="<%=caremission%>" MAXLENGTH=40></td>
      </tr>
      <tr>
        <TD>*<%=r.getString(teasession._nLanguage, "carshape")%>: </TD>
        <td><input type="TEXT" class="edit_input"  name=carshape SIZE=40 VALUE="<%=carshape%>" MAXLENGTH=40></td>
      </tr>
      <tr>
        <TD>*<%=r.getString(teasession._nLanguage, "wheelbase")%>: </TD>
        <td><input type="TEXT" class="edit_input"  name=wheelbase SIZE=40 VALUE="<%=wheelbase%>" MAXLENGTH=40></td>
      </tr>
      <tr>
        <TD>*<%=r.getString(teasession._nLanguage, "maxoutput")%>: </TD>
        <td><input type="TEXT" class="edit_input"  name=maxoutput SIZE=40 VALUE="<%=maxoutput%>" MAXLENGTH=40></td>
      </tr>
      <tr>
        <TD>*<%=r.getString(teasession._nLanguage, "outcapacity")%>: </TD>
        <td><input type="TEXT" class="edit_input"  name=outcapacity SIZE=40 VALUE="<%=outcapacity%>" MAXLENGTH=40></td>
      </tr>      <tr>
        <TD>*<%=r.getString(teasession._nLanguage, "engine")%>: </TD>
        <td><input type="TEXT" class="edit_input"  name=engine SIZE=40 VALUE="<%=engine%>" MAXLENGTH=40></td>
      </tr>      <tr>
        <TD>*<%=r.getString(teasession._nLanguage, "acrotorque")%>: </TD>
        <td><input type="TEXT" class="edit_input"  name=acrotorque SIZE=40 VALUE="<%=acrotorque%>" MAXLENGTH=40></td>
      </tr>      <tr>
        <TD>*<%=r.getString(teasession._nLanguage, "speedchanger")%>: </TD>
        <td><input type="TEXT" class="edit_input"  name=speedchanger SIZE=40 VALUE="<%=speedchanger%>" MAXLENGTH=40></td>
      </tr>      <tr>
        <TD>*<%=r.getString(teasession._nLanguage, "drive")%>: </TD>
        <td><input type="TEXT" class="edit_input"  name=drive SIZE=40 VALUE="<%=drive%>" MAXLENGTH=40></td>
      </tr>      <tr>
        <TD>*<%=r.getString(teasession._nLanguage, "volume")%>: </TD>
        <td><input type="TEXT" class="edit_input"  name=volume SIZE=40 VALUE="<%=volume%>" MAXLENGTH=40></td>
      </tr>
      <tr>
        <TD>*<%=r.getString(teasession._nLanguage, "production")%>: </TD>
        <td><textarea name="production" cols="48" rows="3"><%=production%></textarea></td>
      </tr>
      <tr><TD><%=r.getString(teasession._nLanguage, "content")%>: </TD>
        <td><textarea cols="48" rows="3" name="content"><%if(node.getText(teasession._nLanguage)!=null){out.print(node.getText(teasession._nLanguage));}else{out.print("");}%></textarea></td>
      </tr>

      <tr><TD><%=r.getString(teasession._nLanguage, "carprice")%>: </TD>
        <td><input type="TEXT" class="edit_input"  name=carprice SIZE=10 VALUE="<%if(car.getCarprice()!=null){out.print(car.getCarprice());}else{out.print("");}%>" MAXLENGTH=40 mask="float"></td>
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

