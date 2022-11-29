<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.admin.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.yl.shop.*"%><%

Http h=new Http(request,response);
String param = request.getQueryString();
String url = request.getRequestURI();
if(param != null)
	url = url + "?" + param;

if(h.member<1){
	response.sendRedirect("/mobjsp/yl/user/login_mob.html?nexturl="+Http.enc(url));
	return;
}

int member = h.member;
Profile profile = Profile.find(member);
//收货人信息
ShopOrderAddress soa = ShopOrderAddress.getObjByMember(member);
/*验证医院资质是否已过期*/
ShopHospital sh = ShopHospital.findcheck(soa.getHospitalId());
//发票信息
//ShopNvoice sn = ShopNvoice.getObjByMember(member);

//当前商品IP
int product_id = h.getInt("product",0);
float price = h.getFloat("price");//开票价，对应医院设置的价格
int quantity = h.getInt("quantity",0);

String token = System.currentTimeMillis()+new Random().nextInt()+"";
request.getSession().setAttribute("token", token);


%><!doctype html><html><head>
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/mobjsp/yl/shopStyle.css" rel="stylesheet" type="text/css">

<script src="/tea/mt.js" type="text/javascript"></script>
<script src='/tea/city.js' type="text/javascript"></script>
<script src='/tea/jquery.js' type="text/javascript"></script>
<script type="text/javascript" src="/tea/dateTimeUtil.js"></script>
<script type="text/javascript" src="/tea/webUtil.js"></script>
<title>订单详细</title>
</head>
<body>
<header class="header"><a href="javascript:history.go(-1)"></a>确认订单</header>

<!-- 收货人信息 -->
<form name="form1" action="/ShopOrderForms.do" method="post" onsubmit="return setCityName(this)">
	<input type="hidden" name="id" value="<%=soa.getId() %>" />
	<input type="hidden" name="nexturl" value="<%=url%>"/>
	<input type="hidden" name="act" value="orderAddress" />
	
	<div class='radiusBox newlist wSpan'>
		<ul class=''>
	    	<li class='bold' style='border-bottom:none'>收货人信息&nbsp;&nbsp;<i id="address_up" style="display: <%=soa.getMember()>0?"":"none" %>" ><a href="javascript:void(0)" onclick="setAddress()">修改</a></i></li>
	    </ul>
		<div class='f-tables' style='border:none;padding-bottom:0'>
			<ul id="nvoice_show" style="display: <%=soa.getMember()>0?"":"none" %>">
				<%
				ShopQualification sqq = ShopQualification.findByMember(member);
				if(profile.membertype == 2){ %>
					<li><span>医&nbsp;&nbsp;&nbsp;院：</span><%=MT.f(soa.getHospital()) %>
						<input type="hidden" name="hospital" value="<%=soa.getHospital() %>" />
					</li>
					<li><span>科&nbsp;&nbsp;&nbsp;室：</span><%=MT.f(soa.getDepartment()) %></li>
				<%}else{ %>
					<li><span>医&nbsp;&nbsp;&nbsp;院：</span><%=MT.f(ShopHospital.find(sqq.hospital_id).getName()) %>
						<input type="hidden" name="hospital" value="<%=MT.f(ShopHospital.find(sqq.hospital_id).getName()) %>" />
						<input type="hidden" name="hospital_id" value="<%=sqq.hospital_id %>" />
					</li>
					<li><span>科&nbsp;&nbsp;&nbsp;室：</span><%=MT.f(soa.getDepartment()) %></li>
				<%} %>
				<li><span>收货人：</span><%=soa.getConsignees() %></li>
				<li><span>电&nbsp;&nbsp;&nbsp;话：</span><%=soa.getMobile() %></li>
				<li><span>地&nbsp;&nbsp;&nbsp;址：</span><i id="cityaddress"></i><%=soa.getAddress() %></li>
			</ul>
		</div>
		<div class='f-tables'>
			<ul id="nvoice_edit" class='seachr emcolor' style="display: <%=soa.getMember()>0?"none":"" %>">
			<%
				if(profile.membertype == 2){
					out.print("<li class='sels'><span><em>*</em>医&nbsp;&nbsp;&nbsp;院：</span>");
					String [] sarr = profile.hospitals.split("\\|");
					out.print("<select name='hospital_id' alt='医院名称' onchange=selectHosp(this.options[this.options.selectedIndex]);>");
					out.print("<option value=''>--请选择--</option>");
					for(int i=1;i<sarr.length;i++){
						ShopHospital s1 = ShopHospital.find(Integer.parseInt(sarr[i]));
						if(soa.getHospitalId() == s1.getId())
							out.print("<option selected value='"+s1.getId()+"'>"+s1.getName()+"</option>");
						else
							out.print("<option value='"+s1.getId()+"'>"+s1.getName()+"</option>");
					}
					out.print("</select>");
					out.print("<br><span>科&nbsp;&nbsp;&nbsp;室：</span><select name=\"department\">");
					out.print("<option value=\"无\">--请选择--</option>");
							for(int j=1;j<ShopQualification.DEPARTMENT_ARR.length;j++){
								if(MT.f(soa.getDepartment()).equals(ShopQualification.DEPARTMENT_ARR[j]))
									out.print("<option selected value='"+ShopQualification.DEPARTMENT_ARR[j]+"'>"+ShopQualification.DEPARTMENT_ARR[j]+"</option>");
								else
									out.print("<option value='"+ShopQualification.DEPARTMENT_ARR[j]+"'>"+ShopQualification.DEPARTMENT_ARR[j]+"</option>");
							}
					 out.print("</select>");
					out.print("</li>");
				}else{
			%>
				<li><span>医&nbsp;&nbsp;&nbsp;&nbsp;院：</span><%= (sqq.hospital_id==0?"无":ShopHospital.find(sqq.hospital_id).getName()) %></li>
				<li><span>科&nbsp;&nbsp;&nbsp;&nbsp;室：</span><%= (sqq.department==0?"无":ShopQualification.DEPARTMENT_ARR[sqq.department]) %>
					<input type="hidden" name="department" value="<%= (sqq.department==0?"":ShopQualification.DEPARTMENT_ARR[sqq.department]) %>" />
				</li>
				<script type="text/javascript">
				 	//查找收货人
					mt.send("/Members.do?act=getsign&hospital=<%=sqq.hospital_id%>",function(d)
					{
					   var sel = document.getElementById("_consignees");
					   sel.innerHTML = d;
					});
			 	</script>
			<%
				}
			%>
				<li class='sels'><span align='right' nowrap><em>*</em>收货人：</span>
					<input type="hidden" name="consignees" value="<%=MT.f(soa.getConsignees()) %>"/>
					<input type="hidden" name="consignees_id" value="<%=MT.f(soa.getConsignees_id()) %>"/>
					<select name="consig" alt="收货人" id="_consignees" onchange="selectPro(this.options[this.options.selectedIndex])">
						<option><%=MT.f(soa.getConsignees(),"无") %></option>
					</select>
				</li>
				<li><span><em>*</em>手机号码：</span><input readonly="readonly" placeholder="手机号" type="tel" placeholder="请输入手机号" class='bors' id="_mobile" name="mobile" value="<%=MT.f(soa.getMobile()) %>" alt="手机号" /> </li>
				<li><span><em>*</em>详细地址：</span><input readonly="readonly" type="text" placeholder="请输入详细地址" id="_address" name="address" value="<%=MT.f(soa.getAddress()) %>" alt="详细地址" /></li>
				<li><button type="submit">保存收货人信息</button></li>
			</ul>
		</div>
	</div>
</form>
<script type="text/javascript">
	//选择医院
	function selectHosp(obj){
		//alert(obj.value + "-" + obj.text);
		form1.hospital.value = obj.text;
		//查找收货人
		mt.send("/Members.do?act=getsign&hospital="+obj.value,function(d)
		{
		   var sel = document.getElementById("_consignees");
		   sel.innerHTML = d;
		});
		
		document.getElementById("_mobile").value="";
		document.getElementById("_address").value="";
	}
	//选择签收人
	function selectPro(obj){
		//alert(obj.value + "-" + obj.text);
		form1.consignees.value = obj.text;
		form1.consignees_id.value = obj.value;
		//查找收货人
		mt.send("/Members.do?act=selsign&profile="+obj.value,function(d)
		{
			var obj = eval(d);
			document.getElementById("_mobile").value=obj[0].mobile;
			document.getElementById("_address").value=obj[0].address;
		});
	}
</script>

<form name="form5" action="/ShopOrders.do" method="post" target="_ajax" onsubmit="return mt.check(this)">
	<div class='f-tabless'>
		<input type="hidden" name="act" value="submit" />
		<input type="hidden" name="nexturl" value="/mobjsp/yl/shopweb/ShopOrderPayment_wx.jsp" />
		<input type="hidden"  name="isLzCategory" value="1" />
		<input type="hidden" name="amount" value="<%=price*quantity %>" />
		<input type="hidden" name="product_id" value="<%=product_id %>" />
		<input type="hidden" name="quantity" value="<%=quantity %>" />
		<input type="hidden" name="cityname" />
		<input type="hidden" name="iswx" value="1" />
		<input type="hidden" name="token" value="<%=token %>" />
		<%
			Profile mp = Profile.find(h.member);//购买用户
			String malluser = "";
			if(mp.membertype==1){
				malluser = ShopHospital.find(ShopQualification.findByMember(mp.profile).hospital_id).getName();
			}else{
				malluser = mp.member;
			}
			//商品
			ShopProduct p=ShopProduct.find(product_id);
		%>
		<input type="hidden"  name="orderUnit" value="<%=malluser %>" />
		<div class='radiusBox newlist wSpan'>
			<ul class="seachr emcolor">
				<li class='bold'>商品清单</li>
				<li><span>商品名称：</span><%=p.name[1] %></li>
				<li><span>购买数量：</span><%=quantity %></li>
				<%
					Calendar c = Calendar.getInstance();
		    	    c.set(Calendar.DATE, c.get(Calendar.DATE) +8);
		    	    Date maxDate = c.getTime();
		    	    
	    			StringBuffer caliBuff = new StringBuffer("<li class='calidate'>");
	    	    	ShopProductModel spm = ShopProductModel.find(p.model_id);
	    	    	String activityStr = spm.getModel().replaceAll("[a-zA-Z]","");
					if(activityStr.contains("[")){
						activityStr = activityStr.split("\\[")[0];
					}
	    	    	if(activityStr.indexOf("-")!=-1){
	    	    		String[] activityArr = activityStr.split("-");
	    	    		Double activityMin =  Double.parseDouble(activityArr[0]);
	    	    		Double activityMax =  Double.parseDouble(activityArr[1]);
	    	    		caliBuff.append("<span style='color:coral'><em>*</em>粒子活度：</span><input alt='粒子活度' placeholder='请输入粒子活度' title='粒子活度范围："+activityStr+"' name='activity' value='' onkeyup=\"keyupActivity(this)\" onblur=\"blurActivity(this,"+activityMin+","+activityMax+")\" /></li>");
	    	    	}else
	    	    		caliBuff.append("<span style='color:coral'><em>*</em>粒子活度：</span><input placeholder='请输入粒子活度' type='hidden' name='activity' value='"+activityStr+"' />"+activityStr+"</li>");
		    	    //caliBuff.append("<li>校准时间：<input alt='校准时间' placeholder='校准时间' id='teeDate' name='calidate' type='hidden'  readonly style='' class='mydate'/><em class='date' id='teeDateShow'>");
		    	    caliBuff.append("<li><span style='color:coral'><em>*</em>校准时间：</span><input placeholder='请选择校准时间' alt='校准时间' name='calidate' value='' onClick='mt.date(this,false,\""+new Date()+"\",\""+maxDate+"\")' readonly style='width:100px' class='date'/>");
		    	    caliBuff.append("</li>");
		    	    
	    			out.println(caliBuff.toString());
				%>
				<li class='bold'>备注</li>
				<li><textarea  name="userRemarks" placeholder="备注说明" rows="6" cols="100" id="textar"></textarea></li>
				<li><!-- <button type="button" onclick="mt.submit(this.form);">提交订单</button> -->
					<button type="button" onclick="return fnsub(this.form);">提交订单</button>
				</li>
			</ul>
		</div>
	</div>
</form>

<script type="text/javascript">

	//修改发货人信息
	function setAddress(){
		document.getElementById('nvoice_show').style.display = 'none';
		document.getElementById('nvoice_edit').style.display = '';
		document.getElementById('address_up').style.display = '';
		var hospital = form1.hospital_id.value;
		var consignees = form1.consignees.value;
		//查找收货人
		mt.send("/Members.do?act=getsign&hospital="+hospital+"&consignees="+consignees,function(d)
		{
		   var sel = document.getElementById("_consignees");
		   sel.innerHTML = d;
		});
		mt.fit();
	}

	mt.ajax=function(act){
		if('setAddress'==act){
			var id = form1.id.value;
			var consignees = form1.consignees.value;
			var address = form1.address.value;
			var mobile = form1.mobile.value;
			var telphone = form1.telphone.value;
			mt.send("/ShopOrderForms.do?act=orderAddress&id="+id+"&consignees="+encodeURIComponent(consignees)+"&address="+encodeURIComponent(address)+"&mobile="+mobile+"&telphone="+telphone,function(d)
			{
			   alert(123);
			});
		}
	};
	
	function keyupActivity(obj){
		obj.value = obj.value.replace(/[^\d.]/g,""); //清除"数字"和"."以外的字符
		obj.value = obj.value.replace(/^\./g,""); //验证第一个字符是数字而不是
		obj.value = obj.value.replace(/^[2-9]/g,""); //验证第一个字符是数字而不是
		obj.value = obj.value.replace(/\.{2,}/g,"."); //只保留第一个. 清除多余的
		obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
		obj.value = obj.value.replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3'); //只能输入两个小数 
	}
	
	function blurActivity(obj,activityMin,activityMax){
		if(obj.value!=''&&(obj.value<activityMin||obj.value>activityMax)){
			mt.show("活度超出范围 "+activityMin+"-"+activityMax+"！");
			obj.value = activityMin;
		}
	}
	
	mt.submit=function(f){
		if(<%=soa.getId()<1%>){
			mt.show("对不起！收货人信息没有填写，不能提交订单！");
			return;
		}else{
			if(<%=sh.getId() > 0%>){
				mt.show("当前医院资质已过期，不能提交订单！");
				return;
			}
			var activity = f.activity;
			if(activity&&activity.value==''){
				mt.show('抱歉，请先填写粒子活度！！！');
				return;
			}
			var calidate = f.calidate;
			if(calidate&&calidate.value==''){
				mt.show('抱歉，请先填写粒子的校准时间！！！');
				return;
			}
			var st = cookie.get("saveTime");
			if(st!=undefined && st!=""){
				var timestamp=new Date().getTime();
				var ret = timestamp - st;
				if(ret < 30000){
					alert('抱歉，不能重复提交订单,请稍后再试！');
					return;
				}
			}
			f.submit();
		}
		return;
	};
	
	function fnsub(f){
		$.post("/ShopOrders.do?act=checkpricewx&product_id="+f.product_id.value+"&limitdate=2017-10-1", function(data) {
			
			 if(data.length>2){
				 if(data.indexOf('对不起')==-1){
					 var astr=data+'，此商品管理员没有设置开票价格，请与管理员联系，设置开票价格后才可提交订单！';
					 mt.show(astr);
					 return false;
				 }else{
					 mt.show(data);
					 return false;
				 }
				 
			 }
			 
			 if(<%=soa.getId()<1%>){
					mt.show("对不起！收货人信息没有填写，不能提交订单！");
					return false;
				}else{
					if(<%=sh.getId() > 0%>){
						mt.show("当前医院资质已过期，不能提交订单！");
						return false;
					}
					var activity = f.activity;
					if(activity&&activity.value==''){
						mt.show('抱歉，请先填写粒子活度！！！');
						return false;
					}
					var calidate = f.calidate;
					if(calidate&&calidate.value==''){
						mt.show('抱歉，请先填写粒子的校准时间！！！');
						return false;
					}
					var st = cookie.get("saveTime");
					if(st!=undefined && st!=""){
						var timestamp=new Date().getTime();
						var ret = timestamp - st;
						if(ret < 30000){
							alert('抱歉，不能重复提交订单,请稍后再试！');
							return false;
						}
					}
					f.submit();
				}
					
					
					
					
					
					
					
				
			 
			 
			 
			});
		
		
	}
</script>

<script>

mycity=function(s0,s1,s2,dv)
{
  var h='';
    s0+='-';
	for(var i=2;i<s0.length;i+=2)
	{
	  var v=s0.substring(0,i);
	  var l=v.substring(0,i-2)||0;
      for(var j=0;j<CITY[l].length;j++)
      {
        if(CITY[l][j][0]==v)
        {
          h+=CITY[l][j][2]+' ';
          break;
        }
      }
	  if(v=="11"||v=="12"||v=="31"||v=="50")i+=2;
	}
	document.getElementsByName("cityname")[0].value = h;
	document.getElementById("cityaddress").innerHTML = h;
};
function setCityName(obj){
	if(mt.check(obj)){
		var cityid = document.getElementsByName("city2")[0].value;
		mycity(cityid);
	}else{
		return false;
	}
};
function showfp(){
	document.getElementById("stab1").style.display = 'none';
	document.getElementById("stab2").style.display = 'none';
	document.getElementById("fap").style.display = '';
}
mycity('<%= soa.getCity() %>');
mt.fit();
</script>
	<script type="text/javascript" charset="utf-8">
	    var subject=null;
		Date.prototype.Format = function(fmt) {//author: meizz
			var o = {
				"M+" : this.getMonth() + 1, //月份
				"d+" : this.getDate(), //日
				"h+" : this.getHours(), //小时
				"m+" : this.getMinutes(), //分
				"s+" : this.getSeconds(), //秒
				"q+" : Math.floor((this.getMonth() + 3) / 3), //季度
				"S" : this.getMilliseconds() //毫秒
			};
			if (/(y+)/.test(fmt))
				fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
			for (var k in o)
			if (new RegExp("(" + k + ")").test(fmt))
				fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
			return fmt;
		}
		var date = new Date();
		date.setDate(date.getDate() + 1); 
		$("#teeDateShow").html(toChineseDateString(date.Format("yyyy-MM-dd")));
		$("#teeDate").val(date.Format("yyyy-MM-dd"));
        $('#teeDateShow').click(function(){
        	var teeDateStr = $('#teeDate').val();
    		initDateDialog();
    		initDateList(teeDateStr,20);
    		$('#dateDialog').show(); 
    	});

	</script>
</body>
</html>
