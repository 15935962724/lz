package tea.entity.admin;

import java.io.*;
import java.util.Date;
import tea.db.DbAdapter;
import java.sql.SQLException;
import tea.entity.*;
import java.util.Vector;
import java.util.Enumeration;

public class DayOrder extends Entity
{
    private int id;
    private int begintime;
    private int begintime1;
    private int endtime;
    private int endtime1;
    private int affairtype;
    private String affaircontent;
    private Date subtime;
    private Date time;
    private String member;
    private String community;

    private boolean exists;

    private static Cache _cache = new Cache(100);

    public DayOrder(int id) throws SQLException
    {
        this.id = id;
        load();

    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT begintime,begintime1,endtime,endtime1,affairtype,affaircontent,subtime,time,member,community from DayOrder where id = " + id + " ORDER BY subtime");
            if(db.next())
            {
                begintime = db.getInt(1);
                begintime1 = db.getInt(2);
                endtime = db.getInt(3);
                endtime1 = db.getInt(4);
                affairtype = db.getInt(5);
                affaircontent = db.getVarchar(1,1,6);
                subtime = db.getDate(7);
                time = db.getDate(8);
                member = db.getVarchar(1,1,9);
                community=db.getString(10);
                this.exists = true;
            } else
            {
                this.exists = false;
            }
        } finally
        {
            db.close();
        }
    }

    public static DayOrder find(int id) throws SQLException
    {
        /*
         * Bulletin obj = (Bulletin) _cache.get(new Integer(bull_id)); if (obj == null) { obj = new Bulletin(bull_id); _cache.put(new Integer(bull_id), obj); }
         */
        return new DayOrder(id);
    }

    public static int create(int begintime,int begintime1,int endtime,int endtime1,int affairtype,String affaircontent,Date time,String community,RV _rv,int dept,int distin) throws SQLException
    {
        int bull_id = 0;
        Date d = new Date();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO DayOrder (begintime,begintime1,endtime,endtime1,affairtype,affaircontent,time,subtime,community,member,dept,distin)values (" + begintime + "," + begintime1 + "," + endtime + "," + endtime1 + "," + affairtype + "," + DbAdapter.cite(affaircontent) + "," + DbAdapter.cite(time) + "," + DbAdapter.cite(d) + "," + DbAdapter.cite(community) + ",'" + _rv + "'," + dept + "," + distin + ")");
            bull_id = db.getInt("SELECT MAX(id) FROM DayOrder");
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(bull_id));
        return bull_id;
    }

    public void set(int begintime,int begintime1,int endtime,int endtime1,int affairtype,String affaircontent,Date time,String community,RV _rv,int dept,int distin) throws SQLException
    {

        Date d = new Date();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id FROM DayOrder WHERE id =" + id);

            if(db.next())
            {
                db.executeUpdate("UPDATE DayOrder SET begintime =" + begintime + " , begintime1=" + begintime1 + ",endtime=" + endtime + ",endtime1=" + endtime1 + ",affairtype= " + affairtype + ",subtime = " + DbAdapter.cite(d) + " ,affaircontent=" + DbAdapter.cite(affaircontent) + ",community=" + DbAdapter.cite(community) + ",member='" + _rv + "',time =" + DbAdapter.cite(time) + ",dept=" + dept + ",distin=" + distin + " WHERE id =" + id);

            } else
            {
                db.executeUpdate("insert into DayOrder (begintime,begintime1,endtime,endtime1,affairtype,affaircontent,time,subtime,community,member,dept,distin)values (" + begintime + "," + begintime1 + "," + endtime + "," + endtime1 + "," + affairtype + "," + DbAdapter.cite(affaircontent) + "," + DbAdapter.cite(time) + "," + DbAdapter.cite(d) + "," + DbAdapter.cite(community) + ",'" + _rv + "'," + dept + "," + distin + ")");

            }
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(id));

    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM DayOrder WHERE id=" + id);
        } finally
        {
            db.close();
        }
    }

    public static java.util.Enumeration findByCommunity(String community,String sql) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter db = new DbAdapter();
        try
        {
//            db.executeQuery("SELECT l.id FROM DayOrder l INNER JOIN AdminUsrRole aur ON l.community=" + DbAdapter.cite(community) + " AND aur.community=" + DbAdapter.cite(community) + " AND l.member=aur.member WHERE 1=1" + sql);
			db.executeQuery("SELECT id FROM DayOrder WHERE community="+DbAdapter.cite(community) + sql);//  where +")

			while(db.next())
            {
                vector.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }
	public static java.util.Enumeration findByCommunityold(String community,String sql) throws SQLException
	   {
		   java.util.Vector vector = new java.util.Vector();
		   DbAdapter db = new DbAdapter();
		   try
		   {
//			   String Sql = "SELECT l.id FROM DayOrder l INNER JOIN AdminUsrRole aur ON l.community=" + DbAdapter.cite(community) + " AND aur.community=" + DbAdapter.cite(community) + " AND l.member=aur.member WHERE 1=1" + sql;
//			   System.out.println(Sql);
			   db.executeQuery("SELECT l.id FROM DayOrder l INNER JOIN AdminUsrRole aur ON l.community=" + DbAdapter.cite(community) + " AND aur.community=" + DbAdapter.cite(community) + " AND (select profile from profile where member = l.member)=aur.member WHERE 1=1" + sql);

			   while(db.next())
			   {
				   vector.addElement(new Integer(db.getInt(1)));
			   }
		   } finally
		   {
			   db.close();
		   }
		   return vector.elements();
	   }

    public static Enumeration findByCommunity(String community,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id FROM DayOrder WHERE  "+db.cite(community) + sql,pos,size);
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
            db.executeQuery("SELECT count(id) FROM DayOrder WHERE  "+db.cite(community)  + sql);
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
    //根据日期获取 id
    public static int getId(String community,Date times)throws SQLException
    {
    	int d = 0;
    	 DbAdapter db = new DbAdapter();
    	 try
    	 {
    		 db.executeQuery("SELECT id FROM DayOrder WHERE community="+db.cite(community)+" and time = "+DbAdapter.cite(times));
    		 if(db.next())
    		 {
    			 d = db.getInt(1);
    		 }
    	 }finally
    	 {
    		 db.close();
    	 }
    	return d;
    }
    public void set(String affaircontent)throws SQLException
    {
    	DbAdapter db = new DbAdapter();
   	 try
   	 {
   		 db.executeUpdate("UPDATE DayOrder SET affaircontent="+db.cite(affaircontent)+" WHERE id=  "+id);
   		 
   	 }finally
   	 { 
   		 db.close();
   	 }
    }
    public static void create(String affaircontent,Date times,String community,String member)throws SQLException
    {
    	DbAdapter db = new DbAdapter();
	   	 try  
	   	 {
	   		 db.executeUpdate("INSERT INTO DayOrder (affaircontent,time,community,member)VALUES("+db.cite(affaircontent)+","+db.cite(times)+","+db.cite(community)+","+db.cite(member)+"  )");
	   		  
	   	 }finally
	   	 {
	   		 db.close();
	   	 }
    }

    public int getBegintime()
    {
        return begintime;
    }

    public int getBegintime1()
    {
        return begintime1;
    }

    public int getEndtime()
    {
        return endtime;
    }

    public int getEndtime1()
    {
        return endtime1;
    }

    public int getAffairtype()
    {
        return affairtype;
    }

    public String getAffaircontent()
    {
        return affaircontent;
    }

    public Date getSubtime()
    {
        return subtime;
    }

    public String getSubtimeToString()
    {
        if(subtime != null)
        {
            return DayOrder.sdf.format(subtime);
        } else
        {
            return "";
        }

    }

    public Date getTime()
    {
        return time;
    }

    public String getTimeToString()
    {
        if(time != null)
        {
            return DayOrder.sdf.format(time);
        } else
        {
            return "";
        }

    }


    public String getMember()
    {
        return member;
    }

}
