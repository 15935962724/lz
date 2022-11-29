package tea.entity.node;

import java.io.*;
import java.sql.*;
import java.util.*;
import java.util.Date;
import tea.ui.*;
import tea.db.*;
import tea.entity.*;
import tea.entity.site.*;
import tea.entity.admin.*;
import tea.html.*;

public class Tender extends Entity
{
    private static Cache _cache = new Cache(100);
    private int node;
    private int language; //语言
    private int media; //媒体编号
    private String subhead;
    private String author; //作者
    private String locus; //地点
    private String filepath; // 附件//
    private String filename;
    private String logograph; //导语
    private Date time; //发布时间
    private boolean exists;

    public static void create(int node,int language,int media,String subhead,String author,String locus,String filepath,String filename,String logograph,Date time) throws SQLException
    {
        StringBuilder s1 = new StringBuilder();
        s1.append("INSERT INTO Tender(node,language,media,subhead,author,locus,filepath,filename,logograph,time)");
        s1.append("VALUES(").append(node).append(", ").append(language).append(", ").append(media).append(",").append(DbAdapter.cite(subhead)).append(", ").append(DbAdapter.cite(author)).append(", ").append(DbAdapter.cite(locus));
        s1.append(",").append(DbAdapter.cite(filepath)).append(",").append(DbAdapter.cite(filename)).append(", ").append(DbAdapter.cite(logograph)).append(", ").append(DbAdapter.cite(time)).append(")");
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(s1.toString());
        } finally
        {
            db.close();
        }
        _cache.remove(node + ":" + language);
    }

    public void set(int media,String subhead,String author,String locus,String filepath,String filename,String logograph,Date time) throws SQLException
    {
        int j = 0;
        StringBuilder s1 = new StringBuilder();
        s1.append("UPDATE Tender SET media=").append(media);
        s1.append(",subhead=").append(DbAdapter.cite(subhead));
        s1.append(",author=").append(DbAdapter.cite(author));
        s1.append(",locus=").append(DbAdapter.cite(locus));
        s1.append(",filepath=").append(DbAdapter.cite(filepath));
        s1.append(",filename=").append(DbAdapter.cite(filename));
        s1.append(",logograph=").append(DbAdapter.cite(logograph));
        s1.append(",time=").append(DbAdapter.cite(time));
        s1.append(" WHERE node=").append(node).append(" AND language=").append(language);
        DbAdapter db = new DbAdapter();
        try
        {
            j = db.executeUpdate(s1.toString());
        } finally
        {
            db.close();
        }
        this.media = media;
        this.subhead = subhead;
        this.author = author;
        this.locus = locus;
        this.filepath = filepath;
        this.filename = filename;
        this.logograph = logograph;
        this.time = time;
        if(j < 1)
        {
            create(node,language,media,subhead,author,locus,filepath,filename,logograph,time);
        }
    }

    public Tender(int node,int language) throws SQLException
    {
        this.node = node;
        this.language = language;
        load();
    }

    public int getMedia()
    {
        return this.media;
    }

    public Date getTime()
    {
        return time;
    }

    public String getTimeToString()
    {
        return sdf.format(time);
    }

    private void load() throws SQLException
    {
        int j = this.getLanguage(language);
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT media,subhead,author,locus,filepath,filename,logograph,time FROM Tender WHERE node=" + node + " AND language=" + j);
            if(db.next())
            {
                this.media = db.getInt(1);
                this.subhead = db.getVarchar(j,language,2);
                this.author = db.getVarchar(j,language,3);
                this.locus = db.getVarchar(j,language,4);
                this.filepath = db.getString(5);
                this.filename = db.getVarchar(j,language,6);
                this.logograph = db.getText(j,language,7);
                this.time = db.getDate(8);
                this.exists = true;
            } else
            {
                this.exists = false;
            }
        } finally
        {
            db.close();
        }
    }


    private int getLanguage(int language) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT language FROM Tender WHERE node=" + node);
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

    public static Tender find(int node,int language) throws SQLException
    {
        Tender obj = (Tender) _cache.get(node + ":" + language);
        if(obj == null)
        {
            obj = new Tender(node,language);
            _cache.put(node + ":" + language,obj);
        }
        return obj;
    }

    public String getLogograph()
    {
        return logograph;
    }

    public String getLocus()
    {
        return locus;
    }

    public int getLanguage()
    {
        return language;
    }

    public String getSubhead()
    {
        return subhead;
    }

    public String getAuthor()
    {
        return author;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getFileName()
    {
        return filename;
    }

    public String getFilePath()
    {
        return filepath;
    }

    public static String check(Http h) throws SQLException
    {
        CommunityOption co = CommunityOption.find(h.community);
        String trole = co.get("tenderrole");
        int info = co.getInt("tenderinfo");
        if(!trole.equals("/"))
        {
            if(h.member == 0)
            {
                return "/servlet/StartLogin?node=" + h.node;
            }
            AdminUsrRole aur = AdminUsrRole.find(h.community,h.username);
            String role = aur.getRole();
            String trs[] = trole.split("/");
            for(int i = 1;i <= trs.length;i++)
            {
                if(i == trs.length)
                {
                    return "/servlet/Node?node=" + info;
                } else if(role.indexOf("/" + trs[i] + "/") != -1 || AdminRole.find(Integer.parseInt(trs[i])).getType() == 1)
                {
                    break;
                }
            }
        }
        return null;
    }

    public String getDetail(Node n,Http h,int listing,String target) throws SQLException,IOException
    {
        StringBuilder text = new StringBuilder();
        int node = n._nNode;
        Tender obj = new Tender(node,h.language);
        String subject = n.getSubject(h.language);
        ListingDetail detail = ListingDetail.find(listing,86,h.language);
        Iterator e = detail.keys();
        while(e.hasNext())
        {
            String name = (String) e.next(),value = null;
            int istype = detail.getIstype(name);
            if(istype == 0)
            {
                continue;
            }
            int qu = detail.getQuantity(name);
            if(name.equals("subject"))
            {
                value = subject;
            } else if(name.equals("media"))
            {
                int media = obj.getMedia();
                Media m = Media.find(media);
                value = m.getName(h.language);
            } else if(name.equals("father"))
            {
                value = Node.find(n.getFather()).getAnchor(h.language).toString();
            } else if(name.equals("logograph"))
            {
                value = obj.getLogograph();
            } else if(name.equals("locus"))
            {
                value = obj.getLocus();
            } else if(name.equals("file"))
            {
                if(filepath != null && filepath.length() > 0)
                {
                    value = "<A HREF=/servlet/EditTender?node=" + node + "&h.language=" + h.language + "&act=down><SPAN ID=TenderIDname>" + filename + "</SPAN></A>";
                }
            } else if(name.equals("content"))
            {
                if(detail.getQuantity(name) == 0)
                {
                    if((n.getOptions() & 0x40L) == 0)
                    {
                        value = (tea.html.Text.toHTML(n.getText2(h.language)));
                    } else
                    {
                        value = (n.getText2(h.language));
                    }
                } else
                {
                    value = (n.getText(h.language));
                }
            } else if(name.equals("creator"))
            {
                value = "<A HREF='/jsp/type/tender/ViewTenderCreator.jsp?node=" + node + "&h.language=" + h.language + "'>联系发布人</A>";
            } else if(name.equals("time"))
            {
                value = obj.getTimeToString();
            } else if(name.equals("stoptime"))
            {
                value = n.getStopTimeToString();
            } else if(name.equals("MediaLogo"))
            {
                int _nMedia = obj.getMedia();
                Media media = Media.find(_nMedia);
                String logo = media.getLogo(h.language);
                if(logo != null && logo.length() > 0)
                {
                    value = "<IMG onerror=\"this.style.display='none';\" SRC=\"" + logo + "\" />";
                }
            } else if(name.equals("subhead"))
            {
                value = obj.getSubhead();
            } else if(name.equals("author"))
            {
                value = obj.getAuthor();
            } else if(name.equals("correlation"))
            {
                StringBuilder sb = new StringBuilder();
                ArrayList al = n.getCorrelation(h.language,39,qu,detail.getTime(name));
                for(int i = 0;i < al.size();i++)
                {
                    Node nc = (Node) al.get(i);
                    sb.append("<a id='TenderIDcorrelation1' href='/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/report/" + nc._nNode + "-" + h.language + ".htm'>" + nc.getSubject(h.language) + "</a>");
                    Report r2 = Report.find(nc._nNode);
                    if(r2.getMedia() != 0)
                    {
                        Media m = Media.find(r2.getMedia());
                        if(m.type > 0)
                            sb.append("<span id='TenderIDcorrelationMedia'>" + m.getName(h.language) + "</span>");
                    }
                    sb.append("<span id='TenderIDcorrelation2'>" + MT.f(nc.getStartTime()) + "</span><br/>");
                }
                if(sb.length() == 0) // 如果没有内容，则不显示 之前，之后
                {
                    continue;
                }
                value = sb.toString();
            } else if(name.equals("correlationNP")) // 相关 报纸文章
            {
                StringBuilder sb = new StringBuilder();
                ArrayList al = n.getCorrelation(h.language,44,qu,detail.getTime(name));
                for(int i = 0;i < al.size();i++)
                {
                    Node nc = (Node) al.get(i);
                    sb.append("<a id='TenderIDcorrelationNP1' href='/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/newspaper/" + nc._nNode + "-" + h.language + ".htm'>" + nc.getSubject(h.language) + "</a><br/>");
                }
                if(sb.length() == 0) // 如果没有内容，则不显示 之前，之后
                {
                    continue;
                }
                value = (sb.toString());
            } else if(name.equals("correlationDL")) // 相关下载
            {
                java.util.Enumeration enumer = Download.getCorrelation(n,h.language,63,qu);
                int node_id;
                StringBuilder sb = new StringBuilder();
                while(enumer.hasMoreElements())
                {
                    node_id = ((Integer) enumer.nextElement()).intValue();
                    Node node_obj = Node.find(node_id);
                    java.util.Enumeration enumer_dns = DNS.findByCommunity(node_obj.getCommunity(),0);
                    String sn = "";
                    if(enumer_dns.hasMoreElements())
                    {
                        DNS dns = DNS.find((String) enumer_dns.nextElement());
                        sn = "http://" + dns.getDomainname();
                    }
                    tea.html.Anchor a = new tea.html.Anchor(sn + "/servlet/Download?node=" + node_id + "&h.language=" + h.language,node_obj.getSubject(h.language));
                    a.setTarget("_blank");
                    a.setId("TenderIDcorrelationDL1");
                    sb.append(a.toString() + "<BR>");
                }
                if(sb.length() == 0) // 如果没有内容，则不显示 之前，之后
                {
                    continue;
                }
                value = (sb.toString());
            }
            if(value != null && qu > 0 && value.length() > qu)
            {
                value = value.substring(0,qu) + " ...";
            }
            if(detail.getAnchor(name) != 0)
            {
                Anchor anchor = new Anchor("/servlet/Tender?node=" + node + "&h.language=" + h.language,value);
                anchor.setTarget(target);
                value = anchor.toString();
            }
            Span span = new Span(value);
            span.setId("TenderID" + name);
            text.append(detail.getBeforeItem(name)).append(span).append(detail.getAfterItem(name));
        }
        return text.toString();
    }
}
