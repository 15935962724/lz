<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"  %>
<%@ page import="tea.resource.Resource" %>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.entity.site.*" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="tea.entity.member.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="tea.ui.*" %>
<%@ page import="java.net.URLEncoder"%><%
request.setCharacterEncoding("UTF-8");
if(request.getProtocol().compareTo("HTTP/1.0")==0)
{
  response.setHeader("Pragma","no-cache");
}
if(request.getProtocol().compareTo("HTTP/1.1")==0)
{
  response.setHeader("Cache-Control","no-cache");
}
response.setDateHeader("Expires",0);

TeaSession teasession=new TeaSession(request);
String nexturl = request.getRequestURI()+"?"+request.getQueryString();
String member = "";
if(teasession._rv != null)
{
  member = teasession._rv._strR;
}

int value = 0;   //1:从COOKIE取参   2：从库取参    3：从URL取参

if(teasession._rv == null)
{
  //取COOKIE保存参数
  value = 3;
  Cookie[] cookie = request.getCookies();
  if(cookie !=null)
  {
    for (int i = 0; i < cookie.length; i++)
    {
      if (cookie[i].getName().equals("param"))
      {
        value = 1;
      }
    }
  }

}else
{
  //判断该用户是否定制过信息
  boolean isEx = PreInfo.isExist(member);
  if(isEx)
  {
    value = 2;
  }else
  {
    //库中无信息，取所传参数
    value = 3;
  }
}

int count = 0;
String kinds = teasession.getParameter("count");
if(kinds!=null)
{
  count =Integer.parseInt(kinds);
}
StringBuffer ssb =new StringBuffer();
String[] totelNum = null;
if(value == 1)
{
  Cookie[] cookie = request.getCookies();
  for (int i = 0; i < cookie.length; i++)
  {
    if (cookie[i].getName().equals("param"))
    {
      String[] gc = cookie[i].getValue().split("%21");
//      System.out.println("||||"+cookie[i].getValue());
      for(int z = 0; z < gc.length; z++)
      {
        ssb.append(gc[z]).append("!");
      }
      totelNum = ssb.toString().split("/");
    }
  }
}
if(value == 2)
{

  String tn = PreInfo.getNum(member);
  totelNum = tn.split("/");
}

if(value == 3)
{
  totelNum = teasession.getParameterValues("nid");
}

String[] proNum = teasession.getParameterValues("nid");
%>

<style>
.show
{
color:red;
}
</style>
<%
//out.print("value="+value);
StringBuffer h=new StringBuffer();
TeaServlet ts =new TeaServlet();
String[] nodeNum = null;
for(int i = 0; i < totelNum.length; i++)
{
  if(i < count)
  {//取拦目
  if(value != 1)
  {
    nodeNum = totelNum[i].split(",");
  }else
  {
    nodeNum = totelNum[i].split("!");
  }

  int node = Integer.parseInt(nodeNum[0]);
  String subject=Node.find(node).getSubject(teasession._nLanguage);
  %>
  <span id="kinds<%=i%>" class="hidden" onclick="f_show(<%=i%>)"><%=subject%></span>
  <%
  h.append("<div id='listing"+i+"' style='dispay:none'>");
  for(int j = 1; j < nodeNum.length; j++)
  {//取列举

  int listNum = Integer.parseInt(nodeNum[j]);

  Listing l = Listing.find(listNum);
  String text = ts.getListingText(teasession, l,false);
  h.append(text);
}
h.append("</div>");
}
}
%>
<input id="dzshow" type="button" value="订制" onclick="f_show(-1);"/>
</div>
<%=h.toString()%>
<div id="dingzhi" style="display:none">

  <form action="/jsp/community/PreInfo.jsp" name="fom" onsubmit="s_cookie()">

  <table border="0" cellspacing="0" cellpadding="0">
    <tr>
    <%
    for(int i = 0; i <count; i++)
    {
      int node = -1;
      if(i < count)
      {//取拦目
      if(value != 1)
      {
        nodeNum = totelNum[i].split(",");
      }else
      {
        nodeNum = totelNum[i].split("!");
      }

      node = Integer.parseInt(nodeNum[0]);
      String subject=Node.find(node).getSubject(teasession._nLanguage);
//      out.print("<td>"+subject+"<br>");
      out.print("<td>");
    }

    for(int p = 0; p < proNum.length; p++)
    {
      String[] nodNum = proNum[p].split(",");
      int node1 = Integer.parseInt(nodNum[0]);
      String subject=Node.find(node1).getSubject(teasession._nLanguage);
      %><input id="rid<%=p%>" type="radio" name="id<%=i%>" value="<%=proNum[p]%>" onclick="f_dis(this)" <%if(node1 == node){out.print("checked");}%> /><%=subject%><br>
      <%
      }
      out.print("</td>");
    }

    %>
    </tr>
    <tr>
      <td colspan="<%=count%>" align="center">
        <input type="hidden" name="nexturl" value="<%=nexturl%>"/>
        <input type="hidden" name="count" value="<%=count%>"/>
        <input id="dzsubmit" type="submit" value="确定"/>
        <input type="button" value="关闭" onclick="f_show(-2)"/>
      </td>
    </tr>
  </table>
  </form>
</div>
<script type="">
function GetCookieVal(offset)
//获得Cookie解码后的值
{
  var endstr = document.cookie.indexOf (";", offset);
  if (endstr == -1)
  endstr = document.cookie.length;
  return unescape(document.cookie.substring(offset, endstr));
}

function SetCookie(name, value)
//设定Cookie值
{
var expire = new Date();
	expire.setTime(expire.getTime() + 30*24*60*60*1000);//COOKIE有效期为个月

	document.cookie = name + "=" + escape(value) + "; expires=" + expire.toGMTString() + "; path=/";
}

function f_dis(obj)
{
  if(!obj)
  {
    var arr=fom.elements;
    for(var i=0; i <arr.length;i++)
    {
      if(arr[i].checked)
      {
        f_dis(arr[i]);
      }
    }
  }else
  {
    var id=parseInt(obj.name.substring(2));
    var selectindex=0;
    var ids=document.all("id"+id);
    for(var i=0;i<ids.length;i++)
    {
      if(ids[i].checked)
      {
        selectindex=i;
        break;
      }
    }
    for(var i=0;i<<%=count%>;i++)
    {
      if(i!=id)
      {
        var ids=document.all("id"+i);
        for(var j=0;j<ids.length;j++)
        {
          ids[j].disabled=selectindex==j;
        }
      }
    }
  }
}
f_dis();

function DelCookie(name)
//删除Cookie
{
  var expire = new Date();
  expire.setTime(expire.getTime() - 30*24*60*60*1000);
  document.cookie = name + "=" + escape('remove') + "; expires=" + expire.toGMTString() + "; path=/";
}

function s_cookie()
{

  var arr=fom.elements;
  var strM="";
  for(var i=0; i <arr.length;i++)
  {
    if(arr[i].checked)
    {
      strM += arr[i].value+"/";
    }
  }
  var cook = strM.replace(/,/g,"!");

  SetCookie("param",cook);

}

function f_show(id)
{
  //  document.getElementById("dd");
  //  var ls=document.all("listing");
  //  var ks=document.all("kinds");

  if(id==-1)
  {
    document.getElementById("dingzhi").style.display='';
  }else if(id==-2)
  {
    document.getElementById("dingzhi").style.display='none';
    f_show(0);
  }else
  {

    for(var i = 0; i < <%=count%>;i++)
    {
      document.getElementById("listing"+i).style.display='none';
      document.getElementById("kinds"+i).className="hidden";
    }
    document.getElementById("listing"+id).style.display='';
    document.getElementById("kinds"+id).className="show";
  }

}
f_show(0);

//function f_ent()
//{
//  document.fom.action="/jsp/community/PreInfo.jsp";
//  document.fom.submit();
//  window.location.reload();
//}

</script>
<div>
