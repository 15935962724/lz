<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="tea.entity.node.*" %>
<%@page import="tea.ui.TeaSession"%>

<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");


TeaSession teasession = new TeaSession(request);

int poll=Integer.parseInt(request.getParameter("Poll"));

PollChoice pollc = PollChoice.find(poll);
Poll pollobj = Poll.find(pollc.getPoll());
String nexturl = teasession.getRequestURI() +"?"+teasession.getQueryString();
%>

<style type="text/css">
body{background:#FFD;margin:0 auto;}
.lzj_biao{display:block;height:50px;font-size:18px;text-align:center;font-weight:bold;line-height:50px;}
.lzj_xiaobiao{display:block;height:50px;font-size:14px;text-align:center;font-weight:bold;line-height:50px;color:#888888;width:944px;}
.lzj_rq{display:block;height:25px;line-height:25px;text-align:center;width:944px;}
.lzj_ri{margin-right:20px;font-size:14px;}
.lzj_sy{color:#ff0000;font-size:14px;}
.lzj_img{display:block;text-align:center;width:944px;}
.lzj_hao{display:block;text-align:center;line-height:55px;height:55px;width:944px;font-size:14px;}
.lzj_jian{display:block;height:25px;line-height:25px;text-align:left;width:944px;}
.lzj_xb{display:block;height:25px;line-height:25px;text-align:left;font-size:12px;font-weight:bold;width:944px;}
.lzj_nr{display:block;line-height:150%;text-align:left;font-size:12px;width:944px;}
.hb_yj{border-top:5px solid #f60;height:73px;*height:78px;text-align:center;padding-top:15px;width:944px;margin:0 auto;font-size:12px;}
.lzj_img img{width:900px;}
</style>
<script>
function f_singlepollButton(igd){
  foVote.textsinglepollButton.value=igd;
  foVote.submit();
}
</script>
<div style="width:100%;text-align:center;">


  <div style="width:944px;margin:0 auto;">
    <span class="lzj_xiaobiao"><%=pollc.getTitle()%></span>

      <span class="lzj_img"><img src="<%=pollc.getBigPicture()%>" alt=""></span>

        <span class="lzj_hao"><span>编号：<%=pollc.getChoice()%>　　　作者：</span><span><%=pollc.getFirstname()%></span></span>
        <a href=""></a>

        <!--span class="lzj_jian"><%=pollc.getMemberinfo()%></span-->


        <span class="lzj_xb">作品简介：</span>
        <span class="lzj_nr"><%=pollc.getPollinfo()%></span>
       <FORM NAME=foVote METHOD=POST ACTION="/servlet/VotePoll" onSubmit="return true&&submitChoice(this.Answer9,'投票')">
<INPUT TYPE="HIDDEN" NAME="Node" VALUE="<%=pollobj.getNode()%>"/><INPUT TYPE="HIDDEN" NAME="Poll" VALUE="<%=pollc.getPoll()%>"/>
<INPUT TYPE="HIDDEN" NAME="pollpos" VALUE="<%=pollobj.getNode()+poll%>"/>
<input type="hidden" name="textsinglepollButton" >
<input type="hidden" name="nexturl" value="<%=nexturl%>">
<Span ID=PollIDpoll1>

<Span ID=PollIDsubmit><INPUT TYPE="SUBMIT" ID="PollIDVote" VALUE="投票" onclick ="f_singlepollButton('<%=poll%>');" ></Span><Span ID=PollIDresultButton>
<!--<INPUT TYPE="BUTTON" VALUE="投票结果" ID="CBLogout" CLASS="CB" onClick="window.open('/servlet/Node?Node=29762&listing=8514&result=ON');"/>-->
<input type="button" value="关闭" onclick="window.close();" />
</Span>

</FORM>
  </div>
        <span></span>

  </div>
