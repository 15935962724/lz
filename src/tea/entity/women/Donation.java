package tea.entity.women;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

public class Donation
{
    protected static Cache c = new Cache(50);
    public int donation; //捐赠信息
    public String invoice; //发票编号
    public Date dtime; //捐赠时间
    public String donors; //捐赠者
    public float money; //捐赠金额
    public String address; //地址
    public String zip; //邮编
    public String tel; //电话
    public String location; //指定地点
    public String named; //指定冠名
    public String remark; //备注
    public String province; //落实省(区)
    public String city; //市(县)
    public String town; //乡(镇)
    public String village; //村
    public String photoid; //落实照片编号
    public String photo; //落实照片
    public String omember; //操作人
    public Date otime; //操作时间
    public Date time; //创建时间

    public Donation(int donation)
    {
        this.donation = donation;
    }

    public static Donation find(int donation) throws SQLException
    {
        Donation t = (Donation) c.get(donation);
        if(t == null)
        {
            ArrayList al = find(" AND donation=" + donation,0,1);
            t = al.size() < 1 ? new Donation(donation) : (Donation) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT donation,invoice,dtime,donors,money,address,zip,tel,location,named,remark,province,city,town,village,photoid,photo,omember,otime,time FROM Donation WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                Donation t = new Donation(rs.getInt(i++));
                t.invoice = rs.getString(i++);
                t.dtime = db.getDate(i++);
                t.donors = rs.getString(i++);
                t.money = rs.getFloat(i++);
                t.address = rs.getString(i++);
                t.zip = rs.getString(i++);
                t.tel = rs.getString(i++);
                t.location = rs.getString(i++);
                t.named = rs.getString(i++);
                t.remark = rs.getString(i++);
                t.province = rs.getString(i++);
                t.city = rs.getString(i++);
                t.town = rs.getString(i++);
                t.village = rs.getString(i++);
                t.photoid = rs.getString(i++);
                t.photo = rs.getString(i++);
                t.omember = rs.getString(i++);
                t.otime = db.getDate(i++);
                t.time = db.getDate(i++);
                c.put(t.donation,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM Donation WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            if(donation < 1)
            {
                db.executeUpdate("INSERT INTO Donation(invoice,dtime,donors,money,address,zip,tel,location,named,remark,province,city,town,village,photoid,photo,omember,otime,time)VALUES(" + DbAdapter.cite(invoice) + "," + DbAdapter.cite(dtime) + "," + DbAdapter.cite(donors) + "," + money + "," + DbAdapter.cite(address) + "," + DbAdapter.cite(zip) + "," + DbAdapter.cite(tel) + "," + DbAdapter.cite(location) + "," + DbAdapter.cite(named) + "," + DbAdapter.cite(remark) + "," + DbAdapter.cite(province) + "," + DbAdapter.cite(city) + "," + DbAdapter.cite(town) + "," + DbAdapter.cite(village) + "," + DbAdapter.cite(photoid) + "," + DbAdapter.cite(photo) + "," + DbAdapter.cite(omember) + "," + DbAdapter.cite(otime) + "," + DbAdapter.cite(time) + ")");
                db.executeQuery("SELECT MAX(donation) FROM Donation WHERE invoice=" + DbAdapter.cite(invoice));
                donation = db.next() ? db.getInt(1) : 0;
            } else
                db.executeUpdate("UPDATE Donation SET invoice=" + DbAdapter.cite(invoice) + ",dtime=" + DbAdapter.cite(dtime) + ",donors=" + DbAdapter.cite(donors) + ",money=" + money + ",address=" + DbAdapter.cite(address) + ",zip=" + DbAdapter.cite(zip) + ",tel=" + DbAdapter.cite(tel) + ",location=" + DbAdapter.cite(location) + ",named=" + DbAdapter.cite(named) + ",remark=" + DbAdapter.cite(remark) + ",province=" + DbAdapter.cite(province) + ",city=" + DbAdapter.cite(city) + ",town=" + DbAdapter.cite(town) + ",village=" + DbAdapter.cite(village) + ",photoid=" + DbAdapter.cite(photoid) + ",photo=" + DbAdapter.cite(photo) + ",omember=" + DbAdapter.cite(omember) + ",otime=" + DbAdapter.cite(otime) + ",time=" + DbAdapter.cite(time) + " WHERE donation=" + donation);
        } finally
        {
            db.close();
        }
        c.remove(donation);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM Donation WHERE donation=" + donation);
        c.remove(donation);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE Donation SET " + f + "=" + DbAdapter.cite(v) + " WHERE donation=" + donation);
        c.remove(donation);
    }

    //
    public static Donation find(String invoice) throws SQLException
    {
        ArrayList al = find(" AND invoice=" + Database.cite(invoice),0,1);
        return al.size() < 1 ? new Donation(0) : (Donation) al.get(0);
    }


}
