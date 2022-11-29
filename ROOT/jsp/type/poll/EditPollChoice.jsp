<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.node.*" %>
<%@ page import="tea.html.*" %>
<%@include file="/jsp/Header.jsp"%>

<%/*
int id=0;
if(request.getParameter("id")!=null)
id=Integer.parseInt(request.getParameter("id"));*/
TeaSession teasession=new TeaSession(request);

int nodes=Integer.parseInt(teasession.getParameter("node"));
int poll=Integer.parseInt(teasession.getParameter("Poll"));
Poll poll_obj=Poll.find(poll);

StringBuffer param = new StringBuffer();
param.append("?id=").append(request.getParameter("id"));
param.append("&community=").append(teasession._strCommunity);
param.append("&node=").append(nodes);
param.append("&Poll=").append(poll);

int pollid=0;
String bigPictures="";
String smallPictures="";
String pollinfos="";
String memberinfos="";
String firstnames="";
String titles="";
String Choices="";
String corrects = "";
String linkmans="";
int  sequence = 0;
if(teasession.getParameter("pollid")!=null && teasession.getParameter("pollid").length()>0)
{
  pollid=Integer.parseInt(teasession.getParameter("pollid"));
  tea.entity.node.PollChoice pc=tea.entity.node.PollChoice.find(pollid);
  bigPictures=pc.getBigPicture();
  corrects = teasession.getParameter("corrects").replaceAll("\"","&quot;");
  smallPictures=pc.getSmallPicture();
  if(pc.getPollinfo()!=null && pc.getPollinfo().length()>0)
  {
    pollinfos=pc.getPollinfo().replaceAll("\"","&quot;");
  }
  if(pc.getMemberinfo()!=null && pc.getMemberinfo().length()>0)
  {
    memberinfos=pc.getMemberinfo().replaceAll("\"","&quot;");
  }
  if(pc.getFirstname()!=null && pc.getFirstname().length()>0)
  {
    firstnames=pc.getFirstname().replaceAll("\"","&quot;");
  }
  if(pc.getTitle()!=null && pc.getTitle().length()>0)
  {
    titles=pc.getTitle().replaceAll("\"","&quot;");
  }
  if(pc.getChoice()!=null && pc.getChoice().length()>0)
  {
    Choices=pc.getChoice().replaceAll("\"","&quot;");
  }
  if(pc.getLinkman()!=null && pc.getLinkman().length()>0)
  {
    linkmans=pc.getLinkman().replaceAll("\"","&quot;");
  }
   sequence = pc.getSequence();

}

if("delete".equals(teasession.getParameter("act")))
{
  int pcid = 0;
  if(teasession.getParameter("pcid")!=null &&teasession.getParameter("pcid").length()>0)
  {
    pcid = Integer.parseInt(teasession.getParameter("pcid"));
  }
    tea.entity.node.PollChoice pc2=tea.entity.node.PollChoice.find(pcid);
    pc2.delete();
    out.print("<script>");
    out.print("alert('删除成功!');");
    out.print("history.go(-1);");
    out.print("</script>");
}
r.add("/tea/ui/node/type/poll/EditPoll");


int pos = 0, pageSize = 10, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}
 count = PollChoice.countByPoll(poll);

%>
<HTML>
  <HEAD>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script>
function f_load()
{
  f_editor();
}
function f_delete(igd)
{
  if(confirm('<%=r.getString(teasession._nLanguage,"ConfirmDelete")%>'))
  {
    form1.action ="/jsp/type/poll/EditPollChoice.jsp?node=<%=teasession._nNode%>&Poll=<%=poll%>&act=delete&pcid="+igd;
    form1.submit();
  }
}
</script>
</HEAD>
<body onLoad="f_load()">
<h1><%=r.getString(teasession._nLanguage, "Choice")%></h1>
<br>
<div id="head6"><img height="6" src="about:blank" alt=""></div>


   <form action="/servlet/EditPoll" method="POST" name="form1" enctype="multipart/form-data" target="_ajax">
   <input type="hidden" name="PollChoice" value="<%=pollid%>">
   <input type="hidden" name="Poll" value="<%=poll%>">
   <input type="hidden" name="Node" value="<%=teasession._nNode%>">
   <input type="hidden" name="act" value="Choice" >
    <input type="hidden" name="pcid" >
   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

     <tr id="tableonetr">
       <td>ID</td>
       <td><%=r.getString(teasession._nLanguage, "选项编号")%></td>
       <td>选项名称</td>
       <td>选项姓名</td>
       <td>选项导语</td>
       <td>联系方式</td>
       <td>显示顺序</td>
       <td>是否为正确答案</td>
       <td>操作</td>
     </tr><%
     java.util.Enumeration enumeration=tea.entity.node.PollChoice.findByPoll(poll,pos,pageSize);
     while(enumeration.hasMoreElements())
     {
       int id=((Integer) enumeration.nextElement()).intValue();
       tea.entity.node.PollChoice obj=tea.entity.node.PollChoice.find(id);

       %>
       <tr>
         <td><%=id%></td>
         <td><%=obj.getChoice()%></td>
         <td><%=obj.getTitle()%></td>
         <td><%if(obj.getFirstname()!=null)out.print(obj.getFirstname());%></td>
         <td><%if(obj.getMemberinfo()!=null)out.print(obj.getMemberinfo());%></td>
         <td><%if(obj.getLinkman()!=null)out.print(obj.getLinkman());%></td>
           <td><%=obj.getSequence()%></td>
         <td><%
         if(poll_obj.getType()==0)//单选
         {
           if(poll_obj.getCorrect()==id)out.print(r.getString(teasession._nLanguage,"正确答案"));
         }else if(poll_obj.getType()==1)//多选
         {
           if(poll_obj.getCorrect_ch()!=null && poll_obj.getCorrect_ch().length()>0 && poll_obj.getCorrect_ch().indexOf("/"+id+"/")!=-1)
           {
             out.print(r.getString(teasession._nLanguage,"正确答案"));
           }
         }
        %>&nbsp;</td>
         <td><input type=button onClick="window.open('/jsp/type/poll/EditPollChoice.jsp?node=<%=nodes%>&corrects=<%=(poll_obj.getCorrect()==id)%>&Poll=<%=poll%>&pollid=<%=id%>','_self');"VALUE="<%=r.getString(teasession._nLanguage, "Edit")%>">

           <!--td><input type=button onClick="home_form111_net.PollChoice.value=<%=id%>;home_form111_net.title.value='<%=obj.getTitle()%>';home_form111_net.bigpic.value='<%=obj.getBigPicture()%>';home_form111_net.pollinfo.value='<%=obj.getPollinfo()%>';home_form111_net.document.getElementById('img').src='<%=obj.getBigPicture()%>';home_form111_net.document.getElementById('img2').src='<%=obj.getSmallPicture()%>';home_form111_net.memberinfo.value='<%=obj.getMemberinfo()%>';home_form111_net.firstname.value='<%=obj.getFirstname()%>';home_form111_net.Choice.value='<%=obj.getChoice()%>';home_form111_net.correct.checked=<%=(poll_obj.getCorrect()==id)%>;home_form111_net.Choice.focus();"
             VALUE="<%=r.getString(teasession._nLanguage, "Edit")%>"-->
             <input type=button name="delete" onClick="f_delete('<%=id%>');" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Delete")%>"></td>
       </tr>
       <%}%>
       <%if (count > pageSize) {  %>
      <tr> <td colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
      <%}  %>
              </table>

              <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
                <tr>
                  <TD align="right" nowrap>选项编号：</TD>
                  <td><input name="Choice" size="40" maxlength="50" value="<%=Choices%>"/></td>
                    <td>
                      <input name="correct" type="checkbox" value="<%=corrects%>"   <%
                      if(poll_obj.getType()==0)//单选
                      {
                        if(poll_obj.getCorrect()==pollid)
                        {
                          out.print("checked=\"checked\"  ");
                        }

                      }else if(poll_obj.getType()==1)//多选
                      {
                          if(poll_obj.getCorrect_ch()!=null && poll_obj.getCorrect_ch().length()>0 && poll_obj.getCorrect_ch().indexOf("/"+pollid+"/")!=-1)
                        {
                           out.print("checked=\"checked\"  ");
                        }
                      }
                      %> >
                      <%=r.getString(teasession._nLanguage,"CorrectAnswer")%>
                    </td>
                </tr>
                <tr>
                  <TD align="right" nowrap>选项名称：</TD>
                  <td ><input name="title" size="40" maxlength="200" value="<%=titles%>" alt="选项名称"/></td>
                    <td><input  type="button" onClick="window.open('/jsp/type/poll/EditPollChoice.jsp?node=<%=nodes%>&Poll=<%=poll%>','_self');"VALUE="新建">

                </tr>
                <tr>
                  <TD align="right" nowrap>作者：</TD>
                  <td colspan="2"><input name="firstname" size="40" maxlength="200" value="<%=firstnames%>"/></td>
                </tr>
                <tr>
                  <TD align="right" nowrap>选项导语：</TD>
                  <td colspan="2"><input name="memberinfo" size="40" maxlength="200" value="<%=memberinfos%>"/></td>
                </tr>

                <tr>
                  <TD align="right" nowrap>联系方式：</TD>
                  <td colspan="2"><input name="linkman" size="40" maxlength="200" value="<%=linkmans%>"/></td>
                </tr>
                <tr>
                  <TD align="right" nowrap>大图：</TD>
                  <td colspan="2"><input type="file" name="bigpic" value="" onChange="document.getElementById('img').src=this.value;">
                    <%if(bigPictures!=null&&bigPictures.length()>0){ %>
                    <img  height="20" width="18" id="img"  src="<%=bigPictures%>" alt="">
                      <%} %>
                  </td>
                </tr>
                <tr>
                  <TD align="right" nowrap>小图：</TD>
                  <td colspan="2"><input type="file" name="smallpic" value="" onChange="document.getElementById('img2').src=this.value;">
                    <%if(smallPictures!=null&&smallPictures.length()>0){ %>
                    <img  height="20" width="18" id="img2"  src="<%=smallPictures%>" alt=""></td>
                  <%} %>
                </tr>
                 <tr>
                  <TD align="right" nowrap>显示顺序：</TD>
                  <td colspan="2"><input type="text" name="sequence" value="<%=sequence%>"></td>

                </tr>
                <tr>
                  <td nowrap align="right">选项简介：</td>
                  <td>
                    <input id="radio" type="radio" NAME="textorhtml" VALUE="0" ><%=r.getString(teasession._nLanguage, "TEXT")%>
                    <input id="radio" type="radio" NAME="textorhtml" VALUE="1" >HTML
                    <input id="CHECKBOX" type="CHECKBOX" name="nonuse" onClick="f_editor(this)"><%=r.getString(teasession._nLanguage, "NonuseEditor")%>
                  </td>
                </tr>
                <tr>
                 <td colspan="3">
                    <textarea style="display:none" name="content" rows="16" cols="97" class="edit_input"><%=pollinfos%></textarea>
                    <iframe id="editor" src="/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=content&Toolbar=<%=teasession._strCommunity%>" width="730" height="300" frameborder="no" scrolling="no"></iframe>
                  </td>
                </tr>
                <tr>

<td colspan="3"><input type=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Submit")%>" onclick="return mt.check(form1)"></td>
 </tr>
</table>
</form>

<input type="button" onClick="window.location='EditPollQuestion.jsp?node=<%=teasession._nNode%>';" name="GoBack"  id="edit_GoBack" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "GoBack")%>">
<input type=button onClick="window.location='/servlet/Poll?node=<%=teasession._nNode%>';" name="GoFinish" ID="edit_GoFinish"  class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Finish")%>">

<div id="head6"><img height="6" src="about:blank"  alt=""></div><div id="language"><%=new Languages (teasession._nLanguage,request)%></div>
</body>
</HTML>

