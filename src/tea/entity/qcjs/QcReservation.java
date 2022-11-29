package tea.entity.qcjs;


import java.sql.SQLException;
import java.util.Date;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Vector;

import tea.db.DbAdapter;
import tea.entity.Entity;
import tea.entity.photography.Photography;

public class QcReservation extends Entity
{
	private int rid;
	private int mid;//会员表id
	private String name;//姓名
	private String card;//身份证
	private String telephone;//电话
	private int activity;//参加活动
	private int  manner;//接车方式
	private String mannerlocation;//接车地点
	private int forms;//活动形式
	private int forms3;//
	
	private String notes;//备注
	private String community;//
	private Date times;//
	private boolean exists;
	
	public static final String ACTIVITY_TYPE[] = {"丰宁坝上草原革命避暑战役"};
	public static final String FORMS_TYPE[] = {"手动挡","自动挡","自驾车"};
	
	 
	public static QcReservation find(int rid) throws SQLException
	{
		return new QcReservation(rid);
	}
	
	public QcReservation(int rid) throws SQLException
	{
		this.rid = rid;
		load();
	}
	private void load() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT name,telephone ,card,activity,manner,mannerlocation ,forms,notes,times,community,mid,forms3 FROM QcReservation   WHERE rid=" + rid);
			if(db.next())
			{
				name=db.getString(1);
				telephone=db.getString(2);
				card=db.getString(3);
				activity=db.getInt(4);
				manner=db.getInt(5);
				mannerlocation=db.getString(6);
				forms = db.getInt(7);
				notes = db.getString(8);
				times=db.getDate(9);
				community=db.getString(10);
				mid=db.getInt(11);
				forms3=db.getInt(12);
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
	
	public static void create(String name,String telephone ,String card,int activity,int manner,String mannerlocation ,int forms,String notes,Date times,String community,int mid,int forms3) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("INSERT INTO QcReservation(name,telephone ,card,activity,manner,mannerlocation ,forms,notes,times,community,mid,forms3 )VALUES" +
					"("+db.cite(name)+","+db.cite(telephone)+","+db.cite(card)+" ,"+activity+" ,"+manner+" ,"+db.cite(mannerlocation)+" ,"+forms+" ," +
					" "+db.cite(notes)+" ,"+db.cite(times)+" ,"+db.cite(community)+"  ,"+mid+" ,"+forms3+"    )");
		
		} finally
		{
			db.close();
		}
	}
	
	
	public void set(String name,String telephone ,String card,int activity,int manner,String mannerlocation ,int forms,String notes,int mid,int forms3) throws SQLException
	{
		StringBuilder sb = new StringBuilder();
		sb.append("UPDATE QcReservation SET");
		sb.append(" name=").append(DbAdapter.cite(name));
		sb.append(",telephone=").append(DbAdapter.cite(telephone));
		sb.append(",card=").append(DbAdapter.cite(card));
		
		sb.append(",activity=").append(activity);
		sb.append(",manner=").append(manner);

		sb.append(",mannerlocation=").append(DbAdapter.cite(mannerlocation));
		sb.append(",forms=").append(forms);
		sb.append(",notes=").append(DbAdapter.cite(notes));
		sb.append(",mid=").append(mid);
		sb.append(",forms3=").append(forms3);

	
	
		sb.append(" WHERE rid=").append(rid);
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
			db.executeUpdate(" DELETE FROM QcReservation   WHERE rid=" + rid);
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
            db.executeQuery("SELECT rid FROM QcReservation WHERE community= " + db.cite(community) + sql,pos,size);
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
            db.executeQuery("SELECT COUNT(rid) FROM QcReservation  WHERE community=" + db.cite(community) + sql);
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

	public int getMid()
	{
		return mid;
	}

	public String getName()
	{
		return name;
	}

	public String getCard()
	{
		return card;
	}

	public String getTelephone()
	{
		return telephone;
	}

	public int getActivity()
	{
		return activity;
	}

	public int getManner()
	{
		return manner;
	}

	public String getMannerlocation()
	{
		return mannerlocation;
	}

	public int getForms()
	{
		return forms;
	}

	public String getNotes()
	{
		return notes;
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
    public int getForms3()
    {
    	return forms3;
    }

    
}
