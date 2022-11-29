package tea.entity.member;

import tea.entity.*;
import tea.entity.site.*;
import tea.db.*;
import java.sql.SQLException;
import java.net.*;

public class Vpopmail extends Entity
{
	private String domain;
	private String name;
	private String passwd;
	private boolean exists;

	public Vpopmail(String name, String domain) throws SQLException
	{
		this.name = name;
		this.domain = domain;
		load();
	}

	public static void create(String smtp, String name, String domain, String passwd) throws SQLException
	{
		DbAdapter db = new DbAdapter(2);
		try
		{
			passwd =((String) Entity.open("http://" + smtp + "/igenus/crypt.php?name=" + name + "&domain=" + domain + "&pwd=" + passwd)).trim();
			db.executeUpdate("INSERT INTO vpopmail(pw_name,pw_domain,pw_passwd,pw_uid,pw_gid,pw_gecos,pw_dir,pw_shell,pw_clear_passwd)VALUES(" + DbAdapter.cite(name) + "," + DbAdapter.cite(domain) + "," + DbAdapter.cite(passwd) + ",0,0," + DbAdapter.cite(name) + "," + DbAdapter.cite("/home/vpopmail/domains/" + domain + "/" + name) + "," + DbAdapter.cite("52428800") + "," + DbAdapter.cite("1234") + ")");
		} catch (Exception exception1)
		{
			throw new SQLException(exception1.toString());
		} finally
		{
			db.close();
		}
	}

	private void load() throws SQLException
	{
		DbAdapter db = new DbAdapter(2);
		try
		{
			db.executeQuery("SELECT pw_passwd FROM vpopmail WHERE pw_name=" + DbAdapter.cite(name) + " AND pw_domain=" + DbAdapter.cite(domain));
			if (db.next())
			{
				passwd = db.getString(1);
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

	public static Vpopmail find(String name, String domain) throws SQLException
	{
		return new Vpopmail(name, domain);
	}

	public String getDomain()
	{
		return domain;
	}

	public boolean isExists()
	{
		return exists;
	}

	public String getName()
	{
		return name;
	}

	public String getPasswd()
	{
		return passwd;
	}
}

/*
 *  <? $name=$_GET["name"]; $domain=$_GET["domain"]; $pwd=$_GET["pwd"];
 *
 * echo crypt($pwd);
 *  # $cmd="/home/vpopmail/bin/vpasswd ".$name." ".$pwd; # system($cmd); # echo $cmd;
 *
 * #/qmail/vpopmail-5.2.1/vpasswd
 *
 * if(!is_dir("/home/vpopmail/domains/".$domain."/".$name)) { mkdir("/home/vpopmail/domains/".$domain."/".$name); mkdir("/home/vpopmail/domains/".$domain."/".$name."/Maildir/"); mkdir("/home/vpopmail/domains/".$domain."/".$name."/Maildir/cur/"); mkdir("/home/vpopmail/domains/".$domain."/".$name."/Maildir/new/"); mkdir("/home/vpopmail/domains/".$domain."/".$name."/Maildir/tmp/"); }
 *  ?>
 *
 */
