<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.node.*" %>
<%@include file="/jsp/Header.jsp"%><%@page import="tea.entity.netdisk.*"%><%@page import="tea.entity.site.*"%>
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

House house = House.find(teasession._nNode);
int filecenter=0;
String subject="";
if(node.getType()>1)
{
  subject=node.getSubject(teasession._nLanguage);
}
String picture=house.getHuxingpic();

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
//function f_click(obj)
//{
  //  var view=document.getElementById("view");
  //  view.src=obj.value;
  //
  //  document.getElementById("view").style.display="";
  //}
  function   isFloat(){

    var   f2   =   foEdit._nName.value;//------------a   为某组件的name，这里是个文本框
    if   (foEdit._nName.value=="" || f2==null)
    {
      alert("房产名称不能为空！");
      return   false;
    }
    var   f   =   document.all.price.value;//------------a   为某组件的name，这里是个文本框
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

  var arr=new Array();
  function f_click(obj)
  {
    if(!obj)obj=this;
    var table=document.all("tb");
    var tr = document.createElement("tr");
    tr.id="tr"+arr.length;
    //
    var td = document.createElement("td");
    var path=obj.value;
    var name=path.substring(path.lastIndexOf("\\")+1);
    var ex=name.substring(name.lastIndexOf(".")+1);
    td.innerHTML="<img src=/tea/image/netdisk/"+ex+".gif width='16' height='16' onerror=onerror=null;src='/tea/image/netdisk/defaut.gif'>"+name;
    tr.appendChild(td);
    //
    td = document.createElement("td");
    td.innerHTML="<a href=javascript:f_del("+arr.length+");>移除</a>";
    tr.appendChild(td);
    table.appendChild(tr);
    //
    arr.push(obj);
    var oInput=document.createElement("INPUT");
    oInput.type="file";
    oInput.name="file";
    oInput.style.width=10;
    oInput.style.position="absolute";
    oInput.style.cursor="hand";
    oInput.style.filter="Alpha(opacity=0)";
    oInput.onchange=f_click;
    var tdadd=document.getElementById("tdadd");
    tdadd.appendChild(oInput);
  }
  function f_del(id,path)
  {
    if(confirm("确认删除?"))
    {
      var tr=document.getElementById("tr"+id);
      tr.style.display="none";
      if(arr[id])
      {
        arr[id].disabled=true;
      }else
      {
        foEdit.old.value=foEdit.old.value.replace(path,"");
      }
    }
  }
  </script>

</head>

<body>

<h1><%=r.getString(teasession._nLanguage, "EditDish")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

  <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>

  <FORM name=foEdit METHOD=POST action="/servlet/EditHouse" enctype="multipart/form-data">
  <%
  String parameter=teasession.getParameter("nexturl");
  boolean parambool=(parameter!=null&&!parameter.equals("null"));
  if(parambool)
  out.print("<input type='hidden' name=nexturl value="+parameter+">");
  %>
  <input type='hidden' name=node VALUE="<%=teasession._nNode%>">
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr><TD>*<%=r.getString(teasession._nLanguage, "HouseName")%>: </TD>
      <td><input type="TEXT" class="edit_input"  name=_nName SIZE=40 VALUE="<%=subject%>" MAXLENGTH=40></td>
</tr>
<!---->
<tr>
  <TD>*<%=r.getString(teasession._nLanguage, "huxing")%>: </TD>
  <td><input type="TEXT" class="edit_input"  name=huxing SIZE=40 VALUE="<%if(house.getHuxing()!=null){out.print(house.getHuxing());}%>" MAXLENGTH=40></td>
</tr>
<tr>
  <TD>*<%=r.getString(teasession._nLanguage, "housesizes")%>: </TD>
  <td><input type="TEXT" class="edit_input"  name=sizes SIZE=40 VALUE="<%if(house.getSizes()!=null){out.print(house.getSizes());}%>" MAXLENGTH=40></td>
</tr>
<tr>
  <TD>*<%=r.getString(teasession._nLanguage, "parcel")%>: </TD>
  <td><input type="TEXT" class="edit_input"  name=parcel SIZE=40 VALUE="<%if(house.getParcel()!=null){out.print(house.getParcel());}%>" MAXLENGTH=40></td>
</tr>
<tr>
  <TD>*<%=r.getString(teasession._nLanguage, "zhuangxiu")%>: </TD>
  <td><input type="TEXT" class="edit_input"  name=zhuangxiu SIZE=40 VALUE="<%if(house.getZhuangxiu()!=null){out.print(house.getZhuangxiu());}%>" MAXLENGTH=40></td>
</tr>
<tr>
  <TD>*<%=r.getString(teasession._nLanguage, "toward")%>: </TD>
  <td><input type="TEXT" class="edit_input"  name=toward SIZE=40 VALUE="<%if(house.getToward()!=null){out.print(house.getToward());}%>" MAXLENGTH=40></td>
</tr>
<tr>
  <TD>*<%=r.getString(teasession._nLanguage, "floor")%>: </TD>
  <td><input type="TEXT" class="edit_input"  name=floor SIZE=40 VALUE="<%if(house.getFloor()!=null){out.print(house.getFloor());}%>" MAXLENGTH=40></td>
</tr>
<tr>
  <TD>*<%=r.getString(teasession._nLanguage, "address")%>: </TD>
  <td><input type="TEXT" class="edit_input"  name=address SIZE=40 VALUE="<%if(house.getAddress()!=null){out.print(house.getAddress());}%>" MAXLENGTH=40></td>
</tr>
<tr><TD><%=r.getString(teasession._nLanguage, "houseprice")%>: </TD>
  <td><input type="TEXT" class="edit_input"  name=price SIZE=10 VALUE="<%if(house.getPrice()!=null){out.print(house.getPrice());}else{out.print("");}%>" MAXLENGTH=40 mask="float"></td>
</tr>
<tr><TD><%=r.getString(teasession._nLanguage, "average")%>: </TD>
  <td><input type="TEXT" class="edit_input"  name=average SIZE=10 VALUE="<%if(house.getAverage()!=null){out.print(house.getAverage());}else{out.print("");}%>" MAXLENGTH=40 mask="float"></td>
</tr>
 <tr>
    <td><%=r.getString(teasession._nLanguage, "huxingpic")%>:</td>
    <td COLSPAN=6><input type="file" name="picture" size="40">
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

<tbody id="tb">
  <tr>
    <TD>*<%=r.getString(teasession._nLanguage, "impactpic")%>: </TD>
    <td id="tdadd" ><a style="position:absolute;"><img  src="/tea/image/netdisk/deplacer.gif" align="absmiddle"><%=r.getString(teasession._nLanguage, "添加文件")%></a>  <input type="file" name=file style="position:absolute;width:10;cursor:hand;filter:Alpha(opacity=0)" onChange="f_click(this)"/>　</td>
  </tr>
  <tr id=tableonetr><td align="right"><%=r.getString(teasession._nLanguage, "路径")%></td><td><%=r.getString(teasession._nLanguage, "操作")%></td></tr>
  <%
  if(house.getImpactpic()!=null)
  {
    out.println("<input type=hidden name=old value="+house.getImpactpic()+">");
    StringBuffer str = new StringBuffer("");
    String sp[] = house.getImpactpic().split(",");
    if(sp.length != -1)
    {
      for(int i = 1;i < sp.length;i++)
      {
        out.println("<tr id=tra"+i+"><td align=right><img  width=80 src="+sp[i]+" align=absmiddle onerror=onerror=null;src='/tea/image/netdisk/defaut.gif';>"+ sp[i].subSequence(sp[i].lastIndexOf("/")+1,sp[i].length()));
        out.println("<td><a href=javascript:f_del('a"+i+"','"+sp[i]+"');>"+r.getString(teasession._nLanguage, "CBDelete")+"</a>");//r.getString(teasession._nLanguage, "Clear")
      }
    }
  }
  %>
  </tbody>

  <tr>
    <TD>*<%=r.getString(teasession._nLanguage, "facilities")%>: </TD>
    <td><input type="TEXT" class="edit_input"  name=facilities SIZE=40 VALUE="<%if(house.getFacilities()!=null){out.print(house.getFacilities());}else{out.print("");}%>" MAXLENGTH=40></td>
  </tr>
  <tr>
    <TD>*<%=r.getString(teasession._nLanguage, "xiaoqu")%>: </TD>
    <td><input type="TEXT" class="edit_input"  name=xiaoqu SIZE=40 VALUE="<%if(house.getXiaoqu()!=null){out.print(house.getXiaoqu());}else{out.print("");}%>" MAXLENGTH=40></td>
  </tr>


  <tr><TD><%=r.getString(teasession._nLanguage, "content")%>: </TD>
    <td><textarea cols="48" rows="3" name="content"><%if(node.getText(teasession._nLanguage)!=null){out.print(node.getText(teasession._nLanguage));}else{out.print("");}%></textarea></td>
    </tr>


<tr id="EditReport_12">
  <td nowrap><%=r.getString(teasession._nLanguage, "发布时间")%>:</TD>
  <td nowrap><%=new tea.htmlx.TimeSelection("Issue", date_r)%></td>
</tr>

  </table>
  <P ALIGN=CENTER>

    <input type=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Finish")%>" onClick="return isFloat()">
    <input type="submit" name="GoBack" id="edit_GoBack" class="edit_button" VALUE="高级"  >
  </P>
</form>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>

</body>
</html>

