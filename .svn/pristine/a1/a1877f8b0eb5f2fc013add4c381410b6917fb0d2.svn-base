package tea.entity.yl.shop;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Database;
import tea.entity.Seq;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


public class TbMeeting {
    protected static Cache c = new Cache(50);
    private int id; //主键id
    private int member;//账户id
    private Date create_Data;//创建日期
    private String name;//会议名称
    private int inform; //会议通知
    private int zhaoshang;//招商函
    private int apply;//申请表
    private int type;//审核状态
    private String cause;//失败原因

    public TbMeeting(int id) {
        this.id = id;
    }

    /**
     * 根据id查询
     *
     * @param
     * @return
     */
    public static TbMeeting find(int id) throws SQLException {
        TbMeeting sf = (TbMeeting) c.get(id);
        if (sf == null) {
            List<TbMeeting> list = find(" AND id = " + id, 0, 1);
            sf = list.size() < 1 ? new TbMeeting(id) : list.get(0);
        }
        return sf;
    }


    /**
     * 分页查询所有
     *
     * @param sql
     * @param pos
     * @param page_size
     * @return
     */
    public static List<TbMeeting> find(String sql, int pos, int page_size) throws SQLException {
        List<TbMeeting> sfList = new ArrayList<TbMeeting>();
        DbAdapter db = new DbAdapter();
        String SQsql = "select id,member,create_Data,name,inform,zhaoshang,apply,type,cause from tb_meeting where 1=1 " + sql;
        try {
            ResultSet rs = db.executeQuery(SQsql, pos, page_size);
            while (rs.next()) {
                int i = 1;
                TbMeeting sf = new TbMeeting(rs.getInt(i++));
                sf.setMember(rs.getInt(i++));
                sf.setCreate_Data(db.getDate(i++));
                sf.setName(rs.getString(i++));
                sf.setInform(rs.getInt(i++));
                sf.setZhaoshang(rs.getInt(i++));
                sf.setApply(rs.getInt(i++));
                sf.setType(rs.getInt(i++));
                sf.setCause(rs.getString(i++));
                c.put(sf.id,sf);
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

    public static int count(String sql) throws SQLException{
//		String Qsql = "select count(0) from shoporder so "+tab(sql)+" where 1=1 " + sql;
//		System.out.println(Qsql);
        return DbAdapter.execute("select count(0) from tb_meeting  where 1=1 " + sql);
    }

    public int set() throws SQLException{
        String sql;
        if (id < 1){
            sql = "INSERT INTO tb_meeting(id,member,create_Data,name,inform,zhaoshang,apply,type,cause)VALUES(" + (id = Seq.get()) +","+member+","+ Database.cite(new Date()) +","+ DbAdapter.cite(name)+","+inform+ ","+zhaoshang+","+apply+","+type+","+Database.cite(cause)+")";
        } else {
            sql = "UPDATE tb_meeting SET name=" + DbAdapter.cite(name) + ",create_Data=" + Database.cite(new Date()) + ",inform=" +inform+ ",zhaoshang=" +zhaoshang + ",apply=" +apply+ ",type=" + type + ",cause="+Database.cite(cause)+" WHERE id=" + id;
        }
        DbAdapter db = new DbAdapter();
        try{
            db.executeUpdate(id, sql);
        } finally{
            db.close();
        }
        c.remove(id);
        return id;
    }

    public static void delete(String ids){
        DbAdapter db = new DbAdapter();
        try {
            db.executeUpdate("DELETE FROM tb_meeting WHERE id in(" + ids + ")");
        } catch (SQLException e) {
            e.printStackTrace();
        }finally{
            db.close();
        }
        String[] arr = ids.split(",");
        for(int i=0;i<arr.length;i++){
            c.remove(arr[i]);


        }
    }

    public static Cache getC() {
        return c;
    }

    public static void setC(Cache c) {
        TbMeeting.c = c;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getMember() {
        return member;
    }

    public void setMember(int member) {
        this.member = member;
    }

    public Date getCreate_Data() {
        return create_Data;
    }

    public void setCreate_Data(Date create_Data) {
        this.create_Data = create_Data;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getInform() {
        return inform;
    }

    public void setInform(int inform) {
        this.inform = inform;
    }

    public int getZhaoshang() {
        return zhaoshang;
    }

    public void setZhaoshang(int zhaoshang) {
        this.zhaoshang = zhaoshang;
    }

    public int getApply() {
        return apply;
    }

    public void setApply(int apply) {
        this.apply = apply;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public String getCause() {
        return cause;
    }

    public void setCause(String cause) {
        this.cause = cause;
    }
}
