var page = new Object();
page.loadPage = function(options){
	this.page_size = options.page_size || 5;//每页5条数据
	this.page_size_max = options.page_size_max || 2;//下拉+分页用到
	this.pos = options.pos || 0;//页数
	this.initpos = options.pos || 0;//初始页数
	this.is_load_finish = options.is_load_finish || 0;
	this.url =  options.url || null;
	this.par = options.par || "";
	this.load_msg = options.load_msg || "加载中...";//
	this.callBackFunc = options.callBackFunc || null;//展示方法
	this.type = options.type || 0;//展示方式 0下拉 1下拉+分页 2分页 3无分页
	this.pagediv = options.pagediv || "ggpage";
	this.showtype = options.showtype || "0";//分页链接类型0跳转 1ajax
	this.showfun = options.showfun || "";//方法
};
var myindex;
page.loadPage.prototype.show = function(){
	var _self = this;
	$("#"+_self.pagediv).html("");
	if(_self.type!=2&&_self.type!=3){
		$("#"+_self.pagediv).html(_self.load_msg);
	}
	fn.ajax(_self.url+"&page_size="+_self.page_size+"&pos="+_self.pos,"",function(data){
		var _result = null;
		try{
			//var result = eval("(" + data + ")");
			var result = data;
			var proData = result.data_list;
			if(result.data_list==undefined){
				result.data_list = '';
			}
			_result = result;
			if(proData!=''){
				_self.callBackFunc(_result);
				var is_load_finish = result.is_load_finish;//0：可点击加载更多；1：已加载完成
				if(_self.type==3){
					
				}else{
					if(_self.type!=2){
						if(_self.type==0){
							if(is_load_finish == 0){
								var moreBtn = $("<p>加载更多</p>");
								$(moreBtn).unbind("click").bind("click",function(){
									_self.show();
								});
								$("#"+_self.pagediv).html("");
								$("#"+_self.pagediv).append(moreBtn);
							}else if(is_load_finish == 1){
								$("#"+_self.pagediv).html("已加载全部");
							}
						}else if(_self.type==1){
							if(is_load_finish == 0){
								if(_self.pos >= parseInt((_self.page_size_max * _self.page_size )+parseInt(_self.initpos))){
									fn.ajax("/gf/Members?act=getpage&pos="+_self.pos+"&sum="+result.sum+"&size="+_self.page_size,"",function(data){
										if(data.type==0){
											$("#"+_self.pagediv).html(data.data);
										}
									});
								}else{
									var moreBtn = $("<p>加载更多</p>");
									$(moreBtn).unbind("click").bind("click",function(){
										_self.show();
									});
									$("#"+_self.pagediv).html("");
									$("#"+_self.pagediv).append(moreBtn);
								}
							}else{
								fn.ajax("/gf/Members?act=getpage&pos="+_self.pos+"&sum="+result.sum+"&size="+_self.page_size,"",function(data){
									if(data.type==0){
										$("#"+_self.pagediv).html(data.data);
										$("#"+_self.pagediv).find("a").each(function(){
											var myhtml = _self.par;
											var datahref = $(this).attr("href");
											if(myhtml.indexOf("?")>0){
												datahref = datahref.replace('?','&');
											}
											if(_self.showtype==1&&_self.showfun!=""){
												var mypos = mygetParam($(this).attr("href"),"pos");
												$(this).attr("href","javascript:void(0)");
												$(this).click(function(){
													_self.showfun(mypos);
												});
											}else{
												$(this).attr("href",myhtml+datahref);
											}
										});
									}
								});
							}
						}
					}else{
						fn.ajax("/ShopHospitals.do?act=getpage&pos="+_self.pos+"&sum="+result.sum+"&size="+_self.page_size,"",function(data){
							if(data.type==0){
								$("#"+_self.pagediv).html(data.data);
								$("#"+_self.pagediv).find("a").each(function(){
									var myhtml = _self.par;
									var datahref = $(this).attr("href");
									if(myhtml.indexOf("?")>0){
										datahref = datahref.replace('?','&');
									}
									if(_self.showtype==1&&_self.showfun!=""){
										var mypos = mygetParam($(this).attr("href"),"pos");
										$(this).attr("href","javascript:void(0)");
										$(this).click(function(){
											_self.showfun(mypos);
										});
									}else{
										$(this).attr("href",myhtml+datahref);
									}
								});
							}
							
						});
					}
				}
				
				if(_self.type==1){
					if(_self.pos <= parseInt((_self.page_size_max * _self.page_size )+parseInt(_self.initpos))){
						_self.pos = parseInt(parseInt(_self.pos)+parseInt(_self.page_size));
					}
				}else{
					_self.pos = parseInt(_self.pos)+parseInt(_self.page_size);
				}
			}else{
				if(_self.type!=3){
					if(_self.pos == 0){
						_self.callBackFunc(_result);
						$("#"+_self.pagediv).html("");
					}else{
						if(_self.initpos ==_self.pos){
							_self.callBackFunc(_result);
							$("#"+_self.pagediv).html("");
						}
					}
				}else{
					_self.callBackFunc(_result);
				}
			}
		}catch(e){
			alert(e);
			_self.callBackFunc(_result);
		}
	});
};
/**
 * 从url里获取对应参数值
 * @param paramName
 * @returns {String}
 */
mygetParam = function(par,paramName) {
    var paramValue = "";
    isFound = false;
    if (par.indexOf("?") == 0 && par.indexOf("=")>1)
    {
        arrSource = par.substring(1,par.length).split("&");
        i = 0;
        while (i < arrSource.length && !isFound)
        {
            if (arrSource[i].indexOf("=") > 0)
            {
                 if (arrSource[i].split("=")[0].toLowerCase()==paramName.toLowerCase())
                 {
                    paramValue = arrSource[i].split("=")[1];
                    isFound = true;
                 }
            }
            i++;
        }   
    }
	return paramValue;
};

