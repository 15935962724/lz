<%@page contentType="text/html;charset=UTF-8"  %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="tea.entity.bpicture.*" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="tea.db.*" %>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");
TeaSession teasession = new TeaSession(request);
StringBuffer sql=new StringBuffer(" and member="+DbAdapter.cite(teasession._rv.toString())+" and passpage=1 ");
int count = 0;
count = Baudit.count(teasession._strCommunity,sql.toString());
int countwc = 0;
countwc = Baudit.count(teasession._strCommunity,sql.toString()+" and  property!=0");






String falg =Bpseudonym.getsql(" id  "," and applied=1 and member="+DbAdapter.cite(teasession._rv.toString()));
int type=0;
int id =0;
String biname=teasession._rv.toString();
if(falg!=null && falg.length()>0)
{
  id= Integer.parseInt(falg);
  Bpseudonym bobj=Bpseudonym.find(id);
  type=bobj.getLtype();
  biname = bobj.getName();
}
else
{
  Bpseudonym.set(0,teasession._rv.toString(),teasession._strCommunity,teasession._rv.toString(),0,1);
}
%>
<html>
<HEAD>
  <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>

  <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="" ></SCRIPT>

  <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/load.js" type=""></SCRIPT>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache"/>
  <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"/>
  <META HTTP-EQUIV="Expires" CONTENT="0"/>
  <title>图片信息管理</title>

  <script type="">
   function fun(date)
    {
//      var arr=date.split("/");
//      document.all("sh"+arr[0]).innerHTML=arr[1];
//      document.all("DNAid"+arr[0]).value=arr[2];
window.location.href=window.location.href;
    }

  function addp()
  {
    if(document.all("name").value==""||document.all("member").value=="")
    {
      alert("请输入正确的摄影师名称！");
      return false;
    }
    sendx("/jsp/bpicture/saler/Saler_PAjax.jsp?typenum=1&name="+encodeURIComponent(document.all("name").value,"UTF-8")+"&member="+encodeURIComponent(document.all("member").value,"UTF-8")+"&community="+encodeURIComponent(document.all("community").value,"UTF-8"),fun);
    window.location.href;
  }

  function setltype()
  {
    if(document.all("member").value=="")
    {
      alert("无效类型！");
      return false;
    }
    var ly = null;
    for(var i = 0; i < 4; i++)
    {
      if(document.getElementById("ly"+i).checked){
        ly = document.getElementById("ly"+i).value;
      }
    }
    sendx("/jsp/bpicture/saler/Saler_PAjax.jsp?name="+encodeURIComponent(document.all("name").value,"UTF-8")+"&member="+encodeURIComponent(document.all("member").value,"UTF-8")+"&community="+encodeURIComponent(document.all("community").value,"UTF-8")+"&typenum=0&id="+encodeURIComponent(document.all("id").value,"UTF-8")+"&ltype="+encodeURIComponent(ly,"UTF-8"),fun);

  }

 function setbiming()
  {
    if(document.all("member").value=="")
    {
      alert("无效类型！");
      return false;
    }
    var ly = null;
    for(var i = 0; i < 3; i++)
    {
      if(document.getElementById("ly"+i).checked){
        ly = document.getElementById("ly"+i).value;
      }
    }
    sendx("/jsp/bpicture/saler/Saler_PAjax.jsp?name="+encodeURIComponent(document.all("name").value,"UTF-8")+"&member="+encodeURIComponent(document.all("member").value,"UTF-8")+"&community="+encodeURIComponent(document.all("community").value,"UTF-8")+"&typenum=2&id="+encodeURIComponent(document.getElementById("choosepname").value,"UTF-8")+"&ltype="+encodeURIComponent(ly,"UTF-8"),fun);

  }




  function delp()
  {
    sendx("/jsp/bpicture/saler/Saler_PAjax.jsp?&typenum=3&id="+encodeURIComponent(document.getElementById("delnum").value,"UTF-8"),fun);
  }



  </script>
<style>
#table001{background:#F6F6F6;border-bottom:10px solid #eee;border-top:10px solid #eee;padding:6px;width:95%;margin-top:10px;}
#table001 td{padding:6px 15px;line-height:180%;}
#table001 td li{line-height:180%;}
.lzj_tu,.padright,.mandatory{background:url(/res/bigpic/u/0812/08124172.jpg) no-repeat 0 7px;padding-left:12px;}
.orange{display:block;background:url(/res/bigpic/u/0812/08124169.jpg) no-repeat 0 2px;padding-left:20px;}
.ready{display:block;background:url(/res/bigpic/u/0812/08124170.jpg) no-repeat 0 2px;padding-left:20px;}
.Not-ready{display:block;background:url(/res/bigpic/u/0812/08124171.jpg) no-repeat 0 2px;padding-left:20px;}
.lzj_youxian{border-right:1px solid #ccc;}
.button{height:22px;height:18px;border:1px solid #7F9DB9;background:#fff;line-height:8px;}
#ly1,#ly2,#ly3,#ly4,#ly0{border:0;}
#anliu{height:23px;line-height:23px;*line-height:18px;}
.lzj_001,.button{height:23px;border:1px solid #7F9DB9;background:#fff;line-height:20px;*line-height:14px;padding-bottom:5px;*paddding-bottom:0;}
.lzj_002{height:23px;border:1px solid #7F9DB9;background:#fff;line-height:23px;*line-height:17px;}
</style>
</HEAD>
<body style="margin:0;" >
<!--body style="margin:0;" onLoad="load()"-->
<div id="wai">
<div id="li_biao"><a href="http://bp.redcome.com" target="_top">首页</a>&nbsp;>&nbsp;管理中心&nbsp;>&nbsp;设定缺省的许可和管理摄影师</div>
<h1>设定缺省和管理摄影师</h1>


  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td class="t">我的图片</td>
    </tr>
  </table>
  <table border="0" cellpadding="0" cellspacing="0" id="table001">
    <tr>
      <td id="table003"><strong>你想怎么办呢？</strong></td>
      <td>&nbsp;</td>
      <td class="border" rowSpan="2"><IMG height="1" src="images/s.gif" width="1" border="0" alt=""></td>
        <td><strong>如何使用此网页</strong></td>
    </tr>
    <tr vAlign="top">
      <td class="border-dash" nowrap id="table003"><ul class="lzj_youxian"><li class="padright">设置默认的许可证书和管理摄影师名称
        <li class="lzj_tu"><strong>查看所有图片(<%=count%>)</strong><ul>
        <li>准备出售的图像 (<%=countwc%>)<br>
        <span class="not-ready" title="Not ready"> 没有准备
        <span class="nouline"> (<%=count-countwc%>)</span></span>
          <span class="ready" title="ready" >准备
          <span class="nouline"> (<%=countwc%>)</span></span><li><a href="/jsp/bpicture/saler/Saler_my_images.jsp">查看图片出售<span class="nouline"> (<%=countwc%>)</span></a><br/>
            <span class="orange">需要更多细节 <span class="nouline"> (<%=count-countwc%>)</span></span>
           </ul></ul></td>
            <td><strong>查找图片</strong><br>
              <br>
              <table cellSpacing="0" cellPadding="0" width="100%" border="0">
                <tr>
                  <td><input type="text" value="" name="txtSearch" id="anliu"></td>
                    <td class="padleft"><input class="button" id="btnSearch"  type="button" value="Search" name="btnSearch"></td>
                </tr>
              </table>
                    </td>
                    <td>
                      <ul style="list-style-type:none;"><li class="mandatory"><strong>强制性细节</strong>.</li><li class="not-ready"><font color="#CC0001"><strong>没准备</strong> </font>- 图片在完成强制性的细节之前标示为没有准备好。</li><li class="ready"><font color="#006600"><strong>准备</strong></font> -图片标示为准备将
                        <em>顾客在24小时内可见</em> (不包括周末).</li><li class="orange"><font color="#FE8100"><strong>出售-需要更多细节</strong></font> - 您的图片上出售给顾客，而是使之更实用，我们建议您修改您的关键字，并完成所有的领域。</li></ul>
                        如果您的图片已经出售，您可以变更，删除或添加到下面的信息，除版权类型仍然客户在24小时内可见（不包括周末） 。
                    </td>
    </tr>
  </table>





  <form  name="form1" action="/servlet/EditBPicture" method="POST">
  <input  type="hidden" value="act"  name="bpseudonym"/>
  <input type="hidden" value="<%=id%>" name="id" />
  <input  type="hidden" value="<%=teasession._strCommunity%>"  name="community"/>
  <input type="hidden" value="<%=teasession._rv.toString()%>"  name="member"/>
  <table border="0" cellpadding="0" cellspacing="0" id="table001">
    <tr>
      <th width="34%" height="37" align="left" scope="col"> &nbsp;&nbsp;&nbsp;设定和管理摄影师</th>
      <th width="66%" align="left" scope="col">&nbsp;</th>
    </tr>
    <tr>
      <td>选择默认的许可类型 - Licensing explained</td>
      <td>&nbsp;</td>
    </tr>

    <tr>
      <td valign="top">Your current default licence is：
        <%if(type==0){out.print("Not Set");}else{out.print(Bpseudonym.LTYPE[type]);}%></td>
      <td><%
      for(int i=0;i<Bpseudonym.LTYPE.length;i++)
      {
        out.print("<input type=radio id=ly"+i+" name=ltype  value="+i);
        if(type==i)
        {
          out.print(" checked ");
        }
        out.print(" />"+Bpseudonym.LTYPE[i]);
        out.print("<br>");
      }
      %>
        <input name="licencesubimt" type="button" class="lzj_001" onClick="setltype();" value="保存默认类型"  /></td>
    </tr>
    <tr>
      <td  align="left"><strong> 创建一个摄影师名称</strong></td>
      <td  align="left">&nbsp;</td>
    </tr>
    <tr>
      <td> 假如不创建名称，你的登陆名将被使用<br></td>
      <td><input type="text" name="name" value=""  class="lzj_002" />
        <input name="pseudonymnew" type="button" class="lzj_001"  onClick="addp();" value="创建名称"/></td>
    </tr>
    <tr>
      <td align="left"><strong>选择一个默认的名称</strong></td>
      <td align="left">&nbsp;</td>
    </tr>
    <tr>
      <td>你的默认名称是: <%=biname%><br></td>
      <td><select name="choosepname" class="lzj_002">
          <option>-------------</option>
          <%
      java.util.Enumeration ee = Bpseudonym.findByCommunity(teasession._strCommunity," and member ="+DbAdapter.cite(teasession._rv.toString()),0,20);
      for(int i=0;ee.hasMoreElements();i++)
      {
        int idb=Integer.parseInt(String.valueOf(ee.nextElement()));
        Bpseudonym bj = Bpseudonym.find(idb);
        out.print("<option value="+idb+">"+bj.getName());
        out.print("</option>");
      }
      %>
        </select>
          <input name="button2" type="button" class="lzj_001" onClick="setbiming();" value="选择默认名称" /></td>
    </tr>
    <tr>
      <td><b>删除默认名称</b></td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>如果你删除一名称,所有的和那名称有关的图片将也被删除.</td>
      <td><select name="delnum" class="lzj_002">
          <option>-------------</option>
          <%
      java.util.Enumeration eec = Bpseudonym.findByCommunity(teasession._strCommunity," and member ="+DbAdapter.cite(teasession._rv.toString()),0,20);
      for(int i=0;eec.hasMoreElements();i++)
      {
        int idb=Integer.parseInt(String.valueOf(eec.nextElement()));
        Bpseudonym bj = Bpseudonym.find(idb);
        out.print("<option value="+idb+">"+bj.getName());
        out.print("</option>");
      }
      %>
        </select>
          <input name="button" type="button" class="lzj_001" onClick="delp();" value="删除名称" /></td>
    </tr>
    <tr>
      <td></td>
      <td></td>
    </tr>
  </table>
  </form>
  </div>
  </body>
</html>
