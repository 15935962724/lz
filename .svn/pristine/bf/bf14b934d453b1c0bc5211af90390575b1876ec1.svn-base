package tea.entity.yl.shop;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Conf;
import tea.entity.Seq;
import util.Config;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;


public class JihuoCode {
    protected static Cache c = new Cache(50);
    private int id; //主键id
    private String code;//激活码
    private Date time;//创建时间
    private int usetype;//使用状态
    private int type;//类型 时间or次数or客户端
    private int type_child;//类型下选项
    private int member;//创建人
    private String mail;//邮箱



    public JihuoCode(int id) {
        this.id = id;
    }

    public static Map<String,String> jtype= new LinkedHashMap<String, String>();//类型
    public static String [] JihuoCodeField = {"","code","type","type_child"};

    static {
        jtype.put("请选择激活码类型", "");
        jtype.put("时间", Config.getString("shijian"));
        jtype.put("次数", Config.getString("cishu"));
        jtype.put("客户端", Config.getString("kehuduan"));

    }



    /**
     * 根据id查询
     *
     * @param
     * @return
     */
    public static JihuoCode find(int id) throws SQLException {
        JihuoCode sf = (JihuoCode) c.get(id);
        if (sf == null) {
            List<JihuoCode> list = find(" AND id = " + id, 0, 1);
            sf = list.size() < 1 ? new JihuoCode(id) : list.get(0);
        }
        return sf;
    }
    /*
    * 查询条数
    * */
    public static int count(String sql) throws SQLException {
            return DbAdapter.execute("SELECT COUNT(*) from tb_jihuoCode WHERE 1=1 " + sql);

    }




    /**
     * 分页查询所有
     *
     * @param sql
     * @param pos
     * @param page_size
     * @return
     */
    public static List<JihuoCode> find(String sql, int pos, int page_size) throws SQLException {
        List<JihuoCode> sfList = new ArrayList<JihuoCode>();
        DbAdapter db = new DbAdapter();
        String SQsql = "select id,code,time,usetype,type,member,mail,type_child from tb_jihuoCode where 1=1 " + sql;
        try {
            ResultSet rs = db.executeQuery(SQsql, pos, page_size);
            while (rs.next()) {
                int i = 1;
                JihuoCode sf = new JihuoCode(rs.getInt(i++));
                sf.setCode(rs.getString(i++));
                sf.setTime(rs.getDate(i++));
                sf.setUsetype(rs.getInt(i++));
                sf.setType(rs.getInt(i++));
                sf.setMember(rs.getInt(i++));
                sf.setMail(rs.getString(i++));
                sf.setType_child(rs.getInt(i++));
                c.put(sf.id, sf);
                sfList.add(sf);
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.close();
        }
        return sfList;
    }

    public int set() throws SQLException {
        String sql;
        if (id < 1) {
            sql = "INSERT INTO tb_jihuoCode(id,code,time,usetype,type,member,mail,type_child)VALUES("+(id=Seq.get())+","+DbAdapter.cite(code)+","+DbAdapter.cite(new Date())+","+usetype+","+type+","+member+","+DbAdapter.cite(mail)+","+type_child+")";
        } else {
            sql = "UPDATE tb_jihuoCode SET code=" + DbAdapter.cite(code) + ",time=" + DbAdapter.cite(new Date()) + ",usetype=" +usetype+ ",type=" + type + ",member=" + member + ",mail="+DbAdapter.cite(mail)+",type_child="+type_child+" WHERE id=" + id;
        }
        DbAdapter db = new DbAdapter();
        try {
            db.executeUpdate(id, sql);
        } finally {
            db.close();
        }
        c.remove(id);
        return id;
    }

    public static void delete(String ids) {
        DbAdapter db = new DbAdapter();
        try {
            db.executeUpdate("DELETE FROM tb_jihuoCode WHERE id in(" + ids + ")");
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.close();
        }
        String[] arr = ids.split(",");
        for (int i = 0; i < arr.length; i++) {
            c.remove(arr[i]);
        }
    }

    public static Cache getC() {
        return c;
    }

    public static void setC(Cache c) {
        JihuoCode.c = c;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public int getMember() {
        return member;
    }

    public void setMember(int member) {
        this.member = member;
    }

    public int getUsetype() {
        return usetype;
    }

    public void setUsetype(int usetype) {
        this.usetype = usetype;
    }

    public String getMail() {
        return mail;
    }

    public void setMail(String mail) {
        this.mail = mail;
    }

    public int getType_child() {
        return type_child;
    }

    public void setType_child(int type_child) {
        this.type_child = type_child;
    }
}
