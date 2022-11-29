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
//ShopOrderAddress soa = ShopOrderAddress.getObjByMember(member);
//发票信息
ShopNvoice sn = ShopNvoice.getObjByMember(member);

ShopQualification sqq = ShopQualification.findByMember(member);

String token = System.currentTimeMillis()+new Random().nextInt()+"";
request.getSession().setAttribute("token", token);

int product_id1 = 0;
String[] ps=h.getCook("cart","|").split("[|]");
for(int i=1;i<ps.length;i++){
	String[] arr=ps[i].split("&");
	int checkFlag = Integer.parseInt(arr[2]);
	if(checkFlag==0)continue;
	//判断product_id是否商品的id，如果不是则为套装id
   product_id1 =Integer.parseInt(arr[0]);
}
int hosid = Integer.parseInt(h.getCook(product_id1+"","0"));
System.out.println(hosid+"==="+product_id1+"--"+member);

%><!doctype html><html><head>
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
	<%-- <input type="hidden" name="id" value="<%=soa.getId() %>" /> --%>
	<input type="hidden" name="nexturl" value="/jsp/yl/shopweb/ShopOrderForm.jsp"/>
	<input type="hidden" name="act" value="orderAddress" />
	<%-- <div class='shotit'><strong>收货人信息</strong>&nbsp;&nbsp;<span id="address_up" style="display: <%=soa.getMember()>0?"":"none" %>" ><a href="#" onclick="setAddress()">修改</a></span></div>
	 --%><%-- <div class='f-tables' style='border:none;padding-bottom:0'>
		<table id="nvoice_show" style="display: <%=soa.getMember()>0?"":"none" %>">
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
	</div> --%>
	<div class='f-tables'>
		<table id="nvoice_edit" <%-- style="display: <%=soa.getMember()>0?"none":"" %>" --%>>
		<%
			if(profile.membertype == 2){
				out.print("<tr><td align='right'><em>*</em>医院名称：</td><td>");
				String [] sarr = profile.hospitals.split("\\|");
				out.print("<select name='hospital_id' alt='医院名称' onchange=selectHosp(this.options[this.options.selectedIndex]);>");
				out.print("<option value=''>--请选择--</option>");
				for(int i=1;i<sarr.length;i++){
					ShopHospital s1 = ShopHospital.find(Integer.parseInt(sarr[i]));
					/* if(soa.getHospitalId() == s1.getId())
						out.print("<option selected value='"+s1.getId()+"'>"+s1.getName()+"</option>");
					else */
						out.print("<option value='"+s1.getId()+"'>"+s1.getName()+"</option>");
				}
				out.print("</select>");
				out.print("<select name=\"department\">");
				out.print("<option value=\"无\">--请选择--</option>");
						for(int j=1;j<ShopQualification.DEPARTMENT_ARR.length;j++){
							/* if(MT.f(soa.getDepartment()).equals(ShopQualification.DEPARTMENT_ARR[j]))
								out.print("<option selected value='"+ShopQualification.DEPARTMENT_ARR[j]+"'>"+ShopQualification.DEPARTMENT_ARR[j]+"</option>");
							else */
								out.print("<option value='"+ShopQualification.DEPARTMENT_ARR[j]+"'>"+ShopQualification.DEPARTMENT_ARR[j]+"</option>");
						}
				out.print("</select>");
				out.print("</td></tr>");
			}else{
		%>
			<tr><td align='right'>医院名称：<%=MT.f(ShopHospital.find(sqq.hospital_id).getName()) %></td><td>
			 	科室：<%= (sqq.department==0?"无":ShopQualification.DEPARTMENT_ARR[sqq.department]) %>
			 	<input type="hidden" name="department" value="<%= (sqq.department==0?"":ShopQualification.DEPARTMENT_ARR[sqq.department]) %>">
			 	<script type="text/javascript">
				 	//查找收货人
					mt.send("/Members.do?act=getsign&hospital=<%=sqq.hospital_id%>",function(d)
					{
					   var sel = document.getElementById("_consignees");
					   sel.innerHTML = d;
					});
			 	</script>
			</td></tr>
		<%
			}
		%>
		
			<%-- <tr><td align='right'><em>*</em>收货人：</td>
				<td>
					<input type="hidden" name="consignees" value="<%=MT.f(soa.getConsignees()) %>"/>
					<input type="hidden" name="consignees_id" value="<%=MT.f(soa.getConsignees_id()) %>"/>
					<select name="consig" alt="收货人" id="_consignees" onchange="selectPro(this.options[this.options.selectedIndex])">
						<option><%=MT.f(soa.getConsignees(),"无") %></option>
					</select>
				</td>
			</tr> --%>
			<tr><td align='right'><em>*</em>手机号：</td><td><input type="text" readonly="readonly" class='bors' id="_mobile" name="mobile" value="" alt="手机号" /></td></tr>
			<tr><td align='right'><em>*</em>详细地址：</td><td><input type="text" readonly="readonly" style='width:420px' class='bors' id="_address" name="address" value="" alt="详细地址" /></td></tr>
			<tr><td>&nbsp;</td><td class='bnts2'><input type="submit" value="保存收货人信息" /><!-- <input type="button" onclick="mt.ajax('setAddress');" value="保存收货人信息" /> --></td></tr>
		</table>
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
</div>

<!-- 支付方式 -->
<input type="hidden" name="payType" value="2"/>

<form name="form5" action="/ShopOrders.do" method="post" target="_ajax" onsubmit="return mt.check(this)">
<div class='f-tables'>
	<h3>备注</h3>
		<table>
			<tr>
				<td>&nbsp;</td>
				<td>
					<textarea  name="userRemarks" rows="6" cols="100"></textarea>
				</td>
			</tr>
		</table>
</div>
		<input type="hidden" name="act" value="submit" />
		<input type="hidden" name="nexturl" value="/html/folder/14110391-1.htm" />
		
		<input type="hidden"  name="payType" value="" />
		<input type="hidden"  name="isLzCategory" value="" />
		<input type="hidden" name="token" value="<%=token %>" />
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
				
			
			    int checkLength = 0;
				boolean isLzCategory = false;
				boolean includeLzCar = false;
				int num=0;//数量
				float totalprice = 0.0f;
			    //isLzCategory = ps.length==2;
		  		for(int i=1;i<ps.length;i++){
		  			String[] arr=ps[i].split("&");
		    		int checkFlag = Integer.parseInt(arr[2]);
		    		if(checkFlag==0)continue;
		    		checkLength++;
		    		//判断product_id是否商品的id，如果不是则为套装id
		    	    int product_id=Integer.parseInt(arr[0]);
		    	    int quantity=Integer.parseInt(arr[1]);//数量
		    	    num=quantity;
		    	    //System.out.println("product_id=="+product_id);
		    		ShopProduct p=ShopProduct.find(product_id);
		    		ShopPackage spage = new ShopPackage(0);
		    		List<ShopProduct> spagePList = new ArrayList<ShopProduct>();
		    	    String pname = "";
		    	    boolean isLiziClazz = false;
		    	    Calendar c = Calendar.getInstance();
		    	    //c.set(Calendar.DATE, c.get(Calendar.DATE) +21);
		    	    c.set(Calendar.DATE, c.get(Calendar.DATE) +8);//2017/7/4 屈通知由21天改为8天
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
	    			
	    			/*验证医院资质是否已过期*/
	        		ShopHospital sh = ShopHospital.findcheck(soad.getHospitalId());
	    			if(sh.getId() > 0){
	    				out.print("<input type=\"hidden\"  name=\"pastdue\" value=\"0\" />");
	    			}
	    		}
	    		
			%>
			</table>
		</div>
		<input type="hidden" name="quantity" value="<%=num %>"/>
		<input type="hidden" name="amount" value="<%=totalprice%>" />
		<input type="hidden" name="cityname" />
		<div class='yisuan'><span>应付金额：</span><strong>&yen&nbsp;<%=MT.f((double)totalprice,2)%></strong></div>
	<div class='tijiao'>
	<!-- <input type="button" onclick="mt.submit(this.form)" value="提交订单" /> -->
	<!-- <input type="submit" value="提交订单" /> -->
	<input type="button" onclick="return fnsub(this.form)" value="提交订单" />
	</div>
	</form>
</div>


<script type="text/javascript">
function fncheck(){
	//alert("aaaa");
	mt.send("/ShopOrders.do?act=checkprice",function(d)
			{
	  //alert(d);
				        if(d!='0')
				        {
				        	mt.show(d+'，此商品管理员没有设置开票价格，请与管理员联系，设置开票价格后才可提交订单！');
				        	return false;
				        }else{
				        	return true;
				        }
				    });
	
	
}
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
		
		if(<%=ps.length<1%>){
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
			
			var pastdue = f.pastdue;
			if(pastdue&&pastdue.value=='0'){
				mt.show('当前医院资质已到期，不能提交订单！');
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
			
			f.submit();
			
			
			
		}
		
	};
	function fnsub(f){
		
		
		$.post("/ShopOrders.do?act=checkprice&limitdate=2017-10-1", function(data) {
			
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
			 
			 if(<%=ps.length<1%>){
					mt.show("对不起！商品清单内没有商品，不能提交订单！");
					return false;
				}else{
					//includeLzCar?(isLzCategory
					var includeLzCar = <%=includeLzCar%>;
					var isLzCategory = <%=isLzCategory%>;
					if(includeLzCar){
						if(isLzCategory){
							f.isLzCategory.value=1;
						}else{
							mt.show("对不起！购物车中有粒子，而且不是单一粒子产品，不能提交订单！");
							return false;
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
					
					var pastdue = f.pastdue;
					if(pastdue&&pastdue.value=='0'){
						mt.show('当前医院资质已到期，不能提交订单！');
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
					//判断当前医院有无未提交订单，从2017年10月1日开始算起
					
					
					
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
		
	}
}


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


