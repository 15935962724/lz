package tea.entity.yl.shop;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Database;
import tea.entity.Seq;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 君安库存占用
 */
public class ShopBatchesData
{
    public int id;//
    public String orderId; //
    public int psid;
    public int number;
    public Date time;//

    public int occupyNumber;//已经分批数量

    public ShopBatchesData(int id)
    {
        this.id = id;
    }

    public static ShopBatchesData find(int id) throws SQLException
    {
        ShopBatchesData t = null;
        if (t == null)
        {
            ArrayList al = find(" AND id=" + id, 0, 1);
            t = al.size() < 1 ? new ShopBatchesData(id) : (ShopBatchesData) al.get(0);
        }
        return t;
    }

    public static ShopBatchesData find(String orderId,int psid) throws SQLException
    {
        ShopBatchesData t = null;
        if (t == null)
        {
            ArrayList al = find(" AND orderId=" + Database.cite(orderId)+" AND psid = "+psid, 0, 1);
            t = al.size() < 1 ? new ShopBatchesData(0) : (ShopBatchesData) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql, int pos, int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT sbd.id,sbd.orderId,sbd.psid,sbd.number,sbd.time,sbd.occupyNumber FROM ShopBatchesData sbd "+tab(sql)+" WHERE 1=1" + sql, pos, size);
            while (rs.next())
            {
                int i = 1;
                ShopBatchesData t = new ShopBatchesData(rs.getInt(i++));
                t.orderId = db.getString(i++);
                t.psid = db.getInt(i++);
                t.number = db.getInt(i++);
                t.time = db.getDate(i++);
                t.occupyNumber = db.getInt(i++);
                al.add(t);
            }
            rs.close();
        } finally
        {
            db.close();
        }
        return al;
    }

    private static String tab(String sql)
    {
        StringBuilder sb = new StringBuilder();
        if(sql.contains(" AND ps."))
            sb.append(" INNER JOIN ProductStock ps ON ps.psid=sbd.psid");
        return sb.toString();
    }

    public static int count(String sql) throws SQLException
    {
        return DbAdapter.execute("SELECT COUNT(*) FROM ShopBatchesData sbd "+tab(sql)+" WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        String sql;
        if (id < 1){
            id = Seq.get();
            sql = "INSERT INTO ShopBatchesData(id,orderId,psid,number,time,occupyNumber)VALUES("+id+","+ Database.cite(orderId) +","+psid+","+number+","+Database.cite(time)+","+occupyNumber+")";
        }
        else {
            sql = "UPDATE ShopBatchesData SET orderId="+Database.cite(orderId)+",psid="+psid+",number="+number+",time="+Database.cite(time)+",occupyNumber="+occupyNumber+" WHERE id=" + id;
        }
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(id, sql);
        } finally
        {
            db.close();
        }
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(id, "DELETE FROM ShopBatchesData WHERE id=" + id);
        } finally
        {
            db.close();
        }
    }



    public void set(String f, String v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(id, "UPDATE ShopBatchesData SET " + f + "=" + DbAdapter.cite(v) + " WHERE id=" + id);
        } finally
        {
            db.close();
        }
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public int getPsid() {
        return psid;
    }

    public void setPsid(int psid) {
        this.psid = psid;
    }

    public int getNumber() {
        return number;
    }

    public void setNumber(int number) {
        this.number = number;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public int getOccupyNumber() {
        return occupyNumber;
    }

    public void setOccupyNumber(int occupyNumber) {
        this.occupyNumber = occupyNumber;
    }
}
