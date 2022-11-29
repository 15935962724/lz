package tea.entity.node;

import java.sql.*;
import java.util.*;
import java.util.Date;
import tea.db.*;
import tea.entity.*;
import tea.entity.member.*;
import tea.html.*;
import tea.ui.TeaSession;
import tea.entity.integral.*;


public class Interlocution
{
    private static Cache _cache = new Cache(100);
    private int node;
    private int language;
    private int hint;
    private String phone;
    private String mobile;
    private String email;
    private String name;
    private boolean exists;
    private int offerintegral; //悬赏积分
    private String member;
    private int nodestatic; //这个主题节点对应的状态   0 解决中问题，已解决问题
    private int types;

    public static final String NODESTATIC[] =
            {"解决中问题","已解决问题"};
    public static Interlocution find(int node,int language) throws SQLException
    {
        Interlocution obj = (Interlocution) _cache.get(node + ":" + language);
        if(obj == null)
        {
            obj = new Interlocution(node,language);
            _cache.put(node + ":" + language,obj);
        }
        return obj;
    }

    public Interlocution(int node,int language) throws SQLException
    {
        this.node = node;
        this.language = language;
        loadBasic();
    }

    private void loadBasic() throws SQLException
    {
        int j = this.getLanguage(language);
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT hint    ,phone   ,mobile  ,email   ,name ,offerintegral,nodestatic,member,types FROM Interlocution WHERE node= " + node + " AND language=" + j);
            if(dbadapter.next())
            {
                hint = dbadapter.getInt(1);
                phone = dbadapter.getString(2);
                mobile = dbadapter.getString(3);
                email = dbadapter.getString(4);
                name = dbadapter.getVarchar(j,language,5);
                offerintegral = dbadapter.getInt(6);
                nodestatic = dbadapter.getInt(7);
                member = dbadapter.getString(8);
                types = dbadapter.getInt(9);
                exists = true;
            } else
            {
                exists = false;
            }
        } finally
        {
            dbadapter.close();
        }
    }

    private int getLanguage(int language) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT language FROM Interlocution WHERE node=" + node);
            while(dbadapter.next())
            {
                v.addElement(new Integer(dbadapter.getInt(1)));
            }
        } finally
        {
            dbadapter.close();
        }
        if(v.indexOf(new Integer(language)) != -1)
        {
            return language;
        } else
        {
            if(language == 1)
            {
                if(v.indexOf(new Integer(2)) != -1)
                {
                    return 2;
                }
            } else if(language == 2)
            {
                if(v.indexOf(new Integer(1)) != -1)
                {
                    return 1;
                }
            }
            if(v.size() < 1)
            {
                return 0;
            }
        }
        return((Integer) v.elementAt(0)).intValue();
    }

    public void set(int hint,String phone,String mobile,String email,String name,int offerintegral,int nodestatic,String member,int types) throws SQLException
    {
        int sums = 0;
        Date dates = new Date();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT node FROM Interlocution  WHERE node=" + node + " AND language=" + language);
            if(dbadapter.next())
            {
                dbadapter.executeUpdate("UPDATE Interlocution SET hint  =" + hint + "  ,phone =" + DbAdapter.cite(phone) + " ,mobile=" + DbAdapter.cite(mobile) + ",email =" + DbAdapter.cite(email) + " ,name  =" + DbAdapter.cite(name) + ", offerintegral =" + offerintegral + ", nodestatic =" + nodestatic + " ,member = " + DbAdapter.cite(member) + ", types = " + types + " WHERE  node=" + node + " AND language=" + language);
            } else
            {
                dbadapter.executeUpdate("INSERT INTO Interlocution(node    ,language,hint    ,phone   ,mobile  ,email   ,name,  offerintegral, nodestatic ,member ,types  )VALUES(" + node + "    ," + language + "," + hint + "    ," + DbAdapter.cite(phone) + "   ," + DbAdapter.cite(mobile) + "  ," + DbAdapter.cite(email) + "   ," + DbAdapter.cite(name) + "," + offerintegral + ", " + nodestatic + "," + DbAdapter.cite(member) + " , " + types + " )");
                Profile probj = Profile.find(member);

                if(probj.getIntegral() > offerintegral)
                {
                    //IntegralCycle.create(member,9,dates,offerintegral,probj.getCommunity());
                }
            }
        } finally
        {
            dbadapter.close();
        }
        _cache.remove(node + ":" + language);
    }

    public static boolean option(int node,int language) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT node FROM Interlocution  WHERE node=" + node + " AND language=" + language);
            if(dbadapter.next())
            {
                return true;
            } else
            {
                return false;
            }
        } finally
        {
            dbadapter.close();
        }
    }

    public static String getDetail(Node node,Http h,int listing,String target,tea.resource.Resource r) throws SQLException
    {
        RV rv = h.username == null ? null : new RV(h.username);
        StringBuilder sb = new StringBuilder();
        ListingDetail detail = ListingDetail.find(listing,84,h.language);
        java.util.Iterator e = detail.keys();
        if(e.hasNext())
        {
            Span span = null;
            Interlocution obj = Interlocution.find(node._nNode,h.language);

            while(e.hasNext())
            {
                String name = (String) e.next();
                String value = null;
                int istype = detail.getIstype(name);
                if(istype == 0 || name.startsWith("r_") || name.startsWith("z_r_"))
                {
                    continue;
                } else if(name.equals("subject"))
                {
                    value = (node.getSubject(h.language));
                } else if(name.equals("newgif"))
                {
                    int last = 0;
                    if((System.currentTimeMillis() - node.getTime().getTime() - 1000 * 60 * 60 * 24L) < 0 || ((last = InterlocutionReply.findLast(node._nNode,h.language)) > 0) && (System.currentTimeMillis() - InterlocutionReply.find(last).getTime().getTime() - 1000 * 60 * 60 * 24L) < 0)
                    {
                        value = "<img src=/tea/image/public/new.gif >";
                    }
                } else if(name.equals("creator"))
                {
                    value = (node.getCreator()._strR);
                } else if(name.equals("name"))
                {
                    value = (obj.getName());
                } else if(name.equals("phone"))
                {
                    value = (obj.getPhone());
                } else if(name.equals("mobile"))
                {
                    value = (obj.getMobile());
                } else if(name.equals("text"))
                {
                    value = (node.getText2(h.language));
                } else if(name.equals("issue"))
                {
                    value = (node.getTimeToString());
                } else if(name.equals("email"))
                {
                    value = (obj.getEmail());
                } else if(name.equals("integral"))
                {
                    value = String.valueOf(obj.getOfferintegral());
                } else if(name.equals("types"))
                {
                    InterlocutionType intertype = InterlocutionType.find(obj.getTypes());
                    value = Entity.getNULL(intertype.getTypes());
                } else if(name.equals("hint"))
                {
                    value = ("/tea/image/hint/" + tea.htmlx.HintSelection.HINT[obj.getHint()]);
                } else if(name.equals("replycount"))
                {
                    value = String.valueOf(InterlocutionReply.count(node._nNode,h.language));
                } else if(name.equals("replybutton"))
                {
                    value = (new tea.html.Button("",r.getString(h.language,"Reply"),"window.location='/jsp/type/interlocution/EditInterlocutionReply.jsp?node=" + node._nNode + "';").toString());
                }
                int qu = detail.getQuantity(name);
                if(value != null && qu > 0 && value.length() > qu)
                {
                    value = value.substring(0,qu) + " ...";
                }
                if(detail.getAnchor(name) != 0)
                {
                    Anchor anchor = new Anchor("/servlet/Interlocution?node=" + node._nNode + "&language=" + h.language,value);
                    anchor.setTarget(target);
                    span = new Span(anchor);
                } else
                {
                    span = new Span(value);
                }
                span.setId("InterlocutionID" + name);
                sb.append(detail.getBeforeItem(name)).append(span).append(detail.getAfterItem(name));
                //System.out.println(sb.toString());
            }

            // 最佳答案

            java.util.Enumeration reply_enumer2 = InterlocutionReply.findgood(node._nNode,h.language);
            if(!reply_enumer2.hasMoreElements())
            {
                sb.append("<div id=zj_dan style=display:none;><b>最佳答案：</b><br><Span ID=InterlocutionIDz_r_text>暂无最佳答案</Span></div>");
            }
            for(int index = 0;reply_enumer2.hasMoreElements();index++)
            {
                int interlocutionreply = ((Integer) reply_enumer2.nextElement()).intValue();
                InterlocutionReply reply_obj = InterlocutionReply.find(interlocutionreply);
                e = detail.keys();
                while(e.hasNext())
                {
                    String name = (String) e.next();
                    String value = null;
                    int istype = detail.getIstype(name);
                    if(istype == 0 || !name.startsWith("z_r_"))
                    {
                        continue;
                    } else if(name.equals("z_r_creator"))
                    {
                        value = (reply_obj.getMember());
                    } else if(name.equals("z_r_text"))
                    {
                        if(reply_obj.isHidden() && !node.getCreator().equals(rv))
                        {
                            value = "/***************只有留言者可见*********************/";
                        } else
                        {
                            value = (reply_obj.getText());
                            if(reply_obj.getText() == null)
                            {
                                value = "<span id=zj_da>暂无最佳答案</span>";
                            }
                        }
                    } else if(name.equals("z_r_replystatic"))
                    {
                        value = String.valueOf(InterlocutionReply.BACKSTATIC[reply_obj.getBackstatic()]);
                    } else if(name.equals("z_r_issue"))
                    {
                        value = (reply_obj.getTimeToString());
                    } else if(name.equals("z_r_delete"))
                    {
                        if(reply_obj.getMember().equals(node.getCreator()._strR))
                        {
                            value = "<INPUT TYPE=BUTTON VALUE=" + r.getString(h.language,"CBDelete") + " onclick=\"if(confirm('" + r.getString(h.language,"ConfirmDelete") + "')){window.open('/servlet/EditInterlocution?Node=" + node._nNode + "&interlocutionreply=" + interlocutionreply + "&act=deletereply','_self'); this.disabled=true;}\" >";
                        }
                    }
                    int qu = detail.getQuantity(name);
                    if(value != null && qu > 0 && value.length() > qu)
                    {
                        value = value.substring(0,qu) + " ...";
                    }
                    if(detail.getAnchor(name) != 0)
                    {
                        Anchor anchor = new Anchor("/servlet/Interlocution?node=" + node._nNode + "&language=" + h.language,value);
                        anchor.setTarget(target);
                        span = new Span(anchor);
                    } else
                    {
                        span = new Span(value);
                    }
                    span.setId("InterlocutionID" + name);
                    sb.append(detail.getBeforeItem(name)).append(span).append(detail.getAfterItem(name));
                }
            }

            //其他答案
            int pos = h.getInt("pos");

            int count = InterlocutionReply.count(node._nNode,h.language);

            java.util.Enumeration reply_enumer = InterlocutionReply.find(node._nNode,h.language,pos,20);
            while(reply_enumer.hasMoreElements())
            {
                int interlocutionreply = ((Integer) reply_enumer.nextElement()).intValue();
                InterlocutionReply reply_obj = InterlocutionReply.find(interlocutionreply);
                e = detail.keys();

                while(e.hasNext())
                {
                    String name = (String) e.next();
                    String value = null;
                    int istype = detail.getIstype(name);
                    if(istype == 0 || !name.startsWith("r_"))
                    {
                        continue;
                    } else if(name.equals("r_creator"))
                    {
                        value = (reply_obj.getMember());
                    } else if(name.equals("r_text"))
                    {
                        if(reply_obj.isHidden() && !node.getCreator().equals(rv))
                        {
                            value = "/***************只有留言者可见*********************/";
                        } else
                        {
                            value = (reply_obj.getText());
                        }
                    } else if(name.equals("r_replystatic"))
                    {
                        value = String.valueOf(InterlocutionReply.BACKSTATIC[reply_obj.getBackstatic()]);
                    } else if(name.equals("r_issue"))
                    {
                        value = (reply_obj.getTimeToString());
                    } else if(name.equals("r_delete"))
                    {
                        if(reply_obj.getMember().equals(node.getCreator()._strR))
                        {
                            value = "<INPUT TYPE=BUTTON VALUE=" + r.getString(h.language,"CBDelete") + " onclick=\"if(confirm('" + r.getString(h.language,"ConfirmDelete") + "')){window.open('/servlet/EditInterlocution?Node=" + node._nNode + "&interlocutionreply=" + interlocutionreply + "&act=deletereply','_self'); this.disabled=true;}\" >";
                        }
                    }
                    int qu = detail.getQuantity(name);
                    if(value != null && qu > 0 && value.length() > qu)
                    {
                        value = value.substring(0,qu) + " ...";
                    }
                    if(detail.getAnchor(name) != 0)
                    {
                        Anchor anchor = new Anchor("/servlet/Interlocution?node=" + node._nNode + "&language=" + h.language,value);
                        anchor.setTarget(target);
                        span = new Span(anchor);
                    } else
                    {
                        span = new Span(value);
                    }
                    span.setId("InterlocutionID" + name);
                    sb.append(detail.getBeforeItem(name)).append(span).append(detail.getAfterItem(name));
                }
            }
            if(count > 20)
            {
                sb.append(new tea.htmlx.FPNL(h.language,h.request.getRequestURI() + "?node=" + h.node + "&pos=",pos,count,20));
            }
        }
        return sb.toString();
    }


    public int getNode()
    {
        return node;
    }

    public int getLanguage()
    {
        return language;
    }

    public int getHint()
    {
        return hint;
    }

    public String getPhone()
    {
        return phone;
    }

    public String getMobile()
    {
        return mobile;
    }

    public String getEmail()
    {
        return email;
    }

    public String getName()
    {
        return name;
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getOfferintegral()
    {
        return offerintegral;
    }

    public int getNodestatic()
    {
        return nodestatic;
    }

    public String getMember()
    {
        return member;
    }

    public int getTypes()
    {
        return types;
    }

    //设置会员结贴,成为已解决问题
    public void setNodestatic(int nodestatic,int node) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("Update Interlocution set nodestatic = " + nodestatic + " where node =" + node);
        } finally
        {
            db.close();
        }
    }


}
