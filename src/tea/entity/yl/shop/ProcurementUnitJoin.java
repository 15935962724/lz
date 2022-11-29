package tea.entity.yl.shop;

import tea.db.DbAdapter;
import tea.entity.Database;
import tea.entity.Seq;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 商场关联代理表
 *
 * @author
 */
public class ProcurementUnitJoin {


    public int jid;
    public int puid;//厂商
    public int profile;//关联用户id
    public String company;//服务商公司名称
    public int tax;//进项税返还政策
    public int formula;//服务费公式
    public Date time;//

    public int model;//规格
    public float agentPriceNew;//底价

    public int invoicePuid;//开票单位

    public String hoid;//医院id

    public String crmid;//服务商公司CRMid   服务商档案id


    public static String[] TAXxinke = {"", "返还增值税专用发票（6%）", "返还增值税专用发票（6%）抵扣部分的50%", "返还增值税专用发票（3%）", "返还增值税专用发票（3%）抵扣部分的50%"};
    public static String[] FORMULAxinke = {"", "（单价-120）*0.984*（开票金额/单价）/1.16", "（单价-120）*0.9808*（开票金额/单价）/1.16", "（单价-底价）*0.9844*（开票金额/单价）/1.13"};

    public static String[] TAXgaoke = {"", "返还增值税专用发票（6%）", "返还增值税专用发票（3%）"};
    public static String[] FORMULAgaoke = {"", "（单价-120）*0.984*（开票金额/单价）/1.16", "（单价-120）*0.9808*（开票金额/单价）/1.16"};


    public static double [] gs1 = {0,0.984,0.9808,0.9844};
    public static double [] gs2 = {0,1.16,1.16,1.13};

    public ProcurementUnitJoin(int jid) {
        this.jid = jid;
    }

    public static ProcurementUnitJoin find(int puid, int profile) {
        ProcurementUnitJoin aShopPackage = null;
        if (aShopPackage == null) {
            ArrayList<ProcurementUnitJoin> list = find(" AND puid = " + puid + " AND profile = " + profile, 0, 1);
            aShopPackage = list.size() < 1 ? new ProcurementUnitJoin(0) : list.get(0);
        }
        return aShopPackage;
    }


    public static ProcurementUnitJoin find(int puid, int profile, int hosid) {
        ProcurementUnitJoin aShopPackage = null;
        try {
            if (aShopPackage == null) {
                int count = count(" AND puid = " + puid + " AND profile = " + profile);
                if (count > 1) {
                    ArrayList<ProcurementUnitJoin> list = find(" AND puid = " + puid + " AND profile = " + profile + " AND hoid like " + Database.cite("%," + hosid + "%"), 0, 1);
                    aShopPackage = list.size() < 1 ? new ProcurementUnitJoin(0) : list.get(0);
                } else {
                    ArrayList<ProcurementUnitJoin> list = find(" AND puid = " + puid + " AND profile = " + profile, 0, 1);
                    aShopPackage = list.size() < 1 ? new ProcurementUnitJoin(0) : list.get(0);

                }
            }
        } catch (Throwable e) {

        }
        return aShopPackage;
    }

    public static ProcurementUnitJoin find(int puid, int profile, int hosid,int model) {
        ProcurementUnitJoin aShopPackage = null;
        try {
            if (aShopPackage == null) {
                int count = count(" AND puid = " + puid + " AND profile = " + profile);
                if (count > 1) {
                    ArrayList<ProcurementUnitJoin> list = find(" AND puid = " + puid + " AND profile = " + profile + "  AND model = " + model + "  AND hoid like " + Database.cite("%," + hosid + "%"), 0, 1);
                    aShopPackage = list.size() < 1 ? new ProcurementUnitJoin(0) : list.get(0);
                } else {
                    ArrayList<ProcurementUnitJoin> list = find(" AND puid = " + puid + " AND profile = " + profile, 0, 1);
                    aShopPackage = list.size() < 1 ? new ProcurementUnitJoin(0) : list.get(0);

                }
            }
        } catch (Throwable e) {

        }
        return aShopPackage;
    }

    public static ProcurementUnitJoin find(int id) {
        ProcurementUnitJoin aShopPackage = null;
        if (aShopPackage == null) {
            ArrayList<ProcurementUnitJoin> list = find(" AND jid = " + id, 0, 1);
            aShopPackage = list.size() < 1 ? new ProcurementUnitJoin(id) : list.get(0);
        }
        return aShopPackage;
    }

    public static ArrayList<ProcurementUnitJoin> find(String sql, int pos, int size) {
        ArrayList<ProcurementUnitJoin> list = new ArrayList<ProcurementUnitJoin>();
        DbAdapter db = new DbAdapter();
        String QSql = "select jid,puid,profile,company,tax,formula,time,agentPriceNew,model,invoicePuid,hoid,crmid from procurementunit_join  " + tab(sql) + " where 1=1 " + sql;
        try {
            ResultSet rs = db.executeQuery(QSql, pos, size);
            while (rs.next()) {
                int i = 1;
                ProcurementUnitJoin sa = new ProcurementUnitJoin(rs.getInt(i++));
                sa.puid = db.getInt(i++);
                sa.profile = db.getInt(i++);
                sa.company = db.getString(i++);
                sa.tax = db.getInt(i++);
                sa.formula = db.getInt(i++);
                sa.time = db.getDate(i++);
                sa.agentPriceNew = db.getFloat(i++);
                sa.model = db.getInt(i++);
                sa.invoicePuid = db.getInt(i++);
                sa.hoid = db.getString(i++);
                sa.crmid = db.getString(i++);
                list.add(sa);
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.close();
        }
        return list;
    }

    public static ArrayList<String> model(int puid) {
        DbAdapter db = new DbAdapter();
        String QSql = "select SM.model from ShopProduct_Model SM left join shopproduct SP on SM.id = SP.model_id " +
                "where Sp.puid = '"+puid+"' AND SP.state in (0,1)  AND SP.category in (select category from shopcategory where path like '%14102669%') ";
        ArrayList<String> list = new ArrayList<String>();
        try {
            ResultSet rs = db.executeQuery(QSql, 0, Integer.MAX_VALUE);
            while (rs.next()) {
                list.add(rs.getString(1));
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.close();
        }
        return list;
    }

    public static String options(int puid ,int model) {
        DbAdapter db = new DbAdapter();
        String QSql = "select SM.id, SM.model from ShopProduct_Model SM left join shopproduct SP on SM.id = SP.model_id " +
                "where Sp.puid = '"+puid+"' AND SP.state in (0,1)  AND SP.category in (select category from shopcategory where path like '%14102669%') ";
        StringBuffer stringBuffer = new StringBuffer();
        stringBuffer.append("<option value='' >----------</option>");
        try {
            ResultSet rs = db.executeQuery(QSql, 0, Integer.MAX_VALUE);
            while (rs.next()) {
                String selected = "";
                if (rs.getInt(1)==model){
                    selected = "selected";
                }
                stringBuffer.append("<option value='"+rs.getString(1)+"' "+selected+" >"+rs.getString(2)+"</option>");
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.close();
        }
        return stringBuffer.toString();
    }

    public static int count(String sql) throws SQLException {
        return DbAdapter.execute("select count(0) from procurementunit_join sa " + tab(sql) + " where 1=1 " + sql);
    }

    public void set() throws SQLException {
        String sql = "";
        if (this.jid < 1) {
            this.jid = Seq.get();
            sql = "insert into procurementunit_join(jid,puid,profile,company,tax,formula,time,model, agentPriceNew,invoicePuid,hoid,crmid) values(" + jid + "," + puid + "," + profile + "," + Database.cite(company) + "," + tax + "," + formula + "," + Database.cite(time) + "," + agentPriceNew + "," + model + "," + invoicePuid + "," + Database.cite(hoid) + ","+Database.cite(crmid)+")";
        } else {
            sql = "update procurementunit_join set puid=" + puid + ",profile=" + profile + ",company=" + Database.cite(company) + ",tax=" + tax + ",formula=" + formula + ",time=" + Database.cite(time) + ",agentPriceNew=" + agentPriceNew + ",model=" + model + ",invoicePuid=" + invoicePuid + ",hoid=" + Database.cite(hoid) + ",crmid="+Database.cite(crmid)+" where jid=" + this.jid;
        }
        DbAdapter db = new DbAdapter();
        try {
            db.executeUpdate(this.jid, sql);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.close();
        }
    }

    public void delete() {
        DbAdapter db = new DbAdapter();
        try {
            db.executeUpdate(this.jid, "delete from procurementunit_join where jid= " + this.jid);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.close();
        }
    }

    public void set(String column, String value) {
        DbAdapter db = new DbAdapter();
        try {
            db.executeUpdate(this.jid, "update procurementunit_join set " + column + "=" + DbAdapter.cite(value) + " where jid=" + this.jid);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.close();
        }
    }

    private static String tab(String sql) {
        StringBuilder sb = new StringBuilder();
        if (sql.contains(" AND m."))
            sb.append(" INNER JOIN Profile m ON m.profile=sa.member");
        return sb.toString();
    }

    public static ProcurementUnitJoin findFwsName(int puid, String h_id) {
        List<ProcurementUnitJoin> p = ProcurementUnitJoin.find("AND puid=" + puid + "AND hoid like '%" +h_id+"%'", 0, Integer.MAX_VALUE);
        ProcurementUnitJoin pu = p.get(0);

        return pu;
    }

    public int getJid() {
        return jid;
    }

    public void setJid(int jid) {
        this.jid = jid;
    }

    public int getPuid() {
        return puid;
    }

    public void setPuid(int puid) {
        this.puid = puid;
    }

    public int getProfile() {
        return profile;
    }

    public void setProfile(int profile) {
        this.profile = profile;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public int getTax() {
        return tax;
    }

    public void setTax(int tax) {
        this.tax = tax;
    }

    public int getFormula() {
        return formula;
    }

    public void setFormula(int formula) {
        this.formula = formula;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public int getModel() {
        return model;
    }

    public void setModel(int model) {
        this.model = model;
    }

    public float getAgentPriceNew() {
        return agentPriceNew;
    }

    public void setAgentPriceNew(float agentPriceNew) {
        this.agentPriceNew = agentPriceNew;
    }

    public int getInvoicePuid() {
        return invoicePuid;
    }

    public void setInvoicePuid(int invoicePuid) {
        this.invoicePuid = invoicePuid;
    }

    public String getHoid() {
        return hoid;
    }

    public void setHoid(String hoid) {
        this.hoid = hoid;
    }

    public String getCrmid() {
        return crmid;
    }

    public void setCrmid(String crmid) {
        this.crmid = crmid;
    }
}
