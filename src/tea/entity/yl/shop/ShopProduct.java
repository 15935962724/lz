package tea.entity.yl.shop;

import java.util.*;
import java.sql.SQLException;
import tea.db.DbAdapter;
import tea.entity.*;

public class ShopProduct
{
    protected static Cache c = new Cache(50);
    public int product;
    public int member;
    public int brand; //品牌
    public int category; //商品分类
    public String[] name = new String[2]; //名称
    public float supply; //进货价
    public float list; //标价
    public float price; //销售价
    public String code; //商家编码
    public int inventory; //库存
    public String picture = "|";
    public int state; //是否下架 0 显示 1:隐藏 2:删除
    public String recommend = "|"; //推荐配件
    public int origin; //商品产地
    public float gross; //商品毛重
    public String[] content = new String[2]; //导语
    public String activity;                  //活动详情
    public String[] spec = new String[2]; //积分详情
    public String[] pack = new String[2]; //包装清单
    public int hits; //浏览量
    public int sales; //销量
    public int praise; //好评度
    public Date time;
    public String sync;
    public String color;//颜色
    public String size;//尺寸
    public String packing;//包装
    public String place;//库存地
    public String commend;//专家推荐
    public int popularity;//关注人气
    public String yucode;//编号
    public int shopid;//对应商家id
    public int farming;//种地
    public static String [] FARMINGARR = {"老坑玻璃种","玻璃种","冰种","冰糯花","冬瓜种","油青种","花青种","蜡种","白底青种","芙蓉种","豆种","金丝种","蜜糖黄翠","墨翠","紫罗兰","三彩","铁龙生","干青种"};

    public int indexShow;//是否首页推荐 0不推荐
    public int pcode;//编号
    
    public int model_id;//规格/型号id
    
    public static String[] VIEW_TYPE={"--","列表展示","简介展示"};
    public int view_type;//商品详细页显示类型
    
    public boolean isExist=false;
    
    public String returnc;//审核退回
    
    public int price_display;	//是否显示价格-0不显示；1显示；
    public String price_type;		//价格说明，例如:价格面议
    
    public String factory;	//生产厂家
    public int tps_attch;	//试用包
    
    public int puid;//厂商
    public int send_tps_number;//tps商品推送时的数量
    
    public ShopProduct(int product)
    {
        this.product = product;
    }
    
    public ShopProduct(int brand,int model_id)
    {
        this.brand = brand;
        this.model_id = model_id;
    }

    public static ShopProduct find(int brand,int model_id) throws SQLException
    {
            ArrayList al = find(" AND state in (0,1) AND brand=" + brand+" AND model_id="+model_id, 0, 1);
            ShopProduct t = al.size() < 1 ? new ShopProduct(brand,model_id) : (ShopProduct) al.get(0);
        return t;
    }
    
    public static ShopProduct findpuid(int puid,int model_id) throws SQLException
    {
            ArrayList al = find(" AND state in (0,1) AND puid=" + puid+" AND model_id="+model_id, 0, 1);
            ShopProduct t = al.size() < 1 ? new ShopProduct(puid,model_id) : (ShopProduct) al.get(0);
        return t;
    }
    
    public static ShopProduct find(int product) throws SQLException
    {
        ShopProduct t = (ShopProduct) c.get(product);
        if (t == null)
        {
            ArrayList al = find(" AND product=" + product, 0, 1);
            t = al.size() < 1 ? new ShopProduct(product) : (ShopProduct) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql, int pos, int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            //System.out.println("SELECT pr.product,pr.member,pr.brand,pr.category,pr.name1 FROM product pr" + tab(sql) + " WHERE 1=1" + sql);
            java.sql.ResultSet rs = db.executeQuery("SELECT pr.product,pr.member,pr.brand,pr.category,pr.name0,pr.name1,pr.supply,pr.list,pr.price,pr.code,pr.inventory,pr.picture,pr.state,pr.recommend,pr.origin,pr.gross,pr.content0,pr.content1,pr.activity,pr.spec0,pr.spec1,pr.pack0,pr.pack1,pr.hits,pr.sales,pr.praise,pr.time,pr.sync,pr.yucode,pr.color,pr.size,pr.packing,pr.Place,pr.commend,pr.popularity,pr.shopid,pr.farming,pr.indexshow,pr.pcode,pr.model_id,pr.view_type,pr.returnc,pr.price_type,pr.price_display,pr.factory,pr.tps_attch,pr.puid,pr.send_tps_number FROM shopproduct pr" + tab(sql) + " WHERE 1=1 " + sql, pos, size);
            while (rs.next())
            {
                int i = 1;
                ShopProduct t = new ShopProduct(rs.getInt(i++));
                t.member = rs.getInt(i++);
                t.brand = rs.getInt(i++);
                t.category = rs.getInt(i++);
                t.name[0] = rs.getString(i++);
                t.name[1] = rs.getString(i++);
                t.supply = rs.getFloat(i++);
                t.list = rs.getFloat(i++);
                t.price = rs.getFloat(i++);
                t.code = rs.getString(i++);
                t.inventory = rs.getInt(i++);
                t.picture = rs.getString(i++);
                t.state = rs.getInt(i++);
                t.recommend = rs.getString(i++);
                t.origin = rs.getInt(i++);
                t.gross = rs.getFloat(i++);
                t.content[0] = rs.getString(i++);
                t.content[1] = rs.getString(i++);
                t.activity = rs.getString(i++);
                t.spec[0] = rs.getString(i++);
                t.spec[1] = rs.getString(i++);
                t.pack[0] = rs.getString(i++);
                t.pack[1] = rs.getString(i++);
                t.hits = rs.getInt(i++);
                t.sales = rs.getInt(i++);
                t.praise = rs.getInt(i++);
                t.time = db.getDate(i++);
                t.sync = rs.getString(i++);
                t.yucode = rs.getString(i++);
                t.color = rs.getString(i++);
                t.size = rs.getString(i++);
                t.packing = rs.getString(i++);
                t.place = rs.getString(i++);
                t.commend = rs.getString(i++);
                t.popularity = rs.getInt(i++);
                t.shopid = rs.getInt(i++);
                t.farming = rs.getInt(i++);
                t.indexShow = rs.getInt(i++);
                t.pcode = rs.getInt(i++);
                t.model_id = rs.getInt(i++);
                t.view_type = rs.getInt(i++);
                t.isExist = true;
                t.returnc = rs.getString(i++);
                t.price_type = rs.getString(i++);
                t.price_display = rs.getInt(i++);
                t.factory = rs.getString(i++);
                t.tps_attch = rs.getInt(i++);
                t.puid = rs.getInt(i++);
                t.send_tps_number = rs.getInt(i++);
                c.put(t.product, t);
                al.add(t);
            }
            rs.close();
        } finally
        {
            db.close();
        }
        return al;
    }

    public static int count(String sql) throws SQLException
    {
    	//System.out.println("SELECT COUNT(*) FROM shopproduct pr" + tab(sql) + " WHERE 1=1" + sql);
        return DbAdapter.execute("SELECT COUNT(*) FROM shopproduct pr" + tab(sql) + " WHERE 1=1" + sql);
    }

    public static int countweb(String sql) throws SQLException
    {
    	//System.out.println("SELECT COUNT(*) FROM shopproduct pr" + tab(sql) + " WHERE 1=1" + sql);
        return DbAdapter.execute("SELECT COUNT(*) FROM shopproduct pr" + tab(sql) + " WHERE 1=1" + sql);
    }

    private static String tab(String sql)
    {
        StringBuilder sb = new StringBuilder();
        if (sql.contains(" AND ca."))
            sb.append(" INNER JOIN ShopCategory ca ON ca.category=pr.category");
        if (sql.contains(" AND spm."))
            sb.append(" INNER JOIN ShopProduct_model spm ON spm.id=pr.model_id");
        if (sql.contains(" AND av."))
            sb.append(" INNER JOIN AValue av ON av.product=pr.product");
        return sb.toString();
    }

    public void set() throws SQLException
    {
        String sql;
        ShopProduct sp = ShopProduct.find(product);
        if (!sp.isExist)
        {
        	sql = "INSERT INTO shopproduct(product,member,brand,category,name0,name1,supply,list,price,code,inventory,picture,state,recommend,origin,gross,content0,content1,activity,spec0,spec1,pack0,pack1,hits,sales,praise,time,sync,yucode,color,size,packing,Place,commend,popularity,shopid,farming,indexShow,pcode,model_id,view_type,returnc,price_type,price_display,factory,tps_attch,puid,send_tps_number)VALUES(" + product + "," + member + "," + brand + "," + category + "," + DbAdapter.cite(name[0]) + "," + DbAdapter.cite(name[1]) + "," + supply + "," + list + "," + price + "," + DbAdapter.cite(code) + "," + inventory + "," + DbAdapter.cite(picture) + "," + state + "," + DbAdapter.cite(recommend) + "," + origin + "," + gross + "," + DbAdapter.cite(content[0]) + "," + DbAdapter.cite(content[1]) + ","+DbAdapter.cite(activity) + "," + DbAdapter.cite(spec[0]) + "," + DbAdapter.cite(spec[1]) + "," + DbAdapter.cite(pack[0]) + "," + DbAdapter.cite(pack[1]) + "," + hits + "," + sales + "," + praise + "," +
        			DbAdapter.cite(time) + "," + DbAdapter.cite(sync) + ","+DbAdapter.cite(yucode)+","+DbAdapter.cite(color)+","+DbAdapter.cite(size)+","+DbAdapter.cite(packing)+","+DbAdapter.cite(place)+","+DbAdapter.cite(commend)+","+popularity+","+shopid+","+farming+","+indexShow+","+pcode+","+model_id+","+view_type+","+Database.cite(returnc)+","+Database.cite(price_type)+","+price_display+","+Database.cite(factory)+","+tps_attch+","+puid+","+send_tps_number+")";
        }
        else
            sql = "UPDATE shopproduct SET member=" + member + ",brand=" + brand + ",category=" + category + ",name0=" + DbAdapter.cite(name[0]) + ",name1=" + DbAdapter.cite(name[1]) + ",supply=" + supply + ",list=" + list + ",price=" + price + ",code=" + DbAdapter.cite(code) + ",inventory=" + inventory + ",picture=" + DbAdapter.cite(picture) + ",state=" + state + ",recommend=" + DbAdapter.cite(recommend) + ",origin=" + origin + ",gross=" + gross + ",content0=" + DbAdapter.cite(content[0]) + ",content1=" + DbAdapter.cite(content[1]) + ",activity="+DbAdapter.cite(activity) + ",spec0=" + DbAdapter.cite(spec[0]) + ",spec1=" + DbAdapter.cite(spec[1]) + ",pack0=" + DbAdapter.cite(pack[0]) + ",pack1=" + DbAdapter.cite(pack[1]) + ",hits=" + hits + ",sales=" + sales + ",praise=" + praise + ",time=" + DbAdapter.cite(time) + ",sync=" + DbAdapter.cite(sync) +
                  ",yucode="+DbAdapter.cite(yucode)+",color="+DbAdapter.cite(color)+",size="+DbAdapter.cite(size)+",packing="+DbAdapter.cite(packing)+",Place="+DbAdapter.cite(place)+",commend="+DbAdapter.cite(commend)+",popularity="+popularity+",shopid="+shopid+",farming="+farming+",indexShow="+indexShow+",pcode="+pcode+",model_id="+model_id+",view_type="+view_type+",returnc="+Database.cite(returnc)+",price_type="+Database.cite(price_type)+",price_display="+price_display+",factory="+Database.cite(factory)+",tps_attch="+tps_attch+",puid="+puid+",send_tps_number="+send_tps_number+" WHERE product=" + product;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(product, sql);
        } finally
        {
            db.close();
        }
        c.remove(product);
    }

    public void delete() throws SQLException
    {DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(product, "DELETE FROM shopproduct WHERE product=" + product);
        } finally
        {
            db.close();
        }
        c.remove(product);
    }

    public void set(String f, String v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(product, "UPDATE shopproduct SET " + f + "=" + DbAdapter.cite(v) + " WHERE product=" + product);
        } finally
        {
            db.close();
        }
        c.remove(product);
    }

    //您经常选择的类目
    public static ArrayList often(int member) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT category FROM shopproduct WHERE member=" + member + " GROUP BY category ORDER BY COUNT(category) DESC", 0, 10);
            while (rs.next())
                al.add(rs.getInt(1));
            rs.close();
        } finally
        {
            db.close();
        }
        return al;
    }

    //t:小图 b:大图 s:原图
    public String getPicture(char t) throws SQLException
    {
        if (picture.length() < 2)
            return "/tea/image/404.jpg";
        Attch a = Attch.find(Integer.parseInt(picture.split("[|]")[1]));
        if (t == 't')
            return a.path3;
        if (t == 'b')
            return a.path2;
        //if (t == 's')
        return a.path;
    }

    public String getAnchor(char t) throws SQLException
    {
    	boolean flag = false;
    	if(this.state!=0){
    		flag = true;
    	}
        return "<img src='" + getPicture(t) + "' width='52;' onerror='javascript:this.src=\"/tea/image/404.jpg\"' />";
        //return "<a href='"+(flag?"javascript:alert(\"此商品已下架！\");":"/html/folder/14110010-1.htm?product=" + product + "")+"' target='_blank'><img src='" + getPicture(t) + "' width='52;' onerror='javascript:this.src=\"/tea/image/404.jpg\"' /></a>";
    }

    public String getAnchor(int lang)
    {
    	boolean flag = false;
    	if(this.state!=0){
    		flag = true;
    	}
        return "<a href='"+(flag?"javascript:alert(\"此商品已下架！\");":"/html/folder/14110010-1.htm?product=" + product + "")+"' target='_blank'>" + (state == 0 ? "" : "<s>") + MT.f(name[lang], 38) + "</s></a>";
    }
    
    public String getAnchorX(char t) throws SQLException
    {
    	boolean flag = false;
    	if(this.state!=0){
    		flag = true;
    	}
        return "<a href='javascript:void(0);' onclick=\""+(flag?"alert('此商品已下架！');":"parent.location='/xhtml/folder/14110010-1.htm?product=" + product + "'")+"\"><img src='" + getPicture(t) + "' width='52;' onerror='javascript:this.src=\"/tea/image/404.jpg\"' /></a>";
    }

    public String getAnchorX(int lang)
    {
    	boolean flag = false;
    	if(this.state!=0){
    		flag = true;
    	}
        return "<a href='javascript:void(0);' onclick=\""+(flag?"alert('此商品已下架！');":"parent.location='/xhtml/folder/14110010-1.htm?product=" + product + "'")+"\">" + (state == 0 ? "" : "<s>") + MT.f(name[lang], 38) + "</s></a>";
    }

    public String getAncestor(int lang) throws SQLException
    {
        return ShopCategory.find(category).getAncestor(lang) + " >> " + getAnchor(lang);
    }

    //优惠价
    public float getCoupon() throws SQLException
    {
        Iterator it = Discount.find(" AND type=1 AND(cust=0 OR brand LIKE " + DbAdapter.cite("%|" + brand + "|%") + " OR category LIKE " + DbAdapter.cite("%|" + (ShopCategory.find(category).path + category).split("[|]")[2] + "|%") + " OR product LIKE " + DbAdapter.cite("%|" + product + "|%") + ") ORDER BY value", 0, 1).iterator();
        return it.hasNext() ? ((Discount) it.next()).value * price / 100 : price;
    }

    /**
     * 增加点击
     */
    public void updateclick(){
    	try {
			int flag = DbAdapter.execute("UPDATE shopproduct set popularity = "+(popularity+1)+" WHERE product=" + product);
			if(flag>0){
				popularity++;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
    }

    /**
     * 显示图片
     * @return
     */
    public static String showPic(int type,int count){
    	StringBuffer sb = new StringBuffer();
    	List<ShopProduct> plist = null;
    	try {
	    	if(type==1){//热销
	    		plist = myexecute();
	    	}else if(type==2){//精品推荐
	    		plist = find(" AND state = 0 order by popularity desc", 0, 100);
	    	}
    	if((plist.size()+1)<=count){
    		count = plist.size();
    	}
    	for(int i=0;i<count;i++){
    		ShopProduct pd = plist.get(i);
    		sb.append("<li>");
    		sb.append(find(pd.product).getAnchor('t')+" ");
    		sb.append("<span class='mname'>"+pd.name[1]+"</span>");
    		sb.append("<span class='mprice'>￥"+MT.f(pd.price)+"</span>");
    		sb.append("<span class='mgz'>有"+pd.popularity+"人关注</span>");
    		sb.append("</li>");
    	}
    	} catch (SQLException e) {
			e.printStackTrace();
		}
    	return sb.toString();
    }

    public static ArrayList myexecute() throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
        	java.sql.ResultSet rs = db.executeQuery("SELECT pr.product,pr.member,pr.brand,pr.category,pr.name0,pr.name1,pr.supply,pr.list,pr.price,pr.code,pr.inventory,pr.picture,pr.state,pr.recommend,pr.origin,pr.gross,pr.content0,pr.content1,pr.activity,pr.spec0,pr.spec1,pr.pack0,pr.pack1,pr.hits,pr.sales,pr.praise,pr.time,pr.sync,pr.yucode,pr.color,pr.size,pr.packing,pr.Place,pr.commend,pr.popularity,pr.shopid,pr.farming FROM shopproduct pr where state = 0 order by (select count(1) from trade t inner join Item i on i.trade = t.trade where i.product = pr.product) desc",0,20);
            while (rs.next())
            {
                int i = 1;
                ShopProduct t = new ShopProduct(rs.getInt(i++));
                t.member = rs.getInt(i++);
                t.brand = rs.getInt(i++);
                t.category = rs.getInt(i++);
                t.name[0] = rs.getString(i++);
                t.name[1] = rs.getString(i++);
                t.supply = rs.getFloat(i++);
                t.list = rs.getFloat(i++);
                t.price = rs.getFloat(i++);
                t.code = rs.getString(i++);
                t.inventory = rs.getInt(i++);
                t.picture = rs.getString(i++);
                t.state = rs.getInt(i++);
                t.recommend = rs.getString(i++);
                t.origin = rs.getInt(i++);
                t.gross = rs.getFloat(i++);
                t.content[0] = rs.getString(i++);
                t.content[1] = rs.getString(i++);
                t.activity = rs.getString(i++);
                t.spec[0] = rs.getString(i++);
                t.spec[1] = rs.getString(i++);
                t.pack[0] = rs.getString(i++);
                t.pack[1] = rs.getString(i++);
                t.hits = rs.getInt(i++);
                t.sales = rs.getInt(i++);
                t.praise = rs.getInt(i++);
                t.time = db.getDate(i++);
                t.sync = rs.getString(i++);
                t.yucode = rs.getString(i++);
                t.color = rs.getString(i++);
                t.size = rs.getString(i++);
                t.packing = rs.getString(i++);
                t.place = rs.getString(i++);
                t.commend = rs.getString(i++);
                t.popularity = rs.getInt(i++);
                t.shopid = rs.getInt(i++);
                t.farming = rs.getInt(i++);
                c.put(t.product, t);
                al.add(t);
            }
            rs.close();
        } finally
        {
            db.close();
        }
        return al;
    }


    /*
     * 根据订单id查询 订单明细中的商品规格
     * */
    public static String SelectProductModelByOrderId(String order_id) {
        String modelName = "";//规格名
        try {
            ArrayList<ShopOrderData> shopOrderData = ShopOrderData.find(" AND order_id=" + Database.cite(order_id), 0, Integer.MAX_VALUE);
            if (shopOrderData.size() > 0) {
                //获取商品id
                int productId = shopOrderData.get(0).getProductId();
                //获取商品的规格id
                ShopProduct shopProduct = ShopProduct.find(productId);
                //通过商品的规格id 查询规格
                ShopProductModel productModel = ShopProductModel.find(shopProduct.model_id);

                modelName = productModel.getModel();


            }
        } catch (SQLException e) {
            modelName = "error";
            e.printStackTrace();
        }
        return modelName;

    }
}
