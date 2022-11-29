package tea.entity.util;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import tea.entity.node.*;
import tea.entity.site.*;
import tea.resource.*;
import org.apache.lucene.analysis.standard.*;
import org.apache.lucene.document.*;
import org.apache.lucene.document.Field;
import org.apache.lucene.index.*;
import org.apache.lucene.search.*;
import org.apache.lucene.search.BooleanClause.*;

public class LuceneList
{
    public static Cache _cache = new Cache(50);
    public int lucenelist; //搜索
    public String community; //社区
    public String name; //名称
    public int type = 255; //类型
    public static final String SORT_TYPE[] =
            {"创建时间","相关性"};
    public int sorttype; //排序类型
    public String node_not; //排除节点
    public int hours; //小时
    public int starttime;
    public Date ltime; //上次索引
    public Date time; //创建时间

    public LuceneList(int lucenelist)
    {
        this.lucenelist = lucenelist;
    }

    public static LuceneList find(int lucenelist) throws SQLException
    {
        LuceneList t = (LuceneList) _cache.get(lucenelist);
        if(t == null)
        {
            ArrayList al = find(" AND lucenelist=" + lucenelist,0,1);
            t = al.size() < 1 ? new LuceneList(lucenelist) : (LuceneList) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT lucenelist,community,name,type,sorttype,node_not,hours,starttime,ltime,time FROM lucenelist WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                LuceneList t = new LuceneList(rs.getInt(i++));
                t.community = rs.getString(i++);
                t.name = rs.getString(i++);
                t.type = rs.getInt(i++);
                t.sorttype = rs.getInt(i++);
                t.node_not = rs.getString(i++);
                t.hours = rs.getInt(i++);
                t.starttime = rs.getInt(i++);
                t.ltime = db.getDate(i++);
                t.time = db.getDate(i++);
                _cache.put(t.lucenelist,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM lucenelist WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        String sql;
        if(lucenelist < 1)
            sql = "INSERT INTO lucenelist(lucenelist,community,name,type,sorttype,node_not,hours,starttime,ltime,time)VALUES(" + (lucenelist = Seq.get()) + "," + DbAdapter.cite(community) + "," + DbAdapter.cite(name) + "," + type + "," + sorttype + "," + DbAdapter.cite(node_not) + "," + hours + "," + starttime + "," + DbAdapter.cite(ltime) + "," + DbAdapter.cite(time) + ")";
        else
            sql = "UPDATE lucenelist SET community=" + DbAdapter.cite(community) + ",name=" + DbAdapter.cite(name) + ",type=" + type + ",sorttype=" + sorttype + ",node_not=" + DbAdapter.cite(node_not) + ",hours=" + hours + ",starttime=" + starttime + ",ltime=" + DbAdapter.cite(ltime) + ",time=" + DbAdapter.cite(time) + " WHERE lucenelist=" + lucenelist;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(lucenelist,sql);
        } finally
        {
            db.close();
        }
        _cache.remove(lucenelist);
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(lucenelist,"DELETE FROM lucenelist WHERE lucenelist=" + lucenelist);
        } finally
        {
            db.close();
        }
        _cache.remove(lucenelist);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(lucenelist,"UPDATE lucenelist SET " + f + "=" + DbAdapter.cite(v) + " WHERE lucenelist=" + lucenelist);
        } finally
        {
            db.close();
        }
        _cache.remove(lucenelist);
    }

    //
    public String getType(int lang) throws SQLException
    {
        if(type == 255)
            return "所有类型";
        Resource r = new Resource();
        return type > Node.NODE_TYPE.length ? String.valueOf(type) : r.getString(lang,Node.NODE_TYPE[type]);
    }

    public String getNodeNot(int lang) throws SQLException
    {
        if(node_not == null || node_not.length() < 1)
            return "";
        StringBuilder sb = new StringBuilder();
        String[] arr = node_not.split(",");
        for(int i = 0;i < arr.length;i++)
        {
            Node n = Node.find(Integer.parseInt(arr[i]));
            if(i > 0)
                sb.append("；");
            sb.append(n.getAnchor(lang));
        }
        return sb.toString();
    }

    public void sethours(int hours,int start) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE lucenelist SET hours=" + hours + ",starttime=" + start + " WHERE lucenelist=" + lucenelist);
        } finally
        {
            db.close();
        }
        this.hours = hours;
        this.starttime = start;
    }

    public void setLTime() throws SQLException
    {
        this.ltime = new Date();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE lucenelist SET ltime=" + DbAdapter.cite(ltime) + " WHERE lucenelist=" + lucenelist);
        } finally
        {
            db.close();
        }
    }

    public String index(int language,boolean create,Writer out) throws SQLException,IOException
    {
        File dir = new File(Http.REAL_PATH + "/res/" + community + "/searchindex/" + lucenelist + "_" + language);
        dir.mkdirs();

        StringBuilder sb = new StringBuilder();
        sb.append(" FROM Node n INNER JOIN NodeLayer nl ON n.node=nl.node");
        sb.append(" WHERE n.hidden=0 AND n.finished=1 AND nl.language=").append(language).append(" AND n.community=").append(DbAdapter.cite(community));
        if(!create)
            sb.append(" AND n.updatetime>").append(DbAdapter.cite(ltime));
        //sb.append(" AND n.node=140867");
        if(type != 255)
            sb.append(" AND n.type=").append(type);
        if(MT.f(node_not).length() > 0)
        {
            String[] arr = node_not.split(",+");
            for(int i = 0;i < arr.length;i++)
                sb.append(" AND n.path NOT LIKE '" + Node.find(Integer.parseInt(arr[i])).getPath() + "%'");
        }
        //如果存在"按栏目搜索",则只索引相关栏目下的Node
        Iterator it = Lucenechoice.find(" AND lucene IN(SELECT lucene FROM Lucene WHERE lucenelist=" + lucenelist + " AND field='path')",0,Integer.MAX_VALUE).iterator();
        if(it.hasNext())
        {
            sb.append(" AND(0=1");
            while(it.hasNext())
            {
                Lucenechoice lc = (Lucenechoice) it.next();
                try
                {
                    int n = Integer.parseInt(lc.getValue(language));
                    sb.append(" OR n.path LIKE ").append(DbAdapter.cite(Node.find(n).getPath() + "_%"));
                } catch(NumberFormatException ex1)
                {
                }
            }
            sb.append(")");
        }
        Filex.logs("lucene.txt","开始索引..." + "　ID:" + lucenelist + "　SQL:" + sb.toString());
        File lock = new File(dir,"write.lock"); //全部索引无视lock,差异索引报LockObtainFailedException
        if(lock.exists())
        {
            Filex.logs("lucene.txt","　　存在锁 " + MT.f(new Date(lock.lastModified()),1));
            if(lock.lastModified() < System.currentTimeMillis() - 1000L * 60 * 60 * 24 * 3)
                lock.delete();
            else
                return "索引生成中...<br/>开始时间：" + MT.f(new Date(lock.lastModified()),1);
        }
        ArrayList al = Lucene.find(" AND lucenelist=" + lucenelist,0,200);
        int node = 0;
        this.ltime = new Date();
        IndexWriter iw = new IndexWriter(dir,new StandardAnalyzer(),create || !new File(dir,"segments.gen").exists());
        DbAdapter db = new DbAdapter(),d2 = new DbAdapter();
        try
        {
            int sum = db.getInt("SELECT COUNT(*)" + sb.toString());
            db.executeQuery("SELECT n.node,n.path,n.rcreator,n.type,n.starttime,n.time,nl.subject,nl.keywords,nl.content" + sb.toString());
            Filex.logs("lucene.txt","　　查询完成：" + sum + "条");
            for(int c = 0;db.next();c++)
            {
                node = db.getInt(1);
                if(!create)
                    iw.deleteDocuments(new Term("node",String.valueOf(node)));
                String path = db.getString(2);
                String creator = db.getString(3);
                int type = db.getInt(4);
                Date time = db.getDate(5);
                if(time == null)
                    time = db.getDate(6);
                String subject = db.getString(7);
                String keywords = db.getString(8);
                String content = db.getText(9);
                if(type == 57) //添加贴子的回复内容
                {
                    StringBuilder sbc = new StringBuilder(content);
                    d2.executeQuery("SELECT rl.subject,rl.content FROM BBSReply r INNER JOIN BBSReplyLayer rl ON r.id=rl.bbsreply WHERE node=" + node);
                    while(d2.next())
                    {
                        sbc.append(d2.getString(1)).append("\n").append(d2.getString(2)).append("\n\n");
                    }
                    content = sbc.toString();
                }
                Document doc = new Document();
                doc.add(new Field("node",String.valueOf(node),Field.Store.YES,Field.Index.NOT_ANALYZED));
                for(int i = 0;i < al.size();i++)
                {
                    Lucene l = (Lucene) al.get(i);
                    int nt = l.ntype;
                    String f = l.field;
                    if("subject".equals(f))
                    {
                        doc.add(new Field("subject",Lucene.t(subject),Field.Store.NO,Field.Index.ANALYZED));
                    } else if("keywords".equals(f))
                    {
                        if(keywords != null)
                            doc.add(new Field("keywords",keywords,Field.Store.NO,Field.Index.ANALYZED));
                    } else if("content".equals(f))
                    {
                        doc.add(new Field("content",Lucene.t(content),Field.Store.NO,Field.Index.ANALYZED));
                    } else if("q".equals(f))
                    {
                        doc.add(new Field("q",Lucene.t(subject + "," + keywords + "," + content),Field.Store.NO,Field.Index.ANALYZED));
                    } else if("time".equals(f))
                    {
                        doc.add(new Field("time",MT.f(time),Field.Store.NO,Field.Index.NOT_ANALYZED));
                    } else if("path".equals(f))
                    {
                        path = path.replace('/',' ');
                        doc.add(new Field("path",path,Field.Store.NO,Field.Index.ANALYZED));
                    } else if("creator".equals(f))
                    {
                        doc.add(new Field("creator",creator,Field.Store.NO,Field.Index.ANALYZED));
                    } else if(nt == type)
                    {
                        String sql;
                        if(nt > 65535) //类别别名
                        {
                            nt = TypeAlias.find(nt).getType();
                        }
                        if(nt < 1024)
                        {
                            String tab = Node.NODE_TYPE[nt] + " t";
                            if(nt == 39) //有语言层的表//
                            {
                                tab = Node.NODE_TYPE[nt] + " t INNER JOIN " + Node.NODE_TYPE[nt] + "Layer tl ON t.node=tl.node";
                            }
                            sql = "SELECT " + f + " FROM " + tab + " WHERE t.node=" + node + " AND language=" + language + " AND " + f + " IS NOT NULL";
                        } else
                        {
                            sql = "SELECT value FROM DynamicValue WHERE node=" + node + " AND language=" + language + " AND dynamictype=" + f + " AND value IS NOT NULL";
                        }
                        d2.executeQuery(sql);
                        if(d2.next())
                        {
                            String value = d2.getString(1);
                            int dtype = d2.getMetaData().getColumnType(1);
                            if(dtype == 93 || dtype == 4 || dtype == -6) // 93:datetime 4:int -6:tinyint
                            {
                                doc.add(new Field(f,value,Field.Store.NO,Field.Index.NOT_ANALYZED)); //
                                if("media".equals(f))
                                {
                                    Media m = Media.find(Integer.parseInt(value));
                                    if(m.type > 0)
                                    {
                                        doc.add(new Field("medianame",m.getName(language),Field.Store.NO,Field.Index.ANALYZED));
                                    }
                                }
                            } else
                            {
                                if(f.equals("city") && value.length() % 2 == 0) //二元分词
                                {
                                    StringBuilder city = new StringBuilder();
                                    for(int j = 2;j <= value.length();j = j + 2)
                                    {
                                        city.append(value.substring(0,j)).append(" ");
                                    }
                                    value = city.toString();
                                }
                                doc.add(new Field(f,Lucene.f(value.replaceAll("/|,"," ")),Field.Store.NO,Field.Index.ANALYZED)); //分析
                            }
                        }
                    }
                }
                iw.addDocument(doc);
                if(c % 100 == 0 && out != null)
                {
                    try
                    {
                        out.write("<script>mt.progress(" + c + "," + sum + ");</script>");
                        out.flush();
                    } catch(Throwable ex)
                    {
                        Filex.logs("out.txt",ex.toString());
                    }
                }
            }
            Filex.logs("lucene.txt","　　合并索引文件");
            if(out != null)
            {
                out.write("<script>mt.show('合并索引文件...',0);</script>");
                out.flush();
            }
            iw.optimize();
			db.executeUpdate("UPDATE lucenelist SET ltime=" + DbAdapter.cite(ltime) + " WHERE lucenelist=" + lucenelist);
        } catch(Throwable ex)
        {
            Filex.logs("lucene.txt",ex);
            System.out.println("错误:" + node);
            ex.printStackTrace();
        } finally
        {
            iw.close();
            db.close();
            d2.close();
        }
        Filex.logs("lucene.txt","完成");
        return null;
    }
}
