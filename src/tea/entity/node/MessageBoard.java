package tea.entity.node;

import java.util.*;

import tea.db.*;
import tea.entity.*;
import tea.html.*;
import java.sql.SQLException;

public class MessageBoard
{
    public static Cache _cache = new Cache(100);
    private int node;
    private int language;
    private int hint;
    private String phone;
    private String mobile;
    private String email;
    private String name;
    private String ip;
    private boolean exists;
    private int age;
    private int sex;

    public static MessageBoard find(int node,int language) throws SQLException
    {
        MessageBoard obj = (MessageBoard) _cache.get(node + ":" + language);
        if(obj == null)
        {
            obj = new MessageBoard(node,language);
            _cache.put(node + ":" + language,obj);
        }
        return obj;
    }

    public MessageBoard(int node,int language) throws SQLException
    {
        this.node = node;
        this.language = language;
        load();
    }

    private void load() throws SQLException
    {
        int j = Node.getLanguage(node,language);
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT hint,phone,mobile,email,name,sex,age FROM MessageBoard WHERE node= " + node + " AND language=" + j);
            if(db.next())
            {
                hint = db.getInt(1);
                phone = db.getString(2);
                mobile = db.getString(3);
                email = db.getString(4);
                name = db.getVarchar(j,language,5);
                sex = db.getInt(6);
                age = db.getInt(7);
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


    public void set(int hint,String phone,String mobile,String email,String name,String ip,int age,int sex) throws SQLException
    {
        String sql = "INSERT INTO MessageBoard(node,language,hint,phone,mobile,email,name,ip,age,sex)VALUES(" + node + "," + language + "," + hint + "," + DbAdapter.cite(phone) + "," + DbAdapter.cite(mobile) + "," + DbAdapter.cite(email) + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(ip) + "," + age + "," + sex + ")";
        DbAdapter db = new DbAdapter();
        try
        {
            int j = db.executeUpdate(node,sql);
            if(j < 1)
            {
                db.executeUpdate(node,"UPDATE MessageBoard SET hint=" + hint + ",phone =" + DbAdapter.cite(phone) + ",mobile=" + DbAdapter.cite(mobile) + ",email =" + DbAdapter.cite(email) + ",name=" + DbAdapter.cite(name) + ",ip=" + DbAdapter.cite(ip) + ",age=" + age + ",sex=" + sex + " WHERE node=" + node + " AND language=" + language);
            }
        } finally
        {
            db.close();
        }
        _cache.remove(node + ":" + language);
    }

    //通一个IP和标题不能填写信息
    public static boolean isADD(String ip,String subject) throws SQLException
    {
        boolean f = false;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select node  from MessageBoard  where ip = " + db.cite(ip) + " and exists (select node from NodeLayer nl where nl.node=MessageBoard.node and  subject =" + db.cite(subject) + ")");
            if(db.next())
            {
                f = true;
            }
        } finally
        {
            db.close();
        }
        return f;
    }

    public static String getDetail(Node node,Http h,int listing,String target,tea.resource.Resource r) throws SQLException
    {
        RV rv = h.username == null ? null : new RV(h.username);
        Span span = null;
        StringBuilder sb = new StringBuilder();
        MessageBoard obj = MessageBoard.find(node._nNode,h.language);
        ListingDetail detail = ListingDetail.find(listing,73,h.language);
        Iterator e = detail.keys();
        while(e.hasNext())
        {
            String name = (String) e.next();
            String value = null;
            int istype = detail.getIstype(name);
            if(istype == 0 || name.startsWith("r_"))
            {
                continue;
            } else if(name.equals("subject"))
            {
                value = (node.getSubject(h.language));
            } else if(name.equals("newgif"))
            {
                int last = 0;
                if((System.currentTimeMillis() - node.getTime().getTime() - 1000 * 60 * 60 * 24L) < 0 || ((last = MessageBoardReply.findLast(node._nNode,h.language)) > 0) && (System.currentTimeMillis() - MessageBoardReply.find(last).getTime().getTime() - 1000 * 60 * 60 * 24L) < 0)
                {
                    value = "<img src='/tea/image/public/new.gif' />";
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
            } else if(name.equals("hint"))
            {
                value = ("/tea/image/hint/" + tea.htmlx.HintSelection.HINT[obj.getHint()]);
            } else if(name.equals("replycount"))
            {
                value = String.valueOf(MessageBoardReply.count(node._nNode,h.language));
            } else if(name.equals("replybutton"))
            {
                value = "<input type='button' value='" + r.getString(h.language,"Reply") + "' onclick=window.location='/jsp/type/messageboard/EditMessageBoardReply.jsp?node=" + node._nNode + "' />";
            } else if(name.equals("nmark"))
            {
                NMark nm = NMark.find(node._nNode);
                value = "<script>mt.nmark(" + node + "," + nm.good + "," + nm.poor + ")</script>";
            }

            int qu = detail.getQuantity(name);
            if(value != null && qu > 0 && value.length() > qu)
            {
                value = value.substring(0,qu) + " ...";
            }
            if(detail.getAnchor(name) != 0)
            {
                Anchor anchor = new Anchor("/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/messageboard/" + node._nNode + "-" + h.language + ".htm",value);
                anchor.setTarget(target);
                span = new Span(anchor);
            } else
            {
                span = new Span(value);
            }
            span.setId("MessageBoardID" + name);
            sb.append(detail.getBeforeItem(name)).append(span).append(detail.getAfterItem(name));
        }
        //留言板回复
        Enumeration reply_enumer = MessageBoardReply.find(node._nNode,h.language);
        while(reply_enumer.hasMoreElements())
        {
            int messageboardreply = ((Integer) reply_enumer.nextElement()).intValue();
            MessageBoardReply reply_obj = MessageBoardReply.find(messageboardreply);
            Iterator ei = detail.keys();
            while(ei.hasNext())
            {
                String name = (String) ei.next();
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
                } else if(name.equals("r_issue"))
                {
                    value = (reply_obj.getTimeToString());
                } else if(name.equals("r_delete"))
                {
                    if(reply_obj.getMember().equals(node.getCreator()._strR))
                    {
                        value = "<INPUT TYPE=BUTTON VALUE=" + r.getString(h.language,"CBDelete") + " onclick=\"if(confirm('" + r.getString(h.language,"ConfirmDelete") + "')){window.open('/servlet/EditMessageBoard?Node=" + node._nNode + "&messageboardreply=" + messageboardreply + "&act=deletereply','_self'); this.disabled=true;}\" >";
                    }
                }
                int qu = detail.getQuantity(name);
                if(value != null && qu > 0 && value.length() > qu)
                {
                    value = value.substring(0,qu) + " ...";
                }
                if(detail.getAnchor(name) != 0)
                {
                    Anchor anchor = new Anchor("/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/messageboard/" + node._nNode + "-" + h.language + ".htm",value);
                    anchor.setTarget(target);
                    span = new Span(anchor);
                } else
                {
                    span = new Span(value);
                }
                span.setId("MessageBoardID" + name);
                sb.append(detail.getBeforeItem(name)).append(span).append(detail.getAfterItem(name));
            }
        }
        return(sb.toString());
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

    public int getAge()
    {
        return age;
    }

    public int getSex()
    {
        return sex;
    }
}
