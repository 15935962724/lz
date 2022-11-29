<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.admin.orthonline.*"%>
<%@page import="java.util.Date"%>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
TeaSession teasession = new TeaSession(request);
if (teasession._rv == null) {
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}
String nexturl = teasession.getParameter("nexturl");
String community =teasession.getParameter("community");



int daid = 0;
if(teasession.getParameter("daid")!=null && teasession.getParameter("daid").length()>0)
{
  daid = Integer.parseInt(teasession.getParameter("daid"));
}
Doctoradmin daobj = Doctoradmin.find(daid);
Hospital hobj = Hospital.find(daobj.getYiyuan());
Provinces pobj1=Provinces.find(daobj.getSheng());
Provinces pobj2=Provinces.find(daobj.getShi());
String membername =null,pw=null;
String members =teasession._rv.toString();
if(daobj.getMember()!=null && daobj.getMember().length()>0){
  Profile p = Profile.find(daobj.getMember());
  membername = p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage);
  pw= p.getPassword();
  members = daobj.getMember();
}


//判断管理员的权限
Doctoradmin daobjs_c = Doctoradmin.find(Doctoradmin.isMemberDaid(teasession._strCommunity,teasession._rv.toString()));

Doctoradmin daobjs = Doctoradmin.find(Doctoradmin.isMemberDaid(teasession._strCommunity,members));
boolean fs = false;
boolean fs2 = false;

//管理员级别
int datype=0;
if(daobjs.getDatype()>0)
{
  datype = daobjs.getDatype();
  fs = true;
}

//省
int sheng = 0;
if(daobjs.getSheng()>0)
{
  sheng = daobjs.getSheng();
  fs = true;
}
//市
int shi = 0;
if(daobjs.getShi()>0)
{
  shi = daobjs.getShi();
  fs2 = true;
}

if(daobjs_c.getDatype()==366||daobjs_c.getDatype()==373)
{
  fs = false;
  fs2=false;
  if(daobjs_c.getDatype()==373&&daid==0)
  {
    datype=0;
  }

}
%>

<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<title>设置管理员权限</title>
</head>
<body id="bodynone"  onload="f_load();" >
<script>
function f_load()
{
  f_sheng('<%=shi%>','<%=fs2%>');
  f_hidden();
}
function f_sheng(igd,bool){
  sendx("/jsp/admin/orthonline/city_ajax.jsp?bool="+bool+"&act=city&shiid="+igd+"&sheng="+form1.sheng.value,
  function(data)
  {
    document.getElementById("show").innerHTML=data;
  }
  );
}
function f_shi(){}
//判断管理员账户
function f_member()
{
  sendx("/jsp/admin/orthonline/city_ajax.jsp?act=member&community="+form1.community.value+"&member="+form1.members.value,
  function(data)
  {
    if(data.trim().length>0)
    {
      alert(data);
      form1.members.focus();
      form1.submitname.disabled=true;
    }else
    {
      form1.submitname.disabled=false;
    }
    //document.getElementById("show").innerHTML=data;
  }
  );
}
//查找医院
function f_yiyuan()
{
  var rs = window.showModalDialog('/jsp/admin/orthonline/Hospital.jsp?id='+form1.id.value+'&community='+form1.community.value,self,'edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:857px;dialogHeight:605px;');
  if(rs!=null){
    form1.yiyuanid.value= rs.split("/")[1];
    form1.yiyuan.value= rs.split("/")[2];
  }
}
//查找用户
function f_lookupmember()
{
  var rs = window.showModalDialog('/jsp/admin/orthonline/LookupMember.jsp?time='+(new Date()).getTime()+'&id='+form1.id.value+'&community='+form1.community.value,self,'edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:857px;dialogHeight:605px;');
  if(rs!=null){
    form1.member.value= rs.split("/")[1];
    form1.members.value= rs.split("/")[1];
    form1.membername.value= rs.split("/")[2];
    form1.paw.value= rs.split("/")[3];
   // form1.qpaw.value= rs.split("/")[3];
    form1.members.disabled=true;
  }
}

function f_submit()
{
  if(form1.membername.value=='')
  {
    alert('姓名不能为空');
    form1.membername.focus();
    return false;
  }
  if(form1.members.value=='')
  {
    alert('管理员账号不能为空');
    form1.members.focus();
    return false;
  }

  if(form1.paw.value=='')
  {
    alert('密码不能为空');
    form1.paw.focus();
    return false;
  }
//  if(form1.paw.value!=form1.qpaw.value)
//  {
//    alert('密码和确认密码不一致');
//    form1.paw.focus();
//    return false;
//  }

  if(form1.datype.value==0)
  {
    alert('管理员级别不能为空');
    form1.datype.focus();
    return false;
  }
  if(form1.datype.value==367&&form1.sheng.value==0)
  {
    alert('请选择省份/直辖市');
    form1.sheng.focus();
    return false;
  }
  if(form1.datype.value==368&&form1.sheng.value==0)
  {
    alert('请选择省份/直辖市');
    form1.sheng.focus();
    return false;
  }
  if(form1.datype.value==368&&form1.shi.value==0)
  {
    alert('请选择市/县');
    form1.shi.focus();
    return false;
  }
    if(form1.datype.value==369&&form1.yiyuan.value=='')
  {
    alert('医院不能为空');
    form1.yiyuan.focus();
    return false;
  }
}
function f_c()
{
  form1.yiyuan.value='';
  form1.yiyuanid.value=0;
}
function f_hidden()
{
  var igd = form1.datype.value;
  var sheng=document.getElementById("shengid");
  var shi=document.getElementById("shiid");
  var yiyuan=document.getElementById("yiyuanid2");
  if(igd==366||igd == 373)
  {
    // sheng.style.display='block';
    sheng.style.display='none';
    shi.style.display='none';
    yiyuan.style.display='none';
    form1.sheng.value='0';
    form1.shi.value='0';
    form1.yiyuan.value='';
    form1.yiyuanid.value='0';
  } else if(igd==367)
  {
    sheng.style.display='block';
    shi.style.display='none';
    yiyuan.style.display='none';
    form1.shi.value='<%=shi%>';
    form1.yiyuan.value='';
    form1.yiyuanid.value='0';
  } else if(igd==368)
  {
    sheng.style.display='block';
    shi.style.display='block';
    yiyuan.style.display='none';
    form1.yiyuan.value='';
    form1.yiyuanid.value='0';
  }else if(igd == 369)
  {
    sheng.style.display='none';
    shi.style.display='none';
    yiyuan.style.display='block';
    form1.sheng.value='<%=sheng%>';
    form1.shi.value='<%=shi%>';

  }else
  {
    sheng.style.display='block';
    shi.style.display='block';
    yiyuan.style.display='block';
  }
}
</script>
<h1>设置管理员权限</h1>
<div id="head6"><img height="6" src="about:blank"></div>
  <form action="/servlet/EditDoctoradmin" name="form1"  method="POST" onsubmit="return f_submit();"><!--/servlet/EditDoctor-->
  <input type="hidden" name="community" value="<%=community%>"/>
  <input type="hidden" name="nexturl" value="<%=nexturl%>"/>
  <input type="hidden" name="daid" value="<%=daid%>"/>
  <input type="hidden" name="yiyuanid" value="<%=daobj.getYiyuan()%>"/>
  <input type="hidden" name="id" value="<%=request.getParameter("id")%>"/>
  <input type="hidden" name="act" value="EditDoctoradmin"/>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

    <tr>
      <td>管理员账号:</td>
      <td>

          <input type="text" name="members" value="<%if(daobj.getMember()!=null)out.print(daobj.getMember());%>"  onchange="f_member();"  <%if(daid>0){out.print(" disabled");}%>>&nbsp;
          <input type="button" value="查找已有用户" onclick="f_lookupmember();"/>
          <input type="hidden" name="member" value="<%if(daobj.getMember()!=null)out.print(daobj.getMember());%>">

      </td>
    </tr>


    <tr>
      <td>管理员姓名:</td>
      <td><input type="text" name="membername" value="<%if(membername!=null)out.print(membername);%>"/></td>
    </tr>
    <tr>
      <td>管理员密码:</td>
      <td><input type="text" name="paw" value="<%if(pw!=null&&pw.length()>0)out.print(pw); %>"/></td>
    </tr>
    <!--<tr>
      <td>确认密码:</td>
      <td><input type="text" name="qpaw" value="<%if(pw!=null&&pw.length()>0)out.print(pw); %>"/></td>
    </tr>-->
    <tr>
      <td>管理员级别:</td>
      <td>
        <select name="datype" onchange="f_hidden();"  >
          <option value="0" >---请选择管理员级别---</option>
          <%if(daobjs_c.getDatype()==366){ %>
          <option value=366 <%  if(datype==366){out.print(" selected ");}%>>1级,超级管理员</option>
          <%} %>
          <%if(daobjs_c.getDatype()==366||daobjs_c.getDatype()==373){ %>
              <option value=373 <%  if(datype==373){out.print(" selected ");}%>>1级,管理员</option>
          <%} %>
          <%
          if(datype!=368||daobjs_c.getDatype()==366||daobjs_c.getDatype()==373){
          %>
            <option value=367 <%  if(datype==367){out.print(" selected ");}%>>2级,省份级管理员</option>
            <%}%>
          <option value=368 <%  if(datype==368){out.print(" selected ");}%>>3级,市县级管理员</option>
          <option value=369 <%  if(datype==369){out.print(" selected ");}%>>4级,大型医院管理员</option>
        </select>
      </td>
    </tr>

      <tr  id ="shengid">
        <td>管理省份:</td>
        <td>
          <select name="sheng" onchange="f_sheng('0','<%=fs2%>');"  <%if(fs)out.print(" disabled");%>>
            <option value="0">请选择省份/直辖市</option>
            <%
            java.util.Enumeration e2 = Provinces.find(" AND type=0 ORDER BY provincity ASC ");
            while(e2.hasMoreElements())
            {
              int proid = ((Integer)e2.nextElement()).intValue();
              Provinces pobj = Provinces.find(proid);
              out.print("<option value="+proid);
              if(sheng==proid)
              {
                out.print(" selected");
              }
              out.print(">"+pobj.getProvincity());
              out.print("</option>");
            }
            %>
            </select>
        </td>
      </tr>
      <tr id ="shiid">
        <td>管理市/县:</td>
        <td>
          <span id="show">
            <select name="shi">
              <option value="0">请选择市/县</option>
            </select>
          </span>
        </td>
      </tr>
      <tr id ="yiyuanid2">
        <td>管理医院:</td>
        <td>
          <input type="text" name="yiyuan" readonly value="<%if(hobj.getHoname()!=null)out.print(hobj.getHoname());%>"/>&nbsp;
          <input type="button" value="重填" onclick="f_c();"/>
          <input type="button" value="查找医院" onclick="f_yiyuan();">
        </td>
      </tr>
  </table>
  <input type="submit" name="submitname" value="添加管理员权限"/>&nbsp;&nbsp;

   <input type="button" value="返回" onclick="window.open('/jsp/admin/orthonline/Doctoradmin.jsp?community=<%=teasession._strCommunity%>','_self');"/>
  </form>

  <div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
