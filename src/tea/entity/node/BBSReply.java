package tea.entity.node;

import java.util.*;

import tea.db.*;
import tea.entity.*;
import tea.html.*;
import tea.entity.site.*;
import tea.entity.admin.*;
import tea.entity.member.*;
import java.sql.SQLException;
import tea.entity.bbs.BBSAttach;

public class BBSReply extends Entity
{
    class Layer
    {
        Layer()
        {
        }

        public String subject;
        public String content;
        public String anchor;
    }


    private int hint;
    private int node;
    private int language;
    private static Cache _cache = new Cache(100);
    private Hashtable _htLayer;
    private boolean exists;
    private int id;
    private String member;
    private Date time;
    private String ip;
    private boolean hidden;
    public String umember;
    private Date utime;
    private int search;
    public int reply;
    public int quote;
    private String searchmember; //查阅人员
    private Date searchtime; //查阅时间

    public static BBSReply find(int id) throws SQLException
    {
        BBSReply obj = (BBSReply) _cache.get(new Integer(id));
        if(obj == null)
        {
            obj = new BBSReply(id);
            _cache.put(new Integer(id),obj);
        }
        return obj;
    }

    public BBSReply(int id) throws SQLException
    {
        this.id = id;
        _htLayer = new Hashtable();
        load();
    }

    public void set(int hint,String ip,String umember,Date utime,String content,int language) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE BBSReply SET hint=" + (hint) + ",ip=" + DbAdapter.cite(ip) + ",umember=" + DbAdapter.cite(umember) + ",utime=" + DbAdapter.cite(utime) + " WHERE id=" + id);
            db.executeUpdate("UPDATE BBSReplyLayer SET content=' ' WHERE bbsreply=" + id + " AND language=" + language);
            db.setText("BBSReplyLayer","content",content,"bbsreply=" + id + " AND language=" + language);
        } finally
        {
            db.close();
        }
        this.hint = hint;
        this.umember = umember;
        this.utime = utime;
        _htLayer.clear();
    }

    //修改查阅
    public void setSearch(int search) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE BBSReply SET search=" + search + " WHERE id=" + id);
        } finally
        {
            db.close();
        }
        this.search = search;
        _htLayer.clear();
    }

    //修改查阅日期和查阅会员
    public void setSearch(String searchmember,Date searchtime) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE BBSReply SET searchmember=" + DbAdapter.cite(searchmember) + ",searchtime=" + DbAdapter.cite(searchtime) + " WHERE id=" + id);
        } finally
        {
            db.close();
        }
        this.searchmember = searchmember;
        this.searchtime = searchtime;
        _htLayer.clear();
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM BBSReply WHERE id=" + id);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(id));
    }

    public static int create(int node,String member,String ip,int hint,boolean hidden,int language,String subject,String text,String anchor,int reply,int quote) throws SQLException
    {
        int id = 0;
        Date d = new Date();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO BBSReply(id,node,member,hint,ip,hidden,time,utime,reply,quote)VALUES(" + (id = Seq.get()) + "," + node + "," + DbAdapter.cite(member) + "," + hint + "," + DbAdapter.cite(ip) + "," + (hidden ? "1" : "0") + "," + DbAdapter.cite(d) + "," + DbAdapter.cite(d) + "," + reply + "," + quote + ")");
            db.executeUpdate("INSERT INTO BBSReplyLayer(bbsreply,language,subject,content,anchor)VALUES(" + id + "," + language + "," + DbAdapter.cite(subject) + ",' '," + DbAdapter.cite(anchor) + ")");
            db.setText("BBSReplyLayer","content",text,"bbsreply=" + id + " AND language=" + language);
        } finally
        {
            db.close();
        }
        if(!hidden)
            BBS.find(node,language).set(member,d);
        return id;
    }

    // 我参与的讨论
    public static int countByMember(String community,String member) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(DISTINCT n.node) FROM Node n INNER JOIN BBSReply br ON n.node=br.node WHERE n.type=57 AND n.community=" + DbAdapter.cite(community) + " AND br.member=" + DbAdapter.cite(member)); // + " AND n.vcreator!=" + DbAdapter.cite(member)
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

    // 我参与的讨论
    public static Enumeration findByMember(String community,String member,int pos,int pagesize) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT n.node FROM Node n INNER JOIN BBSReply br ON n.node=br.node WHERE n.type=57 AND n.community=" + DbAdapter.cite(community) + " AND br.member=" + DbAdapter.cite(member) + " GROUP BY n.node ORDER BY n.node DESC",pos,pagesize); //+ " AND n.vcreator!=" + DbAdapter.cite(member)
            while(db.next())
            {
                v.add(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static Enumeration find(int node,int language) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id FROM BBSReply WHERE hidden=0 AND node=" + node + " ORDER BY id DESC");
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

    public static Enumeration find(String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id FROM BBSReply WHERE 1=1" + sql,pos,size);
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

    public static Enumeration find(int node,String member,int language,int pos,int size) throws SQLException
    {
        String sql = " AND hidden=0 ";
        Node obj = Node.find(node);
        if(member != null)
        {
            Communitybbs com_obj = Communitybbs.find(obj.getCommunity());
            boolean _bCommunityMember = member.equals(com_obj.getSuperhost()); // 超级版主
            AdminUsrRole aur_obj = AdminUsrRole.find(obj.getCommunity(),member);
            if(_bCommunityMember || aur_obj.getBbsHost().indexOf("/" + obj.getFather() + "/") != -1)
            {
                sql = "";
            }
        }
        boolean sort = Forum.find(obj.getCommunity()).isSort();
        BBS b = BBS.find(node,language);
        int best = b.getBest();
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id FROM BBSReply WHERE node=" + node + sql + " ORDER BY id " + (sort ? "DESC" : "ASC"),pos,size);
            while(db.next())
            {
                int id = db.getInt(1);
                if(best == id)
                {
                    v.insertElementAt(new Integer(id),0);
                } else
                {
                    v.addElement(new Integer(id));
                }
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static int count(int node,String sql) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(*) FROM BBSReply WHERE node=" + node + sql);
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

    public static int count(int node,int language) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            return db.getInt("SELECT COUNT(*)  FROM BBSReply WHERE node=" + node);
        } finally
        {
            db.close();
        }
    }

    public static int count(int node,String member,int language) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            String sql = " AND hidden=0 ";
            if(member != null)
            {
                Node obj = Node.find(node);
                Communitybbs com_obj = Communitybbs.find(obj.getCommunity());
                boolean _bCommunityMember = member.equals(com_obj.getSuperhost()); // 超级版主
                tea.entity.admin.AdminUsrRole aur_obj = tea.entity.admin.AdminUsrRole.find(obj.getCommunity(),member);
                if(aur_obj.getBbsHost().indexOf("/" + obj.getFather() + "/") != -1 || _bCommunityMember)
                {
                    sql = "";
                }
            }
            return db.getInt("SELECT COUNT(id) FROM BBSReply WHERE node=" + node + sql);
        } finally
        {
            db.close();
        }
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node,member,time,hint,ip,hidden,umember,utime,search,searchmember,searchtime,reply,quote FROM BBSReply WHERE id=" + id);
            if(db.next())
            {
                node = db.getInt(1);
                member = db.getString(2);
                time = db.getDate(3);
                hint = db.getInt(4);
                ip = db.getString(5);
                hidden = db.getInt(6) != 0;
                umember = db.getString(7);
                utime = db.getDate(8);
                search = db.getInt(9);
                searchmember = db.getString(10);
                searchtime = db.getDate(11);
                reply = db.getInt(12);
                quote = db.getInt(13);
                exists = true;
            } else
            {
                exists = false;
            }
        } finally
        {
            db.close();
        }
    }

    public int getSearch()
    {
        return search;
    }

    public String getSearchmember()
    {
        return searchmember;
    }

    public Date getSearchtime()
    {
        return searchtime;
    }

    public int getHint()
    {
        return hint;
    }

    public int getNode()
    {
        return node;
    }

    public int getLanguage()
    {
        return language;
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getId()
    {
        return id;
    }

    public String getMember()
    {
        return member;
    }

    public String getSubject(int language) throws SQLException
    {
        return getLayer(language).subject;
    }

    public String getContent(int language) throws SQLException
    {
        return getLayer(language).content;
    }

    public String getAnchor(int language) throws SQLException
    {
        return getLayer(language).anchor;
    }

    public Date getTime()
    {
        return time;
    }

    public String getTimeToString()
    {
        if(time == null)
        {
            return "";
        }
        return sdf2.format(time);
    }

    public String getIp()
    {
        return ip;
    }

    public String getIpBlur()
    {
        String blur;
        int index = ip.lastIndexOf(".");
        blur = ip.substring(0,index + 1) + "*";
        return blur;
    }

    public boolean isHidden()
    {
        return hidden;
    }

    public Date getUtime()
    {
        return utime;
    }

    public String getUtimeToString()
    {
        return sdf2.format(utime);
    }

    private Layer getLayer(int i) throws SQLException
    {
        Layer layer = (Layer) _htLayer.get(new Integer(i));
        if(layer == null)
        {
            layer = new Layer();
            int j = this.getLanguage(i);
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT subject,content,anchor FROM BBSReplyLayer WHERE bbsreply=" + id + " AND language=" + j);
                if(db.next())
                {
                    layer.subject = db.getVarchar(j,i,1);
                    layer.content = db.getText(j,i,2);
                    layer.anchor = db.getString(3);
                }
            } finally
            {
                db.close();
            }
            _htLayer.put(new Integer(i),layer);
        }
        return layer;
    }

    private int getLanguage(int language) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT language FROM BBSReplyLayer WHERE bbsreply=" + id);
            while(db.next())
            {
                v.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        if(v.indexOf(new Integer(language)) != -1)
        {
            return language;
        } else
        {
            if(language == 1)
            {
                if(v.indexOf(new Integer(2)) != -1)
                {
                    return 2;
                }
            } else if(language == 2)
            {
                if(v.indexOf(new Integer(1)) != -1)
                {
                    return 1;
                }
            }
            if(v.size() < 1)
            {
                return 0;
            }
        }
        return((Integer) v.elementAt(0)).intValue();
    }

    public void setHidden(boolean hidden) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE BBSReply SET hidden=" + (hidden ? "1" : "0") + "  WHERE id=" + id); // + " AND language=" + this.language
        } finally
        {
            db.close();
        }
        this.hidden = hidden;
    }

    public String getHtml(int language) throws SQLException
    {
        StringBuilder tsb = new StringBuilder();
        int quote = Math.max(this.reply,this.quote);
        if(quote > 0)
        {
            String str,user,time;
            if(quote == 1)
            {
                Node n = Node.find(node);
                str = n.getText(language);
                user = n.getCreator()._strR;
                time = MT.f(n.getTime(),1);
            } else
            {
                BBSReply br = BBSReply.find(quote);
                str = br.getContent(language);
                user = br.getMember();
                time = MT.f(br.getTime(),1);
            }
            str = MT.f(tea.entity.util.Lucene.t(str),100);
            if(this.quote > 0) //引用
                tsb.append("<img src='/tea/image/bbslevel/quote1.gif' />" + user + " 发表于 " + time + "<img src='/tea/image/bbslevel/quote.gif'/><br/>" + str + "<img src='/tea/image/bbslevel/quote2.gif' />");
            else //回复
                tsb.append("<div style='background-color:#FDFDDF'><font color='red'>回复 " + user + " 的内容：<br/></font>" + str + "</div>");
        }
        tsb.append(this.getContent(language)).append(BBSAttach.toHtml(true,this.id));
        String anchor = this.getAnchor(language);
        if(anchor != null && anchor.length() > 10)
        {
            tsb.append("<br>贴子相关链接:<br>");
            String lc = anchor.toLowerCase();
            if(lc.endsWith(".swf") || lc.endsWith(".wav") || lc.endsWith(".mp3") || lc.endsWith(".asf") || lc.endsWith(".rm") || lc.endsWith(".rmvb"))
            {
                tsb.append("<embed src='" + anchor + " '></embed>");
            } else
            {
                tsb.append("<img src='" + anchor + "' />");
            }
        }
        if(this.getTime().getTime() - this.getUtime().getTime() != 0)
        {
            tsb.append("<br/><span id='BBSIDeditalert'>[此贴子已经被 " + (this.getMember().equals(this.umember) ? "作者" : this.umember) + " 于 " + this.getUtimeToString() + " 编辑过]</span>");
        }
        return tsb.toString();
    }
}
