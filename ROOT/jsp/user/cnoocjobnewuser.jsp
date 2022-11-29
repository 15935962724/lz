<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%

if(!teasession._rv.toString().equalsIgnoreCase("cnooc")&&!License.getInstance().getWebMaster().equals(teasession._rv.toString()))
{
    ts.outText(response,1, "你没有权限,访问本页.");
    return;
}
StringBuffer scriptsb=new StringBuffer();
//r.add("/tea/ui/member/community/Subscribers");
//r.add("/tea/ui/member/community/Communities");
//r.add("/tea/entity/site/Organizer");
//r.add("/tea/entity/site/Manager");
//r.add("/tea/entity/node/AccessMember");
//r.add("/tea/ui/TeaServlet");
String community=node.getCommunity();
            byte byte0 = 25;
            String s = request.getParameter("Community");
            //Text text = new Text(String.valueOf(hrefGlance(teasession._rv)) + ">" + new Anchor("Communities", super.r.getString(teasession._nLanguage, "Communities")) + ">" + new Anchor("OrganizingCommunities", super.r.getString(teasession._nLanguage, "OrganizingCommunities")) + ">" + s + ":" + super.r.getString(teasession._nLanguage, "Subscribers"));
            String s1 = request.getParameter("Pos");
            int i = s1 == null ? 0 : Integer.parseInt(s1);
int j = Subscriber.count(s,"");
String nexturl=request.getParameter("nexturl");
if(nexturl!=null)
nexturl="&nexturl="+nexturl;
else
nexturl="";
if(request.getMethod().equals("POST"))
{

    String member=request.getParameter("txtUserName").trim().toLowerCase();
    boolean booledit=request.getParameter("edit")!=null;
    if(!booledit&&Profile.isExisted(member))
    {
         ts.outText(response,1, member+" 用户已经存在.");
         return;
     }
     DbAdapter dbadapter=new DbAdapter();
     if(!booledit)
     {
         dbadapter.executeUpdate("INSERT INTO Profile(member,password)VALUES("+dbadapter.cite(member)+","+
         dbadapter.cite(request.getParameter("txtComfirmPwd"))+")");
         dbadapter.executeUpdate("INSERT INTO ProfileLayer(language,member,firstname,organization,email,telephone,job)VALUES(1,"+
         dbadapter.cite(member)+","+
         dbadapter.cite(request.getParameter("txtName"))+","+
         dbadapter.cite(request.getParameter("selOrg"))+","+
         dbadapter.cite(request.getParameter("txtEmail"))+","+
         dbadapter.cite(request.getParameter("txtTelephone"))+","+
         dbadapter.cite(request.getParameter("txtWork_Title"))+
         ")");

     }else
     {
         dbadapter.executeUpdate("UPDATE Profile SET password="+ dbadapter.cite(request.getParameter("txtComfirmPwd"))+" WHERE member="+dbadapter.cite(member)
         );
         dbadapter.executeUpdate("UPDATE ProfileLayer SET firstname="+dbadapter.cite(request.getParameter("txtName")) +
         ",organization="+ dbadapter.cite(request.getParameter("selOrg"))+
         ",email="+dbadapter.cite(request.getParameter("txtEmail"))+
         ",telephone="+dbadapter.cite(request.getParameter("txtTelephone"))+
         ",job="+dbadapter.cite(request.getParameter("txtWork_Title"))+" WHERE member="+         dbadapter.cite(member));
         Profile._cache.remove(member);
     }
     dbadapter.close();
     Purview objpurview=Purview.find(member,teasession._strCommunity);
     String _strNode=request.getParameter("selCompanyxx");
     boolean _bJob=(request.getParameter("chkRight1")!=null);
boolean _bResume=(request.getParameter("chkRight2")!=null);
boolean _bApply=(request.getParameter("chkRight3")!=null);
boolean _bCompany=(request.getParameter("chkRight4")!=null);
objpurview.set(_strNode,_bJob,_bResume,_bApply,_bCompany);
/*
dbadapter.executeUpdate("INSERT INTO Purview(username,company,job,resume,apply,comp)VALUES("+
dbadapter.cite(request.getParameter("txtUserName"))+","+
dbadapter.cite(request.getParameter("selCompanyxx"))+","+request.getParameter("chkRight1")+","+request.getParameter("chkRight2")+","+
request.getParameter("chkRight3")+","+request.getParameter("chkRight4")+")");
*/
Organizer.create(community, member);//组织者
/*Manager.create(community, member);//管理者
Subscriber.create(community, new RV(member));//用户
if(request.getParameter("chkRight1")!=null)  //  职位管理
{
    AccessMember accessmember=  AccessMember.find(15542,member);//create(j4, rv);
    accessmember.set();
}
if(request.getParameter("chkRight2")!=null)//简历管理
{
    AccessMember accessmember=  AccessMember.find(15544,member);//create(j4, rv);
    accessmember.set();
}
if(request.getParameter("chkRight3")!=null)// 应聘管理
{
    AccessMember accessmember=  AccessMember.find(15543,member);//create(j4, rv);
    accessmember.set();
}
if(request.getParameter("chkRight4")!=null)// 公司设置
{
    AccessMember accessmember=  AccessMember.find(15537,member);//create(j4, rv);
    accessmember.set();
}*/
response.sendRedirect("/jsp/community/cnoocjobsubscribers.jsp?node=15538");
return;
}
String member=request.getParameter("Member");


%>
<html>
<head>
<TITLE>新增用户</TITLE>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=UTF-8">
<LINK href="/tea/CssJs/default.css" REL="stylesheet" TYPE="text/css">
<SCRIPT language="javascript" SRC="/tea/CssJs/validate.js"></SCRIPT>
<SCRIPT language="javascript" SRC="/tea/CssJs/CheckUserName.js"></SCRIPT>
<SCRIPT language="javascript">
function OpenWin(theURL,winName,features)
{
  window.open(theURL,winName,features);
}

function chkit()
{
	var frm=document.frmInsertUser;
	frm.selCompany.value=frm.selCompanyxx.value;
	if(!ChkTxt(frm.txtName, "姓名")) return false;
	if (frm.selOrg.value=='255' || frm.selOrg.value=='-1')	{
		alert("请选择用户所属的机构！");
		frm.selOrg.focus();
		return false;
	}
	if (!IsMail(frm.txtEmail.value)) {
		alert("请输入正确的E-mail！");
		frm.txtEmail.focus();
		return false;
	}
	if (frm.selCompany.value=='255' || frm.selCompany.value=='-1')	{
		alert("请选择用户可以操作的机构！");
		frm.selCompanyxx.focus();
		return false;
	}

	if(!CheckUserName(frm.txtUserName)) return false;
	if(!Chkpwd(frm.txtPassWord,"密码",12,6)) return false;
	if(!Chkpwd(frm.txtComfirmPwd,"确认密码",12,6)) return false;
	if(frm.txtPassWord.value!=frm.txtComfirmPwd.value) {alert('两次输入密码不一致！');frm.txtPassWord.select();return false;}
	if(frm.hiddenCount.value == null){
	    alert("请选择用户权限范围！");
		return false;
	}
	var flagstr = false;
	for(var i=0;i<frm.chkRights.length;i++)	{
	    if(frm.chkRights[i].checked){flagstr = true;}
	}
	if(!flagstr){alert("请选择用户权限范围！");	return false;}

}

function account() {

    var sum = 0;
    var count = document.frmInsertUser.chkRights.length;
    for(var i = 0; i <= count - 1; i++) {
        if (document.frmInsertUser.chkRights[i].checked) {
            sum += parseInt(document.frmInsertUser.chkRights[i].value);
        }
    }
    document.frmInsertUser.hiddenCount.value = sum;
}
</SCRIPT>
</head>
<BODY>
<h1><%=r.getString(teasession._nLanguage, "新增用户")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

        <FORM NAME="frmInsertUser" METHOD="post" onSubmit="javascript:return chkit();">
        
      <TABLE border="0" cellpadding="0" cellspacing="0" id="tablecenter">
        <%
        if(member==null)
        {
            member="";
        }else
        out.print("<input type=hidden name=edit value=on />");
        Purview purview=Purview.find(member,teasession._strCommunity);
        Profile profile=Profile.find(member);
        %>
          <TR>
            <TD COLSPAN="4">新增用户</TD>
          </TR>
          <TR>
            <TD COLSPAN="4"><SPAN >* 必须填写</SPAN></TD>
          </TR>

          <TR>
            <TD align="right" width=100><SPAN >*</SPAN> 姓名 &nbsp;</TD>
            <TD> <INPUT TYPE="text" class="edit_input" NAME="txtName" MAXLENGTH="50" VALUE="<%=getNull(profile.getFirstName(1))%>">            </TD>
            <TD ALIGN="RIGHT"><SPAN >* </SPAN>所在机构&nbsp;</TD>
            <TD> <SELECT NAME="selOrg" STYLE="width:172px">
<%java.util.Enumeration enumeration=tea.entity.node.Node.findByType(21,community);int nodeCode;
while(enumeration.hasMoreElements())
{
   nodeCode =((Integer)enumeration.nextElement()).intValue();
   String strTempSubject=tea.entity.node.Node.find(nodeCode).getSubject(1);
%>
<OPTION VALUE="<%=nodeCode%>"<%=getSelect(strTempSubject.equals(profile.getOrganization(1)))%>><%=strTempSubject%></OPTION>
<%}%>
</SELECT>
        </TD>
          </TR>
          <TR>
            <TD width="100" ALIGN="RIGHT"><SPAN >*</SPAN> E-mail&nbsp;</TD>
            <TD> <INPUT TYPE="text" class="edit_input" NAME="txtEmail" MAXLENGTH="120" VALUE="<%=getNull(profile.getEmail())%>">            </TD>
            <TD ALIGN="RIGHT">电话&nbsp;</TD>
            <TD> <INPUT TYPE="text" class="edit_input" NAME="txtTelephone" MAXLENGTH="40" VALUE="<%=getNull(profile.getTelephone(1))%>">            </TD>
          </TR>
          <TR>
            <TD width="100" ALIGN="RIGHT">职位&nbsp;</TD>
            <TD> <INPUT TYPE="text" class="edit_input" NAME="txtWork_Title" MAXLENGTH="60" VALUE="<%=getNull(profile.getJob(1))%>">            </TD>
            <TD ALIGN="RIGHT">&nbsp;</TD>
            <TD>&nbsp;</TD>
          </TR>
          <TR>
            <TD COLSPAN="4"> <HR SIZE="1"> </TD>
          </TR>
          <TR>
            <TD COLSPAN="4"><SPAN >*</SPAN> 管辖机构</TD>
          </TR>
          <TR>
            <TD width="100">&nbsp; </TD>
            <TD COLSPAN="3"> <INPUT TYPE="hidden" NAME="selCompany" VALUE="">
              <SELECT NAME="selCompanyxx" VALUE="255" STYLE="width:272px;height:200px" multiple="multiple">

<%java.util.Enumeration enumerationabc=tea.entity.node.Node.findByType(21,community); String checkOption=null;
while(enumerationabc.hasMoreElements())
{
   nodeCode =((Integer)enumerationabc.nextElement()).intValue();
    checkOption=purview.getNode();
%>
<OPTION VALUE="<%=nodeCode%>" <%=getSelect((checkOption.indexOf("/"+nodeCode+"/")!=-1)||checkOption.endsWith("/"+nodeCode))%>><%=tea.entity.node.Node.find(nodeCode).getSubject(teasession._nLanguage)%></OPTION>
<%}%>
</SELECT>
              <SPAN CLASS="note">该用户可以对所选机构的信息进行操作</SPAN></TD>
          </TR>
          <TR>
            <TD width="100" ALIGN="RIGHT">权限&nbsp;</TD>
            <TD COLSPAN="3">

              <INPUT  id="CHECKBOX" type="CHECKBOX" NAME="chkRight1" VALUE="1"<%=getCheck(purview.isJob())%>>            职位管理
              <INPUT  id="CHECKBOX" type="CHECKBOX" NAME="chkRight2" VALUE="1" <%=getCheck(purview.isResume())%>>
              简历管理
              <INPUT  id="CHECKBOX" type="CHECKBOX" NAME="chkRight3" VALUE="1" <%=getCheck(purview.isApply())%>>
              应聘管理
              <INPUT  id="CHECKBOX" type="CHECKBOX" NAME="chkRight4" VALUE="1"<%=getCheck(purview.isCompany())%>><!-- onClick="account();"-->
              公司设置</TD>
          </TR>
          <TR>
            <TD COLSPAN="4"> <HR SIZE="1"> </TD>
          </TR>
          <TR>
            <TD width="100" ALIGN="RIGHT"><SPAN >*</SPAN> 用户名&nbsp;</TD>
            <TD COLSPAN="3">
               <% if(member!=null&&member.length()>1){%>
                             <INPUT class="edit_input" TYPE="text" NAME="txtUserNameabcd" MAXLENGTH="20" disabled="disabled" VALUE="<%=member%>">
                                 <input type="hidden" name="txtUserName" value="<%=member%>"/>
<%               }else{
                   %>
    <INPUT class="edit_input" TYPE="text" NAME="txtUserName" MAXLENGTH="20" >;
<%}%>
              <SPAN CLASS="note">20位以内，字母、数字、下划线的组合</SPAN> </TD>
          </TR>
          <TR>
            <TD width="100" ALIGN="RIGHT"><SPAN >*</SPAN> 密码&nbsp;</TD>
            <TD COLSPAN="3"> <INPUT class="edit_input" TYPE="password" NAME="txtPassWord" MAXLENGTH="12" value="<%=getNull(profile.getPassword())%>" >
              <SPAN CLASS="note">3-12位</SPAN> </TD>
          </TR>
          <TR>
            <TD width="100" ALIGN="RIGHT"><SPAN >*</SPAN> 确认密码&nbsp;</TD>
            <TD width="100"> <INPUT class="edit_input" TYPE="password" NAME="txtComfirmPwd" MAXLENGTH="12" value="<%=getNull(profile.getPassword())%>"> </TD>
            <TD width="100" ALIGN="RIGHT">&nbsp;</TD>
            <TD width="100">&nbsp;</TD>
          </TR>
          <TR>
            <TD HEIGHT="50" COLSPAN="4" ALIGN="CENTER"> <INPUT TYPE="hidden" NAME="hiddenCount" VALUE="">
              <INPUT TYPE="hidden" NAME="hiddenSubmit" VALUE="1">
              &nbsp;
              <!--<INPUT name="imageField6" type="image" SRC="/images/btn_cancel.gif" width="60" height="21" border="0">-->
              <input class="edit_button"  type="submit" name="Submit" value="提交">
              <input class="edit_button"  name="reset" type="reset" id="'" value="重置"></TD>
          </TR>
</TABLE>
</FORM>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</BODY>
</html>

