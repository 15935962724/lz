package tea.ui.node.general;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import java.net.*;
import tea.entity.*;
import tea.entity.node.*;
import org.htmlparser.util.ParserException;
import java.sql.SQLException;

public class ExportNodeToHtml extends HttpServlet
{
    private static final String CONTENT_TYPE = "text/html; charset=UTF-8";

    // Initialize global variables
    public void init() throws ServletException
    {
    }

    // Process the HTTP Get request
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType(CONTENT_TYPE);
        PrintWriter out = response.getWriter();
        out.println("<html>");
        out.println("<head><title>ExportNodeToHtml</title><link href=\"/tea/community.css\" rel=\"stylesheet\" type=\"text/css\"></head>");
        out.println("<body bgcolor=\"#ffffff\">");
        out.println("<p>导出中.....</p>");
        out.flush();
        scr = new StringBuilder("  <html>                                                                \r\n"
                                + "    <head>                                                              \r\n"
                                + "    </head>                                                             \r\n"
                                + "    <body>                                                              \r\n"
                                + "      <script type=''>                                                  \r\n"
                                + "                function setCookie(name, value) {                                                             \r\n"
                                + "        var expire = new Date();                                                                              \r\n"
                                + "        expire.setTime(expire.getTime() + 30*24*60*60*1000);                                                  \r\n"
                                + "        document.cookie = name + '=' + escape(value) + '; expires=' + expire.toGMTString() + '; path=/';      \r\n"
                                + "}                                                                                                             \r\n"
                                + "                                                                                                              \r\n"
                                + "function removeCookie(name) {                                                                                 \r\n"
                                + "        var expire = new Date();                                                                              \r\n"
                                + "        expire.setTime(expire.getTime() - 30*24*60*60*1000);                                                  \r\n"
                                + "                                                                                                              \r\n"
                                + "        document.cookie = name + '=' + escape('remove') + '; expires=' + expire.toGMTString() + '; path=/';   \r\n"
                                + "}                                                                                                             \r\n"
                                + "                                                                                                              \r\n"
                                + "function getCookie(name, value) {                                                                             \r\n"
                                + "        var search = name + '=';                                                                              \r\n"
                                + "        if (document.cookie.length > 0) {                                                                     \r\n"
                                + "                offset = document.cookie.indexOf(search);                                                     \r\n"
                                + "                if (offset != -1) {                                                                           \r\n"
                                + "                        offset += search.length;                                                               \r\n"
                                + "                        end = document.cookie.indexOf(';', offset); // set index of end of cookie value        \r\n"
                                + "                        if (end == -1)                                                                         \r\n"
                                + "                                end = document.cookie.length;                                                  \r\n"
                                + "                                                                                                               \r\n"
                                + "                        return unescape(document.cookie.substring(offset, end));                               \r\n"
                                + "                }                                                                                              \r\n"
                                + "        }                                                                                                      \r\n"
                                + "                                                                                                               \r\n"
                                + "        return value;                                                                                          \r\n"
                                + "}                                                                                                              \r\n"
                                + "      function getParameter(param)                                      \r\n"
                                + "      {                                                                 \r\n"
                                + "        var url= ''+document.location;                                  \r\n"
                                + "        var index=url.indexOf('?');                                     \r\n"
                                + "        url=url.substring(index+1);                                     \r\n"
                                + "        var args=url.split('&');                                        \r\n"
                                + "        for(i=0;i<args.length;i++)if(args[i].indexOf(param+'=')==0)return args[i].substring(param.length+1);                       \r\n"
                                + "        return null;                                                  \r\n"
                                + "      }                                                                 \r\n"
                                + "      var node=getParameter('node'); if(!node)node=getParameter('Node'); var pos=getParameter('pos');                                      \r\n"
                                + "      if(!node)node=getCookie('tea.Node','');                                  \r\n"
                                + "      setCookie('tea.Node',node);                                       \r\n"

                                + "      var language=getParameter('language');                            \r\n"
                                + "      if(!language)language=getCookie('tea.Language','');                          \r\n"
                                + "      if(language.length<=0)language='1';                                                   \r\n"
                                + "      setCookie('tea.Language',language);                               \r\n"
                                + "      switch(node)                                                      \r\n"
                                + "      {                                                                 \r\n");

        try
        {
            tea.ui.TeaSession teasession = new tea.ui.TeaSession(request);
            /*
             * String userHome = System.getProperty("user.home"); java.io.File dir = new java.io.File(userHome + "/ExportNodeToHtml" + System.currentTimeMillis() + teasession.hashCode()); if (!dir.exists()) { dir.mkdirs(); }
             */
            String path = "/res/" + teasession._strCommunity + "/temp/";
            java.io.File dir = new java.io.File(this.getServletContext().getRealPath(path));
            if(!dir.exists())
            {
                dir.mkdirs();
            }
            java.io.File file = java.io.File.createTempFile("Output",".zip",dir);
            java.util.zip.ZipOutputStream zos = new java.util.zip.ZipOutputStream(new java.io.FileOutputStream(file));

            findNode(zos,"",request,teasession._strCommunity,teasession._nNode,teasession._nLanguage,out);
            scr.append("      }                                                                  \r\n" + "       </script>                                                         \r\n" + "    </body>                                                              \r\n" + "  </html>                                                                ");
            for(int i = 0;i < Node.NODE_TYPE.length;i++)
            {
                zos.putNextEntry(new java.util.zip.ZipEntry("/servlet/" + Node.NODE_TYPE[i]));
                zos.write(scr.toString().getBytes());
            }
            zos.putNextEntry(new java.util.zip.ZipEntry("/servlet/Node"));
            zos.write(scr.toString().getBytes());
            zos.putNextEntry(new java.util.zip.ZipEntry("/servlet/SwitchLanguage"));
            zos.write(scr.toString().getBytes());
            zos.close();
            out.println(new tea.html.Anchor(request.getContextPath() + path + file.getName(),"下载"));
            out.println("</body>");
            out.println("</html>");
        } catch(Exception ex)
        {
            ex.printStackTrace();
			response.sendError(500,ex.toString());
        }
        out.close();
    }

    public void findNode(java.util.zip.ZipOutputStream zos,String path,javax.servlet.http.HttpServletRequest request,String community,int node,int language,PrintWriter out) throws Exception
    {
        zos.putNextEntry(new java.util.zip.ZipEntry(path + "/N" + node + "L" + language + "Pnull.html"));
        java.net.URL url = new java.net.URL("HTTP",request.getServerName(),request.getServerPort(),"/servlet/Node?node=" + node + "&language=" + language);
        String str = (String) Node.open(url.toString());
        zos.write(str.getBytes());
        parser(url,str,zos);
        scr.append("case '" + node + "':\r\n" + "window.location.replace('" + path + "/N" + node + "L'+language+'P'+pos+'.html');\r\n" + "break;\r\n");
        out.print(url.toString() + "<br/>");
        out.flush();

        java.util.Enumeration enumer = Node.findSons(node);
        while(enumer.hasMoreElements())
        {
            int sonNode = ((Integer) enumer.nextElement()).intValue();
            findNode(zos,path + "/" + sonNode,request,community,sonNode,language,out);
        }
    }

    public void parser(java.net.URL url,String html,java.util.zip.ZipOutputStream zos) throws ParserException,Exception
    {
        // org.htmlparser.NodeFilter filter = new org.htmlparser.filters.TagNameFilter("IMG");
        org.htmlparser.NodeFilter filter1 = new org.htmlparser.filters.NodeClassFilter(Class.forName("org.htmlparser.tags.ImageTag"));
        org.htmlparser.Parser p = new org.htmlparser.Parser(url.openConnection());
        // p.setEncoding("UTF-8");
        // p.setInputHTML(html);
        org.htmlparser.util.NodeList list = p.extractAllNodesThatMatch(filter1);
        for(int i = 0;i < list.size();i++)
        {
            org.htmlparser.tags.ImageTag it = (org.htmlparser.tags.ImageTag) list.elementAt(i);
            String strUrl = it.getImageURL();
            String strSrc = it.getAttribute("SRC");
            System.out.println("----------------------------strSrc:" + strSrc);
            if(strSrc != null && strSrc.length() > 0 && !strSrc.toLowerCase().startsWith("http://"))
            {
                try
                {
                    zos.putNextEntry(new java.util.zip.ZipEntry(strSrc));
                    zos.write((byte[]) Node.open(new java.net.URL(url.getProtocol(),url.getHost(),url.getPort(),strUrl).toString()));
                } catch(java.util.zip.ZipException ex)
                {
                    // ex.printStackTrace();
                } catch(IOException ex1)
                {
                    ex1.printStackTrace();
                }
            }
        }

        // css
        filter1 = new org.htmlparser.filters.TagNameFilter("LINK");
        // filter1 = new org.htmlparser.filters.NodeClassFilter(org.htmlparser.tags.LinkTag.class);
        p.setInputHTML(html);
        list = p.extractAllNodesThatMatch(filter1);
        for(int i = 0;i < list.size();i++)
        {
            org.htmlparser.nodes.TagNode it = (org.htmlparser.nodes.TagNode) list.elementAt(i);
            String strUrl = it.getAttribute("HREF");
            System.out.println("----------------------------strUrl:" + strUrl);
            if(strUrl != null && strUrl.length() > 0 && !strUrl.toLowerCase().startsWith("http://"))
            {
                try
                {
                    zos.putNextEntry(new java.util.zip.ZipEntry(strUrl));
                    zos.write(((String) Node.open(new java.net.URL(url.getProtocol(),url.getHost(),url.getPort(),strUrl).toString())).getBytes());
                } catch(java.util.zip.ZipException ex)
                {
                    // ex.printStackTrace();
                } catch(Exception ex)
                {
                    ex.printStackTrace();
                }
            }
        }

        // js
        filter1 = new org.htmlparser.filters.NodeClassFilter(Class.forName("org.htmlparser.tags.ScriptTag"));
        p.setInputHTML(html);
        list = p.extractAllNodesThatMatch(filter1);
        for(int i = 0;i < list.size();i++)
        {
            org.htmlparser.tags.ScriptTag it = (org.htmlparser.tags.ScriptTag) list.elementAt(i);
            String strUrl = it.getAttribute("SRC");
            if(strUrl != null && strUrl.length() > 0 && !strUrl.toLowerCase().startsWith("http://"))
            {
                try
                {
                    System.out.println("----------------------------" + strUrl);
                    zos.putNextEntry(new java.util.zip.ZipEntry(strUrl));
                    zos.write(((String) Node.open(new java.net.URL(url.getProtocol(),url.getHost(),url.getPort(),strUrl).toString())).getBytes());
                } catch(java.util.zip.ZipException ex)
                {
                    // ex.printStackTrace();
                } catch(Exception ex)
                {
                    ex.printStackTrace();
                }
            }
        }

    }


    StringBuilder scr = null;

}
