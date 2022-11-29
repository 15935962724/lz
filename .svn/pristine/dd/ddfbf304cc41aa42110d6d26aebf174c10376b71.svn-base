// ??Epams???
function Epams(){
    this.WEB_APP_NAME  = "";
}
var epams = new Epams();

/**
 * @file globals.js
 * @desription
 */

function  executesel(src,width,height,arobjput){
    style="help:no;status:no;dialogWidth:"+width+";dialogHeight:"+height;
    reval=window.showModalDialog(src,arobjput,style);//打开窗口等待返回值，赋予变量reval
    if(reval==null){
      }else{
        for(i=0;i<reval.length;i++){        
        reval[i];        
      }
      }
  }

 /********************************/
 /*增加窗口调用                    */
 /*********************************/
function addwindow(src,width,height){

		style="help:no;status:no;dialogWidth:"+width+";dialogHeight:"+height;
            	reval=window.showModalDialog(src,null,style);//打开窗口等待返回值，赋予变量reval
                if(reval=="success"){
                   document.forms[0].submit();
                  }else{
                    document.forms[0].submit();
                    }

  }
 /********************************/
 /*修改窗口调用                    */
 /*********************************/

  function updatewindow(frm,src,width,height,str){
        if (false==editObj('chk')){
            return false;
            }else{
		var url="&"+getAlldata(frm);
                url=src+url;
		style="help:no;status:no;dialogWidth:"+width+";dialogHeight:"+height;
		reval=window.showModalDialog(url,null,style);//打开窗口等待返回值，赋予变量reval
                if(reval=="success"){
                   document.forms[0].submit();
                  }else{
                    document.forms[0].submit();
                    }
        }

  }

  /********************************/
 /*用于弹出页面窗口调用，返回时不刷新当前页面   */
 /*********************************/

  function getwindow(frm,src,width,height,str){
        if (false==editObj('chk')){
            return false;
            }else{
		var url="&"+getAlldata(frm);
                url=src+url;
//                alert(url);
		style="help:no;status:no;dialogWidth:"+width+";dialogHeight:"+height;
		reval=window.showModalDialog(url,null,style);//打开窗口等待返回值，赋予变量reval
        }

  }


/********************************/
 /*提交窗口调用                    */
 /*********************************/

  function submitwindow(frm,src,str){
        if (false==editObj('chk')){
            return false;
            }else{
		var url="&"+getAlldata(frm);
                url=src+url;
                //alert(url);
                frm.action=url;
                frm.submit();

        }

  }
 /********************************/
 /*删除窗口回调                   */
 /*********************************/
 function deletewindow(frm,src){

     if (false==editObj('chk')){
            return false;
            }else{
		var url="&"+getAlldata(frm);
                url=src+url;
//                alert(url);
                frm.action=url;
        if(confirm("您确定删除该记录吗？")){

        }else{
          return false;
          }
                frm.submit();

        }

   }


/********************************/
 /*选择返回的值                    */
 /*********************************/
 function returnAlldata(obj){
     var row="";
     var flag=0;
	 var j=0;
	// alert(obj.length);
	 var temp = new Array();
     for (i=0; i<obj.length; i++ ){
        if ( obj(i).type != "submit" && obj(i).type != "reset" && obj(i).type != "button"){
            if(obj(i).type =="radio" || obj(i).type =="checkbox"){
                if (obj(i).checked){
                    flag=1;
                }else{
                	flag=0;
                }
            }else{
            	if(flag==1){
			var arinput=window.dialogArguments;
                        var selname=obj(i).name;
                        var selvalue=obj(i).value;
                            
                       for(j=0;j<arinput.length;j++){
                             var tempname=arinput[j].name;
                             if (tempname ==selname){                             
                                arinput[j].value=selvalue;
                             }
                             /*if(!isNaN(tempname.charAt(tempname.length-1))){
                                       if(selname==arinput[j].name){
                                    alert(selvalue);   

                               		arinput[j].value=selvalue;
                               }
                               }else{
                                      if(selname==tempname.substring(0,tempname.length-1)){
                               		arinput[j].value=selvalue;
                                    alert(selvalue);
                                 }
                                

                          } */
                }

                }
            }
        }
    }
   window.returnValue = arinput;
   self.close();
 }






 /********************************/
 /*关闭窗口                   */
 /*********************************/
function onExit()
		{
	self.close();
		}

/********************************/
/*保存，修改是调用                   */
/*********************************/
function onsave(src){
  document.forms[0].action=src;
 // alert(document.forms[0].action);
  document.forms[0].submit();

    //  self.close();
  }

//得到表单上的所有元素的值
function getAlldata(obj){
    var row="";
    var flag=0;
	//alert("dd"+obj.length)
    for (i=0; i<obj.length; i++ ){
       // alert(obj(i).type+"checked="+obj(i).type.checked);

        if ( obj(i).type != "submit" && obj(i).type != "reset" && obj(i).type != "button"){
            if(obj(i).type =="radio" || obj(i).type =="checkbox"){
                if (obj(i).checked){
                    flag=1;
                }else{
                	flag=0;
                }
            }else{
            	if(flag==1){
                	var name=obj(i).name;
                	var value=obj(i).value;
                    //    alert(value);
                	row=row+name+"="+replaceStr(value)+"&";
                }
            }
        }
    }
//    alert(row);
    return row;
}
function replaceStr(str)
{
	str = str.replace(/%/g,"%25");
	str = str.replace(/&/g,"%26");
    str = str.replace(/\\/g,"&#92;");
    str = str.replace(/</g,"&#60;");
    str = str.replace(/>/g,"&#62;");
    str = str.replace(/\"/g,"&#34;");
    str = str.replace(/ /g,"&nbsp;");

    return str;
}

function page_init()
{
	if(document.getElementById("resultset")!=null){
		formatTable();
	}
	//sortInit();
}
function formatTable()
{
	var obj = document.all["resultset"];
	if (obj.length>0){
	for(var j=0; j<obj.length; j++)
        {
           var rows=obj[j].rows;
        for(var i=1;i<rows.length;i++)
	{
		if((i-1)%2==0)
	    {
			rows[i].className = "ListColorA";
	    }else
	    {
			rows[i].className = "ListColorB";
	    }
	}
        }
       }else{
         var rows=document.all.resultset.rows;
	 for(var i=1;i<rows.length;i++)
	 {
		if((i-1)%2==0)
	    {
			rows[i].className = "ListColorA";
	    }else
	    {
			rows[i].className = "ListColorB";
	    }
	 }

       }
}
function selectall(obj)
{
	if(null ==obj) return false;
 var num=obj.length;
  if(document.all("checkall").checked){
    if(num==null){obj.checked=true;}
	else{
       for (var i=0;i<num;i++)
	     obj[i].checked=true;
	}
	}
  else
  {
   if(num==null){obj.checked=false;}
   else{
     for (var i=0;i<num;i++)
      obj[i].checked=false;
  }
  }
}
//判断是否全选，如果下面的所有checkbox全部选中，则修改checkall的状态
function checkItem(checkListName, controlCheck)
{
 var aryChecked = document.all(checkListName);
 if (aryChecked != null)
 {
  if (aryChecked.length != null && aryChecked.length > 0)
  {
   var nCount = 0;
   for (var i = 0; i < aryChecked.length; i ++)
   {
    if (aryChecked[i].checked)
        nCount ++;
   }
   if (nCount == aryChecked.length) {


       controlCheck.checked = true;
	}  else{
       controlCheck.checked = false;
 	}
  }
  else
  {
   controlCheck.checked = aryChecked.checked;
  }
 }
}
//只能选择一个
function editObj(name) {
    var checkObj = document.all(name);
    if (checkObj) {
      if (checkObj.length) {
        for (var i=0,j=0;i<checkObj.length && j<=2;i++) {
          if (checkObj[i].checked) {
            j++;
          }
        }
        if (j > 1) {
          alert("只能选择一条业务数据");
          return false;
        } else if (j == 0) {
          alert("请选择业务数据");
          return false;
        }
      } else {
        if (! checkObj.checked) {
          alert("请选择业务数据");
          return false;
        }
      }
    } else {
      alert("当前没有选中的业务数据");
      return false;
    }

	return true;
  }

/**
 *输出两个等待层，并显示出来。
 */
document.write("<div id=\"Layer300\" style=\"position:absolute;z-index:900;top:0;left:0;width:100%;height:100%;background-image:url('about:blank');\"><table width=100% height=100%><tr><td align=center><center><div><iframe width=201px height=101px></iframe></div></center></td></tr></table></div>");
document.write("<div id=\"Layer400\" style=\"position:absolute;z-index:990;top:0;left:0;width:100%;height:100%;background-image:url('about:blank');FILTER: progid:DXImageTransform.Microsoft.Alpha( style=0,opacity=55); color: darkred; background-color: #D6D3CE\"><table width=100% height=100%><tr><td align=center><center><span style=\"width:200px;height:100px;border:1px blue solid;border-width:3;border-style:double; background:white;\"><table width=100% height=100% ><tr><td align=center>正在处理数据,请稍候<marquee direction='right' scrollamount='5' scrolldelay='100' width=15px>......</marquee></td></tr></table></span></center></td></tr></table></div>");
estate('none');//等待消失
function openWaitWin() {
	estate('display');//等待
}

function estate( sign ) {
	if(sign=='display') {
		Layer400.style.visibility = "visible";
		Layer300.style.visibility = "visible";
		for(var i=0; i<document.all.length; i++)
		if(document.all[i].tagName == 'SELECT' && document.all[i].dataFld != "rec_status" && document.all[i].dataFld != "display_type") document.all[i].disabled = true;
	}
	if(sign=='none') {
		Layer400.style.visibility = "hidden";
		Layer300.style.visibility = "hidden";
		for(var i=0; i<document.all.length; i++)
		if(document.all[i].tagName == 'SELECT' && document.all[i].dataFld != "rec_status" && document.all[i].dataFld != "display_type") document.all[i].disabled = false;
	}
}

//必须有选中
function delObj(name) {
    var checkObj = document.all(name);   //复选框对象
    if (checkObj) {
      if (checkObj.length) {
        for (var i=0,j=0;i<checkObj.length;i++) {
          if (checkObj[i].checked) {
            j++;
            break;
          }
        }
        if (j == 0) {
          alert("请选择要删除的业务数据");
          return false;
        }
      } else {
        if (!checkObj.checked) {
          alert("请选择要删除的业务数据");
          return false;
        }
      }
    } else {
      alert("当前没有可删除的业务数据");
      return false;
    }
     return true;
  }
/***************************************************************************/
/**************************************************************************/
/**得到当前行的数据
*@param obj object
*/
function getRowData(obj){
	//get the parent element(TD)
	var obj_col=obj.parentElement;
	if (obj_col==null)
	{
		return;
	}
	//get the parent element again(TR)
	var obj_row=obj_col.parentElement;
	if (obj_row==null)
	{
		return;
	}
	//keep the data of the current line
	var rowData=new Array();
	var iLength=obj_row.childNodes.length;
	var iNum=0;
	for (var i=0;i<iLength;i++)
	{
		//rowData[iNum]=obj_row.childNodes(i).childNodes(0).value;
		rowData[iNum]=obj_row.childNodes(i).innerText;
		iNum++;
	}
	return rowData;
}

//得到要编辑的数据（1条）name:checkbox的name
function getEditData(name){
  var obj=document.all.tags("input");
  var rowdata = null;
	var str="";
	for(var i=0;i<obj.length;i++)
	{
      if(obj[i].type == "checkbox"){

        if( obj[i].name == name && obj[i].checked){
      		rowdata = getRowData(obj[i]);
              break;
        }
      }
	}
  return rowdata;
}

/**校验同名的radio是否有被选中
*  @param objRadio 同名的radio
*  @return true/false/null 有被选中/没有被选中/对象不存在
*  @author zhouzm
*/
function checkRadio(objRadio){
    if(objRadio==undefined)
	return null;
	if(objRadio.length==undefined){
		return objRadio.checked;
	}else{
		for(var i=0;i<objRadio.length;i++){
		 if(objRadio[i].checked)
			return true;
		}
		return false;
	}
}

/**校验同名的radio是否有被选中
*  @param objRadio 同名的radio
*  @return true/false/null 有被选中/没有被选中/对象不存在
*  @author zhouzm
*/
function checkRadio(objRadio){
    if(objRadio==undefined)
	return true;
	if(objRadio.length==undefined){
		return objRadio.checked;
	}else{
		for(var i=0;i<objRadio.length;i++){
		 if(objRadio[i].checked)
			return true;
		}
		return false;
	}
}

//==================================================== 参数设定部分 =======================================================
var bMoveable=true;		//设置日历是否可以拖动
var _VersionInfo="Version:2.0&#13;2.0作者:walkingpoison&#13;1.0作者: F.R.Huang(meizz)&#13;MAIL: meizz@hzcnc.com"	//版本信息

//==================================================== WEB 页面显示部分 =====================================================
var strFrame;		//存放日历层的HTML代码
document.writeln('<iframe id=meizzDateLayer Author=wayx frameborder=0 style="position: absolute; width: 144; height: 211; z-index: 9998; display: none"></iframe>');
strFrame='<style>';
strFrame+='INPUT.button{BORDER-RIGHT: #ff9900 1px solid;BORDER-TOP: #ff9900 1px solid;BORDER-LEFT: #ff9900 1px solid;';
strFrame+='BORDER-BOTTOM: #ff9900 1px solid;BACKGROUND-COLOR: #fff8ec;font-family:宋体;}';
strFrame+='TD{FONT-SIZE: 9pt;font-family:宋体;}';
strFrame+='</style>';
strFrame+='<scr' + 'ipt>';
strFrame+='var datelayerx,datelayery;	/*存放日历控件的鼠标位置*/';
strFrame+='var bDrag;	/*标记是否开始拖动*/';
strFrame+='function document.onmousemove()	/*在鼠标移动事件中，如果开始拖动日历，则移动日历*/';
strFrame+='{if(bDrag && window.event.button==1)';
strFrame+='	{var DateLayer=parent.document.all.meizzDateLayer.style;';
strFrame+='		DateLayer.posLeft += window.event.clientX-datelayerx;/*由于每次移动以后鼠标位置都恢复为痴思的位置，因此写法与div中不同*/';
strFrame+='		DateLayer.posTop += window.event.clientY-datelayery;}}';
strFrame+='function DragStart()		/*开始日历拖动*/';
strFrame+='{var DateLayer=parent.document.all.meizzDateLayer.style;';
strFrame+='	datelayerx=window.event.clientX;';
strFrame+='	datelayery=window.event.clientY;';
strFrame+='	bDrag=true;}';
strFrame+='function DragEnd(){		/*结束日历拖动*/';
strFrame+='	bDrag=false;}';
strFrame+='</scr' + 'ipt>';
strFrame+='<div style="z-index:9999;position: absolute; left:0; top:0;" onselectstart="return false"><span id=tmpSelectYearLayer Author=wayx style="z-index: 9999;position: absolute;top: 3; left: 19;display: none"></span>';
strFrame+='<span id=tmpSelectMonthLayer Author=wayx style="z-index: 9999;position: absolute;top: 3; left: 78;display: none"></span>';
strFrame+='<table border=1 cellspacing=0 cellpadding=0 width=142 height=160 bordercolor=#ff9900 bgcolor=#ff9900 Author="wayx">';
strFrame+='  <tr Author="wayx"><td width=142 height=23 Author="wayx" bgcolor=#FFFFFF><table border=0 cellspacing=1 cellpadding=0 width=140 Author="wayx" height=23>';
strFrame+='      <tr align=center Author="wayx"><td width=16 align=center bgcolor=#ff9900 style="font-size:12px;cursor: hand;color: #ffffff" ';
strFrame+='        onclick="parent.meizzPrevM()" title="向前翻 1 月" Author=meizz><b Author=meizz>&lt;</b>';
strFrame+='        </td><td width=60 align=center style="font-size:12px;cursor:default" Author=meizz ';
strFrame+='onmouseover="style.backgroundColor=\'#FFD700\'" onmouseout="style.backgroundColor=\'white\'" ';
strFrame+='onclick="parent.tmpSelectYearInnerHTML(this.innerText.substring(0,4))" title="点击这里选择年份"><span Author=meizz id=meizzYearHead></span></td>';
strFrame+='<td width=48 align=center style="font-size:12px;cursor:default" Author=meizz onmouseover="style.backgroundColor=\'#FFD700\'" ';
strFrame+=' onmouseout="style.backgroundColor=\'white\'" onclick="parent.tmpSelectMonthInnerHTML(this.innerText.length==3?this.innerText.substring(0,1):this.innerText.substring(0,2))"';
strFrame+='        title="点击这里选择月份"><span id=meizzMonthHead Author=meizz></span></td>';
strFrame+='        <td width=16 bgcolor=#ff9900 align=center style="font-size:12px;cursor: hand;color: #ffffff" ';
strFrame+='         onclick="parent.meizzNextM()" title="向后翻 1 月" Author=meizz><b Author=meizz>&gt;</b></td></tr>';
strFrame+='    </table></td></tr>';
strFrame+='  <tr Author="wayx"><td width=142 height=18 Author="wayx">';
strFrame+='<table border=1 cellspacing=0 cellpadding=0 bgcolor=#ff9900 ' + (bMoveable? 'onmousedown="DragStart()" onmouseup="DragEnd()"':'');
strFrame+=' BORDERCOLORLIGHT=#FF9900 BORDERCOLORDARK=#FFFFFF width=140 height=20 Author="wayx" style="cursor:' + (bMoveable ? 'move':'default') + '">';
strFrame+='<tr Author="wayx" align=center valign=bottom><td style="font-size:12px;color:#FFFFFF" Author=meizz>日</td>';
strFrame+='<td style="font-size:12px;color:#FFFFFF" Author=meizz>一</td><td style="font-size:12px;color:#FFFFFF" Author=meizz>二</td>';
strFrame+='<td style="font-size:12px;color:#FFFFFF" Author=meizz>三</td><td style="font-size:12px;color:#FFFFFF" Author=meizz>四</td>';
strFrame+='<td style="font-size:12px;color:#FFFFFF" Author=meizz>五</td><td style="font-size:12px;color:#FFFFFF" Author=meizz>六</td></tr>';
strFrame+='</table></td></tr><!-- Author:F.R.Huang(meizz) http://www.meizz.com/ mail: meizz@hzcnc.com 2002-10-8 -->';
strFrame+='  <tr Author="wayx"><td width=142 height=120 Author="wayx">';
strFrame+='    <table border=1 cellspacing=2 cellpadding=0 BORDERCOLORLIGHT=#FF9900 BORDERCOLORDARK=#FFFFFF bgcolor=#fff8ec width=140 height=120 Author="wayx">';
var n=0; for (j=0;j<5;j++){ strFrame+= ' <tr align=center Author="wayx">'; for (i=0;i<7;i++){
strFrame+='<td width=20 height=20 id=meizzDay'+n+' style="font-size:12px" Author=meizz onclick=parent.meizzDayClick(this.innerText,0)></td>';n++;}
strFrame+='</tr>';}
strFrame+='      <tr align=center Author="wayx">';
for (i=35;i<39;i++)strFrame+='<td width=20 height=20 id=meizzDay'+i+' style="font-size:12px" Author=wayx onclick="parent.meizzDayClick(this.innerText,0)"></td>';
strFrame+='        <td colspan=3 align=right Author=meizz><span onclick=parent.closeLayer() style="font-size:12px;cursor: hand"';
strFrame+='         Author=meizz title="' + _VersionInfo + '"><u>关闭</u></span>&nbsp;</td></tr>';
strFrame+='    </table></td></tr><tr Author="wayx"><td Author="wayx">';
strFrame+='        <table border=0 cellspacing=1 cellpadding=0 width=100% Author="wayx" bgcolor=#FFFFFF>';
strFrame+='          <tr Author="wayx"><td Author=meizz align=left><input Author=meizz type=button class=button value="<<" title="向前翻 1 年" onclick="parent.meizzPrevY()" ';
strFrame+='             onfocus="this.blur()" style="font-size: 12px; height: 20px"><input Author=meizz class=button title="向前翻 1 月" type=button ';
strFrame+='             value="< " onclick="parent.meizzPrevM()" onfocus="this.blur()" style="font-size: 12px; height: 20px"></td><td ';
strFrame+='             Author=meizz align=center><input Author=meizz type=button class=button value=今天 onclick="parent.meizzToday()" ';
strFrame+='             onfocus="this.blur()" title="当前日期" style="font-size: 12px; height: 20px; cursor:hand"></td><td ';
strFrame+='             Author=meizz align=right><input Author=meizz type=button class=button value=" >" onclick="parent.meizzNextM()" ';
strFrame+='             onfocus="this.blur()" title="向后翻 1 月" class=button style="font-size: 12px; height: 20px"><input ';
strFrame+='             Author=meizz type=button class=button value=">>" title="向后翻 1 年" onclick="parent.meizzNextY()"';
strFrame+='             onfocus="this.blur()" style="font-size: 12px; height: 20px"></td>';
strFrame+='</tr></table></td></tr></table></div>';

window.frames.meizzDateLayer.document.writeln(strFrame);
window.frames.meizzDateLayer.document.close();		//解决ie进度条不结束的问题

//==================================================== WEB 页面显示部分

var outObject;
var outButton;		//点击的按钮
var outDate="";		//存放对象的日期
var odatelayer=window.frames.meizzDateLayer.document.all;		//存放日历对象
function setday(tt,obj) //主调函数
{
	if (arguments.length >  2){alert("对不起！传入本控件的参数太多！");return;}
	if (arguments.length == 0){alert("对不起！您没有传回本控件任何参数！");return;}
	var dads  = document.all.meizzDateLayer.style;
	var th = tt;
	var ttop  = tt.offsetTop;     //TT控件的定位点高
	var thei  = tt.clientHeight;  //TT控件本身的高
	var tleft = tt.offsetLeft;    //TT控件的定位点宽
	var ttyp  = tt.type;          //TT控件的类型
	while (tt = tt.offsetParent){ttop+=tt.offsetTop; tleft+=tt.offsetLeft;}
	dads.top  = (ttyp=="image")? ttop+thei : ttop+thei+6;
	dads.left = tleft;
	outObject = (arguments.length == 1) ? th : obj;
	outButton = (arguments.length == 1) ? null : th;	//设定外部点击的按钮
	//根据当前输入框的日期显示日历的年月
	var reg = /^(\d+)-(\d{1,2})-(\d{1,2})$/;
	var r = outObject.value.match(reg);
	if(r!=null){
		r[2]=r[2]-1;
		var d= new Date(r[1], r[2],r[3]);
		if(d.getFullYear()==r[1] && d.getMonth()==r[2] && d.getDate()==r[3]){
			outDate=d;		//保存外部传入的日期
		}
		else outDate="";
			meizzSetDay(r[1],r[2]+1);
	}
	else{
		outDate="";
		meizzSetDay(new Date().getFullYear(), new Date().getMonth() + 1);
	}
	dads.display = '';

	event.returnValue=false;
}

var MonHead = new Array(12);    		   //定义阳历中每个月的最大天数
    MonHead[0] = 31; MonHead[1] = 28; MonHead[2] = 31; MonHead[3] = 30; MonHead[4]  = 31; MonHead[5]  = 30;
    MonHead[6] = 31; MonHead[7] = 31; MonHead[8] = 30; MonHead[9] = 31; MonHead[10] = 30; MonHead[11] = 31;

var meizzTheYear=new Date().getFullYear(); //定义年的变量的痴思值
var meizzTheMonth=new Date().getMonth()+1; //定义月的变量的痴思值
var meizzWDay=new Array(39);               //定义写日期的数组

/*
function document.onclick() //任意点击时关闭该控件	//ie6的情况可以由下面的切换焦点处理代替
{
  with(window.event)
  { if (srcElement.getAttribute("Author")==null && srcElement != outObject && srcElement != outButton)
    closeLayer();
  }
}

function document.onkeyup()		//按Esc键关闭，切换焦点关闭
  {

    if (window.event.keyCode==27){
		if(outObject)outObject.blur();
		closeLayer();
	}
	else if(document.activeElement)
		if(document.activeElement.getAttribute("Author")==null && document.activeElement != outObject && document.activeElement != outButton)
		{
			closeLayer();
		}
  }
*/
function meizzWriteHead(yy,mm)  //往 head 中写入当前的年与月
  {
	odatelayer.meizzYearHead.innerText  = yy + " 年";
    odatelayer.meizzMonthHead.innerText = mm + " 月";
  }

function tmpSelectYearInnerHTML(strYear) //年份的下拉框
{
  if (strYear.match(/\D/)!=null){alert("年份输入参数不是数字！");return;}
  var m = (strYear) ? strYear : new Date().getFullYear();
  if (m < 1000 || m > 9999) {alert("年份值不在 1000 到 9999 之间！");return;}
  var n = m - 100;
  if (n < 1000) n = 1000;
  if (n + 26 > 9999) n = 9974;
  var s = "<select Author=meizz name=tmpSelectYear style='font-size: 12px' "
     s += "onblur='document.all.tmpSelectYearLayer.style.display=\"none\"' "
     s += "onchange='document.all.tmpSelectYearLayer.style.display=\"none\";"
     s += "parent.meizzTheYear = this.value; parent.meizzSetDay(parent.meizzTheYear,parent.meizzTheMonth)'>\r\n";
  var selectInnerHTML = s;
  for (var i = n; i < n + 200; i++)
  {
    if (i == m)
       {selectInnerHTML += "<option Author=wayx value='" + i + "' selected>" + i + "年" + "</option>\r\n";}
    else {selectInnerHTML += "<option Author=wayx value='" + i + "'>" + i + "年" + "</option>\r\n";}
  }
  selectInnerHTML += "</select>";
  odatelayer.tmpSelectYearLayer.style.display="";
  odatelayer.tmpSelectYearLayer.innerHTML = selectInnerHTML;
  odatelayer.tmpSelectYear.focus();
}

function tmpSelectMonthInnerHTML(strMonth) //月份的下拉框
{
  if (strMonth.match(/\D/)!=null){alert("月份输入参数不是数字！");return;}
  var m = (strMonth) ? strMonth : new Date().getMonth() + 1;
  var s = "<select Author=meizz name=tmpSelectMonth style='font-size: 12px' "
     s += "onblur='document.all.tmpSelectMonthLayer.style.display=\"none\"' "
     s += "onchange='document.all.tmpSelectMonthLayer.style.display=\"none\";"
     s += "parent.meizzTheMonth = this.value; parent.meizzSetDay(parent.meizzTheYear,parent.meizzTheMonth)'>\r\n";
  var selectInnerHTML = s;
  for (var i = 1; i < 13; i++)
  {
    if (i == m)
       {selectInnerHTML += "<option Author=wayx value='"+i+"' selected>"+i+"月"+"</option>\r\n";}
    else {selectInnerHTML += "<option Author=wayx value='"+i+"'>"+i+"月"+"</option>\r\n";}
  }
  selectInnerHTML += "</select>";
  odatelayer.tmpSelectMonthLayer.style.display="";
  odatelayer.tmpSelectMonthLayer.innerHTML = selectInnerHTML;
  odatelayer.tmpSelectMonth.focus();
}

function closeLayer()               //这个层的关闭
  {
    document.all.meizzDateLayer.style.display="none";
  }

function IsPinYear(year)            //判断是否闰平年
  {
    if (0==year%4&&((year%100!=0)||(year%400==0))) return true;else return false;
  }

function GetMonthCount(year,month)  //闰年二月为29天
  {
    var c=MonHead[month-1];if((month==2)&&IsPinYear(year)) c++;return c;
  }

function GetDOW(day,month,year)     //求某天的星期几
  {
    var dt=new Date(year,month-1,day).getDay()/7; return dt;
  }

function meizzPrevY()  //往前翻 Year
  {
    if(meizzTheYear > 999 && meizzTheYear <10000){meizzTheYear--;}
    else{alert("年份超出范围（1000-9999）！");}
    meizzSetDay(meizzTheYear,meizzTheMonth);
  }
function meizzNextY()  //往后翻 Year
  {
    if(meizzTheYear > 999 && meizzTheYear <10000){meizzTheYear++;}
    else{alert("年份超出范围（1000-9999）！");}
    meizzSetDay(meizzTheYear,meizzTheMonth);
  }
function meizzToday()  //Today Button
  {
	var today;
    meizzTheYear = new Date().getFullYear();
    meizzTheMonth = new Date().getMonth()+1;
    if(meizzTheMonth < 10)
    meizzTheMonth = "0" + meizzTheMonth;
    today=new Date().getDate();
    //meizzSetDay(meizzTheYear,meizzTheMonth);
    if(outObject){
		outObject.value=meizzTheYear + "-" + meizzTheMonth + "-" + today;
    }
    closeLayer();
  }
function meizzPrevM()  //往前翻月份
  {
    if(meizzTheMonth>1){meizzTheMonth--}else{meizzTheYear--;meizzTheMonth=12;}
    meizzSetDay(meizzTheYear,meizzTheMonth);
  }
function meizzNextM()  //往后翻月份
  {
    if(meizzTheMonth==12){meizzTheYear++;meizzTheMonth=1}else{meizzTheMonth++}
    meizzSetDay(meizzTheYear,meizzTheMonth);
  }

function meizzSetDay(yy,mm)   //主要的写程序**********
{
  meizzWriteHead(yy,mm);
  //设置当前年月的公共变量为传入值
  meizzTheYear=yy;
  meizzTheMonth=mm;

  for (var i = 0; i < 39; i++){meizzWDay[i]=""};  //将显示框的内容全部清空
  var day1 = 1,day2=1,firstday = new Date(yy,mm-1,1).getDay();  //某月第一天的星期几
  for (i=0;i<firstday;i++)meizzWDay[i]=GetMonthCount(mm==1?yy-1:yy,mm==1?12:mm-1)-firstday+i+1	//上个月的最后几天
  for (i = firstday; day1 < GetMonthCount(yy,mm)+1; i++){meizzWDay[i]=day1;day1++;}
  for (i=firstday+GetMonthCount(yy,mm);i<39;i++){meizzWDay[i]=day2;day2++}
  for (i = 0; i < 39; i++)
  { var da = eval("odatelayer.meizzDay"+i)     //书写新的一个月的日期星期排列
    if (meizzWDay[i]!="")
      {
		//痴思化边框
		da.borderColorLight="#FF9900";
		da.borderColorDark="#FFFFFF";
		if(i<firstday)		//上个月的部分
		{
			da.innerHTML="<b><font color=gray>" + meizzWDay[i] + "</font></b>";
			da.title=(mm==1?12:mm-1) +"月" + meizzWDay[i] + "日";
			da.onclick=Function("meizzDayClick(this.innerText,-1)");
			if(!outDate)
				da.style.backgroundColor = ((mm==1?yy-1:yy) == new Date().getFullYear() &&
					(mm==1?12:mm-1) == new Date().getMonth()+1 && meizzWDay[i] == new Date().getDate()) ?
					 "#FFD700":"#e0e0e0";
			else
			{
				da.style.backgroundColor =((mm==1?yy-1:yy)==outDate.getFullYear() && (mm==1?12:mm-1)== outDate.getMonth() + 1 &&
				meizzWDay[i]==outDate.getDate())? "#00ffff" :
				(((mm==1?yy-1:yy) == new Date().getFullYear() && (mm==1?12:mm-1) == new Date().getMonth()+1 &&
				meizzWDay[i] == new Date().getDate()) ? "#FFD700":"#e0e0e0");
				//将选中的日期显示为凹下去
				if((mm==1?yy-1:yy)==outDate.getFullYear() && (mm==1?12:mm-1)== outDate.getMonth() + 1 &&
				meizzWDay[i]==outDate.getDate())
				{
					da.borderColorLight="#FFFFFF";
					da.borderColorDark="#FF9900";
				}
			}
		}
		else if (i>=firstday+GetMonthCount(yy,mm))		//下个月的部分
		{
			da.innerHTML="<b><font color=gray>" + meizzWDay[i] + "</font></b>";
			da.title=(mm==12?1:mm+1) +"月" + meizzWDay[i] + "日";
			da.onclick=Function("meizzDayClick(this.innerText,1)");
			if(!outDate)
				da.style.backgroundColor = ((mm==12?yy+1:yy) == new Date().getFullYear() &&
					(mm==12?1:mm+1) == new Date().getMonth()+1 && meizzWDay[i] == new Date().getDate()) ?
					 "#FFD700":"#e0e0e0";
			else
			{
				da.style.backgroundColor =((mm==12?yy+1:yy)==outDate.getFullYear() && (mm==12?1:mm+1)== outDate.getMonth() + 1 &&
				meizzWDay[i]==outDate.getDate())? "#00ffff" :
				(((mm==12?yy+1:yy) == new Date().getFullYear() && (mm==12?1:mm+1) == new Date().getMonth()+1 &&
				meizzWDay[i] == new Date().getDate()) ? "#FFD700":"#e0e0e0");
				//将选中的日期显示为凹下去
				if((mm==12?yy+1:yy)==outDate.getFullYear() && (mm==12?1:mm+1)== outDate.getMonth() + 1 &&
				meizzWDay[i]==outDate.getDate())
				{
					da.borderColorLight="#FFFFFF";
					da.borderColorDark="#FF9900";
				}
			}
		}
		else		//本月的部分
		{
			da.innerHTML="<b>" + meizzWDay[i] + "</b>";
			da.title=mm +"月" + meizzWDay[i] + "日";
			da.onclick=Function("meizzDayClick(this.innerText,0)");		//给td赋予onclick事件的处理
			//如果是当前选择的日期，则显示亮蓝色的背景；如果是当前日期，则显示暗黄色背景
			if(!outDate)
				da.style.backgroundColor = (yy == new Date().getFullYear() && mm == new Date().getMonth()+1 && meizzWDay[i] == new Date().getDate())?
					"#FFD700":"#e0e0e0";
			else
			{
				da.style.backgroundColor =(yy==outDate.getFullYear() && mm== outDate.getMonth() + 1 && meizzWDay[i]==outDate.getDate())?
					"#00ffff":((yy == new Date().getFullYear() && mm == new Date().getMonth()+1 && meizzWDay[i] == new Date().getDate())?
					"#FFD700":"#e0e0e0");
				//将选中的日期显示为凹下去
				if(yy==outDate.getFullYear() && mm== outDate.getMonth() + 1 && meizzWDay[i]==outDate.getDate())
				{
					da.borderColorLight="#FFFFFF";
					da.borderColorDark="#FF9900";
				}
			}
		}
        da.style.cursor="hand"
      }
    else{da.innerHTML="";da.style.backgroundColor="";da.style.cursor="default"}
  }
}

function meizzDayClick(n,ex)  //点击显示框选取日期，主输入函数*************
{
  var yy=meizzTheYear;
  var mm = parseInt(meizzTheMonth)+ex;	//ex表示偏移量，用于选择上个月份和下个月份的日期
	//判断月份，并进行对应的处理
	if(mm<1){
		yy--;
		mm=12+mm;
	}
	else if(mm>12){
		yy++;
		mm=mm-12;
	}

  if (mm < 10){mm = "0" + mm;}
  if (outObject)
  {
    if (!n) {//outObject.value="";
      return;}
    if ( n < 10){n = "0" + n;}
    outObject.value= yy + "-" + mm + "-" + n ; //注：在这里你可以输出改成你想要的格式
    closeLayer();
  }
  else {closeLayer(); alert("您所要输出的控件对象并不存在！");}
}
//====================================punblic js====================================================
/**
 * 该脚本文件提供一些公用的函数
 * @copyright bjlbs 2004
 * @author zhouzm
 * @date 2004-3-10

*/


/**去掉字符串中的所有空格
 * @param str 要去掉空格的字符串
 */
function replaceBlankAll(str){
	str=str.toString();
	if (str=="")
	{
		return;
	}
	var reg=/ /gi;
	return str.replace(reg, "");

}

/**去掉字符串中的所有空格
 * @param str 要去掉空格的字符串
 */
function replaceBlank(str){
	str=str.toString();
	if (str=="")
	{
		return;
	}
	var reg=/(^\s*|\s*$)/g;
	return str.replace(reg, "");

}

/**比较两个日期大小
 * @param max 两个日期中大的日期
 * @param min 两个日期中小的日期
 * @return true/false max大于min/max小于min
 */
function compareDate(max,min){
	var newMax = strToDate(max);
	var newMin = strToDate(min);
	if (newMax >= newMin)
	{
		return true;
	}else{
		return false;
	}
}

/**用于把一个日期string 转换成一个 Date 类型的值
*  @param strDate 要转换的字符串 ‘20020303’ 或 ‘2002-3-3’ 或 ‘2002.3.3’
*  @return 日期类型值
*/
function strToDate(strDate) {
	var tempDate = strDate;

	var index1 = tempDate.lastIndexOf(".");
	var index2 = tempDate.lastIndexOf("-");
	var index11 = tempDate.indexOf(".");
	var index22 = tempDate.indexOf("-");

	//形式如2002-2-2,2002.2.3的解析
	if ((index1 != -1) || (index2 != -1)) {
		var index3 = index1;

		if (index2 > index1) {
			index3 = index2;
		}

		index33 = index11;

		if ((index22 < index11 && index22 != -1) || (index11 == -1 && index22 != -1)) {
			index33 = index22;
		}

		var dTempDate = new Date();

		dTempDate.setYear(parseInt(tempDate.substring(0, index33), 10));
		var sTemp = parseInt(tempDate.substring(index33 + 1, index3), 10);
		dTempDate.setMonth(sTemp - 1);
		var sTemp1 = parseInt(tempDate.substring(index3 + 1, tempDate.length), 10);
		dTempDate.setDate(sTemp1);
		return dTempDate;
	//形式如20020202的解析
	} else if ((index1 == -1) && (index2 == -1) && tempDate.length == 8) {
		var dTempDate = new Date();

		dTempDate.setYear(parseInt(tempDate.substring(0, 4), 10));
		dTempDate.setMonth(parseInt(tempDate.substring(4, 6), 10) - 1);
		dTempDate.setDate(parseInt(tempDate.substring(6, 8), 10));
		return dTempDate;
	}
}

/**得到一个字符串的长度(中英数混合)
 * @param str 字符串
 * return 字符串长度
 */
function getStrLength(str){
	var num = str.length;
	var arr = str.match(/[^\x00-\x80]/ig)
	if(arr!=null)num+=arr.length;
	return num
}


/**通过身份证号码得到出生年月日
*@param str 身份证号码
*return 20000101/19990101 出生年月日
*/
function getDateForCard(str){
	var inputStr=str.toString();
	var year;
	var month;
	var day;
	if (inputStr.length==18)
	{
		year=parseInt(inputStr.substring(6,10),10).toString();
		month=parseInt(inputStr.substring(10,12),10).toString();
		day=parseInt(inputStr.substring(12,14),10).toString();
	}else{
        year=parseInt(inputStr.substring(6,8),10).toString();
		year="19"+year;
		month=parseInt(inputStr.substring(8,10),10).toString();
		day=parseInt(inputStr.substring(10,12),10).toString();
	}
	if (month.length==1)
	{
		month="0"+month;
	}
	if (day.length==1)
	{
		day="0"+day;
	}

	return year+month+day;
}

/**通过身份证号码得到性别
*@param str 身份证号码
*return 1/2 男/女
*/
function getSexForCard(str){
	var inputStr=str.toString();
	var sex;
	if (inputStr.length==18)
	{
		sex=inputStr.charAt(16);
		if (sex%2==0)
		{
			return 2;
		}else{
			return 1;
		}
	}else{
		sex=inputStr.charAt(14);
		if (sex%2==0)
		{
			return 2;
		}else{
			return 1;
		}
	}

}

/**
 * 将选中的项从左边的多选option框移到右边的多选option框
* @param form 多选option框所在的
* @param leftOption 左边的多选option框
* @param rightOption 右边的多选option框
* @param 是否全选
 */
function moveRight(form,leftOption,rightOption,isAll) {
 //alert(isAll);
 var leftSelect  = document.all(form).all(leftOption);
 var rightSelect = document.all(form).all(rightOption);
 move(leftSelect,rightSelect,isAll);
}
/**
 * 将选中的项从右边的多选option框移到左边的多选option框
* @param form 多选option框所在的
* @param leftOption 左边的多选option框
* @param rightOption 右边的多选option框
* @param 是否全选
 */
function moveLeft(form,leftOption,rightOption,isAll) {
 var leftSelect  = document.all(form).all(leftOption);
 var rightSelect = document.all(form).all(rightOption);
 move(rightSelect,leftSelect,isAll);
}
/**
  * 把数据从fromSelect多选option框中的数据，移动至toSelect多选option框中
  * @param fromSelect 提供数据的select
  * @param toSelect   接收她据的select
  * @param isAll      是否全部移动，默认为移动选中数据，true，移动所有数据
  * @return void
  */
function move(fromSelect,toSelect,isAll)  {
 //alert(isAll);
 fromOptions = fromSelect.options;
 //alert("optionsLength="+fromOptions.length);
 var toSelectLength = 0;
 if(toSelect.options) {
    toSelectLength = toSelect.options.length;
 }

if(fromOptions.length){
 if(isAll) {
   for(i=0;i<fromOptions.length;) {
       //alert(fromOptions.length+"="+fromOptions[i].value+"=["+i+"]="+fromOptions[i].text);
       var newOption = new Option(fromOptions[i].text,fromOptions[i].value,toSelectLength++);
       toSelect.add(newOption);
       fromSelect.remove(fromOptions[i].index);
   }
 } else {
   for(i=0;i<fromOptions.length;i++) {
      if(fromOptions[i].selected) {
       	  //alert(fromOptions.length+"="+fromOptions[i].value+"=["+i+"]="+fromOptions[i].text);
          var newOption =new Option(fromOptions[i].text,fromOptions[i].value,++toSelectLength);
     	  toSelect.add(newOption);
     	  fromSelect.remove(fromOptions[i].index);
          i = 0;
      }
   }
 }
}
}
/**
 * 得到选中的记录
 */
function getSelectedData(form,selectedOption) {
  var selected = document.all(form).all(selectedOption);
  var resultList = "";
  if(selected.length){
   for(i = 0;i < selected.length; i++) {
          resultList += selected[i].value + ";";
   }
  }
  return resultList;
}

/**
 * 得到选中的记录的名称
 */
function getSelectedDataName(form,selectedOption) {
  var selected = document.all(form).all(selectedOption);
  //alert(selected);
  var resultList = "";
  if(selected.length){
   for(i = 0;i < selected.length; i++) {
          resultList += selected[i].text + ";";
   }
  }
  return resultList;
}
/**
 * 校验form表单提交
 */

function checkValue(formObj){

    var obj;
    var form = formObj;
    for(i=0;i<form.elements.length; i++){

         obj=form[i];

            if(obj.isEAF=="true"){

            if(obj.type != "submit" && obj.type != "reset" && obj.type != "button" )
            {
               if(!(obj.validate())){
                    try{
                    obj.focus();
                    }catch(e){}
                    return false;
                 }
	    }



         }
    }
    return true;
}
/**
 * 控件校验
 */
function validate(obj){
  if(!obj.validate()){
    try{
        obj.focus();
    }catch(e){
    }
    return false;
  }
  return true;
}
//重置按钮的js
function clearForm(obj){
  if(obj.length){
    for(var i = 0; i < obj.length; i++){
        if ( obj(i).type != "submit" && obj(i).type != "reset" && obj(i).type != "button" ){
          if(obj(i).type == "hidden"){
            
          }else{
            obj(i).value='';
          }
        }
    }
  }else{
    if (obj.type != "submit" && obj.type != "reset" && obj.type != "button" ){
            if(obj.type == "hidden"){
                
            }else{
                obj.value='';
            }
    }
  }
}
/**
 * 关闭窗口
 */
function closeWindow(formName){
   if(confirm("确定要关闭此窗口吗？")){            
    var XMLHTTP = new ActiveXObject("Microsoft.XMLHTTP");
    XMLHTTP.open("POST", epams.WEB_APP_NAME + "/cleanSessionAction.do?name=" + formName, false);
    XMLHTTP.send("");
    location.href = epams.WEB_APP_NAME + "/Main.htm";
   }
}