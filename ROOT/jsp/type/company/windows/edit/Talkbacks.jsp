<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.node.*" %>
<%

int count=Talkback.count(node);

%>
  <div id="edit_page2">
    <div id="edit_page2_wai_left">
      <div id="edit_page2_left">

<table>
<%
Enumeration eall=Talkback.find(" ORDER BY talkback DESC",0,20);
while(eall.hasMoreElements())
{
  int tid=((Integer)eall.nextElement()).intValue();
  Talkback tb=Talkback.find(tid);
  String subject=tb.getSubject(lang);
  subject=subject.replaceAll("<","&lt;");
  out.print(" <tr><td><span><a href=javascript:f_open('?url=Talkbacks&node="+tb.getNode()+"')>"+subject+"</a></span></td></tr>");
}
%>
</table>

      </div>
    </div>
    <div id="edit_page2_wai_right">
      <div id="edit_page2_right"><span><%=n.getSubject(lang)+" ( "+count+" )"%></span>
    </div>

    <div id="page2_w_r_e_p_style"></div>

<div id="page2_w_r_e_P_div"></div>


<table cellspacing="0" cellpadding="0" id="page2_w_r_e_P_table3">
<%
Enumeration e34=Talkback.find(node,pos,10);
while(e34.hasMoreElements())
{
  int tid=((Integer)e34.nextElement()).intValue();
  Talkback tb=Talkback.find(tid);
  String subject=tb.getSubject(lang);
  String content=tb.getContent(lang);
  if(subject==null||content==null)continue;
  subject=subject.replaceAll("<","&lt;");
  content=content.replaceAll("<","&lt;");
  out.print("<tr><td id=td01>"+subject+"</td>");
  out.print("<td id=td02>"+tb.getTelephone(lang)+"</td>");
  out.print("<td id=td03>"+tb.getEmail(lang)+"</td>");
  out.print("<td id=td04>"+tb.getTimeToString()+"</td></tr>");
  out.print("<tr><td colspan=4>"+content+"</td></tr>");
  out.print("<tr><td colspan=4 id=del><a href=javascript:f_op('re',"+tid+")>[回复]</a>　<a href=javascript:f_op('delete',"+tid+")>[删除]</a></td></tr>");

  Enumeration er34=TalkbackReply.findByTalkback(tid);
  while(er34.hasMoreElements())
  {
    int trid=((Integer)er34.nextElement()).intValue();
    TalkbackReply tr=TalkbackReply.find(trid);
    out.print("<tr><td id=td01>回复</td>");
    out.print("<td id=td02></td>");
    out.print("<td id=td03></td>");
    out.print("<td id=td04>"+tr.getTimeToString()+"</td></tr>");
    out.print("<tr><td colspan=4 id=td"+trid+">"+tr.getText()+"</td></tr>");
    out.print("<tr><td colspan=4 id=del><a href=javascript:f_op('edit',"+tid+","+trid+")>[编辑]</a>　<a href=javascript:f_op('delete',"+tid+","+trid+")>[删除]</a></td></tr>");
  }
}
%>
</table>

<div id="page2_w_r_e_P_t_page"><%=new tea.htmlx.FPNL(lang,"?community="+como+"&url="+url+"&pos=",pos,count,10)%></div>





</div>
  </div>
  <div id="edit_page2_bottom"></div>

<form name="form34" action="/servlet/EditTalkbackReply" method="post" onsubmit="return submitText(this.reply,'<%=r.getString(teasession._nLanguage, "无效-回复")%>')">
<input type="hidden" name="talkbackreply" value="0">
<input type="hidden" name="talkback" value="0">
<input type="hidden" name="nexturl" value="<%=nu%>">
<input type="hidden" name="act">

<table cellspacing="0" cellpadding="0" id="page2_w_r_e_P_table4" style="display:none;position:absolute;z-index:1;left:300px;top:200px;" onMouseDown="var e=event.srcElement; if(e.id=='bbs'){ this.down=true; this.x=event.offsetX; this.y=event.offsetY; this.setCapture(); }" onMouseUp="if(this.down){ this.releaseCapture(); this.down=false; }" onMouseMove="if(this.down){ var x=event.clientX+document.body.scrollLeft; if(x<0) x=0; var y=event.clientY+document.body.scrollTop; if(y<0)y=0; this.style.left=x-this.x; this.style.top=y-this.y; }">
  <tr><td id="bbs">留言回复 <a href="javascript:f_close()">X</a></td></tr>
  <tr><td id="textarea01"><textarea name="reply" cols="" rows=""></textarea></td></tr>
  <tr><td align="center"><input name="" type="image" value="回复" src="/tea/image/eyp/images/Reply.gif" id="Reply"></td></tr>
</table>
</form>

<script>
var tab=document.all('page2_w_r_e_P_table4');
function f_op(act,id,trid)
{
  form34.act.value=act;
  form34.talkback.value=id;
  var dv='';
  if(trid)
  {
    form34.talkbackreply.value=trid;
    dv=document.getElementById('td'+trid).innerHTML;
  }
  if(act=='delete')
  {
    if(!confirm('确认删除?'))
    return;
    if(!trid)
    {
      form34.action='/servlet/DeleteTalkback';
    }
    form34.submit();
    return;
  }
  form34.reply.value=dv;
  tab.style.display='';
  form34.reply.focus();
}
function f_close()
{
tab.style.display='none';
}
</script>

