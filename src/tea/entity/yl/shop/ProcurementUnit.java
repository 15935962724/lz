package tea.entity.yl.shop;

import tea.db.DbAdapter;
import tea.entity.*;
import tea.entity.member.SMSMessage;
import util.DateUtil;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import static tea.entity.yl.shop.ShopHospital.dqzjArr;

public class ProcurementUnit {

    protected static Cache c = new Cache(50);

    public int puid;
    public String name;  // 厂商名称
    public Date time;  // 创建时间
    public int img; // 厂商图标
    public int deleted;  // 是否删除 0:未删除,1:删除
    public int sort; // 排序字段
    public int isStopSupply ; //是否停止供货 0否  1 是
    public String fullname;//全称
    public String fullnameen;//英文全称
    public String mobile;//手机
    public String person;//联系人
    public String email;//邮箱
    public String zipcode;//邮编
    public String fax;//传真


    public String address;//地址
    public String telephone;//电话
    public String website;//网址
    public String telephoneReturn;//退货电话


    public Date radiationSafetyTime;//辐射安全许可证有效期
    public String radiationSafetyUrl;//辐射安全许可证文件路径

    public Date businessLicenseTime;//企业营业执照有效期
    public String businessLicenseUrl;//企业营业执照文件路径

    public Date productionLicenseTime;//放射药品生产许可证有效期
    public String productionLicenseUrl;//放射药品生产许可证文件路径

    public Date approvalFormTime;//转让审批表有效期
    public String approvalFormUrl;//转让审批表文件路径

    public Date gmpCertificateTime;//药品GMP证书有效期
    public String gmpCertificateUrl;//药品GMP证书文件路径

    public Date registrationApprovalTime;//药品再注册批件有效期
    public String registrationApprovalUrl;//药品再注册批件文件路径

    public Date powerOfAttorneyTime;//授权委托书有效期
    public String powerOfAttorneyUrl;//授权委托书文件路径

    public String manufactorMobile;   //厂商预留电话
    public String platformMobile ;   //平台预留电话

    public int status ; //审核 0待审核 1采购员审核 2采购负责人审核 3质量管理员审核 4质量负责人审核

    public String message; //审核描述

    public Date getRadiationSafetyTime() {
        return radiationSafetyTime;
    }

    public void setRadiationSafetyTime(Date radiationSafetyTime) {
        this.radiationSafetyTime = radiationSafetyTime;
    }

    public String getRadiationSafetyUrl() {
        return radiationSafetyUrl;
    }

    public void setRadiationSafetyUrl(String radiationSafetyUrl) {
        this.radiationSafetyUrl = radiationSafetyUrl;
    }

    public Date getBusinessLicenseTime() {
        return businessLicenseTime;
    }

    public void setBusinessLicenseTime(Date businessLicenseTime) {
        this.businessLicenseTime = businessLicenseTime;
    }

    public String getBusinessLicenseUrl() {
        return businessLicenseUrl;
    }

    public void setBusinessLicenseUrl(String businessLicenseUrl) {
        this.businessLicenseUrl = businessLicenseUrl;
    }

    public Date getProductionLicenseTime() {
        return productionLicenseTime;
    }

    public void setProductionLicenseTime(Date productionLicenseTime) {
        this.productionLicenseTime = productionLicenseTime;
    }

    public String getProductionLicenseUrl() {
        return productionLicenseUrl;
    }

    public void setProductionLicenseUrl(String productionLicenseUrl) {
        this.productionLicenseUrl = productionLicenseUrl;
    }

    public Date getApprovalFormTime() {
        return approvalFormTime;
    }

    public void setApprovalFormTime(Date approvalFormTime) {
        this.approvalFormTime = approvalFormTime;
    }

    public String getApprovalFormUrl() {
        return approvalFormUrl;
    }

    public void setApprovalFormUrl(String approvalFormUrl) {
        this.approvalFormUrl = approvalFormUrl;
    }

    public Date getGmpCertificateTime() {
        return gmpCertificateTime;
    }

    public void setGmpCertificateTime(Date gmpCertificateTime) {
        this.gmpCertificateTime = gmpCertificateTime;
    }

    public String getGmpCertificateUrl() {
        return gmpCertificateUrl;
    }

    public void setGmpCertificateUrl(String gmpCertificateUrl) {
        this.gmpCertificateUrl = gmpCertificateUrl;
    }

    public Date getRegistrationApprovalTime() {
        return registrationApprovalTime;
    }

    public void setRegistrationApprovalTime(Date registrationApprovalTime) {
        this.registrationApprovalTime = registrationApprovalTime;
    }

    public String getRegistrationApprovalUrl() {
        return registrationApprovalUrl;
    }

    public void setRegistrationApprovalUrl(String registrationApprovalUrl) {
        this.registrationApprovalUrl = registrationApprovalUrl;
    }

    public Date getPowerOfAttorneyTime() {
        return powerOfAttorneyTime;
    }

    public void setPowerOfAttorneyTime(Date powerOfAttorneyTime) {
        this.powerOfAttorneyTime = powerOfAttorneyTime;
    }

    public String getPowerOfAttorneyUrl() {
        return powerOfAttorneyUrl;
    }

    public void setPowerOfAttorneyUrl(String powerOfAttorneyUrl) {
        this.powerOfAttorneyUrl = powerOfAttorneyUrl;
    }

    public String getManufactorMobile() {
        return manufactorMobile;
    }

    public void setManufactorMobile(String manufactorMobile) {
        this.manufactorMobile = manufactorMobile;
    }

    public String getPlatformMobile() {
        return platformMobile;
    }

    public void setPlatformMobile(String platformMobile) {
        this.platformMobile = platformMobile;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public int getSort() {
        return sort;
    }

    public void setSort(int sort) {
        this.sort = sort;
    }

    public int getIsStopSupply() {
        return isStopSupply;
    }

    public void setIsStopSupply(int isStopSupply) {
        this.isStopSupply = isStopSupply;
    }

    public int getImg() {
        return img;
    }

    public void setImg(int img) {
        this.img = img;
    }

    public ProcurementUnit() {
    }

    public ProcurementUnit(int puid) {
        this.puid = puid;
    }

    public ProcurementUnit(int puid, String name, Date time, int img, int deleted,int sort) {
        this.puid = puid;
        this.name = name;
        this.time = time;
        this.img = img;
        this.deleted = deleted;
        this.sort = sort;
    }

    public static String findName(int puid) {
    	String name = "同辐";
    	if(puid!=0) {
    		ProcurementUnit pu = ProcurementUnit.find(puid);
    		name = pu.getName();
    	}
    	
        return name;
    }

    /**
     * 查询所有厂商
     * @param sql
     * @param pos
     * @param size
     * @return
     */
    public static List<ProcurementUnit> find(String sql, int pos, int size){
        List<ProcurementUnit> procurementUnitList = new ArrayList<ProcurementUnit>();
        DbAdapter db = new DbAdapter();
        String QSsql = "select puid,name,time,img,deleted,sort,fullname,fullnameen,mobile,person,email,zipcode,fax,address,telephone,website,telephoneReturn,radiationSafetyTime,radiationSafetyUrl,businessLicenseTime,businessLicenseUrl,productionLicenseTime,productionLicenseUrl,approvalFormTime,approvalFormUrl,gmpCertificateTime,gmpCertificateUrl,registrationApprovalTime,registrationApprovalUrl,powerOfAttorneyTime,powerOfAttorneyUrl,manufactorMobile,platformMobile,status,isStopSupply from procurementunit where 1=1" + sql + " and deleted = 0 order by sort asc";
        try {
            ResultSet rs = db.executeQuery(QSsql, pos, size);
            while (rs.next()){
                int i = 1;
                ProcurementUnit p = new ProcurementUnit(rs.getInt(i++));
                p.setName(rs.getString(i++));
                p.setTime(rs.getDate(i++));
                p.setImg(rs.getInt(i++));
                p.setDeleted(rs.getInt(i++));
                p.setSort(rs.getInt(i++));
                p.fullname = rs.getString(i++);
                p.fullnameen = rs.getString(i++);
                p.mobile = rs.getString(i++);
                p.person = rs.getString(i++);
                p.email = rs.getString(i++);
                p.zipcode = rs.getString(i++);
                p.fax = rs.getString(i++);
                p.address = rs.getString(i++);
                p.telephone = rs.getString(i++);
                p.website = rs.getString(i++);
                p.telephoneReturn = rs.getString(i++);
                p.radiationSafetyTime = rs.getDate(i++);
                p.radiationSafetyUrl = rs.getString(i++);
                p.businessLicenseTime = rs.getDate(i++);
                p.businessLicenseUrl = rs.getString(i++);
                p.productionLicenseTime = rs.getDate(i++);
                p.productionLicenseUrl = rs.getString(i++);
                p.approvalFormTime = rs.getDate(i++);
                p.approvalFormUrl = rs.getString(i++);
                p.gmpCertificateTime = rs.getDate(i++);
                p.gmpCertificateUrl = rs.getString(i++);
                p.registrationApprovalTime = rs.getDate(i++);
                p.registrationApprovalUrl = rs.getString(i++);
                p.powerOfAttorneyTime = rs.getDate(i++);
                p.powerOfAttorneyUrl = rs.getString(i++);
                p.manufactorMobile = rs.getString(i++);
                p.platformMobile = rs.getString(i++);
                p.status = rs.getInt(i++);
                p.isStopSupply = rs.getInt(i++);
                c.put(p.puid,p);
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

    /**
     * 查询厂商数量
     * @param sql
     * @return
     * @throws SQLException
     */
    public static int count(String sql) throws SQLException {
        return DbAdapter.execute("select count(0) from procurementunit where 1=1 " + sql + " and deleted=0");
    }

    /**
     * 添加or修改厂商信息
     * @throws SQLException
     */
    public void set() throws SQLException{
        String sql = "";
        if(this.puid < 1){
            sql = "insert into procurementunit(puid,name,time,img,deleted,sort,fullname,fullnameen,mobile,person,email,zipcode,fax,address,telephone,website,telephoneReturn,radiationSafetyTime ,radiationSafetyUrl ,businessLicenseTime ,businessLicenseUrl ,productionLicenseTime ,productionLicenseUrl ,approvalFormTime ,approvalFormUrl ,gmpCertificateTime ,gmpCertificateUrl ,registrationApprovalTime ,registrationApprovalUrl ,powerOfAttorneyTime ,powerOfAttorneyUrl ,manufactorMobile ,platformMobile ,isStopSupply,status)" +
                    " values(" + (this.puid = Seq.get()) + "," + DbAdapter.cite(this.name) + "," + DbAdapter.cite(this.time) + "," + this.img + "," + this.deleted +","+ this.sort + ","+Database.cite(fullname)+","+Database.cite(fullnameen)+","+Database.cite(mobile)+","+Database.cite(person)+","+Database.cite(email)+","+Database.cite(zipcode)+","+Database.cite(fax)+","+Database.cite(address)+","+Database.cite(telephone)+","+Database.cite(website)+","+Database.cite(telephoneReturn)+     ","+DbAdapter.cite(this.radiationSafetyTime)+
                    ","+DbAdapter.cite(this.radiationSafetyUrl)+
                    ","+DbAdapter.cite(this.businessLicenseTime)+
                    ","+DbAdapter.cite(this.businessLicenseUrl)+
                    ","+DbAdapter.cite(this.productionLicenseTime)+
                    ","+DbAdapter.cite(this.productionLicenseUrl)+
                    ","+DbAdapter.cite(this.approvalFormTime)+
                    ","+DbAdapter.cite(this.approvalFormUrl)+
                    ","+DbAdapter.cite(this.gmpCertificateTime)+
                    ","+DbAdapter.cite(this.gmpCertificateUrl)+
                    ","+DbAdapter.cite(this.registrationApprovalTime)+
                    ","+DbAdapter.cite(this.registrationApprovalUrl)+
                    ","+DbAdapter.cite(this.powerOfAttorneyTime)+
                    ","+DbAdapter.cite(this.powerOfAttorneyUrl)+
                    ","+DbAdapter.cite(this.manufactorMobile)+
                    ", "+DbAdapter.cite(this.platformMobile )+
                    ", "+this.isStopSupply+
                    ", "+this.status+ ")";
        }else{
            sql = "update procurementunit set name =" + DbAdapter.cite(this.name) +",img = " + this.img +  ",sort = "+ this.sort  + ",fullname="+Database.cite(fullname)+",fullnameen="+Database.cite(fullnameen)+",mobile="+Database.cite(mobile)+",person="+Database.cite(person)+",email="+Database.cite(email)+",zipcode="+Database.cite(zipcode)+",fax="+Database.cite(fax)+",address="+Database.cite(address)+",telephone="+Database.cite(telephone)+",website="+Database.cite(website)+",telephoneReturn="+Database.cite(telephoneReturn)+" where puid=" + this.puid;
        }
        DbAdapter db = new DbAdapter();
        try {
            db.executeUpdate(this.puid, sql);
        } catch (SQLException e) {
            e.printStackTrace();
        }finally{
            db.close();
        }
        c.remove(this.puid);
    }
    
    public void update() throws SQLException{
        String sql = "";
        sql = "update procurementunit set name =" + DbAdapter.cite(this.name) +",img = " + this.img +  ",sort = "+ this.sort  + ",fullname="+Database.cite(fullname)+",fullnameen="+Database.cite(fullnameen)+",mobile="+Database.cite(mobile)+",person="+Database.cite(person)+",email="+Database.cite(email)+",zipcode="+Database.cite(zipcode)+",fax="+Database.cite(fax)+",address="+Database.cite(address)+",telephone="+Database.cite(telephone)+",website="+Database.cite(website)+",telephoneReturn="+Database.cite(telephoneReturn)+"" +
                ",radiationSafetyTime= "+DbAdapter.cite(this.radiationSafetyTime)+
                ",radiationSafetyUrl= "+DbAdapter.cite(this.radiationSafetyUrl)+
                ",businessLicenseTime= "+DbAdapter.cite(this.businessLicenseTime)+
                ",businessLicenseUrl= "+DbAdapter.cite(this.businessLicenseUrl)+
                ",productionLicenseTime= "+DbAdapter.cite(this.productionLicenseTime)+
                ",productionLicenseUrl= "+DbAdapter.cite(this.productionLicenseUrl)+
                ",approvalFormTime= "+DbAdapter.cite(this.approvalFormTime)+
                ",approvalFormUrl= "+DbAdapter.cite(this.approvalFormUrl)+
                ",gmpCertificateTime= "+DbAdapter.cite(this.gmpCertificateTime)+
                ",gmpCertificateUrl= "+DbAdapter.cite(this.gmpCertificateUrl)+
                ",registrationApprovalTime= "+DbAdapter.cite(this.registrationApprovalTime)+
                ",registrationApprovalUrl= "+DbAdapter.cite(this.registrationApprovalUrl)+
                ",powerOfAttorneyTime= "+DbAdapter.cite(this.powerOfAttorneyTime)+
                ",powerOfAttorneyUrl= "+DbAdapter.cite(this.powerOfAttorneyUrl)+
                ",manufactorMobile= "+DbAdapter.cite(this.manufactorMobile)+
                ",platformMobile = "+DbAdapter.cite(this.platformMobile )+
                ",status = "+this.status+
                ",isStopSupply = "+this.isStopSupply+
                " where puid=" + this.puid;
        DbAdapter db = new DbAdapter();
        try {
            db.executeUpdate(sql);
        } catch (SQLException e) {
            e.printStackTrace();
        }finally{
            db.close();
        }
        c.remove(this.puid);
    }

    /**
     * 根据id查询
     * @param puid
     * @return
     */
    public static ProcurementUnit find(int puid){
        ProcurementUnit pu = (ProcurementUnit)c.get(puid);
        if(pu == null){
            ArrayList<ProcurementUnit> list = (ArrayList<ProcurementUnit>) find(" AND puid = " + puid, 0, 1);
            pu = list.size() < 1 ? new ProcurementUnit(puid):list.get(0);
        }
        return pu;
    }



    /**
     * 根据厂商id查询关联医院数量
     * @param puid
     * @return
     */
    public static int findPUCount(int puid){
        try {
            return DbAdapter.execute("select count(hid) from hospitals_join where puid=" + puid);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * 根据厂商id查询关联药品数量
     * @param puid
     * @return
     */
    public static int findDrug(int puid) {
        try {
            return DbAdapter.execute("select count(*) from shopproduct where puid =" + puid);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * 根据厂商id查询关联服务商数量
     * @param puid
     * @return
     */
    public static int findProCount(int puid){
        try {
            return DbAdapter.execute("select count(profile) from procurementunit_join where puid=" + puid);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * 根据id 删除(假删除)
     * @param puid
     */
    public static void delete(int puid){
        String name = ProcurementUnit.find(puid).getName();
        String tmp = name + "[于" + MT.f(new Date(),1) + "删除]";
        DbAdapter db = new DbAdapter();
        try {
            String sql = "UPDATE procurementUnit SET deleted=1,name=" + DbAdapter.cite(tmp) + " WHERE puid=" + puid;
            db.executeUpdate(puid,sql);
        } catch (SQLException e) {
            e.printStackTrace();
        }finally{
            db.close();
        }
        c.remove(puid);
    }

    /**
     * 添加关联医院
     * @param puid
     * @param hid
     */
    public static void AddJoinHosp(int puid,int hid){
        DbAdapter db = new DbAdapter();
        try {
            db.executeUpdate("insert into hospitals_join(puid,hid) values("+puid+","+hid+")");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            db.close();
        }
    }

    /**
     * 取消关联医院
     * @param puid
     * @param hid
     */
    public static void RemoveJoinHosp(int puid, int hid) {
        DbAdapter db = new DbAdapter();
        try {
            db.executeUpdate("delete hospitals_join where puid=" + puid + " and hid=" + hid);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            db.close();
        }
    }

    /**
     * 根据puid 查询 关联医院
     * @param puid
     * @return
     */
    public static List<Integer> JoinHosp(int puid){
        DbAdapter db = new DbAdapter();
        ArrayList<Integer> inds = new ArrayList<Integer>();
        try {
            db.executeQuery("select hid from hospitals_join where puid = " + puid);
            while (db.next()){
                int i = 1;
                //int puid1 = db.getInt(i++);
                int hid = db.getInt(i++);
                inds.add(hid);
            }
            return inds;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            db.close();
        }
        return null;
    }
    
    /**
     * 根据通过医院查厂商
     * @param hosid
     * @return
     */
    public static List<Integer> findHospJoin(int hosid){
        DbAdapter db = new DbAdapter();
        ArrayList<Integer> inds = new ArrayList<Integer>();
        try {
            db.executeQuery("select puid from hospitals_join where hid = " + hosid);
            while (db.next()){
                int i = 1;
                int puid1 = db.getInt(i++);
                inds.add(puid1);
            }
            return inds;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            db.close();
        }
        return null;
    }



    public static void SendMessage(){
        Date date = new Date();
        try {
            int day = 0;
            List<ProcurementUnit> procurementUnitList = ProcurementUnit.find("",0,Integer.MAX_VALUE);
            for (ProcurementUnit procurementUnit : procurementUnitList) {
                day = DateUtil.countTwoDate(procurementUnit.getRadiationSafetyTime());
                Filex.logs("procurementUnit.log","厂商名称:"+procurementUnit.getName()+",辐射安全许可证还有"+day+"天到期。");
                if (day<=30&&day%5==0){
                    //给厂商预留电话发短信
                    SMSMessage.sendExpireMessage("Home", "amdin", procurementUnit.getManufactorMobile(), 1, procurementUnit.getName() + "的辐射安全许可证还有"+day+"天到期。", 2);
                    //给平台预留电话发短信
                    SMSMessage.sendExpireMessage("Home", "amdin", procurementUnit.getPlatformMobile(), 1, procurementUnit.getName() + "的辐射安全许可证还有"+day+"天到期。", 2);
                }
                day = DateUtil.countTwoDate(procurementUnit.getBusinessLicenseTime());
                if (day<=30&&day%5==0){
                    Filex.logs("procurementUnit.log","厂商名称:"+procurementUnit.getName()+",企业营业执照还有"+day+"天到期。");
                    //给厂商预留电话发短信
                    SMSMessage.sendExpireMessage("Home", "amdin", procurementUnit.getManufactorMobile(), 1, procurementUnit.getName() + "的企业营业执照还有"+day+"天到期。", 2);
                    //给平台预留电话发短信
                    SMSMessage.sendExpireMessage("Home", "amdin", procurementUnit.getPlatformMobile(), 1, procurementUnit.getName() + "的企业营业执照还有"+day+"天到期。", 2);
                }
                day = DateUtil.countTwoDate(procurementUnit.getProductionLicenseTime());
                if (day<=30&&day%5==0){
                    //给厂商预留电话发短信
                    SMSMessage.sendExpireMessage("Home", "amdin", procurementUnit.getManufactorMobile(), 1, procurementUnit.getName() + "的放射药品生产许可证还有"+day+"天到期。", 2);
                    //给平台预留电话发短信
                    SMSMessage.sendExpireMessage("Home", "amdin", procurementUnit.getPlatformMobile(), 1, procurementUnit.getName() + "的放射药品生产许可证还有"+day+"天到期。", 2);
                }
                day = DateUtil.countTwoDate(procurementUnit.getApprovalFormTime());
                if (day<=30&&day%5==0){
                    //给厂商预留电话发短信
                    SMSMessage.sendExpireMessage("Home", "amdin", procurementUnit.getManufactorMobile(), 1, procurementUnit.getName() + "的转让审批表还有"+day+"天到期。", 2);
                    //给平台预留电话发短信
                    SMSMessage.sendExpireMessage("Home", "amdin", procurementUnit.getPlatformMobile(), 1, procurementUnit.getName() + "的转让审批表还有"+day+"天到期。", 2);
                }
                day = DateUtil.countTwoDate(procurementUnit.getGmpCertificateTime());
                if (day<=30&&day%5==0){
                    //给厂商预留电话发短信
                    SMSMessage.sendExpireMessage("Home", "amdin", procurementUnit.getManufactorMobile(), 1, procurementUnit.getName() + "的药品GMP证书还有"+day+"天到期。", 2);
                    //给平台预留电话发短信
                    SMSMessage.sendExpireMessage("Home", "amdin", procurementUnit.getPlatformMobile(), 1, procurementUnit.getName() + "的药品GMP证书还有"+day+"天到期。", 2);
                }
                day = DateUtil.countTwoDate(procurementUnit.getRegistrationApprovalTime());
                if (day<=30&&day%5==0){
                    //给厂商预留电话发短信
                    SMSMessage.sendExpireMessage("Home", "amdin", procurementUnit.getManufactorMobile(), 1, procurementUnit.getName() + "的药品再注册批件还有"+day+"天到期。", 2);
                    //给平台预留电话发短信
                    SMSMessage.sendExpireMessage("Home", "amdin", procurementUnit.getPlatformMobile(), 1, procurementUnit.getName() + "的药品再注册批件还有"+day+"天到期。", 2);
                }
                day = DateUtil.countTwoDate(procurementUnit.getPowerOfAttorneyTime());
                if (day<=30&&day%5==0){
                    //给厂商预留电话发短信
                    SMSMessage.sendExpireMessage("Home", "amdin", procurementUnit.getManufactorMobile(), 1, procurementUnit.getName() + "的授权委托书还有"+day+"天到期。", 2);
                    //给平台预留电话发短信
                    SMSMessage.sendExpireMessage("Home", "amdin", procurementUnit.getPlatformMobile(), 1, procurementUnit.getName() + "的授权委托书还有"+day+"天到期。", 2);
                }

            }
        } catch (SQLException e) {


        }


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

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public int getDeleted() {
        return deleted;
    }

    public void setDeleted(int deleted) {
        this.deleted = deleted;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getFullnameen() {
        return fullnameen;
    }

    public void setFullnameen(String fullnameen) {
        this.fullnameen = fullnameen;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getPerson() {
        return person;
    }

    public void setPerson(String person) {
        this.person = person;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getZipcode() {
        return zipcode;
    }

    public void setZipcode(String zipcode) {
        this.zipcode = zipcode;
    }

    public String getFax() {
        return fax;
    }

    public void setFax(String fax) {
        this.fax = fax;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public String getWebsite() {
        return website;
    }

    public void setWebsite(String website) {
        this.website = website;
    }

    public String getTelephoneReturn() {
        return telephoneReturn;
    }

    public void setTelephoneReturn(String telephoneReturn) {
        this.telephoneReturn = telephoneReturn;
    }


    public static boolean checkZZ(int puid) {
        Boolean after = true;
        ProcurementUnit procurementUnit = ProcurementUnit.find(puid);
        ArrayList<Date> list = new ArrayList<>();
        list.add(procurementUnit.getRadiationSafetyTime());
        list.add(procurementUnit.getBusinessLicenseTime());
        list.add(procurementUnit.getProductionLicenseTime());
        list.add(procurementUnit.getApprovalFormTime());
        list.add(procurementUnit.getRegistrationApprovalTime());
        list.add(procurementUnit.getPowerOfAttorneyTime());
        list.add(procurementUnit.getGmpCertificateTime());

        for (int i = 0; i < list.size(); i++) {
            Date date = list.get(i);
            if(date!=null){
                if(!date.after(new Date())){
                    return false;
                }

            }
        }
        return after;
    }
}
