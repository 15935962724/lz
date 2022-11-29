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


String nexturl = request.getRequestURI()+"?"+request.getQueryString();
StringBuffer sql = new StringBuffer();
StringBuffer param = new StringBuffer();
param.append("?id=").append(request.getParameter("id"));
param.append("&community=").append(teasession._strCommunity);
//判断管理员的权限
String member =teasession._rv.toString();
Doctoradmin daobj = Doctoradmin.find(Doctoradmin.isMemberDaid(teasession._strCommunity,member));
AdminRole arobj = AdminRole.find(daobj.getDatype());
boolean fs = false,fs2=false,fs3=false,yiyuanfs=false;
//医生名称
String xingming=teasession.getParameter("xingming");
if(xingming!=null && xingming.length()>0)
{
  xingming = xingming.trim();
  sql.append(" AND xingming LIKE ").append(DbAdapter.cite("%"+xingming+"%"));
  param.append("&xingming=").append(java.net.URLEncoder.encode(xingming,"UTF-8"));
  fs3=true;
}
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
if(shi>0)
{
  sql.append(" AND shi = ").append(shi);
  param.append("&shi=").append(shi);
  fs3=true;
}
//工作单位
String gongzuodanwei = teasession.getParameter("gongzuodanwei");
if(daobj.getYiyuan()>0)
{
  Hospital h = Hospital.find(daobj.getYiyuan());
  gongzuodanwei = h.getHoname();
  yiyuanfs = true;
}
if(gongzuodanwei!=null && gongzuodanwei.length()>0)
{
  //如果是医院统计里面点击进来的 则用 ”= “ 否则 用 LIKE
  String ls = "  LIKE  "+DbAdapter.cite("%"+gongzuodanwei+"%");
  if("DoctorRanking".equals(teasession.getParameter("act")))//医院统计页面来的参数 用 =
  {
    ls =" = "+DbAdapter.cite(gongzuodanwei);
  }
  gongzuodanwei =gongzuodanwei.trim();
  sql.append(" AND gongzuodanwei in (SELECT hoid FROM Hospital WHERE honame  "+ls+"   ) ");
  param.append("&gongzuodanwei=").append(java.net.URLEncoder.encode(gongzuodanwei,"UTF-8"));
  fs3=true;
}
//有效证件号
String youxiaozhengjianhao = teasession.getParameter("youxiaozhengjianhao");
if(youxiaozhengjianhao!=null && youxiaozhengjianhao.length()>0)
{
  sql.append(" AND youxiaozhengjianhao LIKE "+DbAdapter.cite("%"+youxiaozhengjianhao+"%")+" ");
  param.append("&youxiaozhengjianhao=").append(youxiaozhengjianhao);
  fs3=true;
}
//医院级别
String yyjibie = teasession.getParameter("yyjibie");
if(yyjibie!=null&&yyjibie.length()>0)
{

  yyjibie = yyjibie.trim();
  sql.append(" AND yyjibie =").append(DbAdapter.cite(yyjibie));
  param.append("&yyjibie=").append(java.net.URLEncoder.encode(yyjibie,"UTF-8"));
  fs3=true;
}
//技术职称1
int jishuzhicheng1 = 0;
if(teasession.getParameter("jishuzhicheng1")!=null&& teasession.getParameter("jishuzhicheng1").length()>0)
{
  jishuzhicheng1 = Integer.parseInt(teasession.getParameter("jishuzhicheng1"));
}
if(jishuzhicheng1>0)
{
  sql.append(" AND jishuzhicheng1 = ").append(jishuzhicheng1);
  param.append("&jishuzhicheng1=").append(jishuzhicheng1);
  fs3=true;
}
//技术职称2
int jishuzhicheng2 = 0;
if(teasession.getParameter("jishuzhicheng2")!=null&& teasession.getParameter("jishuzhicheng2").length()>0)
{
  jishuzhicheng2 = Integer.parseInt(teasession.getParameter("jishuzhicheng2"));
}
if(jishuzhicheng2>0)
{
  sql.append(" AND jishuzhicheng2 = ").append(jishuzhicheng2);
  param.append("&jishuzhicheng2=").append(jishuzhicheng2);
  fs3=true;
}
//技术职称3
int jishuzhicheng3 = 0;
if(teasession.getParameter("jishuzhicheng3")!=null&& teasession.getParameter("jishuzhicheng3").length()>0)
{
  jishuzhicheng3 = Integer.parseInt(teasession.getParameter("jishuzhicheng3"));
}
if(jishuzhicheng3>0)
{
  sql.append(" AND jishuzhicheng3 = ").append(jishuzhicheng3);
  param.append("&jishuzhicheng3=").append(jishuzhicheng3);
  fs3=true;
}

//zhuanyefangxiang1
//专业方向1
int zhuanyefangxiang1 = 0;
if(teasession.getParameter("zhuanyefangxiang1")!=null&& teasession.getParameter("zhuanyefangxiang1").length()>0)
{
  zhuanyefangxiang1 = Integer.parseInt(teasession.getParameter("zhuanyefangxiang1"));
}
if(zhuanyefangxiang1>0)
{
  sql.append(" AND zhuanyefangxiang1 = ").append(zhuanyefangxiang1);
  param.append("&zhuanyefangxiang1=").append(zhuanyefangxiang1);
  fs3=true;
}
//专业方向2
int zhuanyefangxiang2 = 0;
if(teasession.getParameter("zhuanyefangxiang2")!=null&& teasession.getParameter("zhuanyefangxiang2").length()>0)
{
  zhuanyefangxiang2 = Integer.parseInt(teasession.getParameter("zhuanyefangxiang2"));
}
if(zhuanyefangxiang2>0)
{
  sql.append(" AND zhuanyefangxiang2 = ").append(zhuanyefangxiang2);
  param.append("&zhuanyefangxiang2=").append(zhuanyefangxiang2);
  fs3=true;
}
//专业方向3
int zhuanyefangxiang3 = 0;
if(teasession.getParameter("zhuanyefangxiang3")!=null&& teasession.getParameter("zhuanyefangxiang3").length()>0)
{
  zhuanyefangxiang3 = Integer.parseInt(teasession.getParameter("zhuanyefangxiang3"));
}
if(zhuanyefangxiang3>0)
{
  sql.append(" AND zhuanyefangxiang3 = ").append(zhuanyefangxiang3);
  param.append("&zhuanyefangxiang3=").append(zhuanyefangxiang3);
  fs3=true;
}
//医院性质
String yyxingzhi = teasession.getParameter("yyxingzhi");
if(yyxingzhi!=null && yyxingzhi.length()>0)
{
  sql.append(" AND yyxingzhi = ").append(DbAdapter.cite(yyxingzhi));
  param.append("&yyxingzhi=").append(java.net.URLEncoder.encode(yyxingzhi,"UTF-8"));
  fs3=true;
}





int pos = 0, pageSize = 30, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}
count = Doctor.count(teasession._strCommunity,sql.toString());
tea.entity.site.Community community = tea.entity.site.Community.find(teasession._strCommunity);

sql.append(" order by times desc ");

%>

<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<title>医生信息统计</title>
</head>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
<body id="bodynone" onload="f_sheng('<%=shi%>','<%=fs2%>');" >
<script>
function f_edit(igd)
{
  form1.doid.value=igd;
  form1.action='/jsp/admin/orthonline/EditDoctor.jsp'
  form1.submit();
}
function f_delete(igd)
{
  if(confirm('您确定要删除此内容吗？')){
    form1.doid.value=igd;
    form1.act.value='delete';
    form1.action='/servlet/EditDoctor'
    form1.submit();
  }
}
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
//医生登记表管理

//查看详细
function f_c(igd)
{
  var y ='edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:1357px;dialogHeight:905px;';
  var url = '/jsp/admin/orthonline/DoctorShow2.jsp?doid='+igd;
  window.showModalDialog(url,self,y);
}



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
<h1>医生信息统计</h1>
<div id="head6"><img height="6" src="about:blank"></div>
  <h2>查询&nbsp;&nbsp;&nbsp;&nbsp;您目前是:<%if(arobj.getName()!=null)out.print(arobj.getName()); %></h2>
  <form action="?" name="form1"  method="GET"><!--/servlet/EditDoctor-->
  <input type="hidden" name="nexturl" value="<%=nexturl%>"/>
  <input type="hidden" name="doid" >
  <input type="hidden" name="act">
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
  <input type="hidden" name="repository" value="GeRenZhaoPian"/>
  <input type="hidden" name="id" value="<%=request.getParameter("id")%>" >
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td>医生姓名:</td>
      <td><input type="text" name="xingming" value="<%if(xingming!=null)out.print(xingming);%>"/></td>
        <td>所属省市:</td>
        <td colspan="2">
          <select name="sheng" onchange="f_sheng('0','<%=fs2%>');" <%if(fs)out.print(" disabled");%>>
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
    </tr>
    <tr>

      <td>技术职称(职称1)</td>
      <td>
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
      </td>
      <td>工作单位:</td>
      <td colspan="2"><input type="text"  name="gongzuodanwei" value="<%if(gongzuodanwei!=null)out.print(gongzuodanwei);%>" <%if(yiyuanfs)out.print(" disabled");%>></td>
    </tr>
    <tr>
      <td>证件号码:</td>
      <td><input type="text" name="youxiaozhengjianhao" value="<%if(youxiaozhengjianhao!=null)out.print(youxiaozhengjianhao);%>"/></td>
      <td>医院级别：</td>
      <td>
       <select name="yyjibie">
          <option value="">请选择医院级别</option>
          <option value="三甲" <%if("三甲".equals(yyjibie))out.print(" selected");%>>三甲</option>
          <option value="三乙" <%if("三乙".equals(yyjibie))out.print(" selected");%>>三乙</option>
          <option value="二甲" <%if("二甲".equals(yyjibie))out.print(" selected");%>>二甲</option>
          <option value="二乙" <%if("二乙".equals(yyjibie))out.print(" selected");%>>二乙</option>
          <option value="未评级" <%if("未评级".equals(yyjibie))out.print(" selected");%>>未评级</option>
        </select>
      </td>
        <td><input type="submit" value="查询"/></td>
    </tr>
    <tr>

    </tr>
  </table>

  <h2>列表&nbsp;(&nbsp;目前共有&nbsp;<font color="#000000" size="3"><%=count%></font>&nbsp;位登记的医生&nbsp;)</h2>
  <%
  if(fs3){
    out.print("<h3>您搜索的范围是：");
    //医生姓名
    if(xingming!=null && xingming.length()>0)
    {
      out.print("医生姓名&nbsp;");
      out.print("<span id = xlsize>"+xingming+"</span>&nbsp;");
    }
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
    //工作单位
    if(gongzuodanwei!=null && gongzuodanwei.length()>0)
    {
      out.print("工作单位&nbsp;");
      out.print("<span id= xlsize>"+gongzuodanwei+"</span>");
    }
    //有效证件号
    if(youxiaozhengjianhao!=null && youxiaozhengjianhao.length()>0)
    {
      out.print("有效证件号&nbsp;");
      out.print("<span id = xlsize>"+youxiaozhengjianhao+"</span>&nbsp;");
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
    out.print("</h3>");
  }
  %>

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id="tableonetr">
      <td nowrap>序号</td>
      <td nowrap>医生姓名</td>
      <td nowrap>省/直辖市</td>
      <td nowrap>市县</td>
      <td nowrap>工作单位</td>
      <td nowrap>行政职务</td>
      <td nowrap>技术职称</td>
      <td nowrap>添加时间</td>
      <td nowrap>操作</td>
    </tr>
    <%

    java.util.Enumeration  e = Doctor.find(teasession._strCommunity,sql.toString(),pos,pageSize);
    if(!e.hasMoreElements())
    {
      out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
    }
    int j = count;
    for(int i =1;e.hasMoreElements();i++)
    {
      int doid =((Integer)e.nextElement()).intValue();
      Doctor doobj= Doctor.find(doid);
      Provinces pobj = Provinces.find(doobj.getSheng());
      Provinces pobj2 = Provinces.find(doobj.getShi());
      Hospital hobj = Hospital.find(doobj.getGongzuodanwei());
      // hobj.setQuantity(hobj.getQuantity()+1);
      %>
      <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
        <td><%=j-pos %></td>
        <td><a href="#"  onclick="f_c('<%=doid%>');"><%=doobj.getXingming()%></a></td>
        <td><%=pobj.getProvincity() %></td>
        <td><%=pobj2.getProvincity() %></td>
        <td ><%
          if(doobj.getGongzuodanwei2s()==1){out.print(doobj.getGongzuodanwei2());}else if(hobj.getHoname()!=null){out.print(hobj.getHoname());}%></td>
          <td nowrap><%out.print(Doctor.XINGZHENG_ZHICHENG[doobj.getXingzhengzhicheng()]+"&nbsp;"+Doctor.XINGZHENG_ZHICHENG[doobj.getXingzhengzhicheng2()]); %></td>
          <td nowrap><%out.print(Doctor.JISHU_ZHICHENG[doobj.getJishuzhicheng1()]+"&nbsp;"+Doctor.JISHU_ZHICHENG[doobj.getJishuzhicheng2()]+"&nbsp;"+Doctor.JISHU_ZHICHENG[doobj.getJishuzhicheng3()]);%></td>
          <td nowrap><%=doobj.getTimesToString()%></td>
          <td nowrap><a href="#" onclick="f_edit('<%=doid%>');">编辑</a>&nbsp;<a href="#" onclick="f_delete('<%=doid%>');">删除</a></td>
      </tr>
      <%j--;} %>
      <%if (count > pageSize) {  %>
      <tr> <td colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
      <%}  %>
  </table>

  <input type="button" value="添加医生" onclick="window.open('/jsp/admin/orthonline/EditDoctor.jsp?community=<%=teasession._strCommunity%>&nexturl=<%=nexturl%>','_self');"/>
  </form>


  <div id="head6"><img height="6" src="about:blank"></div>
    <SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
</body>
</html>
