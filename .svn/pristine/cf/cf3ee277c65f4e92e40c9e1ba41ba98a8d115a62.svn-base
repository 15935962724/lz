package tea.entity.node;

import java.util.*;
import tea.db.DbAdapter;
import tea.entity.*;
import tea.html.*;
import tea.ui.*;
import java.sql.SQLException;

public class NewsPaper extends Entity
{
    private static Cache _cache = new Cache(100);
    private int _nNode;
    private int language;
    private boolean exists;
    private String subtitle;
    private int issue;
    private String edition;
    private String column;
    private Date pubdate;
    private String author;
    private String editor;

    public void set(String subtitle,int issue,String edition,String column,Date pubdate,String author,String editor) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int j = db.executeUpdate(" UPDATE NewsPaper   SET  SubTitle= " + DbAdapter.cite(subtitle) + " ,Qihao   = " + issue + " ,Edition = " + DbAdapter.cite(edition) + ",Lanmu=" + DbAdapter.cite(column) + " ,PubDate = " + DbAdapter.cite(pubdate) + " ,Author  = " + DbAdapter.cite(author) + " ,Editor  = " + DbAdapter.cite(editor) + " WHERE node=" + _nNode + " AND language=" + language);
            if(j < 1)
            {
                db.executeUpdate("INSERT INTO NewsPaper(node,language,SubTitle, Qihao,Edition,Lanmu,PubDate,Author,Editor)VALUES (" + _nNode + "," + language + "," + DbAdapter.cite(subtitle) + ", " + issue + "," + DbAdapter.cite(edition) + "," + DbAdapter.cite(column) + "," + DbAdapter.cite(pubdate) + "," + DbAdapter.cite(author) + "," + DbAdapter.cite(editor) + ")");
            }
        } finally
        {
            db.close();
        }
        this.subtitle = subtitle;
        this.issue = issue;
        this.edition = edition;
        this.column = column;
        this.pubdate = pubdate;
        this.author = author;
        this.editor = editor;
        this.exists = true;
        // _cache.remove(_nNode + ":" + language);
    }

    public NewsPaper(int _nNode,int language) throws SQLException
    {
        this._nNode = _nNode;
        this.language = language;
        load();
    }

    private void load() throws SQLException
    {
        int j = Node.getLanguage(_nNode,language);
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT SubTitle,Qihao   ,Edition ,Lanmu   ,PubDate ,Author  ,Editor   FROM NewsPaper  WHERE node=" + _nNode + " AND language=" + j);
            if(db.next())
            {
                subtitle = db.getVarchar(j,language,1);
                issue = db.getInt(2);
                edition = db.getVarchar(j,language,3);
                column = db.getVarchar(j,language,4);
                pubdate = db.getDate(5);
                author = db.getVarchar(j,language,6);
                editor = db.getVarchar(j,language,7);
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


    public int getIssue() throws SQLException
    {
        return issue;
    }

    public String getSubTitle() throws SQLException
    {
        return this.subtitle;
    }

    public String getColumn() throws SQLException
    {
        return this.column;
    }

    public String getEdition() throws SQLException
    {
        return this.edition;
    }

    public String getEditor() throws SQLException
    {
        return this.editor;
    }

    public String getAuthor() throws SQLException
    {
        return this.author;
    }

    public Date getPubdate() throws SQLException
    {
        return this.pubdate;
    }

    public String getPubdateToString() throws SQLException
    {
        if(pubdate != null)
        {
            return sdf.format(pubdate);
        }
        return "";
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM NewsPaper WHERE node=" + _nNode + " AND language=" + language);
        } finally
        {
            db.close();
        }
        _cache.remove(_nNode + ":" + language);
    }

    public static NewsPaper find(int node,int language) throws SQLException
    {
        NewsPaper newspaper = (NewsPaper) _cache.get(node + ":" + language);
        if(newspaper == null)
        {
            newspaper = new NewsPaper(node,language);
            _cache.put(node + ":" + language,newspaper);
        }
        return newspaper;
    }

    public static String getDetail(Node obj,Http h,int listing,String target,String keyword) throws SQLException
    {
        Span span = null;
        StringBuilder sb = new StringBuilder();
        NewsPaper np_obj = NewsPaper.find(obj._nNode,h.language);
        ListingDetail detail = ListingDetail.find(listing,44,h.language);
        java.util.Iterator e = detail.keys();
        while(e.hasNext())
        {
            String name = (String) e.next(),value = null;
            int istype = detail.getIstype(name);
            if(istype == 0)
            {
                continue;
            }
            if(name.equals("subject"))
            {
                if(keyword != null && keyword.length() > 0)
                {
                    value = (obj.getSubject(h.language).replaceAll(keyword,"<FONT COLOR=\"RED\">" + keyword + "</FONT>")); // obj.getSubject(iLanguage)
                } else
                {
                    value = (obj.getSubject(h.language));
                }
            } else if(name.equals("SubTitle"))
            {
                value = (np_obj.getSubTitle());
            } else if(name.equals("Content"))
            {
                if((obj.getOptions() & 0x40) == 0)
                {
                    value = (Text.toHTML(obj.getText2(h.language)));
                } else
                {
                    value = (obj.getText2(h.language));
                }
            } else if(name.equals("Qihao"))
            {
                value = String.valueOf(np_obj.getIssue());
            } else if(name.equals("Edition"))
            {
                value = (np_obj.getEdition());
            } else if(name.equals("Lanmu"))
            {
                value = (np_obj.getColumn());
            } else if(name.equals("PubDate"))
            {
                value = (np_obj.getPubdateToString());
            } else if(name.equals("Author"))
            {
                value = (np_obj.getAuthor());
            } else if(name.equals("Editor"))
            {
                value = (np_obj.getEditor());
            }
            if(detail.getAnchor(name) != 0)
            {
                Anchor anchor = new Anchor("/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/newspaper/" + obj._nNode + "-" + h.language + ".htm",value);
                anchor.setTarget(target);
                span = new Span(anchor);
            } else
            {
                span = new Span(value);
            }
            span.setId("NewsPaperID" + name);
            sb.append(detail.getBeforeItem(name) + span + detail.getAfterItem(name));
        }
        return sb.toString();
    }

    public int getLanguage()
    {
        return language;
    }

    public boolean isExists()
    {
        return exists;
    }

}
