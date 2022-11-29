package tea.entity.node;

import tea.db.*;
import tea.ui.*;
import tea.entity.*;
import tea.html.*;
import java.util.*;
import java.sql.SQLException;

public class Download
{
    private static Cache _cache = new Cache(100);
    private int node;
    private int commend = 2;
    private String developer;
    private int language = 1;
    private int len;
    private boolean exists;
    private String picture;
    private int[] software = new int[6];
    private String[] article = new String[6];
    private String small;

    public Download()
    {
    }

    public static Download find(int node,int language) throws SQLException
    {
        Download obj = (Download) _cache.get(node + ":" + language);
        if(obj == null)
        {
            obj = new Download(node,language);
            _cache.put(node + ":" + language,obj);
        }
        return obj;
    }

    public Download(int node,int language) throws SQLException
    {
        this.node = node;
        this.language = language;
        loadBasic();
    }

    public void set() throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            /*
             * dbadapter.executeUpdate("DownloadEdit " + (node) + "," + (language) + "," + (len) + "," + (commend) + "," + DbAdapter.cite(developer) + "," + DbAdapter.cite(picture) + "," + (software[0]) + "," + (software[1]) + "," + (software[2]) + "," + (software[3]) + "," + (software[4]) + "," + (software[5]) + "," + DbAdapter.cite(article[0]) + "," + DbAdapter.cite(article[1]) + "," + DbAdapter.cite(article[2]) + "," + DbAdapter.cite(article[3]) + "," + DbAdapter.cite(article[4]) + "," +
             * DbAdapter.cite(article[5]) + "," + DbAdapter.cite(small));
             */
            dbadapter.executeQuery("SELECT node	FROM Download	WHERE node=" + node + " AND language=" + language);
            if(dbadapter.next())
            {
                dbadapter.executeUpdate("UPDATE Download  SET len=" + (len) + "     ,commend  =" + (commend) + "  ,developer=" + DbAdapter.cite(developer) + ",picture  =" + DbAdapter.cite(picture) + "  ,software1=" + (software[0]) + ",software2=" + (software[1]) + ",software3=" + (software[2]) + ",software4=" + (software[3]) + ",software5=" + (software[4]) + ",software6=" + (software[5]) + ",article1 =" + DbAdapter.cite(article[0]) + " ,article2 =" + DbAdapter.cite(article[1]) + " ,article3 ="
                                        + DbAdapter.cite(article[2]) + " ,article4 =" + DbAdapter.cite(article[3]) + " ,article5 =" + DbAdapter.cite(article[4]) + " ,article6 =" + DbAdapter.cite(article[5]) + " ,small    =" + DbAdapter.cite(small) + " WHERE node=" + node + " AND language=" + language);
            } else
            {
                dbadapter.executeUpdate("INSERT INTO Download(node     ,language ,len     ,commend  ,developer,picture  ,software1,software2,software3,software4,software5,software6,article1 ,article2 ,article3 ,article4 ,article5 ,article6 ,small    )VALUES (" + node + "," + language + " ," + len + "  ," + commend + "  ," + DbAdapter.cite(developer) + "," + DbAdapter.cite(picture) + "  ," + (software[0]) + "," + (software[1]) + "," + (software[2]) + "," + (software[3]) + "," + (software[4])
                                        + "," + (software[5]) + "," + DbAdapter.cite(article[0]) + " ," + DbAdapter.cite(article[1]) + " ," + DbAdapter.cite(article[2]) + " ," + DbAdapter.cite(article[3]) + " ," + DbAdapter.cite(article[4]) + " ," + DbAdapter.cite(article[5]) + " ," + DbAdapter.cite(small) + " )");
            }
        } finally
        {
            dbadapter.close();
        }
        _cache.remove(node + ":" + language);
    }

    public void delete(int id) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("DELETE DownloadAddress WHERE id=" + id);
        } finally
        {
            dbadapter.close();
        }
        _cache.remove(node + ":" + language);
    }

    public static java.util.Enumeration getCorrelation(Node node,int language,int type,int top) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        String keyword = node.getKeywords(language);
        if(keyword != null && keyword.length() > 0)
        {
            tea.db.DbAdapter dbadapter = new tea.db.DbAdapter();
            try
            {
                StringBuilder where = new StringBuilder();
                java.util.StringTokenizer tokenizer = new java.util.StringTokenizer(keyword," ");
                where.append(" UPPER(keywords) LIKE UPPER(" + ("N'%" + tokenizer.nextToken() + "%'") + ")");
                while(tokenizer.hasMoreTokens())
                {
                    where.append(" OR UPPER(keywords) LIKE UPPER(" + ("N'%" + tokenizer.nextToken() + "%'") + ")");
                }
                dbadapter.executeQuery("SELECT Node.node FROM NodeLayer,Node WHERE NodeLayer.node=Node.node AND finished=1 AND hidden=0 AND type=" + type + " AND NodeLayer.language=" + language + " AND Node.node<>" + node._nNode + " AND( " + where.toString() + ")");
                for(int i = 0;(top == 0 || i < top) && dbadapter.next();i++)
                {
                    vector.addElement(new Integer(dbadapter.getInt(1)));
                }
            } catch(Exception ex)
            {
                ex.printStackTrace();
            } finally
            {
                dbadapter.close();
            }
        }
        return vector.elements();
    }

    /*
     * public void create() throws SQLException { DbAdapter dbadapter = new DbAdapter(); try { dbadapter.executeUpdate( "INSERT INTO Download( node, len, commend, developer, language,picture,software1,software2,software3,software4,software5,software6,article1,article2,article3,article4,article5,article6)VALUES( " + node + "," + len + "," + commend + "," + DbAdapter.cite(developer) + "," + language + "," + DbAdapter.cite(this.picture) + "," + this.software[0] + "," + this.software[1] + "," +
     * this.software[2] + "," + this.software[3] + "," + this.software[4] + "," + this.software[5] + "," + this.article[0] + "," + this.article[1] + "," + this.article[2] + "," + this.article[3] + "," + this.article[4] + "," + this.article[5] + ")"); this.exists = true; } finally { dbadapter.close(); } }
     */
    private void loadBasic() throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            // int j = dbadapter.getInt("DownloadGetLanguage " + node + "," + language);
            int j = this.getLanguage(language);
            dbadapter.executeQuery("SELECT len ,    commend,    developer ,    language,picture   , software1 , software2 , software3 , software4 , software5 , software6,  article1 ,  article2 ,  article3 ,  article4 ,  article5  ,  article6,small  FROM Download WHERE node= " + node + " AND language=" + j);
            if(dbadapter.next())
            {
                len = dbadapter.getInt(1);
                commend = dbadapter.getInt(2);
                developer = dbadapter.getVarchar(j,language,3);
                // language = dbadapter.getInt(4);
                this.picture = dbadapter.getString(5);
                /*
                 * for (int index = 0; index < software.length; index++) { this.software[index] = dbadapter.getInt(index + 6); this.article[index] = dbadapter.getInt(software.length + index + 6); }
                 */
                article[0] = dbadapter.getString(12);
                article[1] = dbadapter.getVarchar(1,1,13);
                article[2] = dbadapter.getString(14);
                article[3] = dbadapter.getVarchar(1,1,15);
                article[4] = dbadapter.getString(16);
                article[5] = dbadapter.getVarchar(1,1,17);
                small = dbadapter.getString(18);
                exists = true;
            } else
            {
                exists = false;
            }
        } finally
        {
            dbadapter.close();
        }
    }

    private int getLanguage(int language) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT language FROM Download WHERE node=" + node);
            while(dbadapter.next())
            {
                v.addElement(new Integer(dbadapter.getInt(1)));
            }
        } finally
        {
            dbadapter.close();
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

    public void setCommend(int commend)
    {
        this.commend = commend;
    }

    public void setDeveloper(String developer)
    {
        this.developer = developer;
    }

    public void setLanguage(int language)
    {
        this.language = language;
    }

    public void setSize(int len) throws SQLException
    {
        this.len = len;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("UPDATE Download SET len=" + this.len + " WHERE node= " + node);
        } catch(Exception e)
        {
            e.printStackTrace();
        } finally
        {
            dbadapter.close();
        }
    }

    public static String getDetail(Node obj,Http h,int listing,String target,tea.resource.Resource r) throws SQLException
    {
        Span span = null;
        StringBuilder sb = new StringBuilder();
        int node = obj._nNode;
        String subject = obj.getSubject(h.language);
        tea.entity.node.Download download = Download.find(node,h.language);
        ListingDetail detail = ListingDetail.find(listing,63,h.language);
        java.util.Iterator enumeration = detail.keys(); // Download.getDetail(node, listing, _nLanguage);
        while(enumeration.hasNext())
        {
            String itemname = (String) enumeration.next(),value = null;
            int istype = detail.getIstype(itemname);
            if(istype == 0)
            {
                continue;
            }
            if(itemname.equals("subject"))
            {
                value = (subject);
            } else if(itemname.equals("url")) // 下载的链接
            {
                java.util.Enumeration enumer = DownloadAddress.findByNode(node);
                StringBuilder sbDown = new StringBuilder();
                if(enumer != null)
                {
                    int id;
                    while(enumer.hasMoreElements())
                    {
                        DownloadAddress da = (DownloadAddress) enumer.nextElement();
                        id = da.getId();
                        String url = da.getUrl();
                        String alt = da.getName() + " " + da.getVer();
                        if(url.startsWith("/tea/download/"))
                        {
                            Anchor a = new tea.html.Anchor("/jsp/type/download/Down.jsp?id=" + id + "&node=" + node,alt);
                            sbDown.append(a.toString() + "<BR>");
                        } else
                        {
                            url = url.toLowerCase();
                            if(url.endsWith(".jpg") || url.endsWith(".gif") || url.endsWith(".png") || url.endsWith(".bmp") || url.endsWith(".tif") || url.endsWith(".pcx") || url.endsWith(".ras") || url.endsWith(".rsb") || url.endsWith(".sgi") || url.endsWith(".tga"))
                            {
                                tea.html.Image img = new tea.html.Image("/jsp/type/download/Down.jsp?id=" + id + "&node=" + node,alt);
                                img.setHeight(100);
                                img.setWidth(100);
                                img.setAlt(subject);
                                sbDown.append(img + "<BR>");
                            } else
                            {
                                tea.html.Anchor a = new tea.html.Anchor(url,alt);
                                sbDown.append(a.toString() + "<BR>");
                            }
                        }
                    }
                }
                value = (sbDown.toString());
            } else if(itemname.equals("text"))
            {
                if(detail.getQuantity(itemname) == 0)
                {
                    if((obj.getOptions() & 0x40) == 0)
                    {
                        value = (tea.html.Text.toHTML(obj.getText2(h.language)));
                    } else
                    {
                        value = (obj.getText2(h.language));
                    }
                } else
                {
                    value = (obj.getText(h.language));
                }
            } else if(itemname.equals("access"))
            {
                value = String.valueOf(obj.getClick());
            } else if(itemname.equals("language"))
            {
                if(download.getLanguage() != -1)
                {
                    value = (r.getString(h.language,tea.resource.Common.LANGUAGE[download.getLanguage()]));
                } else
                {
                    value = (null);
                }
            } else if(itemname.equals("commend"))
            {
                StringBuilder sbcommend = new StringBuilder();
                for(int commend = download.getCommend();commend > 0;commend--)
                {
                    sbcommend.append("☆"); // ★☆
                }
                value = (sbcommend.toString());
            } else if(itemname.equals("developer"))
            {
                tea.html.Anchor anchor = new tea.html.Anchor(download.getDeveloper(),download.getDeveloper());
                anchor.setTarget("_blank");
                value = (anchor.toString());
            } else if(itemname.equals("software")) // 相关软件
            {
                StringBuilder sb_soft = new StringBuilder();
                ArrayList enumer = obj.getCorrelation(h.language,63,detail.getQuantity(itemname),null);
                for(int index = 0;index < enumer.size();index++)
                {
                    Node n = (Node) enumer.get(index);
                    sb_soft.append(n.getAnchor(h.language).toString() + "<br>");
                }
                value = sb_soft.toString();
            } else if(itemname.equals("article2")) // 相关文章(手动)
            {
                String article[] = download.getArticle();
                StringBuilder sb_article = new StringBuilder();
                for(int index = 0;index < article.length;index += 2)
                {
                    if(article[index] != null && article[index].length() > 4)
                    {
                        tea.html.Anchor anchor = new tea.html.Anchor(article[index],article[index + 1]);
                        sb_article.append(anchor.toString() + "<BR>");
                    }
                }
                value = (sb_article.toString());
            } else if(itemname.equals("article")) // 相关文章
            {
                StringBuilder sb_article = new StringBuilder();
                ArrayList enumer = obj.getCorrelation(h.language,39,detail.getQuantity(itemname),null);
                for(int index = 0;index < enumer.size();index++)
                {
                    Node n = (Node) enumer.get(index);
                    sb_article.append(n.getAnchor(h.language).toString() + "<br>");
                }
                value = (sb_article.toString());
            } else if(itemname.equals("search")) // 相关搜索
            {
                tea.html.Anchor google = new tea.html.Anchor("http://www.google.cn/custom?q=" + subject + "&client=pub-1178949244591662&forid=1&ie=UTF-8&oe=UTF-8&hl=zh-CN","在GOOGLE中搜索“" + subject + "”");
                google.setTarget("_blank");
                tea.html.Anchor baidu = new tea.html.Anchor("http://www.baidu.com/s?wd=" + subject + "&cl=3","在百度中搜索“" + subject + "”");
                baidu.setTarget("_blank");
                value = (google.toString() + "<BR>" + baidu.toString());
            } else if(itemname.equals("picture"))
            {
                String picture = download.getPicture();
                if(picture != null && picture.length() > 0)
                {
                    tea.html.Image img = new tea.html.Image(picture,subject);
                    value = (img.toString());
                } else
                {
                    value = (null);
                }
            } else if(itemname.equals("small"))
            {
                String small = download.getSmall();
                String picture = download.getPicture();
                if(small != null && small.length() > 0)
                {
                    tea.html.Image img = new tea.html.Image(small,subject);
                    value = (img.toString());
                } else if(picture != null && picture.length() > 0)
                {
                    tea.html.Image img = new tea.html.Image(picture,subject);
                    img.setWidth(240);
                    img.setHeight(160);
                    value = (img.toString());
                } else
                {
                    value = (null);
                }
            } else if(itemname.equals("len"))
            {
                String len;
                if(download.getSize() > 1024)
                {
                    len = (download.getSize() * 100 / 1024) / 100F + " M";
                } else if(download.getSize() <= 0)
                {
                    len = "";
                } else
                {
                    len = download.getSize() + " K";
                }
                value = (len);
            }
            switch(detail.getAnchor(itemname))
            {
            case 1:
                Anchor anchor = new Anchor("/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/download/" + node + "-" + h.language + ".htm",value);
                anchor.setTarget(target);
                span = new Span(anchor);
                break;
            case 2:
                anchor = new Anchor(download.getPicture(),value);
                anchor.setTarget("_blank");
                span = new Span(anchor);
                break;
            default:
                span = new Span(value);
            }
            span.setId("DownloadID" + itemname);
            sb.append(detail.getBeforeItem(itemname) + span + detail.getAfterItem(itemname));
        }
        return sb.toString();
    }

    public void setExists(boolean exists)
    {
        this.exists = exists;
    }

    public void setPicture(String picture)
    {
        this.picture = picture;
    }

    public void setSoftware(int[] software)
    {
        this.software = software;
    }

    public void setArticle(String[] article)
    {
        this.article = article;
    }

    public void setSmall(String small)
    {
        this.small = small;
    }

    public int getNode()
    {
        return node;
    }

    public int getCommend()
    {
        return commend;
    }

    public String getDeveloper()
    {
        return developer;
    }

    public int getLanguage()
    {
        return language;
    }

    public int getSize()
    {
        return len;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getPicture()
    {
        return picture;
    }

    public int[] getSoftware()
    {
        return software;
    }

    public String[] getArticle()
    {
        return article;
    }

    public String getSmall()
    {
        return small;
    }
}
