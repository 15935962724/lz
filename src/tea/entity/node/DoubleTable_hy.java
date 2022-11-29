package tea.entity.node;

public class DoubleTable_hy
{
    private int nodeid;
    private String subject;
    private String memberid;
    public DoubleTable_hy(String memberid ,String subject)
    {
        this.memberid = memberid;
        this.subject = subject;
    }
    public String getMemberid()
    {
        return memberid;
    }

    public int getNodeid()
    {
        return nodeid;
    }

    public String getSubject()
    {
        return subject;
    }

    public void setMemberid(String memberid)
    {
        this.memberid = memberid;
    }

    public void setNodeid(int nodeid)
    {
        this.nodeid = nodeid;
    }

    public void setSubject(String subject)
    {
        this.subject = subject;
    }
}
