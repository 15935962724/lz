package tea.entity.util;

import java.io.*;
import java.util.*;
import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;

import org.apache.lucene.index.*;
import org.apache.lucene.search.*;
import org.apache.lucene.document.*;
import org.apache.lucene.queryParser.*;
import org.apache.lucene.analysis.standard.*;
import tea.db.DbAdapter;
import tea.entity.*;
import tea.entity.node.*;
import java.sql.SQLException;
import tea.resource.*;
import tea.ui.*;
import tea.entity.site.DynamicType;
import tea.entity.site.TypeAlias;

public class Lucene extends Entity
{
    public static final String QUERY_TYPE[] =
            {"关键字搜索","某一范围内搜索","词条搜索"}; //{"QueryParser","RangeQuery","TermQuery"};
    public static final String INPUT_TYPE[] =
            {"text","radio","select","group"};
    public static Cache _cache = new Cache(100);
    public int lucene;
    public int lucenelist;
    public int qtype;
    public int sequence;
    public int itype;
    public int ntype;
    public String field;
    private boolean exists;
    private Hashtable _htLayer;
    class Layer
    {
        private String subject;
        private String beforeitem;
        private String afteritem;
        private boolean layerExists;
    }


    public Lucene(int lucene) throws SQLException
    {
        this.lucene = lucene;
        _htLayer = new Hashtable();
    }

    public Lucene(int lucene,int lucenelist,int qtype,int itype,int sequence) throws SQLException
    {
        this.lucene = lucene;
        this.lucenelist = lucenelist;
        this.qtype = qtype;
        this.itype = itype;
        this.sequence = sequence;
    }

    public static Lucene find(int lucene) throws SQLException
    {
        Lucene t = (Lucene) _cache.get(lucene);
        if(t == null)
        {
            ArrayList al = find(" AND lucene=" + lucene,0,1);
            t = al.size() < 1 ? new Lucene(lucene) : (Lucene) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList(size);
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT lucene,lucenelist,qtype,itype,ntype,field,sequence FROM Lucene WHERE 1=1" + sql + " ORDER BY sequence",pos,size);
            while(db.next())
            {
                int j = 1;
                Lucene t = new Lucene(db.getInt(j++));
                t.lucenelist = db.getInt(j++);
                t.qtype = db.getInt(j++);
                t.itype = db.getInt(j++);
                t.ntype = db.getInt(j++);
                t.field = db.getString(j++);
                t.sequence = db.getInt(j++);
                al.add(t);
                _cache.put(t.lucene,t);
            }
        } finally
        {
            db.close();
        }
        return al;
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(lucene,"UPDATE Lucene SET " + f + "=" + DbAdapter.cite(v) + " WHERE lucene=" + lucene);
        } finally
        {
            db.close();
        }
		_cache.remove(lucene);
    }

    public void set() throws SQLException
    {
        String sql;
        if(lucene < 1)
        {
            sequence = (int) (System.currentTimeMillis() / 1000);
            sql = "INSERT INTO Lucene(lucene,lucenelist,qtype,itype,ntype,field,sequence)VALUES(" + (lucene = Seq.get()) + "," + lucenelist + "," + qtype + "," + itype + "," + ntype + "," + DbAdapter.cite(field) + "," + sequence + ")";
        } else
            sql = "UPDATE Lucene SET qtype=" + qtype + ",itype=" + itype + ",ntype=" + ntype + ",field=" + DbAdapter.cite(field) + " WHERE lucene=" + lucene;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(lucene,sql);
        } finally
        {
            db.close();
        }
		_cache.remove(lucene);
    }

    public void setLayer(int language,String subject,String beforeitem,String afteritem) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int j = db.executeUpdate(lucene,"UPDATE LuceneLayer SET subject=" + DbAdapter.cite(subject) + ",beforeitem=" + DbAdapter.cite(beforeitem) + ",afteritem=" + DbAdapter.cite(afteritem) + " WHERE lucene=" + lucene + " AND language=" + language);
            if(j < 1)
            {
                db.executeUpdate(lucene,"INSERT INTO LuceneLayer(lucene,language,subject,beforeitem,afteritem)VALUES(" + lucene + "," + language + "," + DbAdapter.cite(subject) + "," + DbAdapter.cite(beforeitem) + "," + DbAdapter.cite(afteritem) + ")");
            }
        } finally
        {
            db.close();
        }
        _htLayer.clear();
    }

    public void delete(int language) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(lucene,"DELETE FROM LuceneLayer WHERE lucene=" + lucene + " AND language=" + language);
            db.executeQuery("SELECT lucene FROM LuceneLayer WHERE lucene=" + lucene);
            if(!db.next())
            {
                db.executeUpdate(lucene,"DELETE FROM Lucene WHERE lucene=" + lucene);
                _cache.remove(lucene);
                exists = false;
            } else
            {
                _htLayer.clear();
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
            db.executeQuery("SELECT language FROM LuceneLayer WHERE lucene=" + lucene);
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

    private Layer getLayer(int language) throws SQLException
    {
        Layer layer = (Layer) _htLayer.get(new Integer(language));
        if(layer == null)
        {
            layer = new Layer();
            int j = getLanguage(language);
            layer.layerExists = j == language;
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT subject,beforeitem,afteritem FROM LuceneLayer WHERE lucene=" + lucene + " AND language=" + j);
                if(db.next())
                {
                    layer.subject = db.getVarchar(j,language,1);
                    layer.beforeitem = db.getText(j,language,2);
                    layer.afteritem = db.getText(j,language,3);
                }
            } finally
            {
                db.close();
            }
            _htLayer.put(Integer.valueOf(language),layer);
        }
        return layer;
    }


    public String getSubject(int language) throws SQLException
    {
        return getLayer(language).subject;
    }

    public String getBefore(int language) throws SQLException
    {
        return getLayer(language).beforeitem;
    }

    public String getAfter(int language) throws SQLException
    {
        return getLayer(language).afteritem;
    }

    public boolean isLayerExists(int language) throws SQLException
    {
        return getLayer(language).layerExists;
    }

    public String getItypeToHtml(Http h) throws SQLException
    {
        String value = h.get(field,"");
        int lang = h.language;
        StringBuilder htm = new StringBuilder();
        switch(itype)
        {
        case 0:
            if(qtype == 1)
            {
                String name_b = field + "_begin";
                htm.append("<input name=\"" + name_b + "\" value=\"" + h.get(name_b,"") + "\" /><img src='/tea/image/public/Calendar2.gif' onclick=\"showCalendar('searchform1." + name_b + "');\"/>");
                String name_e = field + "_end";
                htm.append("<span id='searchto'> -- </span><input type='text' name=\"" + name_e + "\" value=\"" + h.get(name_e,"") + "\" /><img src='/tea/image/public/Calendar2.gif' onclick=\"showCalendar('searchform1." + name_e + "');\"/>");
            } else
            {
                htm.append("<input name=\"" + field + "\" value=\"" + value.replaceAll("\"","&quot;") + "\" />");
            }
            break;
        case 1:
            Iterator it = Lucenechoice.find(" AND lucene=" + lucene,0,Integer.MAX_VALUE).iterator();
            if(it.hasNext())
            {
                for(int j = 0;it.hasNext();j++)
                {
                    Lucenechoice lc_obj = (Lucenechoice) it.next();
                    int lc_id = lc_obj.lucenechoice;
                    htm.append("<span><input name='" + field + "' type='radio' id='radiolc" + lc_id + "' value=\"" + lc_obj.getValue(h.language) + "\"");
                    if((value == null && j == 0) || lc_obj.getValue(h.language).equals(value))
                    {
                        htm.append(" checked='' ");
                    }
                    htm.append("/><label for='radiolc" + lc_id + "'>" + lc_obj.getLabel(h.language) + "</label></span>");
                }
            } else if(ntype > 1023) //鑺傜偣绫诲瀷
            {
                DynamicType dt = DynamicType.find(Integer.parseInt(field));
                String dtt = dt.getType();
                if(dtt.equals("select") || dtt.equals("radio"))
                {
                    String cs[] = dt.getContent(lang).split("/");
                    for(int j = 1;j < cs.length;j++)
                    {
                        htm.append("<span><input name='" + field + "' type='radio' id='radiolc" + j + "' value=\"" + cs[j] + "\"");
                        if((value == null && j == 0) || cs[j].equals(value))
                        {
                            htm.append(" checked='' ");
                        }
                        htm.append("/><label for='radiolc" + j + "'>" + cs[j] + "</label></span>");
                    }
                }
            }
            break;

        case 2:
            htm.append("<select name=\"" + field + "\" >");
            it = Lucenechoice.find(" AND lucene=" + lucene,0,Integer.MAX_VALUE).iterator();
            if(it.hasNext())
            {
                for(int j = 0;it.hasNext();j++)
                {
                    Lucenechoice lc_obj = (Lucenechoice) it.next();
                    int lc_id = lc_obj.lucenechoice;
                    htm.append("<option value=\"" + lc_obj.getValue(h.language) + "\"");
                    if(value != null && value.equals(lc_obj.getValue(h.language)))
                    {
                        htm.append(" selected='' ");
                    }
                    htm.append(" >" + lc_obj.getLabel(h.language) + "</option>");
                }
            } else if(ntype > 1023) //鑺傜偣绫诲瀷
            {
                DynamicType dt = DynamicType.find(Integer.parseInt(field));
                String dtt = dt.getType();
                if(dtt.equals("select") || dtt.equals("radio"))
                {
                    String cs[] = dt.getContent(lang).split("/");
                    for(int j = 1;j < cs.length;j++)
                    {
                        htm.append("<option value=\"" + cs[j] + "\"");
                        if(value != null && value.equals(cs[j]))
                        {
                            htm.append(" selected='' ");
                        }
                        htm.append(" >" + cs[j] + "</option>");
                    }
                }
            }
            htm.append("</select>");
            break;

        case 3:
            value = h.get("group");
            htm.append("<span><input name='group' type='radio' id='radiol" + lucene + "' value=\"" + field + "\"");
            if(value == null || field.equals(value))
            {
                value = field;
                htm.append(" checked='' ");
            }
            htm.append("/><label for='radiol" + lucene + "'>" + getSubject(lang) + "</label></span>");
            break;
        }
        return htm.toString();
    }


//    public String getKey()
//    {
//        if("q".equals(field) || "subject".equals(field) || "content".equals(field) || "keywords".equals(field) || "path".equals(field) || "creator".equals(field))
//        {
//            return field;
//        }
//        return "t" + ntype + "_" + field;
//    }

    /*
        public static void index_diff(String community, int lucenelist, int language, Writer out) throws SQLException, IOException
        {
            int count = 0;
            File file = new File(Common.REAL_PATH + "/res/" + community + "/searchindex/" + lucenelist + "_" + language);
            if (!file.exists())
            {
                file.mkdirs();
            }
            Date modified = new Date(file.lastModified());
            LuceneList ll = LuceneList.find(lucenelist);

            StringBuilder sb = new StringBuilder();
            sb.append("SELECT n.node,n.path,n.time,nl.subject,nl.content FROM Node n INNER JOIN NodeLayer nl ON n.node=nl.node and n.updatetime>" + DbAdapter.cite(modified));
            sb.append(" WHERE n.hidden=0 AND n.finished=1 AND nl.language=").append(language).append(" AND n.community=").append(DbAdapter.cite(community));

            if (ll.type != 255)
            {
                sb.append(" AND type=").append(ll.type);
            }
            if (MT.f(ll.node_not).length() > 0)
            {
                String[] arr = ll.node_not.split(",+");
                for (int i = 1; i < arr.length; i++)
                    sb.append(" AND path NOT LIKE '" + Node.find(Integer.parseInt(arr[i])).getPath() + "%'");
            }
            sb.append(" order by n.time desc ");

            System.out.println(sb.toString());
            Vector v = findByLucenelist(lucenelist);
            boolean bool = false; // path.list().length < 1;
            DbAdapter db = new DbAdapter();

            try
            {
                IndexReader ir = IndexReader.open(file);
                IndexSearcher is = new IndexSearcher(file.getAbsolutePath());
                StandardAnalyzer sa = new StandardAnalyzer();

                db.executeQuery(sb.toString());
                while (db.next())
                {
                    int node = db.getInt(1);
                    //System.out.println("node:" + node);
                    BooleanQuery bq = new BooleanQuery();
                    bq.add(new TermQuery(new Term("t255_node", String.valueOf(node))), BooleanClause.Occur.MUST);
                    Hits hits = is.search(bq);

                    int length = hits.length();
                    //System.out.println("length:" + length);
                    for (int i = 0; i < length; i++)
                    {
                        int delete = hits.id(i);
                        System.out.println("delete id" + delete);
                        ir.deleteDocument(delete);
                    }

                }
                ir.close();

                //  ir.unlock(new Directory(file));
            } catch (Exception ex)
            {
                ex.printStackTrace();
            } finally
            {
                db.close();
            }
            DbAdapter db1 = new DbAdapter();
            DbAdapter db2 = new DbAdapter();
            try
            {
                IndexWriter iw = new IndexWriter(file, new StandardAnalyzer(), bool);
                ll.setlastindex(lucenelist);
                db1.executeQuery(sb.toString());
                while (db1.next())
                {
                    int node = db1.getInt(1);
                    String path = db1.getString(2).replaceAll("/", " ");
                    String time = sdf.format(db1.getDate(3));
                    String subject = htmlToText(db1.getVarchar(1, 1, 4));
                    String content = htmlToText(db1.getText(1, 1, 5)) + " " + subject;

                    Document doc = new Document();
                    doc.add(new Field("node", String.valueOf(node), Field.Store.YES, Field.Index.TOKENIZED)); // Field.UnIndexed("node", String.valueOf(node))); 鍙槸鎯充繚瀛樺€硷紝渚涘皢鏉ヤ娇鐢?
                    doc.add(new Field("path", path, Field.Store.YES, Field.Index.TOKENIZED));
                    doc.add(new Field("time", time, Field.Store.YES, Field.Index.UN_TOKENIZED)); // (Field.Keyword("time", time)); 瀛楁寤虹珛绱㈠紩锛岃€屼笉闇€瑕佸厛杩涜鍒嗘瀽
                    doc.add(new Field("subject", subject, Field.Store.YES, Field.Index.TOKENIZED));
                    doc.add(new Field("content", content, Field.Store.YES, Field.Index.TOKENIZED));

                    for (int i = 0; i < v.size(); i++)
                    {
                        int id = ((Integer) v.get(i)).intValue();
                        Lucene obj = Lucene.find(id);

                        int nt = obj.getNtype();
                        String f = obj.getField();
                        if ("q".equals(f) || "subject".equals(f) || "content".equals(f) || "keywords".equals(f) || "path".equals(f) || "creator".equals(f))
                        {
                            continue;
                        }
                        String sql;
                        if (nt > 65535) //绫诲埆鍒悕
                        {
                            nt = TypeAlias.find(nt).getType();
                        }
                        if (nt < 1024)
                        {
                            String tab = Node.NODE_TYPE[nt] + " t";
                            if (nt == 39) //鏈夎瑷€灞傜殑琛?/
                            {
                                tab = Node.NODE_TYPE[nt] + " t INNER JOIN " + Node.NODE_TYPE[nt] + "Layer tl ON t.node=tl.node";
                            }
                            sql = "SELECT " + f + " FROM " + tab + " WHERE t.node=" + node + " AND language=" + language + " AND " + f + " IS NOT NULL";
                        } else
                        {
                            sql = "SELECT value FROM DynamicValue WHERE node=" + node + " AND language=" + language + " AND dynamictype=" + f + " AND value IS NOT NULL";
                        }
                        db2.executeQuery(sql);
                        if (db2.next())
                        {
                            String value = db2.getString(1);
                            int type = db2.getMetaData().getColumnType(1);
                            if (type == 93 || type == 4 || type == -6) // 93:datetime 4:int -6:tinyint
                            {
                                doc.add(new Field(f, value, Field.Store.YES, Field.Index.UN_TOKENIZED)); //
                            } else
                            {
                                doc.add(new Field(f, htmlToText(value.replaceAll("/", " ")), Field.Store.YES, Field.Index.TOKENIZED)); //鍒嗘瀽
                            }
                        }
                    }

                    iw.addDocument(doc);
                    if (++count % 10 == 0)
                    {
                        out.write("<script>c.innerHTML='" + count + "';</script>");
                        out.flush();
                    }
                }
                out.write("<script>c.innerHTML='" + count + "';</script>");
                //iw.optimize();

                iw.close();
            } catch (Exception e)
            {
                e.printStackTrace();
            } finally
            {
                db1.close();
                db2.close();
            }
            System.out.println("索引生成完成");
        }

        //鍥剧墖绔欏樊寮傜储寮?
        public static void index_diff(String community, Writer out) throws SQLException, IOException
        {
            int count = 0;
            File file = new File(Common.REAL_PATH + "/res/" + community + "/searchindex/bpickey_1");
            if (!file.exists())
            {
                file.mkdirs();
            }
            Date modified = new Date(file.lastModified());
            StringBuilder sb = new StringBuilder();
            sb.append("SELECT b.node, nl.subject, b.mainkey, b.basickey, b.intekey, b.property, b.classific, p.width*p.height as size FROM baudit b INNER JOIN NodeLayer nl ON b.node=nl.node INNER JOIN picture p ON b.node = p.node INNER JOIN node n ON b.node=n.node and n.updatetime<" + DbAdapter.cite(modified));
            sb.append(" WHERE b.passpage=1 and b.community=").append(DbAdapter.cite(community));
            boolean bool = false; // path.list().length < 1;
            DbAdapter db = new DbAdapter();

            try
            {
                IndexReader ir = IndexReader.open(file);
                IndexSearcher is = new IndexSearcher(file.getAbsolutePath());

                db.executeQuery(sb.toString());
                while (db.next())
                {
                    int node = db.getInt(1);
                    //System.out.println("node:" + node);
                    BooleanQuery bq = new BooleanQuery();
                    bq.add(new TermQuery(new Term("bp_node", String.valueOf(node))), BooleanClause.Occur.MUST);
                    Hits hits = is.search(bq);

                    int length = hits.length();
                    //System.out.println("length:" + length);
                    for (int i = 0; i < length; i++)
                    {
                        int delete = hits.id(i);
                        System.out.println("delete id" + delete);
                        ir.deleteDocument(delete);
                    }
                }
                ir.close();
                //  ir.unlock(new Directory(file));
            } catch (Exception ex)
            {
                ex.printStackTrace();
            } finally
            {
                db.close();
            }
            DbAdapter db1 = new DbAdapter();
            DbAdapter db2 = new DbAdapter();
            try
            {
                IndexWriter iw = new IndexWriter(file, new StandardAnalyzer(), bool);

                db1.executeQuery(sb.toString());
                while (db1.next())
                {
                    int node = db1.getInt(1);
                    String subject = Lucene.htmlToText(db1.getVarchar(1, 1, 2));
                    String miankey = Lucene.htmlToText(db1.getText(1, 1, 3).replaceAll("/|,", " "));
//                String basickey = Lucene.htmlToText(db.getText(1,1,4));
//                String intekey = Lucene.htmlToText(db.getText(1,1,5));
                    int property = db1.getInt(6);
                    int size = db1.getInt(8) * 3 / (1024 * 1024);
                    System.out.println(size);
                    String classific = Lucene.htmlToText(db1.getText(1, 1, 7).replaceAll("/|,", " "));
                    Document doc = new Document();

                    doc.add(new Field("bp_node", String.valueOf(node), Field.Store.YES, Field.Index.NO)); // Field.UnIndexed("node", String.valueOf(node))); 鍙槸鎯充繚瀛樺€硷紝渚涘皢鏉ヤ娇鐢?
                    doc.add(new Field("bp_subject", subject, Field.Store.NO, Field.Index.TOKENIZED));
                    doc.add(new Field("bp_mainkey", miankey, Field.Store.NO, Field.Index.TOKENIZED));
                    doc.add(new Field("bp_classific", classific, Field.Store.NO, Field.Index.TOKENIZED));
                    doc.add(new Field("bp_property", String.valueOf(property), Field.Store.NO, Field.Index.TOKENIZED));
                    doc.add(new Field("bp_size", String.valueOf(size), Field.Store.NO, Field.Index.TOKENIZED));

                    iw.addDocument(doc);
                    if (++count % 10 == 0)
                    {
                        out.write("<script>p(" + count + ");</script>");
                        out.flush();
                    }
                }
//            out.write("<script>c.innerHTML='" + count + "';</script>");
                iw.optimize();

                iw.close();

            } catch (Exception e)
            {
                e.printStackTrace();
            } finally
            {
                db1.close();
                db2.close();
            }
            System.out.println("绱㈠紩-鐢熸垚瀹屾垚");
        }


        public static void index_diff(String community, int lucenelist, int language) throws SQLException, IOException
        {
            int count = 0;
            File file = new File(Common.REAL_PATH + "/res/" + community + "/searchindex/" + lucenelist + "_" + language);
            if (!file.exists())
            {
                file.mkdirs();
            }
            Date modified = new Date(file.lastModified());
            LuceneList ll = LuceneList.find(lucenelist);

            StringBuilder sb = new StringBuilder();
            sb.append("SELECT n.node,n.path,n.time,nl.subject,nl.content FROM Node n INNER JOIN NodeLayer nl ON n.node=nl.node and n.updatetime>" + DbAdapter.cite(modified));
            sb.append(" WHERE n.hidden=0 AND n.finished=1 AND nl.language=").append(language).append(" AND n.community=").append(DbAdapter.cite(community));

            if (ll.type != 255)
            {
                sb.append(" AND type=").append(ll.type);
            }
            if (MT.f(ll.node_not).length() > 0)
            {
                String[] arr = ll.node_not.split(",+");
                for (int i = 1; i < arr.length; i++)
                    sb.append(" AND path NOT LIKE '" + Node.find(Integer.parseInt(arr[i])).getPath() + "%'");
            }
            sb.append(" order by n.time desc ");

            System.out.println(sb.toString());
            Vector v = findByLucenelist(lucenelist);
            boolean bool = false; // path.list().length < 1;
            DbAdapter db = new DbAdapter();

            try
            {
                IndexReader ir = IndexReader.open(file);
                IndexSearcher is = new IndexSearcher(file.getAbsolutePath());
                StandardAnalyzer sa = new StandardAnalyzer();

                db.executeQuery(sb.toString());
                while (db.next())
                {
                    int node = db.getInt(1);
                    //System.out.println("node:" + node);
                    BooleanQuery bq = new BooleanQuery();
                    bq.add(new TermQuery(new Term("t255_node", String.valueOf(node))), BooleanClause.Occur.MUST);
                    Hits hits = is.search(bq);

                    int length = hits.length();
                    //System.out.println("length:" + length);
                    for (int i = 0; i < length; i++)
                    {
                        int delete = hits.id(i);
                        System.out.println("delete id" + delete);
                        ir.deleteDocument(delete);
                    }

                }
                ir.close();

                //  ir.unlock(new Directory(file));
            } catch (Exception ex)
            {
                ex.printStackTrace();
            } finally
            {
                db.close();
            }
            DbAdapter db1 = new DbAdapter();
            DbAdapter db2 = new DbAdapter();
            try
            {
                IndexWriter iw = new IndexWriter(file, new StandardAnalyzer(), bool);
                ll.setlastindex(lucenelist);
                db1.executeQuery(sb.toString());
                while (db1.next())
                {
                    int node = db1.getInt(1);
                    String path = db1.getString(2).replaceAll("/", " ");
                    String time = sdf.format(db1.getDate(3));
                    String subject = htmlToText(db1.getVarchar(1, 1, 4));
                    String content = htmlToText(db1.getText(1, 1, 5)) + " " + subject;

                    if (ll.type == 57) //添加贴子的回复内容
                    {
                        StringBuilder sbc = new StringBuilder(content);
                        db2.executeQuery("SELECT rl.subject,rl.content FROM BBSReply r INNER JOIN BBSReplyLayer rl ON r.id=rl.bbsreply WHERE node=" + node);
                        while (db2.next())
                        {
                            sbc.append(db2.getString(1)).append("\n").append(db2.getString(2)).append("\n\n");
                        }
                        content = sbc.toString();
                    }

                    Document doc = new Document();
                    doc.add(new Field("node", String.valueOf(node), Field.Store.YES, Field.Index.TOKENIZED)); // Field.UnIndexed("node", String.valueOf(node))); 鍙槸鎯充繚瀛樺€硷紝渚涘皢鏉ヤ娇鐢?
                    doc.add(new Field("path", path, Field.Store.YES, Field.Index.TOKENIZED));
                    doc.add(new Field("time", time, Field.Store.YES, Field.Index.UN_TOKENIZED)); // (Field.Keyword("time", time)); 瀛楁寤虹珛绱㈠紩锛岃€屼笉闇€瑕佸厛杩涜鍒嗘瀽
                    doc.add(new Field("subject", subject, Field.Store.YES, Field.Index.TOKENIZED));
                    doc.add(new Field("content", content, Field.Store.YES, Field.Index.TOKENIZED));

                    for (int i = 0; i < v.size(); i++)
                    {
                        int id = ((Integer) v.get(i)).intValue();
                        Lucene obj = Lucene.find(id);

                        int nt = obj.getNtype();
                        String f = obj.getField();
                        if ("q".equals(f) || "subject".equals(f) || "content".equals(f) || "keywords".equals(f) || "path".equals(f) || "creator".equals(f))
                        {
                            continue;
                        }
                        String sql;
                        if (nt > 65535) //绫诲埆鍒悕
                        {
                            nt = TypeAlias.find(nt).getType();
                        }
                        if (nt < 1024)
                        {
                            String tab = Node.NODE_TYPE[nt] + " t";
                            if (nt == 39) //鏈夎瑷€灞傜殑琛?/
                            {
                                tab = Node.NODE_TYPE[nt] + " t INNER JOIN " + Node.NODE_TYPE[nt] + "Layer tl ON t.node=tl.node";
                            }
                            sql = "SELECT " + f + " FROM " + tab + " WHERE t.node=" + node + " AND language=" + language + " AND " + f + " IS NOT NULL";
                        } else
                        {
                            sql = "SELECT value FROM DynamicValue WHERE node=" + node + " AND language=" + language + " AND dynamictype=" + f + " AND value IS NOT NULL";
                        }
                        db2.executeQuery(sql);
                        if (db2.next())
                        {
                            String value = db2.getString(1);
                            int type = db2.getMetaData().getColumnType(1);
                            if (type == 93 || type == 4 || type == -6) // 93:datetime 4:int -6:tinyint
                            {
                                doc.add(new Field(f, value, Field.Store.YES, Field.Index.UN_TOKENIZED)); //
                            } else
                            {
                                doc.add(new Field(f, htmlToText(value.replaceAll("/", " ")), Field.Store.YES, Field.Index.TOKENIZED)); //鍒嗘瀽
                            }
                        }
                    }

                    iw.addDocument(doc);

                }

                //iw.optimize();

                iw.close();
            } catch (Exception e)
            {
                e.printStackTrace();
            } finally
            {
                db1.close();
                db2.close();
            }
            System.out.println("索引已生成完成");
        }

        public static String htmlToText(String html)
        {
            StringBuilder sb = new StringBuilder(html.replaceAll("&nbsp;", ""));
            int fromindex = 0;
            int endindex = 0;
            while ((fromindex = sb.indexOf("<", fromindex)) != -1 && (endindex = sb.indexOf(">", fromindex)) != -1)
            {
                sb.delete(fromindex, endindex + 1);
            }
            return sb.toString().trim();
        }
     */
    public static String t(String htm)
    {
        return htm == null ? "" : htm.replaceAll("<[^>]+>|&nbsp;","");
    }

    public static String f(String q)
    {
        return q == null || q.length() < 1 ? "" : q.replaceAll("[()\\[\\]{}\"\\~:!^\\-+&|*?]","\\\\$0").trim();
    }
}
