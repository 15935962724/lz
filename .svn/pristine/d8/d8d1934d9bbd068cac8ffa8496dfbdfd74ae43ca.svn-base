<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
if(!tea.entity.util.Safety.find(teasession._rv.toString(),teasession._strCommunity,5).isExists()&&!teasession._rv.toString().equalsIgnoreCase("admin")&&!License.getInstance().getWebMaster().equals(teasession._rv.toString()))
{
    ts.outText(response,1, "你没有权限,访问本页.");
    return;
}
StringBuffer scriptsb=new StringBuffer();
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
         dbadapter.executeUpdate("INSERT INTO Profile(type,age,member,password)VALUES(0,1,"+dbadapter.cite(member)+","+
         dbadapter.cite(request.getParameter("txtComfirmPwd"))+")");
         dbadapter.executeUpdate("INSERT INTO ProfileLayer(language,member,firstname,email,telephone,job)VALUES(1,"+
         dbadapter.cite(member)+","+
         dbadapter.cite(request.getParameter("txtName"))+","+
       //  dbadapter.cite(request.getParameter("selOrg"))+","+
         dbadapter.cite(request.getParameter("txtEmail"))+","+
         dbadapter.cite(request.getParameter("txtTelephone"))+","+
         dbadapter.cite(request.getParameter("txtWork_Title"))+
         ")");

     }else
     {
         dbadapter.executeUpdate("UPDATE Profile SET password="+ dbadapter.cite(request.getParameter("txtComfirmPwd"))+" WHERE member="+dbadapter.cite(member));
         dbadapter.executeUpdate("UPDATE ProfileLayer SET firstname="+dbadapter.cite(request.getParameter("txtName")) +
       //  ",organization="+ dbadapter.cite(request.getParameter("selOrg"))+
         ",email="+dbadapter.cite(request.getParameter("txtEmail"))+
         ",telephone="+dbadapter.cite(request.getParameter("txtTelephone"))+
         ",job="+dbadapter.cite(request.getParameter("txtWork_Title"))+" WHERE member="+         dbadapter.cite(member));
         Profile._cache.remove(member);
     }
     dbadapter.close();
     tea.entity.site.Subscriber.create(node.getCommunity(),new tea.entity.RV(member,node.getCommunity()),0);
     for(int index=0;index<9;index++)
     {
       tea.entity.util.Safety safety=tea.entity.util.Safety.find(member,teasession._strCommunity,index+1);
       if(request.getParameter("chkRight"+(index+1))!=null||"admin".equals(member))
       {
         if(!safety.isExists())
         safety.create(member,teasession._strCommunity,index+1);
       }else
       safety.delete();
     }
/*
dbadapter.executeUpdate("INSERT INTO Purview(username,company,job,resume,apply,comp)VALUES("+
dbadapter.cite(request.getParameter("txtUserName"))+","+
dbadapter.cite(request.getParameter("selCompanyxx"))+","+request.getParameter("chkRight1")+","+request.getParameter("chkRight2")+","+
request.getParameter("chkRight3")+","+request.getParameter("chkRight4")+")");
*/
//Organizer.create(community, member);//组织者
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
response.sendRedirect("/jsp/21century/Subscribers.jsp");
return;
}
String member=request.getParameter("Member");
boolean bool[]=new boolean[9];
if(member!=null)
{
  for(int index=0;index<bool.length;index++)
  bool[index]=tea.entity.util.Safety.find(member,teasession._strCommunity,index+1).isExists();
}else
for(int index=0;index<bool.length;index++)
bool[index]=false;


r.add("/tea/resource/NetDisk");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
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
	if(!ChkTxt(frm.txtName, "<%=r.getString(teasession._nLanguage, "Name")%>")) return false;
//	if (frm.selOrg.value=='255' || frm.selOrg.value=='-1')	{
//		alert("请选择用户所属的机构！");
//		frm.selOrg.focus();
//		return false;
//	}
	if (!IsMail(frm.txtEmail.value)) {
		alert("<%=r.getString(teasession._nLanguage, "InvalidEmail")%>");
		frm.txtEmail.focus();
		return false;
	}
//	if (frm.selCompany.value=='255' || frm.selCompany.value=='-1')	{
//		alert("请选择用户可以操作的机构！");
//		frm.selCompanyxx.focus();
//		return false;
//	}

	if(!CheckUserName(frm.txtUserName)) return false;
	if(!Chkpwd(frm.txtPassWord,"<%=r.getString(teasession._nLanguage, "Password")%>",12,6)) return false;
	if(!Chkpwd(frm.txtComfirmPwd,"<%=r.getString(teasession._nLanguage, "ConfirmPassword")%>",12,6)) return false;
	if(frm.txtPassWord.value!=frm.txtComfirmPwd.value) {alert('<%=r.getString(teasession._nLanguage, "InvalidConfirmPassword")%>');frm.txtPassWord.select();return false;}
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

function account()
{
    var sum = 0;
    var count = document.frmInsertUser.chkRights.length;
    for(var i = 0; i <= count - 1; i++)
    {
        if (document.frmInsertUser.chkRights[i].checked)
        {
            sum += parseInt(document.frmInsertUser.chkRights[i].value);
        }
    }
    document.frmInsertUser.hiddenCount.value = sum;
}
</SCRIPT>
</head>
<BODY>
<h1><%=r.getString(teasession._nLanguage, "NetDiskNewUser")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

  <FORM NAME="frmInsertUser" METHOD="post" onSubmit="javascript:return chkit();">
    <%
        if(member==null)
        {
            member="";
        }else
        out.print("<input type=hidden name=edit value=on />");
        Purview purview=Purview.find(member,node.getCommunity());
        Profile profile=Profile.find(member);
        %>

<TABLE border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <TR>
      <TD COLSPAN="4">新增用户</TD>
    </TR>
    <TR>
      <TD COLSPAN="4"><SPAN >* 必须填写</SPAN></TD>
    </TR>
    <TR>
      <TD align="right"><SPAN >*</SPAN> 姓名 &nbsp;</TD>
      <TD><INPUT TYPE="text" class="edit_input" NAME="txtName" MAXLENGTH="50" VALUE="">
      </TD>
      <%--   <TD ALIGN="RIGHT"><SPAN >* </SPAN>所在机构&nbsp;</TD>
            <TD> <SELECT NAME="selOrg" STYLE="width:172px">
<%
java.util.Enumeration enumeration=tea.entity.node.Node.findByType(21,community);
int nodeCode;
while(enumeration.hasMoreElements())
{
   nodeCode =((Integer)enumeration.nextElement()).intValue();
   String strTempSubject=tea.entity.node.Node.find(nodeCode).getSubject(1);
%>
<OPTION VALUE="<%=nodeCode%>"<%=getSelect(strTempSubject.equals(profile.getOrganization(1)))%>><%=strTempSubject%></OPTION>
<%}%>
</SELECT>
        </TD>
          </TR>--%>
    <TR>
      <TD ALIGN="RIGHT"><SPAN >*</SPAN> E-mail&nbsp;</TD>
      <TD><INPUT TYPE="text" class="edit_input" NAME="txtEmail" MAXLENGTH="120" VALUE="">
      </TD>
      <TD ALIGN="RIGHT"><%=r.getString(teasession._nLanguage, "Telephone")%>&nbsp;</TD>
      <TD><INPUT TYPE="text" class="edit_input" NAME="txtTelephone" MAXLENGTH="40" VALUE="">
      </TD>
    </TR>
    <TR>
      <TD ALIGN="RIGHT"><%=r.getString(teasession._nLanguage, "Job")%>&nbsp;</TD>
      <TD><INPUT TYPE="text" class="edit_input" NAME="txtWork_Title" MAXLENGTH="60" VALUE="">
      </TD>
      <TD ALIGN="RIGHT">&nbsp;</TD>
      <TD>&nbsp;</TD>
    </TR>
    <TR>
      <TD COLSPAN="4"><HR SIZE="1">
      </TD>
    </TR>
    <TR>
      <TD COLSPAN="4"><SPAN >*</SPAN> 管辖授权</TD>
    </TR>
    <TR>
      <TD ALIGN="RIGHT">权限</TD>
      <TD COLSPAN="3"><INPUT  id="CHECKBOX" type="CHECKBOX" NAME="chkRight1" VALUE="1" <%=getCheck(bool[1-1])%>>
        <%=r.getString(teasession._nLanguage, "Download")%>
        <INPUT  id="CHECKBOX" type="CHECKBOX" NAME="chkRight2" VALUE="2" <%=getCheck(bool[2-1])%>>
        <%=r.getString(teasession._nLanguage, "New")%>
        <INPUT  id="CHECKBOX" type="CHECKBOX" NAME="chkRight3" VALUE="3" <%=getCheck(bool[3-1])%>>
        <%=r.getString(teasession._nLanguage, "Delete")%>
        <INPUT  id="CHECKBOX" type="CHECKBOX" NAME="chkRight4" VALUE="4" <%=getCheck(bool[4-1])%>>
        报名表审核
        <INPUT  id="CHECKBOX" type="CHECKBOX" NAME="chkRight5" VALUE="5" <%=getCheck(bool[5-1])%>>
        用户管理
        <INPUT  id="CHECKBOX" type="CHECKBOX" NAME="chkRight6" VALUE="6" <%=getCheck(bool[6-1])%>>
        报名表管理
        <INPUT  id="CHECKBOX" type="CHECKBOX" NAME="chkRight7" VALUE="7" <%=getCheck(bool[7-1])%>>
        议题管理
        <INPUT  id="CHECKBOX" type="CHECKBOX" NAME="chkRight8" VALUE="8" <%=getCheck(bool[8-1])%>>
        上传文件管理
        <INPUT  id="CHECKBOX" type="CHECKBOX" NAME="chkRight9" VALUE="9" <%=getCheck(bool[9-1])%>>
        对外文件管理 </TD>
    </TR>
    <TR>
      <TD COLSPAN="4"><HR SIZE="1">
      </TD>
    </TR>
    <TR>
      <TD ALIGN="RIGHT"><SPAN >*</SPAN> 用户名&nbsp;</TD>
      <TD COLSPAN="3"><% if(member!=null&&member.length()>1){%>
        <INPUT class="edit_input" TYPE="text" NAME="txtUserNameabcd" MAXLENGTH="20" disabled="disabled" VALUE="">
        <input type="hidden" name="txtUserName" value="<%=member%>"/>
        <%               }else{
                   %>
        <INPUT class="edit_input" TYPE="text" NAME="txtUserName" MAXLENGTH="20" >
        <%}%>
        <SPAN CLASS="note">20位以内，字母、数字、下划线的组合</SPAN> </TD>
    </TR>
    <TR>
      <TD ALIGN="RIGHT"><SPAN >*</SPAN> <%=r.getString(teasession._nLanguage, "Password")%>&nbsp;</TD>
      <TD COLSPAN="3"><INPUT class="edit_input" TYPE="password" NAME="txtPassWord" MAXLENGTH="12" value="<%=getNull(profile.getPassword())%>" >
        <SPAN CLASS="note">3-12位</SPAN> </TD>
    </TR>
    <TR>
      <TD ALIGN="RIGHT"><SPAN >*</SPAN> <%=r.getString(teasession._nLanguage, "ConfirmPassword")%>&nbsp;</TD>
      <TD><INPUT class="edit_input" TYPE="password" NAME="txtComfirmPwd" MAXLENGTH="12" value="<%=getNull(profile.getPassword())%>">
      </TD>
      <TD ALIGN="RIGHT">&nbsp;</TD>
      <TD>&nbsp;</TD>
    </TR>
    <TR>
      <TD COLSPAN="4" ALIGN="CENTER"><INPUT TYPE="hidden" NAME="hiddenCount"  VALUE="">
        <INPUT TYPE="hidden" NAME="hiddenSubmit" VALUE="1">
        <!--<INPUT name="imageField6" type="image" SRC="/images/btn_cancel.gif" width="60" height="21" border="0">-->
        <input class="edit_button"  type="submit" name="Submit" value="<%=r.getString(teasession._nLanguage, "Submit")%>">
        <input class="edit_button"  name="reset" type="reset" id="'" value="<%=r.getString(teasession._nLanguage, "Reset")%>"></TD>
    </TR>
</TABLE>
  </FORM>
  
  <script>  document.all['txtName'].focus();   <%if("admin".equals(member))out.print("for(var counter=0;counter<frmInsertUser.elements.length;counter++)        if(frmInsertUser.elements[counter].type==\"checkbox\"){  frmInsertUser.elements[counter].checked=true;       frmInsertUser.elements[counter].disabled=true;     }");%>   </script>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</BODY>
</html>

