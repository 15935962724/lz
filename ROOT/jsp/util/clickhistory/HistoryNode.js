      function getParameter(url,param)
    {
//      var url=document.location.href;
      var index=url.indexOf("?");
      url=url.substring(index+1);
      var args=url.split("&");
      for(i=0;i<args.length;i++)
      {
        if(args[i].indexOf(param+"=")==0)
        return args[i].substring(param.length+1);
      }
      return "null";
    }


var ss = document.getElementsByTagName("SCRIPT");
var s = ss[ss.length-1];

var community=getParameter(s.src,"community");




var value=getCookie("tea.HistoryNode_"+community,"");
if(value!=null)
{

var vs=value.split("</A><A ");
document.write("<A ");
for(var index=1;index<7&&index<vs.length;index++)
{
  document.write(vs[index]+"</A><A ");
}
document.write("></A>");

//value=value.replace(",","<BR/>");


//value="aaaaaaaaa";
//document.write(value);
}

