<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="java.util.*"%><%@page import="tea.entity.*"%>
<%@page import="tea.entity.admin.*"%><%@page import="tea.entity.yl.shop.*"%>
<%@page import="tea.entity.util.Lucene"%><%@page import="tea.entity.member.Profile"%><%


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
    List<ShopProduct> plist = ShopProduct.find(sql.toString(), pos, scount);
    for(int i=0;i<plist.size();i++){
    ShopProduct pd = plist.get(i);
    out.print("<li><table class='pic'><tr><td value='middle' align='center'><a href='javascript:void(0);' onclick=parent.location='/xhtml/folder/14110010-1.htm?product=" + pd.product + "'><img src='" + pd.getPicture('b') + "' /></a></td></tr></table>");
    out.print("<div class='tit'><div class='titout'><b class='tt'>"+pd.getAnchorX(h.language)+"</b>");
    out.print("<span class='number'>商品编号："+MT.f(pd.yucode)+"</span></div>");
    out.print("<div class='texts'>"+Lucene.t(pd.content[1])+"</div>");
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
		out.print("<div class='ord'><div class='price'>销售价格：<strong>"+ priceStr +"</strong></div>");
	}else{
		out.print("<div class='ord'><div class='price'>销售价格：<strong>&yen;&nbsp;"+ price +"</strong></div>");
		out.print("<div class='nowGo'><a href='javascript:void(0);' onclick=parent.location='/xhtml/folder/14110010-1.htm?product=" + pd.product + "'>立即订购</a></div></div>");
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
    <div class="conwu"><img src="/res/Home/structure/14129634.gif" /></div>
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
