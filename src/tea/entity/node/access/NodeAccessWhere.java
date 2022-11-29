package tea.entity.node.access;

import java.util.*;
import tea.db.*;
import java.sql.SQLException;
import java.io.*;

public class NodeAccessWhere
{
	private String community;
	private int count;
	private int sum;
	private String ip;
	private Date time;
	private boolean load;
	private String where;
	public NodeAccessWhere(String commonity,String ip)
	{
		this.community = commonity;
		this.ip = ip;
		load = false;
	}

	public NodeAccessWhere()
	{

	}
	public NodeAccessWhere(String ip,int count,int sum,String address)
	{
		this.ip = ip;
		this.count = count;
		this.sum = sum;
		this.where = address;
	}



	public static void create(String onip,String offip,String district,String address) throws SQLException
	{
		DbAdapter db = new DbAdapter(8);
		try
		{
			db.executeUpdate("INSERT INTO ip(onip,offip,ip,district,address)VALUES(" + conv(onip) + "," + conv(offip) + "," + db.cite(onip) + "," + db.cite(district) + "," + db.cite(address) + ")");
		} finally
		{
			db.close();
		}
	}

	public static void imp(File f) throws IOException,SQLException
	{
		String line;
		BufferedReader br = new BufferedReader(new FileReader(f));
		try
		{
			for(int i = 0;(line = br.readLine()) != null;i++)
			{
				String arr[] = line.split(" +");
				String str = null;
				if(arr[2].equals("CZ88.NET"))
				{
					arr[2] = "未知IP";
				} else if(arr.length > 3 && !arr[3].equals("CZ88.NET"))
				{
					str = arr[3];
				}
				create(arr[0],arr[1],arr[2],str);
				if(i % 1000 == 0)
				{
					System.out.println(i + ":" + line);
				}
			}
		} finally
		{
			br.close();
		}
	}

	

	@SuppressWarnings("unchecked")
	public static ArrayList findByCommunity(String community,int pos,int size) throws SQLException
	{
		ArrayList rs = new ArrayList();
		String arr[] =
				{"count","sum"};
		ArrayList al = new ArrayList();
		DbAdapter db = new DbAdapter(8);
		try
		{
			if(ConnectionPool._nType ==2)
				db.executeQuery("SELECT SUM(count),address FROM NodeAccessCity WHERE community=" + DbAdapter.cite(community) + " and floor(sysdate-time)=0 GROUP BY address ORDER BY SUM(count) DESC",pos,size);
			
			else
				db.executeQuery("SELECT SUM(count),address FROM NodeAccessCity WHERE community=" + DbAdapter.cite(community) + " and datediff(day,time,getdate())=0 GROUP BY address ORDER BY SUM(count) DESC",pos,size);
					while(db.next())
					{
						int sum = db.getInt(1);
						String where = db.getVarchar(1,1,2);
						rs.add(new Object[]
							   {sum,where});
					}


			db.executeQuery("SELECT SUM(sum),address FROM NodeAccessCity WHERE community=" + DbAdapter.cite(community) + " GROUP BY address ORDER BY SUM(sum) DESC",pos,size);
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
	
	public static ArrayList findByCommunity(String community,int year,int month,int pos,int size) throws SQLException
	{
		ArrayList rs = new ArrayList();
		String arr[] =
				{"count","sum"};
		ArrayList al = new ArrayList();
		DbAdapter db = new DbAdapter(8);
		try
		{
		/*
				db.executeQuery("SELECT SUM(count),address FROM NodeAccessCity WHERE community=" + DbAdapter.cite(community) + " and datediff(day,time,getdate())=0 GROUP BY address ORDER BY SUM(count) DESC",pos,size);
					while(db.next())
					{
						int sum = db.getInt(1);
						String where = db.getVarchar(1,1,2);
						rs.add(new Object[]
							   {sum,where});
					}
        */
			if(ConnectionPool._nType ==2)
				db.executeQuery("SELECT SUM(sum),address FROM NodeAccessCity WHERE to_number(to_char(time,'yyyy'))="+year+" and to_number(to_char(time,'MM'))="+month+" and community=" + DbAdapter.cite(community) + " GROUP BY address ORDER BY SUM(sum) DESC",pos,size);
			
				else
			db.executeQuery("SELECT SUM(sum),address FROM NodeAccessCity WHERE year(time)="+year+" and month(time)="+month+" and community=" + DbAdapter.cite(community) + " GROUP BY address ORDER BY SUM(sum) DESC",pos,size);
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
	
	public static ArrayList findByCommunity(String community,int year,int month,int day,int pos,int size) throws SQLException
	{
		ArrayList rs = new ArrayList();
		String arr[] =
				{"count","sum"};
		ArrayList al = new ArrayList();
		DbAdapter db = new DbAdapter(8);
		try
		{
		/*
				db.executeQuery("SELECT SUM(count),address FROM NodeAccessCity WHERE community=" + DbAdapter.cite(community) + " and datediff(day,time,getdate())=0 GROUP BY address ORDER BY SUM(count) DESC",pos,size);
					while(db.next())
					{
						int sum = db.getInt(1);
						String where = db.getVarchar(1,1,2);
						rs.add(new Object[]
							   {sum,where});
					}
        */
			if(ConnectionPool._nType ==2)
				db.executeQuery("SELECT SUM(sum),address FROM NodeAccessCity WHERE to_number(to_char(time,'yyyy'))="+year+" and to_number(to_char(time,'MM'))="+month+" and to_number(to_char(time,'dd'))="+day+" and community=" + DbAdapter.cite(community) + " GROUP BY address ORDER BY SUM(sum) DESC",pos,size);
			
				else
			db.executeQuery("SELECT SUM(sum),address FROM NodeAccessCity WHERE year(time)="+year+" and month(time)="+month+" and day(time)="+day+" and community=" + DbAdapter.cite(community) + " GROUP BY address ORDER BY SUM(sum) DESC",pos,size);
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
	public static int countByCommunity(String community,int year,int month) throws SQLException
	{
		int count=0;
		DbAdapter db = new DbAdapter(8);
		try
		{
	
			if(ConnectionPool._nType ==2)
				db.executeQuery("SELECT sum(sum) FROM NodeAccessCity WHERE to_number(to_char(time,'yyyy'))="+year+" and to_number(to_char(time,'MM'))="+month+" and community=" + DbAdapter.cite(community));
			
				else
			db.executeQuery("SELECT sum(sum) FROM NodeAccessCity WHERE year(time)="+year+" and month(time)="+month+" and community=" + DbAdapter.cite(community));
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

	public static int countByCommunity(String community,int year,int month,int day) throws SQLException
	{
		int count=0;
		DbAdapter db = new DbAdapter(8);
		try
		{
	
			if(ConnectionPool._nType ==2)
				db.executeQuery("SELECT sum(sum) FROM NodeAccessCity WHERE to_number(to_char(time,'yyyy'))="+year+" and to_number(to_char(time,'MM'))="+month+" and to_number(to_char(time,'dd'))="+day+" and community=" + DbAdapter.cite(community));
			
				else
			db.executeQuery("SELECT sum(sum) FROM NodeAccessCity WHERE year(time)="+year+" and month(time)="+month+" and day(time)="+day+" and community=" + DbAdapter.cite(community));
			//System.out.println("SELECT sum(sum) FROM NodeAccessCity WHERE year(time)="+year+" and month(time)="+month+" and day(time)="+day+" and community=" + DbAdapter.cite(community));
				if(db.next())
				{
					count = db.getInt(1);
				//	System.out.println("count:"+count);
				}


		
		} finally
		{
			db.close();
		}
		return count;
	}
	public static int countByCommunity1(String community,int year,int month) throws SQLException
	{
		int count=0;
		DbAdapter db = new DbAdapter(8);
		try
		{
	

			db.executeQuery("SELECT count(distinct address) FROM NodeAccessCity WHERE year(time)="+year+" and month(time)="+month+" and community=" + DbAdapter.cite(community));
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

	public static int countByCommunity1(String community,int year,int month,int day) throws SQLException
	{
		int count=0;
		DbAdapter db = new DbAdapter(8);
		try
		{
	
			if(ConnectionPool._nType ==2)
				db.executeQuery("SELECT count(distinct address) FROM NodeAccessCity WHERE to_number(to_char(time,'yyyy'))="+year+" and to_number(to_char(time,'MM'))="+month+" and to_number(to_char(time,'dd'))="+day+" and community=" + DbAdapter.cite(community) );
			
				else
			db.executeQuery("SELECT count(distinct address) FROM NodeAccessCity WHERE year(time)="+year+" and month(time)="+month+" and day(time)="+day+" and community=" + DbAdapter.cite(community) );
			//System.out.println("SELECT sum(sum) FROM NodeAccessCity WHERE year(time)="+year+" and month(time)="+month+" and day(time)="+day+" and community=" + DbAdto_number(to_char(time,'dd'))e(community));
				if(db.next())
				{
					count = db.getInt(1);
				//	System.out.println("count:"+count);
				}


		
		} finally
		{
			db.close();
		}
		return count;
	}
	@SuppressWarnings("unchecked")
	public static List FindCommunityToday(String community,int pos,int size) throws SQLException
	{
		HashMap hm=new HashMap();
		 ArrayList al=new ArrayList();
		DbAdapter db = new DbAdapter(8);
		try{
			if(ConnectionPool._nType ==2)
				db.executeQuery("SELECT sum(sum),address from NodeAccessCity" +
						" where community=  " +DbAdapter.cite(community)+
						" and address is not null and floor(sysdate-time)=0"+
						" group by address order by sum(sum) desc",pos,size);
				else
			db.executeQuery("SELECT sum(sum),address from NodeAccessCity" +
					" where community=  " +DbAdapter.cite(community)+
					" and address is not null and datediff(day,time,getdate())=0"+
					" group by address order by sum(sum) desc",pos,size);
				while(db.next())
				{  int sum=db.getInt(1);
				  String address=db.getString(2);
				   NodeAccessWhere naw=new NodeAccessWhere();
				   naw.setSum(sum);
				   naw.setWhere(address);
				   al.add(naw);
				 }
		   } finally
		{
			db.close();
		}

		return al;
	}





	public static int countByCommunity(String community) throws SQLException
	{
		int j = 0;
		DbAdapter db = new DbAdapter(8);
		try
		{

     	db.executeQuery("SELECT COUNT(address) FROM NodeAccessCity WHERE community=" + DbAdapter.cite(community));
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



	private static long conv(String ipaddr)
	{
		long ip = 0L;
		StringTokenizer tokenizer = new StringTokenizer(ipaddr,".");
		for(int index = 0;tokenizer.hasMoreTokens();index++)
		{
			switch(index)
			{
			case 0:
				ip = 256 * 256 * 256 * Long.parseLong(tokenizer.nextToken());
				break;
			case 1:
				ip += 256 * 256 * Long.parseLong(tokenizer.nextToken());
				break;
			case 2:
				ip += 256 * Long.parseLong(tokenizer.nextToken());
				break;
			case 3:
				ip += Long.parseLong(tokenizer.nextToken());
				break;
			}
		}
		return ip;
	}

	public static String findByIp(String ipaddr) throws SQLException
	{
		if(ipaddr == null)
		{
			return "UNKNOWN";
		}
		String str = "UNKNOWN";
		long ip = conv(ipaddr);
		DbAdapter db = new DbAdapter(8);
		try
		{   db.executeQuery("SELECT district,address FROM ip WHERE onip<=" + ip + " and offip>="+ip+" ORDER BY onip DESC",0,1);
		//System.out.println("SELECT district,address FROM ip WHERE onip<=" + ip + " and offip>="+ip+" ORDER BY onip DESC");
		
		if(db.next())
			{
				str = db.getString(1);
				String str2 = db.getString(2);
				if(str2 != null && str.equals("中国"))
				{
					str = str + str2;
				}
			}
		} finally
		{
			db.close();
		}
		return str;
	}



	public int getCount()
	{
		return count;
	}

	public int getSum()
	{
		return sum;
	}

	public Date getTime()
	{
		return time;
	}

	public void setTime(Date time)
	{
		this.time = time;
	}

	public void setCount(int count)
	{
		this.count = count;
	}

	public void setSum(int sum)
	{
		this.sum = sum;
	}

	public void setIp(String ip)
	{
		this.ip = ip;
	}
	public void setWhere(String where)
	{
		this.where = where;
	}

	public String getIp()
	{
		return ip;
	}

	public String getWhere()
	{
		return where;
	}

	}
