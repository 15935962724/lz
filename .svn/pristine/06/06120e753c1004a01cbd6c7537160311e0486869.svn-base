package tea.entity.commentreview;

import java.sql.SQLException;
import java.util.Date;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Vector;

import tea.db.DbAdapter;
import tea.entity.*;
import tea.html.Anchor;
import tea.resource.Resource;

public class CommentReview extends Entity
{
    public static Cache _cache = new Cache(100);
    private Hashtable _htLayer;
    public static final int COMMENTREVIEWS_UNREAD = 0;
    public static final int COMMENTREVIEWS_READ = 1;
    private int commentreview;
    private int fkeyid;
    private RV _rv;
    public int country; //国家
    private Date _time;
    private int _nHint;
    private int _nStatus;
    private int _nLanguage;
    private int state; //0 未审核，1，已审核，2, 已拒绝
    private String ip;
    private static final String[] COMMENT_TYPE={"PoFamousComment"};
    private int type;//各个类的类型

    private String auditmember; //审核人员
    private Date audittime; //审核时间

    public static final String STATE_TYPE[] =
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


    public static CommentReview find(int commentreview) throws SQLException
    {
        CommentReview t = (CommentReview) _cache.get(new Integer(commentreview));
        if(t == null)
        {
            t = new CommentReview(commentreview);
            _cache.put(new Integer(commentreview),t);
        }
        return t;
    }

    private CommentReview(int commentreview) throws SQLException
    {
        this.commentreview = commentreview;
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
                db.executeQuery("SELECT subject,name,address,zip,telephone,email,filename,picture,voice,filedata FROM CommentReview WHERE commentreview=" + commentreview);
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
                db.executeQuery("SELECT content FROM CommentReview WHERE commentreview=" + commentreview);
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


    public int getFkeyid()
    {
        return fkeyid;
    }
    
    public int getType()
    {
        return type;
    }

    public void read() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(commentreview,"UPDATE CommentReview SET status=1 WHERE commentreview=" + commentreview + " AND status=" + 0);
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
            db.executeQuery("SELECT commentreview FROM CommentReview WHERE fkeyid=" + fkeyid + " AND commentreview>" + commentreview + " ORDER BY commentreview ");
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
            db.executeQuery("SELECT fkeyid, rmember, vmember, time, hint,country, status, state,ip,type,language,auditmember,audittime FROM CommentReview WHERE commentreview=" + commentreview);
            if(db.next())
            {
                int j = 1;
                fkeyid = db.getInt(j++);
                _rv = new RV(db.getString(j++),db.getString(j++));
                _time = db.getDate(j++);
                _nHint = db.getInt(j++);
                country = db.getInt(j++);
                _nStatus = db.getInt(j++);
                state = db.getInt(j++);
                ip = db.getString(j++);
                type = db.getInt(j++);
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
            db.executeQuery("SELECT commentreview FROM CommentReview  WHERE fkeyid=" + fkeyid + " AND commentreview<" + commentreview + " ORDER BY commentreview DESC ");
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
            db.executeQuery("SELECT DISTINCT t.commentreview " + getEdNodesSql(rv));
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
            db.executeQuery("SELECT DISTINCT t.commentreview " + getEdNodesSql1(rv));
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

    public void set(int _nHint,int country,int language,String s,String s1,String picture,String voice,String file,String filename) throws SQLException
    {
        StringBuilder sql = new StringBuilder("UPDATE CommentReview SET hint=" + _nHint + ",country=" + country + ",language=" + language + ",subject=" + DbAdapter.cite(s) + ",content=" + DbAdapter.cite(s1));
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
        sql.append(" WHERE commentreview=").append(commentreview);
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(commentreview,sql.toString());
        } finally
        {
            db.close();
        }
        this._nHint = _nHint;
        this.country = country;
        this._nLanguage = language;
        _htLayer.clear();
        // _cache.remove(new Integer(commentreview));
    }

    public void set(String auditmember,Date audittime) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(commentreview,"UPDATE CommentReview SET auditmember=" + db.cite(auditmember) + " , audittime=" + db.cite(audittime) + " WHERE commentreview= " + commentreview);
        } finally
        {
            db.close();
        }
        this.auditmember = auditmember;
        this.audittime = audittime;
        _htLayer.clear();
    }

    public static int create(int fkeyid,RV rv,int hint,int country,int state,String ip,int type,int language,String subject,String content,String name,String address,String zip,String telephone,String email,String picture,String voice,String filename,String file) throws SQLException
    {
        int l = 0;
        String userR = null;
        String userV = null;
        if(rv != null)
        {
            userR = rv._strR;
            userV = rv._strV;
        }
        StringBuilder sql = new StringBuilder("INSERT INTO CommentReview (fkeyid, rmember, vmember,time, hint,country, status,state,ip, type, language, subject, content, name, address, zip, telephone, email, picture, voice,  filedata,filename)VALUES(");
        sql.append(fkeyid);
        sql.append(",").append(DbAdapter.cite(userR));
        sql.append(",").append(DbAdapter.cite(userV));
        sql.append(",").append(DbAdapter.cite(new Date()));
        sql.append(",").append(hint);
        sql.append(",").append(country);
        sql.append(",").append(0);
        sql.append(",").append(state);
        sql.append(",").append(DbAdapter.cite(ip));
        sql.append(",").append(type);
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
            l = db.getInt("SELECT MAX(commentreview) FROM CommentReview");
        } finally
        {
            db.close();
        }
        return l;
    }

    //新添加方法

    public static int create(int fkeyid,String userR,String userV,int hint,int country,int state,String ip,int type,int language,String subject,String content,String name,String address,String zip,String telephone,String email,String picture,String voice,String filename,String file) throws SQLException
    {
        int commentreview;
        /*
           String userR = null;
           String userV = null;
           if(rv != null)
           {
         userR = rv._strR;
         userV = rv._strV;
           }
         */
        StringBuilder sql = new StringBuilder("INSERT INTO CommentReview(commentreview,fkeyid,rmember,vmember,time,hint,country,status,state,ip,type,language,subject,content,name,address,zip,telephone,email,picture,voice, filedata,filename)VALUES(");
        sql.append(commentreview = Seq.get());
        sql.append(",").append(fkeyid);
        sql.append(",").append(DbAdapter.cite(userR));
        sql.append(",").append(DbAdapter.cite(userV));
        sql.append(",").append(DbAdapter.cite(new Date()));
        sql.append(",").append(hint);
        sql.append(",").append(country);
        sql.append(",").append(0);
        sql.append(",").append(state);
        sql.append(",").append(DbAdapter.cite(ip));
        sql.append(",").append(type);
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
            db.executeUpdate(commentreview,sql.toString());
        } finally
        {
            db.close();
        }
        return commentreview;
    }

    //通一个IP和标题不能填写信息
    public static boolean isADD(String ip,String content) throws SQLException
    {
        boolean f = false;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select commentreview from CommentReview  where ip = " + db.cite(ip) + "  and     content like " + db.cite("%" + content));

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
        return " FROM Node n, CommentReview t  WHERE n.node=t.node  AND t.status=0 AND n.rcreator=" + DbAdapter.cite(rv._strR);
    }

    private static String getEdNodesSql1(RV rv)
    {
        return " FROM Node n, CommentReview t  WHERE n.node=t.node  AND t.rmember=" + DbAdapter.cite(rv._strR);
        //return " FROM Node n, CommentReview t  WHERE n.node=t.node  AND t.status=0 AND n.rcreator=" + DbAdapter.cite(rv._strR);
    }


    public RV getCreator()
    {
        return _rv;
    }

    public Anchor getAnchor(int i) throws SQLException
    {
        String subject;
        if(this.getState() == 0)
        {
            subject = "<strike>" + getSubject(i) + "</strike>";
        } else
        {
            subject = getSubject(i);
        }
        Anchor anchor = new Anchor("/jsp/commentreview/CommentReview.jsp?fkeyid=" + fkeyid + "&commentreview=" + commentreview,subject);
        anchor.setId("CommentReviewIDsubject");
        return anchor;
    }


    public String getFile(int i) throws SQLException
    {
        return getLayer(i)._strFile;
    }

    public static int countEdNodes2(RV rv) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            i = db.getInt("SELECT COUNT(DISTINCT t.commentreview) " + getEdNodesSql(rv));
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
            db.executeQuery("SELECT commentreview FROM CommentReview WHERE 1=1" + sql,pos,size);

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
        return count(" AND fkeyid=" + i);
    }

    public static int count(String sql) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            j = db.getInt("SELECT COUNT(commentreview) FROM CommentReview WHERE 1=1" + sql);

        } finally
        {
            db.close();
        }
        return j;
    }


    public static Enumeration find(int fkeyid,int pos,int size) throws SQLException
    {
        return find(" AND fkeyid=" + fkeyid + " ORDER BY commentreview DESC",pos,size);
    }

    public static void delete(int i) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(i,"DELETE FROM CommentReview WHERE fkeyid=" + i);
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
            db.executeUpdate(commentreview,"DELETE FROM CommentReview WHERE commentreview=" + commentreview);
            //db.executeUpdate(commentreview,"DELETE FROM CommentReviewReply WHERE commentreview =" + commentreview);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(commentreview));
    }

    public static boolean isPer(int fkeyid,RV rv) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT commentreview FROM CommentReview WHERE fkeyid=" + fkeyid + " AND rmember=" + DbAdapter.cite(rv._strR) + " AND vmember=" + DbAdapter.cite(rv._strV));
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

    public void setState(int state) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(commentreview,"UPDATE CommentReview SET state=" + state + " WHERE commentreview=" + commentreview);
        } finally
        {
            db.close();
        }
        this.state = state;
    }

    //好评率
    public static int getPercent(int fkeyid) throws SQLException
    {
        int sum = CommentReview.count(" AND fkeyid=" + fkeyid + " AND state=1");
        if(sum < 1)
            return 0;
        int gcount = CommentReview.count(" AND fkeyid=" + fkeyid + " AND state=1 AND hint IN(4,5)");
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

    public int getState() {
		return state;
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
