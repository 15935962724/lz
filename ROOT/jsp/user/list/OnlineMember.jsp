<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.member.*" %><%@page import="tea.entity.site.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="java.io.*" %>
<%@page import="java.util.*" %>
<% request.setCharacterEncoding("UTF-8");


TeaSession teasession=new TeaSession(request);

if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

boolean useSMS=(CommunityOption.find(teasession._strCommunity).get("smstype")!=null);

Resource r=new Resource().add("/tea/resource/deptuser");
if(teasession.getParameter("tp")==null){
  %>
  <HTML>
    <HEAD>
      <META http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
        <script src="/tea/tea.js" type="text/javascript"></script>
        <style type="text/css">
        <!--
        body {
        margin-left: 0px;
        margin-top: 0px;
        margin-right: 0px;
        margin-bottom: 0px;
        }
        -->
        </style>
        <script>

        function f_open(msnid)
        {
          window.open('http://settings.messenger.live.com/Conversation/IMMe.aspx?invitee='+msnid+'&mkt=zh-cn','','width=500px,height=400px');
        }
        function f_click(obj,id)
        {
          var div=document.getElementById("div"+id);
          if(div&&div.innerHTML!="")
          {
            var img,dis;
            if(obj.src.indexOf("tree_blank")!=-1)
            {
              dis="none";
              img="/tea/image/tree/tree_plus.gif";
            }else
            {
              dis="";
              img="/tea/image/tree/tree_blank.gif";
            }
            div.style.display=dis;
            obj.src=img;
          }
          obj.focus();
        }
        </script>
        </HEAD>
        <BODY id="sdf"><%}%>
          <div style="float:right;width:100%;text-align:right;"><a href="javascript:parent.topFrame.fright(0)"><img src="/tea/image/public/close.gif"></a></div>
            <%if(teasession.getParameter("tp")!=null){%><marquee behavior=scroll direction=up scrollAmount=2 scrollDelay=1 <%--onmouseout=start()   onmouseover=stop()--%>><%}%>

              <TABLE id="tablecenter">

              <%
              List auList = new ArrayList();
              Enumeration e=OnlineList.findOnline(teasession._strCommunity);
              while(e.hasMoreElements())
              {
                String member = (String)e.nextElement();
                //OnlineList ol = OnlineList.find(sid);
                AdminUsrRole aur = AdminUsrRole.find(teasession._strCommunity,member);
                if(aur.getUnit()!=0)
                {
                  AdminUnit au = AdminUnit.find(aur.getUnit());

                  String[] uPath = au.getPath().split("/");
                  for(int i = 3; i < uPath.length; i++)
                  {
                    int uid = Integer.parseInt(uPath[i]);
                    AdminUnit aun = AdminUnit.find(uid);
                    if(auList.indexOf(aun.getName())==-1){
                      auList.add(aun.getName());
                      out.print("<tr><td colspan=2>");
                      for(int j = 3; j <= i; j++)
                      {
                        out.print("　");
                      }
                      out.print("<b>├"+aun.getName()+"</b>");
                    }
                  }
                  //String member = ol.getMember();
                  Profile p=Profile.find(member);
                  out.print("<tr><td width=65% title=\"电话:"+p.getTelephone(teasession._nLanguage)+"&#13;手机:"+p.getMobile()+"&#13;邮箱:"+p.getEmail()+"\">");
                  for(int z = 2; z <uPath.length;z++){
                    out.print("　");
                  }
                  out.print(member);
                  out.write("<td ><a href=\"/jsp/message/NewMessage.jsp?community="+teasession._strCommunity+"&to="+java.net.URLEncoder.encode(member,"UTF-8")+"\" target=_blank ><img src=/tea/image/public/message.gif></a>");
                String mobile = p.getMobile();
                String msnid = p.getMsnID();
                if(useSMS&&mobile!=null&&mobile.length()>0)
                {
                  out.write("<a href=\"/jsp/sms/EditSMSMessage.jsp?community="+teasession._strCommunity+"&to="+java.net.URLEncoder.encode(member,"UTF-8")+"\" target=_blank ><img src=/tea/image/public/sms.gif></a>");//
                }
                if(msnid!=null)
                {
                  out.write("<a href=# onclick=f_open('"+msnid+"'); ><img src='http://messenger.services.live.com/users/"+msnid+"/presenceimage/' /></a>");
                }
                out.write("</td></tr>");
                }
              }

              %>


              </TABLE>
              <%if(teasession.getParameter("tp")==null){%>
              <BR>
                <div id="head6"><img height="6" src="about:blank"></div>

        </BODY>
  </HTML>
  <%}else{out.print("</marquee>");}%>




