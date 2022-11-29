package tea.entity.lms;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

public class LmsWork
{
    protected static Cache _cache = new Cache(50);
    //public int id; //流水号
    public int orgid; //计划承担的工作
    public int isinschool = 1; //证书学籍管理
    public int isadmincourse = 1; //排课以及调课
    public int isonlinecourse = 1; //网上选课
    public int isregistration = 1; //报名管理
    public int isexnotice = 1; //准备准考证以及考试通知单发放
    public int isexamption = 1; //免考管理
    public int isteach = 1; //教材管理
    public int isthepaper = 1; //毕业论文管理
    public int isenglish = 1; //学位英语考试管
    public int iscertificate = 1; //证书办理
    public int isequipment = 1; //教学设备管理以及维护
    public int isclass = 1; //班级管理
    public int isstudy = 1; //督促学生学习
    public int ispractice = 1; //组织学生参加实践考核
    public int isteaching = 1; //教学效果考核
    public int issafety = 1; //安全管理
    public int isoperation = 1; //操作指导
    public int iscoach = 1; //课程辅导
    public int ispracticecoach = 1; //实践环节考核指导
    public int isinvoice = 1; //开具培训费发票

    public LmsWork(int orgid)
    {
        this.orgid = orgid;
    }

    public static LmsWork find(int orgid) throws SQLException
    {
        LmsWork t = (LmsWork) _cache.get(orgid);
        if(t == null)
        {
            ArrayList al = find(" AND orgid=" + orgid,0,1);
            t = al.size() < 1 ? new LmsWork(orgid) : (LmsWork) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT orgid,isinschool,isadmincourse,isonlinecourse,isregistration,isexnotice,isexamption,isteach,isthepaper,isenglish,iscertificate,isequipment,isclass,isstudy,ispractice,isteaching,issafety,isoperation,iscoach,ispracticecoach,isinvoice FROM lmswork WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                LmsWork t = new LmsWork(rs.getInt(i++));
                t.isinschool = rs.getInt(i++);
                t.isadmincourse = rs.getInt(i++);
                t.isonlinecourse = rs.getInt(i++);
                t.isregistration = rs.getInt(i++);
                t.isexnotice = rs.getInt(i++);
                t.isexamption = rs.getInt(i++);
                t.isteach = rs.getInt(i++);
                t.isthepaper = rs.getInt(i++);
                t.isenglish = rs.getInt(i++);
                t.iscertificate = rs.getInt(i++);
                t.isequipment = rs.getInt(i++);
                t.isclass = rs.getInt(i++);
                t.isstudy = rs.getInt(i++);
                t.ispractice = rs.getInt(i++);
                t.isteaching = rs.getInt(i++);
                t.issafety = rs.getInt(i++);
                t.isoperation = rs.getInt(i++);
                t.iscoach = rs.getInt(i++);
                t.ispracticecoach = rs.getInt(i++);
                t.isinvoice = rs.getInt(i++);
                _cache.put(t.orgid,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM lmswork WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int j = db.executeUpdate("INSERT INTO lmswork(orgid,isinschool,isadmincourse,isonlinecourse,isregistration,isexnotice,isexamption,isteach,isthepaper,isenglish,iscertificate,isequipment,isclass,isstudy,ispractice,isteaching,issafety,isoperation,iscoach,ispracticecoach,isinvoice)VALUES(" + orgid + "," + (isinschool) + "," + (isadmincourse) + "," + (isonlinecourse) + "," + (isregistration) + "," + (isexnotice) + "," + (isexamption) + "," + (isteach) + "," + (isthepaper) + "," + (isenglish) + "," + (iscertificate) + "," + (isequipment) + "," + (isclass) + "," + (isstudy) + "," + (ispractice) + "," + (isteaching) + "," + (issafety) + "," + (isoperation) + "," + (iscoach) + "," + (ispracticecoach) + "," + (isinvoice) + ")");
            if(j < 1)
                db.executeUpdate("UPDATE lmswork SET isinschool=" + (isinschool) + ",isadmincourse=" + (isadmincourse) + ",isonlinecourse=" + (isonlinecourse) + ",isregistration=" + (isregistration) + ",isexnotice=" + (isexnotice) + ",isexamption=" + (isexamption) + ",isteach=" + (isteach) + ",isthepaper=" + (isthepaper) + ",isenglish=" + (isenglish) + ",iscertificate=" + (iscertificate) + ",isequipment=" + (isequipment) + ",isclass=" + (isclass) + ",isstudy=" + (isstudy) + ",ispractice=" + (ispractice) + ",isteaching=" + (isteaching) + ",issafety=" + (issafety) + ",isoperation=" + (isoperation) + ",iscoach=" + (iscoach) + ",ispracticecoach=" + (ispracticecoach) + ",isinvoice=" + (isinvoice) + " WHERE orgid=" + orgid);
        } finally
        {
            db.close();
        }
        _cache.remove(orgid);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM lmswork WHERE orgid=" + orgid);
        _cache.remove(orgid);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE lmswork SET " + f + "=" + (v) + " WHERE orgid=" + orgid);
        _cache.remove(orgid);
    }
}
