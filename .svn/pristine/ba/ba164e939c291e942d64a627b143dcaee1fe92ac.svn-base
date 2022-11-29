

// 弹出层
var docEle = function()
{
    return document.getElementById(arguments[0]) || false;
}

function openNewDiv(_id,ip,sp)
{
    var m = "mask";
    if (docEle(_id)) document.body.removeChild(docEle(_id));
    if (docEle(m)) document.body.removeChild(docEle(m));

    //mask遮罩层

    var newMask = document.createElement("div");
    newMask.id = m;
    newMask.style.position = "absolute";
    newMask.style.zIndex = "1";
    _scrollWidth = Math.max(document.body.scrollWidth,document.documentElement.scrollWidth);
    _scrollHeight = Math.max(document.body.scrollHeight,document.documentElement.scrollHeight);
    newMask.style.width = _scrollWidth + "px";
    newMask.style.height = _scrollHeight + "px";
    newMask.style.top = "0px";
    newMask.style.left = "0px";
    newMask.style.background = "#33393C";
    newMask.style.filter = "alpha(opacity=40)";
    newMask.style.opacity = "0.40";
    document.body.appendChild(newMask);

    //新弹出层

    var newDiv = document.createElement("div");
    newDiv.id = _id;
    newDiv.style.position = "absolute";
    newDiv.style.zIndex = "9999";
    newDivWidth = 400;
    newDivHeight = 250;
    newDiv.style.width = newDivWidth + "px";
    newDiv.style.height = newDivHeight + "px";
    newDiv.style.top = (document.body.scrollTop + document.body.clientHeight/2 - newDivHeight/2) + "px";
    newDiv.style.left = (document.body.scrollLeft + document.body.clientWidth/2 - newDivWidth/2) + "px";
    //newDiv.style.background = "#fff url(/res/REDCOME/0911/09119923.gif) no-repeat center 50%;";
    //newDiv.style.border = "1px solid #860001";
    //newDiv.style.padding = "5px";
    newDiv.innerHTML ="<table border=\"1\" width=\"37%\" cellspacing=\"0\" cellpadding=\"4\" style=\"border-collapse: collapse\" bgcolor=\"#FFFFEC\" height=\"87\"><tr> <td bgcolor=\"#3399FF\" style=\"font-size:12px;color:#ffffff\" height=24>系统数据后台处理中...</td></tr><tr><td style=\"font-size:12px;line-height:200%\" align=center>系统数据后台处理中.请耐心等待...<marquee style=\"border:1px solid #000000\" direction=\"right\" width=\"300\" scrollamount=\"5\" scrolldelay=\"10\" bgcolor=\"#ECF2FF\"><table cellspacing=\"1\" cellpadding=\"0\"><tr height=8> <td bgcolor=#3399FF width=8></td><td></td> <td bgcolor=#3399FF width=8></td> <td></td><td bgcolor=#3399FF width=8></td><td></td><td bgcolor=\"#3399FF\" width=8></td><td></td></tr></table></marquee></td> </tr></table>";
    document.body.appendChild(newDiv);

    //弹出层滚动居中

    function newDivCenter()
    {
        newDiv.style.top = (document.body.scrollTop + document.body.clientHeight/2 - newDivHeight/2) + "px";
        newDiv.style.left = (document.body.scrollLeft + document.body.clientWidth/2 - newDivWidth/2) + "px";
    }
    if(document.all)
    {
        window.attachEvent("onscroll",newDivCenter);
    }
    else
    {
        window.addEventListener('scroll',newDivCenter,false);
    }
}

//关闭层
function f_close(_id)
{
	 var m = "mask";
	 function newDivCenter()
	    {
	        newDiv.style.top = (document.body.scrollTop + document.body.clientHeight/2 - newDivHeight/2) + "px";
	        newDiv.style.left = (document.body.scrollLeft + document.body.clientWidth/2 - newDivWidth/2) + "px";
	    }
	  //关闭新图层和mask遮罩层
        if(document.all)
        {
            window.detachEvent("onscroll",newDivCenter);
        }
        else
        {
            window.removeEventListener('scroll',newDivCenter,false);
        }
        document.body.removeChild(docEle(_id));
        document.body.removeChild(docEle(m));
        return false;
}

