<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*"%>
<%@ page import="javax.servlet.*"%>
<%@ page import="tea.entity.RV"%>
<%@ page import="tea.entity.member.*"%>
<%@ page import="tea.entity.node.*"%>
<%@ page import="tea.entity.site.*"%>
<%@ page import="tea.http.RequestHelper"%>
<%@ page import="java.io.*"%>
<%@ page import="javax.servlet.*"%>
<%@ page import="tea.entity.site.*"%>
<%@ page import="tea.html.*"%>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.resource.*"%>
<%@ page import="tea.ui.*"%><%@ page import="tea.db.*"%>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);
String s = request.getParameter("Member");

if(s == null)
if(teasession._rv != null)
{
  s = teasession._rv._strR;
} else
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String s_en=java.net.URLEncoder.encode(s,"UTF-8");



String community=teasession._strCommunity;


Resource r = new Resource("/tea/ui/member/Glance");
r.add("/tea/resource/Hostel");

TeaServlet ts=new TeaServlet();
int i = 0;
boolean flag = false;
if(teasession._rv != null)
flag = s.equals(teasession._rv._strR) || ProfileGrant.isExisted(s, teasession._rv);

Profile profile = Profile.find(s);


%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Glance")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

  <DIV ID=GlancePage>
    <TABLE border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Profile")%><A href="/servlet/Profile?Member=<%=s_en%>"><img src="/tea/image/Maximize.gif" ALT="<%=r.getString(teasession._nLanguage, "Maximize")%>" style="margin-left:10px;"/></A> </td>
        <td><%=r.getString(teasession._nLanguage, "Feedbacks")%><A href="/servlet/Feedbacks?Member=<%=s_en%>"><img src="/tea/image/Maximize.gif" ALT="<%=r.getString(teasession._nLanguage, "Maximize")%>" style="margin-left:10px;"/></A> </td>

      </tr>
      <tr ID=GlanceData>
        <td COLSPAN=2>
         <FONT ID=MemberId> <%=s%><FONT ID=MemberName>
<%=ts.hrefNewMessage(s, RequestHelper.makeName(teasession._nLanguage, profile.getFirstName(teasession._nLanguage), profile.getLastName(teasession._nLanguage)))%>

            <br/>
<%
 if(flag || profile.getType() == 1)
            {%>
               <%=ts.hrefNewMessage(profile.getEmail(),profile.getEmail())%>
<br><%
                String s1 = profile.getOrganization(teasession._nLanguage);
                if(s1!=null&&s1.length() != 0)
                {%>
                    <%=r.getString(teasession._nLanguage, "Organization")%>:
                    <%=s1%>
<%              }
                String s2 = profile.getWebPage(teasession._nLanguage);
                if(s2!=null&&s2.length() != 0)
                {
                  out.print(r.getString(teasession._nLanguage, "WebPage")+":");
                  Anchor anchor = new Anchor((s2.toLowerCase().startsWith("http://") ? "" : "http://") + s2, s2, "_blank");
                  out.print(anchor);
                }
                String s3 = profile.getAddress(teasession._nLanguage);
                if(s3!=null&&s3.length() != 0)
                {%>
                   <%=r.getString(teasession._nLanguage, "Address")%>:
<%=s3%>
       <%
                }
                String s4 = profile.getCity(teasession._nLanguage);
                if(s4!=null&&s4.length() != 0)
                {%>
                   <%=r.getString(teasession._nLanguage, "City")%>:
<%=s4%>

       <%
                }
                String s5 = profile.getState(teasession._nLanguage);
                if(s5!=null&&s5.length() != 0)
                {%>
                   <%=r.getString(teasession._nLanguage, "State")%>:
<%=s5%>
       <%
                }
                String s6 = profile.getZip(teasession._nLanguage);
                if(s6!=null&&s6.length() != 0)
                {%>
                   <%=r.getString(teasession._nLanguage, "Zip")%>:
                   <%=s6%>
<%
                }
                String s7 = profile.getCountry(teasession._nLanguage);
                if(s7!=null&&s7.length() != 0)
                {%>
                   <%=r.getString(teasession._nLanguage, "Country")%>:
<%=s7%>
       <%
                }
                String s8 = profile.getTelephone(teasession._nLanguage);
                if(s8!=null&&s8.length() != 0)
                {%>
                   <%=r.getString(teasession._nLanguage, "Telephone")%>:
<%=s8%>
       <%                }
                String s9 = profile.getFax(teasession._nLanguage);
                if(s9!=null&&s9.length() != 0)
                {%>
                   <%=r.getString(teasession._nLanguage, "Fax")%>:
<%=s9%>
       <%         }
            }
%>






<td COLSPAN=2><FONT ID=MemberId>
  <ul> <li><A href="/jsp/feedback/Feedbacks.jsp?member=<%=s%>"><%=Feedback.count(teasession._strCommunity ,s)%> <%=r.getString(teasession._nLanguage, "Feedbacks")%></a>
    </ul>
</td>
      </tr>
    </table>
    <TABLE border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Nodes")%><A href="/jsp/node/Nodes.jsp?Member=<%=s%>"><img src="/tea/image/Maximize.gif" ALT="<%=r.getString(teasession._nLanguage, "Maximize")%>" style="margin-left:10px;"/></A> </td>
        <td><%=r.getString(teasession._nLanguage, "Offers")%><A href="/servlet/Offers?Member=<%=s%>"><img src="/tea/image/Maximize.gif" ALT="<%=r.getString(teasession._nLanguage, "Maximize")%>" style="margin-left:10px;"/></A> </td>
      </tr>
      <tr ID=GlanceData>
        <td><%
if(teasession._rv != null && teasession._rv._strR.equals(s))
{%>
          <UL>
          <LI><A href="/jsp/node/TalkbackedNodes.jsp"><%=Node.count(" AND n.rcreator="+DbAdapter.cite(teasession._rv._strR)+" AND n.node IN(SELECT node FROM Talkback)")%> <%=r.getString(teasession._nLanguage, "TalkbackedNodes")%></A> </LI>
          <LI><A href="/jsp/node/TalkbackingNodes.jsp"><%=Node.count(" AND n.node IN(SELECT node FROM Talkback WHERE rmember="+DbAdapter.cite(teasession._rv._strR)+")")%> <%=r.getString(teasession._nLanguage, "TalkbackingNodes")%></A> </LI>
          <LI><A href="/jsp/node/AdedNodes.jsp"><%=Node.count(" AND node IN(SELECT node FROM Aded WHERE rmember=" + DbAdapter.cite(teasession._rv._strR) + " AND vmember=" + DbAdapter.cite(teasession._rv._strV)+")")%> <%=r.getString(teasession._nLanguage, "AdedNodes")%></A> </LI>
          <LI><A href="/jsp/node/AdingNodes.jsp"><%=Node.count(" AND n.rcreator="+DbAdapter.cite(teasession._rv._strR)+" AND n.node IN(SELECT node FROM Ading)")%> <%=r.getString(teasession._nLanguage, "AdingNodes")%></A> </LI>
          <LI><A href="/jsp/node/ListedNodes.jsp"><%=Node.count(" AND n.rcreator="+DbAdapter.cite(teasession._rv._strR)+" AND node IN(SELECT node FROM Listed)")%> <%=r.getString(teasession._nLanguage, "ListedNodes")%></A> </LI>
          <LI><A href="/jsp/node/ListingNodes.jsp"><%=Node.count(" AND n.rcreator=" + DbAdapter.cite(teasession._rv._strR)+" AND node IN(SELECT node FROM Listing)")%> <%=r.getString(teasession._nLanguage, "ListingNodes")%></A> </LI>
          <LI><A href="/jsp/node/FavoriteNodes.jsp"><%=Favorite.countNodes(teasession._strCommunity,teasession._rv,0)%> <%=r.getString(teasession._nLanguage, "FavoriteNodes")%></A> </LI>
          <%
 }
            i = 4;
            do
            {
                int j = Node.countMyNodes(s, i);
                if(j != 0){%>
            <LI><A href="/servlet/Search?Type=<%=i%>&Area=<%=1%>&CreatorStyle=<%=1%>&Creator=<%=s%>"><%=j%> <%=r.getString(teasession._nLanguage, Node.NODE_TYPE[i])%></A> </LI>
            <%	}
			} while(++i <= 6);
%>
          </UL></td>
        <td>
<%
if(teasession._rv != null && teasession._rv._strR.equals(s))
{%><UL>
            <LI><A href="/servlet/ShoppingCarts"><%=Buy.countBuys(teasession._rv,community)%> <%=r.getString(teasession._nLanguage, "Buys")%></A> </LI>
            <LI><A href="/servlet/Bids"><%=Bid.countNodes(teasession._rv)%> <%=r.getString(teasession._nLanguage, "Bids")%></A> </LI>
            <LI><A href="/servlet/Bargains"><%=Bargain.countNodes(teasession._rv)%> <%=r.getString(teasession._nLanguage, "Bargains")%></A> </LI>

          </UL>
          <%}%>
        </td>
      </tr>
    </table>
        <%
if(teasession._rv != null && teasession._rv._strR.equals(s))
{%>
    <TABLE border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr>
        <td><%=r.getString(teasession._nLanguage, "SaleOrders")%><A href="/servlet/SaleOrders"><img src="/tea/image/Maximize.gif" ALT="<%=r.getString(teasession._nLanguage, "Maximize")%>" style="margin-left:10px;"/></A> </td>
        <td><%=r.getString(teasession._nLanguage, "PurchaseOrders")%><A href="/servlet/PurchaseOrders"><img src="/tea/image/Maximize.gif" ALT="<%=r.getString(teasession._nLanguage, "Maximize")%>" style="margin-left:10px;"/></A> </td>
      </tr>
      <tr ID=GlanceData>
        <td><UL>
<%--
  for(int k = 0; k < Trade.TRADE_TYPE.length; k++)
  {
	int l = Trade.count(community," AND rcustomer="+teasession._rv._strR+" AND vcustomer="+teasession._rv._strV+" AND status="+k);
    if(l != 0)
    {%>
            <li><A href="/servlet/SaleOrders?Type=<%=k%>"><%=l%> <%=r.getString(teasession._nLanguage, tea.entity.member.Trade.TRADE_TYPE[k])%> <%=r.getString(teasession._nLanguage, "SaleOrders")%></A> </LI>
            <%                  }
  }%>
          </UL></td>
        <td><UL>
            <%
                for(int i1 = 0; i1 < tea.entity.member.Trade.TRADE_STATUS.length; i1++)
                {
                    int j1 = tea.entity.member.Trade.count(true, teasession._rv, i1,community);
                    if(j1 != 0)
                    {%>
            <LI><A href="/servlet/PurchaseOrders?Type=<%=i1%>"><%=j1%> <%=r.getString(teasession._nLanguage, tea.entity.member.Trade.TRADE_TYPE[i1])%> <%=r.getString(teasession._nLanguage, "PurchaseOrders")%></A> </LI>
            <%                  }
                }

--%>
          </UL></td>
      </tr>
    </table>
    <TABLE border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Communities")%><A href="/servlet/Communities"><img src="/tea/image/Maximize.gif" ALT="<%=r.getString(teasession._nLanguage, "Maximize")%>" style="margin-left:10px;"/></A> </td>
        <td><%=r.getString(teasession._nLanguage, "CGroups")%><A href="/jsp/sms/psmanagement/GroupManage.jsp"><img src="/tea/image/Maximize.gif" ALT="<%=r.getString(teasession._nLanguage, "Maximize")%>" style="margin-left:10px;"/></A> </td>
      </tr>
      <tr ID=GlanceData>
        <td><UL>
            <LI><A href="/servlet/JoiningCommunities"><%=JoinRequest.countJoining(teasession._rv)%> <%=r.getString(teasession._nLanguage, "JoiningCommunities")%></A> </LI>
            <LI><A href="/servlet/JoinedCommunities"><%=Subscriber.countJoined(teasession._rv)%> <%=r.getString(teasession._nLanguage, "JoinedCommunities")%></A> </LI>
            <LI><A href="/servlet/OrganizingCommunities"><%=Organizer.countOrganizing(teasession._rv)%> <%=r.getString(teasession._nLanguage, "OrganizingCommunities")%></A> </LI>
          </UL></td>
        <td><UL>
            <%
for(Enumeration enumeration = tea.entity.node.SMSGroup.findByMember(teasession._rv.toString(),community); enumeration.hasMoreElements();)
{
int id=((Integer)enumeration.nextElement()).intValue() ;
tea.entity.node.SMSGroup smsg=tea.entity.node.SMSGroup.find(id);%>
            <LI><A href="/jsp/sms/psmanagement/PhoneBookManage.jsp?groupid=<%=id%>"><%=smsg.getName()%></A> </LI>
            <%
}
%>
          </UL></td>
      </tr>
    </table>
    <TABLE border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr>
        <td><%=r.getString(teasession._nLanguage, "MessageFolders")%><A href="/servlet/MessageFolders"><img src="/tea/image/Maximize.gif" ALT="<%=r.getString(teasession._nLanguage, "Maximize")%>" style="margin-left:10px;"/></A> </td>
        <td><%=r.getString(teasession._nLanguage, "EmailBoxs")%><A href="/servlet/EmailBoxs"><img src="/tea/image/Maximize.gif" ALT="<%=r.getString(teasession._nLanguage, "Maximize")%>" style="margin-left:10px;"/></A> </td>
      </tr>
      <tr ID=GlanceData>
        <td><UL>
            <LI><A href="/jsp/message/Messages.jsp?folder=0"><%=MessageOld.count(teasession._strCommunity, teasession._rv._strV, 0)%> <%=r.getString(teasession._nLanguage, "InboxMessages")%></A> </LI>
            <%int k1 = MessageOld.count(teasession._strCommunity,teasession._rv._strV,1);
if(k1 != 0)
{%>
            <LI><A href="/jsp/message/Messages.jsp?folder=1"><%=k1%> <%=r.getString(teasession._nLanguage, "SentMessages")%></A> </LI>
            <%}%>
          </UL></td>
        <td><UL>
            <%
            String ss13;
            for(Enumeration enumeration2 = EmailBox.find(teasession._strCommunity,teasession._rv._strR); enumeration2.hasMoreElements(); )
            {
              ss13 = (String)enumeration2.nextElement();%>
            <LI><A href="/jsp/message/Emails.jsp?EmailBox=<%=ss13%>"><%=ss13%></A> </LI>
            <%
          }
          %>
          </UL></td>
      </tr>
    </table>
    <TABLE border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Requests")%><A href="/servlet/Requests"><img src="/tea/image/Maximize.gif" ALT="<%=r.getString(teasession._nLanguage, "Maximize")%>" style="margin-left:10px;"/></A> </td>
<td><%=r.getString(teasession._nLanguage, "DestineOrders")%><A href="/jsp/type/hostel/Destine.jsp?node=<%=teasession._nNode%>"><img src="/tea/image/Maximize.gif" ALT="<%=r.getString(teasession._nLanguage, "Maximize")%>" style="margin-left:10px;"/></A> </td>
      </tr>
      <tr ID=GlanceData>
        <td><UL>
            <%
if(teasession._rv.isSupport())
{%>
            <LI><A href="/servlet/ProfileRequests"><%=ProfileRequest.countRequests(teasession._rv._strR)%> <%=r.getString(teasession._nLanguage, "ProfileRequests")%></A> </LI>
            <%}%>
            <LI><A href="/servlet/JoinRequestCommunities"><%=JoinRequest.countRequestCommunities(teasession._rv)%> <%=r.getString(teasession._nLanguage, "JoinRequestCommunities")%></A> </LI>
            <LI><A href="/servlet/AdRequestNodes"><%=Aded.countRequestNodes(teasession._rv)%> <%=r.getString(teasession._nLanguage, "AdRequestNodes")%></A> </LI>
            <LI><A href="/servlet/AccessRequestNodes"><%=AccessRequest.countNodes(teasession._rv)%> <%=r.getString(teasession._nLanguage, "AccessRequestNodes")%></A> </LI>
            <LI><A href="/servlet/NodeRequestNodes"><%=Node.countRequestNodes(teasession._rv)%> <%=r.getString(teasession._nLanguage, "NodeRequestNodes")%></A> </LI>
          </UL></td>
<td>
<UL>
<LI><A href="/jsp/type/hostel/DestineOrders.jsp?node=<%=teasession._nNode%>"><%=Destine.countByMember(teasession._strCommunity,teasession._rv.toString())%>  <%=r.getString(teasession._nLanguage, "DestineOrders")%></A></LI>
<LI><A href="/jsp/type/sorder/PurchaseSOrder.jsp?node=<%=teasession._nNode%>"><%=r.getString(teasession._nLanguage, "ServiceOrder")%></A></LI>
<LI><A href="/jsp/profile/Center.jsp?node=<%=teasession._nNode%>"><%=r.getString(teasession._nLanguage, "ConsumeStat")%></A></LI>
<LI><A href="/jsp/sms/EditSMSMoney.jsp?node=<%=teasession._nNode%>&member=<%=s%>"><%=r.getString(teasession._nLanguage, "SMS")%></A></LI>

</UL>
</td>
      </tr>
    </table>


    <TABLE border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Resume")%><img src="/tea/image/Maximize.gif" ALT="<%=r.getString(teasession._nLanguage, "Maximize")%>" style="margin-left:10px;"/> </td>

      </tr>
      <tr ID=GlanceData>
        <td><UL>


            <LI><A href="/jsp/type/resume/Resume.jsp"><%=r.getString(teasession._nLanguage, "MyResume")%></A> </LI>
            <LI><A href="/jsp/type/job/AppHistory.jsp"><%=r.getString(teasession._nLanguage, "MyJob")%></A> </LI>
          </UL></td>
<td>
<!--UL>
<LI>
</LI>
</UL-->
</td>
      </tr>
    </table>


    <%}%>
  </DIV>

<div id="head6"><img height="6" src="about:blank"></div>
<%--   <div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>
</body>
</html>


