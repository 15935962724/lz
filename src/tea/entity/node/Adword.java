package tea.entity.node;

import tea.db.DbAdapter;
import tea.entity.*;
import java.math.BigDecimal;
import java.util.*;
import java.sql.SQLException;

public class Adword extends Entity
{
    private static Cache _cache = new Cache(100);

    public static final String STATUS_TYPE[] =
            {"未完成","正常","暂停","已删除"};

    public static final String LANGUAGE_TYPE[][] =
            {
            {"en","英语"},
            {"zh_CN","中文（简体）"},
            {"zh_TW","中文（繁体）"},
            {"pl","波兰语"},
            {"da","丹麦语"},
            {"de","德语"},
            {"ru","俄语"},
            {"fr","法语"},
            {"fi","芬兰语"},
            {"ko","韩语"},
            {"nl","荷兰语"},
            {"no","挪威语"},
            {"ja","日语"},
            {"sv","瑞典语"},
            {"tr","土耳其语"},
            {"es","西班牙语"},
            {"iw","希伯来语"},
            {"it","意大利语"},
            {"ar","阿拉伯语"},
            {"et","爱沙尼亚语"},
            {"bg","保加利亚语"},
            {"hi","北印度语"},
            {"is","冰岛语"},
            {"pl","波兰语"},
            {"da","丹麦语"},
            {"de","德语"},
            {"ru","俄语"},
            {"fr","法语"},
            {"fi","芬兰语"},
            {"ko","韩语"},
            {"nl","荷兰语"},
            {"ca","加泰罗尼亚语"},
            {"cs","捷克语"},
            {"hr","克罗地亚语"},
            {"lv","拉脱维亚语"},
            {"lt","立陶宛语"},
            {"ro","罗马尼亚语"},
            {"no","挪威语"},
            {"pt","葡萄牙语"},
            {"ja","日语"},
            {"sv","瑞典语"},
            {"sr","塞尔维亚语"},
            {"sk","斯洛伐克语"},
            {"sl","斯洛维尼亚语"},
            {"tl","塔加路语"},
            {"th","泰语"},
            {"tr","土耳其语"},
            {"ur","乌尔都语"},
            {"uk","乌克兰语"},
            {"es","西班牙语"},
            {"iw","希伯来语"},
            {"el","希腊语"},
            {"hu","匈牙利语"},
            {"it","意大利语"},
            {"id","印度尼西亚语"},
            {"vi","越南语"}
    };

    private int adword;

    private String member;

    private int status;

    private String name;

    private String region;

    private String language;

    private String adtitle;

    private String adexplain1;

    private String adexplain2;

    private String adshow;

    private String adurl;

    private String adpic;

    private String keyworlds;

    private String text;

    private BigDecimal budget;

    private BigDecimal bid;

    private int hits;

    private int click;

    private BigDecimal outlay;

    private Date time;

    private Date stoptime;

    public Adword(int adword) throws SQLException
    {
        this.adword = adword;
        load();
    }

    public static Adword find(int adword) throws SQLException
    {
        Adword obj = (Adword) _cache.get(new Integer(adword));
        if(obj == null)
        {
            obj = new Adword(adword);
            _cache.put(new Integer(adword),obj);
        }
        return obj;
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT member,status,name,region,language,adtitle,adexplain1,adexplain2,adshow,adurl,adpic,keyworlds,budget,bid,hits,click,outlay,time,stoptime FROM adword WHERE adword=" + adword);
            if(db.next())
            {
                member = db.getString(1);
                status = db.getInt(2);
                name = db.getString(3);
                region = db.getString(4);
                language = db.getString(5);
                adtitle = db.getString(6);
                adexplain1 = db.getString(7);
                adexplain2 = db.getString(8);
                adshow = db.getString(9);
                adurl = db.getString(10);
                adpic = db.getString(11);
                keyworlds = db.getString(12);
                budget = db.getBigDecimal(13,2);
                bid = db.getBigDecimal(14,2);
                hits = db.getInt(15);
                click = db.getInt(16);
                outlay = db.getBigDecimal(17,2);
                time = db.getDate(18);
                stoptime = db.getDate(19);
            }
        } finally
        {
            db.close();
        }
        if(outlay == null)
        {
            outlay = new BigDecimal("0");
        }
    }

    public static int create(String member,String name) throws SQLException
    {
        int i1 = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO adword (member,status,name,time)VALUES(" + DbAdapter.cite(member) + ",0," + DbAdapter.cite(name) + "," + db.citeCurTime() + ")");
            i1 = db.getInt("SELECT MAX(adword) FROM adword");
        } finally
        {
            db.close();
        }
        return i1;
    }

    public void setName(String name) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE adword SET name=" + DbAdapter.cite(name) + " WHERE adword=" + adword);
        } finally
        {
            db.close();
        }
        this.name = name;
    }

    public void setTarget(String region,String language) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE adword SET region=" + DbAdapter.cite(region) + ",language=" + DbAdapter.cite(language) + " WHERE adword=" + adword);
        } finally
        {
            db.close();
        }
        this.region = region;
        this.language = language;
    }

    public void set(String adtitle,String adexplain1,String adexplain2,String adshow,String adurl,String adpic) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        StringBuilder sql = new StringBuilder();
        sql.append("UPDATE adword SET adtitle=").append(DbAdapter.cite(adtitle));
        sql.append(",adexplain1=").append(DbAdapter.cite(adexplain1));
        sql.append(",adexplain2=").append(DbAdapter.cite(adexplain2));
        sql.append(",adshow=").append(DbAdapter.cite(adshow));
        sql.append(",adurl=").append(DbAdapter.cite(adurl));
        if(adpic != null)
        {
            sql.append(",adpic=").append(DbAdapter.cite(adpic));
            this.adpic = adpic;
        }
        sql.append(" WHERE adword=").append(adword);
        try
        {
            db.executeUpdate(sql.toString());
        } finally
        {
            db.close();
        }
        this.adtitle = adtitle;
        this.adexplain1 = adexplain1;
        this.adexplain2 = adexplain2;
        this.adshow = adshow;
        this.adurl = adurl;
    }

    public void setKeyworlds(String keyworlds) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE adword SET keyworlds=" + DbAdapter.cite(keyworlds) + " WHERE adword=" + adword);
        } finally
        {
            db.close();
        }
        this.keyworlds = keyworlds;
    }

    public void set(BigDecimal budget,BigDecimal bid,Date stoptime) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE adword SET budget=" + budget + ",bid=" + bid + ",stoptime=" + DbAdapter.cite(stoptime) + " WHERE adword=" + adword);
        } finally
        {
            db.close();
        }
        this.budget = budget;
        this.bid = bid;
        this.stoptime = stoptime;
    }

    public static Enumeration find(String member,String sql,int pos,int size) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT adword FROM adword WHERE member=" + DbAdapter.cite(member) + sql,pos,size);
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

    public static Enumeration find(String q,String region,String language) throws SQLException
    {
        Vector vector = new Vector();
        // DISTINCT
        StringBuilder sql = new StringBuilder("SELECT a.adword FROM adword a WHERE bid IS NOT NULL ");
        // 状态
        sql.append(" AND a.status=1");
        // 地区
        sql.append(" AND ( a.region='/' OR a.region LIKE " + DbAdapter.cite("%/" + region + "/%") + ")");
        // 语言
        sql.append(" AND ( a.language='/' OR a.language LIKE " + DbAdapter.cite("%/" + language + "/%") + ")");
        // 关键字
        sql.append(" AND a.keyworlds LIKE " + DbAdapter.cite("%" + q + "%"));
        // 预算
        // sql.append(" AND a.budget<()"));
        //
        sql.append(" ORDER BY bid DESC");
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery(sql.toString());
            for(int k = 0;k < 10 && db.next();k++)
            {
                vector.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static int count(String member,String sql) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(adword) FROM adword WHERE member=" + DbAdapter.cite(member) + sql);
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

    public BigDecimal getOutlay()
    {
        return outlay;
    }

    public void setClick() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE adword SET click=click+1,outlay=outlay+bid WHERE adword=" + adword);
        } finally
        {
            db.close();
        }
        this.click++;
        this.outlay = outlay.add(bid);
    }

    public String getAdexplain1()
    {
        return adexplain1;
    }

    public String getAdexplain2()
    {
        return adexplain2;
    }

    public String getAdpic()
    {
        return adpic;
    }

    public String getAdshow()
    {
        return adshow;
    }

    public String getAdtitle()
    {
        return adtitle;
    }

    public String getAdurl()
    {
        return adurl;
    }

    public int getAdword()
    {
        return adword;
    }

    public BigDecimal getBid()
    {
        return bid;
    }

    public BigDecimal getBudget()
    {
        return budget;
    }

    public int getClick()
    {
        return click;
    }

    public int getHits()
    {
        return hits;
    }

    public String getKeyworlds()
    {
        return keyworlds;
    }

    public String getMember()
    {
        return member;
    }

    public String getRegion()
    {
        return region;
    }

    public int getStatus()
    {
        return status;
    }

    public String getName()
    {
        return name;
    }

    public String getText()
    {
        return text;
    }

    public Date getTime()
    {
        return time;
    }

    public Date getStoptime()
    {
        return stoptime;
    }

    public String getStoptimeToString()
    {
        return sdf.format(stoptime);
    }

    public String getLanguage()
    {
        return language;
    }

    public void setStatus(int status) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE adword SET status=" + status + " WHERE adword=" + adword);
        } finally
        {
            db.close();
        }
        this.status = status;
    }

    public void setHits() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE adword SET hits=hits+1 WHERE adword=" + adword);
        } finally
        {
            db.close();
        }
        this.hits++;
    }
}
