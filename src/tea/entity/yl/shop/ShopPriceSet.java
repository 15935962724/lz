package tea.entity.yl.shop;

import java.sql.SQLException;
import java.util.ArrayList;
import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Seq;
import tea.entity.member.Profile;
import util.Config;

//商品价格
public class ShopPriceSet
{
    protected static Cache c = new Cache(50);
    public int id;
    public float price;    		//医院价格、服务商显示价格
    public float agentPrice;	//服务商代理医院价格
    public int hospital_id; 	//医院id  1：代理商，大于1医院
    public int product_id;  	//商品id
    public int memberType;  	//会员类型111

    
    public float agentPriceNew;	//服务商代理医院价格
    public static String [] gkPriceField = {"","hospitalname","price","agentPrice"};
    
    public ShopPriceSet()
    {
    }
    
    public ShopPriceSet(int id)
    {
        this.id = id;
    }

    public static ShopPriceSet find(int id) throws SQLException
    {
        ShopPriceSet t = (ShopPriceSet) c.get(id);
        if (t == null)
        {
            ArrayList al = find(" AND id=" + id, 0, 1);
            t = al.size() < 1 ? new ShopPriceSet(id) : (ShopPriceSet) al.get(0);
        }
        return t;
    }
    
    public static ShopPriceSet find(int hospital_id,int product_id,int memberType) throws SQLException
    {
        ArrayList al = find(" AND hospital_id="+hospital_id + " AND product_id="+product_id +" AND memberType="+memberType, 0, 1);
        ShopPriceSet t = al.size() < 1 ? new ShopPriceSet() : (ShopPriceSet) al.get(0);        
        return t;
    }

    public static ArrayList find(String sql, int pos, int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT sp.id,sp.price,sp.hospital_id,sp.product_id,sp.memberType,sp.agentPrice,sp.agentPriceNew FROM shopPriceSet sp "+tab(sql)+" WHERE 1=1" + sql, pos, size);
            while (rs.next())
            {
                int i = 1;
                ShopPriceSet t = new ShopPriceSet(rs.getInt(i++));
                t.price = rs.getFloat(i++);
                t.hospital_id = rs.getInt(i++);
                t.product_id = rs.getInt(i++);
                t.memberType = rs.getInt(i++);
                t.agentPrice = rs.getFloat(i++);
                t.agentPriceNew = rs.getFloat(i++);
                c.put(t.id, t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM shopPriceSet sp "+tab(sql)+" WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        String sql;
        if (id < 1)
            sql = "INSERT INTO shopPriceSet(id,price,hospital_id,product_id,memberType,agentPrice,agentPriceNew)VALUES(" + (id = Seq.get()) + ","+price + ","+hospital_id +","+product_id + ","+memberType+ ","+agentPrice + ","+agentPriceNew+")";
        else
            sql = "UPDATE shopPriceSet SET price=" + price + ",hospital_id=" + hospital_id + ",product_id=" + product_id + ",memberType=" + memberType+ ",agentPrice=" + agentPrice + ",agentPriceNew="+agentPriceNew+" WHERE id=" + id;
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
            db.executeUpdate(id, "DELETE FROM shopPriceSet WHERE id=" + id);
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
            db.executeUpdate(id, "UPDATE shopPriceSet SET " + f + "=" + DbAdapter.cite(v) + " WHERE id=" + id);
        } finally
        {
            db.close();
        }
        c.remove(id);
    }
    
    static String tab(String sql)
    {
        StringBuilder sb = new StringBuilder();
        if(sql.contains(" AND sh."))
            sb.append(" INNER JOIN ShopHospital sh ON sh.id=sp.hospital_id ");
        return sb.toString();
    }

    public static float findpirce(ShopProduct p,int hosid,int member) {
    	float price = 0;
			//ProcurementUnitJoin puj = ProcurementUnitJoin.find(p.puid, member);
            ProcurementUnitJoin puj = ProcurementUnitJoin.find(p.puid, member,hosid);
			price = puj.agentPriceNew;
    	return price;
    }

    
}
