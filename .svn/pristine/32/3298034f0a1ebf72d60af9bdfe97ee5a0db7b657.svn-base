package tea.entity.yl.shop;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Seq;
import util.Config;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;


public class NcLzProduct {
    protected static Cache c = new Cache(50);
    private int id; //主键id
    private int puid; //厂商
    private String activity; //活度
    private String activityScope;//范围
    private int status;//1 单个活度   2范围
    private String ncCode;//nc编码
    private int member;//最后编辑人
    public NcLzProduct(int id) {
        this.id = id;
    }

    /**
     * 根据id查询
     *
     * @param
     * @return
     */
    public static NcLzProduct find(int id) throws SQLException {
        NcLzProduct sf = (NcLzProduct) c.get(id);
        if (sf == null) {
            List<NcLzProduct> list = find(" AND id = " + id, 0, 1);
            sf = list.size() < 1 ? new NcLzProduct(id) : list.get(0);
        }
        return sf;
    }
    /*
    * 查询条数
    * */
    public static int count(String sql) throws SQLException {
            return DbAdapter.execute("SELECT COUNT(*) from tb_NcLzProduct WHERE 1=1 " + sql);

    }




    /**
     * 分页查询所有
     *
     * @param sql
     * @param pos
     * @param page_size
     * @return
     */
    public static List<NcLzProduct> find(String sql, int pos, int page_size) throws SQLException {
        List<NcLzProduct> sfList = new ArrayList<NcLzProduct>();
        DbAdapter db = new DbAdapter();
        String SQsql = "select id,puid,activity,activityScope,status,ncCode,member from tb_NcLzProduct where 1=1 " + sql;
        try {
            ResultSet rs = db.executeQuery(SQsql, pos, page_size);
            while (rs.next()) {
                int i = 1;
                NcLzProduct sf = new NcLzProduct(rs.getInt(i++));
                sf.setPuid(rs.getInt(i++));
                sf.setActivity(rs.getString(i++));
                sf.setActivityScope(rs.getString(i++));
                sf.setStatus(rs.getInt(i++));
                sf.setNcCode(rs.getString(i++));
                sf.setMember(rs.getInt(i++));
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
            sql = "INSERT INTO tb_NcLzProduct(id,puid,activity,activityScope,status,ncCode,member)VALUES("+(id=Seq.get())+","+puid+","+DbAdapter.cite(activity)+","+DbAdapter.cite(activityScope)+","+status+","+DbAdapter.cite(ncCode)+","+member+")";
        } else {
            sql = "UPDATE tb_NcLzProduct SET puid=" + puid + ",activity=" + DbAdapter.cite(activity) + ",activityScope=" +DbAdapter.cite(activityScope)+ ",status=" + status + ",ncCode=" + DbAdapter.cite(ncCode) + ",member="+member+" WHERE id=" + id;
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
            db.executeUpdate("DELETE FROM tb_NcLzProduct WHERE id in(" + ids + ")");
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

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getPuid() {
        return puid;
    }

    public void setPuid(int puid) {
        this.puid = puid;
    }

    public String getActivity() {
        return activity;
    }

    public void setActivity(String activity) {
        this.activity = activity;
    }

    public String getActivityScope() {
        return activityScope;
    }

    public void setActivityScope(String activityScope) {
        this.activityScope = activityScope;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getNcCode() {
        return ncCode;
    }

    public void setNcCode(String ncCode) {
        this.ncCode = ncCode;
    }

    public int getMember() {
        return member;
    }

    public void setMember(int member) {
        this.member = member;
    }
}
