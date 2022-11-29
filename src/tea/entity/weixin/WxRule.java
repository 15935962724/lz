package tea.entity.weixin;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import tea.entity.node.Node;
import tea.translator.Translator;

public class WxRule extends Entity
{
    public int wxrule; //关键词规则
    public String community; //社区
    public String name; //名称
    public String[] keyword = new String[10]; //关键字
    public static String[] WXRULE_TYPE =
            {"--","文本","图文"};
    public int type; //类型
    public String[] content =
            {null,null,"|"}; //--,文本,图文
    public int hits; //次数
    public Date time; //时间

    public WxRule(int wxrule)
    {
        this.wxrule = wxrule;
    }

    public static WxRule find(int wxrule) throws SQLException
    {
        WxRule t = (WxRule) _cache.get(wxrule);
        if(t == null)
        {
            ArrayList al = find(" AND wxrule=" + wxrule,0,1);
            t = al.size() < 1 ? new WxRule(wxrule) : (WxRule) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT wxrule,community,name,keyword0,keyword1,keyword2,keyword3,keyword4,keyword5,keyword6,keyword7,keyword8,keyword9,type,content1,content2,hits,time FROM wxrule WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                WxRule t = new WxRule(rs.getInt(i++));
                t.community = rs.getString(i++);
                t.name = rs.getString(i++);
                t.keyword[0] = rs.getString(i++);
                t.keyword[1] = rs.getString(i++);
                t.keyword[2] = rs.getString(i++);
                t.keyword[3] = rs.getString(i++);
                t.keyword[4] = rs.getString(i++);
                t.keyword[5] = rs.getString(i++);
                t.keyword[6] = rs.getString(i++);
                t.keyword[7] = rs.getString(i++);
                t.keyword[8] = rs.getString(i++);
                t.keyword[9] = rs.getString(i++);
                t.type = rs.getInt(i++);
                t.content[1] = rs.getString(i++);
                t.content[2] = rs.getString(i++);
                t.hits = rs.getInt(i++);
                t.time = db.getDate(i++);
                _cache.put(t.wxrule,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM wxrule WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        String sql;
        if(wxrule < 1)
            sql = "INSERT INTO wxrule(wxrule,community,name,keyword0,keyword1,keyword2,keyword3,keyword4,keyword5,keyword6,keyword7,keyword8,keyword9,type,content1,content2,hits,time)VALUES(" + (wxrule = Seq.get()) + "," + DbAdapter.cite(community) + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(keyword[0]) + "," + DbAdapter.cite(keyword[1]) + "," + DbAdapter.cite(keyword[2]) + "," + DbAdapter.cite(keyword[3]) + "," + DbAdapter.cite(keyword[4]) + "," + DbAdapter.cite(keyword[5]) + "," + DbAdapter.cite(keyword[6]) + "," + DbAdapter.cite(keyword[7]) + "," + DbAdapter.cite(keyword[8]) + "," + DbAdapter.cite(keyword[9]) + "," + type + "," + DbAdapter.cite(content[1]) + "," + DbAdapter.cite(content[2]) + "," + hits + "," + DbAdapter.cite(time) + ")";
        else
            sql = "UPDATE wxrule SET name=" + DbAdapter.cite(name) + ",keyword0=" + DbAdapter.cite(keyword[0]) + ",keyword1=" + DbAdapter.cite(keyword[1]) + ",keyword2=" + DbAdapter.cite(keyword[2]) + ",keyword3=" + DbAdapter.cite(keyword[3]) + ",keyword4=" + DbAdapter.cite(keyword[4]) + ",keyword5=" + DbAdapter.cite(keyword[5]) + ",keyword6=" + DbAdapter.cite(keyword[6]) + ",keyword7=" + DbAdapter.cite(keyword[7]) + ",keyword8=" + DbAdapter.cite(keyword[8]) + ",keyword9=" + DbAdapter.cite(keyword[9]) + ",type=" + type + ",content1=" + DbAdapter.cite(content[1]) + ",content2=" + DbAdapter.cite(content[2]) + ",hits=" + hits + ",time=" + DbAdapter.cite(time) + " WHERE wxrule=" + wxrule;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(wxrule,sql);
        } finally
        {
            db.close();
        }
        _cache.remove(wxrule);
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(wxrule,"DELETE FROM wxrule WHERE wxrule=" + wxrule);
        } finally
        {
            db.close();
        }
        _cache.remove(wxrule);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(wxrule,"UPDATE wxrule SET " + f + "=" + DbAdapter.cite(v) + " WHERE wxrule=" + wxrule);
        } finally
        {
            db.close();
        }
        _cache.remove(wxrule);
    }

    public String getKeyword()
    {
        StringBuilder sb = new StringBuilder();
        for(int i = 0;i < keyword.length;i++)
        {
            if(keyword[i] == null)
                continue;
            sb.append(keyword[i]).append("；");
        }
        return sb.toString();
    }

    public static String find(Http h,String content) throws SQLException
    {
        String sn = "http://" + h.request.getServerName();
        StringBuilder sql = new StringBuilder(),sb = new StringBuilder();
        sql.append(" AND community=" + Database.cite(h.community));
        sql.append(" AND " + Database.cite(content) + " IN(");
        for(int i = 0;i < 10;i++)
            sql.append(i == 0 ? "" : ",").append("keyword" + i);
        sql.append(")"); // ORDER BY NEWID()
        ArrayList al = WxRule.find(sql.toString(),0,1);
        if(al.size() > 0)
        {
            WxRule r = (WxRule) al.get(0);
            if(r.type == 1)
            {
                sb.append("  <MsgType>text</MsgType>");
                sb.append("  <Content><![CDATA[" + r.content[1].replace("${openid}",h.key).replace("${wxuser}",MT.enc(h.member)) + "]]></Content>");
            } else
            {
                String[] arr = r.content[2].split("[|]");
                sb.append("  <MsgType>news</MsgType>");
                sb.append("  <ArticleCount>" + (arr.length - 1) + "</ArticleCount>");
                sb.append("<Articles>");
                for(int j = 1;j < arr.length;j++)
                {
                    Node a = Node.find(Integer.parseInt(arr[j]));
                    String url = a.getAnchor(h.language,1);
                    if(url.charAt(0) == '/')
                        url = sn + "/WeiXins.do?act=openid&openid=" + Http.enc(h.key) + "&community=" + h.community + "&nexturl=" + Http.enc(url);
                    sb.append("<item><Title><![CDATA[" + a.getSubject(h.language) + "]]></Title><Description><![CDATA[" + a.getDescription(h.language) + "]]></Description><PicUrl><![CDATA[" + sn + Http.enc(MT.f(a.getPicture(h.language),"/tea/image/404.jpg")).replaceAll("%2F","/") + "]]></PicUrl><Url><![CDATA[" + url + "]]></Url></item>");
                }
                sb.append("</Articles>");
            }
            r.set("hits",String.valueOf(++r.hits));
        } else
        {
            sql = new StringBuilder();
            sql.append(" AND n.type IN(" + h.get("type") + ")");
            if(h.node > 0)
                sql.append(" AND n.path LIKE '" + Node.find(h.node).getPath() + "%'");
            sql.append(" AND n.hidden=0");
            String q = content;
            if("mifce".equals(h.community)) //简体转繁体
                q = Translator.getInstance().translate(q,1,2);
            String[] arr = q.split(" +");
            for(int i = 0;i < arr.length;i++)
                sql.append(" AND nl.subject LIKE " + DbAdapter.cite("%" + arr[i] + "%"));

            al = Node.find1(sql.toString(),h.language,0,10);
            if(al.size() < 1)
            {
                sb.append("  <MsgType>text</MsgType>");
                sb.append("  <Content><![CDATA[" + WeiXin.find(h.community).notfound + "<a href=\"" + sn + "#openid=" + h.key + "\"> </a>" + "]]></Content>");
            } else
            {
                sb.append("  <MsgType>news</MsgType>");
                sb.append("  <Content>content</Content>");
                sb.append("  <ArticleCount>" + al.size() + "</ArticleCount>");
                sb.append("  <Articles>");
                for(int i = 0;i < al.size();i++)
                {
                    Node n = (Node) al.get(i);
                    String picture = n.getPicture(h.language);
                    if(picture != null && picture.length() > 1)
                    {
                        if(picture.endsWith("#auto"))
                            picture = picture.substring(0,picture.length() - 5);
                        picture = Http.enc(picture).replaceAll("%2F","/");
                    }
                    content = n.getDescription(h.language);
                    content = MT.f(content.replaceAll("<[^>]+>|&nbsp;",""),100);
                    sb.append("    <item>");
                    sb.append("      <Title><![CDATA[" + n.getSubject(h.language) + "]]></Title>");
                    sb.append("      <Discription><![CDATA[" + content + "]]></Discription>");
                    sb.append("      <PicUrl><![CDATA[" + sn + picture + "]]></PicUrl>");
                    sb.append("      <Url><![CDATA[" + sn + n.getAnchor(h.language,1) + "]]></Url>");
                    sb.append("    </item>");
                }
                sb.append("  </Articles>");
            }
        }
        return sb.toString();
    }
}
