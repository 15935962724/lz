package tea.ui.node.general;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

import tea.entity.*;
import tea.entity.node.*;
import tea.entity.node.Page;
import tea.html.*;
import tea.htmlx.Languages;
import tea.resource.Resource;
import tea.ui.*;
import java.util.*;
import tea.db.*;

public class CloneNode extends TeaServlet
{

    public CloneNode()
    {
    }

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        try
        {
            // 异地复制,请求数据
            if(request.getParameter("validate") != null)
            {
                int i = Integer.parseInt(request.getParameter("node"));
                if(!Node.isExisted(i))
                {
                    return;
                }
                response.setContentType("text/xml;charset=UTF-8");
                String sn = "http://" + request.getServerName() + ":" + request.getServerPort();
                java.io.PrintWriter out = response.getWriter();
                out.println("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
                out.println("<ROOT>");
                if(request.getParameter("section") != null)
                {
                    Enumeration e1 = Section.findByNode(i);
                    while(e1.hasMoreElements())
                    {
                        int k = ((Integer) e1.nextElement()).intValue();
                        Section section = Section.find(k);
                        out.println("<Section>");
                        out.println("<section><![CDATA[" + k + "]]></section>");
                        out.println("<style><![CDATA[" + section.getStyle() + "]]></style>");
                        out.println("<node><![CDATA[" + section.getNode() + "]]></node>");
                        out.println("<position><![CDATA[" + section.getPosition() + "]]></position>");
                        out.println("<sequence><![CDATA[" + section.getSequence() + "]]></sequence>");
                        out.println("<access><![CDATA[" + section.getVisible() + "]]></access>");
                        out.println("<options><![CDATA[" + section.getOptions() + "]]></options>");
                        out.print("<time><![CDATA[");
                        if(section.getTime() != null)
                        {
                            out.print(section.sdf.format(section.getTime()));
                        }
                        out.println("]]></time>");
                        out.println("<Layer>");
                        java.util.Enumeration enumer = section.getLanguages().elements();
                        while(enumer.hasMoreElements())
                        {
                            int language = ((Integer) enumer.nextElement()).intValue();
                            out.println("<Item>");
                            out.println("<language><![CDATA[" + language + "]]></language>");
                            out.print("<text><![CDATA[");
                            if(section.getText(language) != null)
                            {
                                out.print(section.getText(language));
                            }
                            out.println("]]></text>");
                            out.print("<picture><![CDATA[");
                            if(section.getPicture(language) != null)
                            {
                                out.print(section.getPicture(language));
                            }
                            out.println("]]></picture>");
                            out.print("<clickurl><![CDATA[");
                            if(section.getClickUrl(language) != null)
                            {
                                out.print(section.getClickUrl(language));
                            }
                            out.println("]]></clickurl>");
                            out.print("<alt><![CDATA[");
                            if(section.getAlt(language) != null)
                            {
                                out.print(section.getAlt(language));
                            }
                            out.println("]]></alt>");
                            out.println("<align><![CDATA[" + section.getAlign(language) + "]]></align>");
                            out.print("<voice><![CDATA[");
                            if(section.getVoice(language) != null)
                            {
                                out.print(section.getVoice(language));
                            }
                            out.println("]]></voice>");
                            out.print("<filename><![CDATA[");
                            if(section.getFileName(language) != null)
                            {
                                out.print(section.getFileName(language));
                            }
                            out.println("]]></filename>");
                            out.print("<filedata><![CDATA[");
                            if(section.getFileData(language) != null)
                            {
                                out.print(section.getFileData(language));
                            }
                            out.println("]]></filedata>");
                            out.println("</Item>");
                        }
                        out.println("</Layer>");
                        out.println("<Sectionhide>");
                        enumer = Sectionhide.findNodeBySection(k);
                        while(enumer.hasMoreElements())
                        {
                            int node = ((Integer) enumer.nextElement()).intValue();
                            Sectionhide obj = Sectionhide.find(k,node);
                            out.println("<Item>");
                            out.println("<node><![CDATA[" + node + "]]></node>");
                            out.println("<hiden><![CDATA[" + obj.getHiden() + "]]></hiden>");
                            out.println("</Item>");
                        }
                        out.println("</Sectionhide>");
                        out.println("</Section>");
                    }
                } else if(request.getParameter("cssjs") != null)
                {
                    Enumeration e1 = CssJs.findByNode(i);
                    while(e1.hasMoreElements())
                    {
                        int k = ((Integer) e1.nextElement()).intValue();
                        CssJs obj = CssJs.find(k);
                        out.println("<CssJs>");
                        out.println("<cssjs><![CDATA[" + k + "]]></cssjs>");
                        out.println("<style><![CDATA[" + obj.getStyle() + "]]></style>");
                        out.println("<node><![CDATA[" + obj.getNode() + "]]></node>");
                        out.print("<name><![CDATA[");
                        if(obj.getName(1) != null)
                        {
                            out.print(obj.getName(1));
                        }
                        out.println("]]></name>");
                        out.println("<Layer>");
                        java.util.Enumeration enumer = obj.getLanguages().elements();
                        while(enumer.hasMoreElements())
                        {
                            int language = ((Integer) enumer.nextElement()).intValue();
                            out.println("<Item>");
                            out.println("<language><![CDATA[" + language + "]]></language>");
                            out.println("<css><![CDATA[" + obj.getCss(language) + "]]></css>"); // .replaceAll("url(/tea/image/", "url(" + sn + "/tea/image/")
                            out.println("<js><![CDATA[" + obj.getJs(language) + "]]></js>");
                            out.println("</Item>");
                        }
                        out.println("</Layer>");
                        out.println("<Cssjshide>");
                        enumer = Sectionhide.findNodeBySection(k);
                        while(enumer.hasMoreElements())
                        {
                            int node = ((Integer) enumer.nextElement()).intValue();
                            Cssjshide ch_obj = Cssjshide.find(k,node);
                            out.println("<Item>");
                            out.println("<node><![CDATA[" + node + "]]></node>");
                            out.println("<hiden><![CDATA[" + ch_obj.getHiden() + "]]></hiden>");
                            out.println("</Item>");
                        }
                        out.println("</Cssjshide>");
                        out.println("</CssJs>");
                    }
                } else if(request.getParameter("listing") != null)
                {
                    Enumeration e1 = Listing.findByNode(i);
                    while(e1.hasMoreElements())
                    {
                        int k = ((Integer) e1.nextElement()).intValue();
                        Listing obj = Listing.find(k);
                        out.println("<Listing>");
                        out.println("<listing><![CDATA[" + k + "]]></listing>");
                        out.println("<type><![CDATA[" + obj.getType() + "]]></type>");
                        out.println("<style><![CDATA[" + obj.getStyle() + "]]></style>");
                        out.println("<node><![CDATA[" + obj.getNode() + "]]></node>");
                        out.println("<sequence><![CDATA[" + obj.getSequence() + "]]></sequence>");
                        out.println("<position><![CDATA[" + obj.getPosition() + "]]></position>");
                        out.println("<quantity><![CDATA[" + obj.getQuantity() + "]]></quantity>");
                        out.println("<sonquantity><![CDATA[" + obj.getSonQuantity() + "]]></sonquantity>");
                        out.println("<columns><![CDATA[" + obj.getColumns() + "]]></columns>");
                        out.println("<options><![CDATA[" + obj.getOptions() + "]]></options>");
                        out.println("<sorttype><![CDATA[" + obj.getSortType() + "]]></sorttype>");
                        out.println("<sortdir><![CDATA[" + obj.getSortDir() + "]]></sortdir>");
                        out.println("<updategap><![CDATA[" + obj.getUpdateGap() + "]]></updategap>");
                        out.println("<pick><![CDATA[" + obj.getPick() + "]]></pick>");
                        out.println("<access><![CDATA[" + obj.getVisible() + "]]></access>");
                        out.println("<detailoptions><![CDATA[" + obj.getDetailOptions() + "]]></detailoptions>");
                        out.print("<time><![CDATA[");
                        if(obj.getTime() != null)
                        {
                            out.print(obj.sdf.format(obj.getTime()));
                        }
                        out.println("]]></time>");
                        out.println("<target><![CDATA[" + obj.getTarget() + "]]></target>");
                        out.println("<archive><![CDATA[" + obj.getArchive() + "]]></archive>");
                        out.println("<ectypal><![CDATA[" + obj.getEctypal() + "]]></ectypal>");
                        out.println("<Layer>");
                        Enumeration e2 = obj.getLanguages().elements();
                        while(e2.hasMoreElements())
                        {
                            int language = ((Integer) e2.nextElement()).intValue();
                            out.println("<Item>");
                            out.println("<language><![CDATA[" + language + "]]></language>");
                            out.println("<name><![CDATA[" + obj.getName(language) + "]]></name>");
                            out.println("<more><![CDATA[" + obj.getMore(language) + "]]></more>");
                            out.println("<talkbacks><![CDATA[" + obj.getTalkbacks(language) + "]]></talkbacks>");
                            out.println("<edittalkback><![CDATA[" + obj.getEditTalkback(language) + "]]></edittalkback>");
                            out.println("<chatroom><![CDATA[" + obj.getChatRoom(language) + "]]></chatroom>");
                            out.println("<forwardnode><![CDATA[" + obj.getForwardNode(language) + "]]></forwardnode>");
                            out.println("<replynode><![CDATA[" + obj.getReplyNode(language) + "]]></replynode>");
                            out.println("<beforeitempicture><![CDATA[" + obj.getBeforeItemPicture(language) + "]]></beforeitempicture>");

                            out.println("<beforeitem><![CDATA[" + obj.getBeforeItem(language) + "]]></beforeitem>");
                            out.println("<afteritem><![CDATA[" + obj.getAfterItem(language) + "]]></afteritem>");
                            // out.println("<beforedetail><![CDATA[" + obj.getBeforeDetail(language) + "]]></beforedetail>");
                            out.println("<separatordetail><![CDATA[" + obj.getSeparatorDetail(language) + "]]></separatordetail>");
                            // out.println("<afterdetail><![CDATA[" + obj.getAfterDetail(language) + "]]></afterdetail>");
                            // out.println("<beforechild><![CDATA[" + obj.getBeforeChild(language) + "]]></beforechild>");

                            // out.println("<afterchild><![CDATA[" + obj.getAfterChild(language) + "]]></afterchild>");
                            // out.println("<beforechilddetail><![CDATA[" + obj.getBeforeChildDetail(language) + "]]></beforechilddetail>");
                            // out.println("<separatorchilddetail><![CDATA[" + obj.getSeparatorChildDetail(language) + "]]></separatorchilddetail>");
                            // out.println("<afterchilddetail><![CDATA[" + obj.getAfterChildDetail(language) + "]]></afterchilddetail>");
                            out.println("<beforelisting><![CDATA[" + obj.getBeforeListing(language) + "]]></beforelisting>");
                            out.println("<pictureposition><![CDATA[" + obj.getPicturePosition(language) + "]]></pictureposition>");

                            out.println("<picture><![CDATA[" + obj.getPicture(language) + "]]></picture>");
                            out.println("<clickurl><![CDATA[" + obj.getClickUrl(language) + "]]></clickurl>");
                            out.println("<alt><![CDATA[" + obj.getAlt(language) + "]]></alt>");
                            out.println("<align><![CDATA[" + obj.getAlign(language) + "]]></align>");
                            out.println("<afterlisting><![CDATA[" + obj.getAfterListing(language) + "]]></afterlisting>");
                            out.println("<columnafter><![CDATA[" + obj.getColumnAfter(language) + "]]></columnafter>");
                            out.println("</Item>");
                        }
                        out.println("</Layer>");
                        // out.println("<Cssjshide>");
                        // Enumeration e3 = Listinghide.findNodeByListing(k);
                        // while (enumer2.hasMoreElements())
                        // {
                        // int node = ((Integer) enumer2.nextElement()).intValue();
                        // Listinghide lh_obj = Listinghide.find(k, node);
                        // out.println("<Item>");
                        // out.println("<node><![CDATA[" + node + "]]></node>");
                        // out.println("<hiden><![CDATA[" + lh_obj.getHiden() + "]]></hiden>");
                        // out.println("</Item>");
                        // }
                        // out.println("</Cssjshide>");
                        out.println("<PickFrom>");
                        Iterator i3 = PickFrom.findByListing(k).iterator();
                        while(i3.hasNext())
                        {
                            PickFrom pickfrom = (PickFrom) i3.next();
                            out.println("<Item>");
                            out.println("<pickfrom><![CDATA[" + pickfrom.pickfrom + "]]></pickfrom>");
                            out.println("<listing><![CDATA[" + pickfrom.getListing() + "]]></listing>");
                            out.println("<fromstyle><![CDATA[" + pickfrom.getFromStyle() + "]]></fromstyle>");
                            out.println("<fromcommunity><![CDATA[" + pickfrom.getFromCommunity() + "]]></fromcommunity>");
                            out.println("<fromnode><![CDATA[" + pickfrom.getFromNode() + "]]></fromnode>");
                            out.println("</Item>");
                        }
                        out.println("</PickFrom>");
                        out.println("<PickNode>");
                        ArrayList e4 = PickNode.findByListing(k);
                        for(int j = 0;j < e4.size();j++)
                        {
                            PickNode picknode = (PickNode) e4.get(j);
                            out.println("<Item>");
                            out.println("<picknode><![CDATA[" + picknode.picknode + "]]></picknode>");
                            out.println("<listing><![CDATA[" + picknode.listing + "]]></listing>");
                            out.println("<nodestyle><![CDATA[" + picknode.nodeStyle + "]]></nodestyle>");
                            out.println("<type><![CDATA[" + picknode.type + "]]></type>");
                            // out.println("<typealias><![CDATA[" + picknode.getTypeAlias() + "]]></typealias>");
                            out.println("<startstyle><![CDATA[" + picknode.startStyle + "]]></startstyle>");
                            out.println("<startterm><![CDATA[" + picknode.startTerm + "]]></startterm>");
                            out.println("<stopstyle><![CDATA[" + picknode.stopStyle + "]]></stopstyle>");
                            out.println("<stopterm><![CDATA[" + picknode.stopTerm + "]]></stopterm>");
                            out.println("<creatorstyle><![CDATA[" + picknode.creatorStyle + "]]></creatorstyle>");
                            out.println("<rcreator><![CDATA[" + picknode.rcreator + "]]></rcreator>");
                            out.println("<vcreator><![CDATA[" + picknode.vcreator + "]]></vcreator>");
                            out.println("</Item>");
                        }
                        out.println("</PickNode>");
                        out.println("<ListingDetail>");
                        Enumeration e5 = ListingDetail.findByListing(k);
                        while(e5.hasMoreElements())
                        {
                            Object o[] = (Object[]) e5.nextElement();
                            ListingDetail ld = ListingDetail.find(k,((Integer) o[0]).intValue(),((Integer) o[2]).intValue());
                            Iterator it = ld.keys();
                            while(it.hasNext())
                            {
                                String name = (String) it.next();
                                out.println("<Item>");
                                out.println("<listing><![CDATA[" + ld.getListing() + "]]></listing>");
                                out.println("<type><![CDATA[" + ld.getType() + "]]></type>");
                                out.println("<itemname><![CDATA[" + name + "]]></itemname>");
                                out.println("<istype><![CDATA[" + ld.getIstype(name) + "]]></istype>");
                                out.println("<beforeitem><![CDATA[" + ld.getBeforeItem(name) + "]]></beforeitem>");
                                out.println("<afteritem><![CDATA[" + ld.getAfterItem(name) + "]]></afteritem>");
                                out.println("<order><![CDATA[" + ld.getSequence(name) + "]]></order>");
                                out.println("<anchor><![CDATA[" + ld.getAnchor(name) + "]]></anchor>");
                                out.println("<quantity><![CDATA[" + ld.getQuantity(name) + "]]></quantity>");
                                out.println("<language><![CDATA[" + ld.getLanguage() + "]]></language>");
                                out.println("<time><![CDATA[" + ld.getTimeToString(name) + "]]></time>");
                                out.println("</Item>");
                            }
                        }
                        out.println("</ListingDetail>");
                        out.println("</Listing>");
                    }
                } else if(request.getParameter("node") != null)
                {
                    Enumeration e = Node.findAllSons(i);
                    while(e.hasMoreElements())
                    {
                        int node_id = ((Integer) e.nextElement()).intValue();
                        Node node = Node.find(node_id);
                        out.println("<Node>");
                        out.println("<node><![CDATA[" + node_id + "]]></node>");
                        out.println("<father><![CDATA[" + node.getFather() + "]]></father>");
                        out.println("<sequence><![CDATA[" + node.getSequence() + "]]></sequence>");
                        out.println("<community><![CDATA[" + node.getCommunity() + "]]></community>");
                        out.println("<rcreator><![CDATA[" + node.getCreator()._strR + "]]></rcreator>");
                        out.println("<vcreator><![CDATA[" + node.getCreator()._strV + "]]></vcreator>");
                        out.println("<time><![CDATA[" + node.getTimeToString() + "]]></time>");
                        out.println("<type><![CDATA[" + node.getType() + "]]></type>");
                        out.println("<hidden><![CDATA[" + node.isHidden() + "]]></hidden>");
                        out.println("<options><![CDATA[" + node.getOptions() + "]]></options>");
                        out.println("<options1><![CDATA[" + node.getOptions1() + "]]></options1>");
                        out.print("<starttime><![CDATA[");
                        if(node.getStartTime() != null)
                        {
                            out.print(node.sdf.format(node.getStartTime()));
                        }
                        out.println("]]></starttime>");
                        out.print("<stoptime><![CDATA[");
                        if(node.getStopTime() != null)
                        {
                            out.print(node.sdf.format(node.getStopTime()));
                        }
                        out.println("]]></stoptime>");
                        out.println("<path><![CDATA[" + node.getPath() + "]]></path>");
                        // out.println("<typealias><![CDATA[" + node.getTypeAlias() + "]]></typealias>");
                        out.println("<defaultlanguage><![CDATA[" + node.getDefaultLanguage() + "]]></defaultlanguage>");
                        out.println("<click><![CDATA[" + node.getClick() + "]]></click>");
                        out.println("<template><![CDATA[ ]]></template>");
                        out.println("<finished><![CDATA[" + node.getFinished() + "]]></finished>");
                        out.println("<style><![CDATA[" + node.getStyle() + "]]></style>");
                        out.println("<root><![CDATA[" + node.getRoot() + "]]></root>");
                        out.println("<mostly><![CDATA[" + node.isMostly() + "]]></mostly>");
                        out.println("<hot><![CDATA[" + node.getHot() + "]]></hot>");
                        out.println("<updatetime><![CDATA[" + node.getUpdatetimeToString() + "]]></updatetime>");
                        out.println("<kstyle><![CDATA[" + node.getKstyle() + "]]></kstyle>");
                        out.println("<kroot><![CDATA[" + node.getKroot() + "]]></kroot>");
                        out.println("<Layer>");
                        java.util.Enumeration enumer = node.getLanguages().elements();
                        while(enumer.hasMoreElements())
                        {
                            int language = ((Integer) enumer.nextElement()).intValue();
                            out.println("<Item>");
                            out.println("<language><![CDATA[" + language + "]]></language>");
                            out.println("<subject><![CDATA[" + node.getSubject(language) + "]]></subject>");
                            out.println("<keywords><![CDATA[" + node.getKeywords(language) + "]]></keywords>");
                            out.println("<content><![CDATA[" + node.getText(language) + "]]></content>");
                            out.println("<picture><![CDATA[" + node.getPicture(language) + "]]></picture>");
                            out.println("<alt><![CDATA[" + node.getAlt(language) + "]]></alt>");
                            out.println("<align><![CDATA[" + node.getAlign(language) + "]]></align>");
                            out.println("<voice><![CDATA[" + node.getVoice(language) + "]]></voice>");
                            out.println("<clickurl><![CDATA[" + node.getClickUrl(language) + "]]></clickurl>");
                            out.println("<srcurl><![CDATA[" + node.getSrcUrl(language) + "]]></srcurl>");
                            out.println("<srcurlx><![CDATA[" + node.getSrcUrlx(language) + "]]></srcurlx>");
                            out.println("<direction><![CDATA[" + node.getDirection(language) + "]]></direction>");
                            out.println("<filename><![CDATA[" + node.getFileName(language) + "]]></filename>");
                            out.println("<filedata><![CDATA[" + (node.getFile(language)) + "]]></filedata>"); // DbAdapter.cite
                            // out.println("<content2><![CDATA[" + node.getOptions() + "]]></content2>");
                            out.println("<mms><![CDATA[" + node.getMms(language) + "]]></mms>");

                            switch(node.getType())
                            {
                            case 1:
                                Category c_obj = Category.find(node_id);
                                out.println("<Category>");
                                out.println("<category><![CDATA[" + c_obj.getCategory() + "]]></category>");

                                // out.println("<typealias><![CDATA[" + c_obj.getTypeAlias() + "]]></typealias>");
                                out.println("<template><![CDATA[" + c_obj.getTemplate() + "]]></template>");
                                out.println("</Category>");
                                break;
                            case 2:
                                Page page_obj = Page.find(node_id);
                                out.println("<PageLayer>");
                                out.println("<redirecturl><![CDATA[" + page_obj.getRedirectUrl(language) + "]]></redirecturl>");
                                out.println("</PageLayer>");
                                break;
                            case 3:
                                out.println("<PollLayer>");

                                // java.util.Enumeration poll_enumer = Poll.findByNode(node_id, language);
                                // while (poll_enumer.hasMoreElements())
                                // {
                                // int poll_id = ((Integer) poll_enumer.nextElement()).intValue();
                                // Poll poll_obj = Poll.find(poll_id);
                                // out.println("<Item>");
                                // out.println("<question><![CDATA[" + poll_obj.getQuestion() + "]]></question>");
                                // out.println("<type><![CDATA[" + poll_obj.getType() + "]]></type>");
                                // out.println("<picture><![CDATA[" + poll_obj.getPicture() + "]]></picture>");
                                // out.println("<top><![CDATA[" + poll_obj.getTop() + "]]></top>");
                                // out.println("<point><![CDATA[" + poll_obj.getPoint() + "]]></point>");
                                // out.println("<correct><![CDATA[" + poll_obj.getCorrect() + "]]></correct>");
                                // out.println("<PollChoice>");
                                // java.util.Enumeration pc_enumer = PollChoice.findByPoll(poll_id);
                                // while (pc_enumer.hasMoreElements())
                                // {
                                // int pc_id = ((Integer) pc_enumer.nextElement()).intValue();
                                // PollChoice pc_obj = PollChoice.find(pc_id);
                                // out.println("<Item>");
                                // out.println("<choice><![CDATA[" + pc_obj.getChoice() + "]]></choice>");
                                // out.println("</Item>");
                                // }
                                // out.println("</PollChoice>");
                                // out.println("</Item>");
                                // }
                                out.println("</PollLayer>");
                                break;
                            case 15: /*
                                                           java.util.Enumeration stock_enumer = Stock.find(node_id, null, null).elements();
                                                           out.println("<Stock>");
                                                           while (stock_enumer.hasMoreElements())
                                                           {
                                                            int stock_id = ((Integer) stock_enumer.nextElement()).intValue();
                                                            Stock stock_obj = Stock.find(stock_id);
                                                            out.println("<Item>");
                                                            out.println("<stockname><![CDATA[" + stock_obj.getStockName(language) + "]]></stockname>");
                                                            out.println("<date><![CDATA[" + stock_obj.getDateToString() + "]]></date>");
                                                            out.println("<datedata><![CDATA[" + stock_obj.getDateData() + "]]></datedata>");
                                                            out.println("<openingprice><![CDATA[" + stock_obj.getOpen() + "]]></openingprice>");
                                                            out.println("<high><![CDATA[" + stock_obj.getHigh() + "]]></high>");
                                                            out.println("<low><![CDATA[" + stock_obj.getLow() + "]]></low>");
                                                            out.println("<closingprice><![CDATA[" + stock_obj.getClosingPrice() + "]]></closingprice>");
                                                            out.println("<percentchange><![CDATA[" + stock_obj.getChangePercent() + "]]></percentchange>");
                                                            out.println("<volume><![CDATA[" + stock_obj.getVolume() + "]]></volume>");
                                                            out.println("</Item>");
                                                           }
                                                           out.println("</Stock>");
                                                           out.println("<Stock2>");
                                                           Stock2 stock2_obj = Stock2.find(node_id);
                                                           out.println("<stockname><![CDATA[" + stock2_obj.getStockName(language) + "]]></stockname>");
                                                           out.println("<datedata><![CDATA[" + stock2_obj.getdatedata() + "]]></datedata>");
                                                           out.println("<openingprice><![CDATA[" + stock2_obj.getOpen() + "]]></openingprice>");
                                                           out.println("<high><![CDATA[" + stock2_obj.getHigh() + "]]></high>");
                                                           out.println("<low><![CDATA[" + stock2_obj.getLow() + "]]></low>");
                                                           out.println("<closingprice><![CDATA[" + stock2_obj.getclosingprice() + "]]></closingprice>");
                                                           out.println("<percentchange><![CDATA[" + stock2_obj.getChangePercent() + "]]></percentchange>");
                                                           out.println("<graphweek><![CDATA[" + stock2_obj.getGraphWeek() + "]]></graphweek>");
                                                           out.println("<graphmonth><![CDATA[" + stock2_obj.getGraphMonth() + "]]></graphmonth>");
                                                           out.println("<graphyear><![CDATA[" + stock2_obj.getGraphYear() + "]]></graphyear>");
                                                           out.println("<graphyet><![CDATA[" + stock2_obj.getGraphYet() + "]]></graphyet>");
                                                           out.println("</Stock2>");
                                                           break;*/

                            case 34:
                                Goods g_obj = Goods.find(node_id);
                                out.println("<Goods>");
                                out.println("<brand><![CDATA[" + g_obj.getBrand() + "]]></brand>");
                                out.println("<measure><![CDATA[" + g_obj.getMeasure(language) + "]]></measure>");
                                out.println("<spec><![CDATA[" + g_obj.getSpec(language) + "]]></spec>");
                                out.println("<capability><![CDATA[" + g_obj.getCapability(language) + "]]></capability>");
                                out.println("<smallpicture><![CDATA[" + g_obj.getSmallpicture(language) + "]]></smallpicture>");
                                out.println("<status><![CDATA[" + g_obj.isStatus() + "]]></status>");
                                out.println("<correspond><![CDATA[" + g_obj.getCorrespond() + "]]></correspond>");
                                out.println("<correspond2><![CDATA[" + g_obj.getCorrespond2() + "]]></correspond2>");
                                out.println("<correspond3><![CDATA[" + g_obj.getCorrespond3() + "]]></correspond3>");
                                out.println("<correspond4><![CDATA[" + g_obj.getCorrespond4() + "]]></correspond4>");
                                out.println("<correspond5><![CDATA[" + g_obj.getCorrespond5() + "]]></correspond5>");
                                out.println("<correspond6><![CDATA[" + g_obj.getCorrespond6() + "]]></correspond6>");
                                out.println("<bigpicture><![CDATA[" + g_obj.getBigpicture(language) + "]]></bigpicture>");
                                out.println("<commendpicture><![CDATA[" + g_obj.getCommendpicture(language) + "]]></commendpicture>");
                                out.println("<goodstype><![CDATA[" + g_obj.getGoodstype() + "]]></goodstype>");
                                out.println("</Goods>");
                                break;
                            case 37:
                                Event e_obj = Event.find(node_id,language);
                                out.println("<Event>");
                                out.print("<timestart><![CDATA[");
                                if(e_obj.getTimeStart() != null)
                                {
                                    out.print(e_obj.sdf.format(e_obj.getTimeStart()));
                                }
                                out.println("]]></timestart>");
                                out.print("<timestop><![CDATA[");
                                if(e_obj.getTimeStop() != null)
                                {
                                    out.print(e_obj.sdf.format(e_obj.getTimeStop()));
                                }
                                out.println("]]></timestop>");
                                out.println("<nightshop><![CDATA[" + e_obj.getNightShop() + "]]></nightshop>");
                                out.println("<sort><![CDATA[" + e_obj.getSort() + "]]></sort>");
                                out.println("<request><![CDATA[" + e_obj.getRequest() + "]]></request>");
                                out.println("<prescribe><![CDATA[" + e_obj.getPrescribe() + "]]></prescribe>");
                                out.println("<synopsis><![CDATA[" + e_obj.getSynopsis() + "]]></synopsis>");
                                out.println("<organise><![CDATA[" + e_obj.getOrganise() + "]]></organise>");
                                out.println("<linkman><![CDATA[" + e_obj.getLinkman() + "]]></linkman>");
                                out.println("<corp><![CDATA[" + e_obj.getCorp() + "]]></corp>");
                                out.println("<carfare><![CDATA[" + e_obj.getCarfare() + "]]></carfare>");
                                out.println("<feature><![CDATA[" + e_obj.getFeature() + "]]></feature>");
                                out.println("<intropicture><![CDATA[" + e_obj.getIntroPicture() + "]]></intropicture>");
                                out.println("<flyerdata><![CDATA[" + e_obj.getFlyerData() + "]]></flyerdata>");
                                out.println("<localepicture><![CDATA[" + e_obj.getLocalePicture() + "]]></localepicture>");
                                out.println("<localepicture2><![CDATA[" + e_obj.getLocalePicture2() + "]]></localepicture2>");
                                out.println("<localepicture3><![CDATA[" + e_obj.getLocalePicture3() + "]]></localepicture3>");
                                out.println("<date><![CDATA[" + e_obj.getDateToString() + "]]></date>");
                                out.println("</Event>");
                                break;

                            case 39:
                                Report report = Report.find(node_id);
                                out.println("<Report>");
                                out.println("<media_id><![CDATA[" + report.getMedia() + "]]></media_id>");
                                out.println("<class_id><![CDATA[" + report.getClasses() + "]]></class_id>");
                                out.println("<picture><![CDATA[" + report.getPicture(language) + "]]></picture>");
                                out.println("<locus><![CDATA[" + report.getLocus(language) + "]]></locus>");
                                out.println("<subhead><![CDATA[" + report.getSubhead(language) + "]]></subhead>");
                                out.println("<author><![CDATA[" + report.getAuthor(language) + "]]></author>");
                                out.println("<logograph><![CDATA[" + report.getLogograph(language) + "]]></logograph>");
                                out.println("<issuetime><![CDATA[" + report.getIssueTimeToString() + "]]></issuetime>");
                                out.println("</Report>");
                                break;
                            case 45:
                                NightShop ns_obj = NightShop.find(node_id,language);
                                out.println("<NightShop>");
                                out.println("<logo><![CDATA[" + ns_obj.getLogo() + "]]></logo>");
                                out.println("<type><![CDATA[" + ns_obj.getType() + "]]></type>");
                                out.println("<area><![CDATA[" + ns_obj.getArea() + "]]></area>");
                                out.println("<musictype><![CDATA[" + ns_obj.getMusicType() + "]]></musictype>");
                                out.println("<deilstyle><![CDATA[" + ns_obj.getDeilStyle() + "]]></deilstyle>");
                                out.println("<circumstance><![CDATA[" + ns_obj.getCircumstance() + "]]></circumstance>");
                                out.println("<startbusinesshours><![CDATA[" + ns_obj.getStartBusinessHours() + "]]></startbusinesshours>");
                                out.println("<stopbusinesshours><![CDATA[" + ns_obj.getStopBusinessHours() + "]]></stopbusinesshours>");
                                out.println("<options><![CDATA[" + ns_obj.getOptions() + "]]></options>");
                                out.println("<synopsis><![CDATA[" + ns_obj.getSynopsis() + "]]></synopsis>");
                                out.println("<capability><![CDATA[" + ns_obj.getCapability() + "]]></capability>");
                                out.println("<payment><![CDATA[" + ns_obj.getPayment() + "]]></payment>");
                                out.println("<trait><![CDATA[" + ns_obj.getTrait() + "]]></trait>");
                                out.println("<depreciate><![CDATA[" + ns_obj.getDepreciate() + "]]></depreciate>");
                                out.println("<practicehours><![CDATA[" + ns_obj.getPracticeHours() + "]]></practicehours>");
                                out.println("<address><![CDATA[" + ns_obj.getAddress() + "]]></address>");
                                out.println("<picture><![CDATA[" + ns_obj.getPicture() + "]]></picture>");
                                out.println("<principal><![CDATA[" + ns_obj.getPrincipal() + "]]></principal>");
                                out.println("<phone><![CDATA[" + ns_obj.getPhone() + "]]></phone>");
                                out.println("<fax><![CDATA[" + ns_obj.getFax() + "]]></fax>");
                                out.println("<postalcode><![CDATA[" + ns_obj.getPostalcode() + "]]></postalcode>");
                                out.println("<cooperate><![CDATA[" + ns_obj.getCooperate() + "]]></cooperate>");
                                out.println("<sponsor><![CDATA[" + ns_obj.getSponsor() + "]]></sponsor>");
                                out.println("<acreage><![CDATA[" + ns_obj.getAcreage() + "]]></acreage>");
                                out.println("<averageconsume><![CDATA[" + ns_obj.getAverageConsume() + "]]></averageconsume>");
                                out.println("<consume><![CDATA[" + ns_obj.getConsume() + "]]></consume>");
                                out.println("<price><![CDATA[" + ns_obj.getPrice() + "]]></price>");
                                out.println("<among><![CDATA[" + ns_obj.getAmong() + "]]></among>");
                                out.println("<operation><![CDATA[" + ns_obj.getOperation() + "]]></operation>");
                                out.println("<loo><![CDATA[" + ns_obj.getLoo() + "]]></loo>");
                                out.println("<destine><![CDATA[" + ns_obj.getDestine() + "]]></destine>");
                                out.println("<block><![CDATA[" + ns_obj.getBlock() + "]]></block>");
                                out.println("<covercharge><![CDATA[" + ns_obj.getCoverCharge() + "]]></covercharge>");
                                out.println("<member><![CDATA[" + ns_obj.getMember() + "]]></member>");

                                // out.println("<browse><![CDATA[" + ns_obj.getBrowse() + "]]></browse>");
                                out.println("<email><![CDATA[" + ns_obj.getEmail() + "]]></email>");
                                out.println("<ticket><![CDATA[" + ns_obj.getTicket() + "]]></ticket>");
                                out.println("<holisticmark><![CDATA[" + ns_obj.getHolisticMark() + "]]></holisticmark>");
                                out.println("<auramark><![CDATA[" + ns_obj.getAuraMark() + "]]></auramark>");
                                out.println("<servemark><![CDATA[" + ns_obj.getServeMark() + "]]></servemark>");
                                out.println("<musicmark><![CDATA[" + ns_obj.getMusicMark() + "]]></musicmark>");
                                out.println("<crowdmark><![CDATA[" + ns_obj.getCrowdMark() + "]]></crowdmark>");
                                out.println("<drinkmark><![CDATA[" + ns_obj.getDrinkMark() + "]]></drinkmark>");
                                out.println("<delimark><![CDATA[" + ns_obj.getDeliMark() + "]]></delimark>");
                                out.println("<toiletmark><![CDATA[" + ns_obj.getToiletMark() + "]]></toiletmark>");
                                out.println("<relaxmark><![CDATA[" + ns_obj.getRelaxMark() + "]]></relaxmark>");
                                out.println("<lamplightmark><![CDATA[" + ns_obj.getLamplightMark() + "]]></lamplightmark>");
                                out.println("<temperaturemark><![CDATA[" + ns_obj.getTemperatureMark() + "]]></temperaturemark>");
                                out.println("<airmark><![CDATA[" + ns_obj.getAirMark() + "]]></airmark>");
                                out.println("<safetymark><![CDATA[" + ns_obj.getSafetyMark() + "]]></safetymark>");
                                out.println("<bellemark><![CDATA[" + ns_obj.getBelleMark() + "]]></bellemark>");
                                out.println("<pricemark><![CDATA[" + ns_obj.getPriceMark() + "]]></pricemark>");
                                out.println("<degreemark><![CDATA[" + ns_obj.getDegreeMark() + "]]></degreemark>");
                                out.println("<map><![CDATA[" + ns_obj.getMap() + "]]></map>");
                                out.println("</NightShop>");
                                break;
                            case 50:
                                Job j_obj = Job.find(node_id,language);
                                out.println("<Job>");

                                // out.println("<refcode><![CDATA[" + j_obj.getTxtRefCode() + "]]></refcode>");
                                out.println("<orgid><![CDATA[" + j_obj.getOrgId() + "]]></orgid>");
                                out.println("<jobtype><![CDATA[" + j_obj.getJobType() + "]]></jobtype>");

                                // out.println("<occid><![CDATA[" + j_obj.getOccId(";") + "]]></occid>");
                                out.println("<validitydate><![CDATA[" + j_obj.getValidityDateToString() + "]]></validitydate>");
                                out.println("<headcount><![CDATA[" + j_obj.getHeadCount() + "]]></headcount>");
                                out.println("<salaryid><![CDATA[" + j_obj.getSalaryId() + "]]></salaryid>");

                                // out.println("<locid><![CDATA[" + j_obj.getLocId(";") + "]]></locid>");
                                out.println("<reqwyearid><![CDATA[" + j_obj.getReqWyearId() + "]]></reqwyearid>");
                                out.println("<reqdeg><![CDATA[" + j_obj.getReqDegId() + "]]></reqdeg>");

                                // out.println("<jobduty><![CDATA[" + j_obj.getJobDuty() + "]]></jobduty>");
                                out.println("<adcode><![CDATA[" + j_obj.getAdcode() + "]]></adcode>");
                                out.println("</Job>");
                                break;

                            }
                            out.println("</Item>");
                        }
                        out.println("</Layer>");
                        enumer = TypePicture.findByNode(node_id);
                        out.println("<TypePicture>");
                        while(enumer.hasMoreElements())
                        {
                            int tp_id = ((Integer) enumer.nextElement()).intValue();
                            TypePicture tp_obj = TypePicture.findByPrimaryKey(tp_id);
                            out.println("<Item>");
                            out.println("<picture><![CDATA[" + tp_obj.getPicture() + "]]></picture>");
                            out.println("<picname><![CDATA[" + tp_obj.getPicname() + "]]></picname>");
                            out.println("<picture2><![CDATA[" + tp_obj.getPicture2() + "]]></picture2>");
                            out.println("<width><![CDATA[" + tp_obj.getWidth() + "]]></width>");
                            out.println("<height><![CDATA[" + tp_obj.getHeight() + "]]></height>");
                            out.println("</Item>");
                        }
                        out.println("</TypePicture>");
                        out.println("</Node>");
                    }
                }
                out.println("</ROOT>");
                return;
            }

            Http h = new Http(request);
            TeaSession teasession = new TeaSession(request);
            AccessMember am = AccessMember.find(h.node,teasession._rv);
            if(am.getPurview() < 1)
            {
                outLogin(request,response,h);
                return;
            }
            Node node = Node.find(h.node);
            if("GET".equals(request.getMethod()))
            {
                response.sendRedirect("/jsp/general/CloneNode.jsp?" + request.getQueryString());
            } else
            {
                RV rv = teasession._rv;
                if(rv == null)
                {
                    rv = new RV("<" + request.getRemoteAddr() + ">");
                }
                String dn = request.getParameter("dn");
                if(dn == null) // 本地复制
                {
                    String template = request.getParameter("template");
                    String listing = request.getParameter("listing");
                    String section = request.getParameter("section");
                    if(template != null && (template = template.trim()).length() > 0)
                    {
                        int i = Integer.parseInt(template);
                        if(!Node.isExisted(i))
                        {
                            outText(teasession,response,super.r.getString(teasession._nLanguage,"InvalidTemplate"));
                            return;
                        }
                        boolean cs = request.getParameter("clonesections") != null;
                        boolean cl = request.getParameter("clonelistings") != null;
                        int co = -1;
                        String temp = request.getParameter("clonesons");
                        if(temp != null)
                        {
                            co = Integer.parseInt(temp);
                        }
                        Node.clone(i,h.node,cs,cl,co,rv,null);
                    } else if(listing != null && (listing = listing.trim()).length() > 0) // 列举复制
                    {
                        int i = Integer.parseInt(listing);
                        Listing obj = Listing.find(i);
                        if(!obj.isExisted())
                        {
                            outText(teasession,response,super.r.getString(teasession._nLanguage,"InvalidListingNumber"));
                            return;
                        }
                        obj.clone(h.node,h.status);
                    } else if(section != null && (section = section.trim()).length() > 0) // 段落复制
                    {
                        int i = Integer.parseInt(section);
                        Section obj = Section.find(i);
                        if(obj.time == null)
                        {
                            outText(teasession,response,super.r.getString(teasession._nLanguage,"InvalidSectionNumber"));
                            return;
                        }
                        obj.clone(h.node,h.status);
                    } else if(request.getParameter("cssjs") != null) // CssJs复制
                    {
                        int i = Integer.parseInt(request.getParameter("cssjs").trim());
                        CssJs obj = CssJs.find(i);
                        if(!obj.isExists())
                        {
                            outText(teasession,response,super.r.getString(teasession._nLanguage,"InvalidParameter"));
                            return;
                        }
                        obj.clone(h.node,h.status);
                    }
                } else
                {
                    int i = Integer.parseInt(request.getParameter("template").trim());
                    String sessionid = teasession.getSession().getId() + "-" + Math.random();
                    int port = Integer.parseInt(request.getParameter("port"));
                    boolean cs = request.getParameter("clonesections") != null;
                    boolean cl = request.getParameter("clonelistings") != null;
                    boolean cc = request.getParameter("clonecssjs") != null;
                    boolean co = request.getParameter("clonesons") != null;
                    Node.clone(dn,port,i,h.node,h.status,cs,cc,cl,co,rv,sessionid);
                    Clonetemp.correct(sessionid,null);
                }
                response.sendRedirect("Node?node=" + h.node);
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
        super.r.add("/tea/ui/node/general/CloneNode");
    }
}
