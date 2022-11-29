package tea.entity.qcjs;

import java.sql.SQLException;
import java.util.Date;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Vector;

import tea.db.DbAdapter;
import tea.entity.Entity;

public class EnterpriseAward extends Entity
{
	private int eaid;
	private String name;//企业名称
	private String address;//企业地址
	private String natures;//企业性质 
	private String legal;//企业法人
	private String contact;//联系方式
	private String description;//企业描述
	private String remarks;//备 注
	private String community;//
	private Date times;//
	private int eatype;//表示第几届 默认0是第一届
	private boolean exists;
	
	public static EnterpriseAward find(int eaid) throws SQLException
	{
		return new EnterpriseAward(eaid);
	}
	
	public EnterpriseAward(int eaid) throws SQLException
	{
		this.eaid = eaid;
		load();
	}
	private void load() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT name,address,natures,legal,contact,description,remarks,times,community,eatype FROM EnterpriseAward   WHERE eaid=" + eaid);
			if(db.next())
			{
				name=db.getString(1);
				address=db.getString(2);
				natures=db.getString(3);
				legal=db.getString(4);
				contact=db.getString(5);
				description=db.getString(6);
				remarks=db.getString(7);
				times=db.getDate(8);
				community=db.getString(9);
				eatype=db.getInt(10);
				
				exists = true;
			} else 
			{
				exists = false;
			}
		} finally
		{
			db.close();
		}
	}
	
	
	
	public static void create(String name,String address,String natures,String legal,String contact,String description,String remarks,Date times,String community,int eatype) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("INSERT INTO EnterpriseAward(name,address,natures,legal,contact,description,remarks,times,community,eatype)VALUES" +
					"("+db.cite(name)+","+db.cite(address)+","+db.cite(natures)+","+db.cite(legal)+" ,"+db.cite(contact)+" ,"+db.cite(description)+" ,"+db.cite(remarks)+" ,"+db.cite(times)+" ," +
					" "+db.cite(community)+" ,"+eatype+"     )");
		
		} finally
		{
			db.close();
		}
	}
	
	
	public void set(String name,String address,String natures,String legal,String contact,String description,String remarks,int eatype) throws SQLException
	{
		StringBuilder sb = new StringBuilder();
		sb.append("UPDATE EnterpriseAward SET");
		sb.append(" name=").append(DbAdapter.cite(name));
		sb.append(",address=").append(DbAdapter.cite(address));
		sb.append(",natures=").append(DbAdapter.cite(natures));
		sb.append(",legal=").append(DbAdapter.cite(legal));
		sb.append(",contact=").append(DbAdapter.cite(contact));
		sb.append(",description=").append(DbAdapter.cite(description));
		sb.append(",remarks=").append(DbAdapter.cite(remarks));
		sb.append(",eatype=").append(eatype);
	
	
		sb.append(" WHERE eaid=").append(eaid);
		DbAdapter db = new DbAdapter();
		try
		{
			 db.executeUpdate(sb.toString());
		} finally
		{
			db.close();
		}
	}
	
	public void delete()throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate(" DELETE FROM EnterpriseAward   WHERE eaid=" + eaid);
		} finally
		{
			db.close();
		}
	}
	
    public static Enumeration find(String community,String sql,int pos,int size)
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT eaid FROM EnterpriseAward WHERE community= " + db.cite(community) + sql,pos,size);
            while(db.next())
            {
                vector.add(new Integer(db.getInt(1)));
            }
        } catch(Exception exception3)
        {
            System.out.print(exception3);
        } finally
        {
            db.close();
        }
        return vector.elements();
    }
	
    public static int count(String community,String sql) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(eaid) FROM EnterpriseAward  WHERE community=" + db.cite(community) + sql);
            if(db.next())
            {
                count = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return count;
    }

	public String getName()
	{
		return name;
	}

	public String getAddress()
	{
		return address;
	}

	public String getNatures()
	{
		return natures;
	}

	public String getLegal()
	{
		return legal;
	}

	public String getContact()
	{
		return contact;
	}

	public String getDescription()
	{
		return description;
	}

	public String getRemarks()
	{
		return remarks;
	}

	public String getCommunity()
	{
		return community;
	}

	public Date getTimes()
	{
		return times;
	}

	public boolean isExists()
	{
		return exists;
	}
	public int getEatype()
	{
		return eatype;
	}
    
    
	
}
