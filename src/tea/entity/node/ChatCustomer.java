package tea.entity.node;

import java.io.*;
import java.util.*;
import tea.entity.*;
import java.sql.SQLException;

public class ChatCustomer implements Serializable
{
	private static java.util.Hashtable customer = new java.util.Hashtable();
	private static int IDENTITY = 0;
	private String member;
	private String address;
	private Date time;
	private String ip;
	private String nickname;
	private String community;
	private String to;

	public ChatCustomer(String member, String nickname, String community, String to, String ip)
	{
		this.member = member;
		this.nickname = nickname;
		this.community = community;
		this.ip = ip;
		address = null;
		this.to = to;
		time = new Date();
	}

	private void readObject(ObjectInputStream ois) throws IOException, ClassNotFoundException
	{
		ois.defaultReadObject();
	}

	private void writeObject(ObjectOutputStream oos) throws IOException
	{
		oos.defaultWriteObject();
	}

	public static ChatCustomer find(String member)
	{
		return (ChatCustomer) customer.get(member);
	}

	public static java.util.Enumeration findByTo(String to, String communtiy)
	{
		java.util.Vector vector = new java.util.Vector();
		java.util.Enumeration enumer = customer.keys();
		while (enumer.hasMoreElements())
		{
			ChatCustomer obj = find((String) enumer.nextElement());
			if (communtiy.equals(obj.getCommunity()) && to.equals(obj.getTo()))
			{
				vector.addElement(obj.getMember());
			}
		}
		return vector.elements();
	}

	public static ChatCustomer create(String member, String nickname, String community, String to, String ip)
	{
		ChatCustomer obj = new ChatCustomer(member, nickname, community, to, ip);
		customer.put(member, obj);
		return obj;
	}

	public void delete()
	{
		customer.remove(member);
	}

	public String getMember()
	{
		return member;
	}

	public String getAddress()
	{
		if (address == null)
		{
			try 
			{
				address = tea.entity.node.access.NodeAccessWhere.findByIp(ip);
			} catch (SQLException ex)
			{
				address = "";
			}
		}
		return address;
	}

	public Date getTime()
	{
		return time;
	}

	public String getIp()
	{
		return ip;
	}

	public String getTo()
	{
		return to;
	}

	public String getNickname()
	{
		return nickname;
	}

	public String getCommunity()
	{
		return community;
	}

}
