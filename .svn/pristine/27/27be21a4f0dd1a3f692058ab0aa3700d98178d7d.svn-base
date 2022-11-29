<%@page import="tea.entity.site.Community"%>
<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page import="java.util.*" %><%@ page  import="tea.resource.Resource" %><%@ page import="tea.entity.bbs.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.entity.*" %><%@ page import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><%


TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)return;

out.print("<SCRIPT LANGUAGE=JAVASCRIPT SRC=\"/tea/ym/ymPrompt.js\" type=\"\"></SCRIPT>");
out.print("<link href=\"/tea/ym/skin/dmm-green/ymPrompt.css\" rel=\"stylesheet\" type=\"text/css\">");

Profile pobj = Profile.find(teasession._rv.toString());


//if(pobj.getMembertype()==0 || pobj.getMembertype()==2 || pobj.getMembertype()==2)
if(pobj.getMembertype()==0)

{
	// 如果是普通用户，则不能显示俱乐部会员信息
	out.print("<span id='mtypeshow' style='display:none'>false</span>");
}else
{
	out.print("<span id='mtypeshow' style='display:none'>true</span>");
}


if(pobj.getMembertype()==1 && pobj.getCode().equals(pobj.getMember()))//如果会员编号和用户名相同，说明没有绑定
{
  //履友类型
  out.print("<span id=\"codeid\"><a href=\"###\" onclick=\"f_code_c('"+pobj.getCode()+"');\">您的会员编号是："+pobj.getCode()+"，请绑定您的用户名</a></span>");

}else
{
  Community c = Community.find(Node.find(teasession._nNode).getCommunity());
  out.print("<span>"+teasession._rv._strR+"</span><span>　欢迎您登录"+c.getName(teasession._nLanguage)+"！</span>");
}
out.print("　<a href='/html/folder/3-1.htm'>[个人中心]</a>　 <a href='###' class='fbtz' onclick=mt.show('/jsp/type/bbs/BBSEditSel.jsp?node="+teasession._nNode+"',1,innerHTML,300,400)>[发表贴子]</a>　<a href='/servlet/Logout?community="+teasession._strCommunity+"&nexturl=/'>[退出]</a>");
%>

<script>


	function f_code_c(igd)
	{
		var str  = "<span id='codememberid'>会员编号：<span id='code_igd' >"+igd+"</span> </span> <br>";
		str = str + "<span id ='memberid'>请输入您要绑定账号：<input type='text' id='myInput' name='myInput' ></span><span id='member_info'></span> <br>";
		str = str +"<span id='textid'>4-20个字符，一个汉字为两个字符，不能使用纯数字，推荐使用中文会员名。一旦注册成功会员名不能修改。例如：“dood2003”</span> "

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




</script>

