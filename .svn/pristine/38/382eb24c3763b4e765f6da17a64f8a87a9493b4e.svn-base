package tea.service;

import java.io.*;
import java.util.*;
import javax.mail.*;

import javax.mail.internet.*;
import javax.activation.DataHandler;
import java.util.regex.*;
import tea.entity.RV;
import tea.entity.member.*;
import tea.entity.admin.*;
import tea.resource.*;
import tea.entity.*;
import tea.http.ByteArrayDataSource;
import tea.entity.site.*;
import java.util.*;
import tea.db.*;
import java.net.HttpURLConnection;

public class SendEmaily
{
	public String smtpServer;
	public String smtpname;
	public final String smtpuser;
	public final String password;
	public String _strCommunity;

	/*
	 * public SendEmaily(String smtpServer) { this.smtpServer = smtpServer; }
	 */
	public SendEmaily(String _strCommunity) throws Exception
	{
		Community community = Community.find(_strCommunity);
		this._strCommunity = _strCommunity;
		this.smtpServer = community.getSmtp();
		this.smtpuser = community.getSmtpUser();
		this.password = community.getSmtpPassword();
		this.smtpname = community.getSmtpName();
	}

	public SendEmaily(int i) throws Exception
	{
		Community community = Community.find(i);
		this._strCommunity = _strCommunity;
		this.smtpServer = community.getSmtp();
		this.smtpuser = community.getSmtpUser();
		this.password = community.getSmtpPassword();
		this.smtpname = community.getSmtpName();
	}

	public String decode(String content)
	{
		// 编码转换
		StringBuilder sb = new StringBuilder();
		for(int index = 0;index < content.length();index++)
		{
			int value = (int) content.charAt(index);
			if(value > 128)
			{
				sb.append("&#" + value + ";");
			} else
			{
				sb.append((char) value);
			}
		}
		return sb.toString();
	}

	public void sendEmail(String to,String subject,String content)
	{
		sendEmail(null,to,subject,content);
	}

	public void sendEmail(String from,String to,String subject,String content)
	{
		java.util.Properties properties = System.getProperties();
		properties.put("mail.smtp.host",smtpServer);
		properties.put("mail.smtp.auth","true");
		Session session = Session.getInstance(properties,new Authenticator()
		{
			public PasswordAuthentication getPasswordAuthentication()
			{
				return new PasswordAuthentication(smtpuser,password);
			}
		});
		MimeMessage mm = new MimeMessage(session);
		try
		{
			if(from == null)
			{
				mm.setFrom(new InternetAddress(smtpuser,smtpname));
			} else
			{
				mm.setFrom(new InternetAddress(from));
			}
			to = to.replace(',',';');
			StringTokenizer stringtokenizer = new StringTokenizer(to,"; ");
			int l = stringtokenizer.countTokens();

			InternetAddress ainternetaddress[] = new InternetAddress[l];
			for(int k1 = 0;stringtokenizer.hasMoreTokens();k1++)
			{
				String s12 = stringtokenizer.nextToken();
				ainternetaddress[k1] = new InternetAddress(s12);
			}
			mm.addRecipients(javax.mail.Message.RecipientType.TO,ainternetaddress);

			mm.setSubject(subject,"UTF-8");
			mm.setSentDate(new java.util.Date());

			mm.setContent(content,"text/html; charset=UTF-8");

			// 发送附件/////////////////
			// Matcher m = Pattern.compile("src=\"([^>\"]+)\"", Pattern.CASE_INSENSITIVE).matcher(content);
			// java.util.Hashtable h = new java.util.Hashtable();
			// int cid_len = 0;
			// while (m.find())
			// {
			// String url = m.group(1);
			// // System.out.println(url);
			// String cid_url = url.replace('/', '_').replace(':', '_');
			// try
			// {
			// if (h.get(url) == null)
			// {
			// java.net.URL u = new java.net.URL(url);
			// java.net.HttpURLConnection conn = (HttpURLConnection) u.openConnection();
			// conn.setConnectTimeout(5000);
			// java.io.InputStream is = conn.getInputStream();
			// byte by[] = new byte[conn.getContentLength()];
			// is.read(by);
			// is.close();
			//
			// FileOutputStream fos = new FileOutputStream("d:/aa_" + cid_len + ".jpg");
			// fos.write(by);
			// fos.close();
			//
			// MimeBodyPart mbp = new MimeBodyPart();
			// ByteArrayDataSource bytearraydatasource = new ByteArrayDataSource(by, u.getFile());
			// mbp.setDataHandler(new DataHandler(bytearraydatasource));
			// mbp.setFileName(bytearraydatasource.getName());
			// mbp.setHeader("Content-id", cid_url);
			// h.put(url, mbp);
			// }
			// content = content.substring(0, m.start(1) + cid_len) + "cid:" + cid_url + content.substring(m.end(1) + cid_len);
			// cid_len = cid_len + 4;
			// } catch (IOException ioe)
			// {
			// }
			// }
			// MimeBodyPart mbp = new MimeBodyPart();
			// mbp.setContent("﻿<HTML><HEAD><META http-equiv=Content-Type content=\"text/html; charset=UTF-8\"></HEAD><BODY>" + decode(content), "text/html;charset=UTF-8");
			//
			// MimeMultipart mm = new MimeMultipart("related");
			// mm.addBodyPart(mbp);
			//
			// java.util.Enumeration e = h.elements();
			// while (e.hasMoreElements())
			// {
			// mm.addBodyPart((MimeBodyPart) e.nextElement());
			// }
			// mm.setContent(mm);
			Transport.send(mm);

		} catch(Exception ex)
		{
			ex.printStackTrace();
		}
	}

	public int sendEmail_int(String to,String subject,String content)
	{
		return sendEmail_int(null,to,subject,content);
	}

	public int sendEmail_int(String from,String to,String subject,String content)
	{

		java.util.Properties properties = System.getProperties();
		properties.put("mail.smtp.host",smtpServer);
		properties.put("mail.smtp.auth","true");
		Session session = Session.getInstance(properties,new Authenticator()
		{
			public PasswordAuthentication getPasswordAuthentication()
			{
				return new PasswordAuthentication(smtpuser,password);
			}
		});
		MimeMessage mm = new MimeMessage(session);
		try
		{
			if(from == null)
			{
				mm.setFrom(new InternetAddress(smtpuser,smtpname));
			} else
			{
				mm.setFrom(new InternetAddress(from));
			}
			to = to.replace(',',';');
			StringTokenizer stringtokenizer = new StringTokenizer(to,"; ");
			int l = stringtokenizer.countTokens();

			InternetAddress ainternetaddress[] = new InternetAddress[l];
			for(int k1 = 0;stringtokenizer.hasMoreTokens();k1++)
			{
				String s12 = stringtokenizer.nextToken();
				ainternetaddress[k1] = new InternetAddress(s12);
			}
			mm.addRecipients(javax.mail.Message.RecipientType.TO,ainternetaddress);

			mm.setSubject(subject,"UTF-8");
			mm.setSentDate(new java.util.Date());

			mm.setContent(content,"text/html; charset=UTF-8");

			Transport.send(mm);

		} catch(Exception ex)
		{
			ex.printStackTrace();
			return 1;
		}
		return 0;
	}


	public void sendEmail(int i)
	{
		try
		{
			java.util.Properties properties = System.getProperties();
			if(smtpServer != null && smtpServer.length() > 0)
			{
				properties.put("mail.smtp.host",smtpServer);
			} else
			{
				properties.put("mail.smtp.host",License.getInstance().getSmtpServer());
			}
			properties.put("mail.smtp.auth","true");
			Session session = Session.getInstance(properties,new Authenticator()
			{
				public PasswordAuthentication getPasswordAuthentication()
				{
					return new PasswordAuthentication(smtpuser,password);
				}
			});
			session.setDebug(true);

			tea.entity.member.Message obj = tea.entity.member.Message.find(i);
			String community = obj.community;
			int k = 1;
			Profile profile = Profile.find(obj.member);
			String femail = profile.getEmail();

			System.out.println("MailFrom:" + profile.getMember() + "/" + femail);
			String s2 = obj.content;

			MimeMessage mm = new MimeMessage(session);
			mm.setFrom(new InternetAddress(femail,profile.getMember())); //
			mm.setSubject(obj.subject,"UTF-8");
			mm.setSentDate(obj.time);
			if(obj.attch.length() < 2)
			{
				mm.setContent("﻿<HTML><HEAD><META http-equiv=Content-Type content=\"text/html; charset=UTF-8\"></HEAD><BODY>" + s2,"text/html; charset=UTF-8"); // "text/html;charset=UTF-8"
			} else
			{
				MimeMultipart mmp = new MimeMultipart();
				MimeBodyPart mbp = new MimeBodyPart();
				mbp.setContent(s2,"text/html;charset=UTF-8");
				mmp.addBodyPart(mbp);
				String[] arr = obj.attch.split("[|]");
				for(int j = 1;j < arr.length;j++)
				{
					Attch a = Attch.find(Integer.parseInt(arr[j]));
					//
					File f = new File(Common.REAL_PATH + a.path);
					byte by[] = new byte[(int) f.length()];
					FileInputStream fis = new FileInputStream(f);
					fis.read(by);
					fis.close();
					//
					mbp = new MimeBodyPart();
					ByteArrayDataSource bads = new ByteArrayDataSource(by,a.name);
					mbp.setDataHandler(new DataHandler(bads));
					mbp.setFileName(bads.getName());
					mmp.addBodyPart(mbp);
				}
				mm.setContent(mmp);
			}
			Vector v = new Vector();

			String[] s4 = obj.tmember.split("[|]");
			for(int k1 = 1;k1 < s4.length;k1++)
			{
				String member = s4[k1];
				v.add(member);
			}
			// mm.addRecipients(javax.mail.Message.RecipientType.TO, (InternetAddress[]) v.toArray(new InternetAddress[v.size()]));

			String tunit = obj.tdept;
			if(tunit != null && tunit.length() > 1)
			{
				String ts[] = tunit.split("[|]");
				for(int j = 1;j < ts.length;j++)
				{
					int unit = Integer.parseInt(ts[i]);
					Enumeration e = AdminUnitSeq.findByCommunity(community,unit);
					while(e.hasMoreElements())
					{
						String member = (String) e.nextElement();
						if(v.indexOf(member) == -1)
						{
							v.add(member);
						}
					}
				}
			}
			Enumeration e = v.elements();
			while(e.hasMoreElements())
			{
				String member = (String) e.nextElement();
				if(member.indexOf("@") == -1)
				{
					member = Profile.find(member).getEmail();
				}
				if(member != null && member.indexOf("@") != -1)
				{
					mm.addRecipients(javax.mail.Message.RecipientType.TO,member);
				}
			}
			Transport.send(mm);
		} catch(Exception exception)
		{
			exception.printStackTrace();
		}
	}
}
