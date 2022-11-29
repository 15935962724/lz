function drawLine(obj)
{
 var areaObj = obj;
 var str = areaObj.coords;
 var arr = str.split(",");
 var xArr = new Array(arr.length/2);
 var yArr = new Array(arr.length/2);
 var x=0,y=0;
 var max =1,min =2;
 for (var t =0 ;t<arr.length ;t=t+2 )
 {
 	//alert("x == "+arr[t]);
 xArr[x++] = parseInt(arr[t]);
 }
 for (var t =1 ;t<arr.length ;t=t+2 )
 {
 	//alert("y == "+arr[t]);
 yArr[y++] = parseInt(arr[t]);
 }
var x1 = find(xArr,min);
//alert("x min == "+x1);
var x2 = find(xArr,max);
//alert("x max == "+x2);
var y1 = find(yArr,min);
//alert("y min == "+y1);
var y2 = find(yArr,max);
//alert("y max == "+y2);

 var mapObj = obj.parentElement;
 if(typeof mapObj == "object")
 {
 	//alert(mapObj.name);
	
	//var imgs = document.all.tags("img");
	 var imgs = document.getElementById("hotpic");
	 
	//alert(imgs.length);
	if(imgs != null)
	{
		//for(var i=0;i<imgs.length;i++)
		{
			var imgobj = imgs;
			//alert(imgobj.src);
			var mapname = imgobj.useMap;
			//alert(mapname);
			if(typeof mapname == "string" && mapname.toLowerCase() == ("#" + mapObj.name).toLowerCase())
			{
				//alert(mapname);
				var imgleft = 0;
				var imgtop = 0;
				
				
				var imgparent = imgobj.parentElement;
				
				while(typeof imgparent == "object" && imgparent.tagName.toUpperCase() != "BODY")
				{
					imgleft += imgparent.offsetLeft - imgparent.style.borderLeft;
					imgtop += imgparent.offsetTop - imgparent.style.borderTop;
					imgparent = imgparent.parentElement;
				}
				
				imgleft = imgleft +0;
				imgtop = imgtop-0;
				//alert("left1 == "+imgleft);
				//alert("top1 == "+imgtop);
				
				MouseOverMap(x1,y1,x2,y2,imgleft,imgtop);
			}
		}
	}
	
	
 }
}

function find(arr,type)
{
	var tmp=arr[0]; 
	if (type==1)
	{
	 for (var loop=0;loop<arr.length ;loop++ )
	 if (arr[loop]>tmp)
		 tmp = arr[loop];
	 return tmp;
	}
	else if (type == 2)
		{

	 for (var loop=0;loop<arr.length ;loop++ )
	 if (arr[loop]<tmp)
	 		 tmp = arr[loop];
	 return tmp;
	}

}

function MouseOverMap(x1,y1,x2,y2,imgleft,imgtop) {
var divElm = document.getElementById("leveldiv");
var Left = 0 + x1;
var Top = 0+ y1;
var Right = parseInt(x2 - x1);
var bottom = parseInt(y2 - y1);
divElm.style.border = "solid 2px #FF0000";
divElm.style.left = Left+imgleft;
divElm.style.top = Top+imgtop;
divElm.style.width = Right;
divElm.style.height = bottom;
divElm.style.cursor = "pointer";
}

function MouseOutMap() {
	var divElm = document.getElementById("leveldiv");
	divElm.style.border = "";
}
 
function clickmap(obj)
{
		
	obj.target="_self";
}