package tea.entity.copyright;

import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

public class Crzzba extends Entity
{
    public static Cache _cache = new Cache(100);
    private int crzzba;
    private String community;
    private String zzxm; // 作者名称
    private String zzbm; // 作者笔名
    private String zzjj; // 作者简介
    private String zzsfzh; // 身份证号
    private String zzdz; // 地 址
    private String zzyb; // 邮编
    private String zzdh; // 电话
    private String zzsj; // 移动电话
    private String zzdzyj; // 电子邮件
    private String zzczfw; // 创作范围
    private boolean zzht; // 寄送合同
    private String zzfy; // 附言
    private boolean zzqy;
    private String zzpy; // 名称拼音

    public Crzzba(int crzzba) throws SQLException
    {
        this.crzzba = crzzba;
        load();
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT community,zzxm,zzbm,zzjj,zzsfzh,zzdz,zzyb,zzdh,zzsj,zzdzyj,zzczfw,zzht,zzfy,zzqy,zzpy FROM crzzba WHERE crzzba=" + crzzba);
            if(db.next())
            {
                community = db.getString(1);
                zzxm = db.getString(2);
                zzbm = db.getString(3);
                zzjj = db.getString(4);
                zzsfzh = db.getString(5);
                zzdz = db.getString(6);
                zzyb = db.getString(7);
                zzdh = db.getString(8);
                zzsj = db.getString(9);
                zzdzyj = db.getString(10);
                zzczfw = db.getString(11);
                zzht = db.getInt(12) != 0;
                zzfy = db.getString(13);
                zzqy = db.getInt(14) != 0;
                zzpy = db.getString(15);
            }
        } finally
        {
            db.close();
        }
    }

    public static void create(String community,String zzxm,String zzbm,String zzjj,String zzsfzh,String zzdz,String zzyb,String zzdh,String zzsj,String zzdzyj,String zzczfw,boolean zzht,
                              String zzfy,boolean zzqy,String zzpy) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO crzzba(community,zzxm,zzbm,zzjj,zzsfzh,zzdz,zzyb,zzdh,zzsj,zzdzyj,zzczfw,zzht,zzfy,zzqy,zzpy)VALUES(" + DbAdapter.cite(community) + "," + DbAdapter.cite(zzxm) + ","
                             + DbAdapter.cite(zzbm) + "," + DbAdapter.cite(zzjj) + "," + DbAdapter.cite(zzsfzh) + "," + DbAdapter.cite(zzdz) + "," + DbAdapter.cite(zzyb) + "," + DbAdapter.cite(zzdh) + "," + DbAdapter.cite(zzsj) + "," + DbAdapter.cite(zzdzyj) + ","
                             + DbAdapter.cite(zzczfw) + "," + DbAdapter.cite(zzht) + "," + DbAdapter.cite(zzfy) + "," + DbAdapter.cite(zzqy) + "," + DbAdapter.cite(zzpy) + ")");
        } finally
        {
            db.close();
        }
    }

    public void set(String zzxm,String zzbm,String zzjj,String zzsfzh,String zzdz,String zzyb,String zzdh,String zzsj,String zzdzyj,String zzczfw,boolean zzht,String zzfy,boolean zzqy,
                    String zzpy) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE crzzba SET zzxm=" + DbAdapter.cite(zzxm) + ",zzbm=" + DbAdapter.cite(zzbm) + ",zzjj=" + DbAdapter.cite(zzjj) + ",zzsfzh=" + DbAdapter.cite(zzsfzh) + ",zzdz=" + DbAdapter.cite(zzdz) + ",zzyb="
                             + DbAdapter.cite(zzyb) + ",zzdh=" + DbAdapter.cite(zzdh) + ",zzsj=" + DbAdapter.cite(zzsj) + ",zzdzyj=" + DbAdapter.cite(zzdzyj) + ",zzczfw=" + DbAdapter.cite(zzczfw) + ",zzht=" + DbAdapter.cite(zzht) + ",zzfy="
                             + DbAdapter.cite(zzfy) + ",zzqy=" + DbAdapter.cite(zzqy) + ",zzpy=" + DbAdapter.cite(zzpy) + " WHERE crzzba=" + crzzba);
        } finally
        {
            db.close();
        }
        this.zzxm = zzxm;
        this.zzbm = zzbm;
        this.zzjj = zzjj;
        this.zzsfzh = zzsfzh;
        this.zzdz = zzdz;
        this.zzyb = zzyb;
        this.zzdh = zzdh;
        this.zzsj = zzsj;
        this.zzdzyj = zzdzyj;
        this.zzczfw = zzczfw;
        this.zzht = zzht;
        this.zzfy = zzfy;
        this.zzqy = zzqy;
        this.zzpy = zzpy;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM crzzba WHERE crzzba=" + crzzba);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(crzzba));
    }

    public int getCrzzba()
    {
        return crzzba;
    }

    public String getZzyb()
    {
        return zzyb;
    }

    public String getZzxm()
    {
        return zzxm;
    }

    public String getZzsj()
    {
        return zzsj;
    }

    public String getZzpy()
    {
        return zzpy;
    }

    public String getZzjj()
    {
        return zzjj;
    }

    public boolean isZzht()
    {
        return zzht;
    }

    public String getZzfy()
    {
        return zzfy;
    }

    public String getZzdzyj()
    {
        return zzdzyj;
    }

    public String getZzdz()
    {
        return zzdz;
    }

    public String getZzdh()
    {
        return zzdh;
    }

    public String getZzczfw()
    {
        return zzczfw;
    }

    public String getZzbm()
    {
        return zzbm;
    }

    public String getZzsfzh()
    {
        return zzsfzh;
    }

    public boolean isZzqy()
    {
        return zzqy;
    }

    public static Crzzba find(int crzzba) throws SQLException
    {
        Crzzba obj = (Crzzba) _cache.get(new Integer(crzzba));
        if(obj == null)
        {
            obj = new Crzzba(crzzba);
            _cache.put(new Integer(crzzba),obj);
        }
        return obj;
    }

    public static int count(String community,String sql) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(crzzba) FROM crzzba WHERE community=" + DbAdapter.cite(community) + sql);
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

    public static Enumeration find(String community,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT crzzba FROM crzzba WHERE community=" + DbAdapter.cite(community) + sql,pos,size);
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
}
