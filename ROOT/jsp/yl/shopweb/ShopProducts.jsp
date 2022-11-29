<%@page import="tea.entity.util.Lucene"%>
<%@page import="tea.entity.member.Profile"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.*"%><%@page import="tea.entity.admin.*"%><%@page import="tea.entity.yl.shop.*"%><%


Http h=new Http(request,response);

Iterator it;
StringBuilder sql = new StringBuilder(" AND state = 0 ");
StringBuilder par=new StringBuilder("?");
int scount =6;

int category=h.getInt("category");
String keywords = h.get("content","");

if(category>0){
par.append("&category="+category);
sql.append(" AND ca.path like '%|"+category+"|%'");
}
if((keywords=Lucene.f(keywords)).length()>0){
	if(keywords.length()>64)
		keywords = keywords.substring(0,64);
	sql.append(" AND name1 like '%"+keywords+"%'");
	par.append("&content=").append(Http.enc(keywords));
}


int pos=h.getInt("pos");
if(pos==1){
	pos = 0;
}
par.append("&pos=");
%><!doctype html>
<head>


<script>
var ls=parent.document.getElementsByTagName("HEAD")[0];
document.write(ls.innerHTML);
var arr=parent.document.getElementsByTagName("LINK");
for(var i=0;i<arr.length;i++)
{
  document.write("<link href='"+arr[i].href+"' rel='"+arr[i].rel+"' type='text/css'>");
}
</script>

</head>

<script type="text/javascript">
	function AutoResizeImage(maxWidth,maxHeight,objImg){
		var img = new Image();
		img.src = objImg.src;
		var hRatio;
		var wRatio;
		var Ratio = 1;
		var w = img.width;
		var h = img.height;
		wRatio = maxWidth / w;
		hRatio = maxHeight / h;
		if (maxWidth ==0 && maxHeight==0){
		Ratio = 1;
		}else if (maxWidth==0){//
		if (hRatio<1) Ratio = hRatio;
		}else if (maxHeight==0){
		if (wRatio<1) Ratio = wRatio;
		}else if (wRatio<1 || hRatio<1){
		Ratio = (wRatio<=hRatio?wRatio:hRatio);
		}
		if (Ratio<1){
		w = w * Ratio;
		h = h * Ratio;
		}
		objImg.height = h;
		objImg.width = w;
	}
</script>
<body>

         <form name="form1" action="ShopProducts.jsp" value="<%= category%>">
            <input id="category" name="category" type="hidden" value="<%= category%>"/>
          </form>
<div class="maindiv clt">
    <div class="mrigthdiv">
    
    <div class="mrxia">
    <%
    int sum = ShopProduct.count(sql.toString());
    if(sum>0){
    %>
    <div class="showlist">
    <ul class="showul clt">
    <%
    List<ShopProduct> plist = ShopProduct.find(sql.toString()+" order by pr.time desc ", pos, scount);
    for(int i=0;i<plist.size();i++){
    ShopProduct pd = plist.get(i);
    out.print("<li><span class='pic'><a href='/html/folder/14110010-1.htm?product=" + pd.product + "' target='_blank'><img src='" + pd.getPicture('s') + "' onload='AutoResizeImage(195,125,this)'  /></a></span>");
    out.print("<div class='tit'><div class='titout'><b class='tt'>"+pd.getAnchor(h.language)+"</b>");
    out.print("<span class='number'>商品编号："+MT.f(pd.yucode)+"</span></div>");
    out.print("<div class='texts' title='"+Lucene.t(pd.content[1])+"'>"+ MT.f(Lucene.t(pd.content[1]),218)+"</div>");
    float price = pd.price;
	Profile pf = Profile.find(h.member);
	if(pf.qualification==1&&pd.category==ShopCategory.getCategory("lzCategory")){
		ShopQualification sq = ShopQualification.findByMember(h.member);
		if(sq.id>0){
			ShopPriceSet sps = ShopPriceSet.find(sq.hospital_id,pd.product,0);
			if(sps.price>0){
				price=sps.price;
			}
		}				
	}
	if(pf.membertype==2){//代理商价格
			ShopPriceSet sps = ShopPriceSet.find(1,pd.product,0);
			if(sps.price>0){
				price=sps.price;
			}
	}
	if(pd.price_display==1){
		String priceStr = "";
		if("".equals(MT.f(pd.price_type)))
			priceStr = "面议";
		else
			priceStr = pd.price_type;
		out.print("<div class='ord'><div class='price'>销售价格：<span>"+ priceStr +"</span></div>");
	}else{
		out.print("<div class='ord'><div class='price'>销售价格：<strong>&yen;&nbsp;"+ price +"</strong></div>");
		out.print("<div class='nowGo'><a href='/html/folder/14110010-1.htm?product=" + pd.product + "' target='_blank'>立即订购</a></div></div>");
	}
    out.print("</div>");
    out.print("</li>");
    }
    %>
    </ul>
    <div id="PageNum">
    <%if(sum>scount)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,scount));%>
   
    </div>
    </div>
    <%
    }else{
    %>
    <div class="conwu">很抱歉，还没有商品</div>
    <%
    }
    %>
    </div>
    </div>
</div>
<script type="text/javascript">
mt.fit();
</script>
</body>
</html>
