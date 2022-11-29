package tea.entity.admin;

import java.sql.*;
import java.util.*;
import java.io.*;
import tea.resource.*;
import java.util.Date;
import tea.resource.*;
import tea.db.*;
import tea.entity.*;
import tea.entity.member.*;
import tea.entity.netdisk.*;
import tea.entity.node.*;
import tea.entity.site.*;

//工作事务
public class Flowbusiness extends Entity
{
    //xny
    public static final String[] HEAD_TYPE =
            {"",
            "<div style='font-size:18.0pt;font-family:黑体;mso-hansi-font-family:宋体;layout-grid-mode:line;margin-top:20px;'>中国水电建设集团新能源开发有限责任公司发文处理笺</div>",
            "<div style='font-size:18.0pt;font-family:黑体;mso-hansi-font-family:宋体;layout-grid-mode:line;margin-top:20px;'>中国水电建设集团瓜州风电有限公司发文处理笺</div>",
            "<div style='font-size:18.0pt;font-family:黑体;mso-hansi-font-family:宋体;layout-grid-mode:line;margin-top:20px;line-height:150%;'>中国水电建设集团新能源开发有限公司<br/>内蒙风电分公司发文处理笺</div>",
            "<div style='font-size:18.0pt;font-family:黑体;mso-hansi-font-family:宋体;layout-grid-mode:line;margin-top:20px;'>中国水电建设集团新能源开发有限公司长岭风电分公司发文处理笺</div>",
            "贵州桐梓河水电开发有限责任公司文稿纸",
            "瓜州风电有限公司董事会发文处理笺","","","","","","","","","","","","","",
            "<div class='stylesize lineheight'>中国水电建设集团新能源开发有限责任<br/>公司收文处理签</div>",
            "<div class='stylesize lineheight'>中国水电建设集团新能源开发有限责任<br/>公司长岭风电分公司收文处理签</div>",
            "<div class='stylesize lineheight'>中国水电建设集团瓜州风电有限公司<br/>收文处理签</div>",
            "<div class='stylesize lineheight'>中国水电建设集团新能源开发有限公司<br/>内蒙风电分公司<br/>收文处理签</div>"};
    private static Cache _cache = new Cache(100);
    private int flowbusiness;
    private String community;
    private int flowitem;
    private int flow;
    //Flowview.step序号，做加1操作, 此处是Flowprocess.step的号
    private int step; //-1:临时,还没保存 0:事务已完成
    public int nextstep; //下一步,同上  多人转下一步时，保存住第一人，转向的步骤
    private Date ftime;
    private String creator; //发起人
    private String exclusives; //独占///
    private int prev; //前一个事务
    private int nextflow; //下一个流程
    //private int flowview;
    private String csunit; //会签候选部门
    private String csmember; //会签候选人员
    public String reason; //不符合上报要求 写明回退原因
    private int adminunitorg; //是否下属公司
    private int filecenter; //文件的归档
    private int prints; //打印份数
    public int head;
    public String name;
    public String tape1; //红头文件
    public String tape2; // 无印章
    public String content; //Word文件内容
    private boolean exists;

    public Flowbusiness(int flowbusiness) throws SQLException
    {
        this.flowbusiness = flowbusiness;
        load();
    }

    public static Flowbusiness find(int flowbusiness) throws SQLException
    {
        Flowbusiness obj = (Flowbusiness) _cache.get(new Integer(flowbusiness));
        if(obj == null)
        {
            obj = new Flowbusiness(flowbusiness);
            _cache.put(new Integer(flowbusiness),obj);
        }
        return obj;
    }

    public static Enumeration findByCommunity(String community,String sql) throws SQLException
    {
        return findByCommunity(community,sql,0,200);
    }

    public static Enumeration findByCommunity(String community,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT fb.flowbusiness FROM Flowbusiness fb WHERE fb.community=" + DbAdapter.cite(community) + sql,pos,size);
            while(db.next())
            {
                v.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static int countByCommunity(String community,String sql) throws SQLException
    {
        return DbAdapter.execute("SELECT COUNT(fb.flowbusiness) FROM Flowbusiness fb WHERE fb.community=" + DbAdapter.cite(community) + sql);
    }

    public static int countByCommunity_fb(String community,String sql) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(fb.flowbusiness) FROM Flowbusiness fb WHERE fb.community=" + DbAdapter.cite(community) + sql);
            if(db.next())
            {
                count = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return count;
    }


//    //判断用户，所在的部门是否属于"下属公司"
//    public static boolean isSubor(String community,String member) throws SQLException
//    {
//        AdminUnit au = AdminUnit.find(177); //武邵总承包部
//        StringBuilder sql = new StringBuilder();
//        sql.append(" AND id=").append(AdminUsrRole.find(community,member).getUnit()).append(" AND(1=0");
//        Enumeration e = AdminUnit.findByCommunity(community," AND father=" + au.getFather() + " AND sequence>=" + au.getSequence());
//        while(e.hasMoreElements())
//        {
//            AdminUnit obj = (AdminUnit) e.nextElement();
//            int auid = obj.getId();
//            sql.append(" OR path LIKE ").append(DbAdapter.cite("%/" + auid + "/%"));
//        }
//        sql.append(")");
//        return AdminUnit.findByCommunity(community,sql.toString()).hasMoreElements();
//    }

    public static Enumeration find(int flowitem,String sql) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT fb.flowbusiness FROM Flowbusiness fb WHERE fb.flowitem=" + flowitem + sql);
            while(db.next())
            {
                v.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Flowbusiness WHERE flowbusiness=" + flowbusiness);
            db.executeUpdate("DELETE FROM Flowview WHERE flowbusiness=" + flowbusiness); // 流程图
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(flowbusiness));
    }

    public void set(int flowitem,Date ftime,int language,String name,String content) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Flowbusiness SET flowitem=" + flowitem + ",ftime =" + db.cite(ftime) + " WHERE flowbusiness=" + flowbusiness);
            int j = db.executeUpdate("UPDATE FlowbusinessLayer SET name=" + DbAdapter.cite(name) + ",content=" + DbAdapter.cite(content) + " WHERE flowbusiness=" + flowbusiness + " AND language=" + language);
            if(j < 1)
            {
                db.executeUpdate("INSERT INTO FlowbusinessLayer(flowbusiness,language,name,content)VALUES(" + flowbusiness + "," + language + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(content) + ")");
            }
        } finally
        {
            db.close();
        }
        this.flowitem = flowitem;
        this.ftime = ftime;
    }

    private void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE Flowbusiness SET " + f + "=" + DbAdapter.cite(v) + " WHERE flowbusiness=" + flowbusiness);
    }

    public void setReason(String reason) throws SQLException
    {
        set("reason",reason);
        this.reason = reason;
    }

    public void setHead(int head) throws SQLException
    {
        set("head",String.valueOf(head));
        this.head = head;
    }

    public void setPrints(int prints) throws SQLException
    {
        DbAdapter.execute("UPDATE Flowbusiness SET prints=" + prints + " WHERE flowbusiness=" + flowbusiness);
        this.prints = prints;
    }

    public void setCSign(String csunit,String csmember) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Flowbusiness SET csunit=" + DbAdapter.cite(csunit) + ",csmember=" + DbAdapter.cite(csmember) + " WHERE flowbusiness=" + flowbusiness);
        } finally
        {
            db.close();
        }
        this.csunit = csunit;
        this.csmember = csmember;
    }

    public void setName(String name) throws SQLException
    {
        set("name",name);
        this.name = name;
    }

    public void setContent(String content) throws SQLException
    {
        set("content",content);
        this.content = content;
    }

    public void setTape1(String tape1) throws SQLException
    {
        set("tape1",tape1);
        this.tape1 = tape1;
    }

    public void setTape2(String tape2) throws SQLException
    {
        set("tape2",tape2);
        this.tape2 = tape2;
    }

    public static synchronized int create(String community,int flow,String member) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Flowbusiness(community,flowitem,flow,prev,ftime,step,csunit,csmember,adminunitorg,name)VALUES(" +
                             DbAdapter.cite(community) + ",0," + flow + ",0," + db.cite(new Date()) + ",-1,'/','/',0,'')");
            return db.getInt("SELECT MAX(flowbusiness) FROM Flowbusiness WHERE flow=" + flow);
        } finally
        {
            db.close();
        }
    }

    public static int create(String community,int flowitem,int flow,int prev,Date ftime,int adminunitorg,String member,String name) throws SQLException
    {
        int flowbusiness = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Flowbusiness(community,flowitem,flow,prev,ftime,step,csunit,csmember,adminunitorg,name) VALUES (" + DbAdapter.cite(community) + "," + flowitem + "," + flow + "," + prev + "," + db.cite(ftime) + ",1,'/','/'," + adminunitorg + "," + DbAdapter.cite(name) + ")");
            flowbusiness = db.getInt("SELECT MAX(flowbusiness) FROM Flowbusiness WHERE flow=" + flow);
        } finally
        {
            db.close();
        }
        if(prev > 0)
        {
            find(prev).setNextflow(0);
        }
        Flowview.create(flowbusiness,Flowprocess.find(flow,1).getFlowprocess(),member,new String[]
                        {member},1,0);
        return flowbusiness;
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT community,flowitem,flow,prev,ftime,step,nextstep,exclusives,nextflow,csunit,csmember,reason,adminunitorg,filecenter,prints,head,name,tape1,tape2 FROM Flowbusiness WHERE flowbusiness=" + flowbusiness);
            if(db.next())
            {
                int j = 1;
                community = db.getString(j++);
                flowitem = db.getInt(j++);
                flow = db.getInt(j++);
                prev = db.getInt(j++);
                ftime = db.getDate(j++);
                step = db.getInt(j++);
                nextstep = db.getInt(j++);
                exclusives = db.getString(j++);
                nextflow = db.getInt(j++);
                csunit = db.getString(j++);
                csmember = db.getString(j++);
                reason = db.getString(j++);
                adminunitorg = db.getInt(j++);
                filecenter = db.getInt(j++);
                prints = db.getInt(j++);
                head = db.getInt(j++);
                name = db.getString(j++);
                tape1 = db.getString(j++);
                tape2 = db.getString(j++);
                //flowview = db.getInt("SELECT MAX(flowview) FROM Flowview WHERE flowbusiness=" + flowbusiness + " AND step!=" + step);
                exists = true;
            } else
            {
                exists = false;
            }
        } finally
        {
            db.close();
        }
    }

    public int getFlowbusiness()
    {
        return flowbusiness;
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getFlow()
    {
        return flow;
    }

    public int getFlowitem()
    {
        return flowitem;
    }

    public Date getFtime()
    {
        return ftime;
    }

    public int getStep()
    {
        return step;
    }

    public String getStepToString(int lang) throws SQLException
    {
        String str = "第" + step + "步";
        if(step > 0)
        {
            if(Flow.find(flow).getType() != 1) //如果不是自由流程才显示，步骤名
            {
                str = str + ":" + Flowprocess.find(flow,step).getName(lang);
            }
        } else
        {
            str = "已结束";
        }
        return str;
    }

    public String getFtimeToString()
    {
        return sdf.format(ftime);
    }

    public void setStep(int step) throws SQLException
    {
        this.step = step;
        this.nextstep = 0;
        DbAdapter.execute("UPDATE Flowbusiness SET step=" + step + ",nextstep=" + nextstep + " WHERE flowbusiness=" + flowbusiness);
    }

    public void setNextStep(int nextstep) throws SQLException
    {
        this.nextstep = nextstep;
        set("nextstep",String.valueOf(nextstep));
    }

    public void setExclusive(String exclusives) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Flowbusiness SET exclusives=" + DbAdapter.cite(exclusives) + " WHERE flowbusiness=" + flowbusiness);
        } finally
        {
            db.close();
        }
        this.exclusives = exclusives;
    }

    private void setNextflow(int nextflow) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Flowbusiness SET nextflow=" + nextflow + " WHERE flowbusiness=" + flowbusiness);
        } finally
        {
            db.close();
        }
        this.nextflow = nextflow;
    }

    public void setFileCenter(int filecenter) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Flowbusiness SET filecenter=" + filecenter + " WHERE flowbusiness=" + flowbusiness);
        } finally
        {
            db.close();
        }
        this.filecenter = filecenter;
    }

    public void stop(int nf) throws SQLException
    {
        setStep(0);
        if(nf > 0)
        {
            setNextflow(nf);
        }
    }

    //回上一步//ms0:删除当前步的待办记录,ms1:更新上一步的状态
    public void back(String member,String ms0[],String ms1[]) throws SQLException
    {
        int l0 = 0,l1 = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT flowview,flowprocess,transactor FROM Flowview WHERE flowbusiness=" + flowbusiness + " ORDER BY flowview DESC");
            while(db.next())
            {
                int fv = db.getInt(1);
                int fp = db.getInt(2);
                String t = db.getString(3);
                if(l0 == 0 || l0 == fp) //最后一步,删除待办记录
                {
                    l0 = fp;
                    for(int i = 0;ms0 == null || i < ms0.length;i++)
                    {
                        if(ms0 == null || ms0[i].equals(t))
                        {
                            Flowview.delete(fv);
                            break;
                        } else if(i == ms0.length - 1) //如果没有全部删除,就不更新状态
                        {
                            l1 = -1;
                        }
                    }
                } else if(l1 == 0 || l1 == fp) //倒数第二步,更新状态
                {
                    l0 = -1;
                    l1 = fp;
                    step = Flowprocess.find(fp).getStep();
                    for(int i = 0;ms1 == null || i < ms1.length;i++) //如果ms为空,就回所有人
                    {
                        if(ms1 == null || ms1[i].equals(t))
                        {
                            Flowview.find(fv).setState(1);
                            break;
                        }
                    }
                } else
                {
                    break;
                }
            }
            //step = db.getInt("SELECT step FROM Flowview WHERE flowview=( SELECT MAX(flowview) FROM Flowview WHERE flowbusiness=" + flowbusiness + " )");//最后一步
        } finally
        {
            db.close();
        }
        if(l1 == -1)
        {
            next(member); //如果剩余的全部是"已完成"则转下一步
        } else
        {
            setStep(step); //全部收回,转上一步
        }
    }

    public int getNextStep() throws SQLException
    {
        int next = step + 1;
        Flowprocess fp = Flowprocess.find(flow,step);
        Flow f = Flow.find(flow);
        if(f.getType() == 2 && !fp.isSerial() && getMainTransactor() != null) //如果是"可控流程" && !不回主控步 && 已经走过了"主控步骤".则:转到"主控步骤";
        {
            fp = Flowprocess.find(f.getMainProcess());
            if(fp.isExists()) //主控步必须存在
                next = fp.getStep();
        }
        return next;
    }

    public boolean next(String member) throws SQLException
    {
        Flowprocess fp = Flowprocess.find(flow,step);
        int flowprocess = fp.getFlowprocess();
        DbAdapter db = new DbAdapter();
        try
        {
            //如果所有的会员都"传下一步"了,则传下一步.
            int flowview = db.getInt("SELECT MAX(flowview) FROM Flowview WHERE flowbusiness=" + flowbusiness + " AND flowprocess!=0 AND flowprocess!=" + flowprocess);
            db.executeQuery("SELECT flowbusiness FROM Flowview WHERE flowview>" + flowview + " AND flowbusiness=" + flowbusiness + " AND flowprocess=" + flowprocess + " AND state<2");
            if(!db.next())
            {
                int next1 = nextstep;
                Enumeration e = Flowview.find(flowbusiness," AND flowprocess=0");
                if(e.hasMoreElements())
                {
                    if(next1 < 1) //此处小于1,两种情况:1.历史义留 2.见back方法 3.EditFlowbusinessNext.jsp
                        next1 = getNextStep();
                    //待办人
                    db.executeUpdate("UPDATE Flowview SET flowprocess=" + Flowprocess.find(flow,next1).getFlowprocess() + " WHERE flowbusiness=" + flowbusiness + " AND flowprocess=0");
                } else //没有待办人(CEC中的阅毕)，回最后一步(归档)
                {
                    Flowprocess fp1 = Flowprocess.find(flow, -1);
                    String tmember = fp1.getMember().split("/")[1];
                    Flowview.create(flowbusiness,fp1.getFlowprocess(),member,new String[]
                                    {tmember},0,0);
                    next1 = fp1.getStep();
                }
                //事务改下一步
                setStep(next1);
                return true;
            }
        } finally
        {
            db.close();
        }
        return false;
    }

    //传下一步////////当前会员,下一步待办人
    public boolean next(String member,String nextmember[],int nextstep) throws SQLException
    {
        //改为已办
        int fp = Flowprocess.find(flow,step).getFlowprocess();
        Flowview fv = Flowview.find(flowbusiness,fp,member);
        fv.setState(2);
        //设置下一步
        if(this.nextstep < 1)
            setNextStep(nextstep);
        //添加下一步待办人/////
        Flowview.create(flowbusiness,0,member,nextmember,0,0);
        return next(member);
    }

    //传下一步//强制跳转
    public void next(String member,String nextmember[],int flowprocess,int sumprint) throws SQLException
    {
        //改为已办
        int fp = Flowprocess.find(flow,step).getFlowprocess();
        Flowview fv = Flowview.find(flowbusiness,fp,member);
        fv.setState(2);
        //添加下一步待办人/////
        Flowview.create(flowbusiness,flowprocess,member,nextmember,0,sumprint);
        setStep(Flowprocess.find(flowprocess).getStep());
    }

    public void send(String type) throws SQLException
    {
        //发送消息/////
        String url = "/jsp/admin/" + type + "/FlowbusinessEdit.jsp?community=" + community + "&flowbusiness=" + flowbusiness + "&flow=" + flow + "&nexturl=" + Http.enc("/jsp/admin/" + type + "/Flowbusiness.jsp?community=" + community);
        Flowprocess fp = Flowprocess.find(flow,step);
        StringBuffer sb = new StringBuffer();
        sb.append("<a href='" + url + "' target='m' onclick='opener=null;window.close();'>点这里进行办理</a>");
        //发送站内短信息
        StringBuffer mes = new StringBuffer("/");
        Enumeration efv = Flowview.find(flowbusiness,fp.getFlowprocess());
        while(efv.hasMoreElements())
        {
            Flowview fv = Flowview.find(((Integer) efv.nextElement()).intValue());
            mes.append(fv.getTransactor()).append("/");
            //Message.create(community,5,fv.previous,fv.getTransactor(),"/","/",0,url,1,"您有《" + name + "》工作需要办理！",sb.toString());
            Message t = new Message(0);
            t.community = community;
            t.content = sb.toString();
            t.tmember = fv.previous;
            t.subject = "您有《" + name + "》工作需要办理！";
            t.set();
        }
        //Message.create(community,5,member,mes.toString(),"/","/",0,url,1,"您有《" + name + "》工作需要办理！",sb.toString());
    }


//  public void setNextmember(String nextmember) throws SQLException
//  {
//    DbAdapter db = new DbAdapter();
//    try
//    {
//      db.executeUpdate("UPDATE Flowbusiness SET nextmember=" + DbAdapter.cite(nextmember) + " WHERE flowbusiness=" + flowbusiness);
//    } finally
//    {
//      db.close();
//    }
//    this.nextmember = nextmember;
//  }

    public String getCommunity()
    {
        return community;
    }

    public String getCreator() throws SQLException
    {
        if(creator == null)
        {
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT transactor FROM Flowview WHERE flowbusiness=" + flowbusiness + " ORDER BY flowview",0,1);
                if(db.next())
                {
                    creator = db.getString(1);
                }
            } finally
            {
                db.close();
            }
        }
        return creator;
    }

    public String getExclusive()
    {
        return exclusives;
    }

    public int getPrev()
    {
        return prev;
    }

    public int getNextflow()
    {
        return nextflow;
    }

    public int getPrints()
    {
        return prints;
    }

    //发文登记中的正文，无印章版
    public String getTape2() throws SQLException
    {
        return MT.f(tape2,"/res/" + community + "/flow/nor_" + flowbusiness + ".doc");
    }

    public int getAdminUnitOrg()
    {
        return adminunitorg;
    }

    public void setAdminUnitOrg(int adminunitorg) throws SQLException
    {
        set("adminunitorg",String.valueOf(adminunitorg));
        this.adminunitorg = adminunitorg;
    }

    public int getFileCenter()
    {
        return filecenter;
    }

    //文件归档
    public void archiving(String member,int filecenter,Http h) throws SQLException
    {
        Flow f = Flow.find(flow);
        Dynamic d = Dynamic.find(f.getDynamic());
        String dsubject = f.getName(h.language);
        //流程归档////
        int bindfc = d.getBindfc("subject");
        if(bindfc > 0)
        {
            dsubject = DynamicValue.find( -flowbusiness,h.language,bindfc).getValue();
        }
        String code = "";
        bindfc = d.getBindfc("code");
        if(bindfc > 0)
        {
            code = DynamicValue.find( -flowbusiness,h.language,bindfc).getValue();
        }
        Date make = new Date();
        bindfc = d.getBindfc("make");
        if(bindfc > 0)
        {
            String str = DynamicValue.find( -flowbusiness,h.language,bindfc).getValue();
            try
            {
                make = DynamicValue.sdf.parse(str);
            } catch(Exception ex)
            {}
        }
        String unit = "";
        bindfc = d.getBindfc("unit");
        if(bindfc > 0)
        {
            unit = DynamicValue.find( -flowbusiness,h.language,bindfc).getValue();
        } else
        { //事务发起人所在的部门
            int uid = AdminUsrRole.find(h.community,creator).getUnit();
            AdminUnit au;
            if(uid > 0 && (au = AdminUnit.find(uid)).isExists())
            {
                unit = au.getName();
                FileCenterUnit.create(h.community,unit);
            }
        }
        String content = "";
        bindfc = d.getBindfc("content");
        if(bindfc > 0)
        {
            content = DynamicValue.find( -flowbusiness,h.language,bindfc).getValue();
        }
        //int filecenter = Integer.parseInt(request.getParameter("filecenter")); //f.getFilecenter();
        if(filecenter > 0 && FileCenter.find(filecenter).isExists())
        {
            int fc = FileCenter.create(community,filecenter,true,member,true,MT.f(dsubject,"--"),code,true,make,MT.f(unit),"",content);
            Enumeration e = DynamicType.findByDynamic(f.getDynamic()," AND type IN('office','file')",0,200); //在线office生成的文件归档
            while(e.hasMoreElements())
            {
                int dtid = ((Integer) e.nextElement()).intValue();
                DynamicType dt = DynamicType.find(dtid);
                DynamicValue dv = DynamicValue.find( -flowbusiness,h.language,dtid);
                String path = dv.getValue();
                if("file".equals(dt.getType()) && dt.isMulti())
                {
                    Enumeration efile = dv.findMulti("",0,Integer.MAX_VALUE);
                    while(efile.hasMoreElements())
                    {
                        DynamicValue.Multi dvm = (DynamicValue.Multi) efile.nextElement();
                        path = dvm.getValue();
                        String name = path.substring(path.lastIndexOf('/') + 1);
                        String ex = name.substring(name.lastIndexOf('.') + 1);
                        FileCenterAttach.create(fc,dvm.getMember(),name,ex,path);
                    }
                } else if(path != null && path.length() > 0 && path.indexOf(':') == -1) //“:”多个模板
                {
                    if("office".equals(dt.getType())) //正文，归档，不带印章
                    {
                        path = this.getTape2();
                    }
                    String ex = path.substring(path.lastIndexOf('.') + 1);
                    FileCenterAttach.create(fc,member,dt.getName(h.language) + "." + ex,ex,path);
                }
            }
            //会签单需要与发文文件一并保存成为word文档，放置于文件中心指定文件夹下，以附件的形式。
            try
            {
                String path = "/res/" + d.getCommunity() + "/flow/exp_" + flowbusiness + ".doc";
                Filex.write(Common.REAL_PATH + path,h.read("/jsp/admin/flow/FlowbusinessView.jsp?community=" + d.getCommunity() + "&flowbusiness=" + flowbusiness + "&dynamic=" + f.getDynamic()));
                FileCenterAttach.create(fc,member,"文件稿纸.doc","doc",path);
            } catch(Exception ex)
            {
                ex.printStackTrace();
            }
            setFileCenter(fc);
        }
        //动态类归档////
        Enumeration e = DynamicType.findByDynamic(f.getDynamic()," AND filecenter>0",0,Integer.MAX_VALUE);
        while(e.hasMoreElements())
        {
            int dtid = ((Integer) e.nextElement()).intValue();
            DynamicValue dv = DynamicValue.find( -flowbusiness,h.language,dtid);
            DynamicType dt = DynamicType.find(dtid);
            String path = dv.getValue();
            if((path != null && path.length() > 0) || dt.isMulti()) //上传了附件 || 附件可以上传多个
            {
                filecenter = dt.getFilecenter();
                if(!dt.isSync() || !FileCenterAttach.isExists(filecenter,path)) //非同步||没有归档
                {
                    int fc = FileCenter.create(community,filecenter,true,member,true,dsubject,code,true,make,unit,"",content);
                    if(dt.isMulti())
                    {
                        Enumeration e2 = dv.findMulti("",0,Integer.MAX_VALUE);
                        while(e2.hasMoreElements())
                        {
                            DynamicValue.Multi m = (DynamicValue.Multi) e2.nextElement();
                            path = m.getValue();
                            String name = path.substring(path.lastIndexOf('/') + 1);
                            String ex = name.substring(name.lastIndexOf('.') + 1);
                            FileCenterAttach.create(fc,m.getMember(),name,ex,path);
                        }
                    } else
                    {
                        String ex = path.substring(path.lastIndexOf('.') + 1);
                        FileCenterAttach.create(fc,member,dt.getName(h.language) + "." + ex,ex,path);
                    }
                }
            }
        }
    }

    public String getCSUnit()
    {
        return csunit;
    }

    public String getCSMember()
    {
        return csmember;
    }

    //  public int getPrevFb()
//  {
//    return nextfb;
//  }
//
//  public int getNextFb()
//  {
//    return nextfb;
//  }

    public String getCode() throws SQLException
    {
        int code = 0;
        switch(Flow.find(flow).getDynamic())
        {
        case 1026:
            code = 19;
            break;
        case 1027:
            code = 51;
            break;
        case 1031:
            code = 86;
            break;
        case 1032:
            code = 0;
            break;
        case 1033:
            code = 116;
            break;
        case 1034:
            code = 158;
            break;
        case 1055:
            code = 570;
            break;
        case 1056:
            code = 607;
            break;
        }
        return MT.f(DynamicValue.find( -flowbusiness,1,code).getValue());
    }

    //是否走过主控步骤//
    public boolean isRunMain() throws SQLException
    {
        boolean run = false;
        Flow f = Flow.find(flow);
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(*) FROM Flowview WHERE flowbusiness=" + flowbusiness + " AND flowprocess=" + f.getMainProcess());
            if(db.next())
            {
                run = db.getInt(1) > 1;
            }
        } finally
        {
            db.close();
        }
        return run;
    }

    //主控步骤经办人委托代办的人
    public String getMainConsign() throws SQLException
    {
        String mainconsign = null;
        Flow f = Flow.find(flow);
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT consign FROM Flowview WHERE flowbusiness=" + flowbusiness + " AND flowprocess=" + f.getMainProcess() + " ORDER BY flowview DESC");
            if(db.next())
            {
                mainconsign = db.getString(1);
            }
        } finally
        {
            db.close();
        }
        return mainconsign;
    }

    //主控步骤被指定得经办人
    public String getMainTransactor() throws SQLException
    {
        String maintransactor = null;
        Flow f = Flow.find(flow);
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT transactor FROM Flowview WHERE flowbusiness=" + flowbusiness + " AND flowprocess=" + f.getMainProcess() + " ORDER BY flowview DESC");
            if(db.next())
            {
                maintransactor = db.getString(1);
            }
        } finally
        {
            db.close();
        }
        return maintransactor;
    }

    public String getStopbuttonToHtml(int language) throws SQLException
    {
        StringBuffer sb = new StringBuffer();
        sb.append("<input type='button' value='结束流程' onclick=f_submit('stop')>");
        Enumeration e = Flow.find(community," AND prev=" + flow);
        while(e.hasMoreElements())
        {
            int flow = ((Integer) e.nextElement()).intValue();
            Flow f = Flow.find(flow);
            sb.append("<input type=button value=启动" + f.getName(language) + " onclick=f_submit('stop'," + flow + ")>");
        }
        return sb.toString();
    }

    public String getFlowviewToHtml(int language) throws SQLException
    {
        Flow f = Flow.find(flow);
        StringBuffer sb = new StringBuffer();
        sb.append("<table border=0 cellpadding=0 cellspacing=0 id=tablecenter>");
        sb.append("<tr class=TableHeader>");
        sb.append("  <td nowrap align=center> 步骤号 </td>");
        sb.append("  <td nowrap align=center> 步骤名称 </td>");
        sb.append("  <td nowrap> 经办人、办理状态、办理时间 </td>");
        sb.append("</tr>");
        sb.append("<tr class=TableLine2>");
        sb.append("  <td nowrap align=center colspan=3>    开始 <br>      ↓</td>");
        sb.append("</tr>");
        if(f.getType() != 2) //自由流程||固定流程
        {
            Enumeration enumer = Flowprocess.find(flow,"");
            for(int index = 1;enumer.hasMoreElements();index++)
            {
                int flowprocess = ((Integer) enumer.nextElement()).intValue();
                Flowprocess fp = Flowprocess.find(flowprocess);
                sb.append("<tr class=TableLine1>");
                sb.append("<td>第 " + index + " 步</td><td>").append(fp.getName(language));
                if(step == fp.getStep())
                {
                    sb.append("(当前步骤)");
                } else
                if(step + 1 == fp.getStep())
                {
                    sb.append("(下一步骤)");
                }
                sb.append("</td><td nowrap>");

                Enumeration e2 = Flowview.find(flowbusiness," AND flowprocess=" + fp.getFlowprocess());
                while(e2.hasMoreElements())
                {
                    int flowview = ((Integer) e2.nextElement()).intValue();
                    Flowview fv = Flowview.find(flowview);
                    Profile p = Profile.find(fv.getTransactor());
                    sb.append(p.getName(language) + ":" + Flowview.STATE_TYPE[fv.getState()]);
                    String consign = fv.getConsign();
                    if(consign != null && consign.length() > 0)
                    {
                        p = Profile.find(consign);
                        sb.append(" → " + p.getName(language));
                    }
                    sb.append(" [<font color=green>" + fv.getTimeToString() + "</font>]<br>");
                }
            }
        } else
        {
            int flowprocess = 0;
            Enumeration enumer = Flowview.find(flowbusiness," AND flowprocess>0");
            while(enumer.hasMoreElements())
            {
                int flowview = ((Integer) enumer.nextElement()).intValue();
                Flowview fv = Flowview.find(flowview);
                if(flowprocess != fv.getFlowprocess())
                {
                    flowprocess = fv.getFlowprocess();
                    Flowprocess fp = Flowprocess.find(flowprocess);

                    sb.append("<tr class=TableLine1>");
                    sb.append("<td>第 " + fv.getStep() + " 步</td><td>");
                    sb.append(fp.getName(language));
                    sb.append("</td><td nowrap>");
                }
                Profile p = Profile.find(fv.getTransactor());
                sb.append(p.getName(language) + ":" + Flowview.STATE_TYPE[fv.getState()]);
                String consign = fv.getConsign();
                if(consign != null && consign.length() > 0)
                {
                    p = Profile.find(consign);
                    sb.append(" → " + p.getName(language));
                }
                sb.append(" [<font color=green>" + fv.getTimeToString() + "</font>]<br>");
            }
        }
        if(step == 0)
        {
            sb.append("<tr class=TableLine2>");
            sb.append("  <td class=huiditable nowrap align=center colspan=3>  结束 </td>");
            sb.append("</tr>");
            sb.append("</table>");
        }
        sb.append("</table>");
        return sb.toString();
    }
}
