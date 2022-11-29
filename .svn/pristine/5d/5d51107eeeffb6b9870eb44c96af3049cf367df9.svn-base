package tea.entity.yl.shop;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Seq;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class CreatDetail {
    protected static Cache c = new Cache(50);
    private int id; //主键id
    private int pid; //用户 profile
    private int creatpid; //创建人


    public CreatDetail(int id) {
        this.id = id;
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
    public static List<CreatDetail> find(String sql, int pos, int page_size) throws SQLException {
        List<CreatDetail> sfList = new ArrayList<CreatDetail>();
        DbAdapter db = new DbAdapter();
        String SQsql = "select id,pid,creatpid from tb_creatDetail where 1=1 " + sql;
        try {
            ResultSet rs = db.executeQuery(SQsql, pos, page_size);
            while (rs.next()) {
                int i = 1;
                CreatDetail sf = new CreatDetail(rs.getInt(i++));
                sf.setPid(rs.getInt(i++));
                sf.setCreatpid(rs.getInt(i++));
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
            sql = "INSERT INTO tb_creatDetail(id,pid,creatpid)VALUES("+(id=Seq.get())+","+pid+","+creatpid+")";
        } else {
            sql = "UPDATE tb_creatDetail SET pid=" + pid + ",creatpid=" + creatpid + " WHERE id=" + id;
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
            db.executeUpdate("DELETE FROM tb_creatDetail WHERE id in(" + ids + ")");
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

    /**
     * 根据id查询
     *
     * @param
     * @return
     */
    public static CreatDetail find(int id) throws SQLException {
        CreatDetail sf = (CreatDetail) c.get(id);
        if (sf == null) {
            List<CreatDetail> list = find(" AND id = " + id, 0, 1);
            sf = list.size() < 1 ? new CreatDetail(id) : list.get(0);
        }
        return sf;
    }

    public static Cache getC() {
        return c;
    }

    public static void setC(Cache c) {
        CreatDetail.c = c;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getPid() {
        return pid;
    }

    public void setPid(int pid) {
        this.pid = pid;
    }

    public int getCreatpid() {
        return creatpid;
    }

    public void setCreatpid(int creatpid) {
        this.creatpid = creatpid;
    }
}
