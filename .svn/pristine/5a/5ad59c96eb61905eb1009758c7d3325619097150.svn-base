<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.lvyou.*"%>
<%@page import="tea.resource.*"%>
<%@page import="java.util.*"%>
<%@page import="tea.entity.member.*"%>
<%
     request.setCharacterEncoding("UTF-8");
     TeaSession teasession = new TeaSession(request);
     int  id = 0;
    
 
     StringBuffer param=new StringBuffer("?community="+teasession._strCommunity);
     int pos=0,pageSize=10;
     String name="";
     if(teasession.getParameter("name")!=null && teasession.getParameter("name").length()>0)
     {
         name = teasession.getParameter("name");
         param.append("&name=").append(name);
     }
     String mobile="";
     if(teasession.getParameter("mobile")!=null && teasession.getParameter("mobile").length()>0)
     {
    	 mobile = teasession.getParameter("mobile");
    	 param.append("&mobile=").append(mobile);
     }
     int province=0;
     if(teasession.getParameter("province")!=null && teasession.getParameter("province").length()>0)
     {
    	 province = Integer.parseInt(teasession.getParameter("province"));
    	 param.append("&province=").append(String.valueOf(province));
     }
     int city=0;
     if(teasession.getParameter("city")!=null && teasession.getParameter("city").length()>0)
     {
    	 city = Integer.parseInt(teasession.getParameter("city"));
    	 param.append("&city=").append(String.valueOf(city));
     }
     int catagory=0;
    int sex=-1;
     if(teasession.getParameter("catagory")!=null && teasession.getParameter("catagory").length()>0)
     {
    	 catagory = Integer.parseInt(teasession.getParameter("catagory"));
    	 param.append("&catagory=").append(String.valueOf(catagory));
     }
     int state=-1;
     if(teasession.getParameter("state")!=null && teasession.getParameter("state").length()>0)
     {
    	 state = Integer.parseInt(teasession.getParameter("state"));
    	 param.append("&state=").append(String.valueOf(state));
     }
     String day1="";
     if(teasession.getParameter("day1")!=null && teasession.getParameter("day1").length()>0)
     {
    	 day1 = teasession.getParameter("day1");
    	 param.append("&day1=").append(day1);
     }
     String day2="";
     if(teasession.getParameter("day2")!=null && teasession.getParameter("day2").length()>0)
     {
    	 day2 = teasession.getParameter("day2");
    	 param.append("&day2=").append(day2);
     }
     String tmp=request.getParameter("pos");
     if(tmp!=null)
     {
       pos=Integer.parseInt(tmp);
     }   
     
if("POST".equals(request.getMethod()))
{
   if("delete".equals(teasession.getParameter("act")))
   {
	   if(teasession.getParameter("id")!=null && teasession.getParameter("id").length()>0)
	     {
	    	String sid =teasession.getParameter("id");
	         ProfileLvyou.delete(sid);
	     }
   } 
   if("multidelete".equals(teasession.getParameter("act")))
   { String jids[]= teasession.getParameterValues("jid");
	  for(int j=0;j<jids.length;j++)
	     {
	    	// id = Integer.parseInt(jids[j]);
	         ProfileLvyou.delete(jids[j]);
	     }
   } 
    //response.sendRedirect("/jsp/type/lvyou/Jobs.jsp");
  //  return;
}
ArrayList<LvyouCity> provinces = LvyouCity.find1();
ArrayList<LvyouJobCatagory> cats = LvyouJobCatagory.find();
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<title>用户信息管理</title>
</head>
<script>
  

   function f_delete(igd)
   { if(confirm('您确定要删除该信息吗？'))
	   {
       form1.id.value=igd;
       form1.act.value='delete';
       form1.submit();
	   }
   }
   
   function f_excel()
	{
		if(confirm("您确定要导出数据吗?"))
	    {
			form1.action='/servlet/LvyouExcel';
			form1.act.value='Users';
			form1.submit();
		}
  }
   
   function  multidelete()
   {
     if(submitCheckbox(form1.jid,"请选择用户信息"))
     {
		 if(confirm('删除操作系统会把会员信息清空\n您确定要删除吗？'))
   			{
   			 
   				form1.act.value='multidelete';
   			 
   	    		form1.submit();
   			}
   		  		
     }
   }
   function getcities(id){  //保留两位小数点  
	   var url = "/jsp/type/lvyou/getcities.jsp?id="+id; 
   //alert(url);
	    if (window.XMLHttpRequest){ 
	      req = new XMLHttpRequest(); 
	     }else if (window.ActiveXObject) 
	     { 
	      req = new ActiveXObject("Microsoft.XMLHTTP"); 
	     } 
	     if(req) 
	     { 
	      req.open("GET",url, true); 
	      req.onreadystatechange = complete;
	      req.send(null); 
	     } 
	    }  
	   function complete(){ 
	     if (req.readyState == 4) 
	     { 
	      if (req.status == 200){ 
	   	   var content = req.responseText; 
	  // 	  alert(content);
	   document.getElementById('span_city').innerHTML=content;
	   	  
	      } 
	     } 
	   } 
	   function CheckAll()
	   {
	   	var checkname=document.getElementsByName("checkall");
	   	var fname=document.getElementsByName("jid");
	   	var lname="";
	   	if(checkname[0].checked){
	   	    for(var i=0; i<fname.length; i++){
	   	      fname[i].checked=true;
	   	  }
	   	}else{
	   	   for(var i=0; i<fname.length; i++){
	   	      fname[i].checked=false;
	   	   }
	   	}


	  
	   }
</script>
<body id="bodynone">
 <h1>用户信息管理</h1>
 
  <form action="/jsp/type/lvyou/Apps.jsp" name="form1" method="POST">
    <input type="hidden" name="id" value="<%=id%>">
    <input type="hidden" name="files" value="用户列表"/>
     <input type="hidden" name="act">
    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr>
    <td colspan=4>用户信息管理</td>
   </tr>
    <tr>
    <td>姓名</td><td><input type="text" name="name" value="<%=name %>"></td>
    <td>手机</td><td><input type="text" name="mobile" value="<%=mobile %>"></td>
   </tr>
    <tr>
    <td>状态</td>
    <td><select name="state">
    <option value="-1">------------</option>
    <option value="0" <%if(state==0) out.print(" selected"); %>>未发布</option>
    <option value="1" <%if(state==1) out.print(" selected"); %>>已发布</option>
    </select>
    </td>
    <td>身份种类</td><td>
    <select name="catagory" >
    <option value="0">------------</option>
    <%
    for (int i = 0; i < cats.size(); i++) {
    	LvyouJobCatagory cat = (LvyouJobCatagory) cats.get(i);
    	
		out.print("<option value='"+cat.getId()+"'");
	    if(cat.getId()==catagory) out.print(" selected") ;
		out.print(">"+ cat.getName() + "</option>");
	}
    %>
	</select>
	</td>
   </tr>
    <tr>
    <td>发布时间</td><td>
    <input type="text" name="day1" value="<%=day1 %>" size=10 style="cursor:pointer" readonly="readonly" onclick="new Calendar().show('form1.day1');">
   - <input type="text" name="day2" value="<%=day2 %>" size=10 style="cursor:pointer" readonly="readonly" onclick="new Calendar().show('form1.day2');">
    </td>
    <td>工作地点</td><td>
    <select name="province" onchange="getcities(this.value)" style="width:150px;">
    <option value="0">------------</option>
    <%
    for (int i = 0; i < provinces.size(); i++) {
		LvyouCity prov = (LvyouCity) provinces.get(i);
		out.print("<option value='"+prov.getId()+"'");
		   if(prov.getId()==province) out.print(" selected"); 
		out.print(">"+ prov.getName() + "</option>");
	}
    %>
	</select>-
	<span id="span_city">
	 <select name="city" style="width:150px;">
     <option value="0">------------</option>
     <% 
     ArrayList<LvyouCity> citis = LvyouCity.find2(province);
     for (int i = 0; i < citis.size(); i++) {
 		LvyouCity cit = (LvyouCity) citis.get(i);
 		out.print("<option value='"+cit.getId()+"'>"+ cit.getName() + "</option>");
 	}
     %>
     </select>
	</span>
	</td>
   </tr>
   <tr>
    <td colspan=4><input type="submit" name="name" value="搜索"></td>
   </tr>
   </table>

    
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
   <tr>
    <td colspan=9>列表</td>
   </tr>
     <tr id="tableonetr">
      <td>&nbsp;</td>
      <td><b>姓名</b></td>
      <td><b>性别</b></td> 
      <td><b>工作地点</b></td> 
      <td><b>联系电话</b></td> 
      <td><b>身份种类</b></td>
      <td><b>操作年限</b></td>  
      <td><b>发布时间</b></td> 
      <td><b>操作</b></td> 
    </tr>
    <%
             
        ArrayList<ProfileLvyou> pls =ProfileLvyou.find(name, mobile, province, city, catagory, sex, day1, day2, state, pos, pageSize);
       int count=ProfileLvyou.count(name, mobile, province, city, catagory, sex, day1, day2, state);
       
       for(int i=0;i<pls.size();i++)
       {
    	   ProfileLvyou plv=(ProfileLvyou)pls.get(i);
        	LvyouCity pro=LvyouCity.find(plv.getProvince());
        	LvyouCity cit=LvyouCity.find(plv.getCity());
        	LvyouJobCatagory cat=LvyouJobCatagory.find(plv.getJobcategory());
            Profile profile=Profile.find(plv.getMember());
    %>
     <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
         <td><input type="checkbox" name="jid" value="<%=plv.getMember() %>"></td>
         <td><%=plv.getName()  %></td>
         <td><%=plv.getSex()==1?"男":"女" %></td>
         <td><%=(pro.getName()+"-"+cit.getName()) %></td>
         <td><%=profile.getMobile() %></td>
         <td><%=cat.getName() %></td>
          <td><%=plv.getYears() %></td>
         <td><%=profile.getTimeToString() %></td>
      
        <td> 
        <a href="/jsp/type/lvyou/User.jsp?member=<%=plv.getMember()%>" >详细</a>&nbsp;
        <a href="/jsp/type/lvyou/Findappjobs.jsp?member=<%=plv.getMember()%>">求职记录</a>&nbsp;
        <a href="#"  onClick="f_delete('<%=plv.getMember()%>');">删除</a>
        </td>
     </tr>
     
     <%}%>
<tr><td>&nbsp;</td>
<td colspan="4"><input type='checkbox' id="checkall" name="checkall" onclick='CheckAll()' title="全选 /反选" style="cursor:pointer">全选 /反选
&nbsp;
<input type="button" name="name" value="删除"  onClick="multidelete();">
<input type="button" name="name" value="导出到excel"  onClick="f_excel();">
</td>
<td colspan="4">
 <%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>
      
</td>
</tr>
 </table>
  </form>

</body>
</html>