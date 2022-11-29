var x0=0,y0=0,x1=0,y1=0;
var offx=6,offy=6;
var moveable=false;
var hover='orange',normal='slategray',normal1='#000',normal2='#f00',normal3='#00f';//color;
var index=10000;//z-index;
var xx;

function getFocus(obj)
{
        if(obj.style.zIndex!=index)
        {
                index = index + 2;
                var idx = index;
                obj.style.zIndex=idx;
                obj.nextSibling.style.zIndex=idx-1;
        }
}

function ShowHide()
{
        if (xx!=null)
                        if (xx.style.visibility == "hidden")
                                xx.style.visibility = "visible";
                        else if (xx.style.visibility == "visible")
                                xx.style.visibility = "hidden";
}

function xWin(id,w,h,l,t,tit,msg)
{
        index = index+2;
        this.id      = id;
        this.width   = w;
        this.height  = h;
        this.left    = l;
        this.top     = t;
        this.zIndex  = index;
        this.title   = tit;
        this.message = msg;
        this.obj     = null;
        this.bulid   = bulid;
        this.bulid();
        xx = document.getElementById('allx');
        xx.style.visibility = "visible";

}

function bulid()
{
        var str = ""
                + "<div id='allx'><div id='xMsg'" + this.id + " "
                + "style='"
                + "z-index:" + this.zIndex + ";"
                + "width:" + this.width + ";"
                + "height:" + this.height + ";"
                + "left:" + this.left + ";"
                + "top:" + this.top + ";"
/*                + "background: url(/res/9000gw/u/0711/071143215.gif) no-repeat;padding-top:16px;" */
		+ "background: url(/res/9000gw/u/0711/07114960.jpg) no-repeat;padding-top:16px;"
                + "color:" + normal2 + ";"
                + "font-size:12px;"
                + "font-family:Verdana;"
                + "position:absolute;"
                + "cursor:default;"
                + "' "
                + "onmousedown='getFocus(this)'>"
                   /*     + "<div "
                        + "style='"
                        + "background-color:" + normal3 + ";"
                        + "width:" + (this.width-2*2) + ";"
                        + "height:20;"
                        + "color:white;"
                        + "' "
                        + "ondblclick='min(this.childNodes[1])'"
                        + ">"
                                + "<span style='width:" + (this.width-2*14-4) + ";padding-left:3px;'>" + this.title + "</span>"

                        + "</div>"*/
                                + "<div style='"
/*                                + "width:100%;"
                                + "height:" + (this.height-20-4) + ";"
                                + "background-color:white;"
                                + "line-height:14px;"
*/                                + "word-break:break-all;"
/*                                + "padding:3px;"
*/                                + "'>" + this.message + "</div>"
                + "</div>"
                + "<div id='xshadow' style='"
                + "width:" + this.width + ";"
                + "height:" + this.height + ";"
                + "top:" + this.top + ";"
                + "left:" + this.left + ";"
                + "z-index:" + (this.zIndex-1) + ";"
                + "position:absolute;"
/*                + "background-color:black;"*/
                + "filter:alpha(opacity=40);"
                + "'></div></div>";
        document.getElementById('msgbox').innerHTML = str;


}
