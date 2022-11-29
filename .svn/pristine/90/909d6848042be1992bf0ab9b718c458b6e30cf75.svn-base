package tea.entity.yl.shop;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Seq;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 服务商授权申请
 */
public class EmpowerRecord {
    protected static Cache c = new Cache(50);
    private int eid;            // id
    private int upid;           // 用户升级记录id
    private int hospital;       // 医院id
    private Date stateTime;     // 授权有效期开始时间
    private Date endTime;       // 授权有效期截止时间
    private int profile;        // 服务商id
    private String client;      // 委托人
    private int state;          // 授权状态 0:申请 1:成功 2:失败
    private int perfect;        // 资料完善审核,审核通过后给医院下单 0: 未提交医院资质   1,提交医院资质未审核  2,提交医院资质审核通过  3,提交医院资质审核不通过
    private String describe;    // 描述
    private Date radiation;     // 辐射安全许可证正本的截止日期
    private int credentials;    // 6种证件

    private Date empowerTime;   // 申请时间
    private Date examineTime;   // 审核时间

    private int clientID;       // 委托人身份证复印件
    private int radiationCard;  // 辐射安全许可证
    private Date raditaionStart; // 辐射安全许可证正本的开始日期
    private int radiate;        // 放射诊疗许可证
    private int empower;        // 授权申请书
    private int radiateCard;    // 放射性药品使用许可证

    private int turnApproval;   // 转入/转出审批表
    private int signFor;        // 粒子/发票签收人
    private int certificate;    // 已盖章授权书,供用户下载
    private int contract;       // 购销合同
    private String company_mail;  //快递公司
    private String number_mail;   //快递单号

    public EmpowerRecord() {
    }

    public EmpowerRecord(int eid) {
        this.eid = eid;
    }

    /**
     * 分页查询所有
     * @param sql
     * @param pos
     * @param size
     * @return
     */
    public static List<EmpowerRecord> find(String sql,int pos,int size){
        ArrayList<EmpowerRecord> list = new ArrayList<EmpowerRecord>();
        DbAdapter db = new DbAdapter();
        String SQsql = "select eid,upid,hospital,stateTime,endTime,profile,client,state,describe,radiation,credentials,empowerTime,examineTime,perfect,clientID,radiationCard,radiate,empower,radiateCard,raditaionStart,turnApproval,signFor,certificate,contract,company_mail,number_mail from empowerRecord where 1=1 " + sql;
        try {
            ResultSet rs = db.executeQuery(SQsql, pos, size);
            while (rs.next()){
                int i = 1;
                EmpowerRecord er = new EmpowerRecord(rs.getInt(i++));
                er.setUpid(rs.getInt(i++));
                er.setHospital(rs.getInt(i++));
                er.setStateTime(rs.getDate(i++));
                er.setEndTime(rs.getDate(i++));
                er.setProfile(rs.getInt(i++));
                er.setClient(rs.getString(i++));
                er.setState(rs.getInt(i++));
                er.setDescribe(rs.getString(i++));
                er.setRadiation(rs.getDate(i++));
                er.setCredentials(rs.getInt(i++));
                er.setEmpowerTime(rs.getDate(i++));
                er.setExamineTime(rs.getDate(i++));
                er.setPerfect(rs.getInt(i++));
                er.setClientID(rs.getInt(i++));
                er.setRadiationCard(rs.getInt(i++));
                er.setRadiate(rs.getInt(i++));
                er.setEmpower(rs.getInt(i++));
                er.setRadiateCard(rs.getInt(i++));
                er.setRaditaionStart(rs.getDate(i++));
                er.setTurnApproval(rs.getInt(i++));
                er.setSignFor(rs.getInt(i++));
                er.setCertificate(rs.getInt(i++));
                er.setContract(rs.getInt(i++));
                er.setCompany_mail(rs.getString(i++));
                er.setNumber_mail(rs.getString(i++));
                c.put(er.eid,er);
                list.add(er);
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.close();
        }
        return list;
    }

    /**
     * 根据id查询
     * @param eid
     * @return
     */
    public static EmpowerRecord find(Integer eid){
        EmpowerRecord er = (EmpowerRecord) c.get(eid);
        if(er == null){
            ArrayList<EmpowerRecord> list = (ArrayList<EmpowerRecord>) find(" and eid=" + eid, 0, 1);
            er = list.size() < 1 ? new EmpowerRecord(eid) : list.get(0);
        }
        return er;
    }

    /**
     * 添加 || 修改
     */
    public void set() throws SQLException {
        String sql = "";
        if(this.eid<1){
            sql = "insert into empowerRecord(eid,upid,hospital,stateTime,endTime,profile,client,state,describe,radiation,credentials,empowerTime,examineTime,perfect,clientID,radiationCard,radiate,empower,radiateCard,raditaionStart,turnApproval,signFor,certificate,contract,company_mail,number_mail) values("+
                    (this.eid = Seq.get()) + "," +
                    this.upid + "," +
                    this.hospital + "," +
                    DbAdapter.cite(this.stateTime) + "," +
                    DbAdapter.cite(this.endTime) + "," +
                    this.profile + "," +
                    DbAdapter.cite(this.client) + "," +
                    this.state + "," +
                    DbAdapter.cite(this.describe) + "," +
                    DbAdapter.cite(this.radiation) + "," +
                    this.credentials + "," +
                    DbAdapter.cite(this.empowerTime) + "," +
                    DbAdapter.cite(this.examineTime) + "," +
                    this.perfect + "," +
                    this.clientID + "," +
                    this.radiationCard + "," +
                    this.radiate + "," +
                    this.empower + "," +
                    this.radiateCard + "," +
                    DbAdapter.cite(this.raditaionStart) + "," +
                    this.turnApproval + "," +
                    this.signFor + "," +
                    this.certificate +"," +
                    this.contract+","+
                    DbAdapter.cite(this.company_mail)+","+
                    DbAdapter.cite(this.number_mail)
                    +")";
        }else{
            sql = "update empowerRecord set upid="+this.upid+",hospital="+this.hospital+",stateTime="+DbAdapter.cite(this.stateTime)
            +",endTime="+DbAdapter.cite(this.endTime)+",profile="+this.profile+",client="+DbAdapter.cite(this.client)+",state="+this.state
            +",describe="+DbAdapter.cite(this.describe)+",radiation="+DbAdapter.cite(this.radiation)+",credentials="+this.credentials
            +",empowerTime="+DbAdapter.cite(this.empowerTime)+",examineTime="+DbAdapter.cite(this.examineTime)+",perfect="+this.perfect
            +",clientID="+this.clientID+",radiationCard="+this.radiationCard+",radiate="+this.radiate+",empower="+this.empower
            +",radiateCard="+this.radiateCard+",raditaionStart="+DbAdapter.cite(this.raditaionStart)
            +",turnApproval="+this.turnApproval+",signFor="+this.signFor+",certificate="+this.certificate+",contract="+this.contract+",company_mail="+DbAdapter.cite(this.company_mail)+",number_mail="+DbAdapter.cite(this.number_mail)+" where eid="+this.eid;
        }
        DbAdapter db = new DbAdapter();
        try {
            db.executeUpdate(this.eid,sql);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.close();
        }
        c.remove(this.eid);
    }

    /**
     * 查询数量
     * @param sql
     * @return
     */
    public static int count(String sql) throws SQLException {
        return DbAdapter.execute("select count(0) from empowerRecord where 1=1" + sql);
    }

    /*
    * 删除
    * */
    public static void delete(String ids) {
        DbAdapter db = new DbAdapter();
        try {
            db.executeUpdate("DELETE FROM empowerRecord WHERE eid in(" + ids + ")");
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

    public int getEid() {
        return eid;
    }

    public void setEid(int eid) {
        this.eid = eid;
    }

    public int getUpid() {
        return upid;
    }

    public void setUpid(int upid) {
        this.upid = upid;
    }

    public int getHospital() {
        return hospital;
    }

    public void setHospital(int hospital) {
        this.hospital = hospital;
    }

    public Date getStateTime() {
        return stateTime;
    }

    public void setStateTime(Date stateTime) {
        this.stateTime = stateTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public int getProfile() {
        return profile;
    }

    public void setProfile(int profile) {
        this.profile = profile;
    }

    public String getClient() {
        return client;
    }

    public void setClient(String client) {
        this.client = client;
    }

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }

    public String getDescribe() {
        return describe;
    }

    public void setDescribe(String describe) {
        this.describe = describe;
    }

    public Date getRadiation() {
        return radiation;
    }

    public void setRadiation(Date radiation) {
        this.radiation = radiation;
    }

    public int getCredentials() {
        return credentials;
    }

    public void setCredentials(int credentials) {
        this.credentials = credentials;
    }

    public Date getEmpowerTime() {
        return empowerTime;
    }

    public void setEmpowerTime(Date empowerTime) {
        this.empowerTime = empowerTime;
    }

    public Date getExamineTime() {
        return examineTime;
    }

    public void setExamineTime(Date examineTime) {
        this.examineTime = examineTime;
    }

    public int getPerfect() {
        return perfect;
    }

    public void setPerfect(int perfect) {
        this.perfect = perfect;
    }

    public int getClientID() {
        return clientID;
    }

    public void setClientID(int clientID) {
        this.clientID = clientID;
    }

    public int getRadiationCard() {
        return radiationCard;
    }

    public void setRadiationCard(int radiationCard) {
        this.radiationCard = radiationCard;
    }

    public Date getRaditaionStart() {
        return raditaionStart;
    }

    public void setRaditaionStart(Date raditaionStart) {
        this.raditaionStart = raditaionStart;
    }

    public int getRadiate() {
        return radiate;
    }

    public void setRadiate(int radiate) {
        this.radiate = radiate;
    }

    public int getEmpower() {
        return empower;
    }

    public void setEmpower(int empower) {
        this.empower = empower;
    }

    public int getRadiateCard() {
        return radiateCard;
    }

    public void setRadiateCard(int radiateCard) {
        this.radiateCard = radiateCard;
    }

    public int getTurnApproval() {
        return turnApproval;
    }

    public void setTurnApproval(int turnApproval) {
        this.turnApproval = turnApproval;
    }

    public int getSignFor() {
        return signFor;
    }

    public void setSignFor(int signFor) {
        this.signFor = signFor;
    }

    public int getCertificate() {
        return certificate;
    }

    public void setCertificate(int certificate) {
        this.certificate = certificate;
    }

    public int getContract() {
        return contract;
    }

    public void setContract(int contract) {
        this.contract = contract;
    }

    public String getCompany_mail() {
        return company_mail;
    }

    public void setCompany_mail(String company_mail) {
        this.company_mail = company_mail;
    }

    public String getNumber_mail() {
        return number_mail;
    }

    public void setNumber_mail(String number_mail) {
        this.number_mail = number_mail;
    }
}
