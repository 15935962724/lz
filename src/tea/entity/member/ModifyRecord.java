package tea.entity.member;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Entity;
import tea.entity.Seq;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 订单跟踪记录Entity
 *
 * @author liuzq
 * @version 2020-11-19
 */
public class ModifyRecord extends Entity {

    protected static Cache c = new Cache(500);
    private int id;
    private String order_id;//	订单ID
    private String content;//	操作类型  下单、出库、收货
    private int member;//	修改人
    private Date modifyTime;//	修改时间
    private String contentDetail;// 操作详情

    public ModifyRecord(int id) {
        this.id = id;
    }

    public static ModifyRecord find(int id) throws SQLException {
        ModifyRecord t = (ModifyRecord) c.get(id);
        if (t == null) {
            List<ModifyRecord> al = find(" AND id=" + id, 0, 1);
            t = al.size() < 1 ? new ModifyRecord(id) : al.get(0);
        }
        return t;
    }

    public static List<ModifyRecord> find(String sql, int pos, int size) throws SQLException {
        List<ModifyRecord> al = new ArrayList<ModifyRecord>();
        DbAdapter db = new DbAdapter();
        try {
            java.sql.ResultSet rs = db.executeQuery("SELECT m.id,m.order_id,m.content,m.member,m.modifyTime,m.contentDetail FROM tb_modifyRecord m " + tab(sql) + " WHERE 1=1" + sql, pos, size);
            while (rs.next()) {
                int i = 1;
                ModifyRecord obj = new ModifyRecord(rs.getInt(i++));
                obj.setOrder_id(rs.getString(i++));
                obj.setContent(rs.getString(i++));
                obj.setMember(rs.getInt(i++));
                obj.setModifyTime(db.getDate(i++));
                obj.setContentDetail(rs.getString(i++));
                c.put(obj.id, obj);
                al.add(obj);
            }
            rs.close();
        } finally {
            db.close();
        }
        return al;
    }

    public static int count(String sql) throws SQLException {
        return DbAdapter.execute("SELECT COUNT(*) from tb_modifyRecord m " + tab(sql) + " WHERE 1=1" + sql);
    }

    public int set() throws SQLException {
        String sql;
        if (id < 1) {
            sql = "INSERT INTO tb_modifyRecord(id,order_id,content,member,modifyTime,contentDetail)VALUES("
                    + (id = Seq.get()) + ","
                    + DbAdapter.cite(order_id) + ","
                    + DbAdapter.cite(content) + ","
                    + member + ","
                    + DbAdapter.cite(modifyTime)+","
                    +DbAdapter.cite(contentDetail)+
                    ")";

        } else
            sql="";//不修改
        DbAdapter db = new DbAdapter();
        try {
            db.executeUpdate(id, sql);
        } finally {
            db.close();
        }
        c.remove(id);
        return id;
    }

    public static String tab(String sql) {
        StringBuilder sb = new StringBuilder();
        if (sql.contains(" AND p."))
            sb.append(" inner join Profile p on m.member = p.profile");
        return sb.toString();
    }

    public void delete() throws SQLException {
        DbAdapter db = new DbAdapter();
        try {
            db.executeUpdate(id, "DELETE FROM tb_modifyRecord WHERE id=" + id);
        } finally {
            db.close();
        }
        c.remove(id);
    }

    public void set(String f, String v) throws SQLException {
        DbAdapter db = new DbAdapter();
        try {
            db.executeUpdate(id, "UPDATE tb_modifyRecord SET " + f + "=" + DbAdapter.cite(v) + " WHERE id=" + id);
        } finally {
            db.close();
        }
        c.remove(id);
    }

    public static  void creatModifyRecord(String order_id,String content,int member,String contentDetail) throws SQLException {
        ModifyRecord modifyRecord = new ModifyRecord(0);
        modifyRecord.setContent(content);
        modifyRecord.setModifyTime(new Date());
        modifyRecord.setOrder_id(order_id);
        modifyRecord.setMember(member);
        modifyRecord.setContentDetail(contentDetail);
        modifyRecord.set();
    }

    public static Cache getC() {
        return c;
    }

    public static void setC(Cache c) {
        ModifyRecord.c = c;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getOrder_id() {
        return order_id;
    }

    public void setOrder_id(String order_id) {
        this.order_id = order_id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getMember() {
        return member;
    }

    public void setMember(int member) {
        this.member = member;
    }

    public Date getModifyTime() {
        return modifyTime;
    }

    public void setModifyTime(Date modifyTime) {
        this.modifyTime = modifyTime;
    }

    public String getContentDetail() {
        return contentDetail;
    }

    public void setContentDetail(String contentDetail) {
        this.contentDetail = contentDetail;
    }
}