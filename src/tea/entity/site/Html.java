package tea.entity.site;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import tea.entity.node.*;

public class Html
{
	protected static Cache _cache = new Cache(100);
	public String community;
	public int style;
	public int day;
	public int hour;
	public int minute;
	public String nodes = "|"; //附加页面
	public String path;
	public Date ltime; //差异 上次刷新时间
	public int lnode; //全部

	public Html(String community)
	{
		this.community = community;
	}

	//历史遗留,更新mzb时要用到
	public String getPath()
	{
		return MT.f(path,System.getProperty("java.io.tmpdir") + "/" + Http.REAL_PATH.hashCode() + "/" + community + "/");
	}

	public static String getPath(String community)
	{
		return System.getProperty("java.io.tmpdir") + "/" + Http.REAL_PATH.hashCode() + "/" + community + "/";
	}

	public static Html find(String community) throws SQLException
	{
		Html t = (Html) _cache.get(community);
		if(t == null)
		{
			ArrayList al = find(" AND community=" + DbAdapter.cite(community),0,1);
			t = al.size() < 1 ? new Html(community) : (Html) al.get(0);
		}
		return t;
	}

	public static ArrayList find(String sql,int pos,int size) throws SQLException
	{
		ArrayList al = new ArrayList();
		DbAdapter db = new DbAdapter();
		try
		{
			java.sql.ResultSet rs = db.executeQuery("SELECT community,style,day,hour,minute,nodes,path,ltime,lnode FROM Html WHERE 1=1" + sql,pos,size);
			while(rs.next())
			{
				int i = 1;
				String community = rs.getString(i++);
				Html t = (Html) _cache.get(community);
				if(t == null)
				{
					t = new Html(community);
					_cache.put(t.community,t);
				}
				t.style = rs.getInt(i++);
				t.day = rs.getInt(i++);
				t.hour = rs.getInt(i++);
				t.minute = rs.getInt(i++);
				t.nodes = rs.getString(i++);
				t.path = rs.getString(i++);
				t.ltime = db.getDate(i++);
				t.lnode = db.getInt(i++);
				if(t.nodes == null || t.nodes.length() < 1)
					t.nodes = "|";
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
		return DbAdapter.execute("SELECT COUNT(*) FROM Html WHERE 1=1" + sql);
	}

	public void set() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			int i = db.executeUpdate(0,"INSERT INTO Html(community,style,day,hour,minute,nodes,path,ltime,lnode)VALUES(" + DbAdapter.cite(community) + "," + style + "," + day + "," + hour + "," + minute + "," + DbAdapter.cite(nodes) + "," + DbAdapter.cite(path) + "," + DbAdapter.cite(ltime) + "," + lnode + ")");
			if(i < 1)
			{
				db.executeUpdate(0,"UPDATE Html SET community=" + DbAdapter.cite(community) + ",style=" + style + ",day=" + day + ",hour=" + hour + ",minute=" + minute + ",nodes=" + DbAdapter.cite(nodes) + ",path=" + DbAdapter.cite(path) + ",ltime=" + DbAdapter.cite(ltime) + ",lnode=" + lnode + " WHERE community=" + DbAdapter.cite(community));
			}
		} finally
		{
			db.close();
		}
//		c.remove(community);
	}

	public void delete() throws SQLException
	{
		DbAdapter.execute("DELETE FROM Html WHERE community=" + DbAdapter.cite(community));
		_cache.remove(community);
	}

	public void set(String f,String v) throws SQLException
	{
		DbAdapter.execute("UPDATE Html SET " + f + "=" + DbAdapter.cite(v) + " WHERE community=" + DbAdapter.cite(community));
		_cache.remove(community);
	}

	public void set(String f,Date v) throws SQLException
	{
		DbAdapter.execute("UPDATE Html SET " + f + "=" + DbAdapter.cite(v) + " WHERE community=" + DbAdapter.cite(community));
		_cache.remove(community);
	}

	public static void start()
	{
		new Thread()
		{
			public void run()
			{
				Thread.currentThread().setName("生成HTML");
				while(!isInterrupted() && Entity._cache != null)
				{
					try
					{
						Thread.sleep(1000 * 60);
					} catch(InterruptedException ex)
					{
						interrupt();
					}
					try
					{
						Iterator it = Html.find("",0,Integer.MAX_VALUE).iterator();
						while(it.hasNext())
						{
							Html t = (Html) it.next();
							Filex.logs("html.log","生成HTML " + t.community);
							Calendar c = Calendar.getInstance();
							String sql = " AND community=" + DbAdapter.cite(t.community) + " AND finished=1";
							final ArrayList al = new ArrayList();
							if(c.get(Calendar.HOUR_OF_DAY) == 1)
							{
								Enumeration e = Node.find(" AND n.type<2 AND n.finished=1 AND n.node IN(SELECT node FROM Listing)",0,Integer.MAX_VALUE);
								while(e.hasMoreElements())
								{
									int node = ((Integer) e.nextElement()).intValue();
									add(al,node);
								}
								Filex.logs("html.log","　附加：" + al.size());
							}
							sql += " AND ( n.node IN(" + t.nodes.substring(1).replace('|',',') + "0) OR n.updatetime>" + DbAdapter.cite(t.ltime) + ") ORDER BY n.node DESC";
							t.ltime = new Date(System.currentTimeMillis() - 60000); //向前返1分钟，防止同步造成的误差！
							Enumeration e = Node.find(sql,0,Integer.MAX_VALUE);
							while(e.hasMoreElements())
							{
								int node = ((Integer) e.nextElement()).intValue();
								Node n = Node.find(node);
								read(t.community,n._nNode,15);
								String[] arr = n.getPath().split("/");
								for(int j = 1;j < arr.length - 1;j++)
								{
									add(al,Integer.parseInt(arr[j]));
								}
							}
							Filex.logs("html.log","　数量：" + al.size() + "  语句：" + sql + "  时间：" + MT.f(t.ltime,1));
							for(int i = 0;i < al.size();i++)
							{
								read(t.community,((Integer) al.get(i)).intValue(),1);
							}
							t.set("ltime",t.ltime);
							Filex.logs("html.log","　结束");
						}
					} catch(Throwable ex)
					{
						Filex.logs("html.log",ex);
					}
				}
				Filex.logs("html.log","结束？？？　Entity._cache:" + Entity._cache);
			}
		}.start();
	}

	public static void read(String community,final int node,int page) throws InterruptedException,SQLException
	{
		long cur = System.currentTimeMillis() - 1000L * 60 * 60 * 24 * 3;
		String host = Community.find(community).webName;
		Filex.logs("html_" + host + ".log","host:" + host + "　node:" + node);
		try
		{
			int lang = License.getInstance().getWebLanguages();
			for(int i = 0;i < 10;i++)
			{
				if((lang & 1 << i) == 0)
					continue;
//				String path = Html.getPath(community) + "/" + node / 10000 + "/" + node + "-0" + i + ".htm";
//				File f = new File(path + ".gz");
//				if(!f.exists())
//					f = new File(path);
//				if(f.lastModified() > cur)
//					continue;
				for(int j = 1;j <= page;j++)
				{
					Filex.logs("html_" + host + ".log","　lang:" + i + "　page:" + j);
					String htm = (String) Http.open("http://" + host + "/servlet/Node?node=" + node + "&language=" + i + "&pos=" + j,null);
					if(j == 1 && page > 1)
					{
						int s = htm.indexOf("<!--{total:") + 11;
						if(s < 100)
							break;
						page = Math.min(page,Integer.parseInt(htm.substring(s,htm.indexOf('}',s))));
						Filex.logs("html_" + host + ".log","　total:" + page);
					}
				}
			}
			//删除分页
//            File f = new File(Html.getPath(community) + "/" + node / 10000 + "/pos/");
//            if(f.exists())
//            {
//                File[] fs = f.listFiles(new FilenameFilter()
//                {
//                    public boolean accept(File dir,String name)
//                    {
//                        return name.startsWith(node + "-");
//                    }
//                });
//                for(int i = 0;i < fs.length;i++)
//                    fs[i].delete();
//            }
		} catch(Throwable ex)
		{
			Filex.logs("html_" + host + ".log",ex);
			Thread.sleep(1000);
		}
	}


	private static void add(ArrayList al,int node)
	{
		if(al.indexOf(node) != -1)
			return;
		al.add(node);
	}

	public static void start(final int th) throws SQLException,InterruptedException
	{
		for(int i = 0;i < th;i++)
		{
			final int j = i;
			Filex.logs("html_" + j + ".txt","启动");
			new Thread()
			{
				public void run()
				{
					try
					{
						Iterator it = Html.find("",0,Integer.MAX_VALUE).iterator();
						while(it.hasNext())
						{
							Html t = (Html) it.next();
							String sql = " AND community=" + DbAdapter.cite(t.community) + " AND " + DbAdapter.mod("node",String.valueOf(th)) + "=" + j + " AND hidden=0 AND finished=1 AND " + DbAdapter.bitand("options",0x1000) + "=0";
							int count = 0,sum = Node.count(sql);
							sql += " ORDER BY node";
							while(Calendar.getInstance().get(Calendar.HOUR_OF_DAY) < 8)
							{
								Enumeration e = Node.find(" AND node>" + t.lnode + sql,0,100);
								if(!e.hasMoreElements())
								{
									t.lnode = 0;
									Filex.logs("html_" + j + ".txt","　完成");
									break;
								} while(e.hasMoreElements())
								{
									t.lnode = (Integer) e.nextElement();
									Filex.logs("html_" + j + ".txt","　节点:" + t.lnode + " 数量:" + (++count) + "/" + sum + " 时间:" + Calendar.getInstance().get(Calendar.HOUR_OF_DAY));
									read(t.community,t.lnode,Integer.MAX_VALUE);
								}
							}
							t.set("lnode",String.valueOf(t.lnode));
						}
					} catch(Throwable ex)
					{
						Filex.logs("html_" + j + ".txt",ex);
					}
					Filex.logs("html_" + j + ".txt","　结束");
				}
			}.start();
			Thread.sleep(5000);
		}
	}

	public static void main(String[] args) throws Exception
	{
//		ArrayList e = Node.find1("",0,1,Integer.MAX_VALUE);
//		for(int i = 0;i < e.size();i++)
//		{
//			Node n = (Node) e.get(i);
//			System.out.println(i + "、" + n._nNode);
//			read(n.getCommunity(),n._nNode,true);
//		}
//		System.out.println("OK");
	}
}
