<%@page import="tea.entity.taoism.Cft"%>
<%@page import="tea.entity.taoism.Situation"%>
<%@page import="tea.entity.taoism.Taoism"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.ui.*"%>
<%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node);
  return;
}
int id=h.getInt("tid",0);
Taoism t=Taoism.find(id);
String avatar=MT.f(t.picture,"/tea/image/avatar.gif");
%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/country3.js" type="text/javascript"></script>
<script src="/tea/jquery.js" type="text/javascript"></script>
</head>
<body>
<h1>添加/编辑——皈依弟子管理</h1>
<script type="text/javascript">
var i=0;
function addtr(a,b){
	if(i<=b)i=b;
	if(i==b&&b==0)i=1;
	$("#addtr"+a).append("<tr id='tr"+i+a+"'><td align='right'><input type='hidden' size='30' name='Cftid' value='0'>证书名称：</td><td><input type='text' size='30' name='Cftname' value=''></td><td align='right'>证书图片：</td><td><input type='file' size='30' name='pic"+i+"' value=''><a class='datt' href='###' onclick=deltr('"+i+a+"')>删除</a></td></tr>");
i++;
}
function deltr(index,id){
	mt.show('您确认要删除吗？',2);
	mt.ok=function(){
		$("#tr"+index).remove();
		if(id!=undefined){
			form1.cids.value=form1.cids.value+""+id+"|";
		}
	}
	
}
function deltr2(index,id){
	mt.show('您确认要删除吗？',2);
	mt.ok=function(){
	$("#tr"+index).remove();
	if(id!=undefined){
		form1.sids.value=form1.sids.value+""+id+"|";
	}
	}
}
var j=0;
function addtr2(a,b){
	if(j<=b)j=b;
	if(j==b&&b==0)j=1;
	$("#addtr"+a).append("<tr id='tr"+j+a+"'><td align='right'><input type='hidden' size='30' name='situationid' value='0'>年检情况：</td><td><input type='text' size='30' name='situations' value=''><a class='datt' href='###' onclick=deltr('"+j+a+"')>删除</a></td></tr>");
j++;
}

</script>
<form name="form1" action="/Taoisms.do" method="post" enctype="multipart/form-data" target="_ajax" onSubmit="return mt.check(this)" >
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>
<input type="hidden" name="id" value="<%=id%>"/>
<input type="hidden" name="cids" value="|">
<input type="hidden" name="sids" value="|">
<table id="tablecenter" cellspacing="0" style="table-layout:fixed">
  <tr>
    <td align="right"  width="150">系统编号:</td>
    <td colspan="2"><input type="text" name="sysId" value="<%=MT.f(t.sysId) %>"/></td>
    <td align="right">姓名：</td>
    <td><input type="text" name="name" value="<%=MT.f(t.name) %>"/></td>
    <td align="right">性别：</td>
    <td><select name="sex">
    <option value="0" <%=t.sex==0?"selected":"" %>>男</option>
    <option value="1" <%=t.sex==0?"":"selected" %>>女</option>
    </select></td>
    <td rowspan="6"><input type="hidden" name="picture"  value="<%if(avatar.equals("/tea/image/avatar.gif"))out.print("");else out.print(avatar);%>" /><img id="_avatar" src="<%=avatar%>" onClick="image_change(this)"/><br/><a href="###" onclick="mt.show('/jsp/custom/westrac/MemberSetAvatar.jsp?community=<%=h.community%>',2,'修改您的头像',450,277)">上传头像</a><br /><span style="color:red;font-size: 13px"></span></td>
  </tr>
  <tr>
    <td align="right">出生年月：</td>
    <td colspan="2"><input type="text" name="birthday" value="<%=MT.f(t.birthday)%>" onClick="mt.date(this)" readonly class="date" /></td>
    <td align="right">年龄：</td>
    <td><input type="text" name="age" value="<%=MT.f(t.age)%>"/></td>
    <td align="right">名族：</td>
    <td><select name="ethnic">
    <%
    for(int i=0;i<Taoism.ETHNIC.length;i++){
    	%>
    	<option value="<%=i%>" <%=t.ethnic==i?"selected":"" %>><%=Taoism.ETHNIC[i] %></option>
    <%
    }
    %>
    </select></td>
  </tr>
  <tr>
    <td align="right">文化程度：</td>
    <td colspan="2"><select name="educ_lv">
    <%
    for(int i=0;i<Taoism.EDUC_LV.length;i++){
    	%>
    	<option value="<%=i%>" <%=t.educ_lv==i?"selected":"" %>><%=Taoism.EDUC_LV[i] %></option>
    <%
    }
    %>
    </select>    </td>
    <td align="right" nowrap>毕业院校：</td>
    <td><input type="text" name="school" value="<%=MT.f(t.school)%>"/></td>
    <td align="right">所学专业：</td>
    <td><input type="text" name="professional" value="<%=MT.f(t.professional)%>"/></td>
  </tr>
  <tr>
    <td align="right">手机：</td>
    <td colspan="2"><input type="text" name="mobile" value="<%=MT.f(t.mobile)%>"/></td>
    <td align="right">E-mail：</td>
    <td><input type="text" name="email" value="<%=MT.f(t.email)%>"/></td>
    <td align="right">QQ号：</td>
    <td><input type="text" name="qq" value="<%=MT.f(t.qq)%>"/></td>
  </tr>
  <tr>
    <td align="right">身份证号：</td>
    <td colspan="2"><input type="text" name="idCard" value="<%=MT.f(t.idCard)%>"/></td>
    <td align="right">微信号：</td>
    <td colspan="3"><input type="text" name="weixinId" value="<%=MT.f(t.weixinId)%>"/></td>
  </tr>
  <tr>
    <td align="right" nowrap>其他联络方式名称：</td>
    <td colspan="2"><input type="text" name="otherway" value="<%=MT.f(t.otherway)%>"/></td>
    <td align="right" nowrap>其他联络方式号码 ：</td>
    <td colspan="3"><input type="text" name="o_mobile" value="<%=MT.f(t.o_mobile)%>"/></td>
  </tr>
  <tr>
    <td align="right">户籍所在地：</td>
    <td colspan="6"><script>mt.country("1","<%=(t.huji_c==null?"1":t.huji_c)%>","<%=t.huji_p%>","<%=t.huji_s%>");</script> <input type="text" name="huji_address" value="<%=MT.f(t.huji_address)%>"/></td>
  </tr>
  <tr>
    <td align="right">居住地址：</td>
    <td colspan="7"><script>mt.country("2","<%=t.live_c==null?"1":t.live_c%>","<%=t.live_p%>","<%=t.live_s%>");</script> <input type="text" name="live_address" value="<%=MT.f(t.live_address)%>"/></td>
  </tr>
  <tr>
    <td align="right">通信地址：</td>
    <td colspan="7"><script>mt.country("3","<%=t.communication_c==null?"1":t.communication_c%>","<%=t.communication_p%>","<%=t.communication_s%>");</script> <input type="text" name="communication_address" value="<%=MT.f(t.communication_address)%>"/></td>
  </tr>
  <tr>
    <td align="right">师父姓名：</td>
    <td colspan="2"><input type="text" name="master_name" value="<%=MT.f(t.master_name)%>"/></td>
    <td align="right">电话：</td>
    <td><input type="text" name="phone" value="<%=MT.f(t.phone)%>"/></td>
    <td align="right" nowrap>皈依证编号：</td>
    <td colspan="2"><input type="text" name="convertId" value="<%=MT.f(t.convertId)%>"/></td>
  </tr>
  <tr>
    <td align="right">从事工作：</td>
    <td colspan="2"><input type="text" name="job" value="<%=MT.f(t.job)%>"/></td>
    <td align="right">工作单位：</td>
    <td><input type="text" name="job_unit" value="<%=MT.f(t.job_unit)%>"/></td>
    <td align="right">皈依时间：</td>
    <td colspan="2"><input type="text" name="convert_time" value="<%=MT.f(t.convert_time)%>" onClick="mt.date(this)"  class="date"/></td>
  </tr>
  <tr>
    <td align="right">特长：</td>
    <td colspan="2"><input type="text" name="specialty" value="<%=MT.f(t.specialty)%>"/></td>
    <td colspan="5"><input type="button" value="添加证书" onclick="addtr('1',<%=Cft.count(" and CftId="+t.id)%>)"></td>
  </tr>
  <!-- <tr>
    <td align="right">证书名称：</td>
    <td><input type="text" size="60" name="Cftname" value=""></td>
    <td align="right">证书图片：</td>
    <td><input type="file" size="60" name="pic" value=""></td>
  </tr> -->
  <tr>
   <td colspan="8" style="padding:0px;height:auto;border:0px">
   <table id="addtr1" cellpadding="0" cellspacing="0" style=";margin:0px;width:100%;border-collapse:collapse; table-layout:fixed;">
   <%
   ArrayList list1=Cft.find(" and CftId="+t.id+" order by id desc",0,Integer.MAX_VALUE);
   if(list1.size()>0){
	   for(int i=0;i<list1.size();i++){
		   Cft c=(Cft)list1.get(i);
	   
   %>
   <tr id='tr<%=i%>1'><td align="right" width="150" style="height:30px;"><input type='hidden' size='60' name='Cftid' value='<%=c.id%>'>证书名称：</td><td style="height:30px;"><input type='text' size='30' name='Cftname' value='<%=c.Cftname%>'></td><td align="right" width="150"  style="height:30px;">证书图片：</td><td style="height:100%;height:30px;"><input type='file' size='30' name='pic<%=i%>' ><a class='datt' href='###' onclick=deltr('<%=i%>1',<%=c.id %>)>删除</a>&nbsp;<%if(MT.f(c.pic).length()>1){out.print("<a href='"+c.pic+"' target='_blank'>查看</a>");}%></td>
   </tr>
   <%}}
   else{
	   %>
	   <tr id='tr01'><td align="right" width="150"><input type='hidden' size='30' name='Cftid' value='0'>证书名称：</td><td><input type='text' size='30' name='Cftname' value=''></td><td align="right">证书图片：</td><td style="height:100%;"><input type='file' size='60' name='pic0' value=''><a class='datt' href='###' onclick=deltr('01')>删除</a></td>
        </tr>
	   <%  
   }
   %>
   </table>
   </td>
  </tr>
  <tr>
    <td align="right" nowrap>教育及工作简历：</td>
    <td colspan="7"><textarea name="job_resume"  cols="150" rows="4"><%=MT.f(t.job_resume)%></textarea></td>
  </tr>
  <tr>
    <td rowspan="2" align="right">宫观意见：</td>
    <td align="right">推荐意见：</td>
    <td colspan="6"><input type="text" name="temples_opinion" value="<%=MT.f(t.temples_opinion)%>"/></td>
  </tr>
  <tr>
    <td align="right" nowrap>推荐人姓名：</td>
    <td><input type="text" name="t_name" value="<%=MT.f(t.t_name)%>"/></td>
    <td align="right">日期：</td>
    <td><input type="text" name="t_time" value="<%=MT.f(t.t_time)%>" onClick="mt.date(this)"  class="date"/></td>
    <td align="right">备注：</td>
    <td colspan="2"><input type="text" name="t_ramark" value="<%=MT.f(t.t_ramark)%>"/></td>
  </tr>
  <tr>
    <td rowspan="2" align="right">道协审核意见：</td>
    <td align="right">审核意见：</td>
    <td colspan="6"><input type="text" name="ass_opinion" value="<%=MT.f(t.ass_opinion)%>"/></td>
  </tr>
  <tr>
    <td align="right">负责人姓名：</td>
    <td><input type="text" name="a_name" value="<%=MT.f(t.a_name)%>"/></td>
    <td align="right">日期：</td>
    <td><input type="text" name="a_time" value="<%=MT.f(t.a_time)%>" onClick="mt.date(this)"  class="date"/></td>
    <td align="right">备注：</td>
    <td colspan="2"><input type="text" name="a_ramark" value="<%=MT.f(t.a_ramark)%>"/></td>
  </tr>
  <tr>
    <td align="right">最近年检情况：</td>
    <td align="right" nowrap>皈依证颁发时间：</td>
    <%
     Situation s=Situation.findbytid(t.id);
    %>
    <input type="hidden" name="sid" value="<%=s.id%>">
    <td><input type="text" name="c_time" value="<%=MT.f(t.c_time) %>" onClick="mt.date(this)"   class="date"/></td>
    <td align="right">年检情况：</td>
    <td><input type="text"  readonly value="<%=MT.f(s.situation) %>"/></td>
    <td colspan="3"><input type="button" value="添加年检情况" onclick="addtr2('2',<%=Situation.count(" and situationId="+t.id)%>)"></td>
  </tr>
  <tr>
   <td colspan="8" style="padding:0px;border:0px;height:auto;">
   <table id="addtr2" cellpadding="0" cellspacing="0" style="margin:0px;width:100%;border-collapse:collapse; table-layout:fixed">
   <%
   ArrayList list=Situation.find(" and situationId="+t.id,0,Integer.MAX_VALUE);
   if(list.size()>0){
	   for(int i=0;i<list.size();i++){
		   Situation st=(Situation)list.get(i);
	   
   %>
   <tr id='tr<%=i%>2'><td align="right" width="150"><input type='hidden' size='30' name='situationid' value='<%=st.id%>'>年检情况：</td><td ><input type='text' size='30' name='situations' value='<%=st.situation%>'><a class='datt' href='###' onclick=deltr2('<%=i%>2',<%=st.id %>)>删除</a></td>
   </tr>
   <%}}
   else{
	   %>
	   <tr id='tr20'><td width="150" align="right"><input type='hidden' size='30' name='situationid' value='0'>年检情况：</td><td ><input type='text' size='30' name='situations' value=''><a class='datt' href='###' onclick=deltr2('20')>删除</a></td>
       </tr>
	   <%  
   }
   %></table>
   </td>
  </tr>
  <tr>
    <td align="right" nowrap>参加学习及培训情况：</td>
    <td colspan="7"><textarea name="situation" cols="150" rows="4" ><%=MT.f(t.situation)%></textarea></td>
  </tr>
  <tr>
    <td align="right">宫观参访及参加宗教活动记录：</td>
    <td colspan="7"><textarea name="g_content" cols="150" rows="4" ><%=MT.f(t.g_content)%></textarea></td>
  </tr>
  <tr>
    <td align="right">慈善捐赠情况：</td>
    <td colspan="7"><textarea name="c_content" cols="150" rows="4" ><%=MT.f(t.c_content)%></textarea></td>
  </tr>
  <tr>
    <td align="right">学术文章投稿情况：</td>
    <td colspan="7"><textarea name="x_content" cols="150" rows="4" ><%=MT.f(t.x_content)%></textarea></td>
  </tr>
  <tr>
    <td align="right">法务流通情况：</td>
    <td colspan="7"><textarea name="f_content" cols="150" rows="4" ><%=MT.f(t.f_content)%></textarea></td>
  </tr>
  <tr>
    <td align="right">咨询及活动意向情况：</td>
    <td colspan="7"><textarea name="z_content" cols="150" rows="4" ><%=MT.f(t.z_content)%></textarea></td>
  </tr>
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onClick="history.back();"/>
</form>

<script>
mt.receive=function(u)
{
  form1.picture.value=u;
  $$('_avatar').src=u+'?t='+Math.random();
};

</script>
</body>
</html>


