<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="java.io.*" %>
<%@page import="java.util.*" %>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Pragma", "No-cache");
response.setHeader("Cache-Control", "no-cache");
response.setDateHeader("Expires", 0);


TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource().add("/tea/resource/deptuser");

String menuid=teasession.getParameter("id");
CommunityOption co=CommunityOption.find(teasession._strCommunity);
boolean sms;
sms=co.get("smstype")!=null;


int pos=0;
String tmp=request.getParameter("pos");
if(tmp!=null)pos=Integer.parseInt(tmp);

StringBuffer sql = new StringBuffer();
StringBuffer par=new StringBuffer();
boolean isSel = false;//是否查询

par.append("?community=").append(teasession._strCommunity);
par.append("&id=").append(menuid);
String name = request.getParameter("name");

if(name!=null&&name.length()>0){
  isSel = true;
  sql.append(" AND member in (select member from profilelayer where (lastname+firstname) like '%"+name+"%')");
  par.append("&name=").append(name);
}
par.append("&pos=");

int sum=0;
if(!isSel){
  sum = AdminUnit.countByCommunity(teasession._strCommunity,"");
}else{
  sum = Profile.count(sql.toString());
}

%>
<HTML>
  <HEAD>
    <META   HTTP-EQUIV="pragma"   CONTENT="no-cache">
      <META   HTTP-EQUIV="Cache-Control"   CONTENT="no-cache,   must-revalidate">
        <META   HTTP-EQUIV="expires"   CONTENT="Wed,   26   Feb   1997   08:21:57   GMT">
          <META http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
            <script src="/tea/tea.js" type="text/javascript"></script>
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

            function selunit(){
              var un = document.getElementById('name').value;

              window.location.href=encodeURI('/jsp/user/list/AllMembers.jsp?community=<%=teasession._strCommunity%>&name='+un);
            }

            
            </script>
            </HEAD>
            <BODY id="sdf">

              <div id="selectname" style="font-size:12px;width:100%;border-bottom:1px solid #cccccc;background:#f2f2f2;z-index:100;left:1px;position:absolute;"> <a style="text-align:right;" href="javascript:parent.topFrame.fright(0)"><img src="/tea/image/public/close.gif" align="right"></a>

              姓名：<input type="text" size="8" id="name" name="name" value="<%if(name!=null){out.print(name);}%>"/>&nbsp;<input id="sun" type="button" value="GO" onClick="selunit();"/>

</div>
              <script type="text/javascript">
              var selectname=document.getElementById("selectname");
                setInterval('selectname.style.top=document.body.scrollTop;',100);</script>
                <br />
                <TABLE id="tablecenter" >

                <%
                if(sum>0){
                  if(isSel){
                    Enumeration enumer1 =tea.entity.member.Profile.findByCommunityMem(teasession._strCommunity,sql.toString(),true);
                    while(enumer1.hasMoreElements())
                    {
                      String member =(String)enumer1.nextElement(); Profile p = Profile.find(member);
                          if(p!=null&&(!p.getMember().equals("webmaster")))
                          {

                            out.print("<tr><td nowrap=nowrap>　　　　&nbsp;");
                            out.print(Profile.find(p.getMember()).getName(1)+" ");
                            out.print("<td ><A href=\"/jsp/message/NewMessage.jsp?community="+teasession._strCommunity+"&to="+java.net.URLEncoder.encode(p.getMember(),"UTF-8")+"\" target=_blank ><img src=/tea/image/public/message.gif></a>");
                            String mobile=p.getMobile();
                            String msnid = p.getMsnID();
                            if(mobile!=null&&mobile.length()>0&&sms)
                            {
                              out.print("<A href=\"/jsp/sms/EditSMSMessage.jsp?community="+teasession._strCommunity+"&to="+java.net.URLEncoder.encode(p.getMember(),"UTF-8")+"\" target=_blank ><img src=/tea/image/public/sms.gif></a>");//
                            }
                            if(msnid!=null)
                            {
                              out.print("<a href=# onclick=f_open('"+msnid+"'); ><img src='http://messenger.services.live.com/users/"+msnid+"/presenceimage/' /></a>");
                            }
                            out.print("</td></tr>");
                          }
                    }
                  }else{
                    Enumeration e = AdminUnit.findByCommunity(teasession._strCommunity," ORDER BY sequence",pos,30);
                    for(int i=1;e.hasMoreElements();i++)
                    {

                      AdminUnit obj=(AdminUnit)e.nextElement();
                      int id=obj.getId();
                      int fid=obj.getFather();

                      out.print("<tr><td colspan=2 nowrap=nowrap>&nbsp;&nbsp;");

                      out.print(obj.getPrefix());
                      out.print("<b>"+obj.getName() + "</b></td></tr>");

                      if(i < 30){
                        Enumeration enumer =tea.entity.member.Profile.findByCommunityNew(teasession._strCommunity,sql.toString(),id,true);
                        while(enumer.hasMoreElements())
                        {

                          String member =(String)enumer.nextElement();
                          Profile p = Profile.find(member);
                          if(p!=null&&(!p.getMember().equals("webmaster")))
                          {

                            out.print("<tr><td nowrap=nowrap title=\"电话:"+p.getTelephone(teasession._nLanguage)+"&#13;手机:"+p.getMobile()+"&#13;邮箱:"+p.getEmail()+"\">　&nbsp;");
                            out.print(obj.getPrefix().replaceAll("├",""));

                            out.print(Profile.find(p.getMember()).getName(1)+" ");
                            out.print("<td ><A href=\"/jsp/message/NewMessage.jsp?community="+teasession._strCommunity+"&to="+java.net.URLEncoder.encode(p.getMember(),"UTF-8")+"\" target=_blank ><img src=/tea/image/public/message.gif></a>");
                            String mobile=p.getMobile();
                            String msnid = p.getMsnID();
                            if(mobile!=null&&mobile.length()>0&&sms)
                            {
                              out.print("<A href=\"/jsp/sms/EditSMSMessage.jsp?community="+teasession._strCommunity+"&to="+java.net.URLEncoder.encode(p.getMember(),"UTF-8")+"\" target=_blank ><img src=/tea/image/public/sms.gif></a>");//
                            }
                            if(msnid!=null)
                            {
                              out.print("<a href=# onclick=f_open('"+msnid+"'); ><img src='http://messenger.services.live.com/users/"+msnid+"/presenceimage/' /></a>");
                            }
                            out.print("</td></tr>");
                          }
                        }
                      }
                    }
                  }

                }else{
                  out.print("<tr><td colspan='5' align='center'>暂无组织机构");
                }
                out.print("</TABLE>");
                if(sum>30)
                {
                	out.print("<div id=\"selectunit\" style=\"width:100%;border-top:1px solid #cccccc;font-size:12px;background:#ECEBEB;z-index:100;left:1px;position:absolute;\">"+new tea.htmlx.FPNL(teasession._nLanguage,par.toString(),pos,sum,30)+"</div>");

                %>

                <script type="">var selectunit=document.getElementById("selectunit");
                setInterval('selectunit.style.top=document.body.scrollTop+document.body.clientHeight-selectunit.offsetHeight;',100);
                document.getElementById('go').style.display='none';
                </script>
				<%                } %>
                <BR>

                  <div id="head6"><img height="6" src="about:blank"></div>

            </BODY>
</HTML>
