<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%
Job job=Job.find(teasession._nNode,teasession._nLanguage);
String email=getNull(Classified.find(job.getSltOrgId()).getEmail(teasession._nLanguage));
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
<head>
<title>申请职位</title>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script language="javascript">
<!--
      function CoverLetter_Click(letterID,LetterCount)
      {
        for (var i=1;i<=LetterCount;i++)
        {
          if (i == letterID)  //当前项
          {
            document.all["Lable"+i.toString()].style.fontWeight = "bold";
            document.all["TDLetter"+i.toString()].style.backgroundImage = "url('/Images/button_01.gif')";
          }
          else //其他
          {
            document.all["Lable"+i.toString()].style.fontWeight = "normal";
            document.all["TDLetter"+i.toString()].style.backgroundImage = "url('/Images/button_02.gif')";
          }
          document.all.txtLetter.value = document.all["Hidden"+letterID].value.replace(/&lt;/g,"<").replace(/&gt;/g,">").replace(/&quot;/g,"\"").replace(/&amp;/g,"&");
        }

      }

      function CheckLoginInput()
      {
        with (document.frmApply)
        {
          if (userName.value == "")
          {
            document.all("UserNameErr").innerHTML = "<font color='red'>请输入用户名！</font>";
            return false;
          }
          if (password.value == "")
          {
            document.all("PasswordErr").innerHTML = "<font color='red'>请输入密码！</font>";
            return false;
          }
        }
      }

      function IsSubmit()
      {
        if (canApply)
        {
          canApply = false;
          return true;
        }
        else
          return false;
      }

	    function CheckCVSelect()
	    {
		    var CheckBoxList;
		    var IsCheck = false;
		    CheckBoxList = document.all.tags("input")
		    for(i=0;i<CheckBoxList.length;i++)
		    {
			    if(CheckBoxList[i].name.substring(0,6)=="cbLang" && CheckBoxList[i].checked)
			    {IsCheck = true};
		    }
	      if(!IsCheck)
			    {window.alert("请至少选择一份简历！");return false }
		    else
		    {
		      //return Sure_onsubmit();
		      //canApply=false;
		    }
	    }

      function CVPreview()
      {
        var strUrl;
        var CheckBoxList;
		    var IsCheck = false;
		    CheckBoxList = document.all.tags("input")
		    for(i=0;i<CheckBoxList.length;i++)
		    {
			    if(CheckBoxList[i].name.substring(0,6)=="cbLang" && CheckBoxList[i].checked)
			    {IsCheck = true};
		    }
	      if(!IsCheck)
			  {
			    window.alert("请至少选择一份简历！");
			    return false;
			  }
        var objCV1=document.all['rbCvTitle1'];
        var objCV1Cn=document.all['cbLang1Cn'];
        var objCV1En=document.all['cbLang1En'];
        if(objCV1!=null)
        {
            if (objCV1.disabled == false && objCV1.checked == true) //可用且选中
            {
                strUrl = "cvid=" + '4000000000918272';
                if (objCV1Cn != null && objCV1Cn.checked == true && objCV1En != null && objCV1En.checked == true)
                {
                  strUrl += "&lang=2";
                }
                else
                {
                    if (objCV1Cn != null && objCV1Cn.checked == true)
                    {
                      strUrl += "&lang=0";
                    }
                    if (objCV1En != null && objCV1En.checked == true)
                    {
                      strUrl += "&lang=1";
                    }
                }
            }
        }
        var objCV2=document.all['rbCvTitle2'];
        var objCV2Cn=document.all['cbLang2Cn'];
        var objCV2En=document.all['cbLang2En'];
        if(objCV2!=null)
        {
            if (objCV2.disabled == false && objCV2.checked == true) //可用且选中
            {
                strUrl = "cvid=" + '';
                if (objCV2Cn != null && objCV2Cn.checked == true && objCV2En != null && objCV2En.checked == true)
                {
                  strUrl += "&lang=2";
                }
                else
                {
                    if (objCV2Cn != null && objCV2Cn.checked == true)
                    {
                      strUrl += "&lang=0";
                    }
                    if (objCV2En != null && objCV2En.checked == true)
                    {
                      strUrl += "&lang=1";
                    }
                }
            }
        }
       //alert(strUrl);
       window.open ('CVPreview.aspx?' + strUrl, '', 'toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=700,height=500');
      }
      var canApply = true;
      //-->


     function fselect()
      {
          form1.submit.disabled="";
      }
            </script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></head>
<BODY leftMargin="0" topMargin="0" MARGINHEIGHT="0" MARGINWIDTH="0">
<DIV ID="edit_BodyDiv">
<table  border="0"  class="section" cellpadding="0" cellspacing="0">
          <tr id="TableCaption">
            <td valign="top">申请职位</td>
          </tr>
          <tr>
            <td valign="top">
  <TABLE   cellSpacing="1" cellPadding="0"  align="center" bgColor="#666666" border="0">
    <TR bgcolor="#FFFFFF" >

            <TD colspan="2" align="right"><div align="left"><span class="tit">你要申请的职位如下 　　　　　　　　　　　　　　　　　　　

			<A class="linktit" href="/servlet/Talkbacks?node=15545" target="_blank">有问题点击此处</A></span></div></TD>
          </TR>
          <TR bgcolor="#FFFFFF">
            <TD width="98" align="right"><STRONG>公司名称：</STRONG></TD>
            <TD><SPAN class="alert"> <span id="lblMemName" class="alert"><%=tea.entity.node.Node.find(job.getSltOrgId()).getSubject(teasession._nLanguage)%></span> </SPAN></TD>
          </TR>
          <TR bgcolor="#FFFFFF">
            <TD width="98" align="right"><STRONG>职位名称：</STRONG></TD>
            <TD><SPAN class="alert"> <span id="lblJobTitle" class="alert"><%=job.getName()%></span> </SPAN></TD>
          </TR>
          <TR bgcolor="#FFFFFF">
            <TD width="98" align="right"><STRONG>职业类别：</STRONG></TD>
            <TD> <span id="lblJobLoc"><%=job.getSltOccId("&nbsp")%> </span></TD>
          </TR><%--
          <TR bgcolor="#FFFFFF">
            <TD width="98" align="right"><STRONG> <span id="Emaillabel">E-mail：</span></STRONG></TD>
            <TD> <span id="lblJobEmail"><a href='mailto:<%out.println(email);//job.getEmail()%>'>
              <%out.println(email);//job.getEmail()%>
            </a></span></TD>
          </TR>--%>
        </TABLE></TD>
    </TR>
  </TABLE>
<br/>
<!--没有填写简历的提示-->
<table border="0" cellpadding="0" cellspacing="0">
  <tr>
    <TD> <%
                          String strapply=request.getParameter("apply");
                          if(strapply!=null&&strapply.equals("ON")){%>
      <TABLE cellSpacing="1" cellPadding="3"  align="center" bgColor="#cccccc" border="0">
        <TR>
          <TD bgColor="#ffffff"> <P style="TEXT-JUSTIFY: inter-ideograph; TEXT-ALIGN: justify"><IMG height="25" hspace="6" SRC="/images/success.gif" width="25" align="absMiddle" vspace="3"> <span id="lblSaveJobTips"><SPAN CLASS='tit'><STRONG>申请职位成功！</STRONG></SPAN>该职位已经存入<A href='/jsp/type/job/AppHistory.jsp'>已申请职位</A>记录。　　</span></P></TD>
        </TR>
      </TABLE>
      <%}else
                              if(strapply!=null&&strapply.equals("ERR")){%>
      <DIV align="center"> <span id="lblApplyInfo">你已经申请过该职位，不必再次投递简历,或你已经用本简历申请三个职位了.查看<a href='/jsp/type/job/AppHistory.jsp'>申请记录</a></span></DIV>
      <% }else{%>
      <form action="/servlet/EditApply" name="form1">
        <table  border="0"  class="section" cellpadding="0" cellspacing="0">
          <tr id="TableCaption">
            <td valign="top">我的简历</td>
          </tr>
          <tr>
            <td valign="top">
			 <table width="461" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#cbcbcb">
                <tr align="center" valign="middle" bgcolor="#ffffff">
                  <td>选择简历</td>
                  <td>简历名</td>
                  <td width="70">预览/打印</td>
                  <td width="41">修改</td>
                  <td width="41">删除</td>
                  <td width="41">状态</td>
                  <td width="70">更新时间</td>
                </tr>

                  <%
Resume summary=null;
java.util.Enumeration enumeration=Resume.getNode(teasession._rv.toString(),1);
int nodecode;
while(enumeration.hasMoreElements()){
    nodecode=((Integer)enumeration.nextElement()).intValue();
    summary=Resume.find(nodecode,teasession._nLanguage);
    boolean boolfull =(summary.getExperience()==0||Employment.find(nodecode,teasession._nLanguage).hasMoreElements())&&Educate.find(nodecode,teasession._nLanguage).hasMoreElements();
%>  <tr bgcolor="#ffffff">
                  <td>

                      <input  id="radio" type="radio" name="resumenode" onclick="fselect()" value="<%=nodecode%>"                      <%if(!boolfull)out.print(" disabled=disabled ");%>>
                      </td>
                  <td> &nbsp;&nbsp;<span class="hilite"><%=summary.getName()%></span> </td>
                  <td align="center"> <a href='/jsp/type/resume/Preview.jsp?node=<%=nodecode%>' target="_blank"> <img SRC="/images/sign_04.gif" width="18" height="17" border="0" alt="预览/打印简历" /></a></td>
                  <td align="center"> <a href='/jsp/type/resume/EditResume.jsp?node=<%=nodecode%>'> <img SRC="/images/sign_05.gif" width="16" height="17" border="0" alt="修改简历" /></a></td>
                  <td align="center"> <img name="Repeater1:_ctl1:ImageBtnDel1" id="Repeater1__ctl1_ImageBtnDel1" onclick="if(confirm('这份简历的中文版本将被删除。确定要删除吗？'))window.open('/servlet/DeleteResume?node=<%=nodecode%>&Language=1','_self');" SRC="/images/sign_07.gif" alt="删除简历" border="0" /></td>
                  <td align="center">
                      <%
              if(boolfull)
              {
                  out.println("完整");
              }else
              out.println("不完整");
              %>
                      <!--<a href='/jsp/type/resume/SendResume.jsp' target="_blank"> <img SRC="/images/sign_08.gif" width="24" height="17" border="0" alt="发送简历" /></a>-->
                  </td>
                  <td align="center"><%=node.getTime("yyyy-MM-dd")%></td>
                </tr>
                <%}%>
                <tr bgcolor="#ffffff" >
                  <td></td>
                  <td colspan="6">&nbsp;&nbsp;
                    <input class="edit_button" type="button" name="btnCn" value="创建新简历"  onClick='javascript:window.location="/jsp/type/resume/EditResume.jsp?NewNode=ON&Type=52&TypeAlias=0&node=15484&nexturl=<%=request.getRequestURI()+"?"+request.getQueryString()%>"'> </td>
                </tr>
              </table>
              <br>              </td>
          </tr>
        </table>
        <%if(summary!=null){%>
        <input class="edit_button" name="submit" type=submit disabled="disabled" value="用选中的简历申请该职位">
        <%}else{%>
        请先创建简历
        <%}      %>
      </form></TD>
  </tr>
</table>

<%}%>
<span id="lblSaveJobTips">
<div align="center"><input type="submit" class="edit_button" name="btnSaveAndNext2" value="关闭" onclick="javaScript:window.close(); " language="javascript"  /></div>
</span></div>
</BODY>
</html>

