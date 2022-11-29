package tea.entity.subscribe;

import java.sql.SQLException;
import java.util.Date;
import java.util.Enumeration;
import java.util.Vector;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Entity;
import tea.entity.admin.AdminUsrRole;
import tea.entity.admin.mov.MemberType;
import tea.entity.node.Goods;
import tea.entity.node.Node;
import tea.ui.member.profile.newcaller;

public class Tactics extends Entity
{

    private int tid;
    private String tacname; //策略名称
    private int conditions; //生效条件
    private int check_ip; //生效ip范围 选择框 0 不使用，1 使用
    private String ip; //生效的ip
    private String remarks; //备注说明

    private String createmember; //创建人
    private Date createtime; //创建时间

    private String publishmember; //公布人
    private Date publishtime; //公布时间

    private int publish; //公布状态  1公布     0 未公布
    private String community; //
    private int node;
    //会员类型
    private int membertype;
    private boolean exists;
    private static Cache _cache = new Cache(2000);

    public final static String[] CONDITION_TYPE =
            {"访问","用户名登陆"};
    public final static String[] PUBLISH_TYPE =
            {"未公布","已公布"};

    public Tactics(int tid) throws SQLException
    {
        this.tid = tid;
        load();
    }

    public static Tactics find(int tid) throws SQLException
    {
        return new Tactics(tid);
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT tacname,conditions,check_ip,ip,remarks,createmember,createtime,publishmember,publishtime,publish,community,node,membertype FROM Tactics WHERE tid =  " + tid);
            if(db.next())
            {
                tacname = db.getString(1);
                conditions = db.getInt(2);
                check_ip = db.getInt(3);
                ip = db.getString(4);
                remarks = db.getString(5);
                createmember = db.getString(6);
                createtime = db.getDate(7);
                publishmember = db.getString(8);
                publishtime = db.getDate(9);
                publish = db.getInt(10);
                community = db.getString(11);
                node = db.getInt(12);
                membertype = db.getInt(13);
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

    public static int create(String tacname,int conditions,int check_ip,String ip,String remarks,String createmember,Date createtime,int publish,String community,int node,int membertype) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int i = 0;
        try
        {
            db.executeUpdate("INSERT INTO Tactics (tacname,conditions,check_ip,ip,remarks,createmember,createtime,publish,community,node,membertype) " +
                             " VALUES (" + db.cite(tacname) + " , " + conditions + "," + check_ip + "," + db.cite(ip) + "," + db.cite(remarks) + "," + db.cite(createmember) + "," +
                             " " + db.cite(createtime) + " ," + publish + "," + db.cite(community) + "," + node + "," + membertype + "    )");
            i = db.getInt("SELECT MAX(tid) FROM Tactics");
        } finally
        {
            db.close();
        }
        return i;
    }

    public void set(String tacname,int conditions,int check_ip,String ip,String remarks,int publish,int membertype) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Tactics SET tacname =" + db.cite(tacname) + ",conditions=" + conditions + ",check_ip=" + check_ip + ",ip=" + db.cite(ip) + " ,remarks =" + db.cite(remarks) + "," +
                             "publish =" + publish + ",membertype=" + membertype + " WHERE tid=" + tid);
        } finally
        {
            db.close();
        }
    }

    //修改公布人和公布时间
    public void set(String publishmember,Date publishtime) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Tactics SET publishmember =" + db.cite(publishmember) + ",publishtime =" + db.cite(publishtime) + " WHERE tid=" + tid);
        } finally
        {
            db.close();
        }
    }

    public static Enumeration find(String community,String sql,int pos,int size)
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT tid FROM Tactics WHERE community= " + db.cite(community) + sql,pos,size);
            while(db.next())
            {
                vector.add(new Integer(db.getInt(1)));
            }
        } catch(Exception exception3)
        {
            System.out.print(exception3);
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM  Tactics WHERE tid = " + tid);

        } finally
        {
            db.close();
        }
    }

    public static int count(String community,String sql) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(tid) FROM Tactics  WHERE community=" + db.cite(community) + sql);
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

    //修改策略
    public void setPublish(int publish) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Tactics SET publish = " + publish + " WHERE tid =  " + tid);
        } catch(Exception e)
        {
            // TODO: handle exception
        } finally
        {
            db.close();
        }
    }

    public void setMemberTime(String member,Date times) throws SQLException
    {
        //private String publishmember;//公布人
        //private Date publishtime;//公布时间
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Tactics SET publishmember = " + db.cite(publishmember) + ",publishtime=" + db.cite(times) + " WHERE tid =  " + tid);
        } catch(Exception e)
        {
            // TODO: handle exception
        } finally
        {
            db.close();
        }
    }


    public String getTacname()
    {
        return tacname;
    }

    public int getCondition()
    {
        return conditions;
    }

    public int getCheck_ip()
    {
        return check_ip;
    }

    public String getIp()
    {
        return ip;
    }

    public String getRemarks()
    {
        return remarks;
    }

    public String getCreatemember()
    {
        return createmember;
    }

    public Date getCreatetime()
    {
        return createtime;
    }

    public String getCreatetimeToString()
    {
        if(createtime == null)
        {
            return "";
        }
        return sdf2.format(createtime);
    }

    public String getPublishmember()
    {
        return publishmember;
    }

    public Date getPublishtime()
    {
        return publishtime;
    }

    public String getPublishtimeToString()
    {
        if(publishtime == null)
        {
            return "";
        }
        return sdf2.format(publishtime);
    }

    public int getPublish()
    {
        return publish;
    }

    public String getCommunity()
    {
        return community;
    }

    public int getNode()
    {
        return node;
    }

    public boolean isExists()
    {
        return exists;
    }


    public int getMembertype()
    {
        return membertype;
    }

    //判断是否有策略
    public static boolean isTactics(int node,String community) throws SQLException
    {

        boolean fs = false;

        // if(_cache.get(node+community)!=null)
        // {
        //fs = true;
        // }else
        //  {

        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery(" select tid from Tactics where  publish=1 and  node = " + node + " and community =" + db.cite(community));
            if(db.next())
            {
                fs = true;
                // _cache.put(node+community,db.getInt(1));
            }
        } catch(Exception e)
        {
            // TODO: handle exception
        } finally
        {
            db.close();
        }

        // }
        return fs;
    }


    //知道一个node 的path路径  判断出来是否是报纸的节点
    public static int getNode(String path)
    {
        int n = 0;
        try
        {
            for(int i = 1;i < path.split("/").length;i++)
            {
                int pid = Integer.parseInt(path.split("/")[i]);
                Node nobj = Node.find(pid);
                if(nobj.getCategoryosubscribe() != null && nobj.getCategoryosubscribe().indexOf("/0/") != -1)
                {
                    n = pid;
                    break;
                }
            }
        } catch(Exception e)
        {
            // TODO: handle exception
        }
        return n;
    }

    //知道Node 父亲节点名称（电子报导入时候的 期次）判断在策略中期次范围
    public static boolean isQiCi(String qicitimes,int father,String community)
    {
        boolean f = false;
        DbAdapter db = new DbAdapter();
        try
        {
            //boolean s = false;
            //判断是否有所有期次，如果有 则不判断期次范围
            db.executeQuery("select t.tid from Tactics t,ReadRight rr where t.community=" + db.cite(community) + " and t.tid = rr.father and t.node = " + father + " and t.publish=1 and rr.qici_suoyou=1 and rr.type='Tactics' ");
            if(db.next())
            {
                f = true;

            } else //没有所有期次 判断期次范围时间
            {
                db.executeQuery("select * from Tactics t,ReadRight rr where t.community=" + db.cite(community) + " and t.tid = rr.father and t.node =" + father + "  and rr.type='Tactics'  and t.publish=1 and rr.qici_suoyou=0 " +
                                " and rr.qc_timec <= " + db.cite(qicitimes) + " and rr.qc_timed >=" + db.cite(qicitimes));
                if(db.next())
                {
                    f = true;
                }
            }
        } catch(Exception e)
        {
            // TODO: handle exception
        } finally
        {
            db.close();
        }
        return f;
    }

    //判断阅读权限
    public static boolean isYueDu(int father,String community)
    {
        boolean f = false;
        DbAdapter db = new DbAdapter();
        try
        {
            //判断阅读有效期是否设为永久

            db.executeQuery("select t.tid from Tactics t,ReadRight rr where t.community=" + db.cite(community) + "  and rr.type='Tactics'  and t.tid = rr.father and t.node = " + father + " and t.publish=1 and rr.yd_sheweiyoujiu=1 ");
            if(db.next())
            {
                f = true;
            } else
            {
                db.executeQuery("select * from Tactics t,ReadRight rr where t.community=" + db.cite(community) + "  and rr.type='Tactics'  and t.tid = rr.father and t.node =" + father + "  and t.publish=1 and rr.yd_sheweiyoujiu=0 " +
                                " and rr.yd_timec <= " + db.cite(sdf.format(new Date())) + " and rr.yd_timed >=" + db.cite(sdf.format(new Date())));
                if(db.next())
                {
                    f = true;
                }
            }

        } catch(Exception e)
        {
            // TODO: handle exception
        } finally
        {
            db.close();
        }
        return f;
    }

    //判断版次是否可以查看
    public static boolean isBanCi(int father,String community,int banciid)
    {
        boolean f = false;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select t.tid from Tactics t,ReadRight rr where t.community=" + db.cite(community) + "  and rr.type='Tactics'  and t.tid = rr.father and t.node = " + father + " " +
                            "and t.publish=1 and rr.suoyou=0 ");
            if(db.next())
            {
                f = true;
            } else
            {

                db.executeQuery("select t.tid from Tactics t,ReadRight rr where t.community=" + db.cite(community) + "  and rr.type='Tactics'  and t.tid = rr.father " +
                                "and t.node = " + father + " and t.publish=1 and rr.suoyou=1 and  rr.banci like " + db.cite("%/" + banciid + "/%"));

                if(db.next())
                {
                    f = true;
                }
            }

        } catch(Exception e)
        {
            // TODO: handle exception
        } finally
        {
            db.close();
        }
        return f;
    }

    //查看ip限制
    public static boolean isIp(int father,String community,String ip)
    {
        boolean f = false;

        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select ip from Tactics where community=" + db.cite(community) + "  and node = " + father + " and publish=1 and check_ip = 1 ");
            while(db.next())
            {
                String tip = db.getString(1);

                if(tip != null && tip.length() > 0)
                {
                    tip = tip.replaceAll("\\n","");
                    tip = tip.replaceAll("\\r","");

                    if(tip.substring(tip.length() - 1,tip.length()).indexOf("#") == -1)
                    {
                        tip += "#";
                    }
                }

                if(tip != null && tip.length() > 0 && tip.indexOf("#") == -1)
                {
                    tip += "#";
                }

                System.out.println(tip + "--ip:" + ip);
                if(tip != null && tip.length() > 0)
                {
                    for(int i = 0;i < tip.split("#").length;i++)
                    {
                        String t1 = tip.split("#")[i];

                        if(t1.indexOf("-") == -1) //一个ip
                        {

                            if(t1.equals(ip))
                            {
                                f = true;
                                break;
                            }

                        } else //ip段判断
                        {
                            if(ipIsValid(t1.trim(),ip))
                            {
                                f = true;
                                break;
                            }
                        }
                    }
                }

            }
        } catch(Exception e)
        {
            // TODO: handle exception
        } finally
        {
            db.close();
        }

        return f;
    }


    //判断ip是否属于该网段
    public static boolean ipIsValid(String ipSection,String ip)
    {
        if(ipSection == null)
        {
            throw new NullPointerException("IP段不能为空！");
        }
        if(ip == null)
        {
            throw new NullPointerException("IP不能为空！");
        }
        ipSection = ipSection.trim();
        ip = ip.trim();
        final String REGX_IP = "((25[0-5]|2[0-4]\\d|1\\d{2}|[1-9]\\d|\\d)\\.){3}(25[0-5]|2[0-4]\\d|1\\d{2}|[1-9]\\d|\\d)";
        final String REGX_IPB = REGX_IP + "\\-" + REGX_IP;
        if(!ipSection.matches(REGX_IPB) || !ip.matches(REGX_IP))
        {
            return false;
        }
        int idx = ipSection.indexOf('-');
        String[] sips = ipSection.substring(0,idx).split("\\.");
        String[] sipe = ipSection.substring(idx + 1).split("\\.");
        String[] sipt = ip.split("\\.");
        long ips = 0L,ipe = 0L,ipt = 0L;
        for(int i = 0;i < 4;++i)
        {
            ips = ips << 8 | Integer.parseInt(sips[i]);
            ipe = ipe << 8 | Integer.parseInt(sipe[i]);
            ipt = ipt << 8 | Integer.parseInt(sipt[i]);
        }
        if(ips > ipe)
        {
            long t = ips;
            ips = ipe;
            ipe = t;
        }
        return ips <= ipt && ipt <= ipe;
    }

    //判断是否是访问

    public static int getSXtiaojian(int father,String community,String member,int banciid,String qicitimes)
    {
        int f = -1;
        DbAdapter db = new DbAdapter();
        try
        {

            db.executeQuery("select t.tid from Tactics t,ReadRight rr where community=" + db.cite(community) + " and t.tid = rr.father and t.node = " + father + " " +
                            " and t.publish=1  and ( rr.suoyou=0  or  rr.banci like " + db.cite("%/" + banciid + "/%") + " ) " +
                            " and (rr.qici_suoyou=1  or ( rr.qc_timec <= " + db.cite(qicitimes) + " and rr.qc_timed >=" + db.cite(qicitimes) + ") ) " +
                            " and (rr.yd_sheweiyoujiu=1 or ( rr.yd_timec <= " + db.cite(sdf.format(new Date())) + "  and rr.yd_timed >=" + db.cite(sdf.format(new Date())) + ")  )" +
                            " order by t.createtime desc   ");

            if(db.next())
            {
                int tid = db.getInt(1);
                Tactics tobj = Tactics.find(tid);
                if(tobj.getCondition() == 0) //访问
                {
                    f = 0;
                } else
                {
                    if(tobj.getMembertype() > 0)
                    {
                        AdminUsrRole auobj =  AdminUsrRole.find(community,member);
                        String role = auobj.getRole();
                        MemberType mtobj = MemberType.find(tobj.getMembertype());
                        if(role != null && role.length() > 0 && role.indexOf(mtobj.getRole()) != -1) //说明有
                        {
                            f = 3;
                        }
                    } else
                    {
                        if(member != null && member.length() > 0)
                        {
                            f = 2;
                        } else
                        {
                            f = 4;
                        }

                    }
                }
            }
        } catch(Exception e)
        {
            // TODO: handle exception
        } finally
        {
            db.close();
        }
        return f;
    }

}
