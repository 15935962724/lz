<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.node.Event"%>
<%@page import="tea.entity.node.Node"%>
<%@page import="tea.entity.lvyou.LvyouJobCatagory"%>
<%@page import="tea.entity.lvyou.LvyouModels "%>
<%@page import="tea.entity.admin.AdminRole"%>
<%@page import="tea.entity.admin.AdminUnit"%>
<%@page import="tea.entity.admin.AdminUsrRole"%>
<%@page import="java.net.URLEncoder"%>
<%@ page import="tea.resource.Resource" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.*"%><%@page import="tea.entity.volunteer.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.resource.*" %><%@page import="java.io.*" %>
<%@page import="java.util.*"%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

if(teasession._rv==null)
{
	out.println("您没有登录，请登录后操作");
	return;
}

ProfileBBS pb=ProfileBBS.find(teasession._strCommunity,teasession._rv.toString());

tea.entity.site.Community community=tea.entity.site.Community.find(teasession._strCommunity);
String nexturl =request.getRequestURI()+"?"+request.getQueryString();
String member =teasession._rv.toString();
Profile p = Profile.find(member);


%>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<script src="/tea/city.js"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/ym/ymPrompt.js" type=""></SCRIPT>
<link href="/tea/ym/skin/dmm-green/ymPrompt.css" rel="stylesheet" type="text/css">

<script type="text/javascript">

function f_submit()
{




    if(form2.mobile.value=='')
    {
    	  document.getElementById("mobile_id").innerHTML='手机不能为空';
   	    form2.mobile.focus();
   	    return false;
    }else
    {
    	var str = form2.mobile.value;
        var reg=/^(((13[0-9]{1})|150|151|152|153|154|155|156|157|158|159)+\d{8})$/;
        if(!reg.test(str)){
        	document.getElementById("mobile_id").innerHTML='手机格式不正确';
       	    form2.mobile.focus();
       	    return false;
        }
    }

    document.getElementById("mobile_id").innerHTML='';




	if(form2.city0.value=='')
	{
		document.getElementById("city_id").innerHTML='现工作地省份不能为空';
   	    form2.city0.focus();
   	    return false;
	}
	document.getElementById("city_id").innerHTML='';
	if(form2.city1.value=='')
	{
		document.getElementById("city_id").innerHTML='现工作地市不能为空';
   	    form2.city1.focus();
   	    return false;
	}
	document.getElementById("city_id").innerHTML='';
	if(form2.address.value==''){

		document.getElementById("city_id").innerHTML='现工作地详细地址不能为空';
   	    form2.address.focus();
   	    return false;
	}

	document.getElementById("city_id").innerHTML='';


	form2.submit();




}

function f_xp(igd,igdstrid,igdname,igdpingpai)
{

	 sendx("/jsp/admin/edn_ajax.jsp?act=ewmxp&wm="+igd+"&igdname="+igdname+"&igdpingpai="+igdpingpai,
			 function(data)
			 {
		 		if(data!=''&&data.length>1)
		 			{
		 			data = data.trim();
				 	document.getElementById(igdstrid).innerHTML=data;
		 			}
			 }
			 );
}

function f_x()
{
	f_xp('<%=p.getXpinpai()%>','xxinghaoid','xxinghao','<%=p.getXxinghao()%>');
	f_xp('<%=p.getCpinpai()%>','cxinghaoid','cxinghao','<%=p.getCxinghao()%>');
}



function f_code_c(igd)
{
	var str  = "<span id='codememberid'>会员编号：<span id='code_igd' >"+igd+"</span> </span> <br>";
	str = str + "<span id ='memberid'>请输入您要绑定账号：<input type='text' id='myInput' name='myInput' ></span><span id='member_info'></span> <br>";
	str = str +"<span id='textid'>4-20个字符，一个汉字为两个字符，不能使用纯数字，推荐使用中文会员名。一旦注册成功会员名不能修改。</span> "

	ymPrompt.confirmInfo({icoCls:'',msgCls:'confirm',message:str,title:'绑定账号',width:400,height:200,handler:getInput,autoClose:false});

}
function getInput(tp){
	if(tp!='ok') return ymPrompt.close();
	var v=$('myInput').value;
	if(v=='')
		document.getElementById('member_info').innerHTML='请输入要绑定的用户名';
	else{

		var t=$('member_info');
		  if(v.length==0)
		  {
		    t.innerHTML="4-20个字符，一个汉字为两个字符，不能使用纯数字，推荐使用中文会员名。一旦注册成功会员名不能修改。";

		  }else if(v.length<4)
		  {
		    t.innerHTML="会员名在4-20个字符内。";

		  }else if(/^\d+$/.test(v))
		  {
		    t.innerHTML="会员名不能全为数字。";

		  }else if(/[ ,.:;'"　，。：；\\\/]/.test(v))
		  {
		    t.innerHTML="非法的会员名。";

		  }else
		  {
		    //t.innerHTML='检测中...';
		    sendx("/servlet/Ajax?act=checkmember&member="+encodeURIComponent(v),function(d){
		      if(d=='true')
		      {
		        t.innerHTML='该会员名已被使用。';
		        t.className='err';
		      }else
		      {
		        t.innerHTML='&nbsp;';

		        //可以注册了

		      f_sub(v,$('code_igd').innerHTML);



		      }
		    });
		  }




		//ymPrompt.close();
	}
}

function f_sub(igd,codeid)
{
	  sendx("/jsp/admin/edn_ajax.jsp?act=code_memberadd&member="+encodeURIComponent(igd)+"&membercode="+codeid,function(d){

		 if(d!=null && d.trim()=='true')
		 {
			 ymPrompt.close();
			 ymPrompt.win({message:'<br><center>您的用户已经绑定成功!</center>',width:200,height:100,handler:noTitlebar,btn:[['关闭']],titleBar:false});


		 }else if(d!=null && d.trim()=='false1')
		 {
			 document.getElementById('member_info').innerHTML='您输入的用户名有重复，请重新输入';
		 }else  if(d!=null && d.trim()=='false2')
		{
			 document.getElementById('member_info').innerHTML='您的会员编号已经绑定，不能重复绑定';
		}

	    });

}
function noTitlebar(){
	 ymPrompt.close();
	 window.location.reload();
}

//提示保存成功
function f_alert()
{
	 ymPrompt.win({message:'<br><center>您的用户信息提交成功!</center>',width:200,height:100,handler:noTitlebar,btn:[['关闭']],titleBar:false});
}

mt.receive=function(u)
{
  form2.portrait.value=u;
  $$('_avatar').src=u+'?t='+Math.random();
};


f_x();
</script>



<form name="form2" method="POST" action="/servlet/EditMember" target="_ajax" >

<input type="hidden" name="nexturl" value="<%=nexturl%>">
<input type="hidden" name="act" value="EditMyWestracMmeber">
<input type="hidden" name="member" value="<%=member %>">
<input type="hidden" name="portrait" value="<%=pb.getPortrait(teasession._nLanguage)%>"/>
<div class="title">我的资料</div>
<div class="con">
<div class="left"><img src="<%=pb.getPortrait(teasession._nLanguage)%>" id="_avatar" /><br>
<a href="###" onclick="mt.show('/jsp/custom/westrac/MemberSetAvatar.jsp?community=<%=teasession._strCommunity%>',2,'修改您的头像',450,277)">上传头像</a>
<span class="tix">请尽量使用英文名称的图片上传！</span>
</div>
<div class="right">
<table border="0" cellpadding="0" cellspacing="0">
<tr id="tableonetr">
    <td align="right" nowrap="nowrap">个人基本信息</td>
    <td></td>
  </tr>
 <tr>
      <td align="right"><span id="btid">*</span>&nbsp;会员编号：</td>
      <td>
        <%=Entity.getNULL(p.getCode()) %>
      </td>
    </tr>


    <tr>
      <td align="right"><span id="btid">*</span>&nbsp;用户名：</td>
      <td>
        <%if(p.getCode().equals(member)){

        	out.print("暂无绑定");
        	out.print("&nbsp;&nbsp;");
        	out.print("<span id=\"codeid\"><a href=\"###\" onclick=\"f_code_c('"+p.getCode()+"');\">绑定用户名</a></span>　");
        }else
        	{
        	out.print(member);
        	}%>
      </td>
    </tr>

	<tr>
      <td align="right"><span id="btid">*</span>&nbsp;姓名：</td>
      <td>
     <%=Entity.getNULL(p.getFirstName(teasession._nLanguage)) %>
      </td>
    </tr>
    <tr>
      <td align="right"><span id="btid">*</span>&nbsp;性别：</td>
      <td><%if(p.isSex()){out.println("女");} %><%if(!p.isSex()){out.println("男");} %>
      </td>
    </tr>

     <tr>
      <td align="right"><span id="btid">*</span>&nbsp;身份证号：</td>
      <td><%=p.getCard() %></td>
    </tr>


     <tr>
      <td align="right"><span id="btid">*</span>&nbsp;生日：</td>
      <td><%if(p.getBirth()!=null)out.print(Entity.sdf.format(p.getBirth())); %>
      </td>
    </tr>

    <tr>
      <td align="right">E-mail：</td>
      <td>
       	<input type="text"    class="edit_input" name="email" value="<%=Entity.getNULL(p.getEmail()) %>">
      </td>
    </tr>
    <tr>
      <td align="right"><span id="btid">*</span>&nbsp;手机：</td>
      <td>
       	<input type="text"    class="edit_input" name="mobile" value="<%=p.getMobile() %>">&nbsp;<span id="mobile_id"></span>
      </td>
    </tr>

       <tr>
      <td align="right"><span id="btid">*</span>&nbsp;现工作地：</td>
      <td>
       	<script>mt.city("city0","city1",null,'<%=p.getProvince(teasession._nLanguage) %>');</script>

    详细地址:<input type="text" name="address" value="<%=p.getAddress(teasession._nLanguage) %>" title="详细地址">&nbsp;<span id="city_id"></span>
      </td>
    </tr>

   <tr>
   	<td align="right" >从何得知履友联盟？</td>
   	<td><%=Profile.SOURCE_TYPE[p.getSource()] %>

   		&nbsp;
   		<span id="trainid" <%if(p.getSource()==1){out.println(" style=\"display:''\" ");}else{out.print(" style=\"display:none\"");} %>>
   			哪次培训：<%=Entity.getNULL(p.getTraintime()) %>&nbsp;
   			培训地点：<%=Entity.getNULL(p.getTrainaddress()) %>&nbsp;
   			培训时间：<%=Entity.getNULL(p.getTraintime()) %>
   		</span>
   		<span id="tjmemberid" <%if(p.getSource()==2){out.println(" style=\"display:''\" ");}else{out.print(" style=\"display:none\"");} %>>
   		推荐人会员编号或用户名：<%=Entity.getNULL(p.getTjmember()) %>
 			<span id="tjmember_info"></span>


   		</span>
   		<span id="belsellid" <%if(p.getSource()==3){out.println(" style=\"display:''\" ");}else{out.print(" style=\"display:none\"");} %>>
   			销售员姓名：<%=Entity.getNULL(p.getBelsell()) %>
   		</span>
   	</td>
   </tr>


   <tr>
      <td align="right"></td>
      <td align="right">
        <INPUT TYPE=button ID="submit1" class="submit" VALUE="保存" onClick="f_submit();">
      </td>
    </tr>

  </table>

 <table border="0" cellpadding="0" cellspacing="0" >
   <tr id="tableonetr">
    <td  align="right" nowrap="nowrap">个人资料</td>
    <td></td>
  </tr>

     <tr>
      <td align="right">民族：</td>
      <td>
        <input type="text"  maxlength=16  class="edit_input" name="zzracky" value="<%=Entity.getNULL(p.getZzracky()) %>">
      </td>
    </tr>

	<tr>
      <td align="right" nowrap>固定电话：</td>
      <td>
        <input type="text"    class="edit_input" name="telephone" value="<%=Entity.getNULL(p.getTelephone(teasession._nLanguage)) %>
        ">
      </td>
    </tr>
     <tr>
      <td align="right" nowrap>家庭所在地：</td>
      <td>
       	 	<script>mt.city("zzhkszd0","zzhkszd1",null,"<%=p.getZzhkszd(teasession._nLanguage) %>");</script>

    详细:<input type="text" name="paddress" value="<%=Entity.getNULL(p.getPAddress(teasession._nLanguage)) %>" title="详细地址">
      </td>
    </tr>
     <tr>
      <td align="right">现通讯地址：</td>
      <td>
       	<script>mt.city("state0","state1",null,"<%=p.getState(teasession._nLanguage) %>");</script>

    详细:<input type="text" name="organization" value="<%=Entity.getNULL(p.getOrganization(teasession._nLanguage)) %>" title="详细地址">
      </td>
    </tr>
     <tr>
      <td align="right">邮编：</td>
      <td>
       	<input type="text"    class="edit_input" name="zip" value="<%=Entity.getNULL(p.getZip(teasession._nLanguage)) %>">
      </td>
    </tr>

    <tr>
      <td align="right">QQ：</td>
      <td>
       	<input type="text"    class="edit_input" name="msn" value="<%=Entity.getNULL(p.getMsnID()) %>">
      </td>
    </tr>


      <tr>
      <td  align="right">是否有上岗证：</td>
      <td>
	      <input type="radio" name="sfshanggang" value="0" <%if(p.getSfshanggang()==0){out.println(" checked ");} %>>&nbsp;是
	      <input type="radio" name="sfshanggang" value="1"  <%if(p.getSfshanggang()==1){out.println(" checked ");} %>>&nbsp;否
      </td>

    </tr>

      <tr>
      <td align="right">发证机关：</td>
      <td>
 			<input type="text"    class="edit_input" name="fazhengjiguan" value="<%=Entity.getNULL(p.getFazhengjiguan()) %>">
      </td>
    </tr>
     <tr>
      <td align="right">操作年限：</td>
      <td>
 			<input type="text"    class="edit_input" name="caozuonianxian" value="<%=Entity.getNULL(p.getCaozuonianxian()) %>">
      </td>
    </tr>

     <tr>
      <td align="right">身份类型：</td>
      <td>
      <select name="wsttype">
      <%

      ArrayList catatList =LvyouJobCatagory.find();
      for(int i=0;i<catatList.size();i++)
      {
    	  LvyouJobCatagory cata=(LvyouJobCatagory)catatList.get(i);
        out.print("<option value="+i);
        if(p.getWstType()==i)out.print(" selected");
        out.print(">"+cata.getName());
      }
      /*
      for(int i=0;i<Profile.WST_TYPE.length;i++)
      {
        out.print("<option value="+i);
        if(p.getWstType()==i)out.print(" selected");
        out.print(">"+Profile.WST_TYPE[i]);
      }*/
      %>
      </select>
      </td>
    </tr>
 <tr>
      <td align="right">机种：</td>
      <td>
      <%
      String wstmode=p.getWstModel();
      ArrayList modelist=LvyouModels.find();
      for(int i=1;i<modelist.size();i++)
      {LvyouModels model=(LvyouModels)modelist.get(i);
        out.print("<input type='checkbox' name='wstmodel' value='"+model.getName()+"' id='_wstmodel"+i+"'");
        if(wstmode!=null&&wstmode.indexOf(model.getName())!=-1)out.print(" checked");
        out.print("><label for='_wstmodel"+i+"'>"+model.getName()+"</label>　");
      }
      /*
      for(int i=1;i<Profile.WST_MODEL.length;i++)
      {
        out.print("<input type='checkbox' name='wstmodel' value='"+Profile.WST_MODEL[i]+"' id='_wstmodel"+i+"'");
        if(wstmode!=null&&wstmode.indexOf(Profile.WST_MODEL[i])!=-1)out.print(" checked");
        out.print("><label for='_wstmodel"+i+"'>"+Profile.WST_MODEL[i]+"</label>　");
      }
      */
      %>
      </td>
    </tr>

     <tr>
      <td align="right">现操作机型：</td>
      <td>
 			<select name="xpinpai" onChange="f_xp(this.value,'xxinghaoid','xxinghao','0');">
 				<option value="0">品牌</option>
 				<%
 				java.util.Enumeration e = WomenOptions.find(" AND community="+DbAdapter.cite(teasession._strCommunity)+" and type= 0",0,Integer.MAX_VALUE);
 		        while(e.hasMoreElements())
 		       {
 		            int wid = ((Integer)e.nextElement()).intValue();
 		            WomenOptions obj = WomenOptions.find(wid,teasession._nLanguage);
 		            out.println("<option value="+wid);
 		            if(p.getXpinpai()==wid)
 		            {
 		            	out.println(" selected ");
 		            }
 		            out.println(">"+obj.getWoname());
 		            out.print("</option>");
 		       }
 				%>
 			</select>
 			<span id="xxinghaoid">
	 			<select name="xxinghao">
	 				<option value="0">型号</option>

	 			</select>
 			</span>其他:
 			<input type="text"     name="xqita" value="<%=Entity.getNULL(p.getXqita()) %>">
      </td>
    </tr>
     <tr>
      <td align="right">曾操作机型：</td>
      <td>
 			<select name="cpinpai" onChange="f_xp(this.value,'cxinghaoid','cxinghao','0');">
 				<option value="0">品牌</option>
 				<%
	 				java.util.Enumeration e2 = WomenOptions.find(" AND community="+DbAdapter.cite(teasession._strCommunity)+" and type= 0",0,Integer.MAX_VALUE);
	 		        while(e2.hasMoreElements())
	 		       {
	 		            int wid = ((Integer)e2.nextElement()).intValue();
	 		            WomenOptions obj = WomenOptions.find(wid,teasession._nLanguage);
	 		            out.println("<option value="+wid);
	 		           if(p.getCpinpai()==wid)
	 		            {
	 		            	out.println(" selected ");
	 		            }
	 		            out.println(">"+obj.getWoname());
	 		            out.print("</option>");
	 		       }
 				%>
 			</select>
 				<span id="cxinghaoid">
	 			<select name="cxinghao">
	 				<option value="0">型号</option>
	 			</select>
 			</span>其他:
 			<input type="text"     name="cqita"  value="<%=Entity.getNULL(p.getCqita()) %>">
      </td>
    </tr>

     <tr>
      <td align="right">机主相关：</td>
      <td>
 			姓名:<input type="text"    class="edit_input" name="jzname" value="<%=Entity.getNULL(p.getJzname()) %>">
 			型号:<input type="text"    class="edit_input" name="jzxinghao" value="<%=Entity.getNULL(p.getJzxinghao()) %>">
      </td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>
 			序列号:<input type="text"    class="edit_input" name="jzxuliehao" value="<%=Entity.getNULL(p.getJzxuliehao()) %>">
      </td>
    </tr>
     <tr>
      <td>&nbsp;</td>
      <td>
 			联系方式:<input type="text"    class="edit_input" name="jzlianxi" value="<%=Entity.getNULL(p.getJzlianxi()) %>">
      </td>
    </tr>
     <tr>
     <td align="right">爱好：</td>
      <td>
 			<textarea rows="3" cols="60" name="aihao"><%=Entity.getNULL(p.getAihao()) %></textarea>
      </td>
    </tr>
    <tr>
    <td align="right"></td>
    <td align="right"><INPUT TYPE=button ID="submit1" class="submit" VALUE="保存" onClick="f_submit();"></td>
    </tr>
  </table>
</div>
</div>
</form>



