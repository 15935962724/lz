<%@page import="util.Config"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.yl.shopnew.*"%><%@page import="tea.entity.yl.shop.*"%><%@page import="tea.entity.member.Profile"%><%


Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
int menu=h.getInt("id");
StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
par.append("&menu="+menu);

sql.append(" AND member="+h.member+" and istzfws in (1,2) ");
par.append("&member="+h.member);
par.append("&istzfws= 1");


//按医院查询

String hname=h.get("hname","");
if(hname.length()>0){
	sql.append(" and hospitalid in (select id from shophospital where name like "+Database.cite("%"+hname+"%")+")");
	par.append("&hname="+h.enc(hname));
}


int puid = h.getInt("puid",-1);
if(puid!=-1){
	sql.append(" AND puid = "+puid);
	  par.append("&puid="+puid);
}

int pos=h.getInt("pos");
par.append("&pos=");



%><!DOCTYPE html><html><head>


<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<script src="/tea/jquery-1.11.1.min.js"></script>
<link rel="stylesheet" href="/tea/new/css/style.css">
<script src="/tea/new/js/jquery.min.js"></script>
<script src="/tea/new/js/superslide.2.1.js"></script>
<script src="/tea/yl/mtDiag.js"></script>
<style>
.con-left-list .tit-on1{color:#044694;}

	.con-left .bd:nth-child(2){
		display:block;
	}
	.con-left .bd:nth-child(2) li:nth-child(5){
		font-weight: bold;
	}

.mt_data td,.mt_data th{padding:3px}

input[type=text]::-ms-clear{

                display: none;

                 

            }

            input::-webkit-search-cancel-button{

                display: none;

            }  

            input.t {

                border:1px solid #fff;

                background:#fff;            

                padding-left:5px; 

                height:30px; 

                line-height:30px ;

                font-size:12px;

                font-color: #004779;

                 

            } 
</style>

</head>
<body style='min-height:800px'>

<%@ include file="/jsp/yl/shopweb/PersonalTop.jsp" %>
<div id="Content">
	<div class="con-left">
		<%@ include file="/jsp/yl/shopweb/PersonalLeft.jsp" %>
	</div>
	<div class="con-right">
		<form name="form1" action="?">
			<input type="hidden" name="id" value="<%=menu%>"/>
			<div class="con-right-box con-right-box2">
				<div class="right-line1">
					<p>
						<span>医　　院：</span>
						<span style="width:335px;display: inline-block">
							<input type="text" name="hname" class="right-box-data" id="hname" value="<%=hname %>" readonly style="width:252px;"/>
							<input id="hospitalsel" class="right-search" style="border: 1px solid #dadada;float: none;margin: 0px;height: 32px;background: #ececec;color: #333;
							line-height: 31px;" onclick="layer.open({type: 2,title: '选择医院',shadeClose: true,offset:'100px',area: ['60%', '580px'],closeBtn:1,content: '/jsp/yl/shopwebnew/Selhospital.jsp'});" type="button" value="请选择"/>
							<%--<input type="button" value="清空医院" onclick="fnclearhname()"/>--%>
						</span>

						<span class="right-box-tit">开票单位：</span>
						<select name='puid' style="width:333px;"  class="right-box-yy">
							<option value=''>请选择</option>
							<option <%= (puid==Config.getInt("tongfu")?"selected='selected'":"") %> value='<%= Config.getInt("tongfu") %>'>同辐</option>
							<option <%= (puid==Config.getInt("gaoke")?"selected='selected'":"") %> value='<%= Config.getInt("gaoke") %>'>高科</option>
							<option <%= (puid==Config.getInt("junan")?"selected='selected'":"") %> value='<%= Config.getInt("junan") %>'>君安</option>
						</select>
					</p>
				</div>
				<input type="submit" class="right-search right-search2" value="查询">
			</div>

		</form>

		<form name="form2" action="/Charges.do" method="post" target="_ajax">
			<input type="hidden" name="nexturl"/>
			<input type="hidden" name="chargeid" />
			<input type="hidden" name="act"/>
			<input type="hidden" name="hospital"/>
			<input type="hidden" name="id"/>
			<input type='hidden' name="sql" value="<%= sql.toString() %>" />

			<div class="results">
				<table class="right-tab" border="1" cellspacing="0">
					<tr id="tableonetr">

						<th class="td2">序号</th>
						<th class="td3">服务费编号</th>
						<th class="td4">医院</th>
						<th class="td4">申请时间</th>
						<th class="td8">状态</th>
						<th class="td8">开票单位</th>
						<th class="td9">操作</th>

					</tr>
					<%

						int sum=Charge.count(sql.toString());
						if(sum<1)
						{
							out.print("<tr><td colspan='11' align='center'>暂无记录!</td></tr>");
						}else
						{
							List<Charge> lst=Charge.find(sql.toString()+" order by createdate desc ",pos,20);
							for(int i=0;i<lst.size();i++)
							{
								Charge t=lst.get(i);
								int hospitalid=t.getHospitalid();//医院
								ShopHospital hospital=ShopHospital.find(hospitalid);//医院

					%>
					<tr>

						<td><%=(i+1) %></td>
						<td><%=t.getChargecode() %></td>
						<td><%=hospital.getName() %></td>
						<td><%=MT.f(t.getCreatedate(),1) %></td>
						<td><%=Charge.STATUS[t.getStatus()] %></td>
						<td><%= ProcurementUnit.findName(t.getPuid()) %></td>
						<td><a href="javascript:mt.act('data',<%=t.getId() %>)">查看</a>&nbsp;&nbsp;
							<a href="javascript:mt.act('dcdata',<%=t.getId() %>)">导出通知单</a>&nbsp;&nbsp;
						</td>

					</tr>

					<%

							}

							if(sum>20)out.print("<tr class='fenye'><td colspan='11' align='right' id='ggpage'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
						}%>
				</table>
			</div>

		</form>
	</div>
</div>


<script>
form2.nexturl.value=location.pathname+location.search;
//全选操作

$("#all").click(function(){  
	
	
	if($(this).prop("checked")==true){
		
		$("input[name='issigns']").each(function(){
			  if($(this).prop("checked")==false){
				  $(this).click();
			  }
			  
		})
	}else{
		$("input[name='issigns']").each(function(){
			  
			if($(this).prop("checked")==true){
				  $(this).click();
			  }
		})
	}
	var len = $("input[name='issigns']:checkbox:checked").length;
	//控制申请服务费按钮
	if(len==0){
		$('#getinvoice').attr('disabled',"true");
		
	}else{
		$('#getinvoice').removeAttr("disabled"); 
		
	}
	
	
	
});

	
	//单选操作
	$("input[name='issigns']").click(function(){  
		
		
		
		var len = $("input[name='issigns']:checked").length; 
		//控制申请服务费按钮
		if(len==0){
			$('#getinvoice').attr('disabled',"true");
			
		}else{
			$('#getinvoice').removeAttr("disabled"); 
		}
		var alllen=document.getElementsByName("issigns").length;
		//控制全选
		if(len<alllen){
			$("#all").prop("checked", false);  
		}
		if(len==alllen){
			$("#all").prop("checked", true);  
		}
		
		

	});

	mt.act=function(a,rid)
	{
	  
	  if(a=='data')
	  {
		  //window.open("ChargeDatas.jsp");
		  //window.open("ChargeDatasnew.jsp");
		  location.href="/jsp/yl/shopwebnew/ChargeDatas.jsp?chargeid="+rid+"&nexturl=/jsp/yl/shopwebnew/ListCharge.jsp"+location.search;

	  }else if(a=='dcdata'){
		  form2.act.value=a;
		  form2.chargeid.value=rid;
		  form2.submit();
	  }
	};
mt.receive=function(v,n,h){
    document.getElementById("hname").value=v;
};
	mt.fit();
</script>
</body>
</html>
