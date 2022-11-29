//----------------------------------initDateDialog-----------------
var monthArray = [1,2,3,4,5,6,7,8,9,10,11,12];
var arrTime = ["04:00","04:30","05:00","05:30","06:00","06:30","07:00","07:30","08:00","08:30","09:00","09:30","10:00","10:30","11:00","11:30","12:00","12:30"
               ,"13:00","13:30","14:00","14:30","15:00","15:30","16:00","16:30","17:00","17:30","18:00","18:30","19:00","19:30","20:00"];


function initDateDialog(){
	if($('.dateDiv').attr("isEmpty")){
			var str='<div class="modal fade" id="dateDialog" tabindex="-1" role="dialog"  aria-hidden="true" style="padding:0px;">'
					+'<div class="modal-dialog"  style="width:100%;height:100%;margin:0px;padding:0px; border-radius:0px;overflow-y: scroll;">'
					+'<div class="modal-content">'
					+'<div class="modal-body"  style="height:100%;margin:0px;padding:0px;">'
					+'<div id="dateListShow">'
					+'</div>'
					+'</div>'
					+'</div>'					
					+'</div>'
					+'</div>';
	$('.dateDiv').html(str);
	$('.dateDiv').attr("isEmpty",false);
	} 
}
function initDateList(teeDate,preDays){
	$("#dateListShow").empty();
	var cur = new Date();
	for(var i=0;i<2;i++){
		var dayMs = 24*60*60*1000;
		var year = cur.getFullYear();
		var month = cur.getMonth()+i;
		if(month>11){
			month = month%12;
			year++;
		}
		initDateBody(year,month,teeDate,preDays);
		
	}
	$('.selectDate').click(function(){
		if(!$(this).hasClass("isTimeDisable")){
			var teeDate =$(this).attr("data-date");
			$('#teeDate').val(teeDate);
			$('#teeDateShow').html(toChineseDateString(teeDate));
			$('.selectDate').removeClass("isTimeActive");
			$(this).addClass("isTimeActive");
			$('#dateDialog').hide();
			//getbooking(teeDate,$("#test_select").val());
		}
	});
}

function initDateBody(fullYear,month,teeDate,preDays){
	var str = "";
	if(preDays==undefined)preDays =60;
	var outDate = formatDate(plusOrMinDays(preDays));
	var endYM = stringToDate(outDate);
	if(endYM.getFullYear()>fullYear && monthArray[endYM.getMonth()]>monthArray[month]) return false;
	var yearMonth = fullYear+'年'+monthArray[month]+"月";
	str ='<p style="font-size:18px;text-align:center;margin:10px 0px;">'+yearMonth+'</p>'
        +'<table class="table" style="margin: 0px; padding: 0px;font-size: 16px; align: center;height:50px;line-height:50px;">'
		+'<thead class="text-center">'
		+'<tr><td style="background-color:white;">周日</td><td style="background-color:white;">周一</td><td style="background-color:white;">周二</td><td style="background-color:white;">周三</td><td style="background-color:white;">周四</td><td style="background-color:white;">周五</td><td style="background-color:white;">周六</td></tr>'
		+'</thead>'
		+'<tbody>';
	if(teeDate==undefined) teeDate ="";
	var days = getMonthDays(fullYear,month);//本月有多少天
	var m_firstDay = new Date(fullYear,month,1);
	var dayOfWeek  = m_firstDay.getDay(); 
	var curDate = formatDate(new Date());
	str += '<tr style="height:20px;font-size:16px;">';
	var len = days + dayOfWeek;
	len = len%7!=0?len+(7-len%7):len;
	var flag = 0;
	for(var i=1;i<=len;i++){
		if((dayOfWeek+1)<=i) flag=flag+1;
		if(flag==0 || flag>days){
			str+='<td></td>';//<td class="kDate"></td>
		}else{
			var date = new Date(fullYear,month,flag);
			var date_str=formatDate(date);
			var isDisable = date_str<curDate || date_str > outDate?"isTimeDisable":"";
			var isTimeActive = date_str == teeDate ? "isTimeActive" : "";
			str+= '<td class="selectDate '+isDisable+' '+isTimeActive+'" data-date='+date_str+' style="text-align:center;padding-top:10px;"><a style="font-size:16px;">'+flag+'</a></td>';
		}
		if(i%7==0 && i!=len){
			str+='</tr><tr style="height:20px;">';
		}
	}
	str+='</tr></tbody></table>';
	$('#dateListShow').append(str);
}