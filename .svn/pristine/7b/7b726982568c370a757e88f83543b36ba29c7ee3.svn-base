package tea.entity.yl.shop;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Database;
import tea.entity.MT;
import tea.entity.Seq;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Certificates {

    protected static Cache c = new Cache(50);


    public int id;
    public int puid; //厂商id
    public String name;  // 资质名称
    public int type;//1.辐射安全许可证  2.企业营业执照   3.放射药品生产许可证   4.转让审批表   5.药品GMP证书  6.药品再注册批件  7.授权委托书.
    public String delayMessage;//延期申请原因
    public String delayUrl;//延期申请文件
    public int status;//审核状态 0待审核 1 审核通过  2审核不通过

    public Certificates() {

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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public String getDelayMessage() {
        return delayMessage;
    }

    public void setDelayMessage(String delayMessage) {
        this.delayMessage = delayMessage;
    }

    public String getDelayUrl() {
        return delayUrl;
    }

    public void setDelayUrl(String delayUrl) {
        this.delayUrl = delayUrl;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public Certificates(int puid) {
        this.puid = puid;
    }

    public void set() throws SQLException{
        String sql = "";
        if(this.id < 1){
            sql = "insert into certificates(puid,name,type,delayMessage,delayUrl,status) values("+
                      this.puid+
                    ","+DbAdapter.cite(this.name)+
                    ","+this.type+
                    ","+DbAdapter.cite(this.delayMessage)+
                    ","+DbAdapter.cite(this.delayUrl)+
                    ", "+this.status+ ")";
        }else{
            sql = "update certificates set puid = "+this.puid+" name =" + DbAdapter.cite(this.name) +",type = " + this.type +  ",delayMessage = "+ DbAdapter.cite(this.delayMessage)+ ",delayUrl="+Database.cite(delayUrl)+",status="+status+" where id=" + this.id;
        }
        DbAdapter db = new DbAdapter();
        try {
            db.executeUpdate(this.id, sql);
        } catch (SQLException e) {
            e.printStackTrace();
        }finally{
            db.close();
        }
        c.remove(this.id);
    }


    public void update(String sql) throws SQLException{
        String updateSql = "update certificates set status="+this.status+" where puid=" + this.puid +" and type = "+this.type;
        DbAdapter db = new DbAdapter();
        try {
            db.executeUpdate(updateSql);
        } catch (SQLException e) {
            e.printStackTrace();
        }finally{
            db.close();
        }
        c.remove(this.id);
    }




    public static Certificates find(int id){
        Certificates certificates = (Certificates)c.get(id);
        if(certificates == null){
            ArrayList<Certificates> list = (ArrayList<Certificates>) find(" AND id = " + id, 0, 1);
            certificates = list.size() < 1 ? new Certificates(id):list.get(0);
        }
        return certificates;
    }


    public static List<Certificates> find(String sql, int pos, int size){
        List<Certificates> procurementUnitList = new ArrayList<Certificates>();
        DbAdapter db = new DbAdapter();
        String QSsql = "select id,puid,name,delayMessage,delayUrl,type,status from certificates where 1=1" + sql;
        try {
            ResultSet rs = db.executeQuery(QSsql, pos, size);
            while (rs.next()){
                int i = 1;
                Certificates p = new Certificates(rs.getInt(i++));
                p.setPuid(rs.getInt(i++));
                p.setName(rs.getString(i++));
                p.setDelayMessage(rs.getString(i++));
                p.setDelayUrl(rs.getString(i++));
                p.setType(rs.getInt(i++));
                p.status = rs.getInt(i++);
                c.put(p.id,p);
                procurementUnitList.add(p);
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.close();
        }

        return procurementUnitList;
    }



}
