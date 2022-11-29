package tea.entity.node;

import java.sql.SQLException;
import java.util.Date;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Vector;

import tea.db.DbAdapter;
import tea.entity.*;
import tea.html.Anchor;
import tea.resource.Resource;

public class Talkback extends Entity
{
    public static Cache _cache = new Cache(100);
    private Hashtable _htLayer;
    public static final int TALKBACKS_UNREAD = 0;
    public static final int TALKBACKS_READ = 1;
    private int talkback;
    private int _nNode;
    private RV _rv;
    public int country; //国家
    private Date _time;
    private int _nHint;
    private int _nStatus;
    private int _nLanguage;
    private int hidden; //0 未审核，1，已审核，2, 已拒绝
    private String ip;

    private String auditmember; //审核人员
    private Date audittime; //审核时间

    public static final String HIDDEN_TYPE[] =
            {"未审核","已审核","已拒绝"};


    class Layer
    {
        public Layer()
        {
        }

        public String name; //姓名
        public String address; //地址
        public String zip; //邮编
        public String telephone; //联系电话
        public String email;
        public String _strSubject;
        public String _strFileName;
        public String _strContent;
        private String _strPicture;
        private String _strVoice;
        private String _strFile;
    }


    public static Talkback find(int talkback) throws SQLException
    {
        Talkback t = (Talkback) _cache.get(new Integer(talkback));
        if(t == null)
        {
            t = new Talkback(talkback);
            _cache.put(new Integer(talkback),t);
        }
        return t;
    }

    private Talkback(int talkback) throws SQLException
    {
        this.talkback = talkback;
        _htLayer = new Hashtable();
        load();
    }

    public String getFileName(int i) throws SQLException
    {
        return getLayer(i)._strSubject;
    }

    private Layer getLayer(int j) throws SQLException
    {
        Layer layer = (Layer) _htLayer.get(new Integer(j));
        if(layer == null)
        {
            layer = new Layer();
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT subject,name,address,zip,telephone,email,filename,picture,voice,filedata FROM Talkback WHERE talkback=" + talkback);
                if(db.next())
                {
                    layer._strSubject = db.getVarchar(j,_nLanguage,1);
                    layer.name = db.getVarchar(j,_nLanguage,2);
                    layer.address = db.getVarchar(j,_nLanguage,3);
                    layer.zip = db.getVarchar(j,_nLanguage,4);
                    layer.telephone = db.getVarchar(j,_nLanguage,5);
                    layer.email = db.getVarchar(j,_nLanguage,6);
                    layer._strFileName = db.getVarchar(j,_nLanguage,7);
                    layer._strPicture = db.getString(8);
                    layer._strVoice = db.getString(9);
                    layer._strFile = db.getString(10);
                }
            } finally
            {
                db.close();
            }
            _htLayer.put(new Integer(j),layer);
        }
        return layer;
    }

    public String getSubject(int i) throws SQLException
    {
        return getLayer(i)._strSubject;
    }

    public String getContent(int i) throws SQLException
    {
        Layer layer = getLayer(i);
        if(layer._strContent == null)
        {
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT content FROM Talkback WHERE talkback=" + talkback);
                if(db.next())
                {
                    layer._strContent = db.getText(i,_nLanguage,1);
                }
            } finally
            {
                db.close();
            }
        }
        return layer._strContent; // Translator.getInstance().translate(_strContent, _nLanguage, i);
    }


    public int getNode()
    {
        return _nNode;
    }

    public void read() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(talkback,"UPDATE Talkback SET status=1 WHERE talkback=" + talkback + " AND status=" + 0);
        } finally
        {
            db.close();
        }
    }

    public int findNext() throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT talkback FROM Talkback WHERE node=" + _nNode + " AND talkback>" + talkback + " ORDER BY talkback ");
            if(db.next())
            {
                i = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return i;
    }

    public Date getTime()
    {
        return _time;
    }

    public String getTimeToString()
    {
        return sdf2.format(_time);
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node, rmember, vmember, time, hint,country, status, hidden,ip,language,auditmember,audittime FROM Talkback WHERE talkback=" + talkback);
            if(db.next())
            {
                int j = 1;
                _nNode = db.getInt(j++);
                _rv = new RV(db.getString(j++),db.getString(j++));
                _time = db.getDate(j++);
                _nHint = db.getInt(j++);
                country = db.getInt(j++);
                _nStatus = db.getInt(j++);
                hidden = db.getInt(j++);
                ip = db.getString(j++);
                _nLanguage = db.getInt(j++);
                auditmember = db.getString(j++);
                audittime = db.getDate(j++);
            }
        } finally
        {
            db.close();
        }
    }

    public int findPrev() throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT talkback FROM Talkback  WHERE node=" + _nNode + " AND talkback<" + talkback + " ORDER BY talkback DESC ");
            if(db.next())
            {
                i = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return i;
    }

    public boolean isCreator(RV rv)
    {
        return _rv._strR.equals(rv._strR);
    }

    public int getStatus()
    {
        return _nStatus;
    }

    public static Enumeration findEdNodes(RV rv,int i,int j) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT DISTINCT n.node " + getEdNodesSql(rv),i,j);
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

    public static Enumeration findEdNodes2(RV rv,int i,int j) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT DISTINCT t.talkback " + getEdNodesSql(rv));
            for(int k = 0;k < i + j && db.next();k++)
            {
                if(k >= i)
                {
                    vector.addElement(new Integer(db.getInt(1)));
                }
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static Enumeration findEdNodes3(RV rv,int i,int j) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT DISTINCT t.talkback " + getEdNodesSql1(rv));
            for(int k = 0;k < i + j && db.next();k++)
            {
                if(k >= i)
                {
                    vector.addElement(new Integer(db.getInt(1)));
                }
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static String fHostel(int node) throws SQLException
    {
        String hn = "";
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select name from hostel where node=" + node);
            while(db.next())
            {
                hn = db.getString(1);
            }
        } finally
        {
            db.close();
        }
        return hn;
    }


    public void set(int _nHint,int country,int language,String s,String s1,String picture,String voice,String file,String filename) throws SQLException
    {
        StringBuilder sql = new StringBuilder("UPDATE Talkback SET hint=" + _nHint + ",country=" + country + ",language=" + language + ",subject=" + DbAdapter.cite(s) + ",content=" + DbAdapter.cite(s1));
        if(picture != null)
        {
            sql.append(",picture=").append(DbAdapter.cite(picture));
        }
        if(voice != null)
        {
            sql.append(",voice=").append(DbAdapter.cite(voice));
        }
        if(file != null)
        {
            sql.append(",filedata=").append(DbAdapter.cite(file)).append(",filename=").append(DbAdapter.cite(filename));
        }
        sql.append(" WHERE talkback=").append(talkback);
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(talkback,sql.toString());
        } finally
        {
            db.close();
        }
        this._nHint = _nHint;
        this.country = country;
        this._nLanguage = language;
        _htLayer.clear();
        // _cache.remove(new Integer(talkback));
    }

    public void set(String auditmember,Date audittime) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(talkback,"UPDATE Talkback SET auditmember=" + db.cite(auditmember) + " , audittime=" + db.cite(audittime) + " WHERE talkback= " + talkback);
        } finally
        {
            db.close();
        }
        this.auditmember = auditmember;
        this.audittime = audittime;
        _htLayer.clear();
    }

    public static int create(int node,RV rv,int hint,int country,int hidden,String ip,int language,String subject,String content,String name,String address,String zip,String telephone,String email,String picture,String voice,String filename,String file) throws SQLException
    {
        int l = 0;
        String userR = null;
        String userV = null;
        if(rv != null)
        {
            userR = rv._strR;
            userV = rv._strV;
        }
        StringBuilder sql = new StringBuilder("INSERT INTO Talkback (node, rmember, vmember,time, hint,country, status,hidden,ip, language, subject, content, name, address, zip, telephone, email, picture, voice,  filedata,filename)VALUES(");
        sql.append(node);
        sql.append(",").append(DbAdapter.cite(userR));
        sql.append(",").append(DbAdapter.cite(userV));
        sql.append(",").append(DbAdapter.cite(new Date()));
        sql.append(",").append(hint);
        sql.append(",").append(country);
        sql.append(",").append(0);
        sql.append(",").append(hidden);
        sql.append(",").append(DbAdapter.cite(ip));
        sql.append(",").append(language);
        sql.append(",").append(DbAdapter.cite(subject));
        sql.append(",").append(DbAdapter.cite(content));
        sql.append(",").append(DbAdapter.cite(name));
        sql.append(",").append(DbAdapter.cite(address));
        sql.append(",").append(DbAdapter.cite(zip));
        sql.append(",").append(DbAdapter.cite(telephone));
        sql.append(",").append(DbAdapter.cite(email));
        sql.append(",").append(DbAdapter.cite(picture));
        sql.append(",").append(DbAdapter.cite(voice));
        sql.append(",").append(DbAdapter.cite(file)).append(",").append(DbAdapter.cite(filename)).append(")");
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(sql.toString());
            l = db.getInt("SELECT MAX(talkback) FROM Talkback");
        } finally
        {
            db.close();
        }
        return l;
    }

    //新添加方法

    public static int create(int node,String userR,String userV,int hint,int country,int hidden,String ip,int language,String subject,String content,String name,String address,String zip,String telephone,String email,String picture,String voice,String filename,String file) throws SQLException
    {
        int talkback;
        /*
           String userR = null;
           String userV = null;
           if(rv != null)
           {
         userR = rv._strR;
         userV = rv._strV;
           }
         */
        StringBuilder sql = new StringBuilder("INSERT INTO Talkback(talkback,node,rmember,vmember,time,hint,country,status,hidden,ip,language,subject,content,name,address,zip,telephone,email,picture,voice, filedata,filename)VALUES(");
        sql.append(talkback = Seq.get());
        sql.append(",").append(node);
        sql.append(",").append(DbAdapter.cite(userR));
        sql.append(",").append(DbAdapter.cite(userV));
        sql.append(",").append(DbAdapter.cite(new Date()));
        sql.append(",").append(hint);
        sql.append(",").append(country);
        sql.append(",").append(0);
        sql.append(",").append(hidden);
        sql.append(",").append(DbAdapter.cite(ip));
        sql.append(",").append(language);
        sql.append(",").append(DbAdapter.cite(subject));
        sql.append(",").append(DbAdapter.cite(content));
        sql.append(",").append(DbAdapter.cite(name));
        sql.append(",").append(DbAdapter.cite(address));
        sql.append(",").append(DbAdapter.cite(zip));
        sql.append(",").append(DbAdapter.cite(telephone));
        sql.append(",").append(DbAdapter.cite(email));
        sql.append(",").append(DbAdapter.cite(picture));
        sql.append(",").append(DbAdapter.cite(voice));
        sql.append(",").append(DbAdapter.cite(file)).append(",").append(DbAdapter.cite(filename)).append(")");
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(talkback,sql.toString());
        } finally
        {
            db.close();
        }
        return talkback;
    }

    //通一个IP和标题不能填写信息
    public static boolean isADD(String ip,String content) throws SQLException
    {
        boolean f = false;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select talkback from Talkback  where ip = " + db.cite(ip) + "  and     content like " + db.cite("%" + content));

            if(db.next())
            {
                f = true;
            }
        } finally
        {
            db.close();
        }
        return f;
    }

    public String getPicture(int i) throws SQLException
    {
        return getLayer(i)._strPicture;
    }

    private static String getEdNodesSql(RV rv)
    {
        return " FROM Node n, Talkback t  WHERE n.node=t.node  AND t.status=0 AND n.rcreator=" + DbAdapter.cite(rv._strR);
    }

    private static String getEdNodesSql1(RV rv)
    {
        return " FROM Node n, Talkback t  WHERE n.node=t.node  AND t.rmember=" + DbAdapter.cite(rv._strR);
        //return " FROM Node n, Talkback t  WHERE n.node=t.node  AND t.status=0 AND n.rcreator=" + DbAdapter.cite(rv._strR);
    }


    public RV getCreator()
    {
        return _rv;
    }

    public Anchor getAnchor(int i) throws SQLException
    {
        String subject;
        if(this.getHidden() == 0)
        {
            subject = "<strike>" + getSubject(i) + "</strike>";
        } else
        {
            subject = getSubject(i);
        }
        Anchor anchor = new Anchor("/jsp/talkback/Talkback.jsp?node=" + _nNode + "&talkback=" + talkback,subject);
        anchor.setId("TalkbackIDsubject");
        return anchor;
    }


    public String getFile(int i) throws SQLException
    {
        return getLayer(i)._strFile;
    }

    public static int countEdNodes(RV rv) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            i = db.getInt("SELECT COUNT(DISTINCT n.node) " + getEdNodesSql(rv));
        } finally
        {
            db.close();
        }
        return i;
    }

    public static int countEdNodes2(RV rv) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            i = db.getInt("SELECT COUNT(DISTINCT t.talkback) " + getEdNodesSql(rv));
        } finally
        {
            db.close();
        }
        return i;
    }

    public static Enumeration find(String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT talkback FROM Talkback WHERE 1=1" + sql,pos,size);

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


    public static int count(int i) throws SQLException
    {
        return count(" AND node=" + i);
    }

    public static int count(String sql) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            j = db.getInt("SELECT COUNT(talkback) FROM Talkback WHERE 1=1" + sql);

        } finally
        {
            db.close();
        }
        return j;
    }


    public static Enumeration find(int node,int pos,int size) throws SQLException
    {
        return find(" AND node=" + node + " ORDER BY talkback DESC",pos,size);
    }

    public static void delete(int i) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(i,"DELETE FROM Talkback WHERE node=" + i);
        } finally
        {
            db.close();
        }
        _cache.clear();
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(talkback,"DELETE FROM Talkback WHERE talkback=" + talkback);
            db.executeUpdate(talkback,"DELETE FROM TalkbackReply WHERE talkback =" + talkback);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(talkback));
    }

    public static boolean isPer(int node,RV rv) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT talkback FROM Talkback WHERE node=" + node + " AND rmember=" + DbAdapter.cite(rv._strR) + " AND vmember=" + DbAdapter.cite(rv._strV));
            return db.next();
        } finally
        {
            db.close();
        }
    }

    public int getHint()
    {
        return _nHint;
    }

    public String getVoice(int i) throws SQLException
    {
        return getLayer(i)._strVoice;
    }

    public String getName(int i) throws SQLException
    {
        return getLayer(i).name;
    }

    public String getAddress(int i) throws SQLException
    {
        return getLayer(i).address;
    }

    public String getZip(int i) throws SQLException
    {
        return getLayer(i).zip;
    }

    public String getTelephone(int i) throws SQLException
    {
        return getLayer(i).telephone;
    }

    public String getEmail(int i) throws SQLException
    {
        return getLayer(i).email;
    }

    public void setHidden(int hidden) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(talkback,"UPDATE Talkback SET hidden=" + hidden + " WHERE talkback=" + talkback);
        } finally
        {
            db.close();
        }
        this.hidden = hidden;
    }

    //好评率
    public static int getPercent(int node) throws SQLException
    {
        int sum = Talkback.count(" AND node=" + node + " AND hidden=1");
        if(sum < 1)
            return 0;
        int gcount = Talkback.count(" AND node=" + node + " AND hidden=1 AND hint IN(4,5)");
//        java.text.NumberFormat nf = java.text.NumberFormat.getPercentInstance();
//        nf.setMinimumFractionDigits(0); // 小数点后保留几位
//        String c = ps > 0 ? nf.format(ps) : "0%";
//        out.println(c);
        return gcount * 100 / sum;
    }

    public static String getHintString(int i,int lan)
    {
        Resource r = new Resource("/tea/resource/Photography");
        String str = "";
        if(i == 1)
        {
            str = r.getString(lan,"8413268113");
        } else if(i == 2)
        {
            str = r.getString(lan,"4414900785");
        } else if(i == 3)
        {
            str = r.getString(lan,"4880431636");
        } else if(i == 4)
        {
            str = r.getString(lan,"4571733059");
        } else if(i == 5)
        {
            str = r.getString(lan,"1228262699");
        } else if(i == 6)
        {
            str = r.getString(lan,"6441750121");
        } else if(i == 7)
        {
            str = r.getString(lan,"1654479687");
        } else if(i == 8)
        {
            str = r.getString(lan,"2201090179");
        } else if(i == 9)
        {
            str = r.getString(lan,"1965336017");
        } else if(i == 10)
        {
            str = r.getString(lan,"7862260247");
        }
        return str;
    }

    public int getHidden()
    {
        return hidden;
    }

    public String getIp()
    {
        return ip;
    }

    public String getAuditmember()
    {
        return auditmember;
    }

    public Date getAudittime()
    {
        return audittime;
    }
}
