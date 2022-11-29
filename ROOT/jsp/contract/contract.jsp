<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%@page  import="tea.entity.contract.*" %>
<%
request.setCharacterEncoding("UTF-8");
String id=null;
 java.text.DecimalFormat df =new java.text.DecimalFormat("#.00");/*定义float设置格式的对像*/
TeaSession teasession = new TeaSession(request);
//String community =request.getParameter("community") ;
//teasession._strCommunity = community;
//out.print(teasession._strCommunity+teasession._nNode);
Date nowTime=new Date();
SimpleDateFormat sDateFormat=new SimpleDateFormat("yyyy-MM-dd");/*定义时间格式对像*/

String member=teasession._rv.toString();//从session中获取用户名
String todayTime=sDateFormat.format(nowTime);//将当前时间转化成格式为yyyy-mm-dd格式的字符串
int year=Integer.parseInt(todayTime.substring(0,4))+1;//取当前年再加1
String nextyear=String.valueOf(year)+todayTime.substring(4,10);//得到明年的今天
String conid=null;
/*如果session中的conid 不为空则 把它取出来*/
if(teasession.getParameter("conid")!=null&&!teasession.equals("")){
  conid=teasession.getParameter("conid");
}
Contract obj=Contract.find(conid,member);//查找和编号和用户名相同的记录

String e_contract=obj.getE_contract();
int elong=0;
//如果电子合同存在的话就获取它的长度
if(e_contract!=null&&e_contract.length()>0){
 elong =(int)new java.io.File(application.getRealPath(e_contract)).length();
}
String time=null;
String outtime=null;
String e=null;
float money=0;
float prepay=0;
String typeid=null;
String name=null;

  conid=obj.getConid();

  name=obj.getCname();
  if(obj.getTime()!=null && obj.getTime().length()>0)
  {
     time=obj.getTime().substring(0,10);

  }
  typeid=obj. getType();


 if(obj.getOuttime()!=null && obj.getOuttime().length()>0)
  {
     outtime=obj.getOuttime().substring(0,10);
  }
  money=obj.getMoney();
  prepay=obj.getPrepay();
  if(conid==null){//用id 来控制insert 还是 update
    id="insert";
  }else{
  id="no";
  }
  //获取类型个数
  int icount=Iteminfo.count(teasession._strCommunity);

%>
<script type="text/javascript">


function dosubmit()
{

 var conid = document.getElementById("conid").value

 var cname=document.getElementById("cname").value

 var time=document.getElementById("time").value

 var outtime = document.getElementById("outtime").value

 var money=document.getElementById("money").value

 var e=document.getElementById("e_contract").value




  if(conid ==""){
	 alert("合同编号不能为空");
	 form1.conid.focus();
         return false;
	}


        if(cname ==""){
	 alert("合同名不能为空间");
	 form1.cname.focus();
         return false;
	}

		if(time==""){
		alert("合同签定时间")
			form
		}
        if(outtime ==""){
	 alert("合同有效期不能为空");
	 form1.outtime.focus();
         return false;
	}


        if(money==""){
          alert("金额字符不能为空");
          form1.money.focus();
          return false;
        }
        if(/^[0-9]+(\.)?[0-9]*$/g.test(money)){

	}else{
		alert("请输入正确格式的金额数值如 123.5!");
		form1.money.focus();
		return false;
	}



}

</script>
<html>

<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body bgcolor="#ffffff">
<form action="/servlet/ContractServlet" method="POST" name="form1" enctype="multipart/form-data" onSubmit="return dosubmit();">
<%/*判断修改是修改还是新建如果 编号不为空的话则说明是修改否则说明是新建*/ %>
<%if(conid!=null){
  %><h1>修改项目</h1>
<%} else{
%>
<h1>创建项目</h1>
<%} %>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
       <td>
       合同编号：
       </td>
       <td>
       <%/*如果conid不为空的话则显示conid*/ %>
       <input type="text" name="conid" value="<%if(conid!=null)out.print(conid);%>" onchange=""/>
       <input  type="hidden" name="id" value="<%=id%>"/><%/*id 是一个标识*/%>
       <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
       </td>
   </tr>
   <tr>
       <td>
         合同名称：
       </td>
       <td>
        <input type="text" name="cname" value="<%if(name!=null)out.print(name);%>"/>
       </td>
   </tr>
   <tr>
   <td>经销商：</td><td><input type="text" name="j" value="<%=obj.name()%>" readonly="readonly"/></td>
               <input type="hidden" name="member" value="<%=member%>" readonly="readonly"/>
   </tr>
   <tr>
   <td>
      合同签定时间：
   </td>
   <td>
    <input type="text" name="time" value="<%if(time!=null){out.print(time);}else{out.print(todayTime);}%>" readonly="readonly"/><A href="###"><img onclick="showCalendar('form1.time');" src="/tea/image/public/Calendar2.gif" align="top" alt=""/></a>
   </td>
   </tr>
   <tr>
     <td>
       合同有效期至：
     </td>
     <td>
     <input type="text" name="outtime" value="<%if(outtime!=null){out.print(outtime);}else{out.print(nextyear);}%>" readonly="readonly"/><A href="###"><img onclick="showCalendar('form1.outtime');" src="/tea/image/public/Calendar2.gif" align="top" alt=""/></a>
     </td>
   </tr>
   <tr>
    <td>合同金额：</td>
    <td><input type="text" name="money" value="<%if(money!=0)out.print(df.format(money));%>"/></td>

   </tr>
   <tr>
    <td>预付款金额：</td>
    <td><input type="text" name="prepay" value="<%if(prepay!=0)out.print(df.format(prepay));%>"/></td>

   </tr>
   <tr>
    <td>项目类型：</td>
    <td><select name="type">
    <%


   Vector item=(Vector)Iteminfo.find1(teasession._strCommunity,0,Integer.MAX_VALUE);
   // Enumeration item= Iteminfo.find(teasession._strCommunity,0,Integer.MAX_VALUE);
   // while(item.hasMoreElements())
   //{
      Iteminfo iobj=null;
      for(int i=0;i<item.size();i++){
        while(iobj!=null){
          iobj=null;
        }
         iobj=(Iteminfo)item.get(i);
           String itemid = iobj.getItemid();
     // String itemid = (String)item.nextElement();
     //Iteminfo iobj=Iteminfo.find(itemid);
      out.print("<option value="+iobj.getItemid());
      if(itemid.equals(typeid))out.print(" selected");
      out.print(">"+iobj.getItemtype());
      out.print("</option>");
      %>

      <%} %>

</select>

</td>

   </tr>
   <tr>
   <td>合同电子版：</td>
   <td><input type="file" name="e_contract" <%if(e_contract!=null&&e_contract.length()>0)out.print("disabled");%>/><%if(e_contract!=null&&e_contract.length()>0)out.print("<a href="+e_contract+">"+elong+"B</a>");%><input type="checkbox" name="check1" />清除</td>

   </tr>

   <tr>
     <td><input type="submit" value="提交"/></td>
   </tr>
 </table>
</form>
</body>
</html>
