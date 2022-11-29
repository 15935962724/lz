<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"%>
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="tea.entity.admin.sales.*" %>
<%@ page import="java.util.*" %>
<%
request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
String community=teasession._strCommunity;
int taid =0,flowitem=0;
int maplen=0;
if(teasession.getParameter("taid")!=null && teasession.getParameter("taid").length()>0)
	taid = Integer.parseInt(teasession.getParameter("taid"));
Task taobj = Task.find(taid);
String assigner=null,motif=null,remark=null,assignerid=null;
String attime =null;
int fettle =1,pri=2;
if(taid>0)
{
	assigner = taobj.getAssigner();
	motif = taobj.getMotif();
	attime = taobj.getAttimeToString();
	fettle = taobj.getFettle();
	pri = taobj.getPri();
	remark = taobj.getRemark();
	assignerid = taobj.getAssignerid();
	flowitem = taobj.getFlowitem();
	//tea.entity.member.Profile probj = tea.entity.member.Profile();
	//

 if(taobj.getAcceefile()!=null)
 {
 	maplen=(int)new java.io.File(application.getRealPath(taobj.getAcceefile())).length();
 }
}
if(teasession.getParameter("delete")!=null)
{
	taobj.delete();
	response.sendRedirect("/jsp/admin/sales/clienttask.jsp");
	return;
}
%>

<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>


<script>

function LoadWindow()
{
	loc_x=document.body.scrollLeft+event.clientX-event.offsetX-100;
        loc_y=document.body.scrollTop+event.clientY-event.offsetY+140;
	var sFeatures = "edge:raised;scroll:0;status:0;help:0;resizable:1;scroll:yes;dialogWidth:320px;dialogHeight:245px;dialogTop:"+loc_y+"px;dialogLeft:"+loc_x+"px";
	var url = "/jsp/admin/sales/assigner.jsp";
	var aio ="";
	var arr =window.showModalDialog(url,aio,sFeatures);
	if(arr!=null)
        {
		var arr1 = arr.split(",");
			document.all.assignerid.value=arr1[0];
			document.all.assigner.value = arr1[1];
	}
}
function sub()
{
  return submitText(form1.flowitem,'请选择客户或项目')
    &&submitText(form1.motif,'请填写任务的主题')
    &&submitText(form1.attime,'请选择到期时间');
}
</script>
<body>
<h1>我的任务编辑</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
<form name=form1 METHOD=post  action="/servlet/EditTask"  enctype="multipart/form-data"  onsubmit="return sub(this);">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<input type="hidden" name="taid" value="<%=taid %>">
<input type=hidden name="act" value="clien">

  <tr>
    <td nowrap>客户或项目<!--  客户或项目--></td>
    <td>
      <select name="flowitem" >
        <option value="">---------</option>
      <%
       // StringBuffer  = new StringBuffer();

        String member = teasession._rv.toString();//登录的用户ID
       // java.util.Enumeration lme =  Worklinkman.find(teasession._strCommunity,"",0,20);
       // while(lme.hasMoreElements())
      //  {
            // String lmember = ((String)lme.nextElement());
             Worklinkman lobj = Worklinkman.find(teasession._strCommunity,member);
           //  System.out.print(lmember+"----"+member);
           //  if(lmember.indexOf(member)!=-1)//判断联系人表中是否有登录的用户名字
             //{
               //Workproject wobj = Workproject.find(lobj.getWorkproject());//客户的信息

               java.util.Enumeration fme =  Flowitem.find(teasession._strCommunity,"  and workproject="+lobj.getWorkproject() ,0,20);
               while(fme.hasMoreElements())
               {

                 int fid = ((Integer)fme.nextElement()).intValue();
                 Flowitem fobj = Flowitem.find(fid);
                     out.print("<option value="+fid);
		             if(flowitem==fid)
		             out.print(" SELECTED ");
                     out.print(">"+fobj.getName(teasession._nLanguage));
                     out.print("</option>");
              }
            // }else{System.out.print("不相同 ");}
       // }

      %>
      </select>
      <input type="button" value="..." onClick="window.open('/jsp/admin/workreport/Workprojects_2.jsp?community=<%=teasession._strCommunity%>&fieldname=form1.workproject','','height=500,width=500,left=200,top=100,scrollbars=yes,toolbar=no,status=no,menubar=no,location=no,resizable=yes');"/>

    </td>
  </tr>
 <tr><td nowrap>任务主题:</td><td nowrap><textarea cols=35 rows=4 name="motif"><%if(motif!=null)out.print(motif); %></textarea></td></tr>
 <tr><td nowrap>到期日期:</td><td nowrap>
<input name="attime" size="16"  value="<%if(attime!=null)out.print(attime); %>" readonly><A href="###"><img onclick="showCalendar('form1.attime');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
</td></tr>
	 <tr><td nowrap>状态:</td><td nowrap><select name="fettle">
		<%
			for(int i =1;i<Task.FETTLE.length;i++)
			{
				out.print("<option value="+i);
				if(fettle==i)
					out.print(" selected");
				out.print(">"+Task.FETTLE[i]);
				out.print("</option>");
			}
		 %>
		 </select>
	</td></tr>
	  <tr><td nowrap>优先级:</td><td nowrap>
			<select name ="pri">
				<%
					for(int ii =1;ii<Task.PRI.length;ii++)
					{
						out.print("<option value="+ii);
						if(pri==ii)
							out.print(" selected");
						out.print(">"+Task.PRI[ii]);
						out.print("</option>");
					}
				 %>
			</select>
</td></tr>

<tr>
<td>上传附件</td>
<td nowrap>
	     <input NAME="acceefile" TYPE=FILE class="edit_input" onclick="" size="40">
	     <%
	   if(maplen>0){
	 %>
	        <input  id="CHECKBOX" type="CHECKBOX" name="clear1" onClick="form1.big_pic.disabled=this.checked;"/> 清空
	 <%} %>
</td></tr>

	   <tr><td nowrap>说明:</td><td nowrap><textarea cols=37 rows=3 name="remark" wrap="yes" ><%if(remark!=null)out.print(remark); %></textarea></td></tr>

</table>
<input type="submit" value="提交"> &nbsp;&nbsp;<input type="button" value="返回"  onclick="history.back();" >
</FORM>

</body>
</html>



