<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.admin.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.yl.shop.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/html/folder/14102033-1.htm?community="+h.community);
  return;
}

int member = h.member;
Profile profile = Profile.find(h.member);

//收货人信息
ShopOrderAddress soa = ShopOrderAddress.getObjByMember(member);
//发票信息
ShopNvoice sn = ShopNvoice.getObjByMember(member);

ShopQualification sqq = ShopQualification.findByMember(member);

%><!doctype html><head>
<script>
var ls=parent.document.getElementsByTagName("HEAD")[0];
document.write(ls.innerHTML);
var arr=parent.document.getElementsByTagName("LINK");
for(var i=0;i<arr.length;i++)
{
  document.write("<link href='"+arr[i].href+"' rel='"+arr[i].rel+"' type='text/css'>");
}
</script>
<link href="/res/cssjs/base.css" rel="stylesheet" type="text/css"/>
<link href="/res/cssjs/my.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src='/tea/city.js' type="text/javascript"></script>
<script src='/tea/jquery.js' type="text/javascript"></script>
<style>
.mt_data td,.mt_data th{padding:3px}
</style>
</head>
<body>
<div class="ShoppingCart">
<ul class="Order_cart" id="Order_cart_S1">
	<li class="step1">1.我的购物车</li>
	<li class="step2">2.填写核对订单信息</li>
	<li class="step3">3.成功提交订单</li>
</ul>
<div class='xiangxi'>
<h2>填写并核对订单信息</h2>
<!-- 收货人信息 -->
<form name="form1" action="/ShopOrderForms.do" method="post" onsubmit="return setCityName(this)">
	<input type="hidden" name="id" value="<%=soa.getId() %>" />
	<input type="hidden" name="sor_id" value="<%=soa.getSor_id() %>"/>
	<input type="hidden" name="nexturl" value="/jsp/yl/shopweb/ShopOrderForm.jsp"/>
	<input type="hidden" name="act" value="orderAddress" />

	<div class='shotit'><strong>收货人信息</strong>&nbsp;&nbsp;<span id="address_up" style="display: <%=soa.getMember()>0?"":"none" %>" ><a href="#" onclick="setAddress()">修改</a></span></div>
	<div class='f-tables' style='border:none;padding-bottom:0'><table id="nvoice_show" style="display: <%=soa.getMember()>0?"":"none" %>">
		<%if(profile.membertype == 2){ %>
		<tr><td>医院名称:</td><td><%=MT.f(soa.getHospital()) %>
		<input type="hidden" name="hospital" value="<%=soa.getHospital() %>" /></td></tr>
		<tr><td>科室：</td><td><%=MT.f(soa.getDepartment()) %></td></tr>
		<%}else{ %>
		<tr><td>医院名称：</td><td><%=MT.f(ShopHospital.find(sqq.hospital_id).getName()) %></td></tr>
		<tr><td>科室：</td><td><%=MT.f(soa.getDepartment()) %>
		<input type="hidden" name="hospital" value="<%=MT.f(ShopHospital.find(sqq.hospital_id).getName()) %>" />
		<input type="hidden" name="hospital_id" value="<%=sqq.hospital_id %>" /></td></tr>
		<%} %>
		<tr><td>收货人：<%=soa.getConsignees() %></td><td>电话：<%=soa.getMobile() %></td></tr>
		<tr><td colspan="2">地址：<span id="cityaddress"></span><%=soa.getAddress() %></td></tr>
		<tr><td></td><td></td></tr>
	</table>
	</div>
<div class='f-tables'>
	<table id="nvoice_edit" style="display: <%=soa.getMember()>0?"none":"" %>">
		<tr><td align='right'><em>*</em>收货人：</td>
			<td><input type="text" class='bors' name="consignees" value="<%=MT.f(soa.getConsignees()) %>" alt="收货人" />
			<button type="button" class="btn btn-primary btn-xs" onclick="showRecipient()">选择收货人</button>&nbsp;&nbsp;
			<input type="checkbox" onclick="onNewAdd(this)" />&nbsp;是否为新增收货人</td>
		</tr>
	<%
		if(profile.membertype == 2){
			out.print("<tr><td align='right'><em>*</em>医院名称：</td><td>");
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
	%>
		科室：<select name="department">
				<option value="无">--请选择--</option>
				<%
					for(int j=1;j<ShopQualification.DEPARTMENT_ARR.length;j++){
						if(MT.f(soa.getDepartment()).equals(ShopQualification.DEPARTMENT_ARR[j]))
							out.print("<option selected value='"+ShopQualification.DEPARTMENT_ARR[j]+"'>"+ShopQualification.DEPARTMENT_ARR[j]+"</option>");
						else
							out.print("<option value='"+ShopQualification.DEPARTMENT_ARR[j]+"'>"+ShopQualification.DEPARTMENT_ARR[j]+"</option>");
					}
				%>
			 </select>
		</td></tr>
	<%
		}else{
	%>
		<tr><td align='right'>医院名称：<%=MT.f(ShopHospital.find(sqq.hospital_id).getName()) %></td><td>
		 	科室：<%= (sqq.department==0?"无":ShopQualification.DEPARTMENT_ARR[sqq.department]) %>
		 	<input type="hidden" name="department" value="<%= (sqq.department==0?"":ShopQualification.DEPARTMENT_ARR[sqq.department]) %>">
		</td></tr>
	<%
		}
	%>
		<tr><td align='right'><em>*</em>所在地区：</td><td>
		<script>mt.city('city0','city1','city2','<%= soa.getCity()%>')</script>
		</td></tr>
		<tr><td align='right'><em>*</em>详细地址：</td><td><input type="text" style='width:420px' class='bors' name="address" value="<%=MT.f(soa.getAddress()) %>" alt="详细地址" /><em>&nbsp;&nbsp;注：购买粒子，请填写医院详细地址。</em></td></tr>
		<tr><td align='right'><em>*</em>手机号：</td><td><input type="text" class='bors' name="mobile" value="<%=MT.f(soa.getMobile()) %>" alt="手机号" /> 或 固定电话：<input type="text" name="telphone" class='bors' value="<%=MT.f(soa.getTelphone()) %>" /></td></tr>
		<tr><td align='right'>邮编：</td><td><input class='bors' type="text" name="zipcode" value="<%=MT.f(soa.getZipcode()) %>" /></td></tr>
		<tr><td>&nbsp;</td><td class='bnts2'><input type="submit" value="保存收货人信息" /><!-- <input type="button" onclick="mt.ajax('setAddress');" value="保存收货人信息" /> --></td></tr>
	</table>
</form>
<script type="text/javascript">
	function selectHosp(obj){
		//alert(obj.value + "-" + obj.text);
		form1.hospital.value = obj.text;
	}
</script>
</div>

<!-- 支付方式 -->
<div class='f-tables'>
<form name="form2" action="">
<h3>支付方式：</h3>
	<table id='zhif'>
		<!-- <tr><td width='180'><input name="payType" type="radio" value="1" checked/>在线支付</td><td class='pl10'>即时到帐，支持绝大数银行借记卡及部分银行信用卡</td></tr>-->
		<tr><td width='180'><input name="payType" checked="checked" type="radio" value="2" />公司转账</td><td class='pl10'></td></tr>
		<!-- <tr><td><input type="submit" value="保存支付方式"/></td></tr> -->
	</table>
</form>
</div>
<!-- 发票信息 -->
<%-- <div class='f-tables'>
<form name="form3" action="/ShopOrderForms.do" method="post" onsubmit="return mt.check(this)">
	<input type="hidden" name="id" value="<%=sn.getId() %>" />
	<input type="hidden" name="nexturl" value="/jsp/yl/shopweb/ShopOrderForm.jsp"/>
	<input type="hidden" name="type" value="<%=sn.getType() %>" />
	<input type="hidden" name="act" value="nvoice" />
	<h3>发票信息</h3>
	<div>
	<%
		if(sn.getMember()>0){
			out.print("<a href='javascript:void(0);' onclick='showfp();'>修改</a>");
		}
	%>
	
	</div>
	<table style="display: <%=sn.getMember()>0?"":"none" %>" id="stab1">
		<tr>
			<td>发票开具方式：<%= (sn.getType()==1?"增值税普通":"增值税专用") %></td>
		</tr>
		<tr>
			<td>医院名称：<%= MT.f(sn.getCompany()) %></td>
		</tr>
		</table>
		<table id="stab2" style="display: <%=(sn.getMember()>0&&sn.getType()==2)?"":"none" %>" >
			<tr>
			<td>开户行：<%= MT.f(sn.getOpenbank()) %></td>
		</tr>
		<tr>
			<td>账     户：<%= MT.f(sn.getAccountNo()) %></td>
		</tr>
		<tr>
			<td>纳税人识别号：<%= MT.f(sn.getTaxpayerId()) %></td>
		</tr>
		<tr>
			<td>电    话：<%= MT.f(sn.getTelphone()) %></td>
		</tr>
		<tr>
			<td>邮    编：<%= MT.f(sn.getZip()) %></td>
		</tr>
		<tr>
			<td>地    址：<%= MT.f(sn.getAddress()) %></td>
		</tr>
	</table>
	<table id='fap' style="display: <%=sn.getMember()>0?"none":"" %>" >
		<tr><td>发票开具方式：</td><td><input type="radio" name="type_" value="1"  <%out.print((sn.getType()==1||sn.getType()==0)?"checked":"");%> onchange="selNvoice(this.value)" />增值税普通发票 &nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="type_" value="2" <%out.print(sn.getType()==2?"checked":"");%> onchange="selNvoice(this.value)" />增值税专用发票</td></tr>
		<tr><td align='right'><em>*</em>医院名称：</td><td><input type="text" class='bors' name="company" alt="医院名称" value="<%=MT.f(sn.getCompany()) %>" /></td></tr>
		<tr><td colspan="2"><div <%= (sn.getType()==2?"":"style='display:none;'") %> id="nvoice_t"><table>
			<tr><td align='right'><em>*</em>开户行：</td><td><input type="text" name="openbank" alt="开户行" value="<%=MT.f(sn.getOpenbank()) %>" /></td></tr>
			<tr><td align='right'><em>*</em>账     户：</td><td><input type="text" name="accountno" alt="账户" value="<%=MT.f(sn.getAccountNo()) %>" /></td></tr>
			<tr><td align='right'><em>*</em>纳税人识别号：</td><td><input type="text" name="taxpayerid" alt="纳税人识别号" value="<%=MT.f(sn.getTaxpayerId()) %>" /></td></tr>
			<tr><td align='right'><em>*</em>电    话：</td><td><input type="text" name="telphone" alt="电话" value="<%=MT.f(sn.getTelphone()) %>"</td></tr>
			<tr><td align='right'><em>*</em>邮    编：</td><td><input type="text" name="zip" alt="邮编" value="<%=MT.f(sn.getZip()) %>" /></td></tr>
			<tr><td align='right'><em>*</em>地    址：</td><td><input type="text" name="address" alt="地址" value="<%=MT.f(sn.getAddress()) %>" /></td></tr>
		</table></div></td></tr>
		<tr><td></td><td class='bnts2'><input type="submit" value="保存发票信息" /></td></tr>
	</table>
</form>
</div> --%>

<form name="form5" action="/ShopOrders.do" method="post" target="_ajax" onsubmit="return mt.check(this)">
<div class='f-tables'>
	<h3>备注</h3>
		<table>
			<tr>
				<td>&nbsp;</td>
				<td>
					<textarea  name="userRemarks" rows="6" cols="100"></textarea>
<!-- 					<textarea name="userRemarks" rows="" cols=""></textarea>
 -->
				</td>
			</tr>
		</table>
</div>
		<input type="hidden" name="act" value="submit" />
		<input type="hidden" name="nexturl" value="/html/folder/14110391-1.htm" />
		<input type="hidden"  name="payType" value="" />
		<input type="hidden"  name="isLzCategory" value="" />
		<%
			Profile mp = Profile.find(h.member);//购买用户
			String malluser = "";
			if(mp.membertype==1){
				malluser = ShopHospital.find(ShopQualification.findByMember(mp.profile).hospital_id).getName();
			}else{
				malluser = mp.member;
			}
			
		%>
		<input type="hidden"  name="orderUnit" value="<%=malluser %>" />
		
		<div class='f-tables'><h3>商品清单：</h3>
			<table class="cart" cellpadding="0" cellspacing="0">
			<tr>
			  <th>商品编号</th>
			  <th>商品图片</th>
			  <th>商品名称</th>
			  <th>商品单价</th>
			  <th>商品数量</th>
			</tr>
			<%
				String[] ps=h.getCook("cart","|").split("[|]");
			
			    int checkLength = 0;
				boolean isLzCategory = false;
				boolean includeLzCar = false;
				
				float totalprice = 0.0f;
				/* if(ps.length<1){
			  		out.print("<tr><td colspan='5' align='center'>商品清单内暂时没有商品，您可以去<a href='/'>首页</a>挑选喜欢的商品，系统将自动为您跳转......<script>setTimeout(\"location='/';\",6000);</script></td></tr>");
				}else{
					
			    } */
			    //isLzCategory = ps.length==2;
		  		for(int i=1;i<ps.length;i++){
		  			String[] arr=ps[i].split("&");
		    		int checkFlag = Integer.parseInt(arr[2]);
		    		if(checkFlag==0)continue;
		    		checkLength++;
		    		//判断product_id是否商品的id，如果不是则为套装id
		    	    int product_id=Integer.parseInt(arr[0]);
		    	    int quantity=Integer.parseInt(arr[1]);//数量
		    	    
		    		ShopProduct p=ShopProduct.find(product_id);
		    		ShopPackage spage = new ShopPackage(0);
		    		List<ShopProduct> spagePList = new ArrayList<ShopProduct>();
		    	    String pname = "";
		    	    boolean isLiziClazz = false;
		    	    Calendar c = Calendar.getInstance();
		    	    c.set(Calendar.DATE, c.get(Calendar.DATE) +21);
		    	    Date maxDate = c.getTime();
		    	    
		    	    float price = 0.0f;
		    	    
		    	    if(p.isExist){
		    			  pname=p.getAnchor(h.language);
		    			  if(p.category==ShopCategory.getCategory("lzCategory"))
					      {
		    				  isLiziClazz = true;
		    				  includeLzCar = true;
					      }
		    			  Profile pf = Profile.find(h.member);
		    			  price = p.price;
		    			  if(pf.qualification==1&&p.category==ShopCategory.getCategory("lzCategory")){
		  					ShopQualification sq = ShopQualification.findByMember(h.member);
		  					if(sq.id>0){
		  						ShopPriceSet sps = ShopPriceSet.find(sq.hospital_id,p.product,0);
		  						if(sps.price>0){
		  							price=sps.price;
		  						}
		  					}				
		  				}
		  				if(pf.membertype==2){//代理商价格
		  						ShopPriceSet sps = ShopPriceSet.find(1,p.product,0);
		  						if(sps.price>0){
		  							price=sps.price;
		  						}
		  				}
		    		}else{
		    			  spage = ShopPackage.find(product_id);
		    			  pname="[套装]"+MT.f(spage.getPackageName());
		    			  ShopProduct s = ShopProduct.find(spage.getProduct_id());
		    			  //if(s.category==ShopCategory.getCategory("lzCategory"))isLiziClazz = true;
		    			  spagePList.add(0,s);
		    			  String [] sarr = spage.getProduct_link_id().split("\\|");
		    			  for(int m=1;m<sarr.length;m++){
		    				  ShopProduct s1 = ShopProduct.find(Integer.parseInt(sarr[m]));
		    				  //if(!isLiziClazz&&s1.category==ShopCategory.getCategory("lzCategory")){isLiziClazz=true;includeLzCar=true;}
		    				  spagePList.add(m,s1);
		    			  }
		    			  price = (float)spage.getSetPrice();
		    		}
		    	    totalprice+=price*quantity;
		    	    out.println("<tr><td>");
		    		if(p.isExist)
		    		    out.println(p.yucode);
		    		out.println("</td>");
		    		out.println("<td>");
		    		if(p.isExist)
		  			  out.println(p.getAnchor('t'));
		    		out.println("</td>");
		    		out.println("<td>"+pname);
		    		if(isLiziClazz){
		    			StringBuffer caliBuff = new StringBuffer("<span class='calidate'>");
		    			if(p.model_id>0){
			    	    	ShopProductModel spm = ShopProductModel.find(p.model_id);
			    	    	String activityStr = spm.getModel().replaceAll("[a-zA-Z]","");
							if(activityStr.contains("[")){
								activityStr = activityStr.split("\\[")[0];
							}
			    	    	if(activityStr.indexOf("-")!=-1){
			    	    		String[] activityArr = activityStr.split("-");
			    	    		Double activityMin =  Double.parseDouble(activityArr[0]);
			    	    		Double activityMax =  Double.parseDouble(activityArr[1]);
			    	    		caliBuff.append(" 粒子活度：<input alt='粒子活度' title='粒子活度范围："+activityStr+"' style='width:50px;' name='activity' value='' onkeyup=\"keyupActivity(this)\" onblur=\"blurActivity(this,"+activityMin+","+activityMax+")\" />");
			    	    	}else
			    	    		caliBuff.append(" 粒子活度：<input type='hidden' name='activity' value='"+activityStr+"' />"+activityStr);
			    	    }
			    	    //caliBuff.append("校准时间：<input alt='校准时间' name='calidate_"+product_id+"' value='' onClick='mt.date(this,false,\""+new Date()+"\",\""+maxDate+"\")' readonly style='width:100px' class='date'/>");
			    	    caliBuff.append(" 校准时间：<input alt='校准时间' name='calidate' value='' onClick='mt.date(this,false,\""+new Date()+"\",\""+maxDate+"\")' readonly style='width:100px' class='date'/>");
			    	    caliBuff.append("</span>");
		    			out.println(caliBuff.toString());
		    		}
		    		out.println("</td>");
		    		out.println("<td class='price'><span style='font-size:13px;'>&yen;</span>"+MT.f(price,2)+"</td>");
		    		out.println("<td>"+quantity+"</td>");
		    		out.println("</tr>");
		    	    
		    		if(!p.isExist){
		    			for(int n=0;n<spagePList.size();n++){
		    			    ShopProduct s1 = spagePList.get(n);
		    			    price = s1.price;
		    			    out.println("<tr class='tzP'><td>"+s1.yucode+"</td>");
		    		    	out.println("<td>"+s1.getAnchor('t')+"</td>");
		    		    	out.println("<td>"+s1.getAnchor(h.language)+"</td>");
		    		    	out.println("<td class='price'><span style='font-size:13px;'>&yen;</span>"+MT.f(price,2)+"</td>");
		    		    	out.println("<td></td>");
		    		    	out.println("</tr>");
		    			}
		    		}
		  	    }
		  		isLzCategory = checkLength==1;
				//out.println("<tr><td><td colspan='4'>"+(includeLzCar?(isLzCategory?"粒子":"有粒子不唯一"):"不是粒子")+"</tr>");
				
	    		if(isLzCategory){
	    			//根据用户id查询用户地址信息
	    			ShopOrderAddress soad = ShopOrderAddress.getObjByMember(h.member);
	    			ShopHospital hospital = ShopHospital.find(soad.getHospitalId(), 90);
	    			if(hospital.getId() > 0){
	    				out.print("<script>mt.show(\"系统提示！您所在【"+hospital.getName()+"】的资质即将到期，请尽快办理！\")</script>");
	    			}
	    		}
    		
			%>
			</table>
		</div>
		
		<input type="hidden" name="amount" value="<%=totalprice%>" />
		<input type="hidden" name="cityname" />
		<div class='yisuan'><span>应付金额：</span><strong>&yen&nbsp;<%=MT.f((double)totalprice,2)%></strong></div>
	<div class='tijiao'>
	<input type="button" onclick="mt.submit(this.form);" value="提交订单" />
	<%-- <input type="button" onclick="mt.submit(this.form);"  <%out.print(soa.getId()>0&&ps.length>0?"":"disabled"); %> value="提交订单" class='<%=soa.getId()>0&&ps.length>0?"orgbtn":"orgbtnDisabled"%>' /> --%>
	<%-- <input type="button" onclick="parent.location='/jsp/yl/shopweb/ShopOrderPayment.jsp'" <%out.print(soa.getId()>0&&sn.getId()>0&&ps.length>0?"":"disabled"); %> value="提交订单" class='orgbtn' /> --%>
	<%-- <input type="button" onclick="parent.location='/html/folder/14110391-1.htm'" <%out.print(soa.getId()>0&&sn.getId()>0&&ps.length>0?"":"disabled"); %> value="提交订单" class='orgbtn' /> --%>
	</form>
</div></div>

</div>
</div>

<script type="text/javascript">

//选择发票类型
	function selNvoice(v){
		if(v == 1){
			document.getElementById('nvoice_t').style.display = 'none';
			form3.type.value = '1';
		}else{
			document.getElementById('nvoice_t').style.display = '';
			form3.type.value = '2';
		}
		mt.fit();
	}

	//修改发货人信息
	function setAddress(){
		document.getElementById('nvoice_show').style.display = 'none';
		document.getElementById('nvoice_edit').style.display = '';
		document.getElementById('address_up').style.display = '';
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
		}else if(<%=ps.length<1%>){
			mt.show("对不起！商品清单内没有商品，不能提交订单！");
			return;
		}else{
			//includeLzCar?(isLzCategory
			var includeLzCar = <%=includeLzCar%>;
			var isLzCategory = <%=isLzCategory%>;
			if(includeLzCar){
				if(isLzCategory){
					f.isLzCategory.value=1;
				}else{
					mt.show("对不起！购物车中有粒子，而且不是单一粒子产品，不能提交订单！");
					return;
				}			
			}else{
				f.isLzCategory.value=0;
			}
			var payType=1;
			var temp = document.getElementsByName("payType");
			  for(var i=0;i<temp.length;i++)
			  {
			     if(temp[i].checked){
			    	 payType = temp[i].value;
			     }
			  }
			f.payType.value=payType;
			
			/* var cds = $("input[name^='calidate']");
			if(cds&&cds!=null&&cds!='underfind'&&cds.length>0)
			{
				for(var i=0;i<cds.length;i++){
					var cdVal = cds[i].value;
					if(cdVal==''){
						mt.show('抱歉，请先填写粒子的校准时间！！！');
						return;
					}				
				}
				
			} */
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
			f.submit();
		}
		
	};
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

function showRecipient(){
	mt.show("/jsp/yl/shopweb/RecipientSearch.jsp",2,"查询收货人",500,450);
}
mt.receive=function(id,n,m){
	form1.sor_id.value=id;
	form1.consignees.value=n;
	form1.mobile.value=m;
}

//是否为新增收货人
function onNewAdd(obj){
	if(obj.checked == true){
		form1.sor_id.value = '0';
	}else{
		form1.sor_id.value = '<%=soa.getSor_id()%>';
	}
}

mycity('<%= soa.getCity() %>');
mt.fit();

</script>
<!-- <script>
	var refer = window.parent.document.referrer;
	if(!refer){
		//parent.mt.show('非法操作！',1,'/html/folder/14102033-1.htm?community="+h.community+"');
		alert("非法操作！");
		location.href="/";
		return;
	}
</script> -->
</body>
</html>
