package tea.entity.yl.shop;

import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Database;
import tea.entity.Seq;
import util.Config;


public class ShopOrderExpress
{
    protected static Cache c = new Cache(50);
    public int id;
    public String order_id; //订单编号
    public String express_code;   //快递编号
    public String  person;       //发件人
    public Date time;//发件时间
    public String mobile;   //联系方式
    public BigDecimal price;   //价格
    public String express_name; //快递名称
    public int type; //产品类型
    /**销售编号*/
    public String NO1; 
    /**生产批号*/
    public String NO2; 
    public Date vtime;//有效期
    public String images;//检验报告图片
    public String refusereason;//拒绝原因
    public String fuhereason;//复核拒绝原因
    
    public String express_img;//快递图片
    
    
    
    
    public ShopOrderExpress(int id)
    {
        this.id = id;
    }

    public static ShopOrderExpress find(int id) throws SQLException
    {
        ShopOrderExpress t = (ShopOrderExpress) c.get(id);
        if (t == null)
        {
            ArrayList al = find(" AND id=" + id, 0, 1);
            t = al.size() < 1 ? new ShopOrderExpress(id) : (ShopOrderExpress) al.get(0);
        }
        return t;
    }
    
    public static ShopOrderExpress findByOrderId(String order_id) throws SQLException{
		ArrayList list = find(" AND order_id = " + DbAdapter.cite(order_id), 0, 1);
		ShopOrderExpress soe = list.size() < 1 ? new ShopOrderExpress(0):(ShopOrderExpress)list.get(0);
		return soe;
	}

    public static ArrayList find(String sql, int pos, int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id,order_id,express_code,person,time,mobile,price,express_name,type,NO1,NO2,vtime,images,refusereason,fuhereason,express_img FROM ShopOrderExpress WHERE 1=1" + sql, pos, size);
            while (db.next())
            {
                int i = 1;
                ShopOrderExpress t = new ShopOrderExpress(db.getInt(i++));
                t.order_id = db.getString(i++);
                t.express_code = db.getString(i++);
                t.person = db.getString(i++);
                t.time = db.getDate(i++);
                t.mobile = db.getString(i++);
                t.price = db.getBigDecimal(i++, 2);
                t.express_name = db.getString(i++);
                t.type = db.getInt(i++);
                t.NO1 = db.getString(i++);
                t.NO2 = db.getString(i++);
                t.vtime = db.getDate(i++);
                t.images = db.getString(i++);
                t.refusereason = db.getString(i++);
                t.fuhereason = db.getString(i++);
                t.express_img = db.getString(i++);
                c.put(t.id, t);
                al.add(t); 
            }
            db.close();
        } finally
        {
        }
        return al;
    }

    public static int count(String sql) throws SQLException
    {
        return DbAdapter.execute("SELECT COUNT(*) FROM ShopOrderExpress WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        String sql;
        if (id < 1)
            sql = "INSERT INTO ShopOrderExpress(id,order_id,express_code,person,time,mobile,price,express_name,type,NO1,NO2,vtime,images,refusereason,fuhereason,express_img)VALUES(" + (id = Seq.get()) + ","+DbAdapter.cite(order_id) + ","+DbAdapter.cite(express_code)+ ","+DbAdapter.cite(person) +","+DbAdapter.cite(time) +","+DbAdapter.cite(mobile) +","+price+","+DbAdapter.cite(express_name)+","+type+","+DbAdapter.cite(NO1)+","+DbAdapter.cite(NO2)+","+DbAdapter.cite(vtime) + "," +DbAdapter.cite(images)+ ","+DbAdapter.cite(refusereason) + ","+DbAdapter.cite(fuhereason)+ ","+Database.cite(express_img)+")";
        else
            sql = "UPDATE ShopOrderExpress SET order_id="+DbAdapter.cite(order_id) + ",express_code="+DbAdapter.cite(express_code)+ ",person="+DbAdapter.cite(person) + ",time="+DbAdapter.cite(time) + ",mobile="+DbAdapter.cite(mobile) + ",price="+price+ ",express_name="+DbAdapter.cite(express_name)+ ",type="+type+ ",NO1="+DbAdapter.cite(NO1)+ ",NO2="+DbAdapter.cite(NO2)+ ",vtime="+DbAdapter.cite(vtime) +",images=" + DbAdapter.cite(images)+",refusereason="+DbAdapter.cite(refusereason) +",fuhereason="+DbAdapter.cite(fuhereason)+ ",express_img="+Database.cite(express_img)+" WHERE id=" + id;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(id, sql);
        } finally
        {
            db.close();
        }
        c.remove(id);
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(id, "DELETE FROM ShopOrderExpress WHERE id=" + id);
        } finally
        {
            db.close();
        }
        c.remove(id);
    }

    public void set(String f, String v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(id, "UPDATE ShopOrderExpress SET " + f + "=" + DbAdapter.cite(v) + " WHERE id=" + id);
        } finally
        {
            db.close();
        }
        c.remove(id);
    }

    
}
