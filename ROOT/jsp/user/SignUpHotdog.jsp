<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import = "tea.entity.site.Community" %>
<%@ page import = "tea.entity.node.Node" %>
<%@ page import="tea.htmlx.Languages"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import = "tea.resource.Resource" %>
<%
Resource r = new Resource("/tea/ui/util/SignUp");
String node="1";
 String s = request.getParameter("Node");
 if (s!=null)
 node=s;
        TeaSession teasession = new TeaSession(request);
        Community community = Community.find(Node.find(teasession._nNode).getCommunity());
            String ss = community.getTerm(teasession._nLanguage);

%>
<html>
<style type="text/css">
<!--
body{
	background:#2041F0;
	margin-top: 0px;
	margin-bottom: 0px;
}
bodytable{background:#2041F0;}
td,p{ font-size:9pt;}
.9p{ color:#aaa;line-height:15pt;}
.bai{color:#ffffff;line-height:15pt;}
.lan{color:#2041F0;line-height:15pt;}
.hong{ color:#ff0000;line-height:15pt;}
.12hong{color:#ff0000;line-height:15pt;font-size:12pt;}
.unnamed1 {
	background-repeat: repeat-x;
	background-position: bottom;
}
-->
</style>


<form name="form1" method="post" action="/jsp/user/RegisterHotdog.jsp?node=<%=node%>">
<table width="751"  border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
  <tr>
    <td><img src="image/title.jpg" width="751" height="103"></td>
  </tr>
  <tr> <td align="center"><table width="693"  border="0" cellspacing="0" cellpadding="0">
      
<input type='hidden' name=NextUrl VALUE="/servlet/Node?node=<%=node%>">
	  <tr>
        <td colspan="3"><img src="image/title11.jpg" width="693" height="54"></td>
        </tr>
      <tr>
        <td width="3" rowspan="2" background="image/zhuce13.jpg"></td>
        <td width="687" align="center" background="image/zhuce12.jpg" style="background-repeat: repeat-x;background-position: bottom;"><table width="90%"  border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td class="9p" style="padding-left:30px"><span class="hong"><i>好多彩票俱乐部会员</i></span><span class="12hong"><i>注册条款</i></span><i>(开通试用期)</i></td>
          </tr>
          <tr>
            <td  style="padding-left:30px">
              <textarea name="textarea" style="width:540px;height:260px;">1.凡注册成为好多网《好多足彩》的会员，均被视为已经阅读并同意本《会员注册条款》各项内容。《好多足彩》拥有本条款的最终解释权。

2.《好多足彩》向会员提供全面详实的足彩资讯和专家临赛推介服务，不支持赌博，不接受投注。凡参与赌博者均与本网站无关。

3.《好多足彩》特约嘉宾每月推介20场以上比赛，推介信息在网上会员专区公布，会员凭密码进入阅读。

4.会员必须：
(1)自行配备上网所需所有设备；
(2)自行负担个人上网应支付的所有费用；
(3)提供详尽、准确的的个人资料；
(4)在使用本网站提供的服务时不违背国家有关法律法规。

			  </textarea>
</td>
          </tr>
          <tr>
            <td height="25" align="right"><span class="hong">注意:</span>您只有在完全同意上面的服务的条款情况下,才能注册成为新会员。</td>
          </tr>
        </table></td>
        <td width="3" rowspan="2" background="image/zhuce13.jpg"></td>
      </tr><tr>
        <td background="image/zhuce12.jpg" style="background-repeat: repeat-x;background-position: bottom;"><img src="image/zhuce14.jpg" width="127" height="3"></td>
        </tr>
      <tr align="right" >
        <td height="81"  background="image/zhucehu.jpg" colspan="3" style="background-repeat: no-repeat;background-position: right;padding-right:35px;">
		  <input name="Submit" type="image" value="Submit" src="image/jieshou.jpg" width="90" height="21">
          <input name="Submit" type="image" value="Submit" src="image/jujue.jpg" width="89" height="21" onClick="javascript:location.href='/servlet/Node?node=<%=node%>';return(false);">
          &nbsp;
          <p>&nbsp;</p></td>
        </tr>
    </table>    <br/></td>
  </tr>
  <tr>
    <td align="right" bgcolor="#2041F0"><i class="bai">好多资讯 更多精彩 尽在www.hotdog.cn</i></td>
  </tr>
  <tr>
    <td><img src="image/boot.jpg" width="751" height="35"></td>
  </tr>
</table>
</form>

</html>

