<%@page import="tea.entity.yl.shopnew.ReplyMoney"%>
<%@page import="tea.entity.admin.AdminFunction"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.yl.shop.*"%><%@page import="tea.entity.member.Profile"%>
<%@page import="tea.entity.admin.AdminUsrRole"%>
<%@ page import="util.Config" %>
<%@ page import="java.math.BigDecimal" %>
<%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

if(h.isIllegal())
{
  out.println("非法操作！");
  return;
}

int menu=h.getInt("id");

StringBuffer sql=new StringBuffer(),par=new StringBuffer();
Integer puid = Config.getInt(h.get("puid"));
//int puid1 = h.getInt("puid1");

if(puid != null) {
    sql.append(" and r.puid=" + puid);
    par.append("&puid=" + h.get("puid"));
//    puid1=puid;
}
String h_code = h.get("h_code");
if(h_code != null && !h_code.equals("")){
    sql.append(" and h.h_code=" + h_code);
    par.append("& h.h_code=" + h_code);
}

/*
if(puid1 > 0){
    sql.append(" and puid="+puid1);
}
*/

par.append("?id="+menu);

String code=h.get("code","");
if(code.length()>0)
{
  sql.append(" AND code LIKE "+Database.cite("%"+code+"%"));
  par.append("&code="+code);
}
String hospital = h.get("hospital","");
if(!"".equals(hospital)){
	sql.append(" AND h.name LIKE "+Database.cite("%"+hospital+"%"));
	par.append("&hospital="+h.enc(hospital));
}

//sql.append(" AND r.member = "+h.member);


int status = h.getInt("status",-1);
if(status>-1){
	sql.append(" AND status = "+status);
	par.append("&status="+status);
}

int type = h.getInt("type",-1);
if(type>-1){
	sql.append(" AND type = "+type);
	par.append("&type="+type);
}


String[] TAB={"待提交","未通过审核","已通过审核"};
String[] SQL={" and status = 3"," AND status not in(1,3)"," AND status = 1 "};

int tab=h.getInt("tab",0);
par.append("&tab="+tab);

int pos=h.getInt("pos");
par.append("&pos=");

int size = 20;



//int sum=ReplyMoney.count(sql.toString());

//上海管理员  14122306
AdminUsrRole aur=AdminUsrRole.find(h.community,h.member);

%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<script src='/tea/jquery.js' type="text/javascript"></script>
</head>
<body>
<h1>订单管理—<%=AdminFunction.find(menu).getName(h.language) %></h1>
<form name="form1" action="?">
<input type="hidden" name="id" value="<%=menu%>"/>
<input type="hidden" name="tab" value="<%=tab%>"/>
<div class='radiusBox'>
<table id="tdbor" cellspacing="0" class='newTable'>
<thead>
<tr><td colspan='6' class='bornone'>查询</td></tr>
</thead>
<tr>
  <td width="20%">回款编号：<input name="code" value="<%=MT.f(code)%>"/></td>


    <%--<%
        if(puid == null){
            %>
                <td width="20%">厂商：
                    <select name="puid1">
                        <option>请选择</option>
                        <%
                            List<ProcurementUnit> puList = ProcurementUnit.find("", 0, 10);
                            for (int i = 0; i < puList.size(); i++) {
                                out.print("<option "+(puid1==puList.get(i).getPuid()?"selected='selected'":"")+" value='"+puList.get(i).getPuid()+"'>"+puList.get(i).getName()+"</option>");
                            }
                        %>
                    </select>
                </td>
            <%
        }
    %>--%>

  <td width="20%">类型：
  <select name='type'>
  <option>请选择</option>
  	<%
  		for(int i=0;i<ReplyMoney.typeARR.length;i++){
  			out.print("<option "+(type==i?"selected='selected'":"")+" value='"+i+"'>"+ReplyMoney.typeARR[i]+"</option>");
  		}
  	%>
  </select>
  </td>
  <td width="20%">回款状态：
  <select name='status'>
  <option>请选择</option>
  	<%
  		for(int i=0;i<ReplyMoney.statusARR.length;i++){
  			out.print("<option "+(status==i?"selected='selected'":"")+" value='"+i+"'>"+ReplyMoney.statusARR[i]+"</option>");
  		}
  	%>
  </select>
  </td>
  <td width="20%">医院：<input name="hospital" value="<%=MT.f(hospital)%>"/></td>
    <%if(h.get("puid").equals("gaoke")){%>
    <td width="20%">医院编号：<input name="h_code" value="<%=MT.f(h_code)%>"/></td>
    <%}%>
  <td class='bornone'><button class="btn btn-primary" type="submit">查询</button></td>
</tr>
</table>
</div>
</form>
<%


out.print("<div class='switch'>");
for(int i=0;i<TAB.length;i++)
{
  out.print("<a href='javascript:mt.tab("+i+")' class='"+(i==tab?"current":"")+"'>"+TAB[i]+"（"+ReplyMoney.count(sql.toString()+SQL[i])+"）</a>");
}
out.print("</div>");
sql.append(SQL[tab]);
int sum=ReplyMoney.count(sql.toString());
%>
<form name="form2" action="/ReplyMoneys.do" method="post" target="_ajax">
<input type="hidden" name="rid"/>
<input type='hidden' name='soeid' value=''>
<input type='hidden' name='type' value=''>
<input type="hidden" name="id" value="<%=menu %>"/>
<input type="hidden" name="puid" value="<%=puid %>"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type='hidden' name='remarks'>
<div class='radiusBox mt15'>
<table id="" cellspacing="0" class='newTable'>
<thead>
<tr><td colspan='12'>列表 <%=sum%></td></tr>
</thead>
<tr id="tableonetr">
<%-- <%
	if(tab==1){
		%>
	<th><input type="checkbox" onclick="mt.select(form2.rids,checked)"/></th>
		<%
	}
%> --%>
  <th width='60'>序号</th>
  <th>回款编号</th>
  <th>医院</th>
    <%if(h.get("puid").equals("gaoke")){%>
  <th>医院编号</th>
    <%}%>
  <th>厂商</th>
  <th>回款金额</th>
  <th>类型</th>
  <th>回款时间</th>
  <th>回款状态</th>
  <th>匹配状态</th>
    <th>回款类型</th>
  <th>创建日期</th>
  <th>操作</th>
</tr>
<%
int lizinum=0,othernum=0;
    Double replyPricesum = 0.0;
boolean isjinyong = false;
if(sum<1)
{
  out.print("<tr><td colspan='12' class='noCont'>暂无记录!</td></tr>");
}else
{
    if(puid != null){
        sql.append(" and r.puid="+puid);
    }
  sql.append(" order by time desc ");
  List<ReplyMoney> rmlist  =ReplyMoney.find(sql.toString(),pos,size);
  for(int i=0;i<rmlist.size();i++)
  {
	  ReplyMoney t= rmlist.get(i);
      ShopHospital sh1 = ShopHospital.find(t.getHid());
      replyPricesum+=t.getReplyPrice();
%>
  <tr>
  	<%-- <%
  	if(tab==1){
  			isjinyong = true;
  		if(t.getStatus()==1){
  			%>
  			<td><input type="checkbox" name='rids' value='<%= t.getId() %>' /></td>
  			<%
  		}
  	}
  	%> --%>
    <td><%=(i+1)%></td>
    <td><%=MT.f(t.getCode())%></td>
    <td><%=MT.f(sh1.getName())%></td>
        <%if(h.get("puid").equals("gaoke")){%>
    <td><%=MT.f(sh1.getH_code())%></td>
        <%}%>
    <td><%=MT.f(ProcurementUnit.findName(puid))%></td>
    <td><%=t.getReplyPrice()%></td>
    <td><%=ReplyMoney.typeARR[t.getType()]%></td>
    <td><%=MT.f(t.getReplyTime())%></td>
    <td><%=ReplyMoney.statusARR[t.getStatus()]%></td>
    <td><%=ReplyMoney.statusmemberARR[t.getStatusmember()]%></td>
        <td><%=t.getAdd_type()==0?"医院":"服务商"%></td>
    <td><%=MT.f(t.getTime(),1)%></td>
    <td>
    	 <button type="button" class="btn btn-link" onclick="mt.act('data','<%=t.getId()%>')">查看详情</button>
    	 <%
    	 	if(t.getStatus()==2){
    	 		if(MT.f(t.getReturnStr()).length()>0){
    	 			//<%=MT.f(t.getReturnStr())
    	 			%>
    	 		<button type="button" class="btn btn-link" onclick="mt.show('<%=MT.f(t.getReturnStr().trim()) %>');">退回原因</button>
    	 			<%
    	 		}
	    	 %>
            <button type="button" class="btn btn-link" onclick="mt.act('sub','<%=t.getId()%>')">提交审核</button>
	    	<button type="button" class="btn btn-link" onclick="mt.act('edit','<%=t.getId()%>')">编辑</button>
	    	 <button type="button" class="btn btn-link" onclick="mt.act('del','<%=t.getId()%>')">删除</button>
	    	 <%
    	 	}
    	 	if(t.getStatus()==3){
             %>
            <button type="button" class="btn btn-link" onclick="mt.act('sub','<%=t.getId()%>')">提交审核</button>
            <button type="button" class="btn btn-link" onclick="mt.act('edit','<%=t.getId()%>')">编辑</button>
            <button type="button" class="btn btn-link" onclick="mt.act('del','<%=t.getId()%>')">删除</button>
            <%
            }
    	 %>
    </td>
  </tr>
  <%}
  if(sum>size)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,size));
}%>
    <tr>
        <td width="90">回款总金额：</td>
        <td colspan="11"><%=replyPricesum%></td>
    </tr>
</table>
</div>
	<div class='center mt15'><button class="btn btn-primary" type="button" onclick="mt.act('edit','0')">添加回款</button>
	<%-- <%
	if(tab==1){
		%>
		&nbsp;<button class="btn btn-primary" type="button" name="multi" onclick="mt.act('statusmember',0)">通知回款</button>
		<%
	}
	%> --%>
	<button class="btn btn-primary" type="button" onclick="dcorder()">导出</button>
	</div>
</form>


<form action="/ReplyMoneys.do" name="form3"  method="post" target="_ajax" >
	<input name="act" value="exp_replymoney" type="hidden" />

		<input type='hidden' name="sql" value="<%= sql.toString() %>" />
</form>
<script>
<%= (isjinyong?"mt.disabled(form2.rids);":"")%>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,id,status,statusContent)
{
  form2.act.value=a;
  form2.rid.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='status')
  {
	  form2.status.value=status;
	  mt.show('你确定要“'+statusContent+'”吗？',2,'form2.submit()');
  }else if(a=='data')
  {
	  form2.action=("/jsp/yl/shopnew/ReplyMoneyDatas.jsp");
	  form2.target='_self';form2.method='get';form2.submit();
  }else if(a=='edit'){
	  form2.action=("/jsp/yl/shopnew/AddReplyMoney.jsp");
	  form2.target='_self';form2.method='get';form2.submit();
  }else if(a=='sub'){
        mt.show('你确定要提交审核吗?',2);
        mt.ok = function(){
            form2.submit();
        };
  }else if(a=='statusmember'){
	   if($("input[name='rids']:checked").length==0){
			mt.show('请选择回款！');
			return;
	  }
	  mt.show('你确定要通知服务商回款吗？',2);
	  mt.ok = function(){
		  form2.submit();
	  };
  }
};

function dcorder(){

	form3.submit();
}
</script>
</body>
</html>
