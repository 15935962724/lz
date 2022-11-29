package tea.entity.node.access;

import java.util.*;
import java.util.regex.*;

import tea.db.ConnectionPool;
import tea.db.DbAdapter;
import tea.entity.*;
import java.sql.SQLException;


public class NodeAccessReferer
{
    private String community;
    private int count;
    private int sum;
    private String referer;
    private String domain;
    private String keywords;
    public static final String SEARCH_TYPE[] =
            {"www.baidu.com","www.google.com","search.cn.yahoo.com","www.sogou.com","p.zhongsou.com","iask.com","www.soso.com","search.live.com"};
    private static final Pattern P_WD = Pattern.compile("[&|\\?]wd=([^&]+)[&|$]");
    private static final Pattern P_Q = Pattern.compile("[&|\\?]q=([^&]+)[&|$]");
    private static final Pattern P_P = Pattern.compile("[&|\\?]p=([^&]+)[&|$]");
    private static final Pattern P_QUERY = Pattern.compile("[&|\\?]query=([^&]+)[&|$]");
    private static final Pattern P_W = Pattern.compile("[&|\\?]w=([^&]+)[&|$]");
    private static final Pattern P_K = Pattern.compile("[&|\\?]k=([^&]+)[&|$]");

    public NodeAccessReferer(String commonity,String referer) throws SQLException
    {
        this.community = commonity;
        this.referer = referer;
        load();
    }

    public NodeAccessReferer(String referer,int count,int sum,String domain,String keywords)
    {
        this.referer = referer;
        this.count = count;
        this.sum = sum;
        this.domain = domain;
        this.keywords = keywords;
    }

    private void load() throws SQLException
    {
        Calendar c = Calendar.getInstance();
        c.setTimeInMillis(System.currentTimeMillis());
        c.set(11,0);
        c.set(12,0);
        c.set(13,0);
        c.set(14,0);
        DbAdapter db = new DbAdapter(8);
        try
        {
            db.executeQuery("SELECT count,sum,time FROM NodeAccessReferer WHERE community=" + DbAdapter.cite(community) + " AND referer=" + DbAdapter.cite(referer));
            if(db.next())
            {
                count = db.getInt(1);
                sum = db.getInt(2);
                if(c.getTimeInMillis() != db.getInt(3))
                {
                    count = 0;
                }
            }
        } finally
        {
            db.close();
        }
    }

    public static Hashtable findByKeywords(String community,String keywords) throws SQLException
    {
        Calendar c = Calendar.getInstance();
        c.setTimeInMillis(System.currentTimeMillis());
        c.set(11,0);
        c.set(12,0);
        c.set(13,0);
        c.set(14,0);
        // Vector v = new Vector();
        Hashtable ht = new Hashtable();
        DbAdapter db = new DbAdapter(8);
        try
        {
            db.executeQuery("SELECT referer,count,sum,domain,time FROM NodeAccessReferer WHERE community=" + DbAdapter.cite(community) + " AND keywords=" + DbAdapter.cite(keywords));
            while(db.next())
            {
                String referer = db.getString(1);
                int count = db.getInt(2);
                int sum = db.getInt(3);
                String domain = db.getString(4);
                Date time = db.getDate(5);
                if(c.getTimeInMillis() != time.getTime())
                {
                    count = 0;
                }
                ht.put(domain,new NodeAccessReferer(referer,count,sum,domain,keywords));
            }
        } finally
        {
            db.close();
        }
        return ht;
    }

    public int[] getSearchSum() throws SQLException
    {
        int search[] = new int[SEARCH_TYPE.length];
        DbAdapter db = new DbAdapter(8);
        try
        {
            for(int index = 0;index < SEARCH_TYPE.length;index++)
            {
                search[index] = db.getInt("SELECT COUNT(*) FROM NodeAccessReferer WHERE referer LIKE '%" + SEARCH_TYPE[index] + "%' AND community=" + DbAdapter.cite(community));
            }
        } finally
        {
            db.close();
        }
        return search;
    }

    public static void set(String community,String referer,String sn) throws SQLException
    {
        String domain = null,keywords = null;
        if(referer == null) // 直接输入网址
        {
            /*
             * String ua = request.getHeader("user-agent"); int index; if (ua != null && (index = ua.indexOf("http://")) != -1) { int end; if (ua.endsWith(")")) { end = ua.length() - 1; } else { end = ua.length(); } NodeAccessReferer.set(s1, ua.substring(index, end), 2); //搜索引擎的机器人 } else
             */
            referer = " ";
            domain = "";
        } else
        {
            if(!referer.startsWith("http"))
            {
                referer = "http://" + referer;
            }
            if(referer.startsWith("http://" + sn))
            {
                return;
            }
            if(referer.length() > 250)
            {
                referer = referer.substring(0,250);
            }
            int index = referer.indexOf("/",9);
            if(index == -1)
            {
                index = referer.length();
            }
            domain = referer.substring(7,index);
            try
            {
                if(domain.equals(SEARCH_TYPE[0])) // 百度
                {
                    Matcher m = P_WD.matcher(referer);
                    if(m.find())
                    {
                        keywords = m.group(1);
                        referer = "http://" + domain + "/s?wd=" + keywords;
                        keywords = java.net.URLDecoder.decode(keywords,"GBK");
                    }
                } else if(domain.equals(SEARCH_TYPE[1]) || domain.equals("www.google.cn")) // google
                {
                    Matcher m = P_Q.matcher(referer);
                    if(m.find())
                    {
                        keywords = m.group(1);
                        referer = "http://" + domain + "/search?q=" + keywords;
                        keywords = java.net.URLDecoder.decode(keywords,"UTF-8");
                    }
                } else if(domain.equals(SEARCH_TYPE[2])) // 雅虎
                {
                    Matcher m = P_P.matcher(referer);
                    if(m.find())
                    {
                        keywords = m.group(1);
                        referer = "http://" + domain + "/search?p=" + keywords;
                        keywords = java.net.URLDecoder.decode(keywords,"UTF-8");
                    }
                } else if(domain.equals(SEARCH_TYPE[3])) // 搜狗
                {
                    Matcher m = P_QUERY.matcher(referer);
                    if(m.find())
                    {
                        keywords = m.group(1);
                        referer = "http://" + domain + "/web?query=" + keywords;
                        keywords = java.net.URLDecoder.decode(keywords,"GBK");
                    }
                } else if(domain.equals(SEARCH_TYPE[4])) // 中搜
                {
                    Matcher m = P_W.matcher(referer);
                    if(m.find())
                    {
                        keywords = m.group(1);
                        referer = "http://" + domain + "/p?w=" + keywords;
                        keywords = java.net.URLDecoder.decode(keywords,"GBK");
                    }
                } else if(domain.equals(SEARCH_TYPE[5])) // 爱问
                {
                    Matcher m = P_K.matcher(referer);
                    if(m.find())
                    {
                        keywords = m.group(1);
                        referer = "http://" + domain + "/s?k=" + m.group(1);
                        keywords = java.net.URLDecoder.decode(keywords,"GBK");
                    }
                } else if(domain.equals(SEARCH_TYPE[6])) // 搜搜
                {
                    Matcher m = P_W.matcher(referer);
                    if(m.find())
                    {
                        keywords = m.group(1);
                        referer = "http://" + domain + "/q?w=" + keywords;
                        keywords = java.net.URLDecoder.decode(keywords,"GBK");
                    }
                } else if(domain.equals(SEARCH_TYPE[7])) // live.com
                {
                    Matcher m = P_Q.matcher(referer);
                    if(m.find())
                    {
                        keywords = m.group(1);
                        referer = "http://" + domain + "/results.aspx?q=" + keywords;
                        keywords = java.net.URLDecoder.decode(keywords,"UTF-8");
                    }
                }
                // if (keywords != null)
                // System.out.println(keywords + ":" + referer);
            } catch(Exception ex)
            {
                ex.printStackTrace();
            }
        }

        Calendar c = Calendar.getInstance();
        c.setTimeInMillis(System.currentTimeMillis());
        //c.set(11,0);
       // c.set(12,0);
      //  c.set(13,0);
      //  c.set(14,0);
        DbAdapter db = new DbAdapter(8);
        try
        {    db.executeUpdate("INSERT INTO NodeAccessReferer (community,referer,count,sum,time,domain,keywords)VALUES(" + DbAdapter.cite(community) + "," + DbAdapter.cite(referer) + ",1,1," + DbAdapter.cite(c.getTime()) + "," + DbAdapter.cite(domain) + "," + DbAdapter.cite(keywords) + ")");
          /*
			int j = db.executeUpdate("UPDATE NodeAccessReferer SET sum=sum+1,count=count+1 WHERE community=" + DbAdapter.cite(community) + " AND referer=" + DbAdapter.cite(referer) + " AND time=" + DbAdapter.cite(c.getTime()));
            if(j < 1)
            {
                j = db.executeUpdate("UPDATE NodeAccessReferer SET sum=sum+1,count=1,time=" + DbAdapter.cite(c.getTime()) + " WHERE community=" + DbAdapter.cite(community) + " AND referer=" + DbAdapter.cite(referer));
                if(j < 1)
                {
                    db.executeUpdate("INSERT INTO NodeAccessReferer (community,referer,count,sum,time,domain,keywords)VALUES(" + DbAdapter.cite(community) + "," + DbAdapter.cite(referer) + ",1,1," + DbAdapter.cite(c.getTime()) + "," + DbAdapter.cite(domain) + "," + DbAdapter.cite(keywords) + ")");
                }
            }
		  */
        } catch(Exception ex)
        {
            System.out.println("NodeAccessReferer:137\t");
        } finally
        {
            db.close();
        }
    }

/*
    public static Enumeration findByCommunity(String community,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter(8);
        try
        {
          //  db.executeUpdate("UPDATE NodeAccessReferer SET count=0 WHERE count>0 AND time<" + DbAdapter.cite(new Date(),true) + " AND community=" + DbAdapter.cite(community)); // 如果不是当天的数量,就改为0
            db.executeQuery("SELECT SUM(count),SUM(sum),domain FROM NodeAccessFrom WHERE community=" + DbAdapter.cite(community) + " GROUP BY domain ORDER BY SUM(sum) DESC,SUM(count) DESC",pos,size);
            while(db.next())
            {
                int count =db.getInt(1);
                int sum = db.getInt(2);
                String domain = db.getString(3);
                v.addElement(new NodeAccessReferer(null,count,sum,domain,null));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }
    */
	public static ArrayList findByCommunity(String community,int pos,int size) throws SQLException
	{
		ArrayList rs = new ArrayList();
		String arr[] =
				{"count","sum"};
		ArrayList al = new ArrayList();
		DbAdapter db = new DbAdapter(8);
		try
		{
			
				

			     db.executeQuery("SELECT SUM(sum),domain FROM NodeAccessFrom WHERE community=" + DbAdapter.cite(community) + " GROUP BY domain ORDER BY SUM(sum) DESC",pos,size);
			      while(db.next())
				{
					int sum = db.getInt(1);
					String where = db.getVarchar(1,1,2);
					rs.add(new Object[]
						   {sum,where});
				}


		
		} finally
		{
			db.close();
		}
		return rs;
	}
	
	public static ArrayList findByCommunity(String community,int  year,int month,int pos,int size) throws SQLException
	{
		ArrayList rs = new ArrayList();
		String arr[] =
				{"count","sum"};
		ArrayList al = new ArrayList();
		DbAdapter db = new DbAdapter(8);
		try
		{
		
				
			if(ConnectionPool._nType ==2)
				 db.executeQuery("SELECT SUM(sum),domain FROM NodeAccessFrom WHERE to_number(to_char(time,'yyyy'))="+year+" and to_number(to_char(time,'MM'))="+month+" and community=" + DbAdapter.cite(community) + " GROUP BY domain ORDER BY SUM(sum) DESC",pos,size);
			
				else
			     db.executeQuery("SELECT SUM(sum),domain FROM NodeAccessFrom WHERE year(time)="+year+" and month(time)="+month+" and community=" + DbAdapter.cite(community) + " GROUP BY domain ORDER BY SUM(sum) DESC",pos,size);
				while(db.next())
				{
					int sum = db.getInt(1);
					String where = db.getVarchar(1,1,2);
					rs.add(new Object[]
						   {sum,where});
				}


		
		} finally
		{
			db.close();
		}
		return rs;
	}
	public static ArrayList findByCommunity(String community,int  year,int month,int day,int pos,int size) throws SQLException
	{
		ArrayList rs = new ArrayList();
		String arr[] =
				{"count","sum"};
		ArrayList al = new ArrayList();
		DbAdapter db = new DbAdapter(8);
		try
		{
		
				
			if(ConnectionPool._nType ==2)
				 db.executeQuery("SELECT SUM(sum),domain FROM NodeAccessFrom WHERE to_number(to_char(time,'yyyy'))="+year+" and to_number(to_char(time,'MM'))="+month+" and to_number(to_char(time,'dd'))="+day+" and community=" + DbAdapter.cite(community) + " GROUP BY domain ORDER BY SUM(sum) DESC",pos,size);
			
				else
			     db.executeQuery("SELECT SUM(sum),domain FROM NodeAccessFrom WHERE year(time)="+year+" and month(time)="+month+" and day(time)="+day+" and community=" + DbAdapter.cite(community) + " GROUP BY domain ORDER BY SUM(sum) DESC",pos,size);
				while(db.next())
				{
					int sum = db.getInt(1);
					String where = db.getVarchar(1,1,2);
					rs.add(new Object[]
						   {sum,where});
				}


		
		} finally
		{
			db.close();
		}
		return rs;
	}
	
	public static int countByCommunity(String community,int  year,int month) throws SQLException
	{
		int count=0;
		DbAdapter db = new DbAdapter(8);
		try
		{
		
				
			if(ConnectionPool._nType ==2)
				  db.executeQuery("SELECT SUM(sum)  FROM NodeAccessFrom WHERE to_number(to_char(time,'yyyy'))="+year+" and to_number(to_char(time,'MM'))="+month+" and community=" + DbAdapter.cite(community) );
			
				else
			     db.executeQuery("SELECT SUM(sum)  FROM NodeAccessFrom WHERE year(time)="+year+" and month(time)="+month+" and community=" + DbAdapter.cite(community) );
				if (db.next())
				{
					count= db.getInt(1);
				
				}


		
		} finally
		{
			db.close();
		}
		return count;
	}
	public static int countByCommunity(String community,int  year,int month,int day) throws SQLException
	{
		int count=0;
		DbAdapter db = new DbAdapter(8);
		try
		{
		
			if(ConnectionPool._nType ==2)
				  db.executeQuery("SELECT SUM(sum)  FROM NodeAccessFrom WHERE to_number(to_char(time,'yyyy'))="+year+" and to_number(to_char(time,'MM'))="+month+" and to_number(to_char(time,'dd'))="+day+" and community=" + DbAdapter.cite(community) );
			
				else

			     db.executeQuery("SELECT SUM(sum)  FROM NodeAccessFrom WHERE year(time)="+year+" and month(time)="+month+" and day(time)="+day+" and community=" + DbAdapter.cite(community) );
				if (db.next())
				{
					count= db.getInt(1);
				
				}


		
		} finally
		{
			db.close();
		}
		return count;
	}
	public static Enumeration findByCommunity_Count(String community,int pos,int size) throws SQLException
   {
	   Vector v = new Vector();
	   DbAdapter db = new DbAdapter(8);
	   try
	   {
		 //  db.executeUpdate("UPDATE NodeAccessReferer SET count=0 WHERE count>0 AND time<" + DbAdapter.cite(new Date(),true) + " AND community=" + DbAdapter.cite(community)); // 如果不是当天的数量,就改为0
	
		   if(ConnectionPool._nType ==2)
			   db.executeQuery("SELECT SUM(sum),domain FROM NodeAccessFrom WHERE floor(sysdate-time)=0 and community=" + DbAdapter.cite(community) + " GROUP BY domain ORDER BY SUM(sum) DESC,SUM(count) DESC",pos,size);
			  
		   else
			   
		   db.executeQuery("SELECT SUM(sum),domain FROM NodeAccessFrom WHERE datediff(day,time,getdate())=0 and community=" + DbAdapter.cite(community) + " GROUP BY domain ORDER BY SUM(sum) DESC,SUM(count) DESC",pos,size);
		   while(db.next())
		   {
			   int count = db.getInt(1);
			   int sum = 0;
			   String domain = db.getString(2); 
			   v.addElement(new NodeAccessReferer(null,count,sum,domain,null));
		   }
	   } finally
	   {
		   db.close();
	   }
	   return v.elements();
   }


    public static Enumeration findKeywordsByCommunity(String community,int pos,int size) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter(8);
        try
        {
            db.executeQuery("SELECT SUM(count),SUM(sum),keywords FROM NodeAccessFrom WHERE community=" + DbAdapter.cite(community) + " AND keywords IS NOT NULL GROUP BY keywords ORDER BY SUM(sum) DESC,SUM(count) DESC",pos,size);
            while(db.next())
            {
                int count = db.getInt(1);
                int sum = db.getInt(2);
                String keywords = db.getString(3);
                vector.addElement(new NodeAccessReferer(null,count,sum,null,keywords));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static Enumeration findByDomain(String community,String domain,int pos,int size) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter(8);
        try
        {
            db.executeQuery("SELECT count,sum,referer FROM NodeAccessFrom WHERE community=" + DbAdapter.cite(community) + " AND domain=" + DbAdapter.cite(domain) + " ORDER BY sum DESC",pos,size);
            while(db.next())
            {
                int count = db.getInt(1);
                int sum = db.getInt(2);
                String referer = db.getString(3);
                vector.addElement(new NodeAccessReferer(referer,count,sum,null,null));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static NodeAccessReferer find(String commonity,String referer) throws SQLException
    {
        return new NodeAccessReferer(commonity,referer);
    }

    public String getCommunity()
    {
        return community;
    }

    public int getCount()
    {
        return count;
    }

    public static int countByCommunity(String community) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter(8);
        try
        {
            db.executeQuery("SELECT COUNT(DISTINCT domain) FROM NodeAccessFrom WHERE community=" + DbAdapter.cite(community));
            if(db.next())
            {
                j = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return j;
    }

    public static int countByDomain(String community,String domain) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter(8);
        try
        {
            db.executeQuery("SELECT COUNT(domain) FROM NodeAccessFrom WHERE community=" + DbAdapter.cite(community) + " AND domain=" + DbAdapter.cite(domain));
            if(db.next())
            {
                j = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return j;
    }

    public static int getCountMax(String community) throws SQLException
    {
        DbAdapter db = new DbAdapter(8);
        try
        {    if(ConnectionPool._nType ==2)
        {  return db.getInt("SELECT SUM(count) FROM NodeAccessFrom WHERE floor(sysdate-time)=0 and community=" + DbAdapter.cite(community) + " GROUP BY domain ORDER BY SUM(count) DESC");}
        else
        {  return db.getInt("SELECT SUM(count) FROM NodeAccessFrom WHERE datediff(day,time,getdate())=0 and community=" + DbAdapter.cite(community) + " GROUP BY domain ORDER BY SUM(count) DESC");}
        } finally
        {
            db.close();
        }
    }

    public int getSum()
    {
        return sum;
    }

    public String getReferer()
    {
        return referer;
    }

    public static int getSumMax(String community) throws SQLException
    {
        DbAdapter db = new DbAdapter(8);
        try
        {
            return db.getInt("SELECT SUM(sum) FROM NodeAccessFrom where community=" + DbAdapter.cite(community) + " GROUP BY domain ORDER BY SUM(sum) DESC");
        } finally
        {
            db.close();
        }
    }

    public String getDomain()
    {
        return domain;
    }

    public String getKeywords()
    {
        return keywords;
    }
}
