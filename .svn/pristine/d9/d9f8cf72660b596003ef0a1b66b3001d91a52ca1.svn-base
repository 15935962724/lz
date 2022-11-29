<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.entity.admin.orthonline.*"%>
<%@page import="java.util.Date"%>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
TeaSession teasession = new TeaSession(request);

String nexturl = request.getRequestURI()+"?"+request.getQueryString();
StringBuffer sql = new StringBuffer();
StringBuffer param = new StringBuffer();
param.append("?id=").append(request.getParameter("id"));
param.append("&community=").append(teasession._strCommunity);
Date date = new Date();
int ids = 0;
if(teasession.getParameter("ids")!=null && teasession.getParameter("ids").length()>0)
{
  ids = Integer.parseInt(teasession.getParameter("ids"));
}
int bianji=0;
if(teasession.getParameter("bianji")!=null && teasession.getParameter("bianji").length()>0)
{
  bianji = Integer.parseInt(teasession.getParameter("bianji"));
}

CaseCollection ccobj = CaseCollection.find(ids);

int pos = 0, pageSize = 30, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}
sql.append(" order by member asc ");
%>

<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<title>芬必得骨科病例征集</title>
<script type="">
function sub_find2()
{
  if(form1.member.value==null || form1.member.value=="")
  {
    alert("用户名不能为空，请重新填写！");
    form1.member.focus();
    return false;
  }
  if(form1.password.value==null || form1.password.value=="")
  {
    alert("密码不能为空，请重新填写！");
    form1.password.focus();
    return false;
  }
  if(form1.mobilephone.value==null || form1.mobilephone.value=="")
  {
    alert("手机号不能为空，请重新填写！");
    form1.mobilephone.focus();
    return false;
  }else if(form1.mobilephone.value.length!=11)
  {
    alert("请输入正确的手机号，请重新填写！");
     form1.mobilephone.focus();
    return false;
  }
  form1.act.value="updateEditCaseCollection";
  form1.submit();
}

function sub_find()
{
  if(form1.member.value==null || form1.member.value=="")
  {
    alert("用户名不能为空，请重新填写！");
     form1.member.focus();
    return false;
  }
  if(form1.password.value==null || form1.password.value=="")
  {
    alert("密码不能为空，请重新填写！");
         form1.password.focus();
    return false;
  }
  if(form1.firstname.value==null || form1.firstname.value=="")
  {
    alert("姓名不能为空，请重新填写！");
     form1.firstname.focus();
    return false;
  }
  if(form1.address.value==null || form1.address.value=="")
  {
    alert("所在医院不能为空，请重新填写！");
     form1.address.focus();
    return false;
  }
  if(form1.mobilephone.value==null || form1.mobilephone.value=="")
  {
    alert("手机号不能为空，请重新填写！");
       form1.mobilephone.focus();
    return false;
  }else if(form1.mobilephone.value.length!=11)
  {
    alert("请输入正确的手机号，请重新填写！");
      form1.mobilephone.focus();
    return false;
  }
  if(form1.casename.value==null || form1.casename.value=="")
  {
    alert("病例分析标题不能为空，请重新填写！");
        form1.casename.focus();
    return false;
  }
  form1.act.value="EditCaseCollection";
}


function sub_find3()
{  if(form1.firstname.value==null || form1.firstname.value=="")
{
  alert("姓名不能为空，请重新填写！");
    form1.firstname.focus();
  return false;
}
if(form1.address.value==null || form1.address.value=="")
{
  alert("所在医院不能为空，请重新填写！");
   form1.address.focus();
  return false;
}
if(form1.mobilephone.value==null || form1.mobilephone.value=="")
{
  alert("手机号不能为空，请重新填写！");
   form1.mobilephone.focus();
  return false;
}else if(form1.mobilephone.value.length!=11)
{
  alert("请输入正确的手机号，请重新填写！");
     form1.mobilephone.focus();
  return false;
}
if(form1.casename.value==null || form1.casename.value=="")
{
  alert("病例分析标题不能为空，请重新填写！");
   form1.casename.focus();
  return false;
}
form1.act.value="shenhe";
}
function f_xuanze(aa,bb)
{
  window.showModalDialog('/jsp/admin/orthonline/CasePicshow.jsp?ids='+aa+'&str='+bb,self,'edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:857px;dialogHeight:605px;');
}
function being()
{
  var userReg = /^[\u0391-\uFFE5]+$/;
  if(document.form1.member.value=="")
  {
    show.innerHTML="请填写用户名";
    show.style.color='red';
    return false;
  }
  else if (userReg.test(document.form1.member.value))
  {
    window.alert ('不可为汉字！');
    document.form1.member.focus();
    return false;
  }
  var strtt = document.form1.member.value.replace(/[ ]/g,"");
  sendx("/jsp/admin/orthonline/CaseCollection_ajax.jsp?act=cunzai&member="+encodeURIComponent(strtt,"UTF-8"),member_show);
}
function f_showf(vv)
{
//  alert(111111);
//document.form1.sf2.display=block;
  document.getElementById(vv).style.display='block';//
}

function member_show(v)
{
  if(v.indexOf('true')!=-1)
  {
    show.innerHTML="您的用户名还没有被占用，您可以使用！";
    show.style.color='green';
  }else
  {
    show.innerHTML="用户名已存在，如果修改信息请填写密码后点击查看病例，否则请重新输入用户名！";
    show.style.color='red';
  }
}
//function t_change(obj1,obj2)
//{
//  document.getElementById(obj2).innerHTML = document.getElementById(obj1).value.length;
//  if(document.getElementById(obj1).value.length>299)
//  {
//    alert("请勿超过字数限制！");
//  }
//}
</script>
</head>
<body id="bodynone_lzj" >
<h1>芬必得骨科病例征集</h1>
<form action="/servlet/EditCaseCollection" name="form1"  method="POST"  enctype="multipart/form-data"><!--/servlet/EditDoctor-->
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="daid" >
<input type="hidden" name="act" value="EditCaseCollection">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="id" value="<%=request.getParameter("id")%>" >
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter_lzj">
  <TR bgColor=#ffffff>
    <td>
      <div align="right">*用户ID：</div>    </td>

      <td><input  onBlur="being()" class="lzj_hao" size=16 name=member value="<%if(ccobj.getMember()!=null)out.print(ccobj.getMember());%>">   <span id="show" style="margin-left:5px;">用户名由英文、数字组成!</span>  </td>
  </tr>
  <TR bgColor=#ffffff>
    <td>
      <div align="right">*密码：</div>    </td>
      <td><input  type="password" class="lzj_hao" size=16 name=password value="">    <input type=button value=查看或修改我的病例
      <%
      if(ids!=0)
      {
        %>
        onClick="return sub_find();"
        <%
        }else
        {
          %> onClick="return sub_find2();"<%
        }
        %> class="lzj_an1">
        <BR>请填写用户名和密码,用户名是您用来查询或修改病例的唯一方式<BR>如果您想修改已经提交的病例,那么输入用户名和密码后,点击"查看或修改我的病例"即可进行查看或修改      </td>
  </tr>
  <TR bgColor=#ffffff>
    <td>
      <div align="right">*您的姓名：</div>    </td>
      <td><input class="lzj_hao" size=16 name=firstname value="<%if(ccobj.getFirstname()!=null)out.print(ccobj.getFirstname());%>">    </td>
  </tr>
  <TR bgColor=#ffffff>
    <td>
      <div align="right">*所在医院：</div>    </td>
      <td><input id=a1 size=16 name=address value="<%if(ccobj.getAddress()!=null)out.print(ccobj.getAddress());%>">    </td>
  </tr>
  <TR bgColor=#ffffff>
    <td>
      <div align="right">*手机号：
        <input type=hidden value="<%=ids%>" name=ids>
      </div>    </td>
      <td>
        <input name=mobilephone value="<%if(ccobj.getMobilephone()!=null)out.print(ccobj.getMobilephone());%>" class="lzj_hao" mask="float" maxlength="11">      </td>
  </tr>
  <TR bgColor=#ffffff>
    <td>
      <div align="right">*病例分析标题：</div>    </td>
      <td><input id=a1 size=60 name=casename value="<%if(ccobj.getCasename()!=null)out.print(ccobj.getCasename());%>">    </td>
  </tr>

  <TR bgColor=#ffffff>
    <td><div align="right">病例分析：</div></td>
    <td>
    患者性别：
    <%
    for(int i=0;i<CaseCollection.SEXS.length;i++)
    {
      out.print(CaseCollection.SEXS[i]+"<input type=radio value="+i+" name=sex ");
      if(ccobj.getSex()==i)
      {
        out.print("  checked ");
      }
      out.print(">");
    }
    %>
    年龄： <input size=4 name=age  value="<%if(ccobj.getAge()!=null)out.print(ccobj.getAge());%>"  class="lzj_shu1" maxlength="3" mask="float"> 岁</td>
  </tr>
  <TR bgColor=#ffffff>
    <td>
      <div align="right">病史：</div>    </td><!--主诉-->
      <td>
        <TEXTAREA id=a4 name=chief  rows=10 cols=55><%if(ccobj.getChief()!=null)out.print(ccobj.getChief());%></TEXTAREA>

  </tr>


  <TR >
    <td><div align="right">体格检查：</div>    </td>
    <td><TEXTAREA id=a12  name=otheryichang rows=10 cols=55><%if(ccobj.getOtheryichang()!=null)out.print(ccobj.getOtheryichang());%></TEXTAREA>
  </tr>

  <tr>
    <td>
      <div align="right">影像学检查：</div>    </td>
      <td>（请注明何种影像学检查，最好提供影像学资料，如实在没有，可出具结果）<BR>
        <TEXTAREA id=a13 name=yingxiang rows=10 cols=55><%if(ccobj.getYingxiang()!=null)out.print(ccobj.getYingxiang());%> </TEXTAREA>
        <br>
        <input  class="lzj_hao" type="file" name="yxfirstpath" onclick="f_showf('sf2')" /> 图片名称：<input  class="lzj_hao1"  size="6" type="text" name="yxfirstpathname" />上传影像学资料
        <a href="#" onClick="f_xuanze(<%=ids%>,'first')"  style="cursor:pointer"><font color="red">点击查看</font></a><br>

        <div id="sf2"  style="display:none"><input  class="lzj_hao" type="file" name="yxfirstpath2" onclick="f_showf('sf3')" /> 图片名称： <input  class="lzj_hao1"  size="6" type="text" name="yxfirstpathname2" /></div>
        <div id="sf3"   style="display:none"><input  class="lzj_hao" type="file" name="yxfirstpath3" onclick="f_showf('sf4')" /> 图片名称： <input  class="lzj_hao1"  size="6" type="text" name="yxfirstpathname3" /></div>
        <div id="sf4"   style="display:none"><input  class="lzj_hao" type="file" name="yxfirstpath4" onclick="f_showf('sf5')" /> 图片名称： <input  class="lzj_hao1"  size="6" type="text" name="yxfirstpathname4" /></div>
        <div id="sf5"   style="display:none"><input  class="lzj_hao" type="file" name="yxfirstpath5"  /> 图片名称： <input  class="lzj_hao1"  size="6" type="text" name="yxfirstpathname5" /></div>
      </td>
  </tr>
  <TR >
    <td><div align="right">结果：</div></td><!--有异常的实验室检查-->
    <td><BR><TEXTAREA id=a18 name=yichang rows=10 cols=55 ><%if(ccobj.getYichang()!=null)out.print(ccobj.getYichang());%></TEXTAREA>
  </tr>
    <TR >
    <td><div align="right">讨论：</div></td><!--初步诊断-->
    <td>
      <TEXTAREA id=a21   name=chubuzhenduan rows=10 cols=55><%if(ccobj.getChubuzhenduan()!=null)out.print(ccobj.getChubuzhenduan());%></TEXTAREA>
  </tr>
  <TR >
    <td>
      <div align="right">参考文献：</div>    </td><!--诊治经过（如有使用NSAIDs类药物，请注明使用剂量、用法和疗程）-->
      <td><TEXTAREA    id=a22 name=zzjingguo rows=10 cols=55><%if(ccobj.getZzjingguo()!=null)out.print(ccobj.getZzjingguo());%></TEXTAREA>    </td>
  </tr>

   <TR >
    <td>
      <div align="right">补充说明：</div>    </td>
      <td>
      有使用NSAIDs类药物的病例，请注意：<br>
      1．既往史中如有心脑血管病史、胃肠道疾病史或其他特殊病史或服药史请在病例中注明.<br>
      2．在病例中写出NSAIDs类药物的具体剂量、用法和疗程.<br>
      3．治疗前后疼痛的程度：<br>
       &nbsp;&nbsp;治疗前：(无痛)0 1 2 3 4 5 6 7 8 9 10 (极痛)&nbsp;
        <SELECT id=a19 name=gjttnumfrist>
        <%
        for(int i=0;i<CaseCollection.NUM.length;i++)
        {
          out.print("<OPTION value="+i);
          if(ccobj.getGjttnumfrist()==i)
          {
            out.print(" selected ");
          }
          out.print(">"+i+"</OPTION> ");
        }
        %> </SELECT>
        <br>
       &nbsp;&nbsp;治疗后：(无痛)0 1 2 3 4 5 6 7 8 9 10 (极痛)&nbsp;
        <SELECT id=a19 name=gjttnumlast>
        <%
        for(int i=0;i<CaseCollection.NUM.length;i++)
        {
          out.print("<OPTION value="+i);
          if(ccobj.getGjttnumlast()==i)
          {
            out.print(" selected ");
          }
          out.print(">"+i+"</OPTION> ");
        }
        %>
        </SELECT>

      </td>
  </tr>

  <TR >
    <td><div align="right">英雄语录(您执业生涯中的感言)：</div></td>
    <td><TEXTAREA id=a24   name=taolun rows=10 cols=55><%if(ccobj.getTaolun()!=null)out.print(ccobj.getTaolun());%></TEXTAREA> </td>
  </tr>


  <tr>
    <td>&nbsp;</td>
    <td>
    <%
    if(bianji!=0)
    {
      %><input type=submit value=确认审核 name="" class="lzj_an" onClick="return sub_find3()">&nbsp;                                <%
    }
    else
    {
      %><input type=submit value=提交 name="" class="lzj_an" onClick="return sub_find()">&nbsp;                                  <%
    }
    %>
    <input type=button value=返回 name="" class="lzj_an" onClick="window.history.back();">                              </td>
  </tr>
</TABLE>
</FORM>
</body>
</html>
