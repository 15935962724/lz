package tea.entity.util;

import java.io.*;
import java.util.*;
import java.text.*;
import java.sql.SQLException;
import tea.db.DbAdapter;
import tea.entity.*;
import tea.entity.node.*;

import org.htmlparser.Parser;
import org.htmlparser.filters.*;
import org.htmlparser.tags.*;
import org.htmlparser.nodes.*;
import org.htmlparser.util.NodeList;


public class Caiji
{
    protected static Cache _cache = new Cache(50);
    public int caiji;
    public String name;
    public String community;
    public String url;
    public String listbegin,listend; //列表
    public String linkbegin,linkend;
    public String kickerbegin,kickerend; //引题
    public String titlebegin,titleend; //标题
    public String subheadbegin,subheadend; //副标题
    public String authorbegin,authorend; //作者
    public String timebegin,timeend; //时间
    public String sourcebegin,sourceend; //来源
    public String contentbegin,contentend; //正文
    public String code = "gbk";
    public String imgpath;
    public String rimgpath;
    public int father;
    public int count;
    public static final String[] REPEAT_TYPE =
            {"--","跳过","替换","新增"};
    public int repeat;
    public Date lasttime;
    public int total; //采集总数量
    public Date time; //创建时间
    //
//    public String title;
//    public String publishtime;
//    public String content;
//    public String resource;

    public Caiji(int caiji) throws SQLException
    {
        this.caiji = caiji;
    }

    public static Caiji find(int caiji) throws SQLException
    {
        Caiji t = (Caiji) _cache.get(caiji);
        if(t == null)
        {
            ArrayList al = find(" AND caiji=" + caiji,0,1);
            t = al.size() < 1 ? new Caiji(caiji) : (Caiji) al.get(0);
        }
        return t;
    }

    public void set() throws SQLException
    {
        String sql;
        if(caiji < 1)
            sql = "INSERT INTO Caiji(caiji,name,url,listbegin,listend,linkbegin,linkend,kickerbegin,kickerend,titlebegin,titleend,subheadbegin,subheadend,authorbegin,authorend,timebegin,timeend,sourcebegin,sourceend,contentbegin,contentend,code,imgpath,rimgpath,father,count,community,repeat,total,time)VALUES(" + (caiji = Seq.get()) + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(url) + "," + DbAdapter.cite(listbegin) + "," + DbAdapter.cite(listend) + "," + DbAdapter.cite(linkbegin) + "," + DbAdapter.cite(linkend) + "," + DbAdapter.cite(kickerbegin) + "," + DbAdapter.cite(kickerend) + "," + DbAdapter.cite(titlebegin) + "," + DbAdapter.cite(titleend) + "," + DbAdapter.cite(subheadbegin) + "," + DbAdapter.cite(subheadend) + "," + DbAdapter.cite(authorbegin) + "," +
                    DbAdapter.cite(authorend) + "," + DbAdapter.cite(timebegin) + "," + DbAdapter.cite(timeend) + "," + DbAdapter.cite(sourcebegin) + "," + DbAdapter.cite(sourceend) + "," + DbAdapter.cite(contentbegin) + "," + DbAdapter.cite(contentend) + "," + DbAdapter
                    .cite(code) + "," + DbAdapter.cite(imgpath) + "," + DbAdapter.cite(rimgpath) + "," + father + "," + count + "," + DbAdapter.cite(community) + "," + repeat + "," + total + "," + DbAdapter.cite(time) + ")";
        else
            sql = "UPDATE Caiji SET name=" + DbAdapter.cite(name) + ",url=" + DbAdapter.cite(url) + ",listbegin=" + DbAdapter.cite(listbegin) + ",listend=" + DbAdapter.cite(listend) + ",linkbegin=" + DbAdapter.cite(linkbegin) + ",linkend=" + DbAdapter.cite(linkend)
                  + ",kickerbegin=" + DbAdapter.cite(kickerbegin) + ",kickerend=" + DbAdapter.cite(kickerend)
                  + ",titlebegin=" + DbAdapter.cite(titlebegin) + ",titleend=" + DbAdapter.cite(titleend)
                  + ",subheadbegin=" + DbAdapter.cite(subheadbegin) + ",subheadend=" + DbAdapter.cite(subheadend)
                  + ",authorbegin=" + DbAdapter.cite(authorbegin) + ",authorend=" + DbAdapter.cite(authorend)
                  + ",timebegin=" + DbAdapter.cite(timebegin) + ",timeend=" + DbAdapter.cite(timeend)
                  + ",sourcebegin=" + DbAdapter.cite(sourcebegin) + ",sourceend=" + DbAdapter.cite(sourceend)
                  + ",contentbegin=" + DbAdapter.cite(contentbegin) + ",contentend=" + DbAdapter.cite(contentend)
                  + ",code=" + DbAdapter.cite(code) + ",imgpath=" + DbAdapter.cite(imgpath) + ",rimgpath=" + DbAdapter.cite(rimgpath) + ",father=" + father + ",count=" + count + ",repeat=" +
                  repeat + ",total=" + total + ",time=" + DbAdapter.cite(time) + " WHERE caiji=" + caiji;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(caiji,sql);
        } finally
        {
            db.close();
        }
    }

    public void set(int total,Date lasttime) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(caiji,"UPDATE Caiji SET total=" + total + ",lasttime=" + DbAdapter.cite(lasttime) + " WHERE caiji=" + caiji);
        } finally
        {
            db.close();
        }
    }

    public static int count(String sql) throws SQLException
    {
        return DbAdapter.execute("SELECT COUNT(*) FROM Caiji WHERE 1=1" + sql);
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT caiji,name,url,listbegin,listend,linkbegin,linkend,kickerbegin,kickerend,titlebegin,titleend,subheadbegin,subheadend,authorbegin,authorend,timebegin,timeend,sourcebegin,sourceend,contentbegin,contentend,code,imgpath,rimgpath,father,count,community,repeat,lasttime,total,time FROM Caiji WHERE 1=1" + sql,pos,size);
            while(db.next())
            {
                int j = 1;
                Caiji t = new Caiji(db.getInt(j++));
                t.name = db.getString(j++);
                t.url = db.getString(j++);
                t.listbegin = db.getString(j++);
                t.listend = db.getString(j++);
                t.linkbegin = db.getString(j++);
                t.linkend = db.getString(j++);
                t.kickerbegin = db.getString(j++);
                t.kickerend = db.getString(j++);
                t.titlebegin = db.getString(j++);
                t.titleend = db.getString(j++);
                t.subheadbegin = db.getString(j++);
                t.subheadend = db.getString(j++);
                t.authorbegin = db.getString(j++);
                t.authorend = db.getString(j++);
                t.timebegin = db.getString(j++);
                t.timeend = db.getString(j++);
                t.sourcebegin = db.getString(j++);
                t.sourceend = db.getString(j++);
                t.contentbegin = db.getString(j++);
                t.contentend = db.getString(j++);
                t.code = db.getString(j++);
                t.imgpath = db.getString(j++);
                t.rimgpath = db.getString(j++);
                t.father = db.getInt(j++);
                t.count = db.getInt(j++);
                t.community = db.getString(j++);
                t.repeat = db.getInt(j++);
                t.lasttime = db.getDate(j++);
                t.total = db.getInt(j++);
                t.time = db.getDate(j++);
                al.add(t);
            }
        } finally
        {
            db.close();
        }
        return al;
    }


    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(caiji,"DELETE FROM Caiji WHERE caiji=" + caiji);
        } finally
        {
            db.close();
        }
    }

    public String run(Http h) throws Exception
    {
        String csv = "/res/" + community + "/caiji_" + caiji + "_" + Math.random() + ".csv";
        Filex.logs(Http.REAL_PATH + csv,"网址,标题,信息");
        Writer out = h.response.getWriter();
        for(int j = 0;j < 20;j++)
            out.write("// 显示进度条  \n");
        SimpleDateFormat[] SDF =
                {new SimpleDateFormat("yyyy-MM-dd HH:mm"),new SimpleDateFormat("yyyy-MM-dd"),new SimpleDateFormat("yyyy年MM月dd日HH时mm分"),new SimpleDateFormat("yyyy年MM月dd日 HH:mm"),new SimpleDateFormat("yyyy年MM月dd日")};
        int[] COUNT = new int[6];
        ArrayList PAGE = new ArrayList();
        for(int p = 1;p < 200 && PAGE.size() < count;p++)
        {
            if(url.contains("${page}"))
                out.write("<script>$$('dialog_header').innerHTML='页：" + p + "';</script>");
            else if(p > 1)
                break;
            String htm = (String) open(url.replace("${page}",String.valueOf(p)));
            if(htm == null || htm.contains("<TITLE>无法找到该页</TITLE>") || htm.contains("<title>404 Not Found</title>"))
            {
                if(p > 1)
                    break;
                return "抱歉，无法找到该页！";
            }
            int beginIndex = htm.indexOf(listbegin);
            if(beginIndex == -1)
                return "抱歉，源网页中没有找到“列表开始代码”！";

            int endIndex = htm.indexOf(listend,beginIndex + listbegin.length());
            if(endIndex == -1)
                return "抱歉，源网页中没有找到“列表结束代码”！";
            htm = htm.substring(beginIndex,endIndex);

            //Parser parser = new Parser(url);//会改变原内容
            //parser.setEncoding(code);

            NodeList nl = new Parser("<base href='" + url + "' />" + htm).extractAllNodesThatMatch(new NodeClassFilter(Class.forName("org.htmlparser.tags.LinkTag")));
            //Filex.logs("content.txt",htm);
            if(p < 2 && nl.size() < 1)
                return "抱歉，源网页中没有找到“链接”！";
            for(int i = 0;i < nl.size() && PAGE.size() < count;i++)
            {
                LinkTag lt = (LinkTag) nl.elementAt(i);
                out.write("<script>mt.progress(" + i + "," + nl.size() + ",'" + (i + 1) + "、" + lt.getLinkText() + "');</script>");
                out.flush();
                String url = lt.getLink();
                if(PAGE.contains(url))
                    continue;
                PAGE.add(url);
                //if(!url.endsWith("/2/21/730.html"))
                //    continue;
                HashMap HM = new HashMap();
                StringBuilder log = new StringBuilder();
                try
                {
                    log.append(url);
                    String page = (String) open(url);
                    if(page == null)
                    {
                        COUNT[4]++;
                        continue;
                    }
                    //引题
                    String kicker = sub(page,kickerbegin,kickerend,"kicker",HM);
                    String title = sub(page,titlebegin,titleend,"title",HM).replaceAll("<[^>]+>","");
                    log.append("," + title);
                    if(title == null)
                    {
                        log.append(",没找到标题");
                        COUNT[4]++;
                        continue;
                    }
                    int node = 0;
                    Enumeration e = Node.find(" AND n.father=" + father + " AND nl.subject=" + DbAdapter.cite(title),0,1);
                    if(e.hasMoreElements())
                    {
                        if(repeat == 1) //跳过
                        {
                            log.append(",跳过");
                            COUNT[3]++;
                            continue;
                        } else if(repeat == 2) //替换
                        {
                            node = ((Integer) e.nextElement()).intValue();
                            log.append(",替换:" + node);
                        }
                    }
                    //副标题
                    String subhead = sub(page,subheadbegin,subheadend,"subhead",HM);
                    //作者
                    String author = sub(page,authorbegin,authorend,"author",HM);
                    //时间
                    String stime = sub(page,timebegin,timeend,"time",HM);
                    Date time = null;
                    for(int x = 0;x < SDF.length;x++)
                    {
                        try
                        {
                            time = SDF[x].parse(stime);
                            break;
                        } catch(Throwable ex)
                        {}
                    }
                    try
                    {
                        if(time == null)
                            time = new Date(stime);
                    } catch(Throwable ex)
                    {
                        Filex.logs("Caiji.txt","ID：" + caiji + "　网址：" + url + "　日期：" + stime + "　　错误：" + ex.toString());
                        time = new Date();
                    }
                    String source = sub(page,sourcebegin,sourceend,"source",HM);
                    //图片
                    AbstractNode fc = (AbstractNode) lt.getFirstChild();
                    String pic = null;
                    if(fc instanceof ImageTag)
                    {
                        ImageTag it = (ImageTag) fc;
                        pic = img(it.getImageURL(),h,COUNT,time);
                    }
                    //内容
                    String content = sub(page,contentbegin,contentend,"content",HM);
                    if(content == null)
                    {
                        log.append(",没找到内容");
                        COUNT[5]++;
                        continue;
                    }
                    content += page(url,page); //分页
                    //Filex.write("content.htm",content);
                    content = img(url,content,h,COUNT,time); //图片
                    content = content.replace(' ',' '); //160转10,ORACLE不认160
                    content = content.replaceAll("<!--.+-->",""); //去掉注释
                    content = content.replaceAll("<p>(\\s|&nbsp;)*</p>",""); //去掉空<P>
                    content = content.replaceAll("<h\\d>","<p>").replace("</h\\d>","</p>"); //h2改为<P>
                    content = content.replaceAll("<br />","</p>\n<p>"); //br改为<P>
                    content = content.replaceAll("(<p[^>]*>)(　|\\s|&nbsp;)*","$1　　"); //首行缩进
                    //Filex.write("content_2.htm",content);
                    //
                    Node f = Node.find(father);
                    Node n = Node.find(node);
                    n.father = f._nNode;
                    n.community = community;
                    n.member = h.member;
                    n.creator = new RV(h.username);
                    n.type = 39;
                    n.options = f.getOptions();
                    n.options1 = f.getOptions1();
                    n.defaultLanguage = h.language;
                    n.time = n.starttime = time;
                    n.style = f.getStyle();
                    n.root = f.getRoot();
                    n.kstyle = f.getKstyle();
                    n.kroot = f.getKroot();
                    n.mostly1 = n.mostly2 = true;
                    n.syncid = url;
                    //n.source = caiji;
                    n.set();
                    n.setLayer(h.language,title,null,null,content,null,null,0,null,null,null,null,null,"|",null);

                    Report re = Report.find(n._nNode);
                    //媒体
                    if(source != null)
                    {
                        ArrayList mal = Media.find(" AND m.community=" + DbAdapter.cite(community) + " AND ml.name=" + DbAdapter.cite(source),0,1);
                        if(mal.size() < 1)
                        {
                            Media m = new Media(0);
                            m.community = community;
                            m.type = 39;
                            m.set(h.language,source,null,null);
                            re.media = m.media;
                        } else
                            re.media = ((Media) mal.get(0)).media;
                    }
                    re.set();
                    re.setLayer(h.language,pic,null,subhead,author,kicker,null,null,null,null,null,null,null,null,null);
                    n.finished(n._nNode);
                    COUNT[node < 1 ? 0 : 1]++;
                } catch(Throwable ex)
                {
                    log.append("," + ex.toString());
                    Filex.logs("Caiji.txt",ex);
                    return ex.toString();
                } finally
                {
                    Filex.logs(Http.REAL_PATH + csv,log.toString());
                }
            }
        }
        total += COUNT[0];
        set(total,new Date());
        return "添加：" + COUNT[0] + "条<br/>替换：" + COUNT[1] + "条<br/>图片：" + COUNT[2] + "张<br/>重复：" + COUNT[3] + "条<br/>没找到标题：" + COUNT[4] + "条<br/>没找到内容：" + COUNT[5] + "条<a href=/Utils.do?act=down&url=" + csv + ">日志</a>";
    }

    //截取内容
    public static String sub(String htm,String begin,String end,String name,HashMap HM)
    {
        if(begin == null || begin.length() < 1 || end == null || end.length() < 1)
            return null;

        int s = MT.f(HM.get(begin), -1);
        if(s == -1)
        {
            s = htm.indexOf(begin);
            if(s == -1)
                return null;
            s += begin.length();
        }

        int e = MT.f(HM.get(end), -1);
        if(e == -1)
        {
            e = htm.indexOf(end,s);
            if(e == -1)
                return null;
            if(HM != null)
                HM.put("${" + name + "end}",e + end.length());
        }
        return htm.substring(s,e).trim();
    }

    //内容分页
    String page(String url,String htm) throws Exception
    {
        NodeList nl = new Parser("<base href='" + url + "' />" + htm).extractAllNodesThatMatch(new NodeClassFilter(Class.forName("org.htmlparser.tags.LinkTag")));
        for(int p = 0;p < nl.size();p++)
        {
            LinkTag lt = (LinkTag) nl.elementAt(p);
            if("下一页".equals(lt.getLinkText()))
            {
                String curl = lt.getLink();
                if(url.equals(curl)) //最后一页
                    return "";
                htm = (String) open(curl);
                String content = sub(htm,contentbegin,contentend,"content",null);
                return "\r\n<div style=\"page-break-after: always\"><span style=\"display:none\">&nbsp;</span></div>\r\n" + content + page(curl,htm);
            }
        }
        return "";
    }

    public static String img(Http h,String content) throws Exception
    {
        return img(null,content,h,null,new Date());
    }

    //内容图片
    static String img(String url,String content,Http h,int[] COUNT,Date time) throws Exception
    {
        Parser par = new Parser();
        par.setInputHTML(content);
        NodeList imgs = par.extractAllNodesThatMatch(new NodeClassFilter(Class.forName("org.htmlparser.tags.InputTag")));
        for(int x = 0;x < imgs.size();x++)
        {
            InputTag it = (InputTag) imgs.elementAt(x);
            if(!"image".equalsIgnoreCase(it.getAttribute("type")))
                continue;
            it.setTagName("img  ");
            content = content.substring(0,it.getTagBegin()) + it.toHtml() + content.substring(it.getTagEnd());
        }
        par.setInputHTML(url == null ? content : "<base href='" + url + "' />" + content);
        imgs = par.extractAllNodesThatMatch(new NodeClassFilter(Class.forName("org.htmlparser.tags.ImageTag")));
        for(int x = 0;x < imgs.size();x++)
        {
            ImageTag it = (ImageTag) imgs.elementAt(x);
            content = content.replace(it.extractImageLocn(),img(it.getImageURL(),h,COUNT,time));
        }
        return content;
    }

    //图片
    static String img(String url,Http h,int[] COUNT,Date time) throws Exception
    {
        ArrayList al = Attch.find(" AND community=" + DbAdapter.cite(h.community) + " AND path3=" + DbAdapter.cite(url) + " AND deleted=0",0,1);
        if(al.size() > 0)
        {
            url = ((Attch) al.get(0)).path;
        } else
        {
            try
            {
                byte[] by = (byte[]) open(url);
                Attch a = new Attch(Seq.get(time));
                //a.node = father;
                a.community = h.community;
                a.member = h.member;
                a.name = url.substring(url.lastIndexOf('/') + 1);
                a.type = a.name.substring(a.name.lastIndexOf('.') + 1).toLowerCase();
                a.path3 = url; //原始图片路径
                url = a.path = "/res/" + h.community + "/report/" + a.attch + "." + a.type;
                a.length = by.length;
                a.set();
                Filex.write(Http.REAL_PATH + a.path,by);
                if(COUNT != null)
                    COUNT[2]++;
            } catch(Throwable ex)
            {
                Filex.logs("Caiji.txt","　　图片：" + url + "　　错误：" + ex.toString());
            }
        }
        return url;
    }

    static Object open(String url)
    {
        for(int i = 0;i < 3;i++)
        {
            try
            {
                return Http.open(url,null);
            } catch(Throwable ex)
            {
                Filex.logs("Caiji.txt","网址：" + url + "　　重试：" + i + "　　错误：" + ex.toString());
            }
        }
        return null;
    }
}
