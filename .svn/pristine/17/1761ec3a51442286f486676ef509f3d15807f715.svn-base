<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.ui.TeaSession" %><%!

public static final String BADWORDS[] =
            {"李洪志,法轮,法伦,法抡,法沦,法囵,法仑,法纶,发轮,发伦,发抡,发沦,发囵,发仑,发纶,大法,古怪歌,李宏志,江八点,江独裁,民运,民猪,真善忍,政治风波,疆独,大法弟子,六四,东突,江泽民,李鹏,共匪,falungong,绿色环保手机,非典,法轮功,胡锦涛,温家宝,6.4,阴道,阴茎,做爱,makelove,毛泽东,肛交,口交,阴户,骚逼,骚穴,肛门,群交,肛交,鸡巴,老二,抽插,乳交,中奖信息,游行,游行示威,陈水匾,李登辉,真主,萨达姆,恐怖袭击,钓鱼岛,集会,上访,罢工,罢课,代办签证,代办证件,劳务中介,代办移民,劳务签证,市场最低价,跳楼价,极品价,均价,帅哥美女,治愈率百分百,祖传秘方,伟大发明,彻底根治,反民主,反动,反党,反共,最低价,最优惠,最便宜,最好用,最实惠,最时髦,最高档,最轻便,极便宜,极优惠,极实惠,极好用,大放血,大减价,政府参与,政府牵头,国家参与,国家牵头,部参与,部牵头,国家认定,政府认定,国家指定,政府指定,部认定,部指定,政府挂牌,政府授权,国家挂牌,国家授权,不挂牌,不授权,出血价,割肉价,跳楼价,全城最低,最优良的服务,超值价,广而告之,最好的产品,大甩卖,最优惠的价格,超低价,慰安妇,手淫,国家软弱,政府软弱,汉奸,日奸,折后再送,130号码,131号码,133号码,联通手机号码,CDMA号码,小灵通号码,宋祖英,性交,做爱,六彩,性欲,赌博,牌九,特码,四小码,麻将,透视镜,码会,鸟会,足球娱乐,娱乐足球,银联卡,阿扁,靖国神社,贪污,受贿,官倒,官商,政治气氛,粉饰太平,政府无能,腐化,双规,粉仔,吸毒,海洛因,可卡因,贩毒品,统战,中全会,K仔,政治潮流,冰毒,多党制,民主党,实现民主,独裁,专制,新闻自由,新闻开放,言论自由,共党,劣等人种,博彩,操你,傻B,傻逼,卖淫,淫荡,叫床,银联,同床,同居,妹疼,妹痛,弟疼,弟痛,姐疼,姐痛,哥疼,哥痛,同房,打炮,造爱,性爱,作爱,做爱,操你,日你,日批,日逼,我操,操死,开苞,肉棍,肉棒,肉洞,荡妇,阴囊,睾丸,捅你,捅我,插我,插你,插她,插他,干你,干她,干他,妓女,射精,口淫,屁眼,阴户,阴门,龟头,阴毛,避孕套,你妈逼,大鸡巴,性高潮,性虐待,性高潮,大法,弟子,明慧,大法,打倒,台独,朱容基,朱镕基,李长春,李瑞环,胡锦涛,台湾独立,藏独,西藏独立,疆独,新疆独立,邓小平,盖帽,坐台,暴动,暴乱,尉健行,李岚清,黄丽满,自焚,猫肉,温家宝,吴邦国,曾庆红罗干,吴官正,贾庆林,专制,卖淫,三个代表,一党,多党,民主,行房,自慰,吹萧,色狼,胸罩,内裤,底裤,私处,八老,白皮书,保钓,暴乱,暴政,持不同政见,赤化,大法,大纪元,大纪园,戴相龙,弹劾,登辉,地下教会,地下刊物,弟子,钓鱼岛,东北独立,东社,动乱,独裁,独夫,独立台湾会,杜智富,多维,屙民,发愣,发正念,法十轮十功,法十轮十功,法谪,法谪功,反攻,反共,反人类,反社会,分裂,粉饰太平,封从德,封杀,歌功颂德,共党,共匪,共狗,共军,国家安全,国家机密,国贼,韩东方,韩联潮,汉奸红灯区,红色恐怖,胡紧掏,胡锦涛,胡锦滔,胡锦淘,胡景涛,胡总书记,护法,回民暴动,悔过书,建国党,江core,江八点,江青,江戏子,江泽慧,银联卡,银行卡,车税,返税,汽车购置税,洗黑钱,足球博彩,外围赌球,球彩,赌球网站,网上博彩,港澳博球网,赌盘,赔率,外围庄家"
    };
%><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
	response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
	return;
}

String _strId=request.getParameter("id");

if(request.getParameter("delete")!=null)
{
  String nodes[]=request.getParameterValues("nodes");
  String bbsreplys[]=request.getParameterValues("bbsreplys");
  if(nodes!=null)
  {
    for(int i=0;i<nodes.length;i++)
    {
      Node obj = Node.find(Integer.parseInt(nodes[i]));
      obj.delete(teasession._nLanguage);
    }
  }else if(bbsreplys!=null)
  {
    for(int i=0;i<bbsreplys.length;i++)
    {
      BBSReply obj = BBSReply.find(Integer.parseInt(bbsreplys[i]));
      obj.delete();
    }
  }
  response.sendRedirect(request.getRequestURI()+"?community="+teasession._strCommunity);
  return;
}

Resource r=new Resource();
r.add("/tea/resource/BBS");

String father=request.getParameter("father");
String from=request.getParameter("from");
String to=request.getParameter("to");
String creator=request.getParameter("creator");
String keywords=request.getParameter("keywords");

int pos1=0;
String tmp=request.getParameter("pos1");
if(tmp!=null)
{
  pos1=Integer.parseInt(tmp);
}

int pos2=0;
tmp=request.getParameter("pos2");
if(tmp!=null)
{
  pos2=Integer.parseInt(tmp);
}

StringBuffer param=new StringBuffer();
param.append("?community=").append(teasession._strCommunity);
param.append("&id=").append(_strId);

StringBuffer s1=new StringBuffer();
StringBuffer s2=new StringBuffer();
s1.append(" n.community=").append(DbAdapter.cite(teasession._strCommunity)).append(" AND n.type=57");
s2.append(" n.community=").append(DbAdapter.cite(teasession._strCommunity)).append(" AND n.type=57");

if(father!=null&&father.length()>0)
{
  s1.append(" AND n.father=").append(father);
  s2.append(" AND n.father=").append(father);
  param.append("&father=").append(father);
}
if(from!=null&&from.length()>0)
{
  s1.append(" AND n.time>=").append(DbAdapter.cite(from));
  s2.append(" AND n.time>=").append(DbAdapter.cite(from));
  param.append("&from=").append(from);
}
if(to!=null&&to.length()>0)
{
  s1.append(" AND n.time<").append(DbAdapter.cite(to));
  s2.append(" AND n.time<").append(DbAdapter.cite(to));
  param.append("&to=").append(to);
}
if(creator!=null&&creator.length()>0)
{
  s1.append(" AND n.vcreator LIKE ").append(DbAdapter.cite("%"+creator+"%"));
  s2.append(" AND n.vcreator LIKE ").append(DbAdapter.cite("%"+creator+"%"));
  param.append("&creator=").append(java.net.URLEncoder.encode(creator,"UTF-8"));
}
if(keywords!=null&&keywords.length()>0)
{
  s1.append(" AND n.node IN (SELECT node FROM NodeLayer WHERE subject LIKE ").append(DbAdapter.cite("%"+keywords+"%")).append(" OR content LIKE ").append(DbAdapter.cite("%"+keywords+"%")).append(")");
  s2.append(" AND br.id IN (SELECT bbsreply FROM BBSReplyLayer WHERE subject LIKE ").append(DbAdapter.cite("%"+keywords+"%")).append(" OR content LIKE ").append(DbAdapter.cite("%"+keywords+"%")).append(")");
  param.append("&keywords=").append(java.net.URLEncoder.encode(keywords,"UTF-8"));
}






%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<SCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<meta http-equiv="refresh" content="10">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "管理")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
<h2><%=r.getString(teasession._nLanguage, "查询")%></h2>
<form name="form1" method="get" action="?" >
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="id" value="<%=_strId%>"/>
<input type="hidden" name="node" value="<%=teasession._nNode%>"/>

<table cellspacing="0" cellpadding="0" id="tablecenter">
<tr><td nowrap><%=r.getString(teasession._nLanguage,"BBSSpace")%>：
<%
if(father==null)
father="";
tea.html.DropDown select=new tea.html.DropDown("father",father);
select.addOption("","--------");

AdminUsrRole aur_obj=AdminUsrRole.find(teasession._strCommunity,teasession._rv._strR);
Communitybbs com_obj=Communitybbs.find(teasession._strCommunity);
boolean _bCommunityMember=  teasession._rv._strR.equals(  com_obj.getSuperhost());

s1.append(" AND (0!=0");
s2.append(" AND (0!=0");
DbAdapter db=new DbAdapter();
try
{
  db.executeQuery("SELECT n.node FROM Node n INNER JOIN Category c ON n.node=c.node WHERE n.type=1 AND n.community="+db.cite(teasession._strCommunity)+" AND c.category=57");
  while(db.next())
  {
    int id=db.getInt(1);
    if(aur_obj.getBbsHost().indexOf("/"+id+"/")!=-1||_bCommunityMember)
    {
      select.addOption(id,Node.find(id).getSubject(teasession._nLanguage));
      s1.append(" OR n.father="+id);
      s2.append(" OR n.father="+id);
    }
  }
}finally
{
  db.close();
}
s1.append(")");
s2.append(")");

out.print(select);
%>
</td>
<td nowrap>FROM：
  <input type="text" name="from" value="<%if(from!=null)out.print(from);%>" readonly size="9">
  <input onClick="showCalendar('form1.from')" type="button" value="...">
TO：<input readonly name="to"  value="<%if(to!=null)out.print(to);%>" type="text" size="9"><input onClick="showCalendar('form1.to')" type="button" value="..."></td>
 <td nowrap></td></tr><tr> <td nowrap><%=r.getString(teasession._nLanguage,"Poster")%>：<input name="creator"  value="<%if(creator!=null)out.print(creator);%>" type="text" size="10"></td>
  <td nowrap><%=r.getString(teasession._nLanguage,"Keywords")%>：<input name="keywords"  value="<%if(keywords!=null)out.print(keywords);%>" type="text" ></td>
  <td nowrap><input type="submit" value="GO"></td></tr>
  </table>
</form>
<br>


<h2><%=r.getString(teasession._nLanguage, "列表-主题")%></h2>
<form name="form2" action="?" method="get">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="id" value="<%=_strId%>"/>
<table cellspacing="0" cellpadding="0" id="tablecenter">
<tr id="tableonetr"><td width=1><input type="CHECKBOX" onClick="selectAll(form2.Nodes,this.checked);"/></td>
  <td>主题</td>
  <td>内容</td>
  <td>发贴人</td>
  <td>回复数量</td>
  <td>创建日期</td>
</tr>
<%
int count=0;
db=new DbAdapter();
try
{
  count=db.getInt("SELECT COUNT(*) FROM Node n WHERE "+s1.toString());
  db.executeQuery("SELECT n.node FROM Node n WHERE "+s1.toString()+" ORDER BY n.node DESC");
  for(int index=0;db.next()&&index<(pos1+25);index++)
  {
    if(index>=pos1)
    {
      Node obj=Node.find(db.getInt(1));
      BBS bbs=BBS.find(obj._nNode,teasession._nLanguage);
      String subject=obj.getSubject(teasession._nLanguage);
      String content=obj.getText(teasession._nLanguage);
      out.print("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>");
      out.print("<td width=1><input name=nodes type=checkbox value="+obj._nNode+" ></td><td>");

      if(bbs.isParktop())
      out.print("[<font color='red'>" + r.getString(teasession._nLanguage, "Parktop") + "</font>]");
      if(bbs.isQuintessence())
      out.print("[<font color='red'>" + r.getString(teasession._nLanguage, "Quintessence") + "</font>]");
      if(keywords!=null&&keywords.length()>0)
      {
        subject=subject.replaceAll(keywords,"<font color='red'>"+keywords+"</font>");
        content=content.replaceAll(keywords,"<font color='red'>"+keywords+"</font>");
        for(int i=0;i<BADWORDS.length;i++)
        {
          subject=subject.replaceAll(BADWORDS[i],"<font style='background-color:#FFFF00'>"+BADWORDS[i]+"</font>");
          content=content.replaceAll(BADWORDS[i],"<font style='background-color:#FFFF00'>"+BADWORDS[i]+"</font>");
        }
      }
      out.print("<a target=_blank href=/servlet/BBS?node="+obj._nNode+" >"+subject+"</A></td>");
      out.print("<td><div style='width:300px; height:80px; overflow:auto;'>"+content+"</div></td>");
      out.print("<td>"+obj.getCreator()+"</td>");
      out.print("<td><a href=/jsp/type/bbs/BBSReplyManage.jsp?community="+teasession._strCommunity+"&node="+obj._nNode+" >"+BBSReply.count(obj._nNode,teasession._nLanguage)+"</a></td>");
      out.print("<td>"+obj.getTimeToString()+"</td></tr>");
    }
  }
}catch(Exception e)
{
  e.printStackTrace();
}finally
{
  db.close();
}
out.print("<tr><td align=center colspan=40>"+new tea.htmlx.FPNL(teasession._nLanguage,param.toString()+"&pos2="+pos2+"&pos1=", pos1,count)+"</td></tr>");
%>
  </table>
  <input onClick="return(confirm('<%=r.getString(teasession._nLanguage,"ConfirmDelete")%>'));" type="submit" name="delete" value="<%=r.getString(teasession._nLanguage,"CBDelete")%>">
</form>

<!-- //////////////////////////////////////////////////////////////////////////////////////////////////////// -->

<h2><%=r.getString(teasession._nLanguage, "列表-回复")%></h2>
<form name="form3" action="?" method="get">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="id" value="<%=_strId%>"/>
<table cellspacing="0" cellpadding="0" id="tablecenter">
<tr id="tableonetr"><td width=1><input type="CHECKBOX" onClick="selectAll(form3.bbsreplys,this.checked);"/></td>
  <td>主题</td>
  <td>内容</td>
  <td>发贴人</td>
  <td>创建日期</td>
</tr>
<%
db=new DbAdapter();
try
{
  count=db.getInt("SELECT COUNT(br.id) FROM BBSReply br INNER JOIN Node n ON br.node=n.node WHERE "+s2.toString());
  db.executeQuery("SELECT br.id FROM BBSReply br INNER JOIN Node n ON br.node=n.node WHERE "+s2.toString()+" ORDER BY br.id DESC");
  for(int index=0;db.next()&&index<(pos2+25);index++)
  {
    if(index>=pos2)
    {
      BBSReply obj=BBSReply.find(db.getInt(1));
      String subject=obj.getSubject(teasession._nLanguage);
      String content=obj.getContent(teasession._nLanguage);
      out.print("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>");
      out.print("<td width=1><input name=bbsreplys type=checkbox value="+obj.getId()+" ></td>");
      if(keywords!=null&&keywords.length()>0)
      {
        subject=subject.replaceAll(keywords,"<font color='red'>"+keywords+"</font>");
        content=content.replaceAll(keywords,"<font color='red'>"+keywords+"</font>");
        for(int i=0;i<BADWORDS.length;i++)
        {
          subject=subject.replaceAll(BADWORDS[i],"<font style='background-color:#FFFF00'>"+BADWORDS[i]+"</font>");
          content=content.replaceAll(BADWORDS[i],"<font style='background-color:#FFFF00'>"+BADWORDS[i]+"</font>");
        }
      }
      out.print("<td><a target=_blank href=/servlet/BBS?node="+obj.getNode()+" >"+subject+"</a></td>");
      out.print("<td><div style='width:300px; height:80px; overflow:auto;'>"+content+"</div></td>");
      out.print("<td>"+obj.getMember()+"</td>");
      out.print("<td>"+obj.getTimeToString()+"</td></tr>");
    }
  }
}catch(Exception e)
{
  e.printStackTrace();
}finally
{
  db.close();
}
out.print("<tr><td align=center colspan=40>"+new tea.htmlx.FPNL(teasession._nLanguage,param.toString()+"&pos1="+pos1+"&pos2=", pos2,count)+"</td></tr>");
%>
  </table>
  <input onClick="return(confirm('<%=r.getString(teasession._nLanguage,"ConfirmDelete")%>'));" type="submit" name="delete" value="<%=r.getString(teasession._nLanguage,"CBDelete")%>">
</form>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
