package tea.entity.node;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.sql.SQLException;
import java.util.Date;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Vector;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tea.db.*;
import tea.entity.*;
import tea.entity.Entity;
import tea.entity.RV;
import tea.entity.admin.orthonline.NodePoints;
import tea.entity.member.Profile;
import tea.entity.subscribe.MobileOrder;
import tea.entity.subscribe.PackageOrder;
import tea.entity.subscribe.Tactics;
import tea.html.Span;
import tea.ui.TeaSession;
import java.util.ArrayList;

public class Report extends Entity implements Cloneable
{
    public static Cache _cache = new Cache(400);
    private Hashtable _htLayer;
    public int node;
    public int media;
    public int classes;
    public int classes2;
    public Date issuetime;
    public boolean exists;
    public int flag; //添加水印 0 没有，1 有
    public String coordinate; //坐标
    public String editionnumber; //版次编号

    public int cbutors; //是否投稿新闻,,,, 0 不是投稿新闻，1 是投稿新闻

    public int manuscripttype; //稿件类别


    //通过理由
    private String audits_by0;
    private String audits_by1;
    private String audits_by2;
    private String audits_by3;
    private String audits_by4;
    //修改用户
    private String audits_by_member0;
    private String audits_by_member1;
    private String audits_by_member2;
    private String audits_by_member3;
    private String audits_by_member4;


    //拒绝审核理由
    private String audits_reason0;
    private String audits_reason1;
    private String audits_reason2;
    private String audits_reason3;
    private String audits_reason4;

    //拒绝用户
    private String audits_reason_member0;
    private String audits_reason_member1;
    private String audits_reason_member2;
    private String audits_reason_member3;
    private String audits_reason_member4;


    private int refuse_audits; //审核不通过，1 一级初审未通过，2，一级终审未通过，3，二级初审未通过，4 二级终审未通过

    public int iseditreport; //是否有编辑过 默认0 ，暂无编辑，1 在审核或未通过时候编辑过,期间有编辑


    public static final String MANUSCRIPT_TYPE[] =
            {"无","原创","转载","翻译","记者稿","通讯员稿"};

    class RLayer
    {
        String picture;
        String logograph;
        String locus;
        String subhead; //副标题
        String author; //作者
        String kicker; //肩题
        String editmember; //文件编辑

        String newquota; //新闻语录
        String quotasource; //语录出处
        String subjectfilename; //标题图片路径
        String subheadfilename; //副标题图片路径
        String authorfilename; // 作者图片路径


        //投稿使用
        String name; //姓名
        String units; //工作单位
        String email; //邮箱
        String mobile; //手机
        String address; //地址
        String telephone; //办公电话
        String rejection; //退稿原因

        String experts; //专家
        String providemember; //新闻提供者
        String signature; //本文署名

    }


    public static Report find(int node) throws SQLException
    {
        Report obj = (Report) _cache.get(new Integer(node));
        if(obj == null)
        {
            obj = new Report(node);
            _cache.put(new Integer(node),obj);
        }
        return obj;
    }

    public Report(int node) throws SQLException
    {
        this.node = node;
        _htLayer = new Hashtable();
        load();
    }

    private static void create(int node,int media,int classes,Date issuetime,int language,String picture,String locus,String subhead,String author,String logograph,String kicker,int flag) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(node,"INSERT INTO Report(node,media,classes,issuetime,flag)VALUES(" + node + ", " + media + "," + classes + ", " + DbAdapter.cite(issuetime) + "," + flag + ")");
            db.executeUpdate(node,"INSERT INTO ReportLayer(node,language,picture,locus,subhead,author,logograph,kicker)VALUES(" + node + ", " + language + ", " + DbAdapter.cite(picture) + ", " + DbAdapter.cite(locus) + ", " + DbAdapter.cite(subhead) + ", " + DbAdapter.cite(author) + ", " + DbAdapter.cite(logograph) + "," + DbAdapter.cite(kicker) + "   )");
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(node));
    }

    public void set() throws SQLException
    {
        String sql;
        if(exists)
            sql = "UPDATE Report SET media=" + media + ",classes=" + classes + ",classes2=" + classes2 + ",issuetime=" + DbAdapter.cite(issuetime) + ",cbutors=" + cbutors + ",manuscripttype=" + manuscripttype + ",iseditreport=" + iseditreport + ",flag=" + flag + "  WHERE node=" + node;
        else
            sql = "INSERT INTO Report(node,media,classes,issuetime,cbutors,manuscripttype,iseditreport,flag)VALUES(" + node + ", " + media + "," + classes + ", " + DbAdapter.cite(issuetime) + "," + cbutors + "," + manuscripttype + "," + iseditreport + "," + flag + ")";
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(node,sql);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(node));
    }

    public void setLayer(int language,String picture,String locus,String subhead,String author,String kicker,String editmember,String newquota,String quotasource,String subjectfilename,String subheadfilename,String authorfilename,String experts,String providemember,String signature) throws SQLException
    {
        StringBuilder sb = new StringBuilder();
        sb.append("UPDATE ReportLayer SET");
        sb.append(" locus=").append(DbAdapter.cite(locus));
        sb.append(",subhead=").append(DbAdapter.cite(subhead));
        sb.append(",author=").append(DbAdapter.cite(author));
        sb.append(",kicker=").append(DbAdapter.cite(kicker));
        sb.append(",editmember=").append(DbAdapter.cite(editmember));
        sb.append(",newquota=").append(DbAdapter.cite(newquota));
        sb.append(",quotasource=").append(DbAdapter.cite(quotasource));
        sb.append(",experts=").append(DbAdapter.cite(experts));
        sb.append(",providemember=").append(DbAdapter.cite(providemember));
        sb.append(",signature=").append(DbAdapter.cite(signature));
        if(picture != null)
            sb.append(",picture=" + DbAdapter.cite(picture));
        if(subjectfilename != null)
            sb.append(",subjectfilename=" + DbAdapter.cite(subjectfilename));
        if(subheadfilename != null)
            sb.append(",subheadfilename=" + DbAdapter.cite(subheadfilename));
        if(authorfilename != null)
            sb.append(",authorfilename=" + DbAdapter.cite(authorfilename));
        sb.append(" WHERE node=").append(node).append(" AND language=").append(language);
        DbAdapter db = new DbAdapter();
        try
        {
            int j = db.executeUpdate(node,sb.toString());
            if(j < 1)
            {
                db.executeUpdate(node,"INSERT INTO ReportLayer(node,language,picture,locus,subhead,author,kicker,editmember,newquota,quotasource,subjectfilename,subheadfilename,authorfilename,experts,providemember,signature)VALUES(" + node + "," + language + "," + DbAdapter.cite(picture) + "," + DbAdapter.cite(locus) + "," + DbAdapter.cite(subhead) + "," + DbAdapter.cite(author) + "," + DbAdapter.cite(kicker) + "," + DbAdapter.cite(editmember) + "," + DbAdapter.cite(newquota) + "," + DbAdapter.cite(quotasource) + "," + DbAdapter.cite(subjectfilename) + "," + DbAdapter.cite(subheadfilename) + "," + DbAdapter.cite(authorfilename) + "," + DbAdapter.cite(experts) + "," + DbAdapter.cite(providemember) + "," + DbAdapter.cite(signature) + ")");
            }
        } finally
        {
            db.close();
        }
        _htLayer.clear();
    }

    private void set(int media,int classes,Date issuetime,int language,String picture,String locus,String subhead,String author,String logograph,int classes2,String kicker,int flag) throws SQLException
    {
        StringBuilder sb = new StringBuilder();
        sb.append("UPDATE ReportLayer SET");
        sb.append(" locus=").append(DbAdapter.cite(locus));
        sb.append(",subhead=").append(DbAdapter.cite(subhead));
        sb.append(",author=").append(DbAdapter.cite(author));
        sb.append(",logograph=").append(DbAdapter.cite(logograph));
        sb.append(",kicker=").append(DbAdapter.cite(kicker));
        if(picture != null)
        {
            sb.append(",picture=" + DbAdapter.cite(picture));
        }
        sb.append(" WHERE node=").append(node).append(" AND language=").append(language);
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(node,"UPDATE Report SET media=" + media + ",classes=" + classes + ",classes2=" + classes2 + ",issuetime=" + DbAdapter.cite(issuetime) + ",flag=" + flag + "  WHERE node=" + node);
            int j = db.executeUpdate(node,sb.toString());
            if(j < 1)
            {
                db.executeUpdate(node,"INSERT INTO ReportLayer(node,language,picture,locus,subhead,author,logograph,kicker)VALUES(" + node + ", " + language + ", " + DbAdapter.cite(picture) + ", " + DbAdapter.cite(locus) + ", " + DbAdapter.cite(subhead) + ", " + DbAdapter.cite(author) + ", " + DbAdapter.cite(logograph) + "," + DbAdapter.cite(kicker) + ")");
            }
        } finally
        {
            db.close();
        }
        this.media = media;
        this.classes = classes;
        this.classes2 = classes2;
        this.issuetime = issuetime;
        this.flag = flag;
        _htLayer.clear();
    }

    //修改坐标和版次编号
    public void set_(String coordinate,String editionnumber) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Report SET coordinate=" + db.cite(coordinate) + " ,editionnumber= " + db.cite(editionnumber) + " WHERE node=" + node);
        } finally
        {
            db.close();
        }
        this.coordinate = coordinate;
        this.editionnumber = editionnumber;
        _htLayer.clear();
    }

    //投稿修改内容
    public void set(String name,String units,String email,String mobile,String address,int cbutors,String telephone) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Report SET cbutors =" + cbutors + " WHERE node= " + node);
            db.executeUpdate("UPDATE ReportLayer SET name =" + db.cite(name) + ",units=" + db.cite(units) + ",email=" + db.cite(email) + ",mobile=" + db.cite(mobile) + ",address=" + db.cite(address) + ",telephone=" + db.cite(telephone) + " WHERE node= " + node);
        } finally
        {
            db.close();
        }
        this.cbutors = cbutors;
        _htLayer.clear();
    }

    public void setCbutors(int cbutors) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Report SET cbutors =" + cbutors + " WHERE node= " + node);
            //db.executeUpdate("UPDATE ReportLayer SET name ="+db.cite(name)+",units="+db.cite(units)+",email="+db.cite(email)+",mobile="+db.cite(mobile)+",address="+db.cite(address)+",telephone="+db.cite(telephone)+" WHERE node= "+node);
        } finally
        {
            db.close();
        }
        this.cbutors = cbutors;
        _htLayer.clear();
    }

    public void setRefuse_audits(int refuse_audits) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Report SET refuse_audits =" + refuse_audits + " WHERE node= " + node);
        } finally
        {
            db.close();
        }
        this.refuse_audits = refuse_audits;
        _htLayer.clear();
    }

    //新闻是否编辑过
    public void setIseditreport(int iseditreport) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Report SET iseditreport =" + iseditreport + " WHERE node= " + node);
        } finally
        {
            db.close();
        }
        this.iseditreport = iseditreport;
        _cache.clear();
        _htLayer.clear();
    }

    //拒绝理由和用户
    public void setAudits_reason(String field,String audits_reason,String field2,String audits_reason_member) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Report SET " + field + " =" + db.cite(audits_reason) + " ," + field2 + "=" + db.cite(audits_reason_member) + " WHERE node= " + node);
        } finally
        {
            db.close();
        }
        _htLayer.clear();
        _cache.clear();
    }

    public void setAudits_by(String field,String audits_by,String field2,String audits_by_member) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Report SET " + field + " =" + db.cite(audits_by) + " ," + field2 + "=" + db.cite(audits_by_member) + " WHERE node= " + node);
        } finally
        {
            db.close();
        }
        _htLayer.clear();
        _cache.clear();
    }

    //获取审核意见
    public String getAudits_reason(int audits_reason) throws SQLException
    {
        String str = "";

        if(audits_reason == 0)
        {
            str = this.getAudits_reason0();
        } else
        if(audits_reason == 1)
        {
            str = this.getAudits_reason1();
        } else if(audits_reason == 2)
        {
            str = this.getAudits_reason2();
        } else if(audits_reason == 3)
        {
            str = this.getAudits_reason3();
        }
        if(audits_reason == 4)
        {
            str = this.getAudits_reason4();
        }
        return str;

    }

    //判断是否有审核意见
    public static boolean isAudits(int nid) throws SQLException
    {
        boolean f = false;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select node from  Report where node = " + nid + " and (audits_by0 is not null or audits_by1 is not null or audits_by2 is not null or audits_by3 is not null or audits_reason0 is not null or audits_reason1 is not null or audits_reason2 is not null or audits_reason3 is not null)");
            if(db.next())
            {
                f = true;
            }
        } finally
        {
            db.close();
        }
        return f;
    }


    //修改新闻语录和语录出处
    public void setNewquotaSource(String newquota,String quotasource) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE ReportLayer SET newquota=" + db.cite(newquota) + ",quotasource=" + db.cite(quotasource) + " WHERE node= " + node);
        } finally
        {
            db.close();
        }
        _htLayer.clear();
    }

    // 添加退稿信息
    public void setRejection(String rejection) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update ReportLayer set rejection=" + db.cite(rejection) + " where node=  " + node);
        } finally
        {
            db.close();
        }
    }

    //修改本书署名
    private void setSignature(String signature) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE ReportLayer SET signature =" + db.cite(signature) + " WHERE node= " + node);
            //db.executeUpdate("UPDATE ReportLayer SET name ="+db.cite(name)+",units="+db.cite(units)+",email="+db.cite(email)+",mobile="+db.cite(mobile)+",address="+db.cite(address)+",telephone="+db.cite(telephone)+" WHERE node= "+node);
        } finally
        {
            db.close();
        }
        this.cbutors = cbutors;
        _htLayer.clear();
    }

    //修改图片路径
    private void setFile(String fe,String file,int language) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE ReportLayer SET " + fe + "=" + db.cite(file) + " WHERE node= " + node + " and language =" + language);
        } finally
        {
            db.close();
        }

        _htLayer.clear();
    }

    //修改作者author
    public void setAuthor(String author) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE ReportLayer SET author=" + db.cite(author) + " WHERE node= " + node);
        } finally
        {
            db.close();
        }
        _htLayer.clear();
    }

    //修改编辑
    private void setEditmember(String editmember,int language) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE ReportLayer SET editmember=" + db.cite(editmember) + " WHERE node= " + node + " and language=" + language);
        } finally
        {
            db.close();
        }
        _htLayer.clear();
    }

    //修改过稿件
    public void setManuscripttype(int manuscripttype) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Report SET manuscripttype=" + manuscripttype + " WHERE node= " + node);
        } finally
        {
            db.close();
        }
        this.manuscripttype = manuscripttype;
    }

    //修改发生时间
    public void setIssuetime(Date issuetime) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Report SET issuetime=" + db.cite(issuetime) + " WHERE node= " + node);
        } finally
        {
            db.close();
        }
        this.issuetime = issuetime;
    }

    //修改专家和新闻提供者
    public void set(String field,String value,int language) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(node,"UPDATE ReportLayer SET " + field + " =" + db.cite(value) + " WHERE node= " + node + " and language=" + language);
        } finally
        {
            db.close();
        }
        _htLayer.clear();
    }

    public void set(String field,String value) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(node,"UPDATE Report SET " + field + " =" + db.cite(value) + " WHERE node= " + node);
        } finally
        {
            db.close();
        }
    }


    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(" DELETE FROM Report   WHERE node=" + node);
            db.executeUpdate(" DELETE FROM ReportLayer   WHERE node=" + node);

        } finally
        {
            db.close();
        }
    }

    public int getMedia()
    {
        return media;
    }

    public int getCbutors()
    {
        return cbutors;
    }

    public Date getIssueTime()
    {
        return issuetime;
    }

    public int getManuscripttype()
    {
        return manuscripttype;
    }

    public String getIssueTimeToString()
    {
        if(issuetime == null)
        {
            return "";
        } else
        {
            return sdf.format(issuetime);
        }
    }

    public int getClasses()
    {
        return classes;
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getClasses2()
    {
        return classes2;
    }

    public int getFlag()
    {
        return flag;
    }

    public String getCoordinate()
    {
        return coordinate;
    }

    public String getEditionnumber()
    {
        return editionnumber;
    }

    //过滤字符
    public static String getHtml2(String inputString) throws SQLException
    {
        String htmlStr = inputString; // 含html标签的字符串
        String textStr = "";
        java.util.regex.Pattern p_script;
        java.util.regex.Matcher m_script;
        java.util.regex.Pattern p_style;
        java.util.regex.Matcher m_style;
        java.util.regex.Pattern p_html;
        java.util.regex.Matcher m_html;

        java.util.regex.Pattern p_html1;
        java.util.regex.Matcher m_html1;

        try
        {
            String regEx_script = "<[\\s]*?script[^>]*?>[\\s\\S]*?<[\\s]*?\\/[\\s]*?script[\\s]*?>"; // 定义script的正则表达式{或<script[^>]*?>[\\s\\S]*?<\\/script>
            // }
            String regEx_style = "<[\\s]*?style[^>]*?>[\\s\\S]*?<[\\s]*?\\/[\\s]*?style[\\s]*?>"; // 定义style的正则表达式{或<style[^>]*?>[\\s\\S]*?<\\/style>
            // }
            String regEx_html = "<[^>]+>"; // 定义HTML标签的正则表达式
            String regEx_html1 = "<[^>]+";
            p_script = Pattern.compile(regEx_script,Pattern.CASE_INSENSITIVE);
            m_script = p_script.matcher(htmlStr);
            htmlStr = m_script.replaceAll(""); // 过滤script标签

            p_style = Pattern.compile(regEx_style,Pattern.CASE_INSENSITIVE);
            m_style = p_style.matcher(htmlStr);
            htmlStr = m_style.replaceAll(""); // 过滤style标签

            p_html = Pattern.compile(regEx_html,Pattern.CASE_INSENSITIVE);
            m_html = p_html.matcher(htmlStr);
            htmlStr = m_html.replaceAll(""); // 过滤html标签

            p_html1 = Pattern.compile(regEx_html1,Pattern.CASE_INSENSITIVE);
            m_html1 = p_html1.matcher(htmlStr);
            htmlStr = m_html1.replaceAll(""); // 过滤html标签

            textStr = htmlStr;

        } catch(Exception e)
        {
            System.err.println("新闻中的Html2Text: " + e.getMessage());

        }

        return textStr; // 返回文本字符串

    }

    //过滤字符
    public static String getHtml(String htmlStr) throws SQLException
    {
        String regEx_script = "<[\\s]*?script[^>]*?>[\\s\\S]*?<[\\s]*?\\/[\\s]*?script[\\s]*?>"; //定义script的正则表达式{或<script[^>]*?>[\\s\\S]*?<\\/script> }
        java.util.regex.Matcher m_script;
        java.util.regex.Pattern p_script = java.util.regex.Pattern.compile(regEx_script,java.util.regex.Pattern.CASE_INSENSITIVE);
        m_script = p_script.matcher(htmlStr);
        htmlStr = m_script.replaceAll(""); //过滤script标签
        return htmlStr;

    }


    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT media,classes,issuetime,classes2,flag,coordinate,editionnumber,cbutors,manuscripttype," +
                            "audits_reason1,audits_reason2,audits_reason3,audits_reason4,refuse_audits,audits_reason0,audits_by0,audits_by1,audits_by2," +
                            " audits_by3,audits_by4,audits_by_member0,audits_by_member1,audits_by_member2,audits_by_member3,audits_by_member4," +
                            " audits_reason_member0,audits_reason_member1,audits_reason_member2,audits_reason_member3,audits_reason_member4,iseditreport " +
                            " FROM Report WHERE node=" + node);
            int i = 1;
            if(db.next())
            {
                media = db.getInt(i++);
                classes = db.getInt(i++);
                issuetime = db.getDate(i++);
                classes2 = db.getInt(i++);
                flag = db.getInt(i++);
                coordinate = db.getString(i++);
                editionnumber = db.getString(i++);
                cbutors = db.getInt(i++);
                manuscripttype = db.getInt(i++);
                audits_reason1 = db.getString(i++);
                audits_reason2 = db.getString(i++);
                audits_reason3 = db.getString(i++);
                audits_reason4 = db.getString(i++);
                refuse_audits = db.getInt(i++);
                audits_reason0 = db.getString(i++);
                audits_by0 = db.getString(i++);
                audits_by1 = db.getString(i++);
                audits_by2 = db.getString(i++);
                audits_by3 = db.getString(i++);
                audits_by4 = db.getString(i++);
                audits_by_member0 = db.getString(i++);
                audits_by_member1 = db.getString(i++);
                audits_by_member2 = db.getString(i++);
                audits_by_member3 = db.getString(i++);
                audits_by_member4 = db.getString(i++);
                audits_reason_member0 = db.getString(i++);
                audits_reason_member1 = db.getString(i++);
                audits_reason_member2 = db.getString(i++);
                audits_reason_member3 = db.getString(i++);
                audits_reason_member4 = db.getString(i++);
                iseditreport = db.getInt(i++);

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

    private RLayer getLayer(int language) throws SQLException
    {
        RLayer layer = (RLayer) _htLayer.get(new Integer(language));
        if(layer == null)
        {
            layer = new RLayer();
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT language,picture,locus,subhead,author,logograph,kicker,name,units,email,mobile,address,newquota,quotasource,editmember," +
                                " subjectfilename,subheadfilename,authorfilename,telephone,rejection,experts,providemember,signature FROM ReportLayer WHERE node=" + node + " ORDER BY " + (ConnectionPool._nType == 1 ? "DBO." : "") + "LAYER(language," + language + ")");
                if(db.next())
                {
                    int j = 1;
                    int lang = db.getInt(j++);
                    layer.picture = db.getString(j++);
                    layer.locus = db.getVarchar(lang,language,j++);
                    layer.subhead = db.getVarchar(lang,language,j++);
                    layer.author = db.getVarchar(lang,language,j++);
                    layer.logograph = db.getText(lang,language,j++);
                    layer.kicker = db.getString(j++);
                    layer.name = db.getString(j++);
                    layer.units = db.getString(j++);
                    layer.email = db.getString(j++);
                    layer.mobile = db.getString(j++);
                    layer.address = db.getString(j++);
                    layer.newquota = db.getString(j++);
                    layer.quotasource = db.getString(j++);
                    layer.editmember = db.getString(j++);
                    layer.subjectfilename = db.getString(j++);
                    layer.subheadfilename = db.getString(j++);
                    layer.authorfilename = db.getString(j++);
                    layer.telephone = db.getString(j++);
                    layer.rejection = db.getString(j++);
                    layer.experts = db.getString(j++);
                    layer.providemember = db.getString(j++);
                    layer.signature = db.getString(j++);
                } else
                {
                    layer.picture = "";
                }
            } finally
            {
                db.close();
            }
            _htLayer.put(language,layer);
        }
        return layer;
    }

    //文章字数合计
    public static int getReportCount(String community,String sql,int language) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int len = 0;
        try
        {
            db.executeQuery("SELECT n.node FROM Node n,Report r,NodeLayer nl,ReportLayer rl WHERE n.node=r.node AND n.node=nl.node AND n.node=rl.node AND  community=" + db.cite(community) + sql);
            while(db.next())
            {
                Node n = Node.find(db.getInt(1));
                String content = Node.Html2Text(n.getText(language));

                if(content != null && content.length() > 0)
                {
                    len = len + (n.getText(language).getBytes().length / 2);
                }
            }
        } finally
        {
            db.close();
        }
        return len;
    }

    //图片合计
    public static int getReportImg(String community,String sql,int language) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Pattern p = Pattern.compile("(<img )",Pattern.CASE_INSENSITIVE);
        int len = 0;
        try
        {
            db.executeQuery("SELECT n.node FROM Node n,Report r,NodeLayer nl,ReportLayer rl WHERE n.node=r.node AND n.node=nl.node AND n.node=rl.node AND  community=" + db.cite(community) + sql);
            while(db.next())
            {
                Node n = Node.find(db.getInt(1));
                int img = 0;
                Matcher m = p.matcher(n.getText(language));
                while(m.find())
                {
                    img++;
                }

                len = len + img;
            }
        } finally
        {
            db.close();
        }
        return len;
    }

    public String getNewquota(int lang) throws SQLException
    {
        return getLayer(lang).newquota;
    }

    public String getQuotasource(int lang) throws SQLException
    {
        return getLayer(lang).quotasource;
    }

    public String getSubjectfilename(int lang) throws SQLException
    {
        return getLayer(lang).subjectfilename;
    }

    public String getSubheadfilename(int lang) throws SQLException
    {
        return getLayer(lang).subheadfilename;
    }

    public String getAuthorfilename(int lang) throws SQLException
    {
        return getLayer(lang).authorfilename;
    }

    public String getPicture(int lang) throws SQLException
    {
        return getLayer(lang).picture;
    }

    public String getLogograph(int lang) throws SQLException
    {
        return getLayer(lang).logograph;
    }

    public String getKicker(int lang) throws SQLException
    {
        return getLayer(lang).kicker;
    }

    public String getLocus(int lang) throws SQLException
    {
        return getLayer(lang).locus;
    }

    public String getSubhead(int lang) throws SQLException
    {
        return getLayer(lang).subhead;
    }

    public String getName(int lang) throws SQLException
    {
        return getLayer(lang).name;
    }

    public String getUnits(int lang) throws SQLException
    {
        return getLayer(lang).units;
    }

    public String getEmail(int lang) throws SQLException
    {
        return getLayer(lang).email;
    }

    public String getMobile(int lang) throws SQLException
    {
        return getLayer(lang).mobile;
    }

    public String getAddress(int lang) throws SQLException
    {
        return getLayer(lang).address;
    }

    public String getTelephone(int lang) throws SQLException
    {
        return getLayer(lang).telephone;
    }

    public String getRejection(int lang) throws SQLException
    {
        return getLayer(lang).rejection;
    }

    public String getExperts(int lang) throws SQLException
    {
        return getLayer(lang).experts;
    }

    public String getProvidemember(int lang) throws SQLException
    {
        return getLayer(lang).providemember;
    }

    public String getSignature(int lang) throws SQLException
    {
        return getLayer(lang).signature;
    }

    public String getAuthor(int lang) throws SQLException
    {
        return getLayer(lang).author;
    }

    public String getEditmember(int lang) throws SQLException
    {
        return getLayer(lang).editmember;
    }

    public static String getDetail(Node node,Http h,int listing,int pos,String target) throws SQLException
    {
        StringBuilder htm = new StringBuilder();
        String subject = node.getSubject(h.language);
        ListingDetail detail = ListingDetail.find(listing,39,h.language);
        java.util.Iterator e = detail.keys();
        while(e.hasNext())
        {
            String name = (String) e.next(),value = "";
            int istype = detail.getIstype(name);
            if(istype == 0)
                continue;
            String data = null;
            String bi = detail.getBeforeItem(name),ai = detail.getAfterItem(name);
            int dq = detail.getQuantity(name);
            if(name.equals("name")) //主题
            {
                value = subject;
            } else if(name.equals("IssueTime")) //发生时间
            {
                Date issuetime = node.getStartTime();
                if(issuetime != null)
                {
                    if(detail.getQuantity(name) == 20) //月日
                    {
                        java.text.SimpleDateFormat sf = new java.text.SimpleDateFormat("MM-dd");
                        value = sf.format(issuetime);
                    } else if(detail.getQuantity(name) == 21) //年月日时分
                    {
                        value = MT.f(issuetime,1);
                    } else if(detail.getOptions(name).indexOf("/7/") != -1)
                    {
                        value = Entity.sdf_en.format(issuetime);
                    } else
                    {
                        value = MT.f(issuetime);
                    }
                }
            } else if(name.equals("text"))
            {
                //内容
                if(detail.getQuantity(name) == 0)
                {
                    h.language = detail.getOptions(name).indexOf("/7/") != -1 ? 0 : h.language;
                    value = node.getText_for(h,pos);
                } else
                {
                    value = node.getText(h.language);
                }
            } else if(name.equals("Logograph"))
            {
                value = node.getDescription(h.language);
            } else if(name.equals("getFathername")) //父亲节点主题
            {
                Node father = Node.find(node.getFather());
                value = father.getSubject(h.language);
            } else if(name.equals("comments")) //评论数
            {
                value = String.valueOf(Talkback.count(node._nNode));
            } else if(name.equals("correlation39"))
            {
                StringBuilder sb = new StringBuilder();
                ArrayList al = node.getCorrelation(h.language,39,dq,detail.getTime(name));
                for(int i = 0;i < al.size();i++)
                {
                    Node nc = (Node) al.get(i);
                    sb.append(bi);
                    sb.append("<a id='ReportIDcorrelation1' href='/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/report/" + nc._nNode + "-" + h.language + ".htm'>" + nc.getSubject(h.language) + "</a>");
                    Report r2 = Report.find(nc._nNode);
                    if(r2.getMedia() != 0)
                    {
                        Media m = Media.find(r2.getMedia());
                        if(m.type > 0)
                            sb.append("<span id='ReportIDcorrelationMedia'>" + m.getName(h.language) + "</span>");
                    }
                    sb.append("<span id='ReportIDcorrelation2'>" + MT.f(nc.getStartTime()) + "</span>");
                    sb.append(ai);
                }
                value = sb.toString();
                bi = ai = "";
            } else if(name.equals("correlation44")) // 相关 报纸文章
            {
                StringBuilder sb = new StringBuilder();
                ArrayList al = node.getCorrelation(h.language,44,dq,detail.getTime(name));
                for(int i = 0;i < al.size();i++)
                {
                    Node n = (Node) al.get(i);
                    sb.append(bi);
                    sb.append("<a id='ReportIDcorrelation441' href='/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/newspaper/" + n._nNode + "-" + h.language + ".htm'>" + n.getSubject(h.language) + "</a>");
                    sb.append(ai);
                }
                value = sb.toString();
                bi = ai = "";
            } else
            {
                Report r = Report.find(node._nNode);
                if(name.equals("MediaName"))
                {
                    int _nMedia = r.getMedia();
                    if(_nMedia > 0)
                    {
                        Media media = Media.find(_nMedia);
                        value = media.getName(h.language);
                    }
                } else if(name.equals("ClassName"))
                {
                    int _nClass = r.getClasses();
                    data = String.valueOf(_nClass);
                    Classes classes = Classes.find(_nClass);
                    value = (classes.getName());
                } else if(name.equals("ClassName2"))
                {
                    int _nClass2 = r.getClasses2();
                    ClassesChild classesc = ClassesChild.find(_nClass2);
                    value = (classesc.getName());
                } else if(name.equals("Picture"))
                {
                    String p = r.getPicture(h.language);
                    if(p != null && p.length() > 0)
                    {
                        value = "<img onerror=\"this.style.display='none';\" src=\"" + p + "\" />";
                    } else
                    {
                        value = "";
                    }
                } else if(name.equals("kicker")) //肩题
                {
                    value = r.getKicker(h.language);
                } else if(name.equals("newquota")) //新闻语录
                {
                    value = r.getNewquota(h.language);
                } else if(name.equals("quotasource")) //新闻出处
                {
                    value = r.getQuotasource(h.language);
                } else if(name.equals("Locus"))
                {
                    value = r.getLocus(h.language);
                } else if(name.equals("subjectfilename")) //主题图片
                {
                    String su = r.getSubjectfilename(h.language);
                    if(su != null && su.length() > 0)
                    {
                        value = "<img onerror=\"this.style.display='none';\" src=\"" + su + "\" />";
                    } else
                    {
                        value = "";
                    }
                } else if(name.equals("subheadfilename")) //副标题图片
                {
                    String p = r.getSubheadfilename(h.language);
                    if(p != null && p.length() > 0)
                    {
                        value = "<img onerror=\"this.style.display='none';\" src=\"" + p + "\" />";
                    } else
                    {
                        value = "";
                    }
                } else if(name.equals("authorfilename")) //作者图片
                {
                    String p = r.getAuthorfilename(h.language);
                    if(p != null && p.length() > 0)
                    {
                        value = "<img onerror=\"this.style.display='none';\" src=\"" + p + "\" />";
                    } else
                    {
                        value = "";
                    }
                } else if(name.equals("signature")) //本文署名
                {
                    value = r.getSignature(h.language);
                } else if(name.equals("MediaLogo"))
                {
                    Media media = Media.find(r.getMedia());
                    String logo = media.getLogo(h.language);
                    if(logo != null && logo.length() > 0)
                    {
                        value = "<img onerror=\"this.style.display='none';\" src=\"" + logo + "\" />";
                    }
                } else if(name.equals("getSubhead"))
                {
                    value = r.getSubhead(h.language);
                } else if(name.equals("getAuthor")) //新闻作者
                {
                    value = r.getAuthor(h.language);
                } else if(name.equals("editmember")) //新闻编辑
                {
                    value = r.getEditmember(h.language);
                } else if(name.equals("manuscripttype")) //稿件类别
                {
                    value = Report.MANUSCRIPT_TYPE[r.getManuscripttype()];
                }
            }
            if(value == null)
                value = "";
            if(istype == 2 && value.length() < 1)
                continue;
            //限制字数
            value = detail.getOptionsToHtml(name,node,value);
            //显示连接的地方
            if(detail.getAnchor(name) != 0)
            {
                if(subject != null && subject.length() > 0)
                    subject = subject.replace('"','\'');
                value = "<a href='" + node.getAnchor(h.language,h.status) + "' target='" + target + "' title=\"" + subject + "\">" + value + "</a>";
            }
            htm.append(bi).append("<span id='ReportID").append(name).append("'");
            if(data != null)
                htm.append(" data='" + data + "'");
            htm.append(">").append(value).append("</span>").append(ai);
        }
        return htm.toString();
    }


    public static int getAutherSum(String author) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int sum = 0;
        try
        {
            db.executeQuery("select count(node) from ReportLayer where author=" + db.cite(author));
            if(db.next())
            {
                sum = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return sum;
    }

//    public TeaSession getTeasession()
//    {
//        return teasession;
//    }
//
//
//    public void setTeasession(TeaSession teasession)
//    {
//        this.teasession = teasession;
//
//    }

    /*
     * 电子版 上一期，下一期 判断
     * 引用字段：<include src="/jsp/general/subscribe/Forward.jsp?node=2200246"/>
     */
    public static int getSXqc(int father,int node,String str) throws SQLException
    {
        int f = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            String sql = "";
            if("<".equals(str)) //上一条
            {
                sql = "select top 1 node from Node where time <(select time from Node where node = " + node + ") and father =" + father + " and hidden =0 and type =0 order by time desc";
            } else if(">".equals(str)) //下一条
            {
                sql = "select top 1 node from Node where time >(select time from Node where node = " + node + ") and father =" + father + " and hidden =0 and type =0 order by time asc";
            }
            db.executeQuery(sql);
            if(db.next())
            {
                f = db.getInt(1);
            }
        } finally
        {
            db.close();;
        }
        return f;
    }

    //显示上一版，下一版


    public static int getSXban(int father,int node,String str) throws SQLException
    {
        int f = 0;
        int sequence = Node.find(node).getSequence();

        DbAdapter db = new DbAdapter();
        try
        {
            String sql = "";
            if("<".equals(str)) //上一版
            {
                sql = "select top 1 node from Node where sequence <(select sequence from Node where node = " + node + ") and father =" + father + " and hidden =0 and type =1 order by sequence desc ";
            } else if(">".equals(str)) //下一版
            {
                sql = "select top 1 node from Node where sequence >(select sequence from Node where node = " + node + ") and father =" + father + " and hidden =0 and type =1  order by sequence asc ";
            }
            db.executeQuery(sql);
            if(db.next())
            {
                f = db.getInt(1);
            }
        } finally
        {
            db.close();;
        }
        return f;
    }


    // 如果是报纸的根节点，则返回最前面期次的第一版
    public static int getVersion(int father,int nid) throws SQLException
    {

        int node = 0;
        // if(_cache.get(String.valueOf(father)+String.valueOf(nid))!=null)
        // {
        // node = (Integer)_cache.get(String.valueOf(father)+String.valueOf(nid));
        /// }else
        //{
        DbAdapter db = new DbAdapter();
        try
        {
            Node n = Node.find(father);
            if(n.getCategoryosubscribe() != null && n.getCategoryosubscribe().indexOf("/0/") != -1)
            {
                if(father != nid)
                {
                    db.executeQuery("select  node  from Node  where hidden=0  and father = " + nid + " and type=1 order by sequence asc"); //返回版面 node号 是类别
                    //System.out.println("select  node  from Node  where hidden=0  and father = "+nid+" and type=1 order by sequence asc");
                    if(db.next())
                    {
                        node = db.getInt(1);
                        // _cache.put(String.valueOf(father)+String.valueOf(nid),db.getInt(1));
                    }
                } else
                { //返回期次 node号 是文件夹
                    db.executeQuery("select  n.node  from Node n,NodeLayer nl where n.node = nl.node and n.hidden=0 and n.type=0 and n.father = " + father + " order by nl.subject desc");
                    if(db.next())
                    {
                        node = db.getInt(1);
                        ///_cache.put(String.valueOf(father)+String.valueOf(nid),db.getInt(1));
                    }
                }
            }
        } finally
        {
            db.close();
        }
        // }
        return node;
    }

    //控制电子报节点文件权限
    public static boolean isCompetence(int node,int language,String ip,RV rv,HttpServletRequest request,HttpServletResponse response)
    {

        boolean f = false;

        String member = "";
        if(rv != null)
        {
            member = rv.toString();
        }

        Node nobj = Node.find(node);
        //获取当前的node
        int vn = node;

        try
        {

            if(nobj.getType() > 1) //说明是具体文章
            {
                nobj = Node.find(nobj.getFather());
                node = nobj.getFather();
            }

            int father = Tactics.getNode(nobj.getPath()); //报纸节点

            //判断跳转到版面节点上路径
            int versionid = Report.getVersion(father,vn);
            //System.out.println(versionid+":"+father);
            //System.out.println("/html/folder/"+versionid+"-"+h.language+".htm");


            if(versionid > 0)
            {
                try
                {
                    response.sendRedirect("/html/" + nobj.getCommunity() + "/folder/" + versionid + "-" + language + ".htm");
                } catch(IOException e)
                {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
            }

            if(nobj.getType() == 1 && Tactics.isTactics(father,nobj.getCommunity())) //说明是类别 .如果设置了策略 才可以判断下面内容
            {

                boolean cook = false;

                //判断是否使用手机支付
                if(Node.find(father).getCategoryosubscribe() != null && Node.find(father).getCategoryosubscribe().length() > 0 && Node.find(father).getCategoryosubscribe().indexOf("/4/") != -1)
                {
                    Cookie[] cookies = request.getCookies();

                    if(cookies != null)
                    {
                        for(int i = 0;i < cookies.length;i++)
                        {
                            //System.out.println(cookies[i].getName()+"--"+father);
                            if(cookies[i].getName().equals(String.valueOf(father)))
                            {
                                String cookieValue;
                                try
                                {
                                    cookieValue = URLDecoder.decode(cookies[i].getValue(),"utf-8");
                                    //System.out.println(cookieValue+"------------as");
                                    if(cookieValue != null && cookieValue.length() > 0)
                                    {
                                        //System.out.println(cookieValue);
                                        String mobile = cookieValue.split("/")[1];
                                        String mobilecode = cookieValue.split("/")[2];
                                        int n = Integer.parseInt(cookieValue.split("/")[3]);
                                        String c = cookieValue.split("/")[4];

                                        Enumeration e = MobileOrder.find(c," and type =1 and mobile=" + DbAdapter.cite(mobile) + " and mobilecode =" + DbAdapter.cite(mobilecode) + " and node=" + n,0,Integer.MAX_VALUE);
                                        while(e.hasMoreElements())
                                        {
                                            String mid = ((String) e.nextElement());
                                            MobileOrder mobj = MobileOrder.find(mid);
                                            if(mobj.isExists())
                                            {
                                                cook = true;
                                                break;
                                            }
                                        }
                                    }
                                } catch(UnsupportedEncodingException e)
                                {
                                    // TODO Auto-generated catch block
                                    e.printStackTrace();
                                }

                            }
                        }
                    }
                }

                String oftimes = Node.find(nobj.getFather()).getSubject(language); //;期次
                int sequence = nobj.getSequence(); //版次

                boolean fc = false;
                boolean fclog = false;

                //期次
                boolean qc = Tactics.isQiCi(oftimes,father,nobj.getCommunity());
                //阅读
                boolean yd = Tactics.isYueDu(father,nobj.getCommunity());
                //版次
                boolean bc = Tactics.isBanCi(father,nobj.getCommunity(),sequence);
                //判断ip
                boolean tip = Tactics.isIp(father,nobj.getCommunity(),ip);

                //判断Cookie




                if(cook) // 如果使用cook
                {
                    //System.out.println("-----通过Cookie查看------");


                    //System.out.println("qc:"+qc+"---yd:"+yd);
                    //先判断是否有ip的，如果有ip则可以查看
                } else if(tip) //说明访问者ip是在设置的ip段内，不受任何限制 可以进入查看
                {
                    //System.out.println("===========通过【ip】进入阅读页面 ================");
                } else
                {
                    //System.out.println(!qc+"-"+!yd+"--"+!bc);
                    if(!qc || !yd || !bc)
                    {
                        //System.out.println("您不能查看这个页面，需要订阅");

                        //判断用户是否登录
                        if(member != null && member.length() > 0)
                        {
                            fc = true;
                        } else
                        {
                            fclog = true;

                        }
                    } else
                    {
                        //判断生效条件
                        int sxtj = Tactics.getSXtiaojian(father,nobj.getCommunity(),member,sequence,oftimes);

                        if(sxtj == 0)
                        {
                            //System.out.println("=========== 通过生效条件中    【访问】 进入阅读页面================");
                        } else if(sxtj == 2 || sxtj == 3)
                        {
                            //System.out.println("===========通过生效条件中    【会员登录】 进入阅读页面 ================");
                        } else if(sxtj == 4)
                        {
                            //System.out.println("===========生效条件 限制不能查看这个页面，必须登录================");

                            //response.sendRedirect("/servlet/StartLogin?node="+node);
                            fclog = true;

                        } else
                        {
                            //System.out.println("===========生效条件您不能查看着这个页面================");
                            fc = true;
                        }

                    }

                }

                if(fclog)
                {
                    try
                    {
                        //response.sendRedirect("/jsp/general/subscribe/Alert.jsp?type=0");
                        response.sendRedirect("/jsp/general/subscribe/Alert.jsp?type=0&node=" + father + "&nexturl=" + java.net.URLEncoder.encode("/html/node/" + node + ".htm","UTF-8"));
                    } catch(IOException e)
                    {
                        // TODO Auto-generated catch block
                        e.printStackTrace();
                    }
                } else if(fc)
                {
                    //如果用户登录则取判断 用户是否订阅套餐
                    //对用户套餐判断
                    //判断其次
                    boolean tc = PackageOrder.isTaoCan(oftimes,father,nobj.getCommunity(),member,sequence);
                    if(!tc)
                    {
                        //System.out.println("您需要订阅套餐，才能查看");
                        try
                        {
                            response.sendRedirect("/jsp/general/subscribe/Alert.jsp?type=1&node=" + father + "&nexturl=" + java.net.URLEncoder.encode("/html/node/" + node + ".htm","UTF-8"));
                        } catch(IOException e)
                        {
                            // TODO Auto-generated catch block
                            e.printStackTrace();
                        }
                    }
                }

            }

        } catch(SQLException e)
        {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return f;
    }


    //判断是否有积分
    public static String getIntegral(Http h)
    {
        StringBuffer a = new StringBuffer("");
        try
        {
            NodePoints np = NodePoints.get(h.node);
            float integral = 0;
            if(np.getLlwz() > 0)
            {
                if(h != null)
                {
                    if(h.member != 0)
                    {
                        Profile profile = Profile.find(h.member);
                        integral = profile.getIntegral();
                    }
                }

                if(h.member == 0)
                {
                    a.append("<script>alert('您还没有登陆，请登陆后查看');self.location='/servlet/StartLogin?node=" + h.node + "'</script>");
                } else
                if(integral < np.getLlwz() && h.member != 0)
                {
                    a.append("<script>alert('对不起,您的积分不足,不能浏览该文章!');self.location='/html/node/" + Node.find(h.node).getFather() + "-" + h.language + ".htm';</script>");
                } else
                {
                    if("y".equals(h.get("type")))
                    {

                    } else
                    {
                        a.append("<script>if(confirm(\"浏览该文件要扣减积分" + np.getLlwz() + "是否继续\")){ window.open('/html/report/" + h.node + "-" + h.language + ".htm?type=y','_self');}else{self.location='/html/node/" + Node.find(h.node).getFather() + "-" + h.language + ".htm';}</script>");
                    }
                }
            }
        } catch(SQLException e)
        {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return a.toString();
    }

    public String getAudits_reason0()
    {
        return audits_reason0;
    }

    public String getAudits_reason1()
    {
        return audits_reason1;
    }

    public String getAudits_reason2()
    {
        return audits_reason2;
    }

    public String getAudits_reason3()
    {
        return audits_reason3;
    }

    public String getAudits_reason4()
    {
        return audits_reason4;
    }

    public int getRefuse_audits()
    {
        return refuse_audits;
    }

    public int getIseditreport()
    {
        return iseditreport;
    }


    public String getAudits_by0()
    {
        return audits_by0;
    }

    public String getAudits_by1()
    {
        return audits_by1;
    }

    public String getAudits_by2()
    {
        return audits_by2;
    }

    public String getAudits_by3()
    {
        return audits_by3;
    }

    public String getAudits_by4()
    {
        return audits_by4;
    }

    public String getAudits_by_member0()
    {
        return audits_by_member0;
    }

    public String getAudits_by_member1()
    {
        return audits_by_member1;
    }

    public String getAudits_by_member2()
    {
        return audits_by_member2;
    }

    public String getAudits_by_member3()
    {
        return audits_by_member3;
    }

    public String getAudits_by_member4()
    {
        return audits_by_member4;
    }

    public String getAudits_reason_member0()
    {
        return audits_reason_member0;
    }

    public String getAudits_reason_member1()
    {
        return audits_reason_member1;
    }

    public String getAudits_reason_member2()
    {
        return audits_reason_member2;
    }

    public String getAudits_reason_member3()
    {
        return audits_reason_member3;
    }

    public String getAudits_reason_member4()
    {
        return audits_reason_member4;
    }

    public Report clone() throws CloneNotSupportedException
    {
        Report t = (Report)super.clone();
        return t;
    }

}
