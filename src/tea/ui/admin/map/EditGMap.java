package tea.ui.admin.map;

import java.io.*;
import java.net.*;
import java.awt.image.*;
import javax.imageio.*;
import javax.servlet.*;
import tea.ui.*;
import tea.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.admin.map.*;
import tea.entity.site.*;
import tea.entity.util.*;
import tea.entity.node.*;
import java.util.*;

public class EditGMap extends TeaServlet
{

    protected void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        ServletContext application = getServletContext();
        TeaSession teasession = new TeaSession(request);
        String nexturl = teasession.getParameter("nexturl");
        try
        {
            String act = request.getParameter("act");
            //http://maps.google.com/maps/geo?output=json&oe=utf-8&q=天通苑&key=ABQIAAAAxKKO1nWipXU98lhNSI0WeRSHtJr9YXz9eP36Rn-R-ynwFKTiiBR5mgSbSu7Oe55bb5GUffTN_vYBoA&callback=_xdc_._gfrn8o2xj
            if("json".equals(act))
            {
                String q = request.getParameter("q");
                response.setContentType("text/html;charset=UTF-8");
                Writer out = response.getWriter();
                out.write("{" +
                          "  'name': '" + q + "'," +
                          "  'Status': { 'code': 200,'request': 'geocode' }," +
                          "  'Placemark':" +
                          "  [ ");
                int root = Community.find(teasession._strCommunity).getNode();
                Enumeration e = GMap.find(" AND hidden=0 AND node IN( SELECT n.node FROM Node n INNER JOIN NodeLayer nl ON n.node=nl.node WHERE n.path LIKE '/" + root + "/%' AND nl.subject LIKE " + DbAdapter.cite("%" + q + "%") + " )",0,Integer.MAX_VALUE);
                for(int i = 1;e.hasMoreElements();i++)
                {
                    GMap g = (GMap) e.nextElement();
                    Node n = Node.find(g.getNode());

                    if(i > 1)
                    {
                        out.write(",\r\n");
                    }
                    String content = n.getText(teasession._nLanguage);
                    content = content.replaceAll("<[^>]*>","");
                    if(content.length() > 40)
                    {
                        content = content.substring(0,40) + "...";
                    }
                    String pic = n.getPicture(teasession._nLanguage);
                    StringBuilder sb = new StringBuilder();
                    sb.append("  {");
                    sb.append("    'id': '" + n._nNode + "',");
                    sb.append("    'address': '" + n.getSubject(teasession._nLanguage) + "',");
                    sb.append("    'content': '" + content.replace('\'','＇').replaceAll("\\r\\n"," ") + "',"); //<br />
                    if(pic != null && pic.length() > 0)
                    {
                        sb.append("    'picture': '" + pic + "',");
                    }
                    sb.append("    'AddressDetails': {'Country': {'CountryNameCode': 'CN','CountryName': '中国','Locality': {'LocalityName': '北京市','DependentLocality': {'DependentLocalityName': '朝阳区','AddressLine':['天通苑']}}},'Accuracy': 9},");
                    sb.append("    'ExtendedData': {");
                    sb.append("      'LatLonBox': { 'north':40.0645684, 'south':40.0582732, 'east':116.4206533, 'west':116.4143581 }");
                    sb.append("    },");
                    sb.append("    'Point': { 'coordinates': [ " + g.getLng() + ", " + g.getLat() + ", 0 ] }");
                    sb.append("  }");
                    out.write(sb.toString());
                }
                out.write("]}");
                out.close();
                return;
            }
            if(teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode + "&nexturl=" + java.net.URLEncoder.encode(request.getRequestURI() + "?" + request.getQueryString(),"UTF-8"));
                return;
            }
            if("edit".equals(act)) // 1．创建/修改地图标点
            {
                String point = teasession.getParameter("point");
                int father = Integer.parseInt(teasession.getParameter("father"));
                String tmp = teasession.getParameter("nodeid");
                String subject = teasession.getParameter("subject");
                if(tmp.length() < 1)
                {
                    Node n = Node.find(father);
                    Category cat = Category.find(father);
                    teasession._nNode = Node.create(father,0,n.getCommunity(),teasession._rv,cat.getCategory(),(n.getOptions1() & 2) != 0,n.getOptions(),n.getOptions1(),n.getDefaultLanguage(),null,null,new java.util.Date(),n.getStyle(),n.getRoot(),n.getKstyle(),n.getKroot(),null,teasession._nLanguage,subject,"","","",null,"",0,null,"","","","",null,null);
                } else
                {
                    teasession._nNode = Integer.parseInt(tmp);
                    if(subject != null) //通过"节点号"添加或编辑标点
                    {
                        Node n = Node.find(teasession._nNode);
                        if(n.getType() < 2)
                        {
                            response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("无效-节点号","UTF-8") + "&nexturl=" + java.net.URLEncoder.encode(nexturl,"UTF-8"));
                            return;
                        }
                        if(subject.length() > 0)
                        {
                            n.setSubject(subject,teasession._nLanguage);
                        }
                    }
                }
                GMap.create(teasession._nNode,point,teasession._rv._strV);
            } else if("VenuesEdit".equals(act)) //对场馆的标点地图
            {
                String point = teasession.getParameter("point");
                int father = Integer.parseInt(teasession.getParameter("father"));
                String tmp = teasession.getParameter("nodeid");
                String alt = teasession.getParameter("alt");
                //  if(tmp.length() < 1)
                //  {
                //  Node n = Node.find(father);
                //  Category cat = Category.find(father);
                //  teasession._nNode = Node.create(father,0,n.getCommunity(),teasession._rv,cat.getCategory(),(n.getOptions1() & 2) != 0,n.getOptions(),n.getOptions1(),n.getDefaultLanguage(),null,null,new java.util.Date(),n.getStyle(),n.getRoot(),n.getKstyle(),n.getKroot(),"",null,teasession._nLanguage,subject,"","",null,"",0,null,"","","","",null,null);
                //  } else
                //  {
                teasession._nNode = Integer.parseInt(tmp);
                if(alt != null) //通过"节点号"添加或编辑标点
                {
                    Node n = Node.find(teasession._nNode);
                    if(n.getType() < 2)
                    {
                        response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("无效-节点号","UTF-8") + "&nexturl=" + java.net.URLEncoder.encode(nexturl,"UTF-8"));
                        return;
                    }
                    if(alt.length() > 0)
                    {
                        n.setAlt(alt,teasession._nLanguage);
                    }
                }
                //  }
                GMap.create(teasession._nNode,point,teasession._rv._strV);

            } else if("del".equals(act)) // 6.数据删除
            {
                GMap obj = GMap.find(teasession._nNode);
                obj.delete();
            } else if("hidden".equals(act)) // 7.标点状态更改
            {
                boolean hidden = "true".equals(request.getParameter("hidden"));
                GMap obj = GMap.find(teasession._nNode);
                obj.setHidden(hidden);
            }
            response.sendRedirect(nexturl);
        } catch(Exception ex)
        {
            ex.printStackTrace();
            response.sendError(500,ex.toString());
        }
    }
}
