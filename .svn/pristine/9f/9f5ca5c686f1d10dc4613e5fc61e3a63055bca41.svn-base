package tea.ui.util;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.*;
import tea.db.*;
import tea.entity.node.*;
import org.htmlparser.util.ParserException;

public class ReplaceData extends TeaServlet
{
    public void init() throws ServletException
    {
    }

    //Process the HTTP Get request
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            TeaSession teasession = new TeaSession(request);
            if (teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode + "&NextUrl=" + java.net.URLEncoder.encode(request.getRequestURI() + "?" + request.getQueryString(), "UTF-8"));
                return;
            }

            long lo = System.currentTimeMillis();
            String find = request.getParameter("find");
            String find2 = DbAdapter.cite("%" + find + "%");

            String replace = request.getParameter("replace");

            int nodecount = 0, listingcount = 0, sectioncount = 0;
            DbAdapter dbadapter = new DbAdapter();
            DbAdapter dbadapter2 = new DbAdapter();
            try
            {
                if (request.getParameter("replacetext") != null)
                {
                    if (request.getParameter("node") != null)
                    {
                        //      nodecount=dbadapter.executeUpdate("UPDATE NodeLayer SET subject=REPLACE(subject,"+find+","+replace+"),keywords=REPLACE(keywords,"+find+","+replace+") WHERE node IN (SELECT node FROM Node WHERE community="+DbAdapter.cite(community)+") AND(subject LIKE "+find2+" OR keywords LIKE "+find2+")");
                        //      dbadapter.executeUpdate("UPDATE NodeLayer SET content=REPLACE(CAST(content AS NVARCHAR),"+find+","+replace+") WHERE node IN (SELECT node FROM Node WHERE community="+DbAdapter.cite(community)+") AND DATALENGTH(content)<4000 AND content LIKE "+find2);
                        //  System.out.println("SELECT node FROM NodeLayer WHERE language="+teasession._nLanguage+" AND node IN (SELECT node FROM Node WHERE community="+DbAdapter.cite(community)+") AND(subject LIKE "+find2+" OR keywords LIKE "+find2+" OR content LIKE "+find2+")");
                        dbadapter.executeQuery("SELECT nl.node FROM NodeLayer nl INNER JOIN Node n ON nl.node=n.node WHERE nl.language=" + teasession._nLanguage + " AND n.community=" + DbAdapter.cite(teasession._strCommunity) + " AND(nl.subject LIKE " + find2 + " OR nl.keywords LIKE " + find2 + " OR nl.content LIKE " + find2 + ")");
                        while (dbadapter.next())
                        {
                            int node = dbadapter.getInt(1);
                            System.out.println("node:" + node);
                            Node obj = Node.find(node);
                            String subject = obj.getSubject(teasession._nLanguage);
                            subject = subject.replaceAll(find, replace);
                            //  obj.setSubject(subject,teasession._nLanguage);

                            String keywords = obj.getKeywords(teasession._nLanguage);
                            keywords = keywords.replaceAll(find, replace);
                            //  obj.setKeywords(keywords,teasession._nLanguage);

                            String content = obj.getText(teasession._nLanguage);
                            content = content.replaceAll(find, replace);
                            //  obj.setText(content,teasession._nLanguage);

                            dbadapter2.executeUpdate("UPDATE NodeLayer SET [subject]=" + DbAdapter.cite(subject) + ",[keywords]=" + DbAdapter.cite(keywords) + ",[content]=" + DbAdapter.cite(content) + " WHERE node=" + node + " AND language=" + teasession._nLanguage);
                            nodecount++;
                        }

                        ///////////新闻资讯//////////////
                        dbadapter.executeQuery("SELECT node FROM Report WHERE language=" + teasession._nLanguage + " AND node IN (SELECT node FROM Node WHERE community=" + DbAdapter.cite(teasession._strCommunity) + ") AND(logograph LIKE " + find2 + " OR locus LIKE " + find2 + ")");
                        while (dbadapter.next())
                        {
                            int node = dbadapter.getInt(1);
                            System.out.println("report:" + node);
                            Report obj = Report.find(node);
                            String locus = obj.getLocus(teasession._nLanguage);
                            locus = locus.replaceAll(find, replace);

                            String logograph = obj.getLogograph(teasession._nLanguage);
                            logograph = logograph.replaceAll(find, replace);

                            dbadapter2.executeUpdate("UPDATE Report SET [logograph]=" + DbAdapter.cite(logograph) + ",[locus]=" + DbAdapter.cite(locus) + " WHERE node=" + node + " AND language=" + teasession._nLanguage);
                            nodecount++;
                        }
                    }
                    if (request.getParameter("listing") != null)
                    {
                        //      //listingcount=dbadapter.executeUpdate("UPDATE ListingLayer SET name=REPLACE(name,"+find+","+replace+"),beforeitem=REPLACE(CAST(beforeitem AS NVARCHAR),"+find+","+replace+"),afteritem=REPLACE(CAST(afteritem AS NVARCHAR),"+find+","+replace+"),beforedetail=REPLACE(CAST(beforedetail AS NVARCHAR),"+find+","+replace+"),separatordetail=REPLACE(CAST(separatordetail AS NVARCHAR),"+find+","+replace+"),afterdetail=REPLACE(CAST(afterdetail AS NVARCHAR),"+find+","+replace+"),beforechild=REPLACE(CAST(beforechild AS NVARCHAR),"+find+","+replace+"),     afterchild=REPLACE(CAST(afterchild AS NVARCHAR),"+find+","+replace+"),     beforechilddetail=REPLACE(CAST(beforechilddetail AS NVARCHAR),"+find+","+replace+"),     separatorchilddetail=REPLACE(CAST(separatorchilddetail AS NVARCHAR),"+find+","+replace+"),     afterchilddetail=REPLACE(CAST(afterchilddetail AS NVARCHAR),"+find+","+replace+"),     beforelisting=REPLACE(CAST(beforelisting AS NVARCHAR),"+find+","+replace+"),     afterlisting=REPLACE(CAST(afterlisting AS NVARCHAR),"+find+","+replace+") WHERE listing IN (SELECT DISTINCT l.listing FROM Node n,Listing l WHERE n.node=l.node AND n.community="+DbAdapter.cite(teasession._strCommunity)+") AND DATALENGTH(beforeitem)<4000 AND DATALENGTH(afteritem)<4000");
                        //      listingcount=dbadapter.executeUpdate("UPDATE ListingLayer SET beforelisting=REPLACE(CAST(beforelisting AS NVARCHAR),"+find+","+replace+"),afterlisting=REPLACE(CAST(afterlisting AS NVARCHAR),"+find+","+replace+") WHERE listing IN (SELECT DISTINCT l.listing FROM Node n,Listing l WHERE n.node=l.node AND n.community="+DbAdapter.cite(teasession._strCommunity)+") AND DATALENGTH(beforelisting)<4000 AND DATALENGTH(afterlisting)<4000");
                        //      listingcount+=dbadapter.executeUpdate("UPDATE ListingDetail SET BeforeItem=REPLACE(CAST(BeforeItem AS NVARCHAR),"+find+","+replace+"),AfterItem=REPLACE(CAST(AfterItem AS NVARCHAR),"+find+","+replace+") WHERE Listing IN (SELECT DISTINCT l.listing FROM Node n,Listing l WHERE n.node=l.node AND n.community="+DbAdapter.cite(teasession._strCommunity)+") AND DATALENGTH(BeforeItem)<4000 AND DATALENGTH(AfterItem)<4000");
                        dbadapter.executeQuery("SELECT ll.listing FROM ListingLayer ll WHERE ll.language=" + teasession._nLanguage + " AND ll.listing IN ( SELECT l.listing FROM Listing l INNER JOIN Node n ON l.node=n.node AND n.community=" + DbAdapter.cite(teasession._strCommunity) + " )  AND(ll.beforelisting LIKE " + find2 + " OR ll.afterlisting LIKE " + find2 + ")");
                        while (dbadapter.next())
                        {
                            int listing = dbadapter.getInt(1);
                            System.out.println("listing:" + listing);
                            Listing obj = Listing.find(listing);
                            String beforelisting = obj.getBeforeListing(teasession._nLanguage);
                            beforelisting = beforelisting.replaceAll(find, replace);
                            //  obj.set(subject,teasession._nLanguage);
                            //
                            String afterlisting = obj.getAfterListing(teasession._nLanguage);
                            afterlisting = afterlisting.replaceAll(find, replace);
                            //  obj.setKeywords(keywords,teasession._nLanguage);
                            //
                            //  String content=obj.getText(teasession._nLanguage);
                            //  content=content.replaceAll(find,replace);
                            //  obj.setText(content,teasession._nLanguage);
                            dbadapter2.executeUpdate("UPDATE ListingLayer SET [beforelisting]=" + DbAdapter.cite(beforelisting) + ",[afterlisting]=" + DbAdapter.cite(afterlisting) + " WHERE listing=" + listing + " AND language=" + teasession._nLanguage);
                            listingcount++;
                        }

                        dbadapter.executeQuery("SELECT Listing,Type,Itemname FROM ListingDetail WHERE language=" + teasession._nLanguage + " AND Listing IN (SELECT l.listing FROM Listing l INNER JOIN Node n ON l.node=n.node AND n.community=" + DbAdapter.cite(teasession._strCommunity) + ") AND(BeforeItem LIKE " + find2 + " OR AfterItem LIKE " + find2 + ")");
                        while (dbadapter.next())
                        {
                            int listing = dbadapter.getInt(1);
                            System.out.println("listingdetail:" + listing);
                            int type = dbadapter.getInt(2);
                            String itemname = dbadapter.getString(3);

                            ListingDetail obj = ListingDetail.find(listing, type,  teasession._nLanguage);
                            String beforelisting = obj.getBeforeItem(itemname);
                            beforelisting = beforelisting.replaceAll(find, replace);

                            String afterlisting = obj.getAfterItem(itemname);
                            afterlisting = afterlisting.replaceAll(find, replace);

                            dbadapter2.executeUpdate("UPDATE ListingDetail SET [BeforeItem]=" + DbAdapter.cite(beforelisting) + ",[AfterItem]=" + DbAdapter.cite(afterlisting) + " WHERE Listing=" + listing + " AND Type=" + type + " AND Itemname=" + itemname + " AND language=" + teasession._nLanguage);
                            listingcount++;
                        }
                    }
                    if (request.getParameter("section") != null)
                    {
                        dbadapter.executeQuery("SELECT sl.section FROM SectionLayer sl WHERE sl.language=" + teasession._nLanguage + " AND sl.section IN ( SELECT s.section FROM Section s INNER JOIN Node n ON s.node=n.node AND n.community=" + DbAdapter.cite(teasession._strCommunity) + " ) AND [text] LIKE " + find2);
                        while (dbadapter.next())
                        {
                            int section = dbadapter.getInt(1);
                            System.out.println("section:" + section);
                            Section obj = Section.find(section);
                            String content = obj.getText(teasession._nLanguage);
                            content = content.replaceAll(find, replace);
                            dbadapter2.executeUpdate("UPDATE SectionLayer SET [text]=" + DbAdapter.cite(content) + " WHERE section=" + section + " AND language=" + teasession._nLanguage);
                            sectioncount++;
                        }
                    }
                } else ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                {
                    if (request.getParameter("node") != null)
                    {
                        dbadapter.executeQuery("SELECT nl.node,nl.content FROM NodeLayer nl INNER JOIN Node n ON nl.node=n.node WHERE nl.language=" + teasession._nLanguage + " AND n.community=" + DbAdapter.cite(teasession._strCommunity));
                        while (dbadapter.next())
                        {
                            int node = dbadapter.getInt(1);
                            String content = dbadapter.getString(2);
                            int len = content.length();
                            System.out.println("node:" + node);
                            content = replaceimg(content, request.getServerName(), teasession._strCommunity);
                            if (len != content.length())
                            {
                                dbadapter2.executeUpdate("UPDATE NodeLayer SET [content]=" + DbAdapter.cite(content) + " WHERE node=" + node + " AND language=" + teasession._nLanguage);
                                nodecount++;
                            }
                        }
                    }
                    if (request.getParameter("listing") != null)
                    {
                        dbadapter.executeQuery("SELECT ll.listing,ll.beforelisting,ll.afterlisting FROM ListingLayer ll WHERE ll.language=" + teasession._nLanguage + " AND ll.listing IN ( SELECT l.listing FROM Listing l INNER JOIN Node n ON l.node=n.node AND n.community=" + DbAdapter.cite(teasession._strCommunity) + " ) ");
                        while (dbadapter.next())
                        {
                            int listing = dbadapter.getInt(1);
                            System.out.println("listing:" + listing);
                            String beforelisting = dbadapter.getString(2);
                            int bl_len = beforelisting.length();
                            String afterlisting = dbadapter.getString(3);
                            int al_len = afterlisting.length();

                            beforelisting = replaceimg(beforelisting, request.getServerName(), teasession._strCommunity);
                            afterlisting = replaceimg(afterlisting, request.getServerName(), teasession._strCommunity);
                            if (bl_len != beforelisting.length() || al_len != afterlisting.length())
                            {
                                dbadapter2.executeUpdate("UPDATE ListingLayer SET [beforelisting]=" + DbAdapter.cite(beforelisting) + ",[afterlisting]=" + DbAdapter.cite(afterlisting) + " WHERE listing=" + listing + " AND language=" + teasession._nLanguage);
                                listingcount++;
                            }
                        }

                        dbadapter.executeQuery("SELECT Listing,Type,Itemname,BeforeItem,AfterItem FROM ListingDetail WHERE language=" + teasession._nLanguage + " AND Listing IN ( SELECT l.listing FROM Listing l INNER JOIN Node n ON l.node=n.node AND n.community=" + DbAdapter.cite(teasession._strCommunity) + " ) ");
                        while (dbadapter.next())
                        {
                            int listing = dbadapter.getInt(1);
                            System.out.println("listingdetail:" + listing);
                            int type = dbadapter.getInt(2);
                            String itemname = dbadapter.getString(3);
                            String beforeitem = dbadapter.getString(4);
                            int bi_len = beforeitem.length();
                            String afteritem = dbadapter.getString(5);
                            int ai_len = afteritem.length();

                            beforeitem = replaceimg(beforeitem, request.getServerName(), teasession._strCommunity);
                            afteritem = replaceimg(afteritem, request.getServerName(), teasession._strCommunity);
                            if (bi_len != beforeitem.length() || ai_len != afteritem.length())
                            {
                                dbadapter2.executeUpdate("UPDATE ListingDetail SET [BeforeItem]=" + DbAdapter.cite(beforeitem) + ",[AfterItem]=" + DbAdapter.cite(afteritem) + " WHERE Listing=" + listing + " AND Type=" + type + " AND Itemname=" + itemname + " AND language=" + teasession._nLanguage);
                                listingcount++;
                            }
                        }
                    }
                    if (request.getParameter("section") != null)
                    {
                        dbadapter.executeQuery("SELECT sl.section,sl.text FROM SectionLayer sl WHERE sl.language=" + teasession._nLanguage + " AND sl.section IN ( SELECT s.section FROM Section s INNER JOIN Node n ON s.node=n.node AND n.community=" + DbAdapter.cite(teasession._strCommunity) + " ) ");
                        while (dbadapter.next())
                        {
                            int section = dbadapter.getInt(1);
                            System.out.println("section:" + section);
                            String content = dbadapter.getString(2);
                            int c_len = content.length();

                            content = replaceimg(content, request.getServerName(), teasession._strCommunity);
                            if (c_len != content.length())
                            {
                                dbadapter2.executeUpdate("UPDATE SectionLayer SET [text]=" + DbAdapter.cite(content) + " WHERE section=" + section + " AND language=" + teasession._nLanguage);
                                sectioncount++;
                            }
                        }
                    }
                }
            } catch (Exception e)
            {
                e.printStackTrace();
            } finally
            {
                dbadapter.close();
                dbadapter2.close();
            }
            lo = System.currentTimeMillis() - lo;
            response.sendRedirect("/jsp/info/Succeed.jsp?info=" + java.net.URLEncoder.encode("数据替换数列表:<BR>节点:" + nodecount + "<BR>列举:" + listingcount + "<BR>段落:" + sectioncount + "<BR>消耗时间:" + lo, "UTF-8"));
        } catch (Exception e)
        {
            e.printStackTrace();
        }
    }

    public byte[] read(java.net.URL url) throws IOException
    {
        java.net.URLConnection conn = url.openConnection();
        java.io.InputStream is = conn.getInputStream();
        int len = conn.getContentLength();
        if (len != -1)
        {
            byte by[] = new byte[len];
            is.read(by);
            is.close();
            return (by);
        } else
        {
            StringBuilder sb = new StringBuilder();
            int value = is.read();
            while (value != -1)
            {
                sb.append((char) value);
                value = is.read();
            }
            is.close();
            return sb.toString().getBytes("ISO-8859-1");
        }
    }

    public String replaceimg(String content, String sn, String community) throws Exception
    {
        org.htmlparser.NodeFilter imgfilter = new org.htmlparser.filters.NodeClassFilter(Class.forName("org.htmlparser.tags.ImageTag"));
        org.htmlparser.Parser p = new org.htmlparser.Parser();
        p.setInputHTML(content);
        org.htmlparser.util.NodeList nl = p.extractAllNodesThatMatch(imgfilter);
        for (int index = 0; index < nl.size(); index++)
        {
            org.htmlparser.tags.ImageTag it = (org.htmlparser.tags.ImageTag) nl.elementAt(index);
            String src = it.getAttribute("SRC");
            System.out.println("IMG:" + src);
            String src_lc = src.toLowerCase();
            if (src_lc.startsWith("http://" + sn))
            {

            } else
            if (src_lc.startsWith("http://"))
            {
                try
                {
                    byte by[] = read(new java.net.URL(src));
                    String str = super.write(community, by, ".gif");
                    content = content.replaceAll(src, str);
                } catch (Exception ex)
                {
                    System.out.println("错误:" + src);
                }
            }
        }
        return content;
    }

    //Clean up resources
    public void destroy()
    {
    }
}
