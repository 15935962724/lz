package tea.entity.yl.shop;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import tea.entity.Cache;
import tea.entity.DbAdapter;
import tea.entity.Seq;

/**
 * 玉器商家
 * @author Administrator
 *
 */
public class YuShop {
	protected static Cache c = new Cache(50);
	public int sid;
	public String scode;//生成的编号
	public String sname;//店名
	public String slogo;//logo图片
	public String scontext;//介绍
	public int deleted;//0 为删  1删除
	public String phone;//电话
	public String contacts;//联系人
	public String address;//地址

	public YuShop(int sid){
		this.sid = sid;
	}

	public static ArrayList find(String sql, int pos, int size) throws SQLException
	   {
	     ArrayList al = new ArrayList();
	     DbAdapter db = new DbAdapter();
	     try
	     {
	       ResultSet rs = db.executeQuery("SELECT [sid],[scode],[sname],[slogo],[scontext],phone,contacts,address FROM [yushop] WHERE deleted = 0 " + sql, pos, size);
	       while (rs.next())
	       {
	         int i = 1;
	         YuShop t = new YuShop(rs.getInt(i++));
	         t.scode = rs.getString(i++);
						t.sname = rs.getString(i++);
						t.slogo = rs.getString(i++);
						t.scontext = rs.getString(i++);
						t.phone = rs.getString(i++);
						t.contacts = rs.getString(i++);
						t.address = rs.getString(i++);
	         c.put(Integer.valueOf(t.sid), t);
	         al.add(t);
	       }
	       rs.close();
	     }
	     finally {
	       db.close();
	     }
	     return al;
	   }

	public static int count(String sql) throws SQLException
	   {
	     return DbAdapter.execute("SELECT COUNT(*) FROM [yushop] WHERE deleted = 0 " + sql);
	   }

	public void set() throws SQLException
	   {
	     DbAdapter db = new DbAdapter();
	     int seq = Seq.get();
	     String code = Seq.get("idd")+"";
	     int clength = code.length();
	     if(clength==1){
	    	 code = "y00"+code;
	     }else if(clength==2){
	    	 code = "y0"+code;
	     }else if(clength==3){
	    	 code = "y"+code;
	     }
	     try
	     {
	       if (this.sid < 1)
	       {
	         db.executeUpdate("INSERT INTO [yushop] ([sid],[scode],[sname],[slogo],[scontext],[deleted],phone,contacts,address) VALUES("+seq+","+DbAdapter.cite(code)+","+DbAdapter.cite(sname)+","+DbAdapter.cite(slogo)+","+DbAdapter.cite(scontext)+",0,"+DbAdapter.cite(phone)+","+DbAdapter.cite(contacts)+","+DbAdapter.cite(address)+")");

	         ResultSet rs = db.executeQuery("SELECT MAX(sid) FROM [yushop] WHERE sid=" + this.sid);
	         this.sid = (rs.next() ? rs.getInt(1) : 0);
	         rs.close();
	       } else {
	         db.executeUpdate("UPDATE [yushop] SET [scode] = "+DbAdapter.cite(scode)+",[sname] = "+DbAdapter.cite(sname)+",[slogo] = "+DbAdapter.cite(slogo)+",[scontext] = "+DbAdapter.cite(scontext)+",[deleted] = "+deleted+",phone="+DbAdapter.cite(phone)+",contacts="+DbAdapter.cite(contacts)+",address="+DbAdapter.cite(address)+" WHERE sid="+sid);
	       }
	     }
	     finally
	     {
	       db.close();
	     }
	     c.remove(Integer.valueOf(this.sid));
	   }
	public void delete() throws SQLException
	   {
             DbAdapter db = new DbAdapter();
             try
             {
                 db.executeUpdate(sid, "update yushop set deleted = 1 where sid = " + this.sid);
             } finally
             {
                 db.close();
             }
	     c.remove(Integer.valueOf(this.sid));
	   }
	public void set(String f, String v) throws SQLException
	   {
             DbAdapter db = new DbAdapter();
             try
             {
                 db.executeUpdate(sid, "UPDATE yushop SET " + f + "=" + DbAdapter.cite(v) + " WHERE sid=" + this.sid);
             } finally
             {
                 db.close();
             }
	     c.remove(Integer.valueOf(this.sid));
	   }
	public static YuShop find(int sid) throws SQLException
	   {
		YuShop t = (YuShop)c.get(Integer.valueOf(sid));
	     if (t == null)
	     {
	       ArrayList al = find(" AND sid=" + sid, 0, 1);
	       t = al.size() < 1 ? new YuShop(sid) : (YuShop)al.get(0);
	     }
	     return t;
	   }
}
