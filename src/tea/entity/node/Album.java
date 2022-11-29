package tea.entity.node;

import tea.ui.*;
import tea.db.*;
import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.resource.*;
import tea.entity.*;

//95
public class Album
{
    public static Cache _cache = new Cache(50);
    public int node;
    public String[] author = new String[2]; //作者
    public String[] subtitle = new String[2]; //副标题
    public String[] editor = new String[2]; //新闻编辑
    public String[] source = new String[2]; //来源
    public int reserveNode;

    public Album(int node)
    {
        this.node = node;
    }

    public static Album find(int node) throws SQLException
    {
        Album t = (Album) _cache.get(node);
        if(t == null)
        {
            ArrayList al = find(" AND node=" + node,0,1);
            t = al.size() < 1 ? new Album(node) : (Album) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT node,author0,author1,subtitle0,subtitle1,editor0,editor1,source0,source1 FROM Album WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                Album t = new Album(rs.getInt(i++));
                t.author[0] = rs.getString(i++);
                t.author[1] = rs.getString(i++);
                t.subtitle[0] = rs.getString(i++);
                t.subtitle[1] = rs.getString(i++);
                t.editor[0] = rs.getString(i++);
                t.editor[1] = rs.getString(i++);
                t.source[0] = rs.getString(i++);
                t.source[1] = rs.getString(i++);
                _cache.put(t.node,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM Album WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int j = db.executeUpdate(node,"INSERT INTO Album(node,author0,author1,subtitle0,subtitle1,editor0,editor1,source0,source1)VALUES(" + node + "," + DbAdapter.cite(author[0]) + "," + DbAdapter.cite(author[1]) + "," + DbAdapter.cite(subtitle[0]) + "," + DbAdapter.cite(subtitle[1]) + "," + DbAdapter.cite(editor[0]) + "," + DbAdapter.cite(editor[1]) + "," + DbAdapter.cite(source[0]) + "," + DbAdapter.cite(source[1]) + ")");
            if(j < 1)
            {
                db.executeUpdate(node,"UPDATE Album SET author0=" + DbAdapter.cite(author[0]) + ",author1=" + DbAdapter.cite(author[1]) + ",subtitle0=" + DbAdapter.cite(subtitle[0]) + ",subtitle1=" + DbAdapter.cite(subtitle[1]) + ",editor0=" + DbAdapter.cite(editor[0]) + ",editor1=" + DbAdapter.cite(editor[1]) + ",source0=" + DbAdapter.cite(source[0]) + ",source1=" + DbAdapter.cite(source[1]) + " WHERE node=" + node);
            }
        } finally
        {
            db.close();
        }
        _cache.remove(node);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM Album WHERE node=" + node);
        _cache.remove(node);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(node,"UPDATE Album SET " + f + "=" + DbAdapter.cite(v) + " WHERE node=" + node);
        } finally
        {
            db.close();
        }
        _cache.remove(node);
    }

    //
    public String getAuthor(int lang)
    {
        return Res.f(lang,author);
    }

    public String getSubtitle(int lang)
    {
        return Res.f(lang,subtitle);
    }

    public String getEditor(int lang)
    {
        return Res.f(lang,editor);
    }

    public String getSource(int lang)
    {
        return Res.f(lang,source);
    }

    public static String getDetail(Node node,Http h,int listing,String target) throws SQLException,IOException
    {
        StringBuilder sb = new StringBuilder();
        int _nNode = node._nNode;
        String subject = node.getSubject(h.language);
        ListingDetail detail = ListingDetail.find(listing,95,h.language);
        Iterator e = detail.keys();
        while(e.hasNext())
        {
            String name = (String) e.next(),value = "";
            int istype = detail.getIstype(name);
            if(istype == 0)
                continue;

            int dq = detail.getQuantity(name);
            if("subject".equals(name))
            {
                value = subject;
            } else if("content".equals(name))
            {
                value = node.getText(h.language);
            } else if("picture".equals(name))
            {
                value = node.getPicture(h.language);
                value = value != null && value.length() > 0 ? "<img src='" + value + "'/>" : "";
            } else if("keywords".equals(name))
            {
                value = node.getKeywords(h.language);
            } else if("module".equals(name))
            {
                value = "<script>var a_node=" + _nNode + ",a_father=" + node.getFather() + ";</script>" + Filex.read(Common.REAL_PATH + "/jsp/type/album/AlbumModule.htm","utf-8");
            } else if("module2".equals(name))
            {
                String files = node.getFile(h.language);
                if(files.length() < 2)
                    continue;
                //前
                ArrayList al = Node.find1(" AND n.father=" + node.getFather() + " AND n.hidden=0 AND n.node<" + node._nNode + " ORDER BY n.node DESC",h.language,0,1);
                if(al.size() < 1)
                    al = Node.find1(" AND n.father=" + node.getFather() + " AND n.hidden=0 ORDER BY n.node DESC",h.language,0,1);
                Node prev = al.size() < 1 ? node : (Node) al.get(0);
                //后
                al = Node.find1(" AND n.father=" + node.getFather() + " AND n.hidden=0 AND n.node>" + node._nNode + " ORDER BY n.node  ASC",h.language,0,1);
                if(al.size() < 1)
                    al = Node.find1(" AND n.father=" + node.getFather() + " AND n.hidden=0 ORDER BY n.node ASC",h.language,0,1);
                Node next = al.size() < 1 ? node : (Node) al.get(0);
                //
                StringBuffer mpa = new StringBuffer(),mpt = new StringBuffer();
                value = "<link href='/tea/album/m2.css' rel='stylesheet' type='text/css' />" +
                        "<span class='ptitle'>" + node.getSubject(h.language) + "(<span id='pcount'></span>)</span>" +
                        "<div class='btn'>" +
                        "<a id='btn5' hideFocus='true' href='javascript:mp.list(false)'></a>" +
                        "<a id='btn4' hideFocus='true' href='javascript:mp.open()'></a>" +
                        "<a id='btn3' hideFocus='true' href='javascript:mp.list(true)'></a>" +
                        "<a id='btn2' hideFocus='true' href='javascript:mp.start(true)'></a>" +
                        "<div id='menu' style='display:none' onmouseover='mp.menu(true)' onmouseout='mp.menu(false)'>" +
                        "<script>for(var i=1;i<10;i++)document.write('<a href=javascript:mp.time('+i+')>'+i+'</a>');</script>" +
                        "</div>" +
                        "<a id='btn1' hideFocus='true' href='javascript:mp.start(false)'></a><a id='btn0' hideFocus='true' href='javascript:;' onmouseover='mp.menu(true)' onmouseout='mp.menu(false)'>5秒</a>" +
                        "</div>" +
                        "<div class='AlbumIDCon'>" +
                        "<table id='pbody'><tr><td valign='middle' onmousemove='mp.arrow(event,true)' onmouseout='mp.arrow(event,false)'><div id='pview'><img src='/tea/image/public/load3.gif' onload='if(width>940)width=940'/></div></td></tr></table>" +
                        "<img id='blr0' src='/tea/album/btnL_1.png' onclick='mp.view(false)' style='display:none' ><img id='blr1' src='/tea/album/btnR_1.png' onclick='mp.view(true)' style='display:none' >" +
                        //列表页
                        "<div id='plist' style='display:none;'>";
                String[] arr = files.substring(1).split("[|]");
                for(int i = 0;i < arr.length;i++)
                {
                    Attch t = Attch.find(Integer.parseInt(arr[i]));
                    value += "<a href='javascript:mp.view(" + i + ");'><img src='" + t.path3 + "' /></a>";
                    if(i > 0)
                        mpa.append(",");
                    mpa.append("{album:" + t.attch + ",subject:\"" + MT.f(t.name) + "\",content:\"" + (t.content == null ? "" : t.content.replaceAll("\"","&quot;").replaceAll("\r\n","<br/>")) + "\"}");
                    mpt.append("<a href='javascript:mp.view(" + i + ");'><img src='" + t.path3 + "' /></a>");
                }
                value += "</div>" +
                        "<div id='psubject'></div><div id='pcontent'></div>" +
                        "</div>" +
                        "<table class='pfooter' id='pfooter'><tr><td><div class='pic'><a href='/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/album/" + prev._nNode + "-" + h.language + ".htm'><img src='" + prev.getPicture(h.language) + "' /></a></div><<上一个图集</td><td><a id='btn7' hideFocus='true' href='javascript:mp.page(false)'></a><span id='ppage'>" + mpt.toString() + "</span><a id='btn8' hideFocus='true' href='javascript:mp.page(true)'></a></td><td><div class='pic'><a href='/html/album/" + next._nNode + "-" + h.language + ".htm'><img src='" + next.getPicture(h.language) + "' /></a></div>下一个图集>></td></tr></table>" +
                        "<script>mpa=[" + mpa.toString() + "];</script><script src='/tea/album/m2.js'></script>";
            }else if("module3".equals(name))
            {
                value="<include src=\"/jsp/type/album/Album.jsp?node="+_nNode+"\"/>";
            } else if("listb".equals(name))
            {
                StringBuilder pl = new StringBuilder();
                String[] arr = node.getFile(h.language).split("[|]");
                for(int i = 1;i < arr.length;i++)
                {
                    Attch al = Attch.find(Integer.parseInt(arr[i]));
                    pl.append(detail.getBeforeItem(name)).append("<span id='AlbumID" + name + "'><img src='" + al.path2 + "' /></span>").append(detail.getAfterItem(name));
                }
                sb.append(pl);
                continue;
            } else if("list".equals(name))
            {
                //String[] TYPE ={"S","B","M","T"};
                StringBuilder pl = new StringBuilder();
                String[] arr = node.getFile(h.language).split("[|]");
                for(int i = 1;i < arr.length;i++)
                {
                    Attch al = Attch.find(Integer.parseInt(arr[i]));
                    String[] val =
                            {al.path,al.path2,al.path3};
                    pl.append(detail.getBeforeItem(name)).append("<span id='AlbumID" + name + "'><img src='" + val[dq] + "' /></span>").append(detail.getAfterItem(name));
                }
                sb.append(pl);
                continue;
            } else
            {
                Album a = Album.find(_nNode);
                if("author".equals(name))
                {
                    value = a.getAuthor(h.language);
                } else if("subtitle".equals(name))
                {
                    value = a.getSubtitle(h.language);
                } else if("editor".equals(name))
                {
                    value = a.getEditor(h.language);
                } else if("source".equals(name))
                {
                    value = a.getSource(h.language);
                }
            }
            if(dq > 0)
                value = MT.f(value,dq);
            if(detail.getAnchor(name) != 0)
                value = "<a href='/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/album/" + _nNode + "-" + h.language + ".htm' target='" + target + "' title=\"" + subject + "\">" + value + "</a>";
            sb.append(detail.getBeforeItem(name)).append("<span id='AlbumID" + name + "'>" + value + "</span>").append(detail.getAfterItem(name));
        }
        return sb.toString();
    }

    public static String js(int node) throws SQLException,IOException
    {
        Node n = Node.find(node);
        String community = n.getCommunity();
        StringBuffer sb = new StringBuffer();
        //ArrayList al = findByNode(node);
        String[] arr = n.getFile(1).split("[|]");
        sb.append("{'Name':'root','Children':[{'Name':'groupimginfo', 'Content':'', 'Attributes':[], 'Children':[{'Name':'pageno', 'Content':'', 'Attributes':[], 'Children':[{'Name':'', 'Content':'" + (arr.length - 1) + "', 'Attributes':[], 'Children':[]}]},{'Name':'groupimg', 'Content':'', 'Attributes':[], 'Children':[");
        for(int i = 1;i < arr.length;i++)
        {
            Attch a = Attch.find(Integer.parseInt(arr[i]));
            if(i > 1)
                sb.append(",");
            sb.append("{'Name':'img', 'Content':'', 'Attributes':[], 'Children':[{'Name':'imgname', 'Content':'', 'Attributes':[], 'Children':[{'Name':'', 'Content':'" + MT.f(a.content).replaceAll("\r\n","<br/>") + "', 'Attributes':[], 'Children':[]}]},{'Name':'smallimgurl', 'Content':'', 'Attributes':[], 'Children':[{'Name':'', 'Content':'" + a.path3 + "', 'Attributes':[], 'Children':[]}]}");
            sb.append(",{'Name':'bigimgurl', 'Content':'', 'Attributes':[], 'Children':[{'Name':'', 'Content':'" + a.path2 + "', 'Attributes':[], 'Children':[]}]},{'Name':'cnt_article', 'Content':'', 'Attributes':[], 'Children':[{'Name':'', 'Content':'', 'Attributes':[], 'Children':[]}]},{'Name':'simg_article_url', 'Content':'', 'Attributes':[], 'Children':[{'Name':'text', 'Content':'/html/" + community + "/album/" + node + ".htm#" + i + "', 'Attributes':[], 'Children':[]}]}]}");
        }
        sb.append("]},{'Name':'last_url', 'Content':'', 'Attributes':[], 'Children':[{'Name':'', 'Content':'/a/20110308/001934.htm', 'Attributes':[], 'Children':[]}]},{'Name':'last_title', 'Content':'', 'Attributes':[], 'Children':[{'Name':'', 'Content':'高清：韩红等在政协小组上讨论限制低空飞行', 'Attributes':[], 'Children':[]}]},{'Name':'last_imgUrl', 'Content':'', 'Attributes':[], 'Children':[{'Name':'', 'Content':'http://img1.gtimg.com/news/pics/hv1/123/86/734/47750403.jpg', 'Attributes':[], 'Children':[]}]},{'Name':'continuous_play', 'Content':'', 'Attributes':[], 'Children':[{'Name':'', 'Content':'0', 'Attributes':[], 'Children':[]}]},{'Name':'simg_article_id', 'Content':'', 'Attributes':[], 'Children':[{'Name':'text', 'Content':'20110309000391', 'Attributes':[], 'Children':[]}]},{'Name':'top_content', 'Content':'', 'Attributes':[{'Name':'is_firstpage', 'Children':[{'Name':'text', 'Content':'0', 'Attributes':[], 'Children':[]}]}], 'Children':[]},{'Name':'bottom_content', 'Content':'', 'Attributes':[{'Name':'is_firstpage', 'Children':[{'Name':'text', 'Content':'0', 'Attributes':[], 'Children':[]}]}], 'Children':[]}]}]}"
                );
        Filex.write(Http.REAL_PATH + "/res/" + community + "/album/" + node / 10000 + "/N_" + node + ".js",sb.toString());
        return sb.toString();
    }
}
