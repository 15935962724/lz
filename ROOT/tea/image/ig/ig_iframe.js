
function dyniframesize()
{
	var dialog_box=parent.document.getElementById("dialog_box");
	if(dialog_box)
	{
		var ifh=document.body.scrollHeight;
		var ifw=document.body.scrollWidth;
		if(ifh>window.screen.height-400)
		{
		   ifh=window.screen.height-400;
		}
		dialog_box.style.height=ifh;
		dialog_box.style.width=ifw;
		dialog_box.style.left=(window.screen.width-ifw)/2;
		dialog_box.style.top=0;(window.screen.height-ifh)/2;
		
		dialog_box.style.display='';
	}
}
if (window.addEventListener)
	window.addEventListener("load", dyniframesize, false)
else if (window.attachEvent)
	window.attachEvent("onload", dyniframesize)
else
	window.onload=dyniframesize
	
	
	














function Pos(x,y)
{
  this.x   =   x;
  this.y   =   y;
}
var currentMenuItemPos   =   new   Pos(   0,0   );
function mveaablediv()
{
  document.body.ondragenter   = function()
  {
    window.event.returnValue   =   false;
  }
  document.body.ondragover   =function()
  {
    window.event.returnValue   =   false;
  }
  var   item_div   =   document.getElementById('dialog_box');
  item_div.ondragstart   =   function()
  {
    currentMenuItemPos   =   new   Pos(event.offsetX,event.offsetY   );
  }
  item_div.ondrag   =   function()
  {
      this.style.left =   parseInt(this.style.left)   +   event.offsetX-   currentMenuItemPos.x;
      this.style.top =   parseInt(this.style.top)     +   event.offsetY   -   currentMenuItemPos.y;
  }
  item_div.ondragend   =   function()
  {
    currentMenuItemPos.x   =   parseInt(this.style.left)   -   parseInt(document.body.scrollLeft);
    currentMenuItemPos.y   =   parseInt(this.style.top)   -   parseInt(document.body.scrollTop);
    if(currentMenuItemPos.x   <   0   )   //防止将窗口拖出去之后拖不回来
    {
      currentMenuItemPos.x   =   0;
    }

    if(currentMenuItemPos.y   <   0   )   //防止将窗口拖出去之后拖不回来
    {
      currentMenuItemPos.y   =   0;
    }

    window.event.returnValue   =   false;
  }
}