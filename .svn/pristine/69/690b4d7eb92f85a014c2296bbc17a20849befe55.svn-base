<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="tea.entity.node.Talkback"%>
<%@page import="tea.entity.member.Profile"%>
<%@page import="tea.entity.member.WomenOptions"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.Entity"%>
<%@page import="tea.entity.node.Node"%>
<%@page import="tea.entity.node.Event"%>
<%@page import="tea.entity.node.NightShop"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="tea.ui.TeaSession" %>
<%@page import="java.util.*" %>

<%@ page import="tea.resource.*" %>
<%@page import="java.math.BigDecimal"%>
<%@page import="java.text.DecimalFormat"%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

Resource r = new Resource();
r.add("/tea/resource/fashiongolf");

TeaSession teasession=new TeaSession(request);
String community=teasession._strCommunity;
java.util.Date date = new java.util.Date();




String nexturl =  request.getRequestURI()+"?"+request.getQueryString();

StringBuffer sql=new StringBuffer(" and type =45 and hidden = 0  and community = ").append(DbAdapter.cite(community));
StringBuffer param=new StringBuffer();

param.append("?community="+teasession._strCommunity);


sql.append(" and exists (select ns.node from NightShop ns where n.node = ns.node)");
String province = request.getParameter("provinceid");	//省份province
	String city = request.getParameter("cityid");			//城市city2
	String area = request.getParameter("areaid");			//区location	
	
	if(province!=null && province.length()>0 && !"null".equals(province)){	
		sql.append(" and exists (select node from NightShop ev where ev.node = n.node and ev.provinceid ="+DbAdapter.cite(province)+" )");
		param.append("&provinceid="+URLEncoder.encode(province, "UTF-8"));
	}	

	if(city!=null && city.length()>0 && !"null".equals(city)){
		sql.append(" and exists (select node from NightShop ev where ev.node = n.node and ev.cityid ="+DbAdapter.cite(city)+" )");
		param.append("&cityid="+URLEncoder.encode(city, "UTF-8"));	
	}
	if(area!=null && area.length()>0 && !"null".equals(area)){
		sql.append(" and exists (select node from NightShop ev where ev.node = n.node and ev.location ="+DbAdapter.cite(area)+" )");
		param.append("&areaid="+URLEncoder.encode(area, "UTF-8"));	
	}
int nstype1 = 0;
if(teasession.getParameter("xpinpai")!=null && teasession.getParameter("xpinpai").length()>0)
{
	nstype1 = Integer.parseInt(teasession.getParameter("xpinpai"));	
}
if(nstype1>0)
{
	sql.append(" and exists(select ns.node from NightShop ns where n.node = ns.node and ns.nstype1="+nstype1+")");
	param.append("&xpinpai=").append(nstype1);
}

int nstype2 = 0;
if(teasession.getParameter("xxinghao")!=null && teasession.getParameter("xxinghao").length()>0)
{
	nstype2 = Integer.parseInt(teasession.getParameter("xxinghao"));	
}
if(nstype2>0)
{
	sql.append(" and exists(select ns.node from NightShop ns where n.node = ns.node and ns.nstype2="+nstype2+")");
	param.append("&xxinghao=").append(nstype2);
}
String keywords = teasession.getParameter("keywords");
if(keywords!=null && keywords.length()>0)
{
	
	sql.append(" and exists(select nl.node from NodeLayer nl  where n.node = nl.node and nl.subject like "+DbAdapter.cite("%"+keywords+"%")+")");
	param.append("&keywords=").append(URLEncoder.encode(keywords, "UTF-8"));
	//out.print(sql.toString());
}

 
int pos=0,size = 20;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}
param.append("&pos=").append(pos);

int count = Node.count(sql.toString());
String getDisSql = null;
String eventnode = teasession.getParameter("event");
String golfnode = teasession.getParameter("golf");
String nightshopnode = teasession.getParameter("nightshop");
if(eventnode!=null){
	sql.append(" ORDER BY (getDistanceOfMap((select Map from event where node = "+eventnode+"),(select e.map from `nightshop` e where e.node = n.node)))");
	getDisSql = "select node,getDistanceOfMap((select Map from event where node = "+eventnode+"),map) dis from nightshop";
}else if(golfnode!=null){
	sql.append(" ORDER BY (getDistanceOfMap((select Map from golf where node = "+golfnode+"),(select e.map from `nightshop` e where e.node = n.node)))");
	getDisSql = "select node,getDistanceOfMap((select Map from golf where node = "+golfnode+"),map) dis from nightshop";
}else if(nightshopnode!=null){
	sql.append(" ORDER BY (getDistanceOfMap((select Map from nightshop where node = "+nightshopnode+"),(select e.map from `nightshop` e where e.node = n.node)))");
	getDisSql = "select node,getDistanceOfMap((select Map from nightshop where node = "+nightshopnode+"),map) dis from nightshop";
}else{
	sql.append(" order by time desc ");
}
//out.println(nstype1+":"+nstype2);

%>

<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/ym/ymPrompt.js" type=""></SCRIPT>

<link href="/tea/ym/skin/dmm-green/ymPrompt.css" rel="stylesheet" type="text/css">

  <link href="/tea/CssJs/Home.css" rel="stylesheet" type="text/css">
  <script src="/tea/tea.js" type="text/javascript"></script>
  <script src="/tea/mt.js" type="text/javascript"></script>
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/ym/ymPrompt.js" type=""></SCRIPT>
<link href="/tea/ym/skin/dmm-green/ymPrompt.css" rel="stylesheet" type="text/css">
<script type="text/javascript">

function f_xp(igd,igdstrid,igdname,igdpingpai)
{
	 sendx("/jsp/admin/edn_ajax.jsp?act=ewmxp&wotype=2&wm="+igd+"&igdname="+igdname+"&igdpingpai="+igdpingpai,
			 function(data)
			 {
		 		if(data!=''&&data.length>1)
		 			{
		 			   data = data.trim();
				 	   document.getElementById(igdstrid).innerHTML=data;
		 			}
			 }
			 );
}
f_xp('<%=nstype1 %>','xxinghaoid','xxinghao','<%=nstype2 %>');

function f_city_s(igd)		{
			
			form1.areaid.value=igd;	
				
			form1.submit();
		}	
		
		
//列位置对应关系		
	var colLocArry = new Array();
	//列位置对应关系 
	colLocArry[0]=0;
	colLocArry[1]=1;
	colLocArry[2]=2;
	colLocArry[3]=3;
	colLocArry[4]=4;
	
	//var colTextArr = new Array();
	//colTextArr[0]=“1”;
	//colTextArr[1]="距离";
	//colTextArr[2]="价格";
	//colTextArr[3]="点击率";
	//colTextArr[4]="点评数";
	var lastCol = null;
	var desc = "↓";
	var asc = "↑";
	//比较之前进行数据转换
 	function convert(value, dataType) {
  		switch(dataType) {
		   case "int":
		    return parseInt(value);
		    break
		   case "float":
		    return parseFloat(value);
		    break
		   case "date":
		    return Date.parse(value);
		    break
		   default:
		    return value.toString();
		}
	}
 	function setStateFlag(col){
		if(lastCol==null){
			lastCol = col;
			document.getElementById(lastCol).innerText=asc;
		}else if(lastCol==col){
			if(document.getElementById(lastCol).innerText==asc){
				document.getElementById(lastCol).innerText=desc;
			}else{
				document.getElementById(lastCol).innerText=asc;
			}		
		}else{
			document.getElementById(lastCol).innerText="";
			lastCol=col;
			document.getElementById(lastCol).innerText=asc;
		}
 	} 
 	function compareCols(col, dataType) {
 		
		  return function compareTrs(tr1, tr2) {	  
		   var id1 = tr1.id+"_"+colLocArry[col];		   
		   var id2 = tr2.id+"_"+colLocArry[col];		   
		   value1 = convert(document.getElementById(id1).innerHTML, dataType);
		   value2 = convert(document.getElementById(id2).innerHTML, dataType);	  
		  // alert(id1+"="+value1);
		 // alert(id2+"="+value2);
		   if(isNaN(value1)||value1 == ""){
		   	  return -1;
		   }
		   if(isNaN(value2)||value2 == ""){
		   	  return 1;
		   }
		   if (value1 < value2) {
		    return -1;
		   } else if (value1 > value2) {
		    return 1;
		   } else {
		    return 0;
		   }
		  };
 	}
		//对表格进行排序
	function sortTable(tableId, col, dataType) {		  	
		var table = document.getElementById(tableId);
		var tbody = table.tBodies[0];
		var tr = tbody.rows; 
		var trValue = new Array();			
		for (var i=0; i<tr.length; i++ ) {	
			trValue[i] = tr[i];  //将表格中各行的信息存储在新建的数组中			   
		}
		if (tbody.sortCol == col) {
			trValue.reverse(); //如果该列已经进行排序过了，则直接对其反序排列
		}else{			
			trValue.sort(compareCols(col, dataType));  //进行排序			
		}   
		var fragment = document.createDocumentFragment();  //新建一个代码片段，用于保存排序后的结果
		for (var i=0; i<trValue.length; i++ ) {
			fragment.appendChild(trValue[i]);
		}
		tbody.appendChild(fragment); //将排序的结果替换掉之前的值
		tbody.sortCol = col;
		//setStateFlag(col);
	}	
</script>

<div class="GolfEventLeft">
	<div class="GolfCIfication">
		<div class="title"><%=r.getString(teasession._nLanguage,"area")%></div>
		<div class="list">
            <span id=spanid_ class='<%=area==null||area.equals("")?"locationSelected":"locationAll" %>'>
                <a href="###" onClick="f_city_s('');"><%=r.getString(teasession._nLanguage,"unlimited")%></a>
            </span>
    
            <span id="cityid">
                <%
					StringBuffer innerHtml = new StringBuffer();
					//获得区域
					if(city!=null && !city.equals("")){
						List list = Event.getLocationsByCity(city,teasession._nLanguage);			
						for (Iterator it =list.iterator();it.hasNext();) {
							List ls = (List)it.next();			
							
							innerHtml.append("<span id=spanid_"+ls.get(1)+" class=");
							if(((String)ls.get(1)).equals(area))
							{
								innerHtml.append("locationSelected");
							}else 
							{
								innerHtml.append("locationAll");
							}
							  
							innerHtml.append("><a href=\"###\" onclick=f_city_s('"+ls.get(1)+"'); id= 'locationid_"+ls.get(1)+"'>"+ls.get(1)+"</a>&nbsp;&nbsp;</span>");
						}
					}				
				%>
                <%=innerHtml.toString() %>
            </span>

		</div>
    </div>   
</div>
<div class="GolfEventRight">
<form name="form1" action="?" method="GET">

<input type="hidden" name="act" >

<input type="hidden" name="provinceid" value="<%=province %>">
<input type="hidden" name="cityid" value="<%=city %>">
<input type="hidden" name="areaid" value="<%=area %>">


<input type="hidden" name="node" value="<%=teasession._nNode %>" >
<table cellpadding="0" cellspacing="0" class="searchTable">
<tr>
<td width="220"><%=r.getString(teasession._nLanguage, "category")%>：
<select name="xpinpai" onChange="f_xp(this.value,'xxinghaoid','xxinghao','0');">
 				<option value="0">----</option>
 				<%
 				int wotype = 2;
 				int type = 0;
				int lan = teasession._nLanguage;
	            java.util.List catlist = WomenOptions.findByTpyeAndLan(type,wotype,lan);
				if(catlist!=null && !catlist.isEmpty()){
				for(int i=1;i<catlist.size();i++)
				{
					java.util.List catdetail = (java.util.List)catlist.get(i);
					String id = (String)catdetail.get(0);
					String name = (String)catdetail.get(1);
					String tpye = (String)catdetail.get(2);					
					out.print("<option value="+id);
      				if(nstype1==Integer.parseInt(id))
      				{
      					out.println(" selected ");
      				}
      				out.print(">"+name);
      				out.print("</option>");
				}
			} 				
 				%>
 			</select>
 			<span id="xxinghaoid">
	 			<select name="xxinghao">
	 				<option value="0">----</option>
	 				
	 			</select>
 			</span>
</td>
<td><%=r.getString(teasession._nLanguage, "Keyword")%>：<input type="text" name="keywords" value="<%=Entity.getNULL(keywords)%>"></td>
<td><input type="submit" value="<%=r.getString(teasession._nLanguage, "inquires")%>"></td>
</table>

<table cellpadding="0" cellspacing="0" id="qiujia">
<tr>
<td class="map"></td>
<td class="sort"><span id="juli"> <a href="javascript:sortTable('tablecenter', 1, 'float');"><%=r.getString(teasession._nLanguage, "distance")%></a></span><span id="dianji"> <a href="javascript:sortTable('tablecenter', 2, 'float')"><%=r.getString(teasession._nLanguage, "hits")%></a> </span><span id="dianping"> <a href="javascript:sortTable('tablecenter', 3, 'float')"><%=r.getString(teasession._nLanguage, "Review")%></a></span></td>
</tr>
</table>
<table border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
	<%
		java.util.Enumeration eu = Node.find(sql.toString(),pos,size);		
		if(!eu.hasMoreElements())
		{
			out.print("<tr><td colspan='3' class=\"Norecord\">"+r.getString(teasession._nLanguage, "Norecords")+"</td></tr>");
		}
		//获得距离的值
		Map nodeDisMap = null;
		if(getDisSql!=null){
			nodeDisMap = NightShop.getNodeDisMap(getDisSql);		  		
		}
		for(int i=0;eu.hasMoreElements();i++)
		{
			
		 	int nid = ((Integer)eu.nextElement()).intValue();
		  	Node nobj = Node.find(nid);
		  	NightShop nsobj = NightShop.find(nid,teasession._nLanguage);
		  	int sum = Talkback.count(" and node ="+nid+" and hidden = 1  ");
		  	
	%>
 			<tr id = '<%=nid %>'>    
    			<td nowrap="nowrap" class="td01">
    			<div class="Subject"><a href="/html/nightshop/<%=nid%>-<%=teasession._nLanguage%>.htm" target="_blank"><%=nobj.getSubject(teasession._nLanguage) %></a></div>
    				<%=r.getString(teasession._nLanguage, "address")%>：<%=nobj.getNULL(nsobj.getAddress()) %>
    			</td>
    	<td class="td02">
    				<%    				
					String dis = r.getString(teasession._nLanguage, "NO");
					
					if(getDisSql==null){
						if(teasession._rv!=null)
						{
							Profile p = Profile.find(teasession._rv.toString());
							
							dis = Entity.getMapDis(p.getCoordinate(), nsobj.getMap())+"";
						}else{
							if(session.getAttribute("point")==null){
								dis = r.getString(teasession._nLanguage, "Currentlocationisnotset");
							}else{							
								dis = Entity.getMapDis((String)session.getAttribute("point"), nsobj.getMap());
							}					
						}
					}else{
						if(nightshopnode!=null && Integer.parseInt(nightshopnode)==nid){
							dis = "0.00";
						}else{
							if(nodeDisMap.containsKey(nid+"")){							
								dis = (String)nodeDisMap.get(nid+"");
								DecimalFormat df=new DecimalFormat("#.00");
								BigDecimal disBig = new BigDecimal(dis);
								dis = "" + Float.parseFloat(df.format(disBig));
							}	
						}
											
					}
					System.out.println(dis);
					if(dis.equals(r.getString(teasession._nLanguage, "Currentlocationisnotset"))){
						out.print(dis);
					}else{
						out.print(r.getString(teasession._nLanguage, "distance")+":<span id = '"+nid+"_1'>"+dis+"</span>&nbsp;km	");						
					}
					%>
					
					<span id = "<%=nid%>_2" style="display:none"><%=nobj.getClick()%></span>
					<span id = "<%=nid%>_3" style="display:none"><%=sum%></span>
				</td>
				<td class="td03"> 
					 <div class="ScorePic">
		                <div class="ScorePicPer" style="width:<%int gcount = Talkback.count(" and node ="+nid+" and hidden = 1 and (hint=4 or hint = 5) ");
		                		float ps = (float) gcount / sum;
								java.text.NumberFormat nf = java.text.NumberFormat.getPercentInstance();
								nf.setMinimumFractionDigits(0); // 小数点后保留几位
								String c = ps>0?nf.format(ps):"0%";
								out.println(c);%>;">
						</div>
	                </div>
				</td>
 				<td class="td04">
					 <%
					 	int co = Talkback.count(" and node = "+nid);
					 if(teasession._rv==null)
					 {
							out.print("<a href=\"###\" ");
							out.print(" onclick=\"ymPrompt.win({message:'/jsp/user/userlogin.jsp',width:550,height:380,title:'"+r.getString(teasession._nLanguage, "用户登录")+"',handler:function(){},maxBtn:false,minBtn:false,iframe:true});\"");
							out.print(">");
							out.print(r.getString(teasession._nLanguage, "Writeareview"));
							out.print("</a>");
					 }else
					 if(co==0){
						 
					 %>
 					<a href="###" onClick="ymPrompt.win({message:'/jsp/type/nightshop/NightShopTalkback.jsp?node=<%=nid %>',width:610,height:380,title:'<%=r.getString(teasession._nLanguage, "Userreviews")%>',handler:function(){},maxBtn:false,minBtn:false,iframe:true});	"><%=r.getString(teasession._nLanguage, "Writeareview")%></a></td>
					  <%}
					 else{
						 
						 out.print(r.getString(teasession._nLanguage, "Alreadyreviews"));
					 }
					 %> 
  				</tr> 
			  <%
			  }
			  %>
			  
  </table>
  <table>
  	<% 
			  	if(count>size){
			  %>
  				<tr><td class="feny"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,size)%></td></tr>
				<%} %>
  </table>  
</form>
</div>
