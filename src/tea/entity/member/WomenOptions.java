/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package tea.entity.member;
import java.io.IOException;
import java.sql.SQLException;
import java.util.*;

import tea.db.DbAdapter;
import tea.entity.Entity;
import tea.entity.Filex;
import tea.entity.Http;
import tea.entity.sup.SupQualification;
public class WomenOptions extends Entity {
    public int woid;
    private String woname;
    private int type;
    private String community;
    private Date times;

    private int wotype;// 具体什么类型  1 活动类型， 2 酒店类型,3 球队

    private int language;

    private boolean exists;

    /**
     * 增加 活动类型(英文)
     */
    private String wonameen;
    public WomenOptions (int woid,int language)throws SQLException
    {
        this.woid = woid;
        this.language = language;
        load();
    }
    public static WomenOptions find(int woid,int language)throws SQLException
    {
        return new WomenOptions(woid,language);
    }
    public static List findByTpyeAndLan(int wotype,int language)throws SQLException
    {
    	List vt = new ArrayList();
    	String locSql = null;
		if(language ==0){
			locSql = "select woid,wonameen,type from WomenOptions where wonameen is not null and wotype = "+wotype+" order by woid";
		}else if(language ==1){
			locSql = "select woid,woname,type from WomenOptions where woname is not null and wotype = "+wotype+" order by woid";
		}else{
			locSql = "select woid,woname,type from WomenOptions where woname is not null and wotype = "+wotype+" order by woid";
		}
		System.out.print(locSql);
		DbAdapter db = new DbAdapter();
		try{
			db.executeQuery(locSql);
			while (db.next()) {
				List ls = new ArrayList();
				ls.add(db.getString(1));
				ls.add(db.getString(2));
				ls.add(db.getString(3));
				vt.add(ls);
			}
		}finally{
			db.close();
		}
		return vt;
    }

    public static List findByTpyeAndLan(int type,int wotype,int language)throws SQLException
    {
    	List vt = new ArrayList();
    	String locSql = null;
		if(language ==0){
			locSql = "select woid,wonameen,type from WomenOptions where wonameen is not null and wotype = "+wotype+" and type = "+type+" order by woid";
		}else if(language ==1){
			locSql = "select woid,woname,type from WomenOptions where woname is not null and wotype = "+wotype+" and type = "+type+" order by woid";
		}else{
			locSql = "select woid,woname,type from WomenOptions where woname is not null and wotype = "+wotype+" and type = "+type+" order by woid";
		}
		System.out.print(locSql);
		DbAdapter db = new DbAdapter();
		try{
			db.executeQuery(locSql);
			while (db.next()) {
				List ls = new ArrayList();
				ls.add(db.getString(1));
				ls.add(db.getString(2));
				ls.add(db.getString(3));
				vt.add(ls);
			}
		}finally{
			db.close();
		}
		return vt;
    }
    private void load()throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT woname,type,community,times,wotype,wonameen FROM WomenOptions WHERE woid = "+woid+" and language="+language);
            if(db.next())
            {
                woname = db.getString(1);
                type=db.getInt(2);
                community =db.getString(3);
                times =db.getDate(4);
                wotype=db.getInt(5);
                wonameen = db.getString(6);
                exists=true;
            }else
            {
                exists = false;
            }
        }finally
        {
            db.close();
        }
    }

    public static int create(String woname, int type, String community,int wotype,int language) throws SQLException {

        DbAdapter db = new DbAdapter();
        int i = 0;
        try {
            db.executeUpdate("INSERT INTO WomenOptions (woname,type,community,times,wotype,language)VALUES(" + DbAdapter.cite(woname) + "," + type + "," + DbAdapter.cite(community) + "," +
            		" " + DbAdapter.cite(new Date()) + ","+wotype+" ,"+language+")");
            i = db.getInt("SELECT MAX(woid) FROM WomenOptions where language ="+language);
        } finally {
            db.close();
        }
        return i;
    }
    /**
     * 增加 活动类型(英文)
     * @param woname
     * @param wonameen
     * @param type
     * @param community
     * @param wotype
     * @param language
     * @return
     * @throws SQLException
     * create by wanfeng zhou
     */
    public static int create(String woname,String wonameen, int type, String community,int wotype,int language) throws SQLException {

        DbAdapter db = new DbAdapter();
        int i = 0;
        try {
            db.executeUpdate("INSERT INTO WomenOptions (woname,wonameen,type,community,times,wotype,language)VALUES(" + DbAdapter.cite(woname) + ","+DbAdapter.cite(wonameen)+"," + type + "," + DbAdapter.cite(community) + "," +
            		" " + DbAdapter.cite(new Date()) + ","+wotype+" ,"+language+")");
            i = db.getInt("SELECT MAX(woid) FROM WomenOptions where language ="+language);
        } finally {
            db.close();
        }
        return i;
    }
    public void set(String woname, int type) throws SQLException {
        DbAdapter db = new DbAdapter();
        try {
            db.executeUpdate("UPDATE WomenOptions SET woname=" + DbAdapter.cite(woname) + ",type=" + type + " WHERE woid=" + woid+" and language="+language);
        } finally {
            db.close();
        }
    }
    /**
     * 增加 活动类型(英文)
     * @param woname
     * @param type
     * @throws SQLException
     * by wanfeng zhou
     */
    public void set(String woname,String wonameen,int type) throws SQLException {
        DbAdapter db = new DbAdapter();
        try {
            db.executeUpdate("UPDATE WomenOptions SET woname=" + DbAdapter.cite(woname) + ",wonameen="+DbAdapter.cite(wonameen)+",type=" + type + " WHERE woid=" + woid+" and language="+language);
        } finally {
            db.close();
        }
    }
     public static Enumeration find(String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT woid FROM WomenOptions WHERE 1=1"+ sql,pos,size);
            while(db.next())
            {
                v.addElement(new Integer(db.getInt(1)));
            }

        } finally
        {
            db.close();
        }
        return v.elements();
    }
    public void delete() throws SQLException {
        DbAdapter db = new DbAdapter();
        try {
            db.executeUpdate("DELETE FROM  WomenOptions WHERE woid = "+woid +" and language="+language);
            db.executeUpdate("DELETE FROM  WomenOptions WHERE type=  " + woid+" and language="+language);
        } finally {
            db.close();
        }
    }

    public static int getWoid(String community,String wname,String sql,int language)throws SQLException
    {
    	int w = 0;
    	java.util.Enumeration e = WomenOptions.find(sql,0,Integer.MAX_VALUE);
	        while(e.hasMoreElements())
	       {
	            int wid = ((Integer)e.nextElement()).intValue();

	            WomenOptions obj = WomenOptions.find(wid,language);

	            if(obj.getWoname().equals(wname))
	            {
	            	w = wid;
	            	continue;
	            }
	       }
	        return w;

    }

    public static int count(String community,int language, String sql) throws SQLException {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try {
            db.executeQuery("SELECT COUNT(woid) FROM WomenOptions  WHERE language = "+language + sql);
            if (db.next()) {
                count = db.getInt(1);
            }
        } finally {
            db.close();
        }
        return count;
    }

    public String getCommunity() {
        return community;
    }

    public boolean isExists() {
        return exists;
    }

    public Date getTimes() {
        return times;
    }

    public int getType() {
        return type;
    }

    public String getWoname() {
        return woname;
    }
    public int getWotype()
    {
    	return wotype;
    }
	public String getWonameen() {
		return wonameen;
	}
	public void setWonameen(String wonameen) {
		this.wonameen = wonameen;
	}




}
