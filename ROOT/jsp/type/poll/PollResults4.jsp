<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource" %><%@ page  import="tea.entity.admin.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.Http"%><%
request.setCharacterEncoding("UTF-8");
Http h=new Http(request,response);
TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

tea.resource.Resource r=new tea.resource.Resource();

r.add("/tea/ui/node/type/poll/EditPoll");

String community=request.getParameter("community");



int param_poll=0;
if(request.getParameter("poll")!=null)
{
  param_poll=Integer.parseInt(request.getParameter("poll"));
}
int pos=h.getInt("pos");
%><html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="">
function td_calendar(fieldname)
{
  myleft=document.body.scrollLeft+event.clientX-event.offsetX-80;
  mytop=document.body.scrollTop+event.clientY-event.offsetY+140;
  window.showModalDialog("/jsp/include/Calendar.jsp?FIELDNAME="+fieldname,self,"edge:raised;scroll:0;status:0;help:0;resizable:1;dialogWidth:280px;dialogHeight:205px;dialogTop:"+mytop+"px;dialogLeft:"+myleft+"px");
}
</script>
</head>
<body>
 <h1><%=r.getString(teasession._nLanguage, "Poll")%></h1>
 <br>
<div id="head6"><img height="6" src="about:blank"></div>
 <%
    java.util.Enumeration enumeration=Node.findByType(3,community);
    while(enumeration.hasMoreElements())
    {
      int node_id=((Integer)enumeration.nextElement()).intValue();
      Node obj=Node.find(node_id);
      out.print("<h2>"+obj.getSubject(teasession._nLanguage)+"</h2>");
      out.print("<table border=0 cellpadding=0 cellspacing=0 id=tablecenter >");

      java.util.Enumeration enumeration2=Poll.findByNode(node_id,teasession._nLanguage,pos,20);
      while(enumeration2.hasMoreElements())
      {
        int poll_id=((Integer)enumeration2.nextElement()).intValue();
        Poll poll_obj=Poll.find(poll_id);

        if(poll_obj.getType()<2)
        {
          out.print("<tr ID=tableonetr ><td colspan=3 >"+poll_obj.getQuestion()+"</td></tr>");

          java.util.Enumeration enumeration3=PollChoice.find(poll_id,0);
          while(enumeration3.hasMoreElements())
          {
            int pc_id=((Integer)enumeration3.nextElement()).intValue();
            PollChoice pc_obj=PollChoice.find(pc_id);
            out.print("<tr onmouseover=\"javascript:this.bgColor='#BCD1E9'\" onmouseout=\"javascript:this.bgColor=''\"><td>"+pc_obj.getChoice()+"<td><div style=\"width:"+PollResult.getResult(poll_id, teasession._nLanguage, pc_id, 1, true)+"%;background:#0000FF; \"></div></td><td><A href=/jsp/type/poll/PollResults5.jsp?community="+community+"&node="+node_id+"&poll="+poll_id+"&answer="+pc_id+" >"+PollResult.getResult(poll_id,  teasession._nLanguage, pc_id, 1, false)+"</a></td></tr>");
          }
        }else
        {
          //out.print(PollResult.getResult(poll_id, teasession._nLanguage, id, 1, true));
        }
      }

      out.print("</table>");
    }

%>


<br>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
<%--<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>
</body>
</html>

