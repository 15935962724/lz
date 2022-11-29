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
<link rel="stylesheet" href="/tea/mobhtml/m-style.css">
<script src="/tea/new/js/jquery.min.js"></script>
<script src="/tea/new/js/superslide.2.1.js"></script>
<script src="/tea/yl/mtDiag.js"></script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,user-scalable=0">
    <title>通知单</title>

</head>
<body style='min-height:700px'>
<div class="body">




		<form name="form1" action="?">
			<input type="hidden" name="id" value="<%=menu%>"/>
			<div class="order-sea" style="margin-bottom:10px">
				<div class="order-sea-left fl-left">
					<p style="position:relative;">
						<span class="ft14 order-l-span">医院：</span>
						<input type="text" name="hname" class="right-box-data" id="hname" value="<%=hname %>" readonly style=""/>
						<input id="hospitalsel" class="btn btn-link" style="position:absolute;width:auto;right:-70px;color:#044694;border:none;background:none;top:0px;height:33px;" onclick="layer.open({type: 2,title: '选择医院',shadeClose: true,area: ['98%', '580px'],closeBtn:1,content: '/jsp/yl/shopwebnew/Selhospital.jsp'});" type="button" value="请选择"/>
					</p>
					<p>
						<span class="ft14 order-l-span">开票单位：</span>
						<select name='puid' style=""  class="right-box-yy">
							<option value=''>请选择</option>
							<option <%= (puid==Config.getInt("tongfu")?"selected='selected'":"") %> value='<%= Config.getInt("tongfu") %>'>同辐</option>
							<option <%= (puid==Config.getInt("gaoke")?"selected='selected'":"") %> value='<%= Config.getInt("gaoke") %>'>高科</option>
							<option <%= (puid==Config.getInt("junan")?"selected='selected'":"") %> value='<%= Config.getInt("junan") %>'>君安</option>
						</select>
					</p>
				</div>
				<input type="submit" class="fl-right order-cxb order-cxb4  ft14" value="查询" style="margin-top:57px;">
			</div>

		</form>

		<form name="form2" action="/Charges.do" method="post" target="_ajax">
			<input type="hidden" name="nexturl"/>
			<input type="hidden" name="chargeid" />
			<input type="hidden" name="act"/>
			<input type="hidden" name="hospital"/>
			<input type="hidden" name="id"/>
			<input type='hidden' name="sql" value="<%= sql.toString() %>" />


					<%

						int sum=Charge.count(sql.toString());
						if(sum<1)
						{
							out.print("<div class=\"order-list\"><p class='text-c'>暂无记录!</p></div>");
						}else
						{
							List<Charge> lst=Charge.find(sql.toString()+" order by createdate desc ",pos,5);
							for(int i=0;i<lst.size();i++)
							{
								Charge t=lst.get(i);
								int hospitalid=t.getHospitalid();//医院
								ShopHospital hospital=ShopHospital.find(hospitalid);//医院

					%>

					<div class="order-list">
						<p class="order-line1 ft14">
							<span class="fl-left order-tit"><%=hospital.getName() %></span>
							<span class="fl-right order-zt"><%=Charge.STATUS[t.getStatus()] %></span>
						</p>
						<ul class="ft14">
							<li>
								<span class="list-spanr3 fl-left">服务费编号：</span>
								<span class="list-spanr fl-left"><%=t.getChargecode() %></span>
							</li>
							<li>
								<span class="list-spanr3 fl-left">申请时间：</span>
								<span class="list-spanr fl-left"><%=MT.f(t.getCreatedate(),1) %></span>
							</li>
							<li>
								<span class="list-spanr3 fl-left">开票单位：</span>
								<span class="list-spanr fl-left"><%= ProcurementUnit.findName(t.getPuid()) %></span>
							</li>
						</ul>
						<p class="order-btnp">
							<a class='btn' href="javascript:mt.act('data','<%=t.getId() %>')">查看</a>
						</p>
					</div>


					<%

							}

							if(sum>5)out.print("<div id='ggpage'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,5)+"</div>");
						}%>


		</form>

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
		  location.href="/mobjsp/yl/shopweb/ChargeDatas.jsp?chargeid="+rid+"&nexturl=/jsp/yl/shopwebnew/ListCharge.jsp"+location.search;

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
