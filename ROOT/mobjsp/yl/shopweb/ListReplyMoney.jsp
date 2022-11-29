<%@page import="util.Config"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.yl.shopnew.*"%><%@page import="tea.entity.yl.shop.*"%><%@page import="tea.entity.member.Profile"%><%


Http h=new Http(request,response);
	if(h.member<1){
		String param = request.getQueryString();
		String url = request.getRequestURI();
		if(param != null)
			url = url + "?" + param;
		response.sendRedirect("/mobjsp/yl/user/login_mobile.html?nexturl="+Http.enc(url));
		return;
	}



int menu=h.getInt("id");
StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
par.append("&menu="+menu);

Profile profile=Profile.find(h.member);
String hospitals=profile.hospitals;
if(hospitals==null){
	hospitals="|";
}
	String hidstr="";
if(profile.membertype==2){
	String[] hospitalsarr=hospitals.split("[|]");
	for(int i=1;i<hospitalsarr.length;i++){
		//out.print(hospitalsarr[i]+".");
		
		if(i==hospitalsarr.length-1){
			hidstr+=hospitalsarr[i];
		}else{
			hidstr+=hospitalsarr[i]+",";
		}
	}
}else{
	ShopQualification sq = ShopQualification.findByMember(profile.profile);
	hidstr  = sq.hospital_id+"";
}
	if(MT.f(hidstr).length()>1){
		sql.append(" and hid in("+hidstr+")");
	}else{
		sql.append(" and hid in(000)");
	}


	int puid = h.getInt("puid",-1);
	if(puid!=-1){
		sql.append(" AND puid = "+puid);
		  par.append("&puid="+puid);
	}
	Date time0=h.getDate("time0");
	if(time0!=null)
	{
		sql.append(" AND replyTime>="+DbAdapter.cite(time0));
		par.append("&time0="+time0);
	}
	Date time1=h.getDate("time1");
	if(time1!=null)
	{
		sql.append(" and replyTime<"+DbAdapter.cite(time1));
		par.append("&time1="+time1);
	}
/* sql.append(" AND profile="+h.member);
par.append("&profile="+h.member); */

//按医院查询

String hname=h.get("hname","");
if(hname.length()>0){
	sql.append(" and hid in (select id from shophospital where name like "+Database.cite("%"+hname+"%")+")");
	par.append("&hname="+h.enc(hname));
}


String[] TAB={"未匹配发票","待审核","已匹配发票","全部"};
String[] SQL={" AND statusmember = 1 "," AND statusmember = 2 "," AND statusmember = 3 "," AND statusmember > 0 ",};

int tab=h.getInt("tab",0);
par.append("&tab="+tab);

int pos=h.getInt("pos");
par.append("&pos=");



%><!DOCTYPE html><html><head>


<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<script src="/tea/jquery-1.11.1.min.js"></script>
<script src="/tea/new/js/superslide.2.1.js"></script>
<script src="/tea/yl/mtDiag.js"></script>
<link rel="stylesheet" href="/tea/mobhtml/m-style.css">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,user-scalable=0">
<title>回款管理</title>
</head>
<body style=''>

<div class="body body-bot">
	<div class="invoice">
		<input type="button" value="回款匹配发票记录" class="invoice-btn ft16" onclick="location.href='/mobjsp/yl/shopweb/ListBackInvoice.jsp'">
	</div>
	<div class="order-sea">
		<form name="form1" action="?">
			<input type="hidden" name="id" value="<%=menu%>"/>
			<input type="hidden" name="tab" value="<%=tab%>"/>
		<div class="order-sea-left fl-left">
			<p style="position:relative;">
				<span class="ft14 order-l-span">回款单位：</span>
				<input type="text" name="hname" class="right-box-data" id="hname" value="<%=hname %>" readonly style=""/>
				<input id="hospitalsel" class="btn btn-link" style="position:absolute;width:auto;right:-70px;color:#044694;border:none;background:none;top:0px;height:33px;" onclick="layer.open({type: 2,title: '选择医院',shadeClose: true,area: ['98%', '580px'],closeBtn:1,content: '/jsp/yl/shopwebnew/Selhospital.jsp'});" type="button" value="请选择"/>
			</p>
			<p>
				<span class="ft14 order-l-span">收款单位：</span>
				<select name='puid' style=""  class="right-box-yy">
					<option value=''>请选择</option>
					<option <%= (puid==Config.getInt("tongfu")?"selected='selected'":"") %> value='<%= Config.getInt("tongfu") %>'>同辐</option>
					<option <%= (puid==Config.getInt("gaoke")?"selected='selected'":"") %> value='<%= Config.getInt("gaoke") %>'>高科</option>
					<option <%= (puid==Config.getInt("junan")?"selected='selected'":"") %> value='<%= Config.getInt("junan") %>'>君安</option>
				</select>
			</p>
			<p>
				<span class="ft14 order-l-span">回款时间：</span>
				<span class="time">
                        <input name="time0" value="<%=MT.f(time0)%>" onclick="mt.date(this)" class="right-box-data1"/>
                        <span style="">~</span>
                        <input name="time1" value="<%=MT.f(time1)%>" onclick="mt.date(this)" class="right-box-data1"/>
                    </span>
			</p>
			<%--<p><span style="color: red">（高科开票暂不开通匹配发票功能）</span></p>--%>
		</div>
		<input type="submit" class="fl-right order-cxb order-cxb3 ft14" value="查询" style="margin-top:60px;">

		</form>
	</div>
	<div class="order-lx order-lx2">
		<ul>
			<%out.print("<ul>");
				for(int i=TAB.length-1;i>=0;i--)
				{
					out.print("<li class='ft14 fl-left "+(i==tab?"on":"")+"'><a href='javascript:mt.tab("+i+")' class='"+(i==tab?"current":"")+"'>"+TAB[i]+"("+ReplyMoney.count(sql.toString()+SQL[i])+")</a></li>");
				}
				out.print("</ul>");
			%>
		</ul>
	</div>

	<form name="form2" action="/ReplyMoneys.do" method="post" target="_ajax">

		<input type="hidden" name="tab" value="<%=tab%>"/>
		<input type="hidden" name="nexturl"/>
		<input type="hidden" name="act"/>
		<input type="hidden" name="replyid"/>


				<%
					sql.append(SQL[tab]);
					System.out.println("==="+sql);
					int sum=ReplyMoney.count(sql.toString());
					if(sum<1)
					{
						out.print("<div class=\"order-list\"><p class='text-c'>暂无记录!</p></div>");
					}else
					{
						List<ReplyMoney> lst=ReplyMoney.find(sql.toString()+" order by time desc ",pos,10);
						for(int i=0;i<lst.size();i++)
						{
							ReplyMoney t=lst.get(i);
							ShopHospital hospital=ShopHospital.find(t.getHid());

				%>


		<div class="order-list">
			<p class="order-line1 ft14 inv-p">
				<%
					if(tab==0){
				%>


				<%
					if(t.getPuid()!=Config.getInt("gaoke")){//是高科不能在这匹配
				%>
				<input type="checkbox" name="issigns" value="<%=t.getId() %>" class="inv-che fl-left"/>
				<%
					}
				%>
				<input type="hidden" value="<%=hospital.getId() %>"/>

				<%
					}
				%>
				<span class="fl-left inv-tit order-tit"><%=MT.f(hospital.getName()) %></span>
				<span class="fl-right order-zt"><%=ReplyMoney.statusmemberARR[t.getStatusmember()] %></span>
			</p>
			<ul class="ft14">
				<li>
					<span class="fl-left list-spanr2">回款编号：</span>
					<span class="fl-left list-spanr"><%=MT.f(t.getCode()) %></span>
				</li>
				<li>
					<span class="fl-left list-spanr2">类型：</span>
					<span class="fl-left list-spanr"><%=ReplyMoney.typeARR[t.getType()] %></span>
				</li>
				<li>
					<span class="fl-left list-spanr2">回款时间：</span>
					<span class="fl-left list-spanr"><%=MT.f(t.getReplyTime()) %></span>
				</li>
				<li>
					<span class="fl-left list-spanr2">回款金额：</span>
					<span class="fl-left list-spanr huikuan"><%=ShopHospital.getDecimal((double)t.getReplyPrice()) %></span>
				</li>
				<li>
					<span class="fl-left list-spanr2">收款单位：</span>
					<span class="fl-left list-spanr"><%= ProcurementUnit.findName(t.getPuid()) %><input type="hidden" name='puid' value="<%=t.getPuid() %>"/><input type="hidden" name='ReplyMoneyType' value="<%=t.getType() %>"/></span>
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


		<%
			if(tab==0){
		%>
		<div>
			<input disabled="disabled" type="button" id="getinvoice" onclick="fnconfirm(<%=h.member %>)" value="匹配发票" class="inv-f-btn ft16">
		</div>
		<%
			}
		%>
	</form>

</div>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,rid)
{
  form2.act.value=a;
  form2.replyid.value=rid;
  if(a=='data')
  {
	  //window.open("ReplyMoneyDatas.jsp");
	  location.href="/mobjsp/yl/shopweb/ReplyMoneyDatas.jsp?replyid="+rid+"&nexturl=/jsp/yl/shopwebnew/ListReplyMoney.jsp"+location.search;

  }
};


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
	//控制索要发票按钮
	if(len==0){
		$('#getinvoice').attr('disabled',"true");
		
	}else{
		$('#getinvoice').removeAttr("disabled");
		
	}
	
	gethk();
	
});
mt.receive=function(v,n,h){
	  document.getElementById("hname").value=v;
	};
	
	//单选操作
	$("input[name='issigns']").click(function(){  
		
		
		
		var len = $("input[name='issigns']:checked").length; 
		//控制索要发票按钮
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
		
		gethk();

	});
	
	
	
	
	//输入开票金额
	
	function fnconfirm(member){
		
		
		var i=0;
		var hospital='';//医院名称
		var a=0;
		var hid=0;//医院id
		var amount=0;//回款金额
		
		var puid0 = 1;
		
		var ReplyMoneyTypecount=0;
		
		$("input[name='issigns']:checked").each(function(){
			
			i+=1;
			var puid1 = $(this).parent().parent().find("input[name='puid']").val();
			
			if(puid1!=puid0&&puid0!=1){
				a=1;
				mtDiag.show("请选择同一厂商发票！");
				//mt.show("请选择同一厂商发票！");
				return false;
			}
			puid0 = $(this).parent().parent().find("input[name='puid']").val();
			
			var ReplyMoneyType = $(this).parent().parent().find("input[name='ReplyMoneyType']").val();
			if(ReplyMoneyType==0){
				if(puid0==<%= Config.getInt("gaoke") %>){//高科
					ReplyMoneyTypecount++;
				}
			}
			
			/*if(ReplyMoneyTypecount>1){
				a=1;
				mt.show("高科只能选择一张回款发票！");
				return false;
			}*/
			
			
			
			if(i==1){
				hospital=$(this).parent().parent().find("td").eq(4).html();
				hid=$(this).next().val();
			}
			var hospital2=$(this).parent().parent().find("td").eq(4).html();
			
			if(hospital2!=hospital){
				mtDiag.show("请选择同一医院发票！");
				//mt.show("请选择同一医院发票！");
				a=1;
				return false;
				
			}
			//var hk=parseFloat($(this).parent().parent().find("td").eq(5).html());
			var hk=parseFloat($(this).parent('p').next('ul').find('.huikuan').text());


			amount+=hk;

			
		});

		var b=0;
		if(a==0){
			mt.send("/ReplyMoneys.do?act=searchbackinvoice&hid="+hid,function(d)
					{
			
						        if(d=='1')
						        {
									mtDiag.show("现有该医院已提交的申请待审核，暂不能申请！");
						        	//mt.show("现有该医院已提交的申请待审核，暂不能申请！");
						        	
						        }else{
						        	var ids='';//id
									var nums='';//开票数量
									var amounts='';//开票金额
									$("input[name='issigns']:checked").each(function(){
										ids+=$(this).val()+",";
										
									});
									//jsp/yl/shopwebnew/SelInvoice.jsp;
									//location.href='/jsp/yl/shopwebnew/SelInvoice.jsp?ids='+ids+'&member='+member+'&hid='+hid+'&amount='+parseFloat(amount)+'&puid='+puid0+'&nexturl=/jsp/yl/shopwebnew/ListReplyMoney.jsp'+location.search;
									location.href='/mobjsp/yl/shopwebnew/SelInvoice_wx.jsp?ids='+ids+'&member='+member+'&hid='+hid+'&amount='+parseFloat(amount)+'&puid='+puid0+'&nexturl='+location.pathname+location.search;
						        }
						    });
			
			
		}
		
	}
	//选中的回款金额
	function gethk(){
		var amount=0;
		$("input[name='issigns']:checked").each(function(){
			
			var hk=parseFloat($(this).parent().parent().find("td").eq(5).html());
			amount+=hk;
			
		});
		$("#tishi0").html("已选中的回款金额："+parseFloat(amount)+"元");
		mt.fit();
	}
	mt.fit();
</script>
</body>
</html>
