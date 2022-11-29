package tea.service;

import java.awt.Frame;
import java.io.*;
import java.math.BigDecimal;
import java.net.URL;
import java.net.URLConnection;
import java.util.*;
import tea.entity.node.*;
import tea.entity.site.*;
import tea.entity.*;
import tea.entity.admin.*;
import org.w3c.dom.Document;
import tea.entity.member.*;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import org.w3c.dom.NodeList;
import tea.db.DbAdapter;
import tea.db.*;
import tea.entity.util.*;
import tea.service.oasms.SmsServices;

public class ServiceThread extends java.lang.Thread
{
    public static boolean _blStarted = false;
    public ServiceThread()
    {
    }


    java.util.Hashtable h = new java.util.Hashtable();
    public void run()
    {

    }

    public void recursion(int node, java.net.URL url)
    {
        try
        {
            java.io.InputStream is = url.openStream();
            int value = 0;
            StringBuilder sb = new StringBuilder();
            while ((value = is.read()) != -1)
            {
                sb.append((char) (value));
            }
            is.close();
        } catch (IOException ex)
        {
        }

    }

    public static java.io.File dir;
    static
    {
        try
        {
            dir = new java.io.File(Http.REAL_PATH);
        } catch (Exception ex)
        {
            ex.printStackTrace();
            System.exit( -1);
        }
    }

    public static void activateRoboty()
    {
        if (!_blStarted)
        {
            _blStarted = true;

            //生成html
//            MakeHtml makeHtml = new MakeHtml();
//            makeHtml.start();

            //短信自动回复
            SmsServiceAuto smsServiceAuto = new SmsServiceAuto();
            smsServiceAuto.start();

            //节点内容自动添加链接
            //        NodeLinkText2 nodeLinkText2 = new NodeLinkText2();
            //        nodeLinkText2.start();

            //网络硬盘空间检查
            //        NetDiskSize nds = new NetDiskSize();
            //        nds.start();
        }
    }

    /*public static void main(String args[])
    {
        activateRoboty();
    }*/
}


class MakeHtml extends java.lang.Thread
{
    String path;
    public MakeHtml()
    {
        path = ServiceThread.dir.getAbsolutePath() + java.io.File.separator + "tea" + java.io.File.separator + "node" + java.io.File.separator;
    }

    public void run()
    {
        while (true)
        {
            java.util.Calendar c = java.util.Calendar.getInstance();
            int hour = c.get(java.util.Calendar.HOUR_OF_DAY);
            if (hour >= 0 && hour < 5)
            {
                tea.db.DbAdapter db = new tea.db.DbAdapter();
                try
                {
                    db.executeQuery("SELECT DISTINCT n.node,d.domainname FROM Node n,Community c,DNS d WHERE n.community=c.community AND c.type!=0 AND d.community=c.community ORDER BY n.node DESC");
                    while (hour >= 0 && hour < 5 && db.next())
                    {
                        int node = db.getInt(1);
                        tea.entity.node.Node obj = tea.entity.node.Node.find(node);
                        switch (obj.getType())
                        {
                        case 2: //Page
                            if ((obj.getOptions1() & 1) != 0)
                            {
                                continue;
                            }
                            break;
                        }
                        if ((obj.getOptions() & 0x1000) == 0 && !new java.io.File(path + obj.getCommunity() + "/N" + node + "L" + obj.getDefaultLanguage() + "PnullLnull.html").exists() && !new java.io.File(path + obj.getCommunity() + "/N" + node + "L" + obj.getDefaultLanguage() + "PnullLnull_jsp.html").exists())
                        {
                            try
                            {
                                System.out.println(" 节点:" + node + " 社区:" + obj.getCommunity() + " 访问量:" + obj.getClick());
                                java.net.URL url = new java.net.URL("http://" + db.getString(2) + "/servlet/Node?Node=" + node);
                                java.io.InputStream is = url.openStream();
                                is.read();
                                is.close();
                                Thread.sleep(1000L);
                            } catch (Exception ex)
                            {
                                ex.printStackTrace();
                                Thread.sleep(1000L * 100);
                            }
                        }
                        c = java.util.Calendar.getInstance();
                        hour = c.get(java.util.Calendar.HOUR_OF_DAY);
                    }
                } catch (Exception ex)
                {
                    ex.printStackTrace();
                } finally
                {
                    db.close();
                }
            }
            try
            {
                this.sleep(1000L * 60 * 60);
            } catch (InterruptedException ex2)
            {
            }
        }
    }
}


class NodeLinkText2 extends java.lang.Thread
{

    public NodeLinkText2()
    {
    }

    public void run()
    {
        while (true)
        {
            java.util.Calendar c = java.util.Calendar.getInstance();
            int hour = c.get(java.util.Calendar.HOUR_OF_DAY);
            if (hour >= 0 && hour < 5)
            {
                tea.db.DbAdapter db = new tea.db.DbAdapter();
                try
                {
                    db.executeQuery("SELECT n.node,n.community,n.style,n.root,nl.language," + db.length("nl.content") + "(),nl.content FROM Node n,NodeLayer nl WHERE n.node=nl.node AND n.style!=0 AND " + db.length("content") + ">0 ORDER BY " + db.length("nl.content2") + ",n.node DESC");
                    while (hour >= 0 && hour < 5 && db.next())
                    {
                        int _nNode = db.getInt(1);
                        String _strCommunity = db.getString(2);
                        int _nStyle = db.getInt(3);
                        int _nRoot = db.getInt(4);
                        int _nLanguage = db.getInt(5);
                        String text2 = db.getText(_nLanguage, _nLanguage, 6);
                        String sql = null;
                        switch (_nStyle)
                        {
                        case 1:
                            sql = " n.path LIKE '%/" + _nNode + "/%'";
                            break;
                        case 2:
                            sql = " n.community=" + DbAdapter.cite(_strCommunity);
                            break;
                        case 3:
                            sql = " n.path LIKE '%/" + _nRoot + "/%'";
                            break;
                        }
                        int len = text2.length();
                        DbAdapter db2 = new DbAdapter();
                        try
                        {
                            db2.executeQuery("SELECT n.node,n.type,nl.subject FROM Node n,NodeLayer nl WHERE n.node=nl.node AND DATALENGTH(nl.subject)>3 AND nl.language=" + _nLanguage + " AND " + sql);
                            while (db2.next())
                            {
                                int _nNode2 = db2.getInt(1);
                                int _nType2 = db2.getInt(2);
                                String subject2 = db2.getVarchar(_nLanguage, _nLanguage, 3);
                                if (text2.indexOf(subject2) != -1)
                                {
                                    String name;
                                    if (_nType2 >= 1024)
                                    {
                                        name = "Node";
                                    } else
                                    {
                                        name = tea.entity.node.Node.NODE_TYPE[_nType2];
                                    }
                                    text2 = (text2.replaceAll(subject2, "<A TARGET='_blank' HREF=\"" + name + "?Node=" + _nNode + "\">" + subject2 + "</A>"));
                                }
                            }
                            if (len < text2.length())
                            {
                                System.out.println("自动添加链接:" + _nNode);
                                db2.executeUpdate("UPDATE NodeLayer SET content2=" + db2.cite(text2) + " WHERE node=" + _nNode + " AND language=" + _nLanguage);
                            }
                        } finally
                        {
                            db2.close();
                        }
                        try
                        {
                            Thread.sleep(1000L);
                        } catch (Exception ex)
                        {
                            ex.printStackTrace();
                            Thread.sleep(1000L * 100);
                        }
                        c = java.util.Calendar.getInstance();
                        hour = c.get(java.util.Calendar.HOUR_OF_DAY);
                    }
                } catch (Exception ex)
                {
                    ex.printStackTrace();
                } finally
                {
                    db.close();
                }
            }
            try
            {
                this.sleep(1000L * 60 * 60);
            } catch (InterruptedException ex2)
            {
            }
        }
    }
}


class NetDiskSize extends java.lang.Thread
{
    public NetDiskSize()
    {}

    //网络硬盘
    public void run()
    {
//        int index = 0;
//        while (true)
//        {
//            System.out.println("网络硬盘:" + index++);
//            Enumeration e=Community.find("", 0, Integer.MAX_VALUE);
//            while(e.hasMoreElements())
//                {
//                String community=(String)e.nextElement();
//                    System.out.println("网络硬盘:" + community);
//                    try
//                    {
//                        int single = NetDiskSize.getSingleByMember(files[i].getName());
//                        checkSingle(files[i], single); //检查单个文件大小
//                        if (count > 0) //检查文件总数>0
//                        {
//                            int sum = tea.entity.admin.NetDiskSize.getSumByMember(files[i].getName());
//                            long size = tea.entity.admin.NetDiskSize.getSizeByMember(files[i].getName());
//                            checkSum(files[i], count - sum, useSize - size);
//                        }
//                    } catch (SQLException ex)
//                    {
//                        ex.printStackTrace();
//                    }
//                }
//           try
//            {
//                this.sleep(1000L * 60 * 60);
//            } catch (InterruptedException ex2)
//            {
//            }
//        }
    }

    int count = 0;
    long useSize = 0L;
    public void checkSingle(java.io.File file, int single)
    {
        java.io.File files[] = file.listFiles();
        if (files != null)
        {
            for (int index = 0; index < files.length; index++)
            {
                if (files[index].isFile())
                {
                    if (files[index].length() / 1024 > single)
                    {
                        files[index].delete();
                    } else
                    {
                        useSize += (files[index].length() / 1024);
                        count++;
                    }
                } else
                {
                    count++;
                    checkSingle(files[index], single);
                }
            }
        }
    }

    public void checkSum(java.io.File file, int count, long size)
    {
        if (count > 1 || size > 1)
        {
            java.io.File files[] = file.listFiles();
            if (files != null)
            {
                for (int index = 0; index < files.length; index++)
                {
                    if (files[index].isFile())
                    {
                        if (count > 1 || size > 1)
                        {
                            size -= (files[index].length() / 1024);
                            if (files[index].delete())
                            {
                                --count;
                            }
                        } else
                        {
                            return;
                        }
                    } else
                    {
                        checkSum(files[index], count, size);
                    }
                }
            } else
            {
                if (file.delete())
                {
                    --count;
                }
            }
        }
    }

}


class SmsServiceAuto extends java.lang.Thread
{
    public static final java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
    public SmsServiceAuto()
    {}

    //自动回复
    public void run()
    {
        int index = 0;
        while (true)
        {
            System.out.println("短信自动回复:" + index++);
            try
            {
                java.util.Enumeration enumer = SMSProfile.findByAuto();
                while (enumer.hasMoreElements())
                {
                    try
                    {
                        tea.entity.RV rv = (tea.entity.RV) enumer.nextElement();
                        String member = rv._strR;
                        String community = "......";////////err
                        String value = SMSMessage.findReverseByMember(member, community);
                        if (value.length() > 0)
                        {
                            DocumentBuilderFactory domfac = DocumentBuilderFactory.newInstance();

                            DocumentBuilder dombuilder = domfac.newDocumentBuilder();
                            InputStream is = (InputStream) (new ByteArrayInputStream(value.getBytes("UTF-8")));
                            Document doc = dombuilder.parse(is);
                            NodeList msgs = doc.getElementsByTagName("tr");
                            if (msgs != null)
                            {
                                for (int i = 0; i < msgs.getLength(); i++)
                                {
                                    org.w3c.dom.Node msg = msgs.item(i);
                                    if (msg.getNodeType() == org.w3c.dom.Node.ELEMENT_NODE)
                                    {
                                        String number = null, time = null, DestTerm = null, content = null;
                                        int count = 0;
                                        for (org.w3c.dom.Node node = msg.getFirstChild(); node != null; node = node.getNextSibling())
                                        {
                                            if (node.getNodeType() == org.w3c.dom.Node.ELEMENT_NODE)
                                            {
                                                switch (count++)
                                                {
                                                case 0:
                                                    number = node.getFirstChild().getNodeValue();
                                                    break;
                                                case 1:
                                                    content = node.getFirstChild().getNodeValue();
                                                    break;
                                                case 2:
                                                    time = node.getFirstChild().getNodeValue();
                                                    break;
                                                }
                                            }
                                        }
                                        /////////
                                        content = "回复人:" + number + "信息:" + content;
                                        if (content.length() > 70)
                                        {
                                            content = content.substring(0, 70);
                                        }
                                        java.util.Date time2 = sdf.parse(time);
                                        tea.entity.member.SMSProfile smsprofile = tea.entity.member.SMSProfile.find(member, community);

//                                       小于12小时,并且此信息没有自动回复过
                                        if ((System.currentTimeMillis() - time2.getTime()) < 1000L * 60 * 60 * 12 && !SMSMessage.isExists(smsprofile.getCode(), time2, number)) //判断是否已经回复了信息
                                        {
                                            tea.entity.member.Profile profile = tea.entity.member.Profile.find(member);
                                            String result = SMSMessage.send(member, 1, profile.getMobile(), content, true, profile.getCommunity(), 2, sdf.parse(time));
                                            System.out.println(result);
                                        }
                                    }

                                }
                            }
                        }
                    } catch (Exception ex)
                    {
                        ex.printStackTrace();
                    }
                }
            } catch (Exception ex1)
            {
                ex1.printStackTrace();
            }
            try
            {
                this.sleep(1000L * 10);
            } catch (InterruptedException ex2)
            {
            }
        }
    }
}
