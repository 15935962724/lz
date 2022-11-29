package tea.entity.node.access;

import java.util.*;
import tea.entity.*;
import tea.db.ConnectionPool;
import tea.db.DbAdapter;
import java.sql.SQLException;

public class NodeAccessLast extends Entity
{
	private int id;
	private String community;
	private int node;
	private int count;
	private String ip;
	private String member;
	private Date time;

	public NodeAccessLast(int id,String community,int node,String ip,String member,Date time)
	{
		this.id = id;
		this.community = community;
		this.node = node;
		this.ip = ip;
		this.member = member;
		this.time = time;
	}


	public NodeAccessLast()
	{}
	public static boolean create(String community,int node,String ip,String member)
	{   boolean isNewIp = true;
		Date time = new Date();
		DbAdapter db = new DbAdapter(8);
		try
		{
			//db.executeQuery("SELECT id FROM NodeAccessLast WHERE community=" + DbAdapter.cite(community) + " AND ip=" + DbAdapter.cite(ip) + " AND time>" + DbAdapter.cite(time,true));
			//isNewIp = !db.next();
			String address=NodeAccessWhere.findByIp(ip);
			db.executeUpdate("INSERT INTO NodeAccessLast(community,node,ip,member,time,address)VALUES(" + DbAdapter.cite(community) + "," + node + "," + DbAdapter.cite(ip) + "," + DbAdapter.cite(member) + "," + DbAdapter.cite(time) + "," + DbAdapter.cite(address) + ")");
			//System.out.println("INSERT INTO NodeAccessLast(community,node,ip,member,time,address)VALUES(" + DbAdapter.cite(community) + "," + node + "," + DbAdapter.cite(ip) + "," + DbAdapter.cite(member) + "," + DbAdapter.cite(time) + "," + DbAdapter.cite(address) + ")");
				} catch(Exception exception)
		{
			System.out.println("NodeAccessLast:40");
		} finally
		{
			db.close();
		}
		return isNewIp;
	}
	public static boolean create(String community,int node,String ip,String member,int type)
	{   boolean isNewIp = true;
		Date time = new Date();
		DbAdapter db = new DbAdapter(8);
		try
		{
			//db.executeQuery("SELECT id FROM NodeAccessLast WHERE community=" + DbAdapter.cite(community) + " AND ip=" + DbAdapter.cite(ip) + " AND time>" + DbAdapter.cite(time,true));
			//isNewIp = !db.next();
			String address=NodeAccessWhere.findByIp(ip);
			db.executeUpdate("INSERT INTO NodeAccessLast(community,node,ip,member,time,address,isnewip)VALUES(" + DbAdapter.cite(community) + "," + node + "," + DbAdapter.cite(ip) + "," + DbAdapter.cite(member) + "," + DbAdapter.cite(time) + "," + DbAdapter.cite(address) + ","+type+")");
		//	db.executeUpdate("INSERT INTO NodeAccessLast(community,node,ip,member,time)VALUES(" + DbAdapter.cite(community) + "," + node + "," + DbAdapter.cite(ip) + "," + DbAdapter.cite(member) + "," + DbAdapter.cite(time) +")");
		} catch(Exception exception)
		{
			System.out.println("NodeAccessLast:40");
		} finally
		{
			db.close();
		}
		return isNewIp;
	}

	public static Enumeration<NodeAccessLast> findByCommunity(String community,int pos,int size) throws SQLException
	{
		Vector<NodeAccessLast> v = new Vector<NodeAccessLast>();
		DbAdapter db = new DbAdapter(8);
		try
		{
			db.executeQuery("SELECT id,node,ip,member,time FROM NodeAccessLast WHERE community=" + DbAdapter.cite(community) + " ORDER BY id DESC",pos,size);
			while(db.next())
			{
				v.add(new NodeAccessLast(db.getInt(1),community,db.getInt(2),db.getString(3),db.getString(4),db.getDate(5)));
			}
		} finally
		{
			db.close();
		}
		return v.elements();
	}



	public static List<NodeAccessLast> findHotNodes(String community,int year,int month,String columnodeSql,int pos,int size) throws SQLException
	{
		List<NodeAccessLast> list=new ArrayList<NodeAccessLast>();
		DbAdapter db = new DbAdapter(8);

		try
		{
			if(ConnectionPool._nType ==2)
				db.executeQuery("SELECT node,click FROM NodeAccessHot n " +
						" WHERE to_number(to_char(time,'yyyy'))="+year+" and to_number(to_char(time,'MM'))="+month+"  and n.community="+DbAdapter.cite(community) + columnodeSql
						 +" order by click desc",pos,size);
			else
				/*
			db.executeQuery("SELECT node,click FROM NodeAccessHot n " +
					" WHERE to_number(to_char(time,'yyyy'))="+year+" and month(time)="+month+"  and n.community="+DbAdapter.cite(community)
					 +" order by click desc",pos,size);
*/
				db.executeQuery("SELECT node,click FROM NodeAccessHot n " +
						" WHERE year(time)="+year+" and month(time)="+month+" and day(time)=1 and n.community="+DbAdapter.cite(community) + columnodeSql
						 +" order by click desc",pos,size);
			while(db.next())
			{ NodeAccessLast node=new NodeAccessLast();
			  node.setNode(db.getInt(1));
			  node.setCount(db.getInt(2));
			   list.add(node);
			}
		} finally
		{
			db.close();
		}
		return list;
	}

	public static int countHotNodes(String community,int year,int month,String columnodeSql) throws SQLException
	{
int i=0;

		DbAdapter db = new DbAdapter(8);

		try
		{if(ConnectionPool._nType ==2)
 			db.executeQuery("SELECT sum(click) FROM NodeAccessHot n " +
					" WHERE to_number(to_char(time,'yyyy'))="+year+" and to_number(to_char(time,'MM'))="+month+"  and n.community="+DbAdapter.cite(community)+columnodeSql
				);
		else
			db.executeQuery("SELECT sum(click) FROM NodeAccessHot n " +
					" WHERE year(time)="+year+" and month(time)="+month+"  and n.community="+DbAdapter.cite(community)+columnodeSql
				);
			if(db.next())
			{ i=db.getInt(1);
			}
		} catch(Exception e)
		{e.printStackTrace();
		}finally
		{
			db.close();
		}
		return i;
	}

	public static int itemHotNodes(String community,int year,int month,String columnodeSql) throws SQLException
	{
int i=0;

		DbAdapter db = new DbAdapter(8);
		try
		{if(ConnectionPool._nType ==2)
		db.executeQuery("SELECT count(*) FROM NodeAccessHot n " +
			" WHERE to_number(to_char(time,'yyyy'))="+year+" and to_number(to_char(time,'MM'))="+month+"  and n.community="+DbAdapter.cite(community) + columnodeSql);
		else
 			db.executeQuery("SELECT count(*) FROM NodeAccessHot n " +
					" WHERE year(time)="+year+" and month(time)="+month+"  and n.community="+DbAdapter.cite(community) + columnodeSql);
			if(db.next())
			{ i=db.getInt(1);
			}
		} finally
		{
			db.close();
		}
		return i;
	}

	public static List<NodeAccessLast> findHotNodesByMonth(String community,int year,int month,String columnodeSql,int pos,int size) throws SQLException
	{  List<NodeAccessLast> list=new ArrayList<NodeAccessLast>();
		DbAdapter db = new DbAdapter(8);

		try
		{
		 	db.executeQuery("SELECT node,click FROM NodeAccessHotByMonth n " +
						" WHERE year(time)="+year+" and month(time)="+month+" and day(time)=1 and n.community="+DbAdapter.cite(community)+columnodeSql
						 +" order by click desc",pos,size);
			while(db.next())
			{ NodeAccessLast node=new NodeAccessLast();
			  node.setNode(db.getInt(1));
			  node.setCount(db.getInt(2));
			   list.add(node);
			}
		} finally
		{
			db.close();
		}
		return list;
	}


	public static int countHotNodesByMonth(String community,int year,int month) throws SQLException
	{
int i=0;

		DbAdapter db = new DbAdapter(8);

		try
		{
			db.executeQuery("SELECT sum(click) FROM NodeAccessHotByMonth n " +
					" WHERE year(time)="+year+" and month(time)="+month+"  and n.community="+DbAdapter.cite(community)
				);
			if(db.next())
			{ i=db.getInt(1);
			}
		} catch(Exception e)
		{e.printStackTrace();
		}finally
		{
			db.close();
		}
		return i;
	}

	public static int itemHotNodesByMonth(String community,int year,int month,String columnodeSql) throws SQLException
	{
int i=0;

		DbAdapter db = new DbAdapter(8);

		try
		{
 			db.executeQuery("SELECT count(*) FROM NodeAccessHotByMonth n " +
					" WHERE year(time)="+year+" and month(time)="+month+"  and n.community="+DbAdapter.cite(community) + columnodeSql);
			if(db.next())
			{ i=db.getInt(1);
			}
		} finally
		{
			db.close();
		}
		return i;
	}

	public static List<NodeAccessLast> findHotNodes(String community,int year,int month,int day,String columnodeSql,int pos,int size) throws SQLException
	{
		List<NodeAccessLast> list=new ArrayList<NodeAccessLast>();
		DbAdapter db = new DbAdapter(8);

		try
		{if(ConnectionPool._nType ==2)
			db.executeQuery("SELECT node,click FROM NodeAccessHot n " +
					" WHERE to_number(to_char(time,'yyyy'))="+year+" and to_number(to_char(time,'MM'))="+month+" and to_number(to_char(time,'dd'))="+day+"  and n.community="+DbAdapter.cite(community) + columnodeSql
					 +" order by click desc",pos,size);
		else
			db.executeQuery("SELECT node,click FROM NodeAccessHot n " +
					" WHERE year(time)="+year+" and month(time)="+month+" and day(time)="+day+"  and n.community="+DbAdapter.cite(community) + columnodeSql
					 +" order by click desc",pos,size);

			while(db.next())
			{ NodeAccessLast node=new NodeAccessLast();
			  node.setNode(db.getInt(1));
			  node.setCount(db.getInt(2));
			   list.add(node);
			}
		} finally
		{
			db.close();
		}
		return list;
	}



	public static int countHotNodes(String community,int year,int month,int day,String columnodeSql) throws SQLException
	{
int i=0;

		DbAdapter db = new DbAdapter(8);

		try
		{if(ConnectionPool._nType ==2)
 			db.executeQuery("SELECT sum(click) FROM NodeAccessHot n " +
					" WHERE to_number(to_char(time,'yyyy'))="+year+" and to_number(to_char(time,'MM'))="+month+" and to_number(to_char(time,'dd'))="+day+"  and n.community="+DbAdapter.cite(community)+columnodeSql
				);
		else
			db.executeQuery("SELECT sum(click) FROM NodeAccessHot n " +
					" WHERE year(time)="+year+" and month(time)="+month+" and day(time)="+day+"  and n.community="+DbAdapter.cite(community)+columnodeSql
				);
			if(db.next())
			{ i=db.getInt(1);
			}
		} finally
		{
			db.close();
		}
		return i;
	}

	public static int itemHotNodes(String community,int year,int month,int day,String columnodeSql) throws SQLException
	{
int i=0;

		DbAdapter db = new DbAdapter(8);
		try
		{if(ConnectionPool._nType ==2)
 			db.executeQuery("SELECT count(*) FROM NodeAccessHot n " +
					" WHERE to_number(to_char(time,'yyyy'))="+year+" and to_number(to_char(time,'MM'))="+month+" and to_number(to_char(time,'dd'))="+day+"  and n.community="+DbAdapter.cite(community) + columnodeSql
				);
		else
			db.executeQuery("SELECT count(*) FROM NodeAccessHot n " +
					" WHERE year(time)="+year+" and month(time)="+month+" and day(time)="+day+"  and n.community="+DbAdapter.cite(community) + columnodeSql
					
				);
			if(db.next())
			{ i=db.getInt(1);
			}
		} finally
		{
			db.close();
		}
		return i;
	}
	public static int countOldIp(String community) throws SQLException
	{
int i=0;

		DbAdapter db = new DbAdapter(8);

		try
		{
 			db.executeQuery("SELECT ip FROM NodeAccessOld where community="+DbAdapter.cite(community));
			if(db.next())
			{ i=db.getInt(1);
			}
		} catch(Exception e)
		{e.printStackTrace();
		}
		finally
		{
			db.close();
		}
		return i;
	}
	public static int countOldPv(String community) throws SQLException
	{
int i=0;

		DbAdapter db = new DbAdapter(8);

		try
		{
 			db.executeQuery("SELECT pv FROM NodeAccessOld where community="+DbAdapter.cite(community));
			if(db.next())
			{ i=db.getInt(1);
			}
		}catch(Exception e)
		{e.printStackTrace();
		} finally
		{
			db.close();
		}
		return i;
	}

	public static void setOldAccess(String community,int pv,int ip) throws SQLException
	{
   	DbAdapter db = new DbAdapter(8);
	try
		{
 			db.executeQuery("SELECT * FROM NodeAccessOld where community="+DbAdapter.cite(community));
			if(db.next())
			{
		    db.executeUpdate("update NodeAccessOld set pv="+pv+",ip="+ip+" where community="+DbAdapter.cite(community));
			}else
			 db.executeUpdate("insert NodeAccessOld(community,pv,ip)values("+DbAdapter.cite(community)+","+pv+","+ip+")");

		} catch(Exception e)
		{e.printStackTrace();
		}finally
		{
			db.close();
		}

	}


	public Date getTime()
	{
		return time;
	}

	public String getTimeToString()
	{
		return sdf3.format(time);
	}

	public int getNode()
	{
		return node;
	}

	public String getIp()
	{
		return ip;
	}

	public String getMember()
	{
		return member;
	}

	public int getId()
	{
		return id;
	}

	public int getCount()
	{
		return count;
	}

	public void setCount(int count)
	{
		this.count = count;
	}

	public void setNode(int node)
	{
		this.node = node;
	}
}
