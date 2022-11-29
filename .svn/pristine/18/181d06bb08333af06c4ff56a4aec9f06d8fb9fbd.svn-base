package tea.entity.admin.erp.semi;

import java.math.*;
import java.util.Date;
import tea.entity.*;

import java.sql.*;
import java.util.Vector;
import java.util.Enumeration;
import tea.db.DbAdapter;
//供货商表
public class SemiSupplier extends Entity
{

    private int id; //id,sgid,sid,supply,measure,spec,community,member,addtime,num,info
    private int sgid; //半成品ID
    private int sid; //供货商id
    private BigDecimal supply; //商品进货价 supply ---BuyPrice
    private String measure; //商品单位 measure ---Goods
    private String spec; //商品规格 spec ---Goods
    private String community; //社区
    private String member; //人员
    private Date addtime; //添加时间
    private int num; //最小进货数量
    private String info; //备注
    private boolean exists;

    public static SemiSupplier find(int id) throws SQLException
    {
        return new SemiSupplier(id);
    }

    public SemiSupplier(int id) throws SQLException
    {
        this.id = id;
        load();
    }


    public void load() throws SQLException
    {
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("Select sgid,sid,supply,measure,spec,community,member,addtime,num,info from SemiSupplier where id="+id);
			if(db.next())
			{
                int j = 1;
                sgid = db.getInt(j++);
                sid = db.getInt(j++);
                supply = db.getBigDecimal(j++,2);
                measure = db.getString(j++);
                spec = db.getString(j++);
                community = db.getString(j++);
                member = db.getString(j++);
                addtime = db.getDate(j++);
                num = db.getInt(j++);
                info = db.getString(j++);
				exists = true;
			}
			else
			{
				exists = false;
			}
		}
		finally
		{
			db.close();
		}
    }

    public static void set(int id,int sgid,int sid,BigDecimal supply,String measure,String spec,String community,String member,Date addtime,int num,String info) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("Select id from SemiSupplier where id="+id);
			if(db.next())
			{
				db.executeUpdate("Update SemiSupplier set sgid="+sgid+",sid="+sid+",supply="+supply+",measure="+db.cite(measure)+",spec="+db.cite(spec)+",community="+db.cite(community)+",member="+db.cite(member)+",addtime="+db.cite(addtime)+",num="+num+",info="+db.cite(info)+" where id="+id);
			}else
            {
				db.executeUpdate("Insert into SemiSupplier(sgid,sid,supply,measure,spec,community,member,addtime,num,info)values("+sgid+","+sid+","+supply+","+db.cite(measure)+","+db.cite(spec)+","+db.cite(community)+","+db.cite(member)+","+db.cite(addtime)+","+num+","+db.cite(info)+")");
            }
        }
		finally
		{
			db.close();
		}
    }

    public static Enumeration findByCommunity(String community,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id FROM SemiSupplier WHERE community=" + db.cite(community) + sql,pos,size);
            while(db.next())
            {
                v.addElement(db.getInt(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static int count(String community,String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int num = 0;
        try
        {
            db.executeQuery("Select count(id) from SemiSupplier where community=" + db.cite(community) + " " + sql);
            if(db.next())
            {

                num = db.getInt(1);
                return num;
            } else
            {
                return num;
            }
        } finally
        {
            db.close();
        }
    }

    public static void delete(int id) throws SQLException
    {
        DbAdapter db = new DbAdapter();

        try
        {
            db.executeUpdate("Delete  SemiSupplier where id= " + id);

        } finally
        {
            db.close();
        }
    }

    //判断半成品是否与这个供应商关联过。
    public static int auditSeim(int sgid,int sid,String community) throws SQLException
    {
        DbAdapter db = new DbAdapter();
		int count=0;
        try
        {
            db.executeQuery("select count(id)  from  SemiSupplier where sgid= " + sgid+" and sid="+sid+" and community="+db.cite(community));
			if(db.next())
			{
				count=db.getInt(1);
			}
        } finally
        {
            db.close();
        }
		return count;
    }
	public static int auditSeim2(int sgid,int id,int sid,String community) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		int count=0;
		try
		{
			db.executeQuery("select count(id)  from  SemiSupplier where sgid= " + sgid+" and sid="+sid+" and community="+db.cite(community)+" or id="+id);
			if(db.next())
			{
				count=db.getInt(1);
			}
		} finally
		{
			db.close();
		}
		return count;
	}

    public Date getAddtime()
    {
        return addtime;
    }

    public String getCommunity()
    {
        return community;
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getId()
    {
        return id;
    }

    public String getInfo()
    {
        return info;
    }

    public String getMeasure()
    {
        return measure;
    }

    public String getMember()
    {
        return member;
    }

    public int getNum()
    {
        return num;
    }

    public int getSgid()
    {
        return sgid;
    }

    public int getSid()
    {
        return sid;
    }

    public String getSpec()
    {
        return spec;
    }

    public BigDecimal getSupply()
    {
        return supply;
    }
}
