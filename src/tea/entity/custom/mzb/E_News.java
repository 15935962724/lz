package tea.entity.custom.mzb;

import tea.entity.*;
import tea.entity.site.*;
import tea.entity.node.Node;
import tea.entity.node.Report;
import java.sql.SQLException;
import java.io.*;
import java.util.*;
import java.util.regex.*;
import org.apache.lucene.index.IndexWriter;
import tea.db.DbAdapter;
import org.apache.lucene.analysis.standard.*;
import tea.entity.util.*;
import org.apache.lucene.document.*;

public class E_News
{
    Pattern P_LAY = Pattern.compile("<a id=pageLink href=(node_\\d+\\.htm)>([^<]+)</a>");
    Pattern P_NEW = Pattern.compile("<a href=(content_\\d+\\.htm)>");
    Pattern P_CONTENT_t = Pattern.compile(">\\[([^<]+)\\]<"); //>[漫笔天下·民族国家的昨天·今天·明天]<
    Pattern P_CONTENT_s = Pattern.compile(">([^<]+)</strong><br>"); //"> 藏胞归国参观团，带海外藏胞回家看看  </strong><br>
    Pattern P_CONTENT_sh = Pattern.compile(">——([^<]+)<"); //>——追忆上世纪三四十年代的边疆史地研究热<
    Pattern P_CONTENT_a = Pattern.compile(">□ ([^<]+)<"); //>□ 李明浩<
    Pattern P_CONTENT_p = Pattern.compile("<td ><TABLE>(.+)</TABLE></td>"); //内容上面的图片 //http://www.mzzjw.cn/zgmzb/html/2001-06/01/content_52762.htm
    Pattern P_CONTENT_c = Pattern.compile("<founder-content>(.+)</founder-content>"); //内容

    public String community;
    public E_News(String community)
    {
        this.community = community;
    }

    public void imp(java.io.Writer out) throws Exception
    {
        CommunityOption co = CommunityOption.find(community);
        String path = co.get("e-news.path");
        int node = co.getInt("e-news.node");
        if(path == null || node < 1)
            return;
        File dir = new File(path);
        System.out.println("电子报导入...");
        Node n = Node.find(node);
        File[] f1 = dir.listFiles();
        if(f1 == null)
            return;
        for(int i = 0;i < f1.length;i++)
        {
            if(f1[i].isFile())
                continue;
            String year = f1[i].getName();
            int nid_year = Node.findBySyncId(year);
            if(nid_year == 0) //年-月
            {
                if(out != null)
                {
                    out.write("<script>s.innerHTML='创建 " + year + " 栏目';</script>");
                    out.flush();
                }
                nid_year = Node.create(node,0,n.getCommunity(),new RV("webmaster"),0,false,n.getOptions(),n.getOptions1(),n.getDefaultLanguage(),null,null,Node.sdf.parse(year + "-01"),0,0,0,0,year,1,year,"","","",null,null,0,null,null,null,null,null,null,null);
                n.finished(nid_year);
            }
            File f2[] = f1[i].listFiles();
            for(int x = 0;x < f2.length;x++)
            {
                if(f2[x].isFile())
                    continue;
                String dayname = f2[x].getName();
                String day = year + "/" + dayname;
                Date time = Node.sdf.parse(year + "-" + dayname);
                int nid_day = Node.findBySyncId(day);
                if(nid_day == 0) //日
                {
                    if(out != null)
                    {
                        out.write("<script>s.innerHTML='创建 " + day + " 栏目';</script>");
                        out.flush();
                    }
                    nid_day = Node.create(nid_year,0,n.getCommunity(),new RV("webmaster"),0,false,n.getOptions(),n.getOptions1(),n.getDefaultLanguage(),null,null,time,0,0,0,0,day,1,dayname,"","","",null,null,0,null,"http://www.mzzjw.cn/zgmzb/html/" + day + "/node_2.htm",null,null,null,null,null);
                }
                File f = new File(f2[x],"node_2.htm");
                if(!f.exists())
                    continue;
                String h = Filex.read(f.getPath(),"utf-8");
                Matcher m = P_LAY.matcher(h);
                while(m.find()) //版
                {
                    String layout = day + "/" + m.group(1);
                    String layname = m.group(2);
                    int nid_lay = Node.findBySyncId(layout);
                    if(nid_lay > 0)
                    {
                        if(out != null)
                        {
                            out.write("<script>s.innerHTML='" + layout + " 版,已存在 [跳过]';</script>");
                            out.flush();
                        }
                        continue;
                    } else
                    {
                        if(out != null)
                        {
                            out.write("<script>s.innerHTML='创建 " + layout + " 版';</script>");
                            out.flush();
                        }
                        nid_lay = Node.create(nid_day,0,n.getCommunity(),new RV("webmaster"),1,false,n.getOptions(),n.getOptions1(),n.getDefaultLanguage(),null,null,time,0,0,0,0,layout,1,layname,"","","",null,null,0,null,"http://www.mzzjw.cn/zgmzb/html/" + layout,null,null,null,null,null);
                        n.finished(nid_lay);
                    }
                    //新闻
                    String news = Filex.read(new File(dir,layout).getPath(),"utf-8");
                    Matcher m_new = P_NEW.matcher(news);
                    while(m_new.find())
                    {
                        String newsid = day + "/" + m_new.group(1);
                        int nid_39 = Node.findBySyncId(newsid);
                        if(nid_39 == 0)
                        {
                            String hc = Filex.read(new File(dir,newsid).getPath(),"utf-8").replaceAll("\r|\n","");
                            String locus = "",subject = "",subhead = "",author = "",content = "";
                            Matcher m_c = P_CONTENT_t.matcher(hc); //地点
                            if(m_c.find())
                            {
                                locus = m_c.group(1);
                            }
                            m_c = P_CONTENT_s.matcher(hc); //主题
                            if(m_c.find())
                            {
                                subject = m_c.group(1).trim();
                            }
                            m_c = P_CONTENT_sh.matcher(hc); //副标题
                            if(m_c.find())
                            {
                                subhead = m_c.group(1);
                            }
                            m_c = P_CONTENT_a.matcher(hc); //作者
                            if(m_c.find())
                            {
                                author = m_c.group(1);
                            }
                            m_c = P_CONTENT_p.matcher(hc); //图片
                            if(m_c.find())
                            {
                                content = "<TABLE>" + m_c.group(1) + "</TABLE>";
                            }
                            m_c = P_CONTENT_c.matcher(hc); //内容
                            if(m_c.find())
                            {
                                content += m_c.group(1);
                            }
                            //out.print("s.innerHTML=\"创建 "+subject.replace('"','＂')+" 新闻\";");
                            //out.flush();
                            nid_39 = Node.create(nid_lay,0,n.getCommunity(),new RV("webmaster"),39,false,n.getOptions(),n.getOptions1(),n.getDefaultLanguage(),time,null,time,0,0,0,0,newsid,1,subject,"","",content,null,null,0,null,"http://www.mzzjw.cn/zgmzb/html/" + newsid,null,null,null,null,null);
                            Report re = Report.find(nid_39);
                            re.set();
                            re.setLayer(1,null,locus,subhead,author,null,null,null,null,null,null,null,null,null,null);
                            n.finished(nid_39);
                        }
                    } //news end

                }
            }
        }
        System.out.println("电子报导入 OK");
    }

    public void index(java.io.Writer out) throws Exception
    {
        CommunityOption co = CommunityOption.find(community);
        int node = co.getInt("e-news.node");
        if(node < 1)
            return;
        System.out.println("电子报索引...");
        String path = Node.find(node).getPath();
        boolean flag = true;
        IndexWriter iw = new IndexWriter(new File(tea.resource.Common.REAL_PATH + "/res/" + community + "/searchindex/e_news"),new StandardAnalyzer(),true);
        DbAdapter db = new DbAdapter();
        try
        {
            int seq = 0,sum = db.getInt("SELECT COUNT(*) FROM Node n WHERE n.path LIKE " + DbAdapter.cite(path + "%") + " AND n.type=39");
            while(flag)
            {
                flag = false;
                if(out != null)
                {
                    out.write("<script>mt.progress(" + seq + "," + sum + ");</script>");
                    out.flush();
                }
                db.executeQuery("SELECT n.node,nl.subject,nl.content,r.author,n.time FROM Node n INNER JOIN NodeLayer nl ON n.node=nl.node AND nl.language=1 INNER JOIN ReportLayer r ON n.node=r.node AND r.language=1 WHERE n.node>" + node + " AND n.path LIKE " + DbAdapter.cite(path + "%") + " AND n.type=39 ORDER BY n.node",0,1000);
                while(db.next())
                {
                    flag = true;
                    seq++;
                    node = db.getInt(1);
                    String subject = Lucene.t(db.getString(2));
                    String content = Lucene.t(db.getText(3));
                    String author = db.getString(4);

                    Document doc = new Document();
                    doc.add(new Field("node",String.valueOf(node),Field.Store.YES,Field.Index.NO)); // Field.UnIndexed("node", String.valueOf(node))); 只是想保存值，供将来使用
                    doc.add(new Field("subject",subject,Field.Store.NO,Field.Index.ANALYZED));
                    doc.add(new Field("content",subject + " " + content,Field.Store.NO,Field.Index.ANALYZED));
                    doc.add(new Field("author",author,Field.Store.NO,Field.Index.ANALYZED));
                    doc.add(new Field("time",MT.f(db.getDate(5)),Field.Store.NO,Field.Index.NOT_ANALYZED));
                    iw.addDocument(doc);
                }
            }
            iw.optimize();
        } catch(Exception ex)
        {
            ex.printStackTrace();
        } finally
        {
            iw.close();
            db.close();
        }
        System.out.println("电子报索引 OK");
    }
}
