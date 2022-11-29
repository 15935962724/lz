//通用的js语句和函数

var TANGER_OCX_bDocOpen = false;
var TANGER_OCX_strOp; //标识当前操作。1:新建；2:打开编辑；3:打开阅读
var TANGER_OCX_attachName; //标识已经存在的在线编辑文档附件的名称
var TANGER_OCX_attachURL; //在线编辑文档附件的URL
var TANGER_OCX_actionURL; //表单提交到的URL
var TANGER_OCX_OBJ; //控件对象
var TANGER_OCX_key=""; //加密签章
var TANGER_OCX_Username="匿名用户";


function ActionX(caption,key,w,h)
{
  if(!caption||!key)
  {
    caption="北京怡康科技有限公司";
	key="C0C721E12E94305F3FDCFF43A09BD496FB9A8DBF";
  }
  document.write('<object id="ocx" classid="clsid:C9BC4DFF-4248-4a3c-8A49-63A7D317F404" codebase="/tea/applet/office/OfficeControl.cab#Version=5,0,0,8" width='+w+' height='+h+' onload=alert("a");>');
  document.write('<param name="MakerCaption" value="北京怡康科技有限公司">');
  document.write('<param name="MakerKey" value="75BCF10C1E911D5A40D2BE2CB7C953E2830BF904">');
  document.write('<param name="ProductCaption" value="'+caption+'">');
  document.write('<param name="ProductKey" value="'+key+'">');
  document.write("<span style=color:red>不能装载文档控件。请在检查浏览器的选项中检查浏览器的安全设置。</span>");
  document.write('<param name="Caption" value="'+caption+',欢迎使用.">');
  document.write('<param name="MenuBarStyle" value="1">');
  document.write('<param name="MenuButtonStyle" value="8">');
  document.write('<param name="BorderStyle" value="0">');
  document.write('<param name="TitleBar" value="FALSE">');
  document.write('</object>');
  var obj=$("ocx");
  if(obj!="")f_reload();
  return obj;
}

//安装后刷新网页
function f_reload()
{
  if($("ocx")!='')//null:点击了"不安装"
    setTimeout(f_reload,100);
  else
  {
    window.name='self';
    window.open(location.href,window.name);
  }
}



var sign=new Object();
sign.stamp=false;//盖章步

sign.show=function(url,obj)
{
  var j=url.indexOf("?");
  if(!obj)
  {
    if(j!=-1)//.esp
    {
      document.write("<object id='sign_ocx' classid='clsid:36B09CEA-F6CC-4971-B7B5-52CAE0810666' codebase='/tea/applet/office/ntkosigntool.cab#version=3,0,5,0'>");
      document.write("<div style=color:red>不能装载印章管理控件。请在检查浏览器的选项中检查浏览器的安全设置。</div>");
      document.write("</object>");
	  document.write("<iframe id='rtop' height='26' frameborder='0' scrolling='no' src='about:blank' style='position:absolute;margin-top:-2;'></iframe>");
    }else
    {
      document.write("<img id=sign_ocx src='about:blank' >");
    }
    obj=document.all("sign_ocx");
    obj=(obj.length?obj[obj.length-1]:obj);
  }
  if(url&&url.length>5)
  {
    try
    {
      if(obj.src)
      {
        obj.src=url;
      }else
      {
        obj.OpenFromURL(url,url.substring(j+1));//win7+ie8执行两次后，IE未响应。
	    var rtop=document.all("rtop");
	    rtop=(rtop.length?rtop[rtop.length-1]:rtop);
	    rtop.style.marginLeft=-(rtop.width=obj.width);
      }
    }catch(ex)
    {
      //window.attachEvent("onload", "sign.OpenFromURL(url,'111111')");
    }
  }
  return sign.ocx=obj;
}

/*
SendKeys "{ENTER}", False
SendKeys "{ENTER}", False
Me.ActiveWindow.Document.CommandBars("Picture").Controls("压缩图片(&C)...").Execute
*/
//取得word中的印章 'Me.ActiveWindow.Document.Shapes (0)
sign.get=function()
{
  var a=new Array();
  var sha=ocx.ActiveDocument.Shapes;
  for(var i=1;i<=sha.count;i++)
  {
    try
    {
      var alt=sha(i).AlternativeText;
      if(alt.indexOf("用户:")!=-1&&alt.indexOf("印章:")!=-1&&alt.indexOf("标识:")!=-1)
      a.push(sha(i));
    }catch(e){}
    //sha(0).PictureFormat.ColorType = 2 //印章变灰
    //sha(i).Delete();
  }
  return sign.list=a;
}

//锁定印章大小
sign.lock=function()
{
  if(sign.stamp||!sign.list)sign.get();
  for(var i=0;i<sign.list.length;i++)
  {
	var wh=arr[i].Name.split(" x ");
	if(wh.length!=2||arr[i].Width!=parseFloat(wh[0])||arr[i].Height!=parseFloat(wh[1]))
	{
	  arr[i].ScaleWidth(1, -1);
	  arr[i].ScaleHeight(1, -1);
	  try
	  {
	    arr[i].Name=arr[i].Width+" x "+arr[i].Height;
	  }catch(e){}//有两个印章，会报“没有权限”
	}

//	if(wh.length!=4||f2(arr[i].Width)!=f2(wh[0])||f2(arr[i].Height)!=f2(wh[1]))
//	{
//	  arr[i].ScaleWidth(1, -1);
//	  arr[i].ScaleHeight(1, -1);
//	  try
//	  {
//	    arr[i].Name=f2(arr[i].Width)+"x"+f2(arr[i].Height)+"x"+f2(arr[i].Left)+"x"+f2(arr[i].Top);
//	  }catch(e){}//有两个印章，会报“没有权限”
//	}
//	if(wh.length==4&&(f2(arr[i].Left)!=f2(wh[2])||f2(arr[i].Top)!=f2(wh[3])))
//	{	old=" 旧:"+arr[i].Left+"x"+arr[i].Top;
//	  arr[i].Left=f2(wh[2]);
//	  arr[i].Top=f2(wh[3]);
//	}
//	document.all("signmes").innerHTML=arr[i].Name+old+" 实际:"+arr[i].Left+"x"+arr[i].Top;
  }
  setTimeout(sign.lock,1000);
}

sign.del=function()
{
  var arr=sign.get();
  for(var i=0;i<arr.length;i++)
  {
    arr[i].Delete();
  }
}

sign.ro=function(bool)
{
ocx.SetReadOnly(bool,"redcome");
}

function f2(a)
{
 if(typeof(a)=="string")a=parseFloat(a);
 return Math.round(a*10)/10;
}


//此函数在网页装载时被调用。用来获取控件对象并保存到TANGER_OCX_OBJ
//同时，可以设置初始的菜单状况，打开初始文档等等。
function TANGER_OCX_Init(initdocurl)
{
	TANGER_OCX_OBJ = document.all.item("TANGER_OCX");
	var useUTF8 = (document.charset == "utf-8");
	TANGER_OCX_OBJ.IsUseUTF8Data = useUTF8;
	TANGER_OCX_OBJ.FileNew = false;
	TANGER_OCX_OBJ.FileClose = false;
	try
	{
		//保存该表单的提交url，将来传递给控件的SaveToURL函数
		TANGER_OCX_actionURL = document.forms[0].action;
		//获取当前操作代码
		TANGER_OCX_strOp = document.all.item("TANGER_OCX_op").innerHTML;
		//获取已经存在的附件名称
		TANGER_OCX_attachName = document.all.item("TANGER_OCX_attachName").innerHTML;
		//获取已经存在的附件URL
		TANGER_OCX_attachURL = document.all.item("TANGER_OCX_attachURL").innerHTML;
		try
                {
		   TANGER_OCX_key = document.all.item("TANGER_OCX_key").innerHTML;
		}catch(err)
                {
                }finally{};
		TANGER_OCX_OBJ.SetAutoCheckSignKey(TANGER_OCX_key);

		switch(TANGER_OCX_strOp)
		{
			case "1":
				if(initdocurl!="")
				{
					TANGER_OCX_OBJ.BeginOpenFromURL(initdocurl,false,false);//参数：URL,是否显示进程,是否只读
				}
				break;
			case "2":
				if(TANGER_OCX_attachURL)
				{
					TANGER_OCX_OBJ.BeginOpenFromURL(TANGER_OCX_attachURL,true,false);
				}
				else
				{
					if(initdocurl!="")
					TANGER_OCX_OBJ.BeginOpenFromURL(initdocurl,true,false);
				}
				break;
			case "3":
				if(TANGER_OCX_attachURL)
				{
					TANGER_OCX_OBJ.BeginOpenFromURL(TANGER_OCX_attachURL,true,true);
				}
				break;
			default: //去要打开指定的模板文件，此时，TANGER_OCX_strOp指定的是url
				//以下使用当前文档的URL来获得模板的URL,也就是跟在?openform后面的部分
				var keystr = "?openform&".toUpperCase();
				var parastring = window.location.search;
				//alert(parastring);
				var urlbegin = parastring.toUpperCase().indexOf(keystr);
				if(-1 != urlbegin)
				{
					TANGER_OCX_strOp = parastring.substr(urlbegin+keystr.length);
					//alert(TANGER_OCX_strOp);
					//判断是否是WPS模板
					var wpsKey = "vwWpsTurl".toUpperCase();
					var isWpsTemplateURL = (-1 != parastring.toUpperCase().indexOf(wpsKey));
					if(!isWpsTemplateURL)
					{
						TANGER_OCX_OBJ.BeginOpenFromURL(TANGER_OCX_strOp,true,false);
					}
					else
					{
						TANGER_OCX_OBJ.BeginOpenFromURL(TANGER_OCX_strOp,true,false,"WPS.Document");
					}
				}
				break;
		}
	}catch(err)
        {
		alert("错误：" + err.number + ":" + err.description);
	}finally
        {
	}
}

//增加演示自定义菜单项目
function addMyMenuItems()
{
	try
        {
		TANGER_OCX_OBJ = document.all.item("TANGER_OCX");
                alert(TANGER_OCX_OBJ.AddFileMenuItem);
	    //增加自定义文件菜单项目
	    TANGER_OCX_OBJ.AddFileMenuItem('保存到服务器-用户自定义菜单',false,true,1);
		TANGER_OCX_OBJ.AddFileMenuItem('');
		//增加自定义主菜单项目
		TANGER_OCX_OBJ.AddCustomMenuItem('我的菜单1:切换禁止拷贝',false,false,1);
		TANGER_OCX_OBJ.AddCustomMenuItem('');
		TANGER_OCX_OBJ.AddCustomMenuItem('我的菜单2',false,false,2);
		TANGER_OCX_OBJ.AddCustomMenuItem('');
		TANGER_OCX_OBJ.AddCustomMenuItem('我的菜单3',false,false,3);
		TANGER_OCX_OBJ.AddCustomMenuItem('');
		TANGER_OCX_OBJ.AddCustomMenuItem('此菜单需要打开的文档才能使用',false,true,4);
	}catch(err)
	{
          alert(err.description);
	}
}

function ShowTitleBar(bShow)
{
	TANGER_OCX_OBJ.Titlebar = bShow;
}
function ShowMenubar(bShow)
{
	TANGER_OCX_OBJ.Menubar = bShow;
}
function ShowToolMenu(bShow)
{
	TANGER_OCX_OBJ.IsShowToolMenu = bShow;
}
//从本地增加图片到文档指定位置
function AddPictureFromLocal()
{
	if(TANGER_OCX_bDocOpen)
	{
	    TANGER_OCX_OBJ.SetReadOnly(false);
        TANGER_OCX_OBJ.AddPicFromLocal(
        	"", //路径
        	true,//是否提示选择文件
        	true,//是否浮动图片
        	0,//如果是浮动图片，相对于左边的Left 单位磅
        	0, //如果是浮动图片，相对于当前段落Top
        	1 //光标位置
    	);
	};
}

//从URL增加图片到文档指定位置
function AddPictureFromURL(URL)
{
	if(TANGER_OCX_bDocOpen)
	{
	    TANGER_OCX_OBJ.SetReadOnly(false);
        TANGER_OCX_OBJ.AddPicFromURL(
        	URL,//URL 注意；URL必须返回Word支持的图片类型。
        	true,//是否浮动图片
        	0,//如果是浮动图片，相对于左边的Left 单位磅
        	0,//如果是浮动图片，相对于当前段落Top
        	1 //光标位置
	    );
	};
}

//从本地增加印章文档指定位置
function AddSignFromLocal()
{
//   alert(TANGER_OCX_key);
   if(TANGER_OCX_bDocOpen)
   {
      TANGER_OCX_OBJ.SetReadOnly(false);
      TANGER_OCX_OBJ.AddSignFromLocal
      (
    	TANGER_OCX_Username,//当前登陆用户
    	"",//缺省文件
    	true,//提示选择
    	0,//left
    	0,
    	TANGER_OCX_key,
    	1,
    	100,
    	0
	  ) ;
   }
}

//从URL增加印章文档指定位置
function AddSignFromURL(URL)
{
//   alert(TANGER_OCX_key);
   if(TANGER_OCX_bDocOpen)
   {
        TANGER_OCX_OBJ.SetReadOnly(false);
        TANGER_OCX_OBJ.AddSignFromURL
        (
        	TANGER_OCX_Username,//当前登陆用户
        	URL,//URL
        	0,//left
        	0,
        	TANGER_OCX_key,
        	1,
        	100,
        	0
        );  //top
   }
}

//开始手写签名
function DoHandSign()
{
//   alert(TANGER_OCX_key);
    if(TANGER_OCX_bDocOpen)
    {
        TANGER_OCX_OBJ.SetReadOnly(false);
    	TANGER_OCX_OBJ.DoHandSign2(TANGER_OCX_Username,TANGER_OCX_key);
    }
}
//开始手工绘图，可用于手工批示
function DoHandDraw()
{
	if(TANGER_OCX_bDocOpen)
	{
	    TANGER_OCX_OBJ.SetReadOnly(false);
    	TANGER_OCX_OBJ.DoHandDraw2();
	}
}
//检查签名结果
function DoCheckSign()
{
//   alert(TANGER_OCX_key);
   if(TANGER_OCX_bDocOpen)
   {
	var ret = TANGER_OCX_OBJ.DoCheckSign
	(
	false,/*可选参数 IsSilent 缺省为FAlSE，表示弹出验证对话框,否则，只是返回验证结果到返回值*/
	TANGER_OCX_key
	);//返回值，验证结果字符串
	//alert(ret);
   }
}
//以下为以前版本的函数和实用函数


//如果原先的表单定义了OnSubmit事件，保存文档时首先会调用原先的事件。
function TANGER_OCX_doFormOnSubmit()
{
	var form = document.forms[0];
  	if (form.onsubmit)
	{
    	var retVal = form.onsubmit();
     	if (typeof retVal == "boolean" && retVal == false)
       	return false;
	}
	return true;
}


//允许或禁止用户从控件拷贝数据
function TANGER_OCX_SetNoCopy(boolvalue)
{
	TANGER_OCX_OBJ.IsNoCopy = boolvalue;
}

//设置用户名
function TANGER_OCX_SetDocUser(cuser)
{
    TANGER_OCX_Username = cuser;
	with(TANGER_OCX_OBJ.ActiveDocument.Application)
	{
		UserName = cuser;
	}
}

//设置页面布局
function TANGER_OCX_ChgLayout()
{
 	try
	{
		TANGER_OCX_OBJ.showdialog(5); //设置页面布局
	}
	catch(err){
		alert("错误：" + err.number + ":" + err.description);
	}
	finally{
	}
}

//打印文档
function TANGER_OCX_PrintDoc(isBackground)
{
	var oldOption;
	try
	{
		var objOptions =  TANGER_OCX_OBJ.ActiveDocument.Application.Options;
		oldOption = objOptions.PrintBackground;
		objOptions.PrintBackground = isBackground;
	}
	catch(err){};

	TANGER_OCX_OBJ.printout(true);

	try
	{
		var objOptions =  TANGER_OCX_OBJ.ActiveDocument.Application.Options;
		objOptions.PrintBackground = oldOption;
	}
	catch(err){};
}

//此函数在文档关闭时被调用。
function TANGER_OCX_OnDocumentClosed()
{
	TANGER_OCX_bDocOpen = false;
}
//此函数用来保存当前文档。主要使用了控件的SaveToURL函数。
//有关此函数的详细用法，请参阅编程手册。
function TANGER_OCX_SaveDoc(fileName)
{
	var retStr=new String;
	var newwin,newdoc;
	if(fileName=="")
	{
		alert("请指定附件名称!");
		return;
	}
	try
	{
	 	if(!TANGER_OCX_doFormOnSubmit())return;
		if(!TANGER_OCX_bDocOpen)
		{
			alert("没有打开的文档。");
			return;
		}
		//在编辑状态下需要删除的附件名称
		var deleteFile = "";
		//设置要保存的附件文件名
		document.all.item("TANGER_OCX_filename").value = fileName;
		switch(TANGER_OCX_strOp)
		{
			case "3":
				alert("文档处于阅读状态，您不能保存到服务器。");
				break;
			case "2": //需要首先删除以前的文档附件
				deleteFile = (TANGER_OCX_attachName=="")?"":"%%Detach="+escape(TANGER_OCX_attachName);
			case "1":
				//新建文档
			default:
				retStr = TANGER_OCX_OBJ.SaveToURL(TANGER_OCX_actionURL,
				document.all.item("NTKO_UPLOADFIELD").name, //子表单的文件上载控件的名称
				deleteFile,
				fileName,
				0 //同时提交forms[0]的信息
				);
				newwin = window.open("","_blank","left=200,top=200,width=400,height=200,status=0,toolbar=0,menubar=0,location=0,scrollbars=0,resizable=0",false);
				newdoc = newwin.document;
				newdoc.open();
				newdoc.write("<center><hr>"+retStr+"<hr><input type=button VALUE='关闭窗口' onclick='window.close()'></center>");
				newdoc.close();
				//window.alert(retStr);
				window.opener.location.reload();
			   window.close();
				break;
		}
	}
	catch(err){
		alert("不能保存到URL：" + err.number + ":" + err.description);
	}
	finally{
	}
}

//此函数在文档打开时被调用。
function TANGER_OCX_OnDocumentOpened(str, obj)
{
	try
	{
		TANGER_OCX_bDocOpen = true;
		//设置用户名
		TANGER_OCX_SetDocUser(TANGER_OCX_Username);
		if(obj)
		{
			switch(TANGER_OCX_strOp)
			{
				case "1":
				case "2":
				    TANGER_OCX_OBJ.SetReadOnly(false);
					break;
				case "3":
					TANGER_OCX_OBJ.SetReadOnly(true);
					break;
				default:
					break;
			}
		}
	}
	catch(err){

	}
	finally{
	}
}
function SaveAsHTML(URL,uploadfield,fileName)
{
	try
	{
		var retStr = TANGER_OCX_OBJ.PublishAsHTMLToURL(
						URL,uploadfield,
						"__Click=0&subject="+escape(document.forms(0).Subject.value)+
						"&filename="+fileName,
						fileName
					);
		var newwin = window.open("","_blank","left=200,top=200,width=400,height=200,status=0,toolbar=0,menubar=0,location=0,scrollbars=0,resizable=0",false);
			var newdoc = newwin.document;
			newdoc.open();
			newdoc.write("<center><hr>"+retStr+"<hr><input type=button VALUE='关闭窗口' onclick='window.close()'></center>");
			newdoc.close();
	}
	catch(err){
		alert("不能保存到URL：" + err.number + ":" + err.description);
	}
	finally{
	}
}
