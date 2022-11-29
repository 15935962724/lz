package tea.entity.yl.shop;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Seq;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


public class JihuoUse {
    protected static Cache c = new Cache(50);
    private int id;
    private int codeid;
    private String orderid;
    private int productid;
    private int memberid;
    private Date usetime;//使用时间

    public static String[] type = {"","时间","次数","客户端"};

    public JihuoUse(int id) {
        this.id = id;
    }

    /**
     * 根据id查询
     *
     * @param
     * @return
     */
    public static JihuoUse find(int id) throws SQLException {
        JihuoUse sf = (JihuoUse) c.get(id);
        if (sf == null) {
            List<JihuoUse> list = find(" AND id = " + id, 0, 1);
            sf = list.size() < 1 ? new JihuoUse(id) : list.get(0);
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
    public static List<JihuoUse> find(String sql, int pos, int page_size) throws SQLException {
        List<JihuoUse> sfList = new ArrayList<JihuoUse>();
        DbAdapter db = new DbAdapter();
        String SQsql = "select id,codeid,orderid,productid,memberid,usetime from tb_jihuoUse where 1=1 " + sql;
        try {
            ResultSet rs = db.executeQuery(SQsql, pos, page_size);
            while (rs.next()) {
                int i = 1;
                JihuoUse sf = new JihuoUse(rs.getInt(i++));
                sf.setCodeid(rs.getInt(i++));
                sf.setOrderid(rs.getString(i++));
                sf.setProductid(rs.getInt(i++));
                sf.setMemberid(rs.getInt(i++));
                sf.setUsetime(rs.getDate(i++));
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
            sql = "INSERT INTO tb_jihuoUse(id,codeid,orderid,productid,memberid,usetime)VALUES(" + (id = Seq.get()) + ","+codeid+","+DbAdapter.cite(orderid)+","+productid+","+memberid+","+DbAdapter.cite(usetime)+")";
        } else {
            sql = "UPDATE tb_jihuoUse SET codeid=" + codeid+ ",orderid=" +DbAdapter.cite(orderid)+ ",productid=" +productid+ ",memberid=" +memberid+ ",usetime=" +DbAdapter.cite(new Date())+ " WHERE id=" + id;
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
        return DbAdapter.execute("SELECT COUNT(*) from tb_jihuoUse WHERE 1=1 " + sql);

    }


    public static int useCode(int productid,String orderid,int memberid,int type) throws SQLException {
        List<JihuoCode> list = JihuoCode.find("AND type_child="+type+" AND usetype= 0",0,Integer.MAX_VALUE);
        if(list.size()>0) {
            JihuoCode j = list.get(0);
            String code = j.getCode();
            j.setUsetype(1);
            j.set();
            JihuoUse jo = JihuoUse.find(0);
            jo.setMemberid(memberid);
            jo.setProductid(productid);
            jo.setCodeid(j.getId());
            jo.setOrderid(orderid);
            jo.setUsetime(new Date());
            jo.set();
            return 1;
        }else {
            return 0;
        }

    }
    public static void delete(String ids) {
        DbAdapter db = new DbAdapter();
        try {
            db.executeUpdate("DELETE FROM tb_jihuoUse WHERE id in(" + ids + ")");
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

    public String getOrderid() {
        return orderid;
    }

    public void setOrderid(String orderid) {
        this.orderid = orderid;
    }

    public int getProductid() {
        return productid;
    }

    public void setProductid(int productid) {
        this.productid = productid;
    }

    public int getMemberid() {
        return memberid;
    }

    public void setMemberid(int memberid) {
        this.memberid = memberid;
    }

    public Date getUsetime() {
        return usetime;
    }

    public void setUsetime(Date usetime) {
        this.usetime = usetime;
    }

    public static Cache getC() {
        return c;
    }

    public static void setC(Cache c) {
        JihuoUse.c = c;
    }

    public int getCodeid() {
        return codeid;
    }

    public void setCodeid(int codeid) {
        this.codeid = codeid;
    }
}
