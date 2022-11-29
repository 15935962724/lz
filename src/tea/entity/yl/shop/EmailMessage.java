package tea.entity.yl.shop;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Database;
import tea.entity.Seq;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class EmailMessage {
    protected static Cache c = new Cache(50);
    private int id; //主键id
    private String email; //邮箱号
    private String time ;//日期   YYYY-mm-dd
    public EmailMessage(int id) {
        this.id = id;
    }

    /**
     * 根据id查询
     *
     * @param
     * @return
     */
    public static EmailMessage find(int id) throws SQLException {
        EmailMessage sf = (EmailMessage) c.get(id);
        if (sf == null) {
            List<EmailMessage> list = find(" AND id = " + id, 0, 1);
            sf = list.size() < 1 ? new EmailMessage(id) : list.get(0);
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
    public static List<EmailMessage> find(String sql, int pos, int page_size) throws SQLException {
        List<EmailMessage> sfList = new ArrayList<EmailMessage>();
        DbAdapter db = new DbAdapter();
        String SQsql = "select id,email,time from tb_emailmessage where 1=1 " + sql;
        try {
            ResultSet rs = db.executeQuery(SQsql, pos, page_size);
            while (rs.next()) {
                int i = 1;
                EmailMessage sf = new EmailMessage(rs.getInt(i++));
                sf.setEmail(rs.getString(i++));
                sf.setTime(rs.getString(i++));
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
        return DbAdapter.execute("select count(0) from tb_emailmessage  where 1=1 " + sql);
    }

    public int set() throws SQLException{
        String sql;
        if (id < 1){
            sql = "INSERT INTO tb_emailmessage(id,email,time)VALUES(" + (id = Seq.get())+","+Database.cite(email)+","+Database.cite(time)+")";
        } else {
            sql = "UPDATE tb_emailmessage SET email=" + DbAdapter.cite(email) + ",time=" + Database.cite(time) + "  WHERE id=" + id;
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
            db.executeUpdate("DELETE FROM tb_emailmessage WHERE id in(" + ids + ")");
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
        EmailMessage.c = c;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }
}
