<%@page contentType="text/html;charset=UTF-8"  %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="tea.entity.bpicture.*" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="java.util.*" %>
<%@ page import="tea.entity.member.*" %>
<%@page import="tea.db.*" %>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");
TeaSession teasession = new TeaSession(request);

StringBuffer param=new StringBuffer("?community=").append(teasession._strCommunity);
StringBuffer sql=new StringBuffer(" and member="+DbAdapter.cite(teasession._rv.toString())+" and passpage=1 ");
String sear = request.getParameter("txtSearch");
if(sear!=null&&sear.length()>0)
{
  sql.append(" and node like ").append(DbAdapter.cite("%"+sear+"%")).append(" or node in(select node from picture where name like ").append(DbAdapter.cite("%"+sear+"%")+")");
  param.append("&txtSearch=").append(sear);
}

int pos = 0;
if (request.getParameter("pos") != null&&request.getParameter("pos").length()>0) {
  pos = Integer.parseInt(request.getParameter("pos"));
}
int pageSize = 5;
if (request.getParameter("npgs") != null) {
  pageSize = Integer.parseInt(request.getParameter("npgs"));
}


String ynready = request.getParameter("ynready");
if(ynready!=null)
{
  if(ynready.equals("1")){
    sql.append(" and  (property=0 or property is null)");
    param.append("&ynready=1");
  }else{
    sql.append(" and  property!=0");
    param.append("&ynready=2");
  }
}
int count = 0;
count = Baudit.count(teasession._strCommunity,sql.toString());

int countwc = 0;
countwc = Baudit.count(teasession._strCommunity,sql.toString()+" and  property!=0");
%>
<html>
<HEAD>
  <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
  <!--<script type=""> if(parent.lantk) { document.getElementsByTagName("LINK")[0].href="/res/csvclub/cssjs/community_02.css"; } </script>
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="" ></SCRIPT>
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/csvclub/js.js" type=""></SCRIPT>-->

<SCRIPT LANGUAGE=JAVASCRIPT SRC="/res/<%=teasession._strCommunity%>/cssjs/3js.js" type="" ></SCRIPT>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
      <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
        <META HTTP-EQUIV="Expires" CONTENT="0">
          <title>图片信息管理</title>

          <style>
          #table001{background:#F6F6F6;border-bottom:10px solid #eee;border-top:10px solid #eee;width:95%;margin-top:10px;padding:15 10px;}
          #table001 td li{line-height:180%;}
          #table003{padding:15px 0 15px 38px;}
          .lzj_youxian{border-right:1px solid #ccc;}
          #table004{padding-right:38px;}
          .hide{margin-left:25px;margin-top:5px;}
          .lzj_tu,.padright,.mandatory{background:url(/res/bigpic/u/0812/08124172.jpg) no-repeat 0 7px;padding-left:12px;}
          .orange{display:block;background:url(/res/bigpic/u/0812/08124169.jpg) no-repeat 0 2px;padding-left:20px;}
          .ready{display:block;background:url(/res/bigpic/u/0812/08124170.jpg) no-repeat 0 2px;padding-left:20px;}
          .Not-ready{display:block;background:url(/res/bigpic/u/0812/08124171.jpg) no-repeat 0 2px;padding-left:20px;}
          #table002 td{background:#eee;border-bottom:1px solid #ccc;height:30px;}
          #table002{width:95%;padding:6px;margin-top:20px;}
          #table005{background:#F6F6F6;border-bottom:5px solid #eee;height:30px;padding:5px 0;padding-right:15px;}
          .bg8 td{background:#eee;border-bottom:1px solid #ccc;}
          #tablecenter0002{width:95%;}
          #tablecenter0003{width:100%;border-bottom:1px solid #ccc;border-right:1px solid #ccc;margin-top:15px;}
          #tablecenter0003 td{border-top:1px solid #ccc;padding:5px;}
          .lzj_input input{border:0;}
          .lzj_wu{border-left:1px solid #ccc;padding:5px;line-height:150%;}
          .lzj_kuan{width:50px;height:18px;border:1px solid #7F9DB9;background:#fff;text-align:right;}
          .lzj_kuan1{display:block;width:350px;border:1px solid #7F9DB9;background:#fff;margin-bottom:5px;}
          .lzj_kuan2{width:300px;border:1px solid #7F9DB9;background:#fff;}
          #tableborder{margin-bottom:0px;}
          #tableborder td{border:0;padding:3;line-height:150%;}

          #lzj_table{border:0;}
          #lzj_table td{border:0;padding:0;}
          #txtSearch{border:1px solid #7F9DB9;background:#fff;width:200px;height:23px;line-height:23px;*line-height:18px;}
          #btnSearch,.lzj_001,#kwd{border:1px solid #7F9DB9;background:#fff;height:23px;line-height:23px;*line-height:18px;padding-bottom:5px;*padding-bottom:0;}
          </style>
          <script type="">
          function checkit()
          {
            if(document.sear.txtSearch.value=='图片名称或B-picture图片编号'){
              alert('请输入正确的图片名称或B-picture图片编号');
              return false;
            }
            return true;
          }
          </script>
</head>
<body style="margin:0;">
<div id="wai">
  <div id="li_biao"><a href="http://bp.redcome.com" target="_top">首页</a>&nbsp;>&nbsp;管理中心&nbsp;>&nbsp;图像管理</div>
  <H1>图像管理</H1>

  <table border="0" cellpadding="0" cellspacing="0" id="table001">
    <tr>
      <td id="table003"><strong>操作说明</strong></td>
      <td>&nbsp;</td>
      <td width="1%" rowspan="2" class="border"><img height="1" src="images/s.gif" width="1" border="0" alt=""></td>
        <td><strong>网页说明</strong></td>
    </tr>
    <tr valign="top">
      <td width="24%" nowrap class="border-dash" id="table003"><ul class="lzj_youxian">
        <!--<li class="padright"><a href="/jsp/bpicture/saler/Saler_Pseudonym.jsp" >设置和管理摄影师名称 </a>-->
          <li class="lzj_tu"><a href="/jsp/bpicture/saler/Saler_my_images.jsp"><strong>查看所有图片(<%=count%>)</strong></a>
            <ul>
                <li class="not-ready" title="Not ready"><a href="/jsp/bpicture/saler/Saler_my_images.jsp?ynready=1">信息不完整的图片<span class="nouline"> (<%=count-countwc%>)</span></a></li>
                <li class="ready" title="ready" ><a href="/jsp/bpicture/saler/Saler_my_images.jsp?ynready=2">信息完整的图片<span class="nouline"> (<%=countwc%>)</span></a></li>
            </ul></li>
</ul></td>
<td width="20%"><strong>查找图片</strong><br>
  <br>
  <form name="sear" action="?" onsubmit="return checkit();">
  <input type="hidden" name="id" value="<%=request.getParameter("id")%>"/>
  <input type="hidden" name="pos2" value="<%=pos%>"/>
  <input type="hidden" name="npgs2" value="<%=pageSize%>"/>
  <input type="hidden" name="id2" value="<%=request.getParameter("id")%>"/>
  <table cellspacing="0" cellpadding="0" width="95%" border="0">
    <tr>
      <td><input style="WIDTH: 180px" type="text" onfocus="this.value='';" onblur="this.value='图片名称或B-picture图片编号';" value="<%if(sear!=null){out.print(sear);}else{out.print("图片名称或B-picture图片编号");}%>" name="txtSearch"></td>
        <td class="padleft"><input id="btnSearch" type="submit" value="查询" name="btnSearch"></td>
    </tr>
  </table>
  </form></td>
  <td width="55%" id="table004"><ul style="list-style-type:none;">
    <li class="mandatory"><strong>必填信息</strong>。</li>
    <li class="not-ready"><font color="#CC0001"><strong>信息不完整的图片</strong></font> - 图片一些必要信息没有填写好。</li>
    <li class="ready"><font color="#006600"><strong>信息完整的图片</strong></font> -图片必要的相关信息已填写完毕 管理员审核压缩后可以进行销售。</li>

</ul>
如果您的图片已经出售，您可以变更，删除或添加到下面的信息，在24小时内仍然可见 。 </td>
    </tr>
  </table>

  <table cellpadding=2 cellspacing=0 border=0 id="table002">
    <form name="fm" action="?">
    <input type="hidden" name="id" value="<%=request.getParameter("id")%>"/>

    <tr>
      <td width=90% nowrap class="padleft">所有图片(<%=Baudit.count(teasession._strCommunity,sql.toString())%>)</td>

      <td width=5% nowrap>每页图片数目:</td>
      <td width=5% class="padright"><select name="npgs" class=button onChange="document.fm.submit();">
        <OPTION value="5" <%if(pageSize == 5)out.print("selected");%>>5</OPTION>
        <OPTION value="10" <%if(pageSize == 10)out.print("selected");%>>10</OPTION>
        <OPTION value="20" <%if(pageSize == 20)out.print("selected");%>>20</OPTION>
        <OPTION value="40" <%if(pageSize == 40)out.print("selected");%>>40</OPTION>
</select>
      </td>
    </tr>
    </form>
  </table>

  <form name="form1" action="/servlet/EditBPicture" method="POST" enctype="multipart/form-data" onSubmit="return check(this);">
  <input type="hidden" name="act" value="upmore"/>
  <input type="hidden" name="id" value="<%=request.getParameter("id")%>"/>
  <input type="hidden" name="pagesize" value="<%=pageSize%>"/>
  <input type="hidden" name="pos" value="<%=pos%>"/>
  <input type="hidden" name="count" value="<%=count%>"/>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter0002">


    <!--图片循环-->
    <%
    boolean show= false;
    Enumeration e = Baudit.findImgNode(" and community="+DbAdapter.cite(teasession._strCommunity)+sql.toString()+" order by dateaudit desc",pos,pageSize);
    if(e.hasMoreElements())
    {
      show=true;
      %>
      <tr>
        <td align="right" valign="middle" id="table005"> <%if(count>pageSize){
        out.print(new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&npgs="+pageSize+"&pos=",pos,count,pageSize));
      }%>
      <input type="submit" value="保存更改" class="lzj_001"/></td>
      </tr>
      <%
      }
      int cj = 0;
      for(int i = 0;e.hasMoreElements(); i++)
      {
        cj++;
        int node = ((Integer) e.nextElement()).intValue();
        Picture p = Picture.find(node);
        Node n = Node.find(node);
        Baudit ba = Baudit.find(node);

        String picture ="/res/"+teasession._strCommunity+"/picture/"+node+".jpg";
        String cls = "";
        if(ba.getClassific()!=null){
          String[] clas = ba.getClassific().split("/");
          for(int j = 0; j < clas.length; j++)
          {
            cls +=clas[j];
          }
        }
        %>
        <tr>
          <td>

            <table width="100%" border="0" cellpadding="0" cellspacing="0" id="tablecenter0003">
              <tr>
                <td width="177" rowspan="16" valign="top" class="lzj_wu"><br />
                  <a href="/jsp/bpicture/saler/Saler_EditImage.jsp?node=<%=node%>"><img src="<%=picture%>" width="150" alt=""  /></a><br /><a href="/jsp/bpicture/saler/Saler_EditImage.jsp?node=<%=node%>">更多选项</a></td>
                  <td width="150" class="lzj_wu" >出售</td>
                  <td >&nbsp;</td>
                  <td rowspan="14" class="lzj_wu">
                    <table width="350" border="0" cellpadding="0" cellspacing="0" id="tableborder">
                      <tr>
                        <td colspan="2"><input type="hidden" name="node<%=i%>" value="<%=node%>"/>
                          标题&nbsp;*</td>
                      </tr>
                      <tr>
                        <td>图片的简单描述</td>
                        <td align="right" nowrap="nowrap"><span id="aaa<%=i%>"><%=n.getSubject(1).length()%></span>/128 </td>
                      </tr>
                      <tr><td colspan="2">
                        <textarea name="caption<%=i%>" cols="24" rows="2" class="lzj_kuan1" id="caption<%=i%>" onpropertychange="t_change('caption','aaa');"><%=n.getSubject(1)%></textarea>
</td></tr><tr><td colspan="2">基本关键字 <input id="kwd" type="button" value="关键字" onClick="var vl=window.showModalDialog(encodeURI('/jsp/bpicture/saler/BkeyWord.jsp?filename=basickey<%=i%>&mv='+document.form1.basickey<%=i%>.value),'_blank','dialogWidth:450px;dialogHeight:600px;dialogLeft:750px;dialogTop:240px;help:no');if(vl==undefined){vl=form1.basickey<%=i%>.value;}form1.basickey<%=i%>.value=vl;"/>
      </td></tr>
      <tr>
        <td nowrap>最相关的单词和短语。</td>
        <td align="right" nowrap="nowrap"><span id="bbb<%=i%>" ><%if(ba.getBasicKey()!=null){out.print(ba.getBasicKey().length());}else{out.print("0");}%></span>
          /50 </td>
      </tr>
      <tr><td colspan="2">
        <textarea name="basickey<%=i%>" cols="32" rows="2" class="lzj_kuan1" id="basickey<%=i%>" onpropertychange="t_change('basickey','bbb');"><%if(ba.getBasicKey()!=null)out.print(ba.getBasicKey());%></textarea></td></tr>
        <tr><td colspan="2">
          主要关键字&nbsp;&nbsp; <input id="kwd" type="button" value="关键字" onClick="var vl=window.showModalDialog(encodeURI('/jsp/bpicture/saler/BkeyWord.jsp?filename=mainkey<%=i%>&mv='+document.form1.mainkey<%=i%>.value),'_blank','dialogWidth:450px;dialogHeight:600px;dialogLeft:750px;dialogTop:240px;help:no');if(vl==undefined){vl=form1.mainkey<%=i%>.value;}form1.mainkey<%=i%>.value=vl;"/>
</td></tr>
<tr>
  <td>下一个最相关的单词和短语。</td>
  <td align="right" nowrap="nowrap"><span id="ccc<%=i%>"><%if(ba.getMainKey()!=null && ba.getMainKey().length()>0){out.print(ba.getMainKey().length());}else{out.print("0");}%></span>
    /300</td>
</tr>
<tr><td colspan="2">
  <textarea name="mainkey<%=i%>" cols="32" rows="2" class="lzj_kuan1"  onpropertychange="t_change('mainkey','ccc');"><%if(ba.getMainKey()!=null)out.print(ba.getMainKey());%></textarea>            </td></tr>
  <tr><td colspan="2">综合关键字 <input id="kwd" type="button" value="关键字" onClick="var vl=window.showModalDialog(encodeURI('/jsp/bpicture/saler/BkeyWord.jsp?filename=intekey<%=i%>&mv='+document.form1.intekey<%=i%>.value),'_blank','dialogWidth:450px;dialogHeight:600px;dialogLeft:750px;dialogTop:240px;help:no');if(vl==undefined){vl=form1.intekey<%=i%>.value;}form1.intekey<%=i%>.value=vl;"/>
</td></tr>
<tr>
  <td>任何其他的单词和词组。</td>
  <td align="right" nowrap="nowrap"><span id="ddd<%=i%>"><%if(ba.getInteKey()!=null && ba.getInteKey().length()>0){out.print(ba.getInteKey().length());}else{out.print("0");}%></span>
    /856</td>
</tr>
<tr><td colspan="2">
  <textarea name="intekey<%=i%>" cols="32" rows="2" class="lzj_kuan1" onpropertychange="t_change('intekey','ddd');"><%if(ba.getInteKey()!=null)out.print(ba.getInteKey());%></textarea>
</td></tr>
<tr><td colspan="2">说明
</td></tr>
<tr>
  <td>解释此图片的相关信息。</td>
  <td align="right" nowrap="nowrap"><span id="eee<%=i%>"><%if(ba.getIntro()!=null && ba.getIntro().length()>0){out.print(ba.getIntro().length());}else{out.print("0");}%></span>/2000 </td>
</tr>
<tr><td colspan="2">
  <textarea name="intro<%=i%>" cols="32" rows="5" class="lzj_kuan1" onpropertychange="t_change('intro','eee');"><%if(ba.getIntro()!=null)out.print(ba.getIntro());%></textarea>
</td></tr><tr><td colspan="2">位置</td></tr>

<tr>
  <td>街道名称，镇，市，州，省，国家等</td>
  <td align="right" nowrap="nowrap"><span id="fff<%=i%>"><%if(ba.getLocation()!=null && ba.getLocation().length()>0){out.print(ba.getLocation().length());}else{out.print("0");}%></span>
    /100</td>
</tr>
<tr><td colspan="2">
  <input name="location<%=i%>" type="text" class="lzj_kuan1" value="<%if(ba.getLocation()!=null)out.print(ba.getLocation());%>"  size="32" onpropertychange="t_change('location','fff');"/></td></tr>
  <tr><td colspan="2">
    发布日期   年　月　日<br>
    您最短发布日期为一年
</td></tr>
<tr>
  <td><input  name="adopDate<%=i%>" type="text" size="29" value="<%if(ba.getAdopDate()!=null)out.print(ba.getAdopDateToString());%>" readonly="readonly"/>
    <img id="adopDate_image" class="bdplButton " alt="" onclick="new Calendar('2006', '2010', 0,'yyyy-MM-dd').show(adopDate<%=i%>);" src="/tea/image/bpicture/date.gif"  border="0" /></td>
    <td></td>
</tr>
                    </table>
    </td>
  </tr>
  <tr>
    <td class="lzj_wu">您上传的图片名称</td>
    <td>&nbsp;<%if(p.get_nName()!=null)out.print(p.get_nName());%></td>
  </tr>
  <tr>
    <td class="lzj_wu">B-picture的图片编号</td>
    <td>&nbsp;<%=ba.getNode()%></td>
  </tr>
  <tr>
    <td class="lzj_wu">图片上传日期</td>
    <td>&nbsp;<%=p.getDateToString(1)%></td>
  </tr>
  <tr>
    <td valign="top" class="lzj_wu" >分类&nbsp;*</td>
    <td valign="top" class="lzj_input">
      <input id="classific1<%=i%>" type="checkbox" name="classific<%=i%>" value="1" <%if(cls.contains("1"))out.print("checked");%>> <label for="classific1<%=i%>">横图</label><br>
      <input id="classific2<%=i%>" type="checkbox" name="classific<%=i%>" value="2" <%if(cls.contains("2"))out.print("checked");%> ><label for="classific2<%=i%>">&nbsp;竖图</label><br>
      <input id="classific3<%=i%>" type="checkbox" name="classific<%=i%>" value="3" <%if(cls.contains("3"))out.print("checked");%> ><label for="classific3<%=i%>">&nbsp;正图</label><br>
      <input id="classific4<%=i%>" type="checkbox" name="classific<%=i%>" value="4" <%if(cls.contains("4"))out.print("checked");%> ><label for="classific4<%=i%>">&nbsp;全景图</label>            </td>
</tr>
<tr>
  <td valign="top" class="lzj_wu">是否有肖像权?&nbsp;*</td>
  <td valign="top" class="lzj_input">
    <table width="100%" border="0" cellpadding="0" cellspacing="0" id="lzj_table">
      <tr>
        <td width="7%"><input id="photography1<%=i%>" type="radio"  value="1" name="photography<%=i%>" onClick="model(this.id,'<%=i%>');" <%if(ba.getPhotography()==1)out.println("checked");%>/></td>
          <td width="93%"><label for="photography1<%=i%>">有</label></td>
      </tr>
      <tr>
        <td><input id="photography2<%=i%>" type="radio"  value="2" name="photography<%=i%>" onClick="model(this.id,'<%=i%>');" <%if(ba.getPhotography()==2)out.println("checked");%>/></td>
          <td><label for="photography2<%=i%>">没有</label>  </td>
      </tr>
      <tr>
        <td><input id="photography3<%=i%>" type="radio"  value="3" name="photography<%=i%>" onClick="model(this.id,'<%=i%>');" <%if(ba.getPhotography()==3)out.println("checked");%>/></td>
          <td><label for="photography3<%=i%>">不需要</label>  </td>
      </tr>
    </table></td>
</tr>
<tr id="trfile<%=i%>" <%if(ba.getPhotography()==1){out.println("");}else{out.print("style=display:none;");}%>>
  <td valign="top" class="lzj_wu">上传/下载文档：</td>
  <td class="lzj_input"><input id="filevalue<%=i%>" type="hidden" name="filevalue<%=i%>"/><a style="position:absolute"><img src="/tea/image/netdisk/deplacer.gif" align="absmiddle">添加文档</a>  <input type="file" id="fdoc<%=i%>" name="fdoc<%=i%>" style="position:absolute;width:10;cursor:hand;filter:Alpha(opacity=0)" onChange="f_click('<%=i%>')"/>
    &nbsp;<span id="fil<%=i%>" style="position:absolute;margin-left:80;">
    <%
    String wpath = "/res/bigpic/salepic/webmaster/肖像权协议.doc";
    if(ba.getFdoc()!=null){
      wpath = ba.getFdoc();
    }
    out.print("<a href=/jsp/include/DownFile.jsp?uri="+java.net.URLEncoder.encode(wpath,"utf-8")+"&name="+java.net.URLEncoder.encode("肖像权协议","utf-8")+"."+wpath.substring(wpath.lastIndexOf(".")+1)+"><img src=\"/tea/image/netdisk/"+wpath.substring(wpath.lastIndexOf(".")+1)+".gif\" />肖像权协议</a>");
    %></span></td>
    </tr>
    <tr>
      <td valign="top" class="lzj_wu">是否有物产权? &nbsp;*</td>
      <td valign="top" class="lzj_input">
        <table width="100%" border="0" cellpadding="0" cellspacing="0" id="lzj_table">
          <tr>
            <td width="7%"><input id="design1<%=i%>" type="radio"  value="1" name="design<%=i%>" <%if(ba.getDesign()==1)out.println("checked");%>/></td>
              <td width="93%"><label for="design1<%=i%>">有</label></td>
          </tr>
          <tr>
            <td><input id="design2<%=i%>" type="radio"  value="2" name="design<%=i%>" <%if(ba.getDesign()==2)out.println("checked");%>/></td>
              <td><label for="design2<%=i%>">没有</label></td>
          </tr>
          <tr>
            <td><input id="design3<%=i%>" type="radio"  value="3" name="design<%=i%>" <%if(ba.getDesign()==3)out.println("checked");%>/></td>
              <td><label for="design3<%=i%>">不需要</label></td>
          </tr>
        </table>
            </td>
    </tr>
    <tr>
      <td valign="top" class="lzj_wu">授权类型&nbsp;*</td>
      <td valign="top" class="lzj_input">
        <!--input id="property3<%=i%>" type="radio"  value="3" name="property<%=i%>" <%if(ba.getProperty()==3)out.println("checked");%>/>&nbsp;<label for="property3<%=i%>">权利保护</label></td-->
        <table width="100%" border="0" cellpadding="0" cellspacing="0" id="lzj_table">
          <tr>
            <td width="7%"><input id="property1<%=i%>" type="radio"  value="1" name="property<%=i%>" <%if(ba.getProperty()==1)out.println("checked");%>/></td>
              <td width="93%"><label for="property1<%=i%>">免版税图片 - <font color="#FE8100">RF</font></label></td>
          </tr>
          <tr>
            <td><input id="property2<%=i%>" type="radio"  value="2" name="property<%=i%>" <%if(ba.getProperty()==2)out.println("checked");%>/></td>
              <td><label for="property2<%=i%>">版权管理类图片 - <font color="blue">RM</font></label></td>
          </tr>
        </table>
    </tr>
    <tr>
         <td valign="top" class="lzj_wu">原始介质</td>
      <td valign="top" class="lzj_input">
          <select id="medium<%=i%>" name="medium<%=i%>">
          <%

          for(int cnt = 0; cnt<Baudit.MEDIUM.length; cnt++){
            out.print("<option value="+cnt);
            if(ba.getMedium() == cnt){
              out.print(" selected");
            }
            out.print(" >"+Baudit.MEDIUM[cnt]+"</option>");
          }
          %>
          </select>
            </td>
        </tr>
    <tr>
      <td valign="top" class="lzj_wu">色彩</td>
      <td valign="top" class="lzj_input">
        <table width="100%" border="0" cellpadding="0" cellspacing="0" id="lzj_table">
          <tr>
            <td width="7%"><input id="color1<%=i%>" type="radio"  value="1" name="color<%=i%>" <%if(ba.getColor()==1)out.println("checked");%>/></td>
              <td width="93%"><label for="color1<%=i%>">彩色</label></td>
          </tr>
          <tr>
            <td><input id="color2<%=i%>" type="radio"  value="2" name="color<%=i%>" <%if(ba.getColor()==2)out.println("checked");%>/></td>
              <td><label for="color2<%=i%>">灰白</label></td>
          </tr>
        </table></td>
    </tr>
    <tr>
      <td valign="top" class="lzj_wu">这是什么图片? *</td>
      <td valign="top" class="lzj_input">
        <table width="100%" border="0" cellpadding="0" cellspacing="0" id="lzj_table">
          <tr>
            <td width="7%"><input id="touse1<%=i%>" type="radio"  value="1" name="touse<%=i%>" <%if(ba.getTouse()==1)out.println("checked");%>/></td>
              <td width="93%"><label for="touse1<%=i%>">照片</label></td>
          </tr>
          <tr>
            <td><input id="touse2<%=i%>" type="radio"  value="2" name="touse<%=i%>" <%if(ba.getTouse()==2)out.println("checked");%>/></td>
              <td><label for="touse2<%=i%>">插图</label></td>
          </tr>
        </table></td>
    </tr>
    <tr>
      <td valign="top" class="lzj_wu">这图片是剪切图吗?&nbsp;*</td>
      <td valign="top" class="lzj_input">
        <table width="100%" border="0" cellpadding="0" cellspacing="0" id="lzj_table">
          <tr>
            <td width="7%"><input id="cutimg1<%=i%>" type="radio"  value="1" name="cutimg<%=i%>" <%if(ba.getCutimg()==1)out.println("checked");%>/></td>
              <td width="93%"><label for="cutimg1<%=i%>">是</label></td>
          </tr>
          <tr>
            <td><input id="cutimg2<%=i%>" type="radio"  value="2" name="cutimg<%=i%>" <%if(ba.getCutimg()==2)out.println("checked");%>/></td>
              <td><label for="cutimg2<%=i%>">不是</label></td>
          </tr>
        </table></td>
    </tr>
    <tr>
      <td valign="top" class="lzj_wu">图片是否经过修改?&nbsp;* </td>
      <td valign="top" class="lzj_input">
        <table width="100%" border="0" cellpadding="0" cellspacing="0" id="lzj_table">
          <tr>
            <td width="7%"><input id="cuted1<%=i%>" type="radio"  value="1" name="cuted<%=i%>" <%if(ba.getCuted()==1)out.println("checked");%>/></td>
              <td width="93%"><label for="cuted1<%=i%>">是</label></td>
          </tr>
          <tr>
            <td><input id="cuted2<%=i%>" type="radio"  value="2" name="cuted<%=i%>" <%if(ba.getCuted()==2)out.println("checked");%>/></td>
              <td><label for="cuted2<%=i%>">不是</label></td>
          </tr>
        </table></td>
    </tr>
    <tr>
      <td class="lzj_wu">摄影师</td>
      <td>
        <%
           String ename = "";
           if(ba.getMember()!=null){
             Profile pf = Profile.find(ba.getMember());
             ename = pf.getLastName(teasession._nLanguage);
           }
      %>
        <input type="text" id="bpseudonymid<%=i%>" size="29" name="bpseudonymid<%=i%>" value="<%=ename%>" />

       <%-- <select id="bpseudonymid<%=i%>" name="bpseudonymid<%=i%>"><option value="0">-------------</option>
      <%
      boolean falgselect=false;
      java.util.Enumeration ee = Bpseudonym.findByCommunity(teasession._strCommunity," and member ="+DbAdapter.cite(teasession._rv.toString()),0,20);
      for(int k=0;ee.hasMoreElements();k++)
      {
        int idb=Integer.parseInt(String.valueOf(ee.nextElement()));
        Bpseudonym bj = Bpseudonym.find(idb);
        out.print("<option value="+idb);


        String falg =Bpseudonym.getsql(" id  "," and applied=1 and member="+DbAdapter.cite(teasession._rv.toString()));
        String biname=teasession._rv.toString();
        int id=0;
        if(falg!=null && falg.length()>0)
        {
           id= Integer.parseInt(falg);
          Bpseudonym bobj=Bpseudonym.find(id);
          biname = bobj.getName();
        }

        if(ba.getBpseudonymid()==idb)
        {
          out.print(" selected ");
          falgselect=true;
        }
        else  if(biname.equals(bj.getName())&& !falgselect)
        {

          out.print(" selected ");
        }
        out.print(">"+bj.getName()+"</option>");
      }
      %>
      </select>--%>
            </td>
    </tr>
    <tr><td class="lzj_wu">定义图片价格：</td><td class="lzj_input"><input name="picprice<%=i%>" value="<%=p.getPrice(teasession._nLanguage)%>"   size="8" onBlur="onmouseupprice(this.value,<%=i+1%>)" onKeyPress="if(event.keyCode<48||event.keyCode>57)event.returnValue=false;" /></td></tr>
            </table>

      </td>
</tr>
<%
}
%>
<!--循环完毕-->
<%
if(show){
  %>
  <tr>
    <td align="right" valign="middle" id="table005">
      <input type="hidden" name="cj" value="<%=cj%>"/>
      <%if(count>pageSize)
      {
        out.print(new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&npgs="+pageSize+"&pos=",pos,count,pageSize));
      }%>
      <input type="submit" class="lzj_001" value="保存更改"/>
    </td>
  </tr>
  <%}%>
  </table>
  </form>
  <%@include file="/jsp/include/Canlendar4.jsp" %>
  <script type="">
  function t_change(obj1,obj2)
  {
    for(var i = 0; i < <%=cj%>; i++){
      document.getElementById(obj2+i).innerHTML = document.getElementById(obj1+i).value.length;
    }
  }
  function check(form)
  {
    for(var i = 0; i < <%=cj%>; i++)
    {
      if(document.getElementById('classific1'+i).checked==false&&document.getElementById('classific2'+i).checked==false&&document.getElementById('classific3'+i).checked==false&&document.getElementById('classific4'+i).checked==false)
      {
        alert("请选择图片分类");
        document.getElementById('classific1'+i).focus();
        return false;
      }
        if(document.getElementById('photography1'+i).checked==false&&document.getElementById('photography2'+i).checked==false&&document.getElementById('photography3'+i).checked==false)
        {
          alert("请选择是否有肖像权");
          document.getElementById('photography1'+i).focus();
          return false;
        }
        if(document.getElementById('design1'+i).checked==false&&document.getElementById('design2'+i).checked==false&&document.getElementById('design3'+i).checked==false)
        {
          alert("请选择是否有物产权");
          document.getElementById('design1'+i).focus();
          return false;
        }
        if(document.getElementById('property1'+i).checked==false&&document.getElementById('property2'+i).checked==false&&document.getElementById('property3'+i).checked==false)
        {
          alert("请选择授权类型");
          document.getElementById('property1'+i).focus();
          return false;
        }
        if(document.getElementById('color1'+i).checked==false&&document.getElementById('color2'+i).checked==false)
        {
          alert("请选择色彩");
          document.getElementById('color1'+i).focus();
          return false;
        }
        if(document.getElementById('touse1'+i).checked==false&&document.getElementById('touse2'+i).checked==false)
        {
          alert("请选择图片类型");
          document.getElementById('touse1'+i).focus();
          return false;
        }
        if(document.getElementById('cutimg1'+i).checked==false&&document.getElementById('cutimg2'+i).checked==false)
        {
          alert("请选择是否为剪切图");
          document.getElementById('cutimg1'+i).focus();
          return false;
        }
        if(document.getElementById('cuted1'+i).checked==false&&document.getElementById('cuted2'+i).checked==false)
        {
          alert("请选择是否修改过");
          document.getElementById('cuted1'+i).focus();
          return false;
        }
        if(document.getElementById('caption'+i).value.length==0)
        {
          alert('无效-标题');
          document.getElementById('caption'+i).focus();
          return false;
        }
        if(document.getElementById('bpseudonymid'+i).value.length==0)
        {
          alert('无效-摄影师');
          document.getElementById('bpseudonymid'+i).focus();
          return false;
        }
      }
      return true;
    }
    function oc(obj)
    {
      var vl=window.showModalDialog('/jsp/bpicture/saler/BkeyWord.jsp?filename='+obj+'','_blank','dialogWidth:450px;dialogHeight:600px;dialogLeft:750px;dialogTop:240px;help:no');if(vl==undefined){vl=form1.obj.value;}form1.obj.value=vl;
    }
    function onmouseupprice(pic,l)
    {
      if(document.getElementById('picprice'+l).value=='')
      {
        document.getElementById('picprice'+l).value=pic;
      }
    }
    function f_click(obj)
    {
      var path=document.getElementById('fdoc'+obj).value;
      var name=path.substring(path.lastIndexOf("\\")+1);
      var ex=name.substring(name.lastIndexOf(".")+1);
      document.getElementById("fil"+obj).innerHTML="<img src=/tea/image/netdisk/"+ex+".gif width='16' height='16' onerror=onerror=null;src='/tea/image/netdisk/defaut.gif'>"+name+"　<a href=javascript:f_del('"+obj+"');><b>移除</b></a>";
      document.getElementById("filevalue"+obj).value = path;
    }
    function f_del(i)
    {
      var obj = document.getElementById("fdoc"+i);
      obj.outerHTML = obj.outerHTML;
      var obj1 = document.getElementById("filevalue"+i);
      obj1.outerHTML = obj1.outerHTML;

      document.getElementById("fil"+i).innerHTML="&nbsp;";

    }
    function model(obj,idex)
    {

      if(obj == 'photography1'+idex)
      {
        document.getElementById('trfile'+idex).style.display='';
      }else
      {
        document.getElementById('trfile'+idex).style.display='none';
      }

    }
    </script>
    </div>
</body>
</HTML>

