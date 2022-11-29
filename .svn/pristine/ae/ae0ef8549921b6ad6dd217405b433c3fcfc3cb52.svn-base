var valuecid=jQuery("#valuecid").val();
var valuepro=jQuery("#valuepro").val();
var valueloc=jQuery("#valueloc").val();
var valuecom=jQuery("#valuecom").val();
var valueland=jQuery("#valueland").val();

var comMap={};//商圈
var landMap={};//地标

function locationCache(cnname,enname){
	this.cnname=cnname;
	this.enname=enname;
}

/*****1.获取所有省**********/
jQuery(function(){
	//获取省市id
	document.all.selProvince.length = 0 ;
	var provinceid=jQuery("#provinceidhidden").val();
	var cityid=jQuery("#cityidhidden").val();
	

	//alert(provinceid+"=1="+cityid);
	//1.如果不传省 只传市，则省市都不显示
	if(provinceid==0){
		//如果传市的参数，则查询指定 的市下的所有区
		if(cityid!=0){
			getLocationByCity(cityid);
			jQuery("#selProvince").hide();
			jQuery("#selCity").hide();
			return;                      
		}
	}
	//2.如果传省 不传市，则省不显示，市显示
	if(provinceid!=0){
		//如果不传市的参数，则查询省下所有市
		if(cityid==0){
			getCityByProvince(provinceid,0);
			jQuery("#selProvince").hide();
		}
		//如果传市的参数，则查询指定 的市 ，并查询指定市下的所有区
		else{
			getLocationByCity(cityid);
			jQuery("#selProvince").hide();
			jQuery("#selCity").hide();
		}
		return;
	}
//alert(provinceid+"=3="+cityid);
	var url="/ProvinceServlet";
	var param={"provinceid":provinceid,"cityid":cityid,"date":new Date().getTime()};
	jQuery.getJSON(
		url,
		param,
		function(data){
			if(data.lan=='1'){
				jQuery("#selProvince").append("<option value=\"\">--请选择--</option>");
				for(var i=0;i<data.datas.length;i++){
					jQuery("#selProvince").append("<option value='"+data.datas[i].provinceid+"'>"+data.datas[i].provincename+"</option>");
					if(valuepro==data.datas[i].provinceid){
						jQuery("#selProvince").val(valuepro);
					}
				}
			}else{
				jQuery("#selProvince").append("<option value=\"\">--select--</option>");
				for(var i=0;i<data.datas.length;i++){
					jQuery("#selProvince").append("<option value='"+data.datas[i].provinceid+"'>"+data.datas[i].provinceen+"</option>");
					if(valuepro==data.datas[i].provinceid){
						jQuery("#selProvince").val(valuepro);
					}
				}
			}
			getCityByProvince(valuepro,0);
	});	
	
});

/*****2.根据省id获取所有市**********/
function getCityByProvince(provinceid,cityid){
	//provincename=jQuery.trim(provincename);
	  //清空 城市 下拉选单
    document.all.selCity.length = 0 ;
    document.all.selLocation.length = 0 ;
	var url="/CityServlet";
	var param="";
	if(cityid==0){
		param={"provinceid":provinceid,"cityid":0,"date":new Date().getTime()};
	}
	else if(provinceid==0){
		param={"provinceid":0,"cityid":cityid,"date":new Date().getTime()};
	}else{
		param={"provinceid":provinceid,"cityid":cityid,"date":new Date().getTime()};
	}
	jQuery.getJSON(
			url,
			param,
			function(data){
				
				//alert((data.lan)+"====city");
				if(data.lan=='1'){
					jQuery("#selCity").append("<option value=\"\">---请选择---</option>");
					for(var i=0;i<data.datas.length;i++){
						jQuery("#selCity").append("<option value='"+data.datas[i].cityid+"'>"+data.datas[i].cityname+"</option>");
						if(valuecid==data.datas[i].cityid){
							jQuery("#selCity").val(valuecid);
						}
					}
				}else{
					jQuery("#selCity").append("<option value=\"\">---select---</option>");
					for(var i=0;i<data.datas.length;i++){
						jQuery("#selCity").append("<option value='"+data.datas[i].cityid+"'>"+data.datas[i].cityen+"</option>");
						if(valuecid==data.datas[i].cityid){
							jQuery("#selCity").val(valuecid);
						}
					}
				}
				
				if(data.datas.length<1||data.datas.length==""){
					getLocationByCity("");
				}else{
					getLocationByCity(valuecid);
				}
				valuecid="";
		});	
}


/*****3.根据市id获取所有区**********/
function getLocationByCity(cityid){
	//清空 城市 下拉选单
	//cityid=cityid.split("|")[0];
	document.all.selLocation.length = 0 ;
	document.all.selCommericial.length = 0 ;
	document.all.selLandmark.length = 0 ;
	comMap={};
	landMap={};
	var url="/LocationServlet";
	var param={"cityid":cityid,"date":new Date().getTime()};
	jQuery.getJSON(
			url,
			param,
			function(data){
				//设置区
				if(data.lan=='1'){
					jQuery("#selLocation").append("<option value=\"\">-------请选择-------</option>");
					for(var i=0;i<data.district.length;i++){
							jQuery("#selLocation").append("<option value='"+data.district[i].locationname+"'>"+data.district[i].locationname+"</option>");
							if(valueloc==data.district[i].locationname){
								jQuery("#selLocation").val(valueloc);
							}
					}
				}else{
					jQuery("#selLocation").append("<option value=\"\">------select------</option>");
					for(var i=0;i<data.district.length;i++){
//						alert(valueloc+"===="+data.district[i].locationname+"=="+data.district[i].locationen+"===ddata.district[i].locationname 121");
						jQuery("#selLocation").append("<option value='"+data.district[i].locationname+"'>"+data.district[i].locationen+"</option>");
						if(valueloc==data.district[i].locationname){
							jQuery("#selLocation").val(valueloc);
						}
					}
				}
				
				//设置圈
				if(data.lan=='1'){
					jQuery("#selCommericial").append("<option value=\"\">-------请选择-------</option>");
					for(var i=0;i<data.commericial.length;i++){
							jQuery("#selCommericial").append("<option value='"+data.commericial[i].locationname+"'>"+data.commericial[i].locationname+"</option>");
							if(valuecom==data.commericial[i].locationname){
								jQuery("#selCommericial").val(valuecom);
							}
							var comCache=new locationCache(data.commericial[i].locationname,data.commericial[i].locationen);
							comMap[data.commericial[i].locationname]=comCache;
							//alert(data.commericial[i].locationname+"==data.commericial[i].locationname");
					}
				}else{
					jQuery("#selCommericial").append("<option value=\"\">------select------</option>");
					for(var i=0;i<data.commericial.length;i++){
//						alert(valuecom+"===="+data.commericial[i].locationname+"=="+data.commericial[i].locationen+"===ddata.commericial[i].locationname 140");
						jQuery("#selCommericial").append("<option value='"+data.commericial[i].locationname+"'>"+data.commericial[i].locationen+"</option>");
						if(valuecom==data.commericial[i].locationname){
							jQuery("#selCommericial").val(valuecom);
						}
						var comCache=new locationCache(data.commericial[i].locationname,data.commericial[i].locationen);
						comMap[data.commericial[i].locationname]=comCache;
						//alert(data.commericial[i].locationname+"==222data.commericial[i].locationname");
					}
				}
				
				//设置地标
				if(data.lan=='1'){
					jQuery("#selLandmark").append("<option value=\"\">-------请选择-------</option>");
					for(var i=0;i<data.landmark.length;i++){
							jQuery("#selLandmark").append("<option value='"+data.landmark[i].locationname+"'>"+data.landmark[i].locationname+"</option>");
							if(valueland==data.landmark[i].locationname){
								jQuery("#selLandmark").val(valueland);
							}
						var landCache=new locationCache(data.landmark[i].locationname,data.landmark[i].locationen);
						landMap[data.landmark[i].locationname]=landCache;
					}
				}else{
					jQuery("#selLandmark").append("<option value=\"\">------select------</option>");
					for(var i=0;i<data.landmark.length;i++){
//						alert(valueland+"===="+data.landmark[i].locationname+"=="+data.landmark[i].locationen+"===ddata.landmark[i].locationname 161");
						jQuery("#selLandmark").append("<option value='"+data.landmark[i].locationname+"'>"+data.landmark[i].locationen+"</option>");
						if(valueland==data.landmark[i].locationname){
							jQuery("#selLandmark").val(valueland);
						}
						var landCache=new locationCache(data.landmark[i].locationname,data.landmark[i].locationen);
						landMap[data.landmark[i].locationname]=landCache;
					}
				}
				
				if(data.district.length<1||data.district.length==""){
					//jQuery("#selLocation").append(" <option value=\"\">-------请选择------</option>");
				}
				valueloc="";
				valuecom="";
				valueland="";
			});	
	
	
	jQuery(function(){
		jQuery("#cominput").keyup(function(){
			document.all.selCommericial.length = 0 ;
			var cominputvalue=jQuery("#cominput").val();
			cominputvalue=jQuery.trim(cominputvalue);
			var languagehidden=jQuery("#languagehidden").val();
			
			if(languagehidden=='1'){
				for (var key in comMap) {
					var com=comMap[key];
					//alert(com.cnname+"=="+cominputvalue+"=="+com.indexOf(cominputvalue));
					//遍历每个名,如果包含,则添加到下拉框
					if(com.cnname.indexOf(cominputvalue)!=-1){
						jQuery("#selCommericial").append("<option value='"+com.cnname+"'>"+com.cnname+"</option>");
					}
				}
			}else{
				for (var key in comMap) {
					//alert(comMap[key].enname+"==="+comMap[key].cnname+"=="+cominputvalue+"=="+comMap[key].enname.indexOf(cominputvalue));
					//遍历每个名,如果包含,则添加到下拉框
					if(comMap[key].enname.toLowerCase().indexOf(cominputvalue.toLowerCase())!=-1){
						jQuery("#selCommericial").append("<option value='"+comMap[key].cnname+"'>"+comMap[key].enname+"</option>");
					}
				}
			}
		});
		jQuery("#landinput").keyup(function(){
			document.all.selLandmark.length = 0 ;
			var cominputvalue=jQuery("#landinput").val();
			cominputvalue=jQuery.trim(cominputvalue);
			var languagehidden=jQuery("#languagehidden").val();
			if(languagehidden=='1'){
				for (var key in landMap) {
					var com=landMap[key];
					//alert(com.cnname+"=="+cominputvalue+"=="+com.indexOf(cominputvalue));
					//遍历每个名,如果包含,则添加到下拉框
					if(com.cnname.indexOf(cominputvalue)!=-1){
						jQuery("#selLandmark").append("<option value='"+com.cnname+"'>"+com.cnname+"</option>");
					}
				}
			}else{
				for (var key in landMap) {
					//alert(comMap[key].enname+"==="+comMap[key].cnname+"=="+cominputvalue+"=="+comMap[key].enname.indexOf(cominputvalue));
					//遍历每个名,如果包含,则添加到下拉框
					if(landMap[key].enname.toLowerCase().indexOf(cominputvalue.toLowerCase())!=-1){
						jQuery("#selLandmark").append("<option value='"+landMap[key].cnname+"'>"+landMap[key].enname+"</option>");
					}
				}
			}
		});
		
	});
}