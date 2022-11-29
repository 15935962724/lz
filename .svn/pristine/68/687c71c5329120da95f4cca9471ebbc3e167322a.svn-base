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

/**
 * 普通用户升级记录
 */
public class OperationMes {
    private int id;           // id
    private int member;        // member
    private String act;
    private String par;//
    private Date time;//
    private String requesturl;//

    private String profile;

    private String timeStr;

    public OperationMes() {
    }

    public OperationMes(int id) {
        this.id = id;
    }

    /**
     * 分页查询所有
     * @param sql
     * @param pos
     * @param size
     * @return
     */
    public static List<OperationMes> find(String sql, int pos, int size){
        ArrayList<OperationMes> upList = new ArrayList<OperationMes>();
        DbAdapter db = new DbAdapter();
        String SQsql = "select id,member,act,par,time,requesturl from OperationMes where 1=1 " + sql;
        try {
            ResultSet rs = db.executeQuery(SQsql, pos, size);
            while (rs.next()){
                int i=1;
                OperationMes up = new OperationMes(rs.getInt(i++));
                up.member = db.getInt(i++   );
                up.act = db.getString(i++   );
                up.par = db.getString(i++  );
                up.time = db.getDate(i++);
                up.requesturl = db.getString(i++);
                upList.add(up);
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.close();
        }
        return upList;
    }

    /**
     * 查询数量
     * @param sql
     * @return
     */
    public static int count(String sql) throws SQLException {
        return DbAdapter.execute("select count(0) from OperationMes where 1=1" + sql);
    }

    /**
     * 根据用户id查询
     * @param id
     * @return
     * @throws SQLException
     */
    public static OperationMes findByMember(int id) throws SQLException
    {
        OperationMes t = null;
        ArrayList<OperationMes> al = (ArrayList<OperationMes>) find(" AND id=" + id, 0, 1);
        t = al.size() < 1 ? new OperationMes(0) : (OperationMes) al.get(0);
        return t;
    }

    /**
     * 根据id查询
     * @return
     */
    public static OperationMes find(int id){
        OperationMes up = null;
        if(up == null){
            ArrayList<OperationMes> list = (ArrayList<OperationMes>) find(" AND id = " + id, 0, 1);
            up = list.size() < 1 ? new OperationMes(id):list.get(0);
        }
        return up;
    }

    /**
     * 添加 || 修改
     */
    public void set() throws SQLException {
        String sql = "";
        if(this.id<1){
            id = Seq.get();
            sql = "insert into OperationMes(id,member,act,par,time,requesturl) values("+id+","+member+","+ Database.cite(act) +","+Database.cite(par)+","+Database.cite(time)+","+Database.cite(requesturl)+")";
        }else{
            sql = "update OperationMes set member="+member+",act="+Database.cite(act)+",par="+Database.cite(par)+",time="+Database.cite(time)+",requesturl="+Database.cite(requesturl)+" where id=" + this.id;
        }
        DbAdapter db = new DbAdapter();
        try {
            db.executeUpdate(this.id,sql);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.close();
        }
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

    public String getAct() {
        return act;
    }

    public void setAct(String act) {
        this.act = act;
    }

    public String getPar() {
        return par;
    }

    public void setPar(String par) {
        this.par = par;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public String getRequesturl() {
        return requesturl;
    }

    public void setRequesturl(String requesturl) {
        this.requesturl = requesturl;
    }

    public String getProfile() {
        return profile;
    }

    public void setProfile(String profile) {
        this.profile = profile;
    }

    public String getTimeStr() {
        return timeStr;
    }

    public void setTimeStr(String timeStr) {
        this.timeStr = timeStr;
    }
}
