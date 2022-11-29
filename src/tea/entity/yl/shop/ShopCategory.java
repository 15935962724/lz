package tea.entity.yl.shop;

import java.util.*;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.sql.SQLException;
import tea.db.DbAdapter;
import tea.entity.*;

public class ShopCategory extends Entity
{
    protected static Cache c = new Cache(500);
    public int category; //商品类型
    public int father; //父ID
    public String path = "|"; //路径
    public String[] name = new String[2]; //名称
    public int price; //价格
    public boolean pcolor; //颜色
    public boolean psize; //尺码
    public boolean hidden; //显示/隐藏
    public int sequence; //顺序
    public String brand = "|"; //品牌
    public Date time;
    public String sync;
    public boolean offswitch;  //购物开关 0开,1关(//true为关闭)
    public String attribute;     //属性
    
    public int pic;//图片 

    public ShopCategory(int category)
    {
        this.category = category;
    }

    public static ShopCategory find(int category) throws SQLException
    {
        ShopCategory t = (ShopCategory) c.get(category);
        if (t == null)
        {
            ArrayList al = find(" AND category=" + category, 0, 1);
            t = al.size() < 1 ? new ShopCategory(category) : (ShopCategory) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql, int pos, int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT category,father,path,name0,name1,price,pcolor,psize,hidden,sequence,brand,time,sync,offswitch,attribute,pic FROM shopcategory WHERE 1=1" + sql, pos, size);
            while (rs.next())
            {
                int i = 1;
                ShopCategory t = new ShopCategory(rs.getInt(i++));
                t.father = rs.getInt(i++);
                t.path = rs.getString(i++);
                t.name[0] = rs.getString(i++);
                t.name[1] = rs.getString(i++);
                t.price = rs.getInt(i++);
                t.pcolor = rs.getBoolean(i++);
                t.psize = rs.getBoolean(i++);
                t.hidden = rs.getBoolean(i++);
                t.sequence = rs.getInt(i++);
                t.brand = rs.getString(i++);
                t.time = db.getDate(i++);
                t.sync = rs.getString(i++);
                t.offswitch = rs.getBoolean(i++);
                t.attribute = rs.getString(i++);
                t.pic = rs.getInt(i++);
                c.put(t.category, t);
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
        return DbAdapter.execute("SELECT COUNT(*) from shopcategory WHERE 1=1" + sql);
    }

    public int set() throws SQLException
    {
        String sql;
        if (category < 1)
        {
            if (sequence < 1)
                sequence = category;
            sql = "INSERT INTO shopcategory(category,father,path,name0,name1,price,pcolor,psize,hidden,sequence,brand,time,sync,offswitch,attribute,pic)VALUES(" + (category = Seq.get()) + "," + father + "," + DbAdapter.cite(ShopCategory.find(father).path + category + "|") + "," + DbAdapter.cite(name[0]) + "," + DbAdapter.cite(name[1]) + "," + price + "," + DbAdapter.cite(pcolor) + "," + DbAdapter.cite(psize) + "," + DbAdapter.cite(hidden) + "," + sequence + "," + DbAdapter.cite(brand) + "," + DbAdapter.cite(time) + "," + DbAdapter.cite(sync) +","+DbAdapter.cite(offswitch) + ","+DbAdapter.cite(attribute) + ","+pic + ")";
        } else
            sql = "UPDATE shopcategory SET father=" + father + ",name0=" + DbAdapter.cite(name[0]) + ",name1=" + DbAdapter.cite(name[1]) + ",price=" + price + ",pcolor=" + DbAdapter.cite(pcolor) + ",psize=" + DbAdapter.cite(psize) + ",hidden=" + DbAdapter.cite(hidden) + ",sequence=" + sequence + ",brand=" + DbAdapter.cite(brand) +",offswitch="+DbAdapter.cite(offswitch) + ",attribute="+DbAdapter.cite(attribute) + ",pic="+pic + " WHERE category=" + category;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(category, sql);
        } finally
        {
            db.close();
        }
        c.remove(category);
        return category;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(category, "DELETE FROM shopcategory WHERE category=" + category);
        } finally
        {
            db.close();
        }
        c.remove(category);
    }

    public void set(String f, String v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(category, "UPDATE shopcategory SET " + f + "=" + DbAdapter.cite(v) + " WHERE category=" + category);
        } finally
        {
            db.close();
        }
        c.remove(category);
    }

    //
    public static ArrayList findByFather(int father) throws SQLException
    {
        return find(" AND father=" + father + " AND hidden=0 ORDER BY sequence", 0, 200);
    }

    public String getPath() throws SQLException
    {
        return (father > 0 ? find(father).getPath() + father + "|" : "|");
    }

    public String getAncestor(int lang) throws SQLException
    {
        return (father > 0 ? find(father).getAncestor(lang) : "<a href='/'>首页</a>") + " >> " + getAnchor(lang);
    }

    public String getName(int lang) throws SQLException
    {
        return (father > 0 ? find(father).getName(lang) : "") + " >> " + name[1];
    }

    public String getBrand() throws SQLException
    {
        StringBuilder sb = new StringBuilder("|");
        String[] ac = path.split("[|]");
        for (int i = 1; i < ac.length; i++)
        {
            ShopCategory c = ShopCategory.find(Integer.parseInt(ac[i]));
            String[] arr = c.brand.split("[|]");
            for (int j = 1; j < arr.length; j++)
                if (sb.indexOf("|" + arr[j] + "|") == -1){
                	ShopBrand spd = ShopBrand.find(Integer.parseInt(arr[j]));
                	if(spd.time!=null)
                		sb.append(arr[j]).append("|");
                }
        }
//        Iterator it = findByFather(category).iterator();
//        while(it.hasNext())
//        {
//            ShopCategory c = (ShopCategory) it.next();
//            String[] arr = c.brand.split("[|]");
//            for(int i = 1;i < arr.length;i++)
//                if(sb.indexOf("|" + arr[i] + "|") == -1)
//                    sb.append(arr[i]).append("|");
//        }
        return sb.toString();
    }
    
    public static void delBrands(int brand) throws SQLException
    {
    	DbAdapter db = new DbAdapter();
    	try
        {
            db.executeUpdate("update shopcategory set brand=replace(brand,'|"+brand+"|','|') where brand like '%|"+brand+"|%'");
        } finally
        {
            db.close();
        }
    }

    public int getPrice() throws SQLException
    {
        if (price > 0)
            return price;
        ArrayList<ShopCategory> al = find(" AND category IN(" + path.substring(1).replace('|', ',') + "0) AND price>0 ORDER BY path DESC", 0, 1);
        return al.size() > 0 ? al.get(0).price : 0;
    }

    public String getAnchor(int lang)
    {
        return "<a href='/category.jsp?category=" + category + "'>" + name[lang] + "</a>";
    }

    public static ShopCategory getRoot() throws SQLException
    {
        ArrayList al = find(" AND father=0", 0, 1);
        if (al.size() < 1)
        {
            ShopCategory c = new ShopCategory(0);
            c.name[0] = "Root";
            c.name[1] = "根";
            c.set();
            al.add(c);
        }
        return (ShopCategory) al.get(0);
    }
    
    public static String ShowCategoryList(){
    	StringBuffer sb = new StringBuffer();
    	sb.append("<ul>");
    	try {
			List<ShopCategory> sclist = find(" AND father = 1 order by sequence", 0, 100);
			for(int i=0;i<sclist.size();i++){
				ShopCategory sc = sclist.get(i);
				Attch a = Attch.find(sc.pic);
				sb.append("<li>");
				sb.append("<img src='"+a.path+"' class='scimg' />");
				sb.append("<span class='scspan' >"+sc.name[1]+"</span>");
				sb.append("</li>");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
    	sb.append("</ul>");
    	return sb.toString();
    }
    
    public static int getCategory(String key){
    	int val = 0;
    	try {
			Class cl = Class.forName("tea.entity.yl.shop.ShopCategory");
			String name = "/category.properties";
			URL u = cl.getResource(name);
			Properties p = new Properties();
            if(u != null)
            {
            	InputStream is = u.openStream();
                p.load(is);
                is.close();
            	String str = p.getProperty(key);
            	if(null!=str&&str.length()>0)
            		val = Integer.parseInt(str);
            }
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}catch (IOException e) {
			e.printStackTrace();
		}
    	return val;
    }
    
    public static void main(String[] args) {
		int v = ShopCategory.getCategory("lzCategory");
		System.out.println(v);
	}

}
