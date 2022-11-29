<%@page contentType="text/html;charset=UTF-8" %>
<%@ include file="/jsp/Header.jsp" %>
<%
tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
String community=node.getCommunity();
if(request.getParameter("Node")!=null&&teasession._rv.isOrganizer(community))
{
  teasession._nNode=Integer.parseInt(request.getParameter("Node"));

}else
{
java.util.Enumeration enumer_type=tea.entity.node.Node.findByType(64,community);//查找当前会员的差点节点
int nodecode=-1;
boolean bool=false;
while(enumer_type.hasMoreElements())
{
   nodecode=((Integer)enumer_type.nextElement()).intValue();
   tea.entity.node.Node node_temp=  tea.entity.node.Node.find(nodecode);
   if(node_temp.getCreator()._strR.equals(teasession._rv._strR))
   {
     bool=true;
     //node=node_temp;
     teasession._nNode=nodecode;
   }
}
if(!bool)
{
  out.print(new tea.html.Script("alert('对不起,没有记录.');history.back();"));
  return;
}

}
//17539
tea.entity.node.Node node=tea.entity.node.Node.find(teasession._nNode);
if(request.getParameter("hidden")!=null)
{
  int options1=0;
  if(request.getParameter("hidden").equals("1"))
  options1|=1;
  node.setOptions1(options1);
  response.sendRedirect(request.getParameter("nexturl"));
  return;
}r.add("/tea/resource/Score");
%>
<html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Score")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<span style="float:left;color:#FF0000;font-weight:bold;"><img SRC="/tea/image/score/0001.jpg">　差点管理</span>
<span style="float:right;color:#FF0000;font-weight:bold;">你好：
<%

tea.entity.member.Profile profile_obj=tea.entity.member.Profile.find(teasession._rv.toString());
out.println(profile_obj.getLastName(teasession._nLanguage));
out.println(profile_obj.getFirstName(teasession._nLanguage));
%></span><br>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr ID=tableonetr>
    <td align="center" scope="col">打球日期</td>
    <td scope="col">&nbsp;球场</td>
    <td align="center" scope="col">发球台</td>
    <td align="center" scope="col">成绩</td>
    <td align="center" scope="col">是否比赛</td>
    <td align="center" scope="col">操作</td>
  </tr>
  <%


 
   Iterator it = tea.entity.node.Score.find(" AND member=" + DbAdapter.cite(teasession._rv._strR) + " ORDER BY times DESC",0,1).iterator();
    
       
int score;
while(it.hasNext())
{
 Score obj = (Score) it.next();
 score = obj.score;
%>
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
  <td align="center"><%=obj.getTimes("yyyy-MM-dd")%></td>
  <td>&nbsp;
    <%
    if(obj.getNode()!=0)
    out.print(new tea.html.Anchor("/servlet/Node?node="+obj.getNode(),obj.getName()));
    else
    out.print(obj.getName());
    %></td>
  <td align="center"><%=r.getString(teasession._nLanguage ,tea.entity.node.Score.TEE_TYPE[obj.getTee()])%></td>
    <td align="center"><%=obj.getSums()%></td>
    <td align="center"><%=obj.isCompete()?"是":"否"%></td>
    <td align="center"><a href="/jsp/type/score/EditScore.jsp?node=<%=teasession._nNode%>&score=<%=score%>"><img src="/tea/image/score/0003.jpg" width="17" height="15" border="0"></a>
      <input type="image" SRC="/tea/image/score/0004.jpg" alt="删除" value="删除" onclick="if(confirm('确认删除?')){window.open('/servlet/DeleteScore?node=<%=teasession._nNode%>&score=<%=score%>', '_self')};"/>    </td>
</tr>
<%}%>
</table>
<br>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr ID=tableonetr>
    <td>&nbsp;许可查看成绩的会员</td>
    <td><div align="center">操作</div></td>
  </tr>
  <%
Enumeration enumer=  tea.entity.node.AccessMember.findByNode(teasession._nNode);//,0,Integer.MAX_VALUE);
while(enumer.hasMoreElements())
{
  int id=((Integer)enumer.nextElement()).intValue();
  tea.entity.node.AccessMember am_obj=  tea.entity.node.AccessMember.find(id);
  String member=am_obj.getMember();
%>
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <FORM name=foDelete METHOD=POST action="/servlet/EditAccessMembers" onsubmit="return confirm('<%=r.getString(teasession._nLanguage,"ConfirmDelete")%>');">
                <input type='hidden' name="id" VALUE="<%=id%>">
                <input type='hidden' name="node" VALUE="<%=teasession._nNode%>">
          <input type='hidden' name=nexturl VALUE="<%=request.getRequestURI()%>?<%=request.getQueryString()%>">
  <td>&nbsp;<%=member%>
    <input type="hidden" name="member" value="<%=member%>"/></td>
  <td> <div align="center">
    <input type="image" SRC="/tea/image/score/0004.jpg" alt="删除" value="删除">
  </div></td>
    </form>
</tr>
<%}%>
</table>
<input  id="CHECKBOX" type="CHECKBOX" name="hidden" <%if((node.getOptions1()&1)!=0)out.print(" CHECKED ");%> onclick="window.open('/jsp/type/score/ScoreManage.jsp?hidden='+(this.checked?'1':'0')+'&nexturl=<%=request.getRequestURI()%>','_self')" value="checkbox">
我的成绩全体人员可见 &nbsp;&nbsp;&nbsp;添加许可查看成绩的会员
<FORM name=foDelete METHOD=POST action="/servlet/NewAccessMembers" onSubmit="return(submitText(this.Members,'非法的访问会员'));">
          <input type='hidden' name=Node VALUE="<%=teasession._nNode%>">
          <input type="hidden" name="id" value="0"/>
          <input type='hidden' name=nexturl VALUE="<%=request.getRequestURI()%>?<%=request.getQueryString()%>">
          只有许可的会员可见,创建许可会员。输入许可会员ID :
          <input type="TEXT" class="edit_input"  name=Members>
          <input type="submit" class="edit_button" id="edit_submit"  value="提交">
  </form>
  <div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage, request)%></div>
</body>
</html>

