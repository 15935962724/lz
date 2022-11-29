package tea.entity.yl.shop;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Database;
import tea.entity.Seq;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class SecurityCode {
    protected static Cache c = new Cache(50);
    private int id;
    private int pid;
    private int code;
    private String nicheng;

    public SecurityCode(int id) {
        this.id = id;
    }

    /**
     * 根据pid查询
     *
     * @param
     * @return
     */
    public static SecurityCode find(int id) throws SQLException {
        SecurityCode sf = (SecurityCode) c.get(id);
        if (sf == null) {
            List<SecurityCode> list = find(" AND id = " + id, 0, 1);
            sf = list.size() < 1 ? new SecurityCode(id) : list.get(0);
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
    public static List<SecurityCode> find(String sql, int pos, int page_size) throws SQLException {
        List<SecurityCode> sfList = new ArrayList<SecurityCode>();
        DbAdapter db = new DbAdapter();
        String SQsql = "select id,pid,code,nicheng from tb_securityCode where 1=1 " + sql;
        try {
            ResultSet rs = db.executeQuery(SQsql, pos, page_size);
            while (rs.next()) {
                int i = 1;
                SecurityCode sf = new SecurityCode(rs.getInt(i++));
                sf.setPid(rs.getInt(i++));
                sf.setCode(rs.getInt(i++));
                sf.setNicheng(rs.getString(i++));
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
            sql = "INSERT INTO tb_securityCode(id,pid,code,nicheng)VALUES(" + (id = Seq.get()) + ","+pid+","+code+","+Database.cite(nicheng)+")";
        } else {
            sql = "UPDATE tb_securityCode SET pid=" + pid+ ",code=" +code+ ",nicheng="+ Database.cite(nicheng)+" WHERE id=" + id;
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

    /*
     * 查询条数
     * */
    public static int count(String sql) throws SQLException {
        return DbAdapter.execute("SELECT COUNT(*) from tb_securityCode WHERE 1=1 " + sql);

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

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getNicheng() {
        return nicheng;
    }

    public void setNicheng(String nicheng) {
        this.nicheng = nicheng;
    }
}
