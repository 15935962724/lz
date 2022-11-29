package tea.entity.node;

import java.sql.*;
import java.util.*;
import tea.entity.admin.*;
import tea.db.*;
import tea.entity.*;

public class AccessMember extends Entity
{
    public static Cache _cache = new Cache(100);
    public static final String PUR_TYPE[] =
            {"访问","创建","创建和编辑","完全控制","不可访问"};
    public static final String APPLY_STYLE[] =
            {"本节点","子节点","本树"};
    public static final String OBJECT_TYPE[] =
            {"所有人员","所有会员","自定义"};
    public static final String COMPETENCE_TYPE[] =
            {"创建","编辑","删除"};
    public static final String COMPETENCE_TYPE_2[] =
            {"创建","编辑","删除","列项"};
    private int accessmember;
    private int node;
    private String creator;
    private String member; //null:所有人员 /:所有会员
    private String role;
    private String unit;
    private int style;
    private int purview; // 0:访问,1:创建,2.创建编辑,3:完全控制
    private boolean auditing; //审核
    private String type;
    private String category;
    private String section = "/"; //段落权限
    private String listing; //列举权限
    private String cssjs; //css权限
    private String listings; //推荐栏目列举

    private int picshow; //前台编辑小图标是否出现 0:显示 1:隐藏
    private int permissions; //添加权限

    private boolean exists;

    public AccessMember(int node,int purview,boolean auditing,String type,String category,String section,
                        String listing,String cssjs,String listings,int picshow,int permissions) //, String member, String role, String unit
    {
        this.node = node;
        this.member = member;
        this.role = role;
        this.unit = unit;
        this.purview = purview;
        this.auditing = auditing;
        this.type = type;
        this.category = category;
        this.section = section;
        this.listing = listing;
        this.cssjs = cssjs;
        this.listings = listings;
        this.picshow = picshow;
        this.permissions = permissions;
    }


    public void set(String member,String role,String unit,int style,int purview,boolean auditing,String type,
                    String category,String section,String listing,String cssjs,String listings,int picshow,int permissions) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(accessmember,"UPDATE AccessMember SET member="
                             + DbAdapter.cite(member) + ",role=" + DbAdapter.cite(role)
                             + ",unit=" + DbAdapter.cite(unit) + ",style=" + style
                             + ",purview=" + purview + ",auditing="
                             + DbAdapter.cite(auditing) + ",type="
                             + DbAdapter.cite(type) + ",category="
                             + DbAdapter.cite(category) + ",section=" + db.cite(section)
                             + ",listing=" + db.cite(listing) + "," + "cssjs="
                             + db.cite(cssjs) + ",listings=" + DbAdapter.cite(listings)
                             + "," + "picshow=" + picshow + ",permissions=" + permissions + " WHERE accessmember="
                             + accessmember);
        } finally
        {
            db.close();
        }
        this.member = member;
        this.role = role;
        this.unit = unit;
        this.style = style;
        this.purview = purview;
        this.auditing = auditing;
        this.type = type;
        this.category = category;
        this.section = section;
        this.listing = listing;
        this.cssjs = cssjs;
        this.listings = listings;
        this.picshow = picshow;
        this.exists = true;
        this.permissions = permissions;
    }

    public static void create(int node,String member,String role,String unit,String creator,int style,int purview,boolean auditing,String type,String category,
                              String section,String listing,String cssjs,String listings,int picshow,int permissions) throws SQLException
    {
        int accessmember = Seq.get();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(accessmember,"INSERT INTO AccessMember(accessmember,node,member,role,unit,creator,style,purview,auditing,type,category,section,listing,cssjs,listings,picshow,permissions)VALUES(" + accessmember + "," + node + ", " + DbAdapter.cite(member) + ", " + DbAdapter.cite(role) + ", " + DbAdapter.cite(unit) + ", " + DbAdapter.cite(creator) + ","
                             + style + ", " + purview + ", " + db.cite(auditing) + "," + db.cite(type) + ", " + db.cite(category) + "," +
                             "" + db.cite(section) + "," + db.cite(listing) + "," + db.cite(cssjs) + "," + db.cite(listings) + "," +
                             "" + (picshow) + "," + permissions + "  )");
        } finally
        {
            db.close();
        }
    }

    public boolean isProvider(int i) throws SQLException
    {
        if(i != 1)
        {
            return type != null && type.indexOf("/" + i + "/") != -1;
        } else
        {
            return category != null && category.length() > 2;
        }
    }

    public AccessMember(int accessmember) throws SQLException
    {
        this.accessmember = accessmember;
        load();
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node,member,role,unit,creator,style,purview,auditing,type,category,section,listing," +
                            " cssjs,listings,picshow,permissions FROM AccessMember WHERE accessmember=" + accessmember);
            if(db.next())
            {
                node = db.getInt(1);
                member = db.getString(2);
                role = db.getString(3);
                unit = db.getString(4);
                creator = db.getString(5);
                style = db.getInt(6);
                purview = db.getInt(7);
                auditing = db.getInt(8) != 0;
                type = db.getString(9);
                category = db.getString(10);
                section = db.getString(11);
                listing = db.getString(12);
                cssjs = db.getString(13);
                listings = db.getString(14);
                picshow = db.getInt(15);
                permissions = db.getInt(16);
                exists = true;
            } else
            {
                purview = -1;
                exists = false;
            }
        } finally
        {
            db.close();
        }
    }

    // public static Vector getAccessNode(Vector vector, RV rv) throws
    // SQLException
    // {
    // // Vector vector = new Vector();
    // Enumeration enumeration = vector.elements();
    // int nodecode;
    // long option;
    // while (enumeration.hasMoreElements())
    // {
    // nodecode = ((Integer) enumeration.nextElement()).intValue();
    // Node node = Node.find(nodecode);
    // option = node.getOptions();
    // if ((option & 0x1000) != 0 && (option & 0x100) != 0 &&
    // (!AccessMember.isAccessMember(nodecode, rv) && !node.isCreator(rv)))
    // {
    // vector.remove((nodecode));
    // }
    // }
    // return vector;
    // }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM AccessMember WHERE accessmember=" + accessmember);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(accessmember));
    }

    public static Enumeration findByNode(int node) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT accessmember FROM AccessMember WHERE node=" + node);
            while(db.next())
            {
                v.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        if(Node.find(node).isExtend())
        {
            int father = Node.find(node).getFather();
            if(father != 0)
            {
                Enumeration e = findByNode(father);
                while(e.hasMoreElements())
                {
                    v.addElement(e.nextElement());
                }
            }
        }
        return v.elements();
    }

    // 获取用户的权限//////////
    public static AccessMember find(int node,RV rv) throws SQLException
    {
        //boolean bool=teasession._rv.isWebMaster()||teasession._rv.isOrganizer(teasession._strCommunity);
        return find(node,rv == null ? null : rv._strV);
    }

    public static AccessMember find(int node,String member) throws SQLException
    {
        Node obj = Node.find(node);
        int p = -1;
        boolean a = false;
        int picshow = 1;
        int ps = 0;
        StringBuffer sb0 = new StringBuffer();
        StringBuffer sb1 = new StringBuffer();
        StringBuffer sb2 = new StringBuffer();
        StringBuffer sb3 = new StringBuffer();
        StringBuffer sb4 = new StringBuffer();
        StringBuffer sb5 = new StringBuffer();
        StringBuffer sb6 = new StringBuffer();
        StringBuffer sql = new StringBuffer();
        //权限///
        StringBuffer s = new StringBuffer();
        if(member == null)
        {
            s.append("( member IS NULL AND role IS NULL AND unit IS NULL )");
        } else
        {
            s.append(" ( member LIKE ").append(DbAdapter.cite("%/" + member + "/%"));
            AdminUsrRole aur = AdminUsrRole.find(obj.getCommunity(),member);
            if(aur.isExists())
            {
                String rs[] = aur.getRole().split("/");
                for(int i = 1;i < rs.length;i++)
                {
                    s.append(" OR role LIKE ").append(DbAdapter.cite("%/" + rs[i] + "/%"));
                }
                s.append(" OR unit LIKE ").append(DbAdapter.cite("%/" + aur.getUnit() + "/%"));
                String us[] = aur.getClasses().split("/");
                for(int i = 1;i < us.length;i++)
                {
                    s.append(" OR unit LIKE ").append(DbAdapter.cite("%/" + us[i] + "/%"));
                }
            }
            s.append(" OR (member='/' AND role='/' AND unit='/')");
            s.append(")");
        }
        //
        sql.append("SELECT purview,auditing,type,category,section,listing,cssjs,listings,picshow,permissions FROM AccessMember WHERE ( style IN(0,2) AND node=").append(node).append(" AND ").append(s).append(")");
        while(obj.getFather() > 0 && obj.isExtend())
        {
            sql.append(" OR( style IN(1,2) AND node=").append(obj.getFather()).append(" AND ").append(s).append(")");
            obj = Node.find(obj.getFather());
        }
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery(sql.toString());
            while(db.next())
            {
                int purview = db.getInt(1);
                boolean auditing = db.getInt(2) != 0;
                String type = db.getString(3);
                String category = db.getString(4);
                String section = db.getString(5);
                String listing = db.getString(6);
                String cssjs = db.getString(7);
                String listings = db.getString(8);
                if(db.getInt(9) == 0)
                    picshow = 0;
                int permissions = db.getInt(10);
                // ///////
                if(p < purview)
                {
                    p = purview;
                }
                if(auditing)
                {
                    a = true;
                }

                sb0.append(type);
                sb1.append(category);
                sb2.append(section);
                sb3.append(listing);
                sb4.append(cssjs);
                sb5.append(listings);
                ps = permissions;
            }
        } finally
        {
            db.close();
        }
        return new AccessMember(node,p,a,sb0.toString(),sb1.toString(),sb2.toString(),sb3.toString(),sb4.toString(),sb5.toString(),picshow,ps);
    }

    /**
     * 判断用户首页是否可以访问方法
     * @param node
     * @param member
     * @return boolean
     * @throws SQLException
     * newtime 2012-08-25
     */

    public static int getIntPurview(Node obj,String member) throws SQLException
    {
        int ispurview = 0;

        // 先去登陆
        if((obj.getOptions() & 0x1000L) != 0 && member == null)
        {
            ispurview = 1;
        } else
        {
            if(member == null)
            {
                ispurview = 2;
            } else
            {

                StringBuffer sql = new StringBuffer();
                // 权限///
                StringBuffer s = new StringBuffer();

                s.append(" ( member LIKE ").append(DbAdapter.cite("%/" + member + "/%"));
                AdminUsrRole aur = AdminUsrRole.find(obj.getCommunity(),member);
                if(aur.isExists())
                {
                    String rs[] = aur.getRole().split("/");
                    for(int i = 1;i < rs.length;i++)
                    {
                        s.append(" OR role LIKE ").append(DbAdapter.cite("%/" + rs[i] + "/%"));
                    }
                    s.append(" OR unit LIKE ").append(DbAdapter.cite("%/" + aur.getUnit() + "/%"));
                    String us[] = aur.getClasses().split("/");
                    for(int i = 1;i < us.length;i++)
                    {
                        s.append(" OR unit LIKE ").append(DbAdapter.cite("%/" + us[i] + "/%"));
                    }
                }
                s.append(" OR (member='/' AND role='/' AND unit='/')");
                s.append(")");

                //
                sql.append("SELECT purview,auditing,type,category,section,listing,cssjs,listings,picshow,permissions FROM AccessMember WHERE ( style IN(0,2) AND node=").append(obj._nNode).append(" AND ").append(s).append(")");
                while(obj.getFather() > 0 && obj.isExtend())
                {
                    sql.append(" OR( style IN(1,2) AND node=").append(obj.getFather()).append(" AND ").append(s).append(")");
                    obj = Node.find(obj.getFather());
                }
                DbAdapter db = new DbAdapter();
                try
                {
                    db.executeQuery(sql.toString());
                    boolean f = true;
                    while(db.next())
                    {
                        f = false;
                        int purview = db.getInt(1);
                        if(purview != 4)
                        {
                            ispurview = 3;
                            break;
                        }
                    }
                    if(f)
                    {
                        ispurview = 2;
                    }
                } finally
                {
                    db.close();
                }
            }
        }
        return ispurview;
    }


    public static AccessMember find(int id) throws SQLException
    {
        AccessMember obj = (AccessMember) _cache.get(new Integer(id));
        if(obj == null)
        {
            obj = new AccessMember(id);
            _cache.put(new Integer(id),obj);
        }
        return obj;
    }


    // 删除所有子节点的权限，并把子节点改为'继承'的//////////
    public static void reset(int node) throws SQLException
    {
        String path = Node.find(node).getPath();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM AccessMember WHERE node IN( SELECT node FROM Node WHERE path LIKE '/" + path + "/_%' )");
            db.executeQuery("SELECT node FROM Node WHERE path LIKE '/" + path + "/_%' AND extend=0");
            while(db.next())
            {
                int n = db.getInt(1);
                Node.find(n).setExtend(true);
            }
        } finally
        {
            db.close();
        }
        _cache.clear();
    }

    public String getType()
    {
        return type;
    }

    public int getPurview()
    {
        return purview;
    }

    public int getNode()
    {
        return node;
    }

    public String getMember()
    {
        return member;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getCreator()
    {
        return creator;
    }

    public int getObjectType()
    {
        if(role == null && unit == null && member == null)
        {
            return 0;
        }
        if("/".equals(role) && "/".equals(unit) && "/".equals(member))
        {
            return 1;
        }
        return 2;
    }

    public static int getPicshow(int node,String member) throws SQLException
    {
        int c = 1;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT picshow FROM AccessMember where node =" + node + " and member like " + db.cite("%/" + member + "/%"));
            while(db.next())
            {
                int p = db.getInt(1);
                if(p == 0)
                {
                    c = p;
                    continue;
                }
            }
        } finally
        {
            db.close();
        }
        return c;
    }

    //获取用户角色权限
    public static String getRole(String community,int node,String member) throws SQLException
    {
        List list = new ArrayList();
        //取出Node表中 所有栏目新闻类字段
        StringBuffer node_sql = new StringBuffer();
        node_sql.append(" and path like ").append(DbAdapter.cite("%/" + node + "/%"));
        node_sql.append(" and exists (select node from Category c where n.node = c.node and c.category = 39) ");

        java.util.Enumeration ne = Node.find(node_sql.toString(),0,Integer.MAX_VALUE);
        Set set_role = AccessMember.getRole(community,member);
        Set set_unit = AccessMember.getUnit(community,member);

        while(ne.hasMoreElements())
        {

            int nid = ((Integer) ne.nextElement()).intValue();
            Node nobj = Node.find(nid);
            //取出nid 节点中所以的权限 记录
            Enumeration e = AccessMember.findByNode(nid);

            //类别下面的是否有审核的权限


            if(AccessMember.isTypeRole(nid,member,community))
            {

                labelA:
                        for(int i = 0;e.hasMoreElements();)
                {
                    int id = ((Integer) e.nextElement()).intValue();
                    AccessMember obj = AccessMember.find(id);
                    //获取节点权限表中 角色字段 用户是否在此范围内存在
                    if(obj.getRole() != null && obj.getRole().length() > 1)
                    {
                        for(int j = 1;j < obj.getRole().split("/").length;j++)
                        {
                            if(set_role.contains(obj.getRole().split("/")[j]) && obj.permissions > 0)
                            {
                                list.add(nid);
                                break labelA;
                            }
                        }
                    }
                    //获取节点权限表中 部门 字段
                    if(obj.getUnit() != null && obj.getUnit().length() > 1)
                    {
                        for(int j = 1;j < obj.getUnit().split("/").length;j++)
                        {
                            if(set_unit.contains(obj.getUnit().split("/")[j] != null && obj.getUnit().split("/")[j].length() > 0 ? Integer.parseInt(obj.getUnit().split("/")[j]) : 0) && obj.permissions > 0)
                            {
                                list.add(nid);
                                break labelA;
                            }
                        }
                    }
                    //获取是否 节点权限表中用户字段

                    if(obj.getMember() != null && obj.getMember().length() > 1)
                    {
                        for(int j = 1;j < obj.getMember().split("/").length;j++)
                        {
                            if(member.equals(obj.getMember().split("/")[j]) && obj.permissions > 0)
                            {
                                list.add(nid);
                                break labelA;
                            }
                        }
                    }

                }
            }

        }
        StringBuffer sql = new StringBuffer();

        for(Iterator it = list.iterator();it.hasNext();)
        {
            sql.append(" n.path like ").append(DbAdapter.cite("%/" + it.next() + "/%")).append(" or");
        }

        String s = "";
        if(sql != null && sql.length() > 0)
        {
            s = " and ( " + sql.toString().substring(0,sql.toString().length() - 2) + ")";
        } else
        {
            s = " and n.path = null ";
        }

        return s;
    }

    public static boolean isTypeRole(int node,String member,String community) throws SQLException
    {
        boolean f = false;

        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select node from Node where path like " + db.cite("%/" + node + "/%") + " ");
            while(db.next())
            {
                int nid = db.getInt(1);
                Node nobj = Node.find(nid);
                if(AccessMember.isAudit(node,member,community,nobj.getAudit()))
                {
                    f = true;
                    break;
                }
            }

        } finally
        {
            db.close();
        }
        return f;
    }

    /**
     * 判断是否有审核权限
     * @return
     * @throws SQLException
     */
    public static boolean isAudit(int nid,String member,String community,int audit) throws SQLException
    {
        boolean f = false;
        audit = audit + 1;
        Set set_role = AccessMember.getRole(community,member);
        Set set_unit = AccessMember.getUnit(community,member);

        //参数nid 是新闻的栏目节点

        Node nobj = Node.find(nid);
        //取出nid 节点中所以的权限 记录
        Enumeration e = AccessMember.findByNode(nid);
        labelA:
                for(int i = 0;e.hasMoreElements();)
        {
            int id = ((Integer) e.nextElement()).intValue();
            AccessMember obj = AccessMember.find(id);
            //获取节点权限表中 角色字段 用户是否在此范围内存在
            if(obj.getRole() != null && obj.getRole().length() > 1)
            {
                for(int j = 1;j < obj.getRole().split("/").length;j++)
                {
                    if(set_role.contains(obj.getRole().split("/")[j]) && AccessMember.isPermissions(obj.getPermissions()).contains(audit))
                    {
                        f = true;
                        break labelA;
                    }
                }
            }
            //获取节点权限表中 部门 字段
            if(obj.getUnit() != null && obj.getUnit().length() > 1)
            {
                for(int j = 1;j < obj.getUnit().split("/").length;j++)
                {
                    if(set_unit.contains(obj.getUnit().split("/")[j] != null && obj.getUnit().split("/")[j].length() > 0 ? Integer.parseInt(obj.getUnit().split("/")[j]) : 0)
                       && AccessMember.isPermissions(obj.getPermissions()).contains(audit))
                    {
                        f = true;
                        break labelA;
                    }
                }
            }
            //获取是否 节点权限表中用户字段

            if(obj.getMember() != null && obj.getMember().length() > 1)
            {
                for(int j = 1;j < obj.getMember().split("/").length;j++)
                {
                    if(member.equals(obj.getMember().split("/")[j]) && AccessMember.isPermissions(obj.getPermissions()).contains(audit))
                    {
                        f = true;
                        break labelA;
                    }
                }
            }

        }
        return f;
    }

    /**
     * 判断是否有审核权限
     * @return
     * @throws SQLException
     */
    public static boolean isAuditAll(String community,int node,String member,int au) throws SQLException
    {
        boolean f = false;
        List list = new ArrayList();
        //取出Node表中 所以栏目新闻类字段
        StringBuffer node_sql = new StringBuffer();
        node_sql.append(" and path like ").append(DbAdapter.cite("%/" + node + "/%"));
        node_sql.append(" and exists (select node from Category c where n.node = c.node and c.category = 39) ");

        java.util.Enumeration ne = Node.find(node_sql.toString(),0,Integer.MAX_VALUE);
        Set set_role = AccessMember.getRole(community,member);
        Set set_unit = AccessMember.getUnit(community,member);

        while(ne.hasMoreElements())
        {

            int nid = ((Integer) ne.nextElement()).intValue();
            Node nobj = Node.find(nid);
            //取出nid 节点中所以的权限 记录
            Enumeration e = AccessMember.findByNode(nid);
            labelA:
                    for(int i = 0;e.hasMoreElements();)
            {
                int id = ((Integer) e.nextElement()).intValue();
                AccessMember obj = AccessMember.find(id);
                //获取节点权限表中 角色字段 用户是否在此范围内存在
                if(obj.getRole() != null && obj.getRole().length() > 1)
                {
                    for(int j = 1;j < obj.getRole().split("/").length;j++)
                    {
                        if(set_role.contains(obj.getRole().split("/")[j]) && (obj.permissions & au) != 0)
                        {
                            f = true;
                            break labelA;
                        }
                    }
                }
                //获取节点权限表中 部门 字段
                if(obj.getUnit() != null && obj.getUnit().length() > 1)
                {
                    for(int j = 1;j < obj.getUnit().split("/").length;j++)
                    {
                        if(set_unit.contains(obj.getUnit().split("/")[j] != null && obj.getUnit().split("/")[j].length() > 0 ? Integer.parseInt(obj.getUnit().split("/")[j]) : 0) && (obj.permissions & au) != 0)
                        {
                            f = true;
                            break labelA;
                        }
                    }
                }
                //获取是否 节点权限表中用户字段

                if(obj.getMember() != null && obj.getMember().length() > 1)
                {
                    for(int j = 1;j < obj.getMember().split("/").length;j++)
                    {
                        if(member.equals(obj.getMember().split("/")[j]) && (obj.permissions & au) != 0)
                        {
                            f = true;
                            break labelA;
                        }
                    }
                }

            }

        }

        return f;
    }


    //判断是否有这个审核等级
    public static Set isPermissions(int permissions)
    {
        Set set = new HashSet();
        if((permissions & 1) != 0)
        {
            set.add(1);
        }

        if((permissions & 2) != 0)
        {
            set.add(2);
        }

        if((permissions & 4) != 0)
        {
            set.add(3);
        }

        if((permissions & 8) != 0)
        {
            set.add(4);
        }
        return set;
    }

    //获取用户的所以角色ID
    public static Set getRole(String community,String member) throws SQLException
    {
        Set set = new HashSet();
        AdminUsrRole obj = AdminUsrRole.find(community,member);
        if(obj.getRole() != null && obj.getRole().length() > 1)
        {
            for(int i = 1;i < obj.getRole().split("/").length;i++)
            {
                set.add(obj.getRole().split("/")[i]);
            }
        }
        return set;
    }

    //获取用户的所以部门
    public static Set getUnit(String community,String member) throws SQLException
    {
        Set set = new HashSet();
        AdminUsrRole obj = AdminUsrRole.find(community,member);
        set.add(obj.getUnit());
        return set;
    }


    public String getCategory()
    {
        return category;
    }

    public boolean isAuditing()
    {
        return auditing;
    }

    public int getPicshow()
    {
        return picshow;
    }

    public int getAccessmember()
    {
        return accessmember;
    }

    public int getStyle()
    {
        return style;
    }

    public String getRole()
    {
        return role;
    }

    public String getUnit()
    {
        return unit;
    }

    public String getSection()
    {
        return section;
    }

    public String getListing()
    {
        return listing;
    }

    public String getCssjs()
    {
        return cssjs;
    }

    public String getListings()
    {
        return listings;
    }

    public int getPermissions()
    {
        return permissions;
    }
}
