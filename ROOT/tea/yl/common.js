var fn = window.fn || {} ;
fn.ajax = function(url , data , callback,asyncflag){
	var asyncvar = false;
	if(asyncflag!=undefined){
		asyncvar = true;
	}
	if(typeof data == 'string'){
		data += "&timestamp="+new Date().getTime();
	}else{
		data.timestamp = new Date().getTime();
	}
	//data += "&timestamp=1545038843047";
	var indexlayer = "";
	 $.ajax({
		url : url,
	 	type : "POST" , 
	 	dataType:"JSON" , 
	 	data : data , 
	 	async: asyncvar,
	 	beforeSend : function(){
	 		indexlayer = layer.load(1, {
	 			  shade: [0.1,'#fff'] //0.1透明度的白色背景
	 		});
	 	},
	 	success: function(d){
	 		//layer.closeAll();
	 		layer.close(indexlayer);
			callback(d) ;
         } ,
	 	complete: function(){
	 		
	 	} , 
		error : function(ex){
			layer.closeAll();
			mtDiag.show("连接超时，请重试");
		}
	 });
};

fn.ajaxjq = function(url , data , callback){
	if(typeof data == 'string'){
		data += "&timestamp="+new Date().getTime();
	}else{
		data.timestamp = new Date().getTime();
	}
	//data += "&timestamp=1545038843047";
	 $.ajax({
		url : url,
	 	type : "POST" , 
	 	dataType:"JSON" , 
	 	data : data , 
	 	beforeSend : function(){
	 	},
	 	success: function(d){
	 		//layer.closeAll();
	 		d = eval('(' + d + ')');
			callback(d) ;
         } ,
	 	complete: function(){
	 		
	 	} , 
		error : function(ex){
			alert("连接超时，请重试");
		}
	 });
};

function checkemail(email) {
	if (email.length < 1) {
		mtDiag.show("请输入邮箱");
		return false;
	}
	var reg = /^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$/;
	if (!reg.test(email)) {
		mtDiag.show("邮箱格式不正确！");
		return false;
	}
	return true;
}
