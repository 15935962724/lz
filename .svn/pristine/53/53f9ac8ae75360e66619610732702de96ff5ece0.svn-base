<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.util.*" %>
<%@page import="tea.db.DbAdapter"%><%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.cio.*" %><%@ page import="tea.ui.TeaSession" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String menuid=request.getParameter("id");
String nexturl=request.getParameter("nexturl");

String member=teasession._rv._strV;
//member="0152";

int ciocompany;
String tmp=request.getParameter("ciocompany");
if(tmp!=null&&member.equals("admin"))
{
  ciocompany=Integer.parseInt(tmp);
}else
{
  ciocompany=CioCompany.findByMember(member);
}
//if(ciocompany<1)
//{
//  response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("你不是代表","UTF-8"));
//  return;
//}


CioCompany cc=CioCompany.find(ciocompany);
String name=cc.getName();
String contact=cc.getContact();
String tel=cc.getTel();
String mobile=cc.getMobile();
String email=cc.getEmail();
String remark=cc.getRemark();
String attach[]=cc.getAttach();
String invoice=cc.getInvoice();

StringBuilder sql=new StringBuilder();


Resource r=new Resource();

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="">
function f_submit()
{
  if(submitText(form1.name,'无效-参会企业（集团）名称')&&submitText(form1.contact,'无效-参会联系人')&&submitText(form1.tel,'无效-联系人电话')&&submitText(form1.mobile,'无效-联系人手机')&&submitEmail(form1.email,'无效-E-Mail'))
  {
    form1.bs.value="正在提交中...";
    form1.bs.disabled=true;
    return true;
  }
  return false;
}
function f_radio(obj)
{
  var id=obj.id.substring(1);
  for(var i=0;i<2;i++)
  {
    document.getElementById(""+i+id).checked=false;
  }
  obj.checked=true;
}
function f_submit3()
{
  //if(submitText(form1.name,'无效-参会企业（集团）名称')&&submitText(form1.contact,'无效-参会联系人')&&submitText(form1.tel,'无效-联系人电话')&&submitText(form1.mobile,'无效-联系人手机')&&submitEmail(form1.email,'无效-E-Mail'))
  {
    form3.bs.value="正在提交中...";
    form3.bs.disabled=true;
    return true;
  }
  return false;
}
</script>
</head>
<body id="qiyelog">
<div id="qiyelog_01">
<div id="qiyelog_02">
<div id="title_01"></div>
<div class="toubu_xx">
<h1>参会报名表<div class="tishi">——输入正确的真实的信息。点击下面相应的项展开后操作</div></h1>
</div>
<div id="head6"><img height="6" src="about:blank"></div>
<iframe src="about:blank" name="dialog" style="display:none"></iframe>
<form name="form1" action="/servlet/EditCioCompany" method="post" enctype="multipart/form-data" target="dialog" onSubmit="return f_submit();">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="ciocompany" value="<%=ciocompany%>"/>
<input type="hidden" name="act" value="edit"/>

<h2>参会企业信息</h2>
<div id="qiy_xx">
<table border="0" cellpadding="0" cellspacing="0" id="qiy_xx_table">
  <tr>
    <td nowrap colspan="3">参会企业（集团）名称：<span id="table_tesspan"><input type="text" name="name" value="<%if(name!=null)out.print(name);%>" size="50" <%if(ciocompany>0)out.print(" readonly='readonly' ");%>> *</span></td>
  </tr>
  <tr>
    <td colspan="3">中央企业，系统息动填写；地方企业，由填报人填写。</td>
  </tr>
  <tr>
    <td id="td_01">参会联系人：<input type="text" name="contact" value="<%if(contact!=null)out.print(contact);%>"> *</td>
      <td id="td_02">联系人电话：<input type="text" name="tel" value="<%if(tel!=null)out.print(tel);%>" mask="tel"> *</td>
        <td id="td_03">&nbsp;</td>
  </tr>
  <tr>
    <td id="td_01">联系人手机：<input type="text" name="mobile" value="<%if(mobile!=null)out.print(mobile);%>" mask="int"> *</td>
      <td id="td_02">E-Mail：<input type="text" name="email" class="email" value="<%if(email!=null)out.print(email);%>"> *</td>
        <td id="td_03">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="3"><div style="float:left;width:122px;">本企业关心的问题：<br/>(字数不限)</div><div style="float:left"><textarea name="remark" cols="50" rows="5"><%if(remark!=null)out.print(remark);%></textarea></div></td>
  </tr>
  <tr>
    <td colspan="3" >上传参会相关文件：<%
      out.print("<input type='hidden' name='delattach' value='/' />");
      for(int i=0;i<50;i++)
      {
        out.print("<input type='file' name='attach"+i+"' onchange='f_add(this,"+i+");'");
        if(i>0)out.print(" style='display:none'");
        out.print(" />");
      }
      out.print("<div id='filelist'>");
      for(int i=0;i<attach.length;i++)
      {
        int j=attach[i].lastIndexOf('/')+1;
        String aname=attach[i].substring(j);
        String ex=aname.substring(aname.lastIndexOf('.')+1).toLowerCase();
        out.print("<span id='filespan_"+i+"'><a href='/jsp/include/DownFile.jsp?uri="+java.net.URLEncoder.encode(attach[i],"UTF-8")+"&name="+java.net.URLEncoder.encode(aname,"UTF-8")+"'><img src='/tea/image/netdisk/"+ex+".gif' align='top' />"+aname+"</a><a href=javascript:f_del('_"+i+"')><img src='/tea/image/public/del2.gif'/></a>　</span>");
      }
      out.print("</div>");
      %>
      <div style="padding-left:113px;line-height:150%;color:#B04B00;">如发言稿等,格式不限,可以是PPT,DOC,图片等,如多个文件请压缩<br/>打包上传.</div>
    </td>
  </tr>
  <tr>
    <td nowrap colspan="3">开具发票单位名称：<span id="table_tesspan"><input type="text" name="invoice" value="<%if(invoice!=null)out.print(invoice);%>" size="50"></span></td>
  </tr>
</table>
<script type="">
function f_add(file,i)
{
  var fl=document.getElementById("filelist");
  var name=file.value;
  var j=name.lastIndexOf('\\')+1;
  if(j!=-1)
  {
    name=name.substring(j);
    var ex=name.substring(name.lastIndexOf('.')+1).toLowerCase();
    var h="<span id='filespan"+i+"'><img src='/tea/image/netdisk/"+ex+".gif'/>"+name+"<a href='javascript:f_del("+i+")'><img src='/tea/image/public/del2.gif'/></a>　</span>";
    fl.innerHTML+=h;
    file.style.display="none";
    document.all("attach"+(i+1)).style.display="";
  }
}
function f_del(i)
{
  if(confirm("确认删除?"))
  {
    var fs=document.getElementById("filespan"+i);
    fs.style.display="none";
    var file=document.all("attach"+i);
    if(file)
    {
      file.disabled=true;
    }else
    {
      document.all("delattach").value+=i.substring(1)+"/";
    }
  }
}
</script>
<input name="bs" type="submit" value="提交"/>
</div>
</form>
<!--///////////////////////////////////////////////////////////////////////////////////////////////////////////////-->

<h2>参会人员信息</h2>
<div id="canh_ry">
<iframe id="ifcp" src="/jsp/cio/EditCioPart.jsp?community=<%=teasession._strCommunity%>&ciocompany=<%=ciocompany%>&ciopart=0" width="596" height="330" frameborder="0" scrolling="no"></iframe>
</div>


<!--///////////////////////////////////////////////////////////////////////////////////////////////////////////////-->
<h2>问卷调查</h2>
<form name="form3" action="/servlet/EditCioPoll" method="post" target="dialog" onSubmit="return f_submit3();">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="ciocompany" value="<%=ciocompany%>"/>
<input type="hidden" name="act" value="edit"/>
<div id="wenj_dc">
 <div  class="canhbm_xx2">请填写贵企业各应用系统的软件供应商并评价软件性价比</div>
<table id="wenj_dc_table">
  <tr id="wenj_dc_table_tr">
    <td>应用系统</td>
    <td>软件供应商</td>
    <td>软件性价比评价</td>
  </tr>
<%
CioPoll cp=CioPoll.find(ciocompany);
String choose[]=cp.getChoose();
int score[]=cp.getScore();
StringBuilder js3=new StringBuilder();
for(int i=0;i<CioPoll.CHOOSE_TYPE.length;i++)
{
  out.print("<tr><td>"+CioPoll.CHOOSE_TYPE[i]+"</td><td><input type='text' name='choose'");
  if(choose[i]!=null)out.print(" value=\""+choose[i]+"\"");
  out.print("></td>");
  //
  out.print("<td><input type='checkbox' name='score' value='0' id='0"+i+"' onclick='f_radio(this);'");
  if(score[i]==0)out.print(" checked='true'");
  out.print("><label for='0"+i+"'>好</label>");
  //
  out.print("<input type='checkbox' name='score' value='1' id='1"+i+"' onclick='f_radio(this);'");
  if(score[i]==1)out.print(" checked='true'");
  out.print("><label for='1"+i+"'>一般</label></td></tr>");
  //
  js3.append("&&submitText(form3.choose["+i+"],'无效-"+CioPoll.CHOOSE_TYPE[i]+" 软件供应商')");
}
%>
</table>
</div>
<input type="submit" name="bs" value="提交" onClick="return true<%=js3.toString()%>"/>
</form>


<div class="feichang">
说明:<br/>
带*号项为必填,请认真填写真实信息,<br/>
提交成功后,我们会把参会回执发送到企业联系人邮箱中，注意查收.</div>
<input type="button" id="tijiao_canhb" value="" onClick="window.open('/jsp/cio/EditCioCompanySuccess.jsp?ciocompany=<%=ciocompany%>','_self');"/>
<div class="lianx_xx">电话：010-63192334 Email:webmaster@sasac.gov,cn 国资委总机：010-63192000</div>
<div id="head6"><img height="6" src="about:blank"></div>
</div>
<div class="banq_xx">管理维护：国资委信息中心　　　　国资委地址：北京市宣武西大街26号（10053）京ICP备030066号</div>
</div>
</body>
</html>
