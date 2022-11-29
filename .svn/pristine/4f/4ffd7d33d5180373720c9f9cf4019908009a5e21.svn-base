<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.DbAdapter"%><%@page import="java.text.SimpleDateFormat "%>
<%@page import="tea.entity.yl.shop.*"%><%@page import="tea.entity.yl.shopnew.*"%><%@page import="tea.entity.member.Profile"%>
<%@ page import="util.Config" %>
<%@ page import="tea.entity.subscribe.PackageOrder" %>
<%@ page import="java.text.DecimalFormat" %>
<%


	Http h=new Http(request,response);
	if(h.member<1)
	{
		response.sendRedirect("/servlet/StartLogin?community="+h.community);
		return;
	}
	int menu=h.getInt("id");
	StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
	par.append("&id="+menu);

	Integer puid = h.getInt("puid");

	if(puid != null) {
		sql.append(" and puid=" + puid);
		par.append("&puid=" + puid);
	}
	Double money = h.getDouble("money");
	if(money != null) {
		par.append("&money=" + money);
	}

	int profile1 = h.getInt("profile");
	Profile p = Profile.find(profile1);
	sql.append(" and membername like "+Database.cite("%"+p.getMember()+"%"));
	par.append("&pname="+h.enc(p.getMember())+"&profile="+profile1);

	String[] ids = request.getParameterValues("ids");
	String idss = "";
	if(ids.length>0){
		for (int i = 0; i < ids.length; i++) {
			if(i==0){
				idss = idss + ids[i];
			}else{
			    idss = idss+","+ids[i];
			}
		}
		par.append("&ids=" + idss);
	}

//按医院查询

	String hname=h.get("hname","");
	if(hname.length()>0){
		sql.append(" and hospital like "+Database.cite("%"+hname+"%"));
		par.append("&hname="+h.enc(hname));
	}
//按服务商查询
	String pname=h.get("pname","");
	if(pname.length()>0){

		sql.append(" and membername like "+Database.cite("%"+pname+"%"));
		par.append("&pname="+h.enc(pname));
	}
//按开票日期查询

	Date mdate1=h.getDate("mdate1");
	if(mdate1!=null){

		sql.append(" and makeoutdate >= "+DbAdapter.cite(mdate1));
		par.append("&mdate1="+MT.f(mdate1));
	}
	Date mdate2=h.getDate("mdate2");
	if(mdate2!=null){

		sql.append(" and makeoutdate <= "+DbAdapter.cite(mdate2));
		par.append("&mdate2="+MT.f(mdate2));
	}
	//String[] TAB={"全部","待审核","待开发票","审核不通过","已开具发票","退票申请","已退票"};
	String[] SQL={""," AND status = 0 "," AND status = 1 "," AND status = 3 "," AND status = 2 "," AND status = 4 "," AND status = 5 "};

	int tab=4;
	par.append("&tab="+tab);
	sql.append(" and mateType=0");
	par.append("&mateType=0");

	int pos=h.getInt("pos");
	par.append("&pos=");

	int size=20;


%><!DOCTYPE html><html><head>
<script>
    var ls=parent.document.getElementsByTagName("HEAD")[0];
    //document.write(ls.innerHTML);
    var arr=parent.document.getElementsByTagName("LINK");
    for(var i=0;i<arr.length;i++)
    {
        document.write("<link href='"+arr[i].href+"' rel='"+arr[i].rel+"' type='text/css'>");
    }

</script>
<script src="/tea/yl/jquery-1.7.js"></script>
<script src="/tea/yl/top.js"></script>

<script src='/tea/laydate-master/laydate.dev.js'></script>
<script src="/jsp/yl/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script type="text/javascript" src="/tea/angular.min.js"></script>


</head>
<body ng-app="lz" ng-controller="lzController">
<h1>匹配订单发票</h1>
<form name="form1" action="?">
	<input type="hidden" name="id" value="<%=menu%>"/>
	<input type="hidden" name="tab" value="<%=tab%>"/>
	<div class="radiusBox">
		<table cellspacing="0" class='newTable'>
			<thead>
			<tr><td colspan='6'>查询</td></tr>
			</thead>
			<tr>
				<td>医院：<input type="text" name="hname" id="hname" value="<%=hname %>"/>
					<input id="hospitalsel" onclick="mt.show('/jsp/yl/shopnew/Selhospital_shop.jsp',1,'选择医院',500,500)" type="button" value="请选择"/>
				</td>
				<%--<%
                    if(puid == null){
                %>
                <td nowrap="">厂商：
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
				<%--<td>服务商：<input type="text" name="pname" id="pname" value="<%=pname %>"/>
					<input id="hospitalsel" onclick="mt.show('/jsp/yl/shopnew/SelProfile_shop.jsp',1,'选择服务商',500,500)" type="button" value="请选择"/>
				</td>--%>
				<td>
					开票日期：
					<input class="Wdate" onfocus="WdatePicker({readOnly:true,maxDate:'%y-%M-%d'})" id="makeoutdate" name="mdate1" value="<%= MT.f(mdate1) %>"/>
					——<input class="Wdate" onfocus="WdatePicker({readOnly:true,maxDate:'%y-%M-%d'})" id="makeoutdate" name="mdate2" value="<%= MT.f(mdate2) %>"/>
				</td>
				<td>
					<span>
						<%
							int puj_id = h.getInt("puj_id");
							String company =ProcurementUnitJoin.find(puj_id).getCompany();
						%>
						公司名称：<%=company==null?"未选择":MT.f(company)%>
					</span>
				</td>
				<td><input type="submit" class="button" value="查询"/></td>

			</tr>
		</table>
	</div>
</form>

<%--<%out.print("<div class='switch'>");
	for(int i=0;i<TAB.length;i++)
	{
		out.print("<a href='javascript:mt.tab("+i+")' class='"+(i==tab?"current":"")+"'>"+TAB[i]+"（"+Invoice.count(sql.toString()+SQL[i])+"）</a>");
	}
	out.print("</div>");
%>--%>
<form name="form2" action="/Invoices.do" method="post" target="_ajax">

	<input type="hidden" name="tab" value="<%=tab%>"/>
	<input type="hidden" name="id" value="<%=menu %>"/>
	<input type="hidden" name="nexturl"/>
	<input type="hidden" name="invoiceid" />

	<div class='radiusBox mt15'>
		<table  id="" cellspacing="0" class='newTable'>
			<thead>
			<tr><td colspan='20'>列表<span class='sum'><%out.print(Invoice.count(sql.toString()+SQL[4]));%></span><span style="float:right;padding:0px 15px;" id="totalMoney">所选发票金额:￥ <em style="color:red;display:inline-block"><%=money%></em></span><span style="float:right;" id="Money"></span></td></tr>
			</thead>
			<tr>
				<th width="60"><label><input id="all" type="checkbox" name="checkMoney" value="0">&nbsp;&nbsp;全选</label></th>
				<th>序号</th>
				<th>发票号</th>
				<th>服务商</th>
				<th>医院</th>
				<th>厂商</th>
				<th>开具发票时间</th>
				<th>申请开票数量</th>
				<th>申请开票金额</th>
				<th>计提服务费</th>
				<th>操作</th>

			</tr>
			<%
				sql.append(SQL[tab]);

				int sum=Invoice.count(sql.toString());
				if(sum<1)
				{
					out.print("<tr><td colspan='11' style='text-align:center'>暂无记录!</td></tr>");
				}else
				{

					List<Invoice> lstinvoice=Invoice.find(sql.toString()+" and member="+profile1+" order by createdate desc ", pos, size);
					for(int i=0;i<lstinvoice.size();i++)
					{
						Invoice invoice=lstinvoice.get(i);
						String statuscontent="";
						if(invoice.getStatus()==0){
							statuscontent="未开具";
						}else if(invoice.getStatus()==1){
							statuscontent="已审核";
						}else if(invoice.getStatus()==2){
							statuscontent="已开具";
						}else if(invoice.getStatus()==3){
							statuscontent="审核不通过";
						}else if(invoice.getStatus()==4){
							statuscontent="退票申请中";
						}else if(invoice.getStatus()==5){
							statuscontent="已退票";
						}
						Profile profile=Profile.find(invoice.getMember());

						int phpuid = InvoiceData.getPuid(invoice.getId());

						//ProcurementUnitJoin puj = ProcurementUnitJoin.find(phpuid, invoice.getMember());
						ProcurementUnitJoin puj = ProcurementUnitJoin.find(phpuid, invoice.getMember(),invoice.getHospitalid());
						Map<String,Double> map = Invoice.getTaxAmount(puj.tax, invoice.getId(),0.9844,1.13);
						Set<Map.Entry<String, Double>> entries = map.entrySet();
						Double taxAmount = 0.0;
						for (Map.Entry<String, Double> entry : entries) {
							Double value = entry.getValue();
							taxAmount+=value;
						}
						DecimalFormat df = new DecimalFormat("0.00"); // 取两位小数
						double taxamountNew = Double.parseDouble(df.format(taxAmount));
			%>
			<tr>
				<td>
					<label><input type='checkbox' name='checkMoney' alt="<%=taxAmount%>" ng-click=updateSelection($event,<%=invoice.getId()%>,<%=taxAmount%>) value="<%=invoice.getId()%>" /></label>
				</td>
				<td><%=pos+1+i%></td>
				<td><%=MT.f(invoice.getInvoiceno()) %></td>
				<td><%=MT.f(profile.getMember()) %></td>
				<td><%=MT.f(invoice.getHospital()) %></td>
				<td><%=MT.f(ProcurementUnit.findName(puid))%></td>
				<%--<td><%=MT.f(invoice.getCreatedate(),1) %></td>--%>
				<td><%=MT.f(invoice.getMakeoutdate(),1) %></td>
				<td><%=invoice.getNum() %></td>
				<td><%=invoice.getAmount() %></td>
				<td><%=taxamountNew %></td>
				<td>
					<a href="javascript:;" onclick="myact('data',<%=invoice.getId() %>)">查看</a>
				</td>
			</tr>
			<%
					}
					if(sum>20)out.print("<tr class='fenye'><td colspan='11' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20)+"</td></tr>");
				}%>
		</table>
	</div>
</form>
<div class='center mt15'><button class="btn btn-primary" type="button" ng-click="mateOrder()">匹配</button></div>


<script>
    form2.nexturl.value=location.pathname+location.search;
    function myact(a,invoiceid){
        form2.invoiceid.value=invoiceid;
		if(a=='data') {
            form2.action="/jsp/yl/shopnew/InvoiceDatas_shop.jsp";
            form2.target='_self';form2.method='get';form2.submit();
		}
    }

    var oids =  "";
    var ototal = 0.0;
    var app = angular.module('lz',[]);
    app.controller('lzController',function($scope,$http){
        // 发票id集合
        $scope.selectIds = [];
        $("#all").change(function(){
            $scope.selectIds = [];
            var flage =$(this).is(":checked");
            $("input[name='checkMoney']").each(function(){

                $(this).prop("checked",flage);
                var va = $(this).attr("alt");
                var id = $(this).attr("value");
                if(id != 0){
                    if(flage){
                        $scope.selectIds.push(id);
                        ototal+=Number(va);
                    }else{
                        var idx = $scope.selectIds.indexOf(id);
                        $scope.selectIds.splice(idx,1);
                        ototal-=Number(va);
                    }
                }
            })
            $("#Money").html("匹配发票金额:￥ <em style='color:red;display:inline-block'>"+ototal.toFixed(2)+"</em>");
            //console.log(total)
        });
        // 更新复选框：
        $scope.updateSelection = function($event,id,money){
            // 复选框选中
            if($event.target.checked){
                // 向数组中添加元素
                $scope.selectIds.push(id);
                ototal+=money;
                $("#Money").html("匹配发票金额:￥ <em style='color:red;display:inline-block'>"+ototal.toFixed(2)+"</em>");
                //console.log(ototal);
            }else{
                // 从数组中移除
                var idx = $scope.selectIds.indexOf(id);
                $scope.selectIds.splice(idx,1);
                ototal-=money;
                $("#Money").html("匹配发票金额:￥ <em style='color:red;display:inline-block'>"+ototal.toFixed(2)+"</em>");
                //console.log(ototal);
            }

        }
        $scope.mateOrder = function () {
            if($scope.selectIds.length>0){
                if(parseFloat(ototal) <= parseFloat(<%=money%>)){
                    layer.open({
						type: 2,
						title: '确认信息',
						area: ['80%', '80%'],
                        fixed: false, //不固定
                        maxmin: false,
						content: '/jsp/yl/shop/mateCommit.jsp?puid=<%=puid%>&money=<%=money%>&profile=<%=profile1%>&ids=<%=idss%>&oids='+$scope.selectIds+'&total='+ototal.toFixed(2)
					});
                }else{
                    mtDiag.show("订单发票不能大于服务发票金额!","msg");
				}
            }else{
                mtDiag.show("至少选择一条数据!","msg");
            }
        }
    })


</script>
</body>
</html>
