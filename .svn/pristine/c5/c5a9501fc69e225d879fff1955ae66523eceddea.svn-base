package tea.entity.lms;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

//TM_ORG_TAB
public class LmsOrg
{
    protected static Cache _cache = new Cache(50);
    public int lmsorg;
    public int father;
    public int aspid;
    public int layer;
    public static String[] ORGTYPE_TYPE =
            {"--","省企业助学发展机构","省社会助学发展机构"};
    public static String[] ORGTYPE_TYPE0 =
            {"--","普通高校","高职高专","中职中专","非学历民办学校","社会培训机构","其它"};
    public int orgtype; //类型
    public String orgname; //省助学发展机构名称
    public static String[] ORGSTATUS_TYPE =
            {"禁用","可用"};
    @Deprecated
    public int orgstatus; //状态
    public String forguest;
    public String orgno; //编号
    public static String[] ISASP_TYPE =
            {"学习中心","省助学发展机构"};
    public int isasp; //分类
    public String description; //省助学发展机构简介
    public String province; //所在地区/省
    public int city; //所在地区/市
    public String county; //所在地区/县
    public String member; //授权省
    public String dnsname; //省助学发展机构网址
    public String fax; //传真 原:remark1
    public String email; //email,dnsname
    public int record; //自学考试助学机构备案
    public static String[] BRANCH_TYPE =
            {"--","低于10个","10-19个","20-49个","50个以上"};
    public int branch; //现有分支培训机构数量现有分支培训机构数量
    public String tel; //电话 原:remark5
    public Date startdate;
    public Date enddate;
    public String schoolid;
    public String logo;
    public Date regdate;
    public String ischeck;
    public String bxzj; //办学证件
    public String bxzjcode; //证件号码
    public Date establish; //省助学发展机构成立时间
    public Date sprxsj; //首批学生入学时间
    public String address; //通讯地址
    public String postcode; //邮编
    public float billprice;
    public String sjdepartment; //上级主管部门
    public String raddress; //注册地址
    public String rpostcode; //注册地址/邮编
    public static String[] STATE_TYPE =
            {"--","待审","通过","不通过","禁用"};
    public int state; //222
    public int fullnum; //全日制人数
    public int sparenum; //业余人数
    public float zdarea; //占地面积/平方米
    public float jzarea; //建筑面积/平方米
    public float jxxzarea; //教学行政用房/平方米
    public float fujzarea; //房屋建筑总面积/平方米
    public float averagejxarea; //人均/平方米
    public int booknum; //图书资料/册
    public int seatnum; //图书馆座位数/个
    public int averagebooknum; //人均/册
    public static String[] COMPUTER_NUM =
            {"--","50-79台","80-99台","100台以上"};
    public int computernum; //计算机/台
    public float averagecomputernum; //人均/台
    public float jxsbmoney; //教学仪器设备总值/万元
    public int pxtotal; //现有培训人数/合计
    public int teachernum; //教师人数
    public int managernum; //管理人员
    public int zgtotal;
    public int lan; //局域网速是否达到100m 原:remark11
    public int adsl; //宽带是否达到2m 原:remark12
    public int speed; //上网平均速率能否达到32k 原:remark13
    public int classroom1; //可容纳50人以下多少间 原:remark14
    public int classroom2; //可容纳五十人以上多少间 原:remark15
    public boolean specialized; //专科
    public boolean undergraduate; //本科
    public int specializednum; //专科数量
    public int undergraduatenum; //本科数量

    public LmsOrg(int lmsorg)
    {
        this.lmsorg = lmsorg;
    }

    public static LmsOrg find(int lmsorg) throws SQLException
    {
        LmsOrg t = (LmsOrg) _cache.get(lmsorg);
        if(t == null)
        {
            ArrayList al = find(" AND lmsorg=" + lmsorg,0,1);
            t = al.size() < 1 ? new LmsOrg(lmsorg) : (LmsOrg) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT lmsorg,father,aspid,layer,orgtype,orgname,orgstatus,forguest,orgno,isasp,description,province,city,county,member,dnsname,fax,email,record,branch,tel,startdate,enddate,schoolid,logo,regdate,ischeck,bxzj,bxzjcode,establish,sprxsj,address,postcode,billprice,sjdepartment,raddress,rpostcode,state,fullnum,sparenum,zdarea,jzarea,jxxzarea,fujzarea,averagejxarea,booknum,seatnum,averagebooknum,computernum,averagecomputernum,jxsbmoney,pxtotal,teachernum,managernum,zgtotal,lan,adsl,speed,classroom1,classroom2,specialized,undergraduate,specializednum,undergraduatenum FROM lmsorg WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                LmsOrg t = new LmsOrg(rs.getInt(i++));
                t.father = rs.getInt(i++);
                t.aspid = rs.getInt(i++);
                t.layer = rs.getInt(i++);
                t.orgtype = rs.getInt(i++);
                t.orgname = rs.getString(i++);
                t.orgstatus = rs.getInt(i++);
                t.forguest = rs.getString(i++);
                t.orgno = rs.getString(i++);
                t.isasp = rs.getInt(i++);
                t.description = rs.getString(i++);
                t.province = rs.getString(i++);
                t.city = rs.getInt(i++);
                t.county = rs.getString(i++);
                t.member = rs.getString(i++);
                t.dnsname = rs.getString(i++);
                t.fax = rs.getString(i++);
                t.email = rs.getString(i++);
                t.record = rs.getInt(i++);
                t.branch = rs.getInt(i++);
                t.tel = rs.getString(i++);
                t.startdate = db.getDate(i++);
                t.enddate = db.getDate(i++);
                t.schoolid = rs.getString(i++);
                t.logo = rs.getString(i++);
                t.regdate = db.getDate(i++);
                t.ischeck = rs.getString(i++);
                t.bxzj = rs.getString(i++);
                t.bxzjcode = rs.getString(i++);
                t.establish = db.getDate(i++);
                t.sprxsj = db.getDate(i++);
                t.address = rs.getString(i++);
                t.postcode = rs.getString(i++);
                t.billprice = rs.getFloat(i++);
                t.sjdepartment = rs.getString(i++);
                t.raddress = rs.getString(i++);
                t.rpostcode = rs.getString(i++);
                t.state = rs.getInt(i++);
                t.fullnum = rs.getInt(i++);
                t.sparenum = rs.getInt(i++);
                t.zdarea = rs.getFloat(i++);
                t.jzarea = rs.getFloat(i++);
                t.jxxzarea = rs.getFloat(i++);
                t.fujzarea = rs.getFloat(i++);
                t.averagejxarea = rs.getFloat(i++);
                t.booknum = rs.getInt(i++);
                t.seatnum = rs.getInt(i++);
                t.averagebooknum = rs.getInt(i++);
                t.computernum = rs.getInt(i++);
                t.averagecomputernum = rs.getFloat(i++);
                t.jxsbmoney = rs.getFloat(i++);
                t.pxtotal = rs.getInt(i++);
                t.teachernum = rs.getInt(i++);
                t.managernum = rs.getInt(i++);
                t.zgtotal = rs.getInt(i++);
                t.lan = rs.getInt(i++);
                t.adsl = rs.getInt(i++);
                t.speed = rs.getInt(i++);
                t.classroom1 = rs.getInt(i++);
                t.classroom2 = rs.getInt(i++);
                t.specialized = rs.getBoolean(i++);
                t.undergraduate = rs.getBoolean(i++);
                t.specializednum = rs.getInt(i++);
                t.undergraduatenum = rs.getInt(i++);
                _cache.put(t.lmsorg,t);
                al.add(t);
            }
            rs.close();
        } finally
        {
            db.close();
        }
        return al;
    }

    public static int count(String sql) throws SQLException
    {
        return DbAdapter.execute("SELECT COUNT(*) FROM lmsorg WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        String sql;
        if(lmsorg < 1)
            sql = "INSERT INTO lmsorg(lmsorg,father,aspid,layer,orgtype,orgname,orgstatus,forguest,orgno,isasp,description,province,city,county,member,dnsname,fax,email,record,branch,tel,startdate,enddate,schoolid,logo,regdate,ischeck,bxzj,bxzjcode,establish,sprxsj,address,postcode,billprice,sjdepartment,raddress,rpostcode,state,fullnum,sparenum,zdarea,jzarea,jxxzarea,fujzarea,averagejxarea,booknum,seatnum,averagebooknum,computernum,averagecomputernum,jxsbmoney,pxtotal,teachernum,managernum,zgtotal,lan,adsl,speed,classroom1,classroom2,specialized,undergraduate,specializednum,undergraduatenum)VALUES(" + (lmsorg = Seq.get()) + "," + father + "," + aspid + "," + layer + "," + orgtype + "," + DbAdapter.cite(orgname) + "," + orgstatus + "," + DbAdapter.cite(forguest) + "," +
                    DbAdapter.cite(orgno) +
                    "," + isasp + "," +
                    DbAdapter.cite(description) + "," + DbAdapter.cite(province) + "," + city + "," + DbAdapter.cite(county) + "," + DbAdapter.cite(member) + "," + DbAdapter.cite(dnsname) + "," + DbAdapter.cite(fax) + "," + DbAdapter.cite(email) + "," + record + "," + branch + "," + DbAdapter.cite(tel) + "," + DbAdapter.cite(startdate) + "," + DbAdapter.cite(enddate) + "," + DbAdapter.cite(schoolid) + "," + DbAdapter.cite(logo) + "," + DbAdapter.cite(regdate) + "," + DbAdapter.cite(ischeck) + "," + DbAdapter.cite(bxzj) + "," + DbAdapter.cite(bxzjcode) + "," + DbAdapter.cite(establish) + "," + DbAdapter.cite(sprxsj) + "," + DbAdapter.cite(address) + "," + DbAdapter.cite(postcode) + "," + billprice + "," + DbAdapter.cite(sjdepartment) + "," + DbAdapter.cite(raddress) + "," +
                    DbAdapter.cite(rpostcode) + "," + state + "," +
                    fullnum + "," + sparenum + "," + zdarea + "," + jzarea + "," + jxxzarea + "," + fujzarea + "," + averagejxarea + "," + booknum + "," + seatnum + "," + averagebooknum + "," + computernum + "," + averagecomputernum + "," +
                    jxsbmoney + "," + pxtotal + "," + teachernum + "," + managernum + "," + zgtotal + "," + lan + "," + adsl + "," + speed + "," + classroom1 + "," + classroom2 + "," + DbAdapter.cite(specialized) + "," + DbAdapter.cite(undergraduate) + "," + specializednum + "," + undergraduatenum + ")";
        else
            sql = "UPDATE lmsorg SET father=" + father + ",aspid=" + aspid + ",layer=" + layer + ",orgtype=" + orgtype + ",orgname=" + DbAdapter.cite(orgname) + ",orgstatus=" + orgstatus + ",forguest=" + DbAdapter.cite(forguest) + ",orgno=" + DbAdapter.cite(orgno) + ",isasp=" + isasp + ",description=" + DbAdapter.cite(description) + ",province=" + DbAdapter.cite(province) + ",city=" + city + ",county=" + DbAdapter.cite(county) + ",member=" + DbAdapter.cite(member) + ",dnsname=" + DbAdapter.cite(dnsname) + ",fax=" + DbAdapter.cite(fax) + ",email=" + DbAdapter.cite(email) + ",record=" + record + ",branch=" + branch + ",tel=" + DbAdapter.cite(tel) + ",startdate=" + DbAdapter.cite(startdate) + ",enddate=" + DbAdapter.cite(enddate) +
                  ",schoolid=" + DbAdapter.cite(schoolid) + ",logo=" + DbAdapter.cite(logo) + ",regdate=" + DbAdapter.cite(regdate) + ",ischeck=" + DbAdapter.cite(ischeck) + ",bxzj=" + DbAdapter.cite(bxzj) + ",bxzjcode=" + DbAdapter.cite(bxzjcode) + ",establish="
                  + DbAdapter.cite(establish) + ",sprxsj=" + DbAdapter.cite(sprxsj) + ",address=" + DbAdapter.cite(address) + ",postcode=" + DbAdapter.cite(postcode) + ",billprice=" + billprice + ",sjdepartment=" + DbAdapter.cite(sjdepartment) + ",raddress=" + DbAdapter.cite(raddress) + ",rpostcode=" + DbAdapter.cite(rpostcode) + ",state=" + state + ",fullnum=" + fullnum + ",sparenum=" + sparenum + ",zdarea=" + zdarea + ",jzarea=" + jzarea + ",jxxzarea=" + jxxzarea + ",fujzarea=" + fujzarea + ",averagejxarea=" + averagejxarea + ",booknum=" + booknum + ",seatnum=" + seatnum + ",averagebooknum=" + averagebooknum + ",computernum=" + computernum + ",averagecomputernum=" + averagecomputernum + ",jxsbmoney=" + jxsbmoney + ",pxtotal=" + pxtotal + ",teachernum=" + teachernum + ",managernum=" +
                  managernum + ",zgtotal=" + zgtotal +
                  ",lan=" + lan + ",adsl=" + adsl + ",speed=" + speed + ",classroom1=" + classroom1 + ",classroom2=" + classroom2 + ",specialized=" + DbAdapter.cite(specialized) + ",undergraduate=" + DbAdapter.cite(undergraduate) + ",specializednum=" + specializednum + ",undergraduatenum=" + undergraduatenum + " WHERE lmsorg=" + lmsorg;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(sql);
        } finally
        {
            db.close();
        }
        _cache.remove(lmsorg);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM lmsorg WHERE lmsorg=" + lmsorg);
        _cache.remove(lmsorg);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE lmsorg SET " + f + "=" + DbAdapter.cite(v) + " WHERE lmsorg=" + lmsorg);
        _cache.remove(lmsorg);
    }

    //
    public static String options(String sql,int dv) throws SQLException
    {
        StringBuilder htm = new StringBuilder();
        ArrayList al = find(sql,0,Integer.MAX_VALUE);
        for(int i = 0;i < al.size();i++)
        {
            LmsOrg t = (LmsOrg) al.get(i);
            htm.append("<option value=" + t.lmsorg);
            if(dv == t.lmsorg)
                htm.append(" selected");
            htm.append(">" + t.orgname);
        }
        return htm.toString();
    }

    public String toString()
    {
        StringBuilder sb = new StringBuilder();
        sb.append("{id:" + lmsorg);
        sb.append(",orgname:" + Attch.cite(orgname));
        sb.append("}");
        return sb.toString();
    }
}
