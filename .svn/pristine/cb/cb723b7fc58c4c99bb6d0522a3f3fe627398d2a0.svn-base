<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%StringBuffer scriptsb=new StringBuffer();
r.add("/tea/ui/member/community/Subscribers");
r.add("/tea/ui/member/community/Communities");
            byte pagesize = 3;
            String s = request.getParameter("Community");
            //Text text = new Text(String.valueOf(hrefGlance(teasession._rv)) + ">" + new Anchor("Communities", super.r.getString(teasession._nLanguage, "Communities")) + ">" + new Anchor("OrganizingCommunities", super.r.getString(teasession._nLanguage, "OrganizingCommunities")) + ">" + s + ":" + super.r.getString(teasession._nLanguage, "Subscribers"));
            String s1 = request.getParameter("Pos");
            int i = s1 == null ? 0 : Integer.parseInt(s1);
int j = Subscriber.count(s,"");

int pagenum=j/pagesize;
if (j%pagesize!=0)
pagenum++;
String nexturl=request.getParameter("nexturl");
if(nexturl!=null)
nexturl="&nexturl="+nexturl;
else
nexturl="";
%>
<html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
<!--
#user td {padding-left:5px}

-->
</style>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "CBSubscribers")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<input type='hidden' name="rmember" VALUE="webmaster">
<input type='hidden' name=vmember VALUE="webmaster">

 <FORM name=foDelete METHOD=GET action="/servlet/DeleteSubscribers">
    <table id="tablecenter" border="0" cellpadding="0" cellspacing="0">
	<tr>
        <td COLSPAN=10>已创建<%=j%> <%=r.getString(teasession._nLanguage, "Subscribers")%>
		<input type='hidden' name=Community VALUE="<%=s%>"></td>
      </tr>
            <%
            if(j != 0)
            {
                boolean flag = true;%>
            <tr bgcolor="#FFFBF0">
              <td width=20 align=center nowrap>&nbsp;</td>
              <td nowrap>姓名</td>
              <td nowrap>用户ID</td>
              <td nowrap>邮箱</td>
    <td nowrap>电话</td>
    <td nowrap>编辑</td>
            </tr>
            <%
                 int k=0;
                 for(Enumeration enumeration = Subscriber.find(s, "",i, pagesize); enumeration.hasMoreElements(); )
                {  k++;

					RV rv = (RV)enumeration.nextElement();
                   %>

				   <%



                                   String s2 = rv.toString();scriptsb.append("foDelete."+s2+".checked=bool;");
                                   Profile profile = Profile.find(rv._strR);
                                   String email = profile.getEmail();
%>
            <tr >
              <td width=20 nowrap ><input  id="CHECKBOX" type="CHECKBOX" name="<%=s2%>" >    </td>
    <td nowrap >&nbsp;<%=getNull(profile.getFirstName(1))+getNull(profile.getLastName(1))%></td>
              <td nowrap>    <A href="/jsp/user/EditAddress.jsp?Member=<%=s2%>" ><%=s2%></A></td>
                            <td nowrap>    <A HREF="mailto:<%=email%>" ><%=getNull(email)%></A>              </td>
                            <td nowrap ><%=getNull(profile.getTelephone(1))%></td>
                <input type='hidden' name=Subscribers VALUE="<%=s2%>"><td nowrap><A href="/jsp/user/EditAddress.jsp?Member=<%=s2%>&nexturl=<%=request.getRequestURI()+"?"+request.getQueryString()%>" >编辑</A></td>
            </tr>

            <%



				}

            }
 	 %>



		<% for (int mm=0;mm<pagenum;mm++)
		{
			 int pag=mm*pagesize;
			%>

		<A href="/jsp/community/Subscribers2.jsp?Community=<%=s%>&Pos=<%=pag%>" ><%=mm+1%></A>
           <%
		   }
		   %>




	 <tr id="TableHeader">
              <td width=20 align=center><input  id="CHECKBOX" type="CHECKBOX" name="selectAllcheck" onclick="javascript:SelectAll()" ></td>
              <td COLSPAN=9>全选</td>
            </tr>
</table>




		<script         >
        function		SelectAll()
        { bool=foDelete.selectAllcheck.checked;
            <%=scriptsb.toString()%>
        }
        </script         >


  <%  //      if(teasession._rv.isWebMaster() || teasession._rv.isOrganizer(s))
            {
%>
  <input class="in" type=BUTTON VALUE="<%=r.getString(teasession._nLanguage, "CBNew")%>" ID="CBNew" onClick="window.open('/jsp/user/cnoocjobnewuser.jsp?Community=<%=s%><%=nexturl%>', '_self');">
  <%              if(j != 0)
                {%><input class="in"  type=BUTTON VALUE="<%=r.getString(teasession._nLanguage, "CBDelete")%>" ID="CBDelete"  onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDeleteSelected")%>')){window.open('javascript:foDelete.submit();', '_self');}">
  <%}
            }

%>
 </form>
   <div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>



