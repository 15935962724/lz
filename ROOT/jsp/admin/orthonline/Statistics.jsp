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
if (teasession._rv == null) {
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}


tea.entity.site.Community community = tea.entity.site.Community.find(teasession._strCommunity);
//判断管理员的权限
String member =teasession._rv.toString();
Doctoradmin daobj = Doctoradmin.find(Doctoradmin.isMemberDaid(teasession._strCommunity,member));
AdminRole arobj = AdminRole.find(daobj.getDatype());
boolean fs = false,fs2=false,fs3=false;

StringBuffer sql =new StringBuffer();
StringBuffer param =new StringBuffer();
//所属省市

int sheng=0;
if(teasession.getParameter("sheng")!=null && teasession.getParameter("sheng").length()>0)
{
  sheng = Integer.parseInt(teasession.getParameter("sheng"));
}
if(daobj.getSheng()>0)
{
  sheng= daobj.getSheng();
  fs = true;
}
if(sheng>0)
{
  sql.append(" AND sheng = ").append(sheng);
  param.append("&sheng=").append(sheng);
      fs3=true;

}
int shi=0;
if(teasession.getParameter("shi")!=null && teasession.getParameter("shi").length()>0)
{
  shi = Integer.parseInt(teasession.getParameter("shi"));
}

if(daobj.getShi()>0)
{
  shi = daobj.getShi();
  fs2 = true;


}
//医院级别
String yyjibie = teasession.getParameter("yyjibie");

//技术职称
int jishuzhicheng1=0;
if(teasession.getParameter("jishuzhicheng1")!=null&& teasession.getParameter("jishuzhicheng1").length()>0)
{
  jishuzhicheng1= Integer.parseInt(teasession.getParameter("jishuzhicheng1"));

}

int jishuzhicheng2=0;
if(teasession.getParameter("jishuzhicheng2")!=null&& teasession.getParameter("jishuzhicheng2").length()>0)
{
  jishuzhicheng2= Integer.parseInt(teasession.getParameter("jishuzhicheng2"));

}
int jishuzhicheng3=0;
if(teasession.getParameter("jishuzhicheng3")!=null&& teasession.getParameter("jishuzhicheng3").length()>0)
{
  jishuzhicheng3= Integer.parseInt(teasession.getParameter("jishuzhicheng3"));

}
if(shi>0)
{
  sql.append(" AND ").append(" shi = ").append(shi);
  param.append("&shi=").append(shi);
      fs3=true;
}
if(yyjibie!=null&& yyjibie.length()>0)
{
  sql.append(" AND yyjibie=").append(DbAdapter.cite(yyjibie));
  param.append("&yyjibie=").append(java.net.URLEncoder.encode(yyjibie,"UTF-8"));
      fs3=true;
}

if(jishuzhicheng1>0)
{
  sql.append(" AND jishuzhicheng1=").append(jishuzhicheng1);
  param.append("&jishuzhicheng1=").append(jishuzhicheng1);
      fs3=true;
}


if(jishuzhicheng2>0)
{
  sql.append(" AND jishuzhicheng2=").append(jishuzhicheng2);
  param.append("&jishuzhicheng2=").append(jishuzhicheng2);
      fs3=true;
}

if(jishuzhicheng3>0)
{
  sql.append(" AND jishuzhicheng3=").append(jishuzhicheng3);
  param.append("&jishuzhicheng3=").append(jishuzhicheng3);
      fs3=true;
}

//专业方向
int zhuanyefangxiang1=0;
if(teasession.getParameter("zhuanyefangxiang1")!=null&& teasession.getParameter("zhuanyefangxiang1").length()>0)
{
  zhuanyefangxiang1= Integer.parseInt(teasession.getParameter("zhuanyefangxiang1"));

}
if(zhuanyefangxiang1>0)
{
  sql.append(" AND zhuanyefangxiang1=").append(zhuanyefangxiang1);
  param.append("&zhuanyefangxiang1=").append(zhuanyefangxiang1);
   fs3=true;
}


int zhuanyefangxiang2=0;
if(teasession.getParameter("zhuanyefangxiang2")!=null&& teasession.getParameter("zhuanyefangxiang2").length()>0)
{
  zhuanyefangxiang2= Integer.parseInt(teasession.getParameter("zhuanyefangxiang2"));

}
if(zhuanyefangxiang2>0)
{
  sql.append(" AND zhuanyefangxiang2=").append(zhuanyefangxiang2);
  param.append("&zhuanyefangxiang2=").append(zhuanyefangxiang2);
  fs3=true;
}


int zhuanyefangxiang3=0;
if(teasession.getParameter("zhuanyefangxiang3")!=null&& teasession.getParameter("zhuanyefangxiang3").length()>0)
{
  zhuanyefangxiang3= Integer.parseInt(teasession.getParameter("zhuanyefangxiang3"));

}
if(zhuanyefangxiang3>0)
{
  sql.append(" AND zhuanyefangxiang3=").append(zhuanyefangxiang3);
  param.append("&zhuanyefangxiang3=").append(zhuanyefangxiang3);
   fs3=true;
}

String yyxingzhi = teasession.getParameter("yyxingzhi");
if(yyxingzhi!=null && yyxingzhi.length()>0)
{
  sql.append(" AND yyxingzhi = ").append(DbAdapter.cite(yyxingzhi));
  param.append("&yyxingzhi=").append(java.net.URLEncoder.encode(yyxingzhi,"UTF-8"));
    fs3=true;
}

int count = Doctor.count(teasession._strCommunity,sql.toString());
%>

<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<title>医生统计</title>
</head>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
<body id="bodynone" onLoad="f_sheng('<%=shi%>','<%=fs2%>');" >
<script>
//所属省市
 function f_sheng(igd,bool){
         sendx("/jsp/admin/orthonline/city_ajax.jsp?bool="+bool+"&doid=0&shiid="+igd+"&act=city&sheng="+form1.sheng.value,
         function(data)
         {
           document.getElementById("show").innerHTML=data;
         }
         );
 }
 function f_shi()
 {}

//控制右键
function stop(){
return false;
}
document.oncontextmenu=stop;
//控制选择文本
var omitformtags=["input", "textarea", "select"]

omitformtags=omitformtags.join("|")

function disableselect(e){
if (omitformtags.indexOf(e.target.tagName.toLowerCase())==-1)
return false
}

function reEnable(){
return true
}

if (typeof document.onselectstart!="undefined")
document.onselectstart=new Function ("return false")
else{
document.onmousedown=disableselect
document.onmouseup=reEnable
}
</script>
<h1>医生统计</h1>
<div id="head6"><img height="6" src="about:blank"></div>
 <h2>查询&nbsp;(&nbsp;统计范围登记医师总数&nbsp;<font color="#000000" size="3"><%=count%></font>&nbsp;位&nbsp;)</h2>
  <form action="?" name="form1"  method="POST">
    <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
   <input type="hidden" name="id" value="<%=request.getParameter("id")%>" >
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter" class="xiaoliclass">
  <tr>
    <td nowrap>所属省市:</td>
     <td nowrap>
      <select name="sheng" onChange="f_sheng('0','<%=fs2%>');" <%if(fs)out.print(" disabled");%>>
          <option value="0">请选择省份/直辖市</option>
          <%
          java.util.Enumeration e2 = Provinces.find(" AND type=0 ");
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
        <span id="show">
        <select name="shi">
          <option value="0">请选择市/县</option>
        </select>
       </span>
     </td>
     <td nowrap>医院级别</td>
     <td nowrap>
       <select name="yyjibie"  >
         <option value="">请选择医院级别</option>
         <option value="三甲" <%if("三甲".equals(yyjibie))out.print(" selected");%>>三甲</option>
         <option value="三乙" <%if("三乙".equals(yyjibie))out.print(" selected");%>>三乙</option>
         <option value="二甲" <%if("二甲".equals(yyjibie))out.print(" selected");%>>二甲</option>
         <option value="二乙" <%if("二乙".equals(yyjibie))out.print(" selected");%>>二乙</option>
         <option value="未评级" <%if("未评级".equals(yyjibie))out.print(" selected");%>>未评级</option>
       </select>
     </td>
     </tr>
     <tr>

     <td nowrap>技术职称</td>
     <td nowrap>
      职称1&nbsp;
      <select name="jishuzhicheng1">
        <option value="0">--请选择职称1--</option>
        <%
        for(int i =1;i<Doctor.JISHU_ZHICHENG.length;i++)
        {
          out.print("<option value="+i);
          if(jishuzhicheng1==i)
          {
            out.print(" selected ");
          }
          out.print(">"+Doctor.JISHU_ZHICHENG[i]);
          out.print("</option>");
        }
        %>
        </select>
        &nbsp;&nbsp;职称2&nbsp;
        <select name="jishuzhicheng2">
          <option value="0">--请选择职称2--</option>
          <%
          for(int i =1;i<Doctor.JISHU_ZHICHENG.length;i++)
          {
            out.print("<option value="+i);
            if(jishuzhicheng2==i)
            {
              out.print(" selected ");
            }
            out.print(">"+Doctor.JISHU_ZHICHENG[i]);
            out.print("</option>");
          }
          %>
          </select>
          &nbsp;&nbsp;职称3&nbsp;
          <select name="jishuzhicheng3">
            <option value="0">--请选择职称3--</option>
            <%
            for(int i =1;i<Doctor.JISHU_ZHICHENG.length;i++)
            {
              out.print("<option value="+i);
              if(jishuzhicheng3==i)
              {
                out.print(" selected ");
              }
              out.print(">"+Doctor.JISHU_ZHICHENG[i]);
              out.print("</option>");
            }
            %>
            </select>
     </td>
      <td nowrap >专业方向</td>
      <td nowrap>
        <span id="zhuanye1">第一专业<select name="zhuanyefangxiang1">
          <option value="0">请选择第一专业</option>
         <%
            for(int i =1;i<Doctor.ZHUANYE_FANGXIANG.length;i++)
            {
              out.print("<option value="+i);
              if(zhuanyefangxiang1==i)
              {
                out.print(" selected");
              }
              out.print(">"+Doctor.ZHUANYE_FANGXIANG[i]);
              out.print("</option>");
            }
         %>
        </select></span>
        <span id="zhuanye1">&nbsp;&nbsp;第二专业<select name="zhuanyefangxiang2">
          <option value="0">请选择第二专业</option>
          <%
          for(int i =1;i<Doctor.ZHUANYE_FANGXIANG.length;i++)
          {
            out.print("<option value="+i);
               if(zhuanyefangxiang2==i)
              {
                out.print(" selected");
              }
            out.print(">"+Doctor.ZHUANYE_FANGXIANG[i]);
            out.print("</option>");
          }
          %>
        </select></span>

        <span id="zhuanye1">&nbsp;&nbsp;第三专业<select name="zhuanyefangxiang3">
          <option value="0">请选择第三专业</option>
          <%
          for(int i =1;i<Doctor.ZHUANYE_FANGXIANG.length;i++)
          {
            out.print("<option value="+i);
               if(zhuanyefangxiang3==i)
              {
                out.print(" selected");
              }
            out.print(">"+Doctor.ZHUANYE_FANGXIANG[i]);
            out.print("</option>");
          }
          %>
          </select>
</span>
      </td>
      </tr>
      <tr>
      <td nowrap>医院性质</td>
      <td>
      <select name="yyxingzhi" >
          <option value="">请选择医院性质</option>
            <option value="部队"  <%if("部队".equals(yyxingzhi))out.print(" selected ");%> >部队</option>
          <option value="公立"  <%if("公立".equals(yyxingzhi))out.print(" selected ");%> >公立</option>
          <option value="民营" <%if("民营".equals(yyxingzhi))out.print(" selected ");%> >民营</option>
        </select>
      </td>
      <td><input type="submit" value="查询" ></td>
      </tr>

  </tr>
  </table>
</form>
<%
if(fs3){
  out.print("<h3>您统计的范围是：");
  //省
  if(sheng>0)
  {
    Provinces pobj = Provinces.find(sheng);
    out.print("所属省市&nbsp;");
    out.print("<span id = xlsize>"+pobj.getProvincity()+"</span>&nbsp;");
  }
  //市
  if(shi>0)
  {
    Provinces pobj2= Provinces.find(shi);
    out.print("<span id = xlsize>"+pobj2.getProvincity()+"</span>&nbsp;");
  }
  //医院级别
  if(yyjibie!=null && yyjibie.length()>0)
  {
    out.print("医院级别&nbsp;");
    out.print("<span id = xlsize>"+yyjibie+"</span>&nbsp;");
  }
  //医院性质
  if(yyxingzhi!=null && yyxingzhi.length()>0)
  {
    out.print("医院性质&nbsp;");
    out.print("<span id = xlsize>"+yyxingzhi+"</span>&nbsp;");
  }
  //技术职称
  if(jishuzhicheng1>0||jishuzhicheng2>0||jishuzhicheng3>0)
  {
    out.print("技术职称&nbsp;");
  }
  if(jishuzhicheng1>0)
  {
    out.print("职称1&nbsp;");
    out.print("<span id = xlsize>"+Doctor.JISHU_ZHICHENG[jishuzhicheng1] +"</span>&nbsp;");
  }
  if(jishuzhicheng2>0)
  {
    out.print("职称2&nbsp;");
    out.print("<span id = xlsize>"+Doctor.JISHU_ZHICHENG[jishuzhicheng2] +"</span>&nbsp;");
  }
  if(jishuzhicheng3>0)
  {
    out.print("职称3&nbsp;");
    out.print("<span id = xlsize>"+Doctor.JISHU_ZHICHENG[jishuzhicheng3] +"</span>&nbsp;");
  }
  // 专业方向

  if(zhuanyefangxiang1>0||zhuanyefangxiang2>0||zhuanyefangxiang3>0)
  {
    out.print("专业方向&nbsp;");
  }
  if(zhuanyefangxiang1>0)
  {
    out.print("第一专业&nbsp;");
    out.print("<span id = xlsize>"+Doctor.ZHUANYE_FANGXIANG[zhuanyefangxiang1] +"</span>&nbsp;");
  }
  if(zhuanyefangxiang2>0)
  {
    out.print("第二专业&nbsp;");
    out.print("<span id = xlsize>"+Doctor.ZHUANYE_FANGXIANG[zhuanyefangxiang2] +"</span>&nbsp;");
  }
  if(zhuanyefangxiang3>0)
  {
    out.print("第三专业&nbsp;");
    out.print("<span id = xlsize>"+Doctor.ZHUANYE_FANGXIANG[zhuanyefangxiang3] +"</span>&nbsp;");
  }
  out.print("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href =\"#\" onClick=\"javascript:history.back()\">返回</a>");
  out.print("</h3>");
}
%>


  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter" class="xiaoliclass">
    <tr id="tableonetr">
      <td nowrap class="shengshi">按省市</td>
      <td  nowrap class="lzj_jb">医院级别</td>
      <td nowrap class="lzj_jb1">医院性质</td>
      <td  nowrap class="jishuclass">技术职称</td>
      <td nowrap class="zyclass">专业方向</td>
    </tr>
    <tr valign="top">
      <td id="lzj_ss"><%=Doctor.getArrsheng(teasession._strCommunity,teasession._rv.toString(),1,sql.toString(),param.toString(),sheng,shi) %></td>
      <td id="lzj_yy"><%=Doctor.getArrsheng(teasession._strCommunity,teasession._rv.toString(),2,sql.toString(),param.toString(),sheng,shi) %></td>
       <td id="lzj_xz"><%=Doctor.getArrsheng(teasession._strCommunity,teasession._rv.toString(),9,sql.toString(),param.toString(),sheng,shi) %></td>
       <td>
       <table border="0" cellpadding="0" cellspacing="0" id="zhichengtable">
        <tr>
          <td nowrap="nowrap" align="center">职称1</td>
          <td nowrap="nowrap" align="center">职称2</td>
          <td nowrap="nowrap" align="center">职称3</td>
        </tr>
        <tr valign="top">
          <td><%=Doctor.getArrsheng(teasession._strCommunity,teasession._rv.toString(),3,sql.toString(),param.toString(),sheng,shi) %></td>
          <td><%=Doctor.getArrsheng(teasession._strCommunity,teasession._rv.toString(),4,sql.toString(),param.toString(),sheng,shi) %></td>
          <td><%=Doctor.getArrsheng(teasession._strCommunity,teasession._rv.toString(),5,sql.toString(),param.toString(),sheng,shi) %></td>
        </tr>
      </table>
      </td>
      <td>

          <table border="0" cellpadding="0" cellspacing="0" id="zhichengtable">
            <tr>
              <td nowrap="nowrap" align="center">第一专业</td>
              <td nowrap="nowrap" align="center">第二专业</td>
              <td nowrap="nowrap" align="center">第三专业</td>
            </tr>
            <tr valign="top">
              <td><%=Doctor.getArrsheng(teasession._strCommunity,teasession._rv.toString(),6,sql.toString(),param.toString(),sheng,shi) %></td>
              <td><%=Doctor.getArrsheng(teasession._strCommunity,teasession._rv.toString(),7,sql.toString(),param.toString(),sheng,shi) %></td>
              <td><%=Doctor.getArrsheng(teasession._strCommunity,teasession._rv.toString(),8,sql.toString(),param.toString(),sheng,shi) %></td>
            </tr>

          </table>

</td>

    </tr>
</table>


  <div id="head6"><img height="6" src="about:blank"></div>
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
</body>
</html>
