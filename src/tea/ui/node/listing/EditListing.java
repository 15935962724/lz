package tea.ui.node.listing;

import java.util.*;
import java.io.*;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.node.*;
import tea.html.*;
import tea.htmlx.*;
import tea.http.MultipartRequest;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;
import tea.entity.member.*;
import tea.entity.*;

public class EditListing extends TeaServlet
{

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request,response);
        PrintWriter out = response.getWriter();
        try
        {
            TeaSession teasession = new TeaSession(request);

            int realnode = h.node;
            int listing = h.getInt("listing");
            if(listing < 1)
            {
                if(h.node > 0 && !Node.find(h.node).isCreator(teasession._rv) && AccessMember.find(h.node,teasession._rv).getPurview() < 2)
                {
                    response.sendError(403);
                    return;
                }
                String act = h.get("act");
                if("hiden".equals(act))
                {
                    String secs = h.get("listsid");
                    String thiden = h.get("thiden");
                    if(secs != null && secs.length() > 0 && (!"|".equals(secs)) && thiden != null && thiden.length() > 0)
                    {
                        Node node = Node.find(h.node);
                        String se[] = secs.split("[|]");
                        int hiden = Integer.parseInt(thiden);
                        for(int i = 0;i < se.length;i++)
                        {
                            if(se[i] != null && se[i].length() > 0 && (!"|".equals(se[i])))
                            {
                                int setid = Integer.parseInt(se[i]);
                                Listing sections = Listing.find(setid);
                                if(sections.isExisted())
                                {
                                    Listinghide lh = Listinghide.find(setid,h.node);
                                    lh.set(hiden);
                                }
                            }
                        }
                        delete(node);
                    }
                    String nexturl = h.get("nexturl");
                    //out.print("<script>var pmt=parent.mt,doc=parent.document;</script>");
                    out.println("<script>var mt=parent.mt,doc=parent.document;</script>");
//            		 out.println("<script>var mt=parent.mt,doc=parent.document;</script>");
                    //out.print("<script>alert(doc);</script>");
//            		  out.print("<script>mt.show('隐藏成功！',1,'http://www.baidu.com');</script>");
                    // out.print("<script>mt.show('用户名或密码错误！');</script>");
                    out.print("<script>parent.location.replace('" + nexturl + "');</script>");
                    return;
                }
            }
            String sckhref = h.get("ckhref");
            Listing obj = null;
            if(listing != 0)
            {
                obj = Listing.find(listing);
                realnode = obj.getNode();
            }
            Node node = Node.find(realnode);
            if(realnode > 0 && !node.isCreator(teasession._rv) && AccessMember.find(realnode,teasession._rv).getPurview() < 2)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + realnode);
                return;
            }
            if("GET".equals(request.getMethod()))
            {
                response.sendRedirect("/jsp/listing/EditListing.jsp?" + request.getQueryString());
            } else
            {
                RV rv = teasession._rv;
                if(rv == null)
                {
                    rv = new RV("<" + request.getRemoteAddr() + ">");
                }
                String name = h.get("Name");
                Listing l = Listing.find(listing);
                l.status = h.getInt("status");
                l.type = h.getInt("ltype");
                l.pick = h.get("PickManual") == null ? 1 : 0;
                l.ectypal = h.getInt("ectypal");
                l.style = h.getInt("Style");
                l.styletype = h.getInt("type");
                l.stylecategory = h.getInt("stylecategory");
                l.sequence = h.getInt("Sequence");
                // if(i2 > 255)
                // {
                // outText(teasession,response,super.r.getString(teasession._nLanguage,"InvalidSequence"));
                // return;
                // }
                l.position = h.getInt("Position");
                l.visible = h.getInt("visible");
                l.quantity = h.getInt("Quantity");
                l.sonquantity = h.getInt("SonQuantity");
                l.columns = h.getInt("Columns");
                l.updategap = h.getInt("UpdateGap");
                l.options = 0;
                String[] os = h.getValues("options");
                if(os != null)
                {
                    for(int i = 0;i < os.length;i++)
                    {
                        l.options |= Integer.parseInt(os[i]);
                    }
                }
                /*
                 * if (h.get("ListingONodeCreator") != null) k5 |= 0x400; if (h.get("ListingONodeBriefing") != null) k5 |= 0x100; if (h.get("ListingONodeSubject") != null) k5 |= 0x200; if (h.get("ListingONodeDetail") != null) k5 |= 0x800; if (h.get("ListingOSonCreator") != null) k5 |= 0x40000; if (h.get("ListingOSonDetail") != null) k5 |= 0x80000;
                 */
                int i6 = 0;
                /*
                 * if(h.get("MediaName") != null) i6 |= 1; if(h.get("MediaLogo") != null) i6 |= 2; if(h.get("ClassName") != null) i6 |= 4;
                 */
                if(h.get("IssueTime") != null)
                {
                    i6 |= 8;
                }
                if(h.get("Divide") != null) // 分页显示
                {
                    i6 |= 16;
                }
                l.detailoptions = i6;

                /*
                 * if(h.get( "stockinfo") != null) i6 |=32;
                 */
                l.sorttype = h.getInt(("SortType"));
                l.sortdir = h.getInt(("SortDir"));
                int i_s = Integer.parseInt(h.get("SonSortDir"));
                if(i_s == 1)
                {
                    l.sortdir = l.sortdir | 2;
                }
                l.target = h.get("target");
                l.term = h.getInt(("term"));
                l.archive = h.getInt(("archive"));

                //列举时间
                l.termdate = h.getInt(("termdate"));

                String beforeitempicture = h.get("BeforeItemPicture");
                if(h.get("ClearBeforeItemPicture") != null)
                {
                    beforeitempicture = "";
                }
                //
                StringBuilder mark = new StringBuilder("/");
                String[] ms = h.getValues("mark");
                if(ms != null)
                {
                    for(int i = 0;i < ms.length;i++)
                    {
                        mark.append(ms[i]).append("/");
                    }
                }
                l.mark = mark.toString();
                l.time = h.getDate("Issue");
                if(l.listing > 0)
                {
                    Logs.create(h.community,rv,4,l.listing,name);
                } else
                {
                    l.node = h.node;
                }
                l.set();
                //
                String BeforeListing = h.get("BeforeListing");
                if(BeforeListing.length() < 1)
                    BeforeListing = "<ul>";
                String AfterListing = h.get("AfterListing");
                if(AfterListing.length() < 1)
                    AfterListing = "</ul>";
                l.setLayer(h.language,name,h.get("More"),h.get("Talkbacks"),h.get("EditTalkback"),h.get("ChatRoom")
                           ,h.get("ForwardNode"),h.get("ReplyNode"),beforeitempicture,h.get("BeforeItem"),h.get("AfterItem"),h.get("BeforeDetail"),h.get("SeparatorDetail")
                           ,h.get("AfterDetail"),h.get("BeforeChild"),h.get("AfterChild"),h.get("BeforeChildDetail"),h.get("SeparatorChildDetail")
                           ,h.get("AfterChildDetail"),BeforeListing,0,null,h.get("ClickUrl"),h.get("Alt"),0,AfterListing,h.get("columnafter"),h.getInt("isshowlayer"));

                ListingCache.expire(l.listing);
                delete(node);
                if(h.get("hiden") != null)
                {
                    int ht = h.getInt("hiden");
                    Listinghide lh = Listinghide.find(l.listing,h.node);
                    lh.set(ht);
                }
                ListingDetail ld = ListingDetail.find(l.listing, -1,teasession._nLanguage);
                for(int len = 0;len < Listing.SHARE_DETAIL.length;len++)
                {
                    int istype = h.getInt((Listing.SHARE_DETAIL[len]));
                    String before = h.get(Listing.SHARE_DETAIL[len] + "_1");
                    String after = h.get(Listing.SHARE_DETAIL[len] + "_2");
                    int order = h.getInt((Listing.SHARE_DETAIL[len] + "_3"));
                    Date time = null;
                    String year = h.get(Listing.SHARE_DETAIL[len] + "_6Year");
                    if(year != null)
                    {
                        time = ListingDetail.sdf.parse(year + "-" + h.get(Listing.SHARE_DETAIL[len] + "_6Month") + "-" + h.get(Listing.SHARE_DETAIL[len] + "_6Day"));
                    }

                    int anchor = 0;
                    String _strAnchor = h.get(Listing.SHARE_DETAIL[len] + "_4");
                    if(_strAnchor != null)
                    {
                        anchor = Integer.parseInt(_strAnchor);
                    }
                    int quantity = 0;
                    try
                    {
                        quantity = h.getInt((Listing.SHARE_DETAIL[len] + "_5"));
                    } catch(Exception ex)
                    {
                    }

                    if(istype == 0 && before.length() == 0 && after.length() == 0 && quantity == 0)
                    {
                        ld.delete(Listing.SHARE_DETAIL[len]);
                    } else
                    {
                        if(len == 1)
                        {
                            if(sckhref == null)
                            {
                                ld.set(Listing.SHARE_DETAIL[len],istype,before,after,order,anchor,quantity,"/",time,0);
                            } else
                            {
                                ld.set(Listing.SHARE_DETAIL[len],istype,before,after,order,anchor,quantity,"/",time,1);
                            }
                        } else
                        {
                            ld.set(Listing.SHARE_DETAIL[len],istype,before,after,order,anchor,quantity,"/",time);
                        }
                    }
                }
                if(h.get("GoNext") != null)
                {
                    switch(l.type)
                    {
                    case 4:
                        response.sendRedirect("/jsp/listing/EditSearch.jsp?node=" + h.node + "&listing=" + l.listing);
                        return;
                    }
                    response.sendRedirect("/jsp/listing/Picks.jsp?node=" + h.node + "&listing=" + l.listing);
                } else if(h.get("example") != null)
                {
                    response.sendRedirect("/jsp/site/EditExample.jsp?act=step2&extype=L&exid=" + l.listing);
                } else
                {
                    response.sendRedirect("Node?node=" + h.node + "&status=" + l.status + "&edit=ON");
                }
            }
        } catch(Exception ex)
        {
            response.sendError(400,ex.toString());
            ex.printStackTrace();
        }
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/ui/node/listing/EditListing");
    }
}
