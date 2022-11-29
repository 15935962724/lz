package tea.ui.node.general;

import java.io.*;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.zip.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.*;

import tea.entity.*;
import tea.entity.admin.AdminUsrRole;
import tea.entity.admin.orthonline.NodePoints;
import tea.entity.bbs.BBSForum;
import tea.entity.bbs.BBSLevel;
import tea.entity.integral.IntegralRecord;
import tea.entity.member.Logs;
import tea.entity.member.Profile;
import tea.entity.node.AccessMember;
import tea.entity.node.AccessRequest;
import tea.entity.node.Aded;
import tea.entity.node.AdedCounter;
import tea.entity.node.Ading;
import tea.entity.node.Author;
import tea.entity.node.Book;
import tea.entity.node.BuyPrice;
import tea.entity.node.Career;
import tea.entity.node.Category;
import tea.entity.node.Classified;
import tea.entity.node.Commodity;
import tea.entity.node.Event;
import tea.entity.node.Financing;
import tea.entity.node.Forum;
import tea.entity.node.Friend;
import tea.entity.node.Hostel;
import tea.entity.node.Investor;
import tea.entity.node.Listing;
import tea.entity.node.Media;
import tea.entity.node.News;
import tea.entity.node.NightShop;
import tea.entity.node.Node;
import tea.entity.node.access.*;
import tea.entity.node.Page;
import tea.entity.node.QuizA;
import tea.entity.node.QuizQ;
import tea.entity.node.Report;
import tea.entity.node.Section;
import tea.entity.node.Talkback;
import tea.entity.node.TalkbackReply;
import tea.entity.node.Tender;
import tea.entity.node.TypePicture;
import tea.entity.node.Weather;
import tea.entity.site.Community;
import tea.entity.site.DNS;
import tea.entity.site.Dynamic;
import tea.entity.site.Example;
import tea.entity.site.Frame;
import tea.entity.site.JoinRequest;
import tea.entity.site.License;
import tea.entity.site.TypeAlias;
import tea.html.Anchor;
import tea.html.Break;
import tea.html.Button;
import tea.html.Cell;
import tea.html.Form;
import tea.html.HiddenField;
import tea.html.Image;
import tea.html.Radio;
import tea.html.Row;
import tea.html.Span;
import tea.html.Text;
import tea.html.TextField;
import tea.htmlx.FPNL;
import tea.http.RequestHelper;
import tea.resource.Common;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;
import tea.entity.site.Html;
import tea.db.ConnectionPool;

public class NodeServlet extends TeaServlet
{
    public String getBuy(Node node,int i,RV rv,int j,boolean flag) throws SQLException
    {
        StringBuilder text = new StringBuilder();
        Commodity commodity = Commodity.find(i);
        if(commodity.getSKU() != null)
        {
            Text text1 = new Text(r.getString(j,"Vendor") + ": ");
            text1.setId("BuyLabel");
            text.append(text1);
            Text text2 = new Text(hrefGlance(node.getCreator()));
            text2.setId("BuyValue");
            text.append(text2);
            Text text3 = new Text(r.getString(j,"Quality") + ": ");
            text3.setId("BuyLabel");
            text.append(text3);
            Text text4 = new Text(r.getString(j,Commodity.QUALITY[commodity.getQuality()]));
            text4.setId("BuyValue");
            text.append(text4);
            boolean flag1 = (node.getOptions1() & 1) != 0;
            tea.html.Table table = new tea.html.Table();
            table.setCellPadding(3);
            table.setTitle(r.getString(j,"BuyPList") + "\n" + r.getString(j,"BuyPPrice") + "\n" + r.getString(j,"Saving") + "\n" + r.getString(j,"Quantity") + "\n");
            Form form;
            for(Enumeration enumeration = BuyPrice.find(i);enumeration.hasMoreElements();table.add(form))
            {
                int k = ((Integer) enumeration.nextElement()).intValue();
                BuyPrice buyprice = BuyPrice.find(i,k);
                int l = buyprice.getConvertCurrency();
                String s = r.getString(j,Common.CURRENCY[k]);
                form = new Form("foOffer" + k,"GET","/servlet/OfferBuy");
                form.setOnSubmit("return(submitInteger(this.Quantity,'" + r.getString(j,"InvalidQuantity") + "')" + "&&submitFloat(this.Price,'" + r.getString(j,"InvalidPrice") + "')" + ");");
                form.add(new HiddenField("Node",i));
                form.add(new HiddenField("Currency",k));
                form.add(new HiddenField("ConvertCurrency",l));
                BigDecimal bigdecimal = buyprice.getList();
                Row row = new Row();
                Text text5 = new Text(s + bigdecimal);
                text5.setId("BuyListPrice");
                Cell cell = new Cell(text5);
                cell.setAlign(2);
                row.add(cell);
                Cell cell1 = new Cell();
                if(flag1)
                {
                    cell1.add(new Text(s));
                    cell1.add(new TextField("Price","",4));
                    row.add(cell1);
                    row.add(new Cell());
                } else
                {
                    BigDecimal bigdecimal1 = buyprice.getPrice();
                    cell1.add(new HiddenField("Price",bigdecimal1));
                    Text text6 = new Text(s + bigdecimal1);
                    text6.setId("BuyOurPrice");
                    cell1.add(text6);
                    cell1.setAlign(2);
                    row.add(cell1);
                    if(bigdecimal.compareTo(new BigDecimal(0.0D)) != 0)
                    {
                        Text text8 = new Text(bigdecimal.subtract(bigdecimal1).divide(bigdecimal,4).multiply(new BigDecimal(100D)) + "%");
                        text8.setId("BuySavePercentage");
                        Cell cell2 = new Cell(text8);
                        cell2.setAlign(3);
                        row.add(cell2);
                    } else
                    {
                        row.add(new Cell());
                    }
                }
                row.add(new Cell(new TextField("Quantity",commodity.getDefaultQuantity(),4)));
                row.add(new Cell(new Button(0,"CB","CBAddToShoppingCart",r.getString(j,"CBAddToShoppingCart"),"")));
                BigDecimal bigdecimal2 = buyprice.getPoint();
                if(bigdecimal2.compareTo(new BigDecimal(0.0D)) != 0)
                {
                    Text text7 = new Text();
                    Text text9 = new Text();
                    Cell cell3 = new Cell();
                    cell3.add(new Text("(" + r.getString(j,"ConvertCurrencyPoint") + "<font>" + r.getString(j,Common.CURRENCY[l]) + "</font>" + r.getString(j,"Points") + ":"));
                    int i1 = buyprice.getOptions();
                    if(i1 == 0)
                    {
                        text7.add(new Text(" " + buyprice.getPrice().multiply(bigdecimal2).setScale(2)));
                    }
                    if(i1 == 1)
                    {
                        text7.add(new Text(" " + bigdecimal2));
                    }
                    text7.setId("BuyOurPrice");
                    text9.add(new Text(")"));
                    cell3.add(text7);
                    cell3.add(text9);
                    row.add(cell3);
                } else
                {
                    row.add(new Cell(new Text("  ")));
                }
                form.add(row);
            }
            text.append(table);
        }
        if(flag && node.isCreator(rv))
        {
            text.append(new Button(1,"CB","CBEditBuy",r.getString(j,"CBEditBuy"),"window.open('/servlet/EditBuy?node=" + i + "', '_self');"));
            text.append(new Button(1,"CB","CBPrices",r.getString(j,"CBPrices"),"window.open('/servlet/BuyPrices?node=" + i + "', '_self');"));
        }
        return text.toString();
    }

    public String getBook(Node node,int i,RV rv,int j,boolean flag) throws SQLException
    {
        StringBuffer text = new StringBuffer();
        text.append(getAuthor(node,i,0,rv,j,flag));
        text.append(new Break());
        text.append(getAuthor(node,i,1,rv,j,flag));
        text.append(new Break());
        Book book = Book.find(i);
        String s = book.getISBN();
        // System.out.println("Node");
        if(s != null)
        {
            String s1 = book.getSubTitle(j);
            if(s1.length() != 0)
            {
                Text text1 = new Text(s1);
                text1.setId("BookSubTitle");
                text.append(text1);
                text.append(new Break());
            }
            String s2 = book.getCollection(j);
            if(s2.length() != 0)
            {
                Text text2 = new Text(s2);
                text2.setId("BookCollection");
                text.append(text2);
                text.append(new Break());
            }
            String s3 = book.getPublisher(j);
            Text text3 = new Text(); // mapNode(s3, 23, j)
            text3.setId("BookPublisher");
            text.append(text3);
            Text text4 = new Text("ISBN: " + s);
            text4.setId("BookISBN");
            text.append(text4);
            Text text5 = new Text(" " + r.getString(j,"Price") + ": " + r.getString(j,"RMB") + book.getPrice());
            text5.setId("BookPrice");
            text.append(text5);
            text.append(new Break());
            Text text6 = new Text(r.getString(j,Book.BOOK_BINDING[book.getBinding()]) + " ");
            text6.setId("BookBinding");
            text.append(text6);
            int k = book.getAmountWord();
            if(k != 0)
            {
                Text text7 = new Text(r.getString(j,"AmountWord") + ": " + k + r.getString(j,"KiloWord") + " ");
                text7.setId("BookAmountWord");
                text.append(text7);
            }
            int l = book.getAmountPage();
            if(l != 0)
            {
                Text text8 = new Text(r.getString(j,"AmountPage") + ": " + l + " ");
                text8.setId("BookAmountPage");
                text.append(text8);
            }
            Text text9 = new Text(r.getString(j,"PublishDate") + ": " + (new SimpleDateFormat("yyyy.MM")).format(book.getPublishDate()) + " ");
            text9.setId("BookPublishDate");
            text.append(text9);
            Text text10 = new Text(r.getString(j,"Reprint") + ": " + book.getReprint() + " ");
            text10.setId("BookReprint");
            text.append(text10);
            text.append(new Break());
            String s4 = book.getCIPI(j);
            if(s4.length() != 0)
            {
                Text text11 = new Text(s4 + " ");
                text11.setId("BookCIPI");
                text.append(text11);
            }
            String s5 = book.getCIPII(j);
            if(s5.length() != 0)
            {
                Text text12 = new Text(s5 + " ");
                text12.setId("BookCIPII");
                text.append(text12);
            }
            String s6 = book.getCIPIII(j);
            if(s6.length() != 0)
            {
                Text text13 = new Text(s6 + " ");
                text13.setId("BookCIPIII");
                text.append(text13);
            }
            String s7 = book.getCIPIV(j);
            if(s7.length() != 0)
            {
                Text text14 = new Text(s7 + " ");
                text14.setId("BookCIPIV");
                text.append(text14);
            }
            text.append(new Break());
            String s8 = book.getReader(j);
            if(s8.length() != 0)
            {
                Text text15 = new Text(s8 + " ");
                text15.setId("BookReader");
                text.append(text15);
                text.append(new Break());
            }
            String s9 = book.getAnnotation(j);
            if(s9.length() != 0)
            {
                Text text16 = new Text(s9 + " ");
                text16.setId("BookReader");
                text.append(text16);
                text.append(new Break());
            }
        }
        if(flag && node.isCreator(rv))
        {
            text.append(new Button(1,"CB","CBEditBook",r.getString(j,"CBEditBook"),"window.open('EditBook?node=" + i + "', '_self');"));
        }
        text.append(new Break());
        return text.toString();
    }

    public String getClassified(Node node,int i,Http h,boolean flag) throws SQLException
    {
        StringBuffer text = new StringBuffer();
        Classified classified = Classified.find(i);
        int j = h.language;
        String s = classified.getContact(j);
        if(s != null)
        {
            tea.html.Table table = new tea.html.Table();
            if(s.length() != 0)
            {
                Row row = new Row(new Cell(new Text(r.getString(j,"Contact") + ":"),true));
                row.add(new Cell(s));
                table.add(row);
            }
            String s1 = classified.getEmail(j);
            if(s1.length() != 0)
            {
                Row row1 = new Row(new Cell(new Text(r.getString(j,"EmailAddress") + ":"),true));
                row1.add(new Cell(hrefNewMessage(s1)));
                table.add(row1);
            }
            String s2 = classified.getOrganization(j);
            if(s2.length() != 0)
            {
                Row row2 = new Row(new Cell(new Text(r.getString(j,"Organization") + ":"),true));
                row2.add(new Cell(new Text(s2)));
                table.add(row2);
            }
            String s3 = classified.getAddress(j);
            if(s3.length() != 0)
            {
                Row row3 = new Row(new Cell(new Text(r.getString(j,"Address") + ":"),true));
                row3.add(new Cell(new Text(s3)));
                table.add(row3);
            }
            String s4 = classified.getCity(j);
            if(s4.length() != 0)
            {
                Row row4 = new Row(new Cell(new Text(r.getString(j,"City") + ":"),true));
                row4.add(new Cell(new Text(s4)));
                table.add(row4);
            }
            String s5 = classified.getState(j);
            if(s5.length() != 0)
            {
                Row row5 = new Row(new Cell(new Text(r.getString(j,"State") + ":"),true));
                row5.add(new Cell(new Text(s5)));
                table.add(row5);
            }
            String s6 = classified.getZip(j);
            if(s6.length() != 0)
            {
                Row row6 = new Row(new Cell(new Text(r.getString(j,"Zip") + ":"),true));
                row6.add(new Cell(new Text(s6)));
                table.add(row6);
            }
            String s7 = classified.getCountry(j);
            if(s7.length() != 0)
            {

                Row row7 = new Row(new Cell(new Text(r.getString(j,"Country") + ":"),true));
                row7.add(new Cell(new Text(s7)));
                table.add(row7);
            }
            String s8 = classified.getTelephone(j);
            if(s8.length() != 0)
            {
                Row row8 = new Row(new Cell(new Text(r.getString(j,"Telephone") + ":"),true));
                row8.add(new Cell(new Text(s8)));
                table.add(row8);
            }
            String s9 = classified.getFax(j);
            if(s9.length() != 0)
            {
                Row row9 = new Row(new Cell(new Text(r.getString(j,"Fax") + ":"),true));
                row9.add(new Cell(new Text(s9)));
                table.add(row9);
            }
            String s10 = classified.getWebPage(j);
            if(s10.length() != 0)
            {
                Row row10 = new Row(new Cell(new Text(r.getString(j,"WebPage") + ":"),true));
                row10.add(new Cell(new Anchor((s10.toLowerCase().startsWith("http://") ? "" : "http://") + s10,s10,"_blank")));
                row10.add(new Cell(r.getString(j,Common.LANGUAGE[classified.getWebLanguage(j)])));
                table.add(row10);
            }
            text.append(table);
        }
        text.append(new tea.html.Button(Button.BUTTON,"","","?ù??????λ","window.open('/jsp/type/job/JobList.jsp?node=" + i + "','_self');"));
        if(flag && node.isCreator(h.member))
        {
            text.append(new Button(1,"CB","CBEditClassified",r.getString(j,"CBEditClassified"),"window.open('EditClassified?node=" + i + "', '_self');"));
        }
        return text.toString();
    }

    public String getFriend(Node node,int i,RV rv,int j,boolean flag) throws SQLException
    {
        StringBuffer text = new StringBuffer();
        Friend friend = Friend.find(i);
        tea.html.Table table = new tea.html.Table();
        Row row = new Row(new Cell(new Text(r.getString(j,"Gender") + ":"),true));
        row.add(new Cell(r.getString(j,Friend.FRIEND_GENDER[friend.getGender()])));
        table.add(row);
        Row row1 = new Row(new Cell(new Text(r.getString(j,"PrefGender") + ":"),true));
        row1.add(new Cell(r.getString(j,Friend.FRIEND_GENDER[friend.getPrefGender()])));
        table.add(row1);
        Row row2 = new Row(new Cell(new Text(r.getString(j,"Relationship") + ":"),true));
        Cell cell = new Cell();
        int k = friend.getRelationship();
        for(int l = 0;l < Friend.FRIEND_RELATIONSHIP.length;l++)
        {
            if((k & 1 << l) != 0)
            {
                cell.add(new Text(r.getString(j,Friend.FRIEND_RELATIONSHIP[l]) + " "));
            }
        }
        row2.add(cell);
        table.add(row2);
        Row row3 = new Row(new Cell(new Text(r.getString(j,"Ethnicity") + ":"),true));
        row3.add(new Cell(r.getString(j,Friend.FRIEND_ETHNICITY[friend.getEthnicity()])));
        table.add(row3);
        Row row4 = new Row(new Cell(new Text(r.getString(j,"Education") + ":"),true));
        row4.add(new Cell(r.getString(j,Friend.FRIEND_EDUCATION[friend.getEducation()])));
        table.add(row4);
        Row row5 = new Row(new Cell(new Text(r.getString(j,"Employment") + ":"),true));
        row5.add(new Cell(r.getString(j,Friend.FRIEND_EMPLOYMENT[friend.getEmployment()])));
        table.add(row5);
        Row row6 = new Row(new Cell(new Text(r.getString(j,"Religion") + ":"),true));
        row6.add(new Cell(r.getString(j,Friend.FRIEND_RELIGION[friend.getReligion()])));
        table.add(row6);
        Row row7 = new Row(new Cell(new Text(r.getString(j,"Hobbies") + ":"),true));
        Cell cell1 = new Cell();
        int i1 = friend.getHobbies();
        for(int j1 = 0;j1 < Friend.FRIEND_HOBBIES.length;j1++)
        {
            if((i1 & 1 << j1) != 0)
            {
                cell1.add(new Text(r.getString(j,Friend.FRIEND_HOBBIES[j1]) + " "));
            }
        }
        row7.add(cell1);
        table.add(row7);
        Row row8 = new Row(new Cell(new Text(r.getString(j,"BodyType") + ":"),true));
        row8.add(new Cell(r.getString(j,Friend.FRIEND_BODYTYPE[friend.getBodyType()])));
        table.add(row8);
        Row row9 = new Row(new Cell(new Text(r.getString(j,"Age") + ":"),true));
        row9.add(new Cell(new Text(Integer.toString(friend.getAge()))));
        table.add(row9);
        Row row10 = new Row(new Cell(new Text(r.getString(j,"Height") + ":"),true));
        row10.add(new Cell(new Text(Integer.toString(friend.getHeight()))));
        table.add(row10);
        Row row11 = new Row(new Cell(new Text(r.getString(j,"Smoke") + ":"),true));
        row11.add(new Cell(r.getString(j,Friend.FRIEND_SMOKE[friend.getSmoke()])));
        table.add(row11);
        Row row12 = new Row(new Cell(new Text(r.getString(j,"Drink") + ":"),true));
        row12.add(new Cell(r.getString(j,Friend.FRIEND_DRINK[friend.getDrink()])));
        table.add(row12);
        Row row13 = new Row(new Cell(new Text(r.getString(j,"Children") + ":"),true));
        row13.add(new Cell(r.getString(j,Friend.FRIEND_CHILDREN[friend.getChildren()])));
        table.add(row13);
        text.append(table);
        if(flag && node.isCreator(rv))
        {
            text.append(new Button(1,"CB","CBEditFriend",r.getString(j,"CBEditFriend"),"window.open('EditFriend?node=" + i + "', '_self');"));
        }
        return text.toString();
    }

    public String getBid(Node node,int i,RV rv,int j,boolean flag) throws SQLException
    {
        StringBuffer text = new StringBuffer();
        Commodity commodity = Commodity.find(i);
        if(commodity.getSKU() != null)
        {
            Text text1 = new Text(r.getString(j,"Vendor") + ": ");
            text1.setId("BuyLabel");
            text.append(text1);
            Text text2 = new Text(hrefGlance(node.getCreator()));
            text2.setId("BuyValue");
            text.append(text2);
            Text text3 = new Text(r.getString(j,"Quality") + ": ");
            text3.setId("BuyLabel");
            text.append(text3);
            Text text4 = new Text(r.getString(j,Commodity.QUALITY[commodity.getQuality()]));
            text4.setId("BuyValue");
            text.append(text4);
        }
        if(flag && node.isCreator(rv))
        {
            text.append(new Button(1,"CB","CBEditBid",r.getString(j,"CBEditBid"),"window.open('EditBid?node=" + i + "', '_self');"));
            text.append(new Button(1,"CB","CBBidPrices",r.getString(j,"CBBidPrices"),"window.open('BidPrices?node=" + i + "', '_self');"));
        }
        return text.toString();
    }

    public String getCenter(HttpServletRequest request,HttpServletResponse response,Http h,Node node,int pos,boolean editmode) throws SQLException,IOException
    {
        StringBuilder h1 = new StringBuilder();
        int type = node.getType();
        long options = node.getOptions();
        int i1 = node.getOptions1();
        RV rv = h.username == null ? null : new RV(h.username);
        int nodeid = h.node;
        int lang = h.language;
        boolean flag1 = node.isCreator(rv);
        String community = node.getCommunity();
        int father = node.getFather();
        boolean flag2 = false;
        boolean flag3 = false;
        boolean flagm = false;
        if(rv != null)
        {
            flag2 = rv.isOrganizer(community);
            flag3 = rv.isWebMaster();
            flagm = rv.isManager(community);
        }
        boolean flag4 = (options & 0x100) == 0 || AccessMember.find(nodeid,rv).getPurview() > -1; // 0x100->NodeOAccessMember
        if(flag4)
        {
            if((options & 0x80) != 0) // ??????
            {
                switch(type)
                {
                case 1: // ?????
                    h1.append(getCategory(node,nodeid,rv,lang,editmode));
                    break;
                case 3: // '\003'

                    // text.append(getPoll(node, nodeid, rv, j, editmode, path));
                    break;
                case 4: // '\004'
                    h1.append(getBuy(node,nodeid,rv,lang,editmode));
                    break;
                case 5: // '\005'
                    h1.append(getBid(node,nodeid,rv,lang,editmode));
                    break;
                case 8: // '\b'
                    h1.append(getChat(node,nodeid,rv,lang,editmode));
                    break;
                case 9: // '\t'
                    h1.append(getQuiz(node,nodeid,rv,lang,editmode));
                    break;
                case 12: // '\f'
                    h1.append(getBook(node,nodeid,rv,lang,editmode));
                    break;
                case 13: // '\r'
                    h1.append(getNews(node,nodeid,rv,lang,editmode));
                    break;
                case 14: // '\016'
                    h1.append(getWeather(node,nodeid,rv,lang,editmode));
                    break;
                case 15: // '\017'

                    // text.append(getStock(node, nodeid, rv, j, teasession, flag));
                    break;
                case 16: // '\020'
                case 17: // '\021'
                case 18: // '\022'
                case 19: // '\023'
                case 20: // '\024'
                case 21: // '\025'
                case 22: // '\026'
                case 23: // '\027'
                case 24: // '\030'
                case 25: // '\031'
                case 26: // '\032'
                case 27: // '\033'
                case 28: // '\034'
                    h1.append(getClassified(node,nodeid,h,editmode));
                    break;
                case 29: // '\035'
                case 30: // '\036'

                    // text.append(getCareer(node, nodeid, rv, j, flag));
                    h1.append(getFinancing(node,h));
                    break;
                case 31: // '\037'
                    h1.append(getFriend(node,nodeid,rv,lang,editmode));
                    break;
                case 37: // ??
                    h1.append(getEvent(node,h,editmode));
                    break;
                case 45: // ???
                    h1.append(getNightShop(node,nodeid,h,editmode));
                    break;
                case 48: // ???
                    h1.append(getHostel(node,nodeid,rv,lang,editmode));
                    break;
                case 50: // job

                    // text.append(getJob(node, teasession));
                    break;
                case 51: // ??????
                    h1.append(getInvestor(node,h));
                    break;
                }
            }
        } else
        {
            h1.append(r.getString(lang,"NodeOAccessMember"));
        }
        if((options & 0x40000) != 0) //显示父亲节点的内容
        {
            int k1 = father;
            if(k1 != 0)
            {
                Node node1 = Node.find(k1);
                if(node1.getType() == 1)
                {
                    k1 = node1.getFather();
                }
            }
            if(k1 != 0)
            {
                h1.append(getSections(Node.find(k1),h.status,rv,lang,6,false,editmode));
            }
        }
        if(flag4 && (options & 0x80) != 0) // NodeOShowBriefing
        {
            boolean flag5 = false;
            boolean flag6 = false;
            String s1 = r.getString(lang,"FileExtensionGraphics");
            boolean flag7 = false;
            boolean flag9 = false;
            String s3 = r.getString(lang,"FileExtensionVoices");
            String s4 = node.getSrcUrl(lang);
            String s5 = node.getSrcUrlx(lang);
            String clickurl = node.getClickUrl(lang);
            String pictrue = node.getPicture(lang);
            if(pictrue != null && pictrue.length() > 0) // ???????
            {
                if(clickurl != null)
                {
                    h1.append(new Anchor(clickurl,new Image(pictrue,node.getAlt(lang),node.getAlign(lang))).toString());
                } else
                {
                    h1.append(new Image(pictrue,node.getAlt(lang),node.getAlign(lang)).toString());
                }
            } else
            {
                if(s4 != null && s4.lastIndexOf(".") >= 1 && s4.lastIndexOf("/") < s4.lastIndexOf("."))
                {
                    for(StringTokenizer stringtokenizer = new StringTokenizer(s1," ,");stringtokenizer.hasMoreTokens();)
                    {
                        String s6 = stringtokenizer.nextToken();
                        if(s6.equalsIgnoreCase(s4.substring(s4.lastIndexOf(".") + 1)))
                        {
                            flag5 = true;
                            break;
                        }
                    }
                    if(flag5)
                    {
                        if(clickurl != null)
                        {
                            h1.append(new Anchor(clickurl,new Image(s4,node.getAlt(lang),node.getAlign(lang))).toString());
                        } else
                        {
                            h1.append(new Image(s4,node.getAlt(lang),node.getAlign(lang)).toString());
                        }
                    }
                }
                if(!flag5 && s5 != null && s5.lastIndexOf(".") >= 1 && s5.lastIndexOf("/") < s5.lastIndexOf("."))
                {
                    for(StringTokenizer stringtokenizer1 = new StringTokenizer(s1," ,");stringtokenizer1.hasMoreTokens();)
                    {
                        String s7 = stringtokenizer1.nextToken();
                        if(s7.equalsIgnoreCase(s5.substring(s5.lastIndexOf(".") + 1)))
                        {
                            flag6 = true;
                            break;
                        }
                    }
                    if(flag6)
                    {
                        if(clickurl != null)
                        {
                            h1.append(new Anchor(clickurl,new Image(s5,node.getAlt(lang),node.getAlign(lang))).toString());
                        } else
                        {
                            h1.append(new Image(s5,node.getAlt(lang),node.getAlign(lang)).toString());
                        }
                    }
                }
            }
            String voice = node.getVoice(lang);
            if(voice != null && voice.length() > 0) // ?????????
            {
                h1.append(new Button(1,"CB","CBPlay",r.getString(lang,"CBPlay"),"window.open('" + voice + "', '_self');").toString());
            } else
            {
                if(s4 != null && s4.lastIndexOf(".") >= 1 && s4.lastIndexOf("/") < s4.lastIndexOf("."))
                {
                    for(StringTokenizer stringtokenizer2 = new StringTokenizer(s3," ,");stringtokenizer2.hasMoreTokens();)
                    {
                        String s8 = stringtokenizer2.nextToken();
                        if(s8.equalsIgnoreCase(s4.substring(s4.lastIndexOf(".") + 1)))
                        {
                            flag7 = true;
                            break;
                        }
                    }
                    if(flag7)
                    {
                        h1.append(new Button(1,"CB","CBPlay",r.getString(lang,"CBPlay"),"window.open('" + s4 + "', '_self');").toString());
                    }
                }
                if(!flag7 && s5 != null && s5.lastIndexOf(".") >= 1 && s5.lastIndexOf("/") < s5.lastIndexOf("."))
                {
                    for(StringTokenizer stringtokenizer3 = new StringTokenizer(s3," ,");stringtokenizer3.hasMoreTokens();)
                    {
                        String s9 = stringtokenizer3.nextToken();
                        if(s9.equalsIgnoreCase(s5.substring(s5.lastIndexOf(".") + 1)))
                        {
                            flag9 = true;
                            break;
                        }
                    }
                    if(flag9)
                    {
                        h1.append(new Button(1,"CB","CBPlay",r.getString(lang,"CBPlay"),"window.open('" + s5 + "', '_self');").toString());
                    }
                }
            }
            String file = node.getFile(lang);
            if(file != null && file.length() > 1) // ????????
            {
                h1.append(new Anchor(file,node.getFileName(lang)).toString());
                h1.append(new Button(1,"CB","CBDownload",r.getString(lang,"CBDownload"),"window.open('" + file + "', '_self');").toString());
            } else
            {
                if(s4 != null && !flag5 && !flag7 && s4.lastIndexOf(".") >= 1 && s4.lastIndexOf("/") < s4.lastIndexOf("."))
                {
                    Anchor anchor = new Anchor(s4,s4.substring(s4.lastIndexOf("/") + 1));
                    anchor.setTarget("_blank");
                    h1.append(anchor.toString());
                }
                if((s4 == null || s4.length() == 0) && s5 != null && !flag6 && !flag9 && s5.lastIndexOf(".") >= 1 && s5.lastIndexOf("/") < s5.lastIndexOf("."))
                {
                    Anchor anchor1 = new Anchor(s5,s5.substring(s5.lastIndexOf("/") + 1));
                    anchor1.setTarget("_blank");
                    h1.append(anchor1.toString());
                }
            }
            String content = node.getText2(lang);
            if(content.length() != 0 && type != 50) // ...&&????????????????job??
            {
                if((options & 0x40) == 0)
                {
                    content = Text.toHTML(content);
                }
                h1.append("<div id=\"Briefing\">" + content + "</div>");
            }
        }
        // Text text1 = getSections(nodeid, rv, j, 6, true, flag);
        // text1.setId(Node.NODE_TYPE[type] + "Section");
        // text.add(text1);
        int l1 = h.getInt("pos");
        if(l1 < 0)
            l1 = 0;

        output(h,h1.toString());
        h1.append(getContent(h,node,6,1,pos,editmode));
        StringBuilder h2 = new StringBuilder();

        if(flag4) // ??\u6743\uFFFD\uFFFD
        {
            boolean flag8 = (options & 0x800000) != 0; // ????????б?
            boolean flag10 = (options & 0x100000) != 0; // ??????????б?
            if(flag8 || flag10)
            {
                int k2 = Node.countSons(nodeid,rv);
                StringBuilder sbSons = new StringBuilder("<ul id=\"SonList\">");
                for(Enumeration enumeration2 = Node.findSons(nodeid,rv,0,25);enumeration2.hasMoreElements();) // table.add(new Row(cell)))
                {
                    int i4 = ((Integer) enumeration2.nextElement()).intValue();
                    // cell = new Cell();
                    sbSons.append("<li>");
                    if(flag8) // ???????
                    {
                        Node node4 = Node.find(i4);
                        sbSons.append(node4.getAnchor(lang).toString()); // + getDetailText(node4, i4, j, "SonDetail", " ").toString());
                        // cell.add(node4.getAnchor(j, "Son"));
                        // cell.add(getDetailText(node4, i4, j, "SonDetail", " "));
                        boolean flag14 = node4.isCreator(rv);
                        if(flag14)
                        {
                            if(node4.getType() >= 1024)
                            {
                                sbSons.append(new Button(1,"CB","CBEditNode",r.getString(lang,"CBEditNode"),"window.open('/jsp/type/dynamicvalue/EditDynamicValue.jsp?node=" + i4 + "');"));
                            } else if(node4.getType() == 0 || node4.getType() == 1)
                            {
                                sbSons.append(new Button(1,"CB","CBEditNode",r.getString(lang,"CBEditNode"),"window.open('/servlet/EditNode?node=" + i4 + "');"));
                            } else
                            {
                                sbSons.append(new Button(1,"CB","CBEditNode",r.getString(lang,"CBEditNode"),"window.open('/jsp/type/" + Node.NODE_TYPE[node4.getType()].toLowerCase() + "/Edit" + Node.NODE_TYPE[node4.getType()] + ".jsp?node=" + i4 + "');"));
                            }
                        }
                        if((flag2 || flag1 || flag14) && node4.isLayerExisted(lang))
                        {
                            sbSons.append(new Button(1,"CB","CBDeleteNode",r.getString(lang,"CBDeleteNode"),"if(confirm('" + r.getString(lang,"ConfirmDeleteTree") + "')){window.open('/servlet/DeleteNode?node=" + i4 + "', '_self');this.disabled=true;}"));
                        }
                        if(node4.isHidden() && flag1)
                        {
                            sbSons.append(new Button(1,"CB","CBGrant",r.getString(lang,"CBGrant"),"window.open('/servlet/GrantNodeRequests?Go=Grant&amp;node=" + nodeid + "&amp;NodeRequests=" + i4 + "', '_self');"));
                            sbSons.append(new Button(1,"CB","CBDeny",r.getString(lang,"CBDeny"),"if(confirm('" + r.getString(lang,"ConfirmDeleteTree") + "')){window.open('/servlet/GrantNodeRequests?Go=Deny&amp;node=" + nodeid + "&amp;NodeRequests=" + i4 + "', '_self');}"));
                        }
                    }
                    if(flag10) // ?????????
                    {
                        int i5 = Node.countSons(i4,null);
                        if(i5 > 0)
                        {
                            sbSons.append("<ul>");
                            for(Enumeration enumeration4 = Node.findSons(i4,null,0,5);enumeration4.hasMoreElements();)
                            {
                                int k5 = ((Integer) enumeration4.nextElement()).intValue();
                                Node node5 = Node.find(k5);
                                if((node5.getOptions() & 0x100) == 0 || AccessMember.find(k5,rv._strV).getPurview() != -1)
                                {
                                    sbSons.append("<li>" + node5.getAnchor(lang) + "</li>"); // getDetailText(node5, k5, j, "GrandSonDetail", " ") +
                                }
                            }
                            if(i5 > 5)
                            {
                                sbSons.append("<li> ...</li>"); // cell.add(new Text(" ..."));
                            }
                            sbSons.append("</ul>");
                        }
                    }
                    sbSons.append("</li>");
                }
                sbSons.append("</ul>");
                // if (table.getContentCount() > 0)
                {
                    h1.append(sbSons.toString()); // table);
                    if(k2 > 25)
                    {
                        h2.append(new Button(1,"CB","CBMore",r.getString(lang,"CBMore"),"window.open('/jsp/general/SonNodes.jsp?node=" + nodeid + "', '_self');").toString());
                    }
                }
            }
        }
        // ???? --> ???
//        String s9 = getSections(nodeid,h.status,rv,lang,9,false,editmode);
//        StringBuilder text4 = null;
//        if(s9.length() > 0)
//        {
//            Table table1 = new Table();
//            table1.setWidth("100%");
//            Row row = new Row();
//            Cell cell1 = new Cell(new Text(text.toString()));
//            cell1.setId("Content");
//            row.add(cell1);
//            Cell cell2 = new Cell(s9);
//            cell2.setId("Direction");
//            row.add(cell2);
//            table1.add(row);
//            text4 = new StringBuilder(table1.toString());
//        } else
//        {
//            text4 = text;
//        }
        if(flag4 && type == 12)
        {
            for(Enumeration enumeration = Node.findSons(nodeid,rv,0,25);enumeration.hasMoreElements();)
            {
                int l2 = ((Integer) enumeration.nextElement()).intValue();
                Node node2 = Node.find(l2);
                if(node2.getType() == 1)
                {
                    h2.append(new Break(2).toString());
                    h2.append(new Text("<HR SIZE=1>").toString());
                    h2.append(node2.getAnchor(lang).toString());
                    h2.append(new Break().toString());
                    h2.append(getCategory(node2,l2,rv,lang,editmode).toString());
                }
            }
            Enumeration enumeration1 = Author.findByNodeType(nodeid,0);
            if(enumeration1.hasMoreElements())
            {
                int j3 = ((Integer) enumeration1.nextElement()).intValue();
                Author author = Author.find(j3);
                String s10 = author.getName(lang);
                String s11 = s10;
                int j5 = 0;
                try
                {
                    j5 = Integer.parseInt(s10);
                } catch(Exception exception1)
                {
                }
                if(j5 != 0)
                {
                    s11 = Node.find(j5).getSubject(lang);
                }
                h2.append(new Break(2).toString());
                h2.append(new Text("<hr size='1'>").toString());
                h2.append(new Text(RequestHelper.format(r.getString(lang,"AllBooksBy"),new Anchor("/servlet/Search?Type=12&amp;ByStyle=1&amp;By=" + s10 + "&amp;ByText=" + s11,s11))).toString());
            }
        }
        /*
           if(type != 3 && (options & 0x20000) != 0) //准许投票
           {
         h2.append(new Break(2).toString());
         h2.append(new Text("<hr id='HRPollVote' size='1'>").toString());
           // h2.append(new Button("PollIDVote",r.getString(lang,"Poll"),"window.open('/jsp/type/poll/EditPollNode.jsp?node=" + h.node + "');").toString());
         h2.append("<include src=\"/jsp/type/poll/EditPollNode.jsp?node="+h.node+"\"/>");


           }
         */
        if((options & 0x100000000L) != 0 && rv != null && Listing.isBriefcaseExisted(rv))
        {
            h2.append(new Button(1,"CB","CBAddToBriefcase",r.getString(lang,"CBAddToBriefcase"),"window.open('/servlet/AddToBriefcase?node=" + nodeid + "&amp;language=" + lang + "');").toString());
        }
        if((options & 0x200000000L) != 0)
        {
            h2.append(new Button(1,"CB","CBAddToFavorites",r.getString(lang,"CBAddToFavorites"),"window.open('/servlet/AddToFavorite?node=" + nodeid + "&amp;language=" + lang + "');").toString());
        }
        if((options & 0x400000000L) != 0)
        {
            h2.append(new Button(1,"CB","CBAddToContact",r.getString(lang,"CBAddToContact"),"window.open('/jsp/friend/AddToFriend.jsp?node=" + nodeid + "&amp;language=" + lang + "');").toString()); // /servlet/AddToContact?node=
        }
        if((options & 0x800000000L) != 0)
        {
            h2.append(new Button(1,"CB","CBAddToReminder",r.getString(lang,"CBAddToReminder"),"window.open('/servlet/AddToReminder?node=" + nodeid + "&amp;language=" + lang + "');").toString());
        }
        if((options & 0x200) != 0 && ((options & 0x4000) != 0 || h.member != 0))
        {
            int j2 = Talkback.count(nodeid);
            if(j2 != 0)
            {
                int postb = h.getInt("postb");
                h2.append(new Text("<HR id=\"HRTalkback\" SIZE=\"1\">").toString());
                tea.html.Table table2 = new tea.html.Table();
                table2.setId("TalkbackIndex");
                table2.setCellSpacing(0);
                table2.setTitle("\n" + r.getString(lang,"Subject") + "\n" + r.getString(lang,"Time") + "\n" + r.getString(lang,"Poster") + "\n" + r.getString(lang,"Reply") + "\n");
                Row row1;
                for(Enumeration enumeration3 = Talkback.find(nodeid,postb,15);enumeration3.hasMoreElements();)
                {
                    int j4 = ((Integer) enumeration3.nextElement()).intValue();
                    Talkback talkback = Talkback.find(j4);
                    RV rv1 = talkback.getCreator();
                    boolean bool = rv != null && (flag1 || rv1.equals(rv));
                    if(!bool && talkback.getHidden() == 0)
                    {
                        continue;
                    }
                    Date date = talkback.getTime();
                    talkback.getStatus();
                    row1 = new Row("<IMG SRC=/tea/image/hint/" + talkback.getHint() + ".gif>" + talkback.getAnchor(lang).toString());
                    row1.add(new Cell(new Text("<font>" + (new SimpleDateFormat("yyyy.MM.dd HH:mm aaa")).format(date) + "</font>")));
                    // row1.add(new Cell(new Text(hrefGlanceWithName(rv1, j))));
                    row1.add(new Cell(new Text(rv1.toString())));
                    row1.add(new Cell(new Text(String.valueOf(TalkbackReply.countByTalkback(j4)))));
                    if(bool)
                    {
                        row1.add(new Cell(new Button(1,"CB","CBDeleteTalkback",r.getString(lang,"CBDeleteTalkback"),"if(confirm('" + r.getString(lang,"ConfirmDelete") + "')){window.open('/servlet/DeleteTalkback?node=" + nodeid + "&amp;talkback=" + j4 + "&amp;act=delete', '_self');this.disabled=true;}")));
                    }
                    table2.add(row1);
                }
                int count = Talkback.count(nodeid);
                if(count > 15)
                {
                    Cell cell1 = new Cell(new FPNL(h.language,"/servlet/Node?node=" + h.node + "&amp;language=" + h.language + "&amp;postb=",pos,count,15));
                    cell1.setColSpan(4);
                    table2.add(new Row(cell1));
                }
                h2.append(table2.toString());
            }
        }
        h1.append(output(h,h2.toString()));
        return h1.toString();
    }

    public static String getBackStyle()
    {
        return "<style>#EditTop{background:#fff;}#EditTop td{font-size:12px;white-space:nowrap;word-break:keep-all;}.edn_dtable{height:63px;}" + "#edn_pic{height:37px;background-image:url(/tea/image/editpage/080945722.jpg);background-repeat:no-repeat;background-position:left 0px;width:240px;}.edn_sectr td{border-top:3px solid #67A7E3;background:#D6E9F8;height:23px;}"
                + "#folder2{width:63px;height:30px;line-height:30px;text-decoration:none; color:#000;vertical-align: bottom;text-align:center;display:block;float:left;}#currentfolder2{display:block;float:left;width:63px;height:30px;line-height:30px;color:#000;vertical-align: bottom;text-align:center;font-weight:550;}"
                + "#person,#person2{vertical-align:middle;background-image:url();background-repeat:no-repeat;line-height:20px;height:20px;text-decoration:none;margin-bottom:5px;margin-right:8px;color:#0E5FD8;width:50px;}</style>";
    }

    public static String getButton(Node node,Http h,AccessMember obj_am,HttpServletRequest request) throws SQLException,IOException
    {
        RV rv = h.username == null ? null : new RV(h.username);
        License license = License.getInstance();
        Resource r = new Resource();
        int i = h.node;
        int language = h.language;
        int k = node.getType();
        long l = node.getOptions();
        int i1 = node.getOptions1();
        boolean flag1 = node.isCreator(rv);
        String s = node.getCommunity();
        int j1 = node.getFather();
        boolean flag2 = false;
        boolean flag3 = false;
        boolean flagm = false;
        boolean access_create = obj_am.getPurview() > 0;
        boolean access_edit = obj_am.getPurview() > 1;
        boolean access_del = obj_am.getPurview() > 2;
        boolean access_auditing = obj_am.isAuditing();

        String tf = request.getParameter("tf");
        boolean ov = "1".equals(tf);
        if(rv != null)
        {
            flag2 = rv.isOrganizer(s);
            flag3 = rv.isWebMaster();
            flagm = rv.isManager(s);
        }
        StringBuilder nb = new StringBuilder();
        StringBuilder d_structure = new StringBuilder();
        StringBuilder d_create = new StringBuilder();
        StringBuilder d_edit = new StringBuilder();
        nb.append("<div id='fm1' style='z-index:10;left:0px;position:fixed;top:0px;'><script>edn.menu();</script><table id=\"EditTop\" class=\"edn_dtable\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\">"
                  + "<tr bgcolor=\"#ffffff\">"
                  + "<td align=\"left\" id='edn_pic' ></td><td align=\"right\" id='sq'>" + r.getString(language,"Communitty") + "：" + s + "　" + (rv == null ? "游客" : rv._strR)
                  + "&nbsp;&nbsp;<select onchange=\"window.open('/servlet/SwitchLanguage?language='+value+'&amp;nexturl=" + java.net.URLEncoder.encode(request.getRequestURI() + "?" + request.getQueryString(),"UTF-8") + "','_self');\">");
        int wl = license.getWebLanguages();
        for(int j = 0;j < Common.LANGUAGE.length;j++)
        {
            if((wl & 1 << j) != 0)
            {
                nb.append("<option value=\"" + j + "\"");
                if(language == j)
                {
                    nb.append(" selected='true'");
                }
                nb.append(">" + r.getString(h.language,Common.LANGUAGE[j]) + "　&nbsp;&nbsp;</option>");
            }
        }
        nb.append("</select>&nbsp;&nbsp;<input type=\"button\" class=\"gManage\" name=\"manage_sys\" value=\"" + r.getString(language,"BSmanage") + "\" onclick=\"window.open('/jsp/admin/indextop.jsp','_self');\"/>");
        if(flag3)
        {
            //nb.append(" <input type='button' value='开始' class=\"gManage\" onclick=\"window.open('/jsp/admin/popedom/AdminFunctionGroup.jsp?community=" + h.community + "&amp;act=head');\" />"); //sys_menu(this,'ROOT')
        }
        nb.append("　　&nbsp;</td></tr><tr bgcolor=\"#ffffff\" class=\"edn_sectr\"><td width=\"30%\">");
        if(rv != null && (flag2 || flag3))
        {
            if(flag3) // ????? ???????
            {
                //系统
                nb.append("<label id=\"edn_ssystem\" class=\"menu\" onmouseover='edn.show1(this)' onmouseout='edn.hide1(this)'>" + r.getString(language,"System") + "</label>");
                nb.append("<div id=\"edn_dsystem\" class=\"submenu\" style='display:none' onmouseover='edn.show1(this)' onmouseout='edn.hide1(this)'>");
                nb.append("<a id=\"EditLicense\" href='/jsp/site/EditLicense.jsp?community=" + s + "&amp;language=" + language + "'>" + r.getString(language,"CBEditLicense") + "</a>");
                nb.append("<a id=\"MemberOverview\" href='/jsp/site/MemberOverview.jsp?community=" + s + "'>" + r.getString(language,"CBMemberOverview") + "</a>");
                nb.append("<a id=\"CBTypeAliases\" href='/jsp/site/TypeAliases.jsp?community=" + s + "&amp;language=" + language + "'>" + r.getString(language,"CBTypeAliases") + "</a>");
                nb.append("<a id=\"CBOrganizingCommunities\" href='/jsp/community/OrganizingCommunities.jsp?community=" + s + "&amp;language=" + language + "'>" + r.getString(language,"CBOrganizingCommunities") + "</a>");
                nb.append("<a id=\"Logout\" href='/servlet/Logout?community=" + h.community + "&amp;node=" + i + "'>" + r.getString(language,"Loggout") + "</a>");
                nb.append("</div>");
            }
            //社区
            nb.append("<label id=\"edn_scommunity\" class=\"menu\" onmouseover='edn.show1(this)' onmouseout='edn.hide1(this)'>" + r.getString(language,"Communitty") + "</label>");
            nb.append("<div id=\"edn_dcommunity\" class=\"submenu\" style='display:none' onmouseover='edn.show1(this)' onmouseout='edn.hide1(this)'>");
            // nb.append("<label id=\"CBSubscribers\" onclick=\"window.open('/jsp/community/Subscribers.jsp?community=" + s + "&amp;language=" + language + "');\" onmouseover=\"s_color(CBSubscribers);\" onmouseout=\"l_hid(CBSubscribers);\">　　" + r.getString(language,"CBSubscribers") + "</label> ");
            nb.append("<a id=\"CBSubscribers\" href='/jsp/community/EdnMember.jsp?community=" + s + "&amp;language=" + language + "'>" + r.getString(language,"CBSubscribers") + "</a>");
            nb.append("<a id=\"CBOrganizers\" href='/jsp/community/Organizers.jsp?community=" + s + "&amp;language=" + language + "'>" + r.getString(language,"CBOrganizers") + "</a>");
            nb.append("<a id=\"CBEditCommunity\" href='/jsp/community/EditCommunity.jsp?community=" + s + "&amp;language=" + language + "'>" + r.getString(language,"CBEditCommunity") + "</a>");
            nb.append("<a id=\"CBReplaceCreator\" href='/jsp/general/ReplaceCreator.jsp?community=" + s + "&amp;language=" + language + "'>" + r.getString(language,"CBReplaceCreator") + "</a>");
            if(JoinRequest.isExisted(s)) // ????????
            {
                nb.append("<a id=\"CBJoinRequests\" href='/servlet/JoinRequests?community=" + s + "&amp;language=" + language + "'>" + r.getString(language,"CBJoinRequests") + "</a>");
            }
            nb.append("<a id=\"editlistings\" href='###' onclick=\"openwindow('/jsp/site/VolumeUpdateListing.jsp?community=" + s + "','',500,250);\">" + r.getString(language,"修改列举") + "</a>");

            nb.append("<script>");
            nb.append("function openwindow(url,name,iWidth,iHeight){");

            nb.append("var url;"); //转向网页的地址;
            nb.append("var name;"); //网页名称，可为空;
            nb.append("var iWidth;"); //弹出窗口的宽度;
            nb.append("var iHeight;"); //弹出窗口的高度;
            nb.append("var iTop = (window.screen.availHeight-30-iHeight)/2;"); //获得窗口的垂直位置;
            nb.append("var iLeft = (window.screen.availWidth-10-iWidth)/2;"); //获得窗口的水平位置;
            nb.append("window.open(url,name,'height='+iHeight+',,innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+', toolbar=no,menubar=no,scrollbars=auto,resizeable=no,location=no,status=no');");

            nb.append("}");
            nb.append("</script>");
            nb.append("</div>");
        }
        boolean flag10 = (l & 0x8000) != 0; // ??????????????????
        // if (flag10 || ((rv != null) && ((l & 0x20) != 0)))
        // {
        // sb.append(new Button(1, "CB", "CBTalkbacks", r.getString(language, "CBTalkbacks"), "window.open('/servlet/Talkbacks?node=" + i + "&language=" + language + "');"));
        // }
        // if ((l & 0x10000) != 0)
        // {
        // sb.append(new Button(1, "CB", "CBChatRoom", r.getString(language, "CBChatRoom"), "window.open('/servlet/ChatFrameSet?node=" + i + "&language=" + language + "');"));
        // }
        // text4.add(new Button(1, "CB", "CBForward", r.getString(j, "CBForward"), "window.open('ForwardNode?node=" + i + "');"));//???
        // text4.add(new Button(1, "CB", "CBReplyToCreator", r.getString(j, "CBReplyToCreator"), "window.open('ReplyNode?node=" + i + "');"));//??????????
        boolean flag12 = false;
        if(k == 1)
        {
            flag12 = flag1; // (i1 & 1) != 0 || flag1 ///????????????,????????????
        } else if(j1 != 0)
        {
            Node node3 = Node.find(j1);
            flag12 = node3.isCreator(rv); // node3.getType() == 1 && (node3.getOptions1() & 1) != 0 || node3.isCreator(rv); ///????????????,????????????
        }
        if(obj_am.isProvider(0)) /* 创建文件夹 */
        {
            d_create.append("<a id=\"CBNewFolder\" href='/servlet/NewNode?Type=0&amp;node=" + i + "&amp;language=" + language + "'>" + r.getString(language,"CBNewFolder") + "</a>");
        }
        if(obj_am.isProvider(1)) /* 创建类别 */
        {
            d_create.append("<a id=\"CBNewCategory\" class=\"dline\" href='/servlet/NewNode?Type=1&amp;node=" + i + "&amp;language=" + language + "'>" + r.getString(language,"CBNewCategory") + "</a>");
        }

        //创建段落
        if(obj_am.getSection() != null && obj_am.getSection().indexOf("/0/") != -1)
        {
            d_create.append("<a id=\"CBNewSection\" href='/jsp/section/EditSection.jsp?node=" + i + "&amp;status=" + h.status + "&amp;language=" + language + "&amp;section=0'>" + r.getString(language,"CBNewSection") + "</a>");
        }
        //创建段落
        if(obj_am.getListing() != null && obj_am.getListing().indexOf("/0/") != -1)
        {
            d_create.append("<a id=\"CBNewListing\" class=\"dline\" href='/jsp/listing/EditListing.jsp?node=" + i + "&amp;status=" + h.status + "&amp;language=" + language + "&amp;listing=0'>" + r.getString(language,"CBNewListing") + "</a>");
        }
        if(obj_am.getCssjs() != null && obj_am.getCssjs().indexOf("/0/") != -1)
        {
            d_create.append("<a id=\"CBNewCSS\" href='/jsp/section/EditCssJs.jsp?node=" + i + "&amp;status=" + h.status + "&amp;language=" + language + "&amp;cssjs=0'>" + r.getString(language,"CBNewCSS/JS") + "</a>");
        }

        if(k >= 1)
        {
            int node_code = k == 1 ? i : j1;
            Category category = Category.find(node_code);
            int j3 = category.getCategory();

            if(flag12 || rv != null && obj_am.isProvider(j3) || flagm)
            {
                String name,url;
                if(j3 < 1024)
                {
                    name = r.getString(language,"CBNew" + Node.NODE_TYPE[j3]);
                } else
                {
                    if(j3 < 65535)
                    {
                        Dynamic dynamic = Dynamic.find(j3);
                        name = dynamic.getName(language);
                    } else
                    {
                        TypeAlias ta = TypeAlias.find(j3);
                        name = ta.getName(language);
                        j3 = ta.getType();
                    }
                    name = r.getString(language,"CBNew") + name;
                }
                if((j3 == 3 || j3 == 4 || j3 == 11 || j3 == 12 || j3 == 15 || j3 == 21 || j3 == 28 || j3 >= 50 || j3 == 30 || j3 == 32 || j3 == 34 || j3 == 37 || j3 == 39 || j3 == 40 || j3 == 41 || j3 == 44 || j3 == 48) && j3 != 70 && j3 != 64) // 34->??? //64->???
                {
                    if(j3 == 34)
                    {
                        url = "/jsp/type/goods/SelectGoodsType.jsp";
                    } else if(j3 < 1024)
                    {
                        url = "/jsp/type/" + Node.NODE_TYPE[j3].toLowerCase() + "/Edit" + Node.NODE_TYPE[j3] + ".jsp";
                    } else
                    {
                        url = "/jsp/type/dynamicvalue/EditDynamicValue.jsp";
                    }
                } else
                {
                    url = "/jsp/general/EditNode.jsp";
                }
                /* 创建新闻 */
                d_create.append("<a id=\"CBNew\" href='" + url + "?NewNode=ON&amp;Type=" + j3 + "&amp;node=" + node_code + "'>" + name + "</a>");
            }
        }

        // ////////////////////////////////////////////////////------------------------------
        if(rv != null && rv.isAdManager() && Ading.find(node,h.status, -1,true).size() > 0)
        {
            d_edit.append("<a id=\"CBAdeds\" href='/jsp/aded/Adeds.jsp?node=" + i + "&amp;language=" + language + "'>" + r.getString(language,"CBAdeds") + "</a>");
        }
        if(flag1 || access_edit)
        {
            String url;
            if(k >= 65535)
            {
                k = TypeAlias.find(k).getType();
            }
            if(k < 1024) // ?????
            {
                File file = new File(Http.REAL_PATH + "/jsp/type/" + Node.NODE_TYPE[k].toLowerCase() + "/Edit" + Node.NODE_TYPE[k] + ".jsp");
                if(k < 3 || k == 64 || !file.exists())
                {
                    url = "/jsp/general/EditNode.jsp?node=" + i + "&amp;EditNode=ON";
                } else
                {
                    url = "/jsp/type/" + Node.NODE_TYPE[k].toLowerCase() + "/Edit" + Node.NODE_TYPE[k] + ".jsp?node=" + i;
                }
            } else
            {
                url = "/jsp/type/dynamicvalue/EditDynamicValue.jsp?Type=" + k + "&amp;node=" + i;
            }
            d_edit.append("<a id=\"editt\" href='" + url + "'>" + r.getString(language,"CBEdit") + "</a>");
        }
        if(flag1 || access_create)
        {
            d_edit.append("<a id='CBClone' href='/jsp/node/NodeClone.jsp?node=" + i + "'>" + r.getString(language,"CBClone") + "</a>");
            d_edit.append("<a id=\"CBMove\" href='/jsp/general/MoveNode.jsp?node=" + i + "&amp;language=" + language + "'>" + r.getString(language,"CBMove") + "</a>");
        }
        boolean flag13 = node.getFather() > 0 && Node.find(node.getFather()).isCreator(rv);
        if((access_del || flag2 || flag3 || flag1 || flag13) && node.isLayerExisted(language)) // ???
        {
            d_edit.append("<a id=\"del\" href='###' onclick=\"if(confirm('" + r.getString(language,"ConfirmDeleteTree") + "')){window.location.href='/servlet/DeleteNode?node=" + i + "&amp;language=" + language + "';this.disabled=true;};\">" + r.getString(language,"CBDelete") + "</a>");
        }
        if(access_auditing || flag2 || flag13 || flag1 && !node.isHidden())
        {
            d_edit.append("<a id=\"CBSetVisible\" class=\"dline\" href='/jsp/general/SetVisible.jsp?node=" + i + "&amp;language=" + language + "'>" + r.getString(language,"CBSetVisible") + "</a>");
        }
        if(flag1 || access_create)
        {
            d_edit.append("<a id=\"CBSonNodes\" href='/jsp/general/SonNodes.jsp?node=" + i + "&amp;language=" + language + "'>" + r.getString(language,"CBSonNodes") + "</a>");
            /*
             * if(ov) //单击结构 显示节点 { Enumeration enumer = Node.findTopSon(i,20); int countf = Node.countSon(i); if(enumer.hasMoreElements()) { for(int sn = 1;enumer.hasMoreElements();sn++) { int id = ((Integer) enumer.nextElement()).intValue(); Node nd = Node.find(id); if(sn < 20) //记录数 { java.util.Enumeration enumer2 = Node.findTopSon(id,20);
             *
             * if(enumer2.hasMoreElements()) { d_structure.append("<label id=fa_" + id + " class=thcorn onclick=\"window.open('/servlet/Folder?node=" + id + "&amp;language=" + language + "') onmouseover=\"c_jax(" + id + ");\" tid=setTimeout('show1(fa_" + id + ",son_" + id + ")',10);\" onmouseout=fa_" + id + ".className='thcorn';son_" + id + ".style.display='none';clearTimeout(tid);> "); if(nd.getSubject(language).length() > 6) { d_structure.append(nd.getSubject(language).substring(0,6) + "..."); } else {
             * d_structure.append(nd.getSubject(language)); } d_structure.append("</label> "); d_structure.append("<span id=show_" + id + "><div id=son_" + id + " class=submenu style=display:none onmouseover=son_" + id + ".style.display='';fa_" + id + ".className='nsubmenu1';edn_dstructure.style.display=''; onmouseout=fa_" + id + ".className='thcorn';son_" + id + ".style.display='none';></div></span>"); // d_structure.append("<div id=son_" + id + " class=submenu style=display:none
             * onmouseover=son_" + id + ".style.display='';fa_" + id + ".className='nsubmenu1';edn_dstructure.style.display=''; onmouseout=fa_" + id + ".className='thcorn';son_" + id + ".style.display='none';>"); // for(int d2 = 1;enumer2.hasMoreElements();d2++) //二级下拉菜单 // { // int sid = ((Integer) enumer2.nextElement()).intValue(); // // Node ndd = Node.find(sid); // if(d2 < 11) // { // d_structure.append("<span id=ds_" + sid + " onclick=\"window.open('/servlet/Folder?node=" + sid +
             * "&language=" + 1 + "');\" onmouseover=s_color(ds_" + sid + "); onmouseout=l_shid(ds_" + sid + ");>&nbsp;&nbsp;&nbsp;"); // if(ndd.getSubject(language).length() > 26) // { // d_structure.append(ndd.getSubject(language).substring(0,25) + "..."); // } else // { // d_structure.append(ndd.getSubject(language)); // } // d_structure.append("</span>"); // // if(d2 == counts) // { // d_structure.append("<span id=pic class=cen onclick=\"window.open('/jsp/general/SonNodes.jsp?node=" + id +
             * "&language=" + language + "');\" onmouseover=\"this.className='cenc';\" onmouseout=\"this.className='cen';\"><img src=\"/tea/image/editpage/080923193.gif\"/>更多子级</span>"); // break; // } // } else // { // d_structure.append("<span id=pic class=cen onclick=\"window.open('/jsp/general/SonNodes.jsp?node=" + id + "&language=" + language + "');\" onmouseover=\"this.className='cenc';\" onmouseout=\"this.className='cen';\"><img src=\"/tea/image/editpage/080923193.gif\"/>更多子级</span>"); //
             * break; // } // } // d_structure.append("</div>"); } else { d_structure.append("<label id=fa_" + id + " onclick=\"window.open('/servlet/Folder?node=" + id + "&language=" + 1 + "');\" onmouseover=s_color(fa_" + id + "); onmouseout=l_hid(fa_" + id + ");> "); if(nd.getSubject(language).length() > 7) { d_structure.append(nd.getSubject(language).substring(0,6) + "..."); } else { d_structure.append(nd.getSubject(language)); } d_structure.append("</label>"); } if(sn == countf) {
             * d_structure.append("<label id=pic class=cen onclick=\"window.open('/jsp/general/SonNodes.jsp?node=" + i + "&language=" + language + "');\" onmouseover=\"this.className='cenc';\" onmouseout=\"this.className='cen';\"><img src=\"/tea/image/editpage/080923193.gif\"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;更多子级</label>"); break; } } else { d_structure.append("<label id=pic class=cen onclick=\"window.open('/jsp/general/SonNodes.jsp?node=" + i + "&language=" + language + "');\"
             * onmouseover=\"this.className='cenc';\" onmouseout=\"this.className='cen';\"><img src=\"/tea/image/editpage/080923193.gif\"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;更多子级</label>"); break; } } } }
             */

            if(flag1 || access_del)
            {
                d_edit.append("<a id=\"CBAccessPrices\" href='/jsp/access/AccessPrices.jsp?node=" + i + "&amp;language=" + language + "'>" + r.getString(language,"CBAccessPrices") + "</a>");
                d_edit.append("<a id=\"CBAccessMembers\" href='/jsp/access/AccessMembers.jsp?node=" + i + "&amp;language=" + language + "'>" + r.getString(language,"CBAccessMembers") + "</a>");
                if(AccessRequest.isExisted(i))
                {
                    d_edit.append("<a id=\"CBAccessRequests\" class=\"dline\" href='/servlet/AccessRequests?node=" + i + "&amp;language=" + language + "'>" + r.getString(language,"CBAccessRequests") + "</a>");
                }
                d_edit.append("<a id=\"EON\" class=\"dline\" href='/jsp/eon/EditEonNode.jsp?node=" + i + "&amp;language=" + language + "'>" + r.getString(language,"EON") + "</a>");
                //创建css/js
                // d_create.append("<label id=CBNewCSS onclick=\"window.location.href='/jsp/section/EditCssJs.jsp?node=" + i + "&status=" + h.status + "&language=" + language + "&cssjs=0';\" onmouseover=s_color(CBNewCSS); onmouseout=l_hid(CBNewCSS);>　　" + r.getString(language,"CBNewCSS/JS") + "</label> ");


                //创建段落
                //	d_create.append("<label id=CBNewSection onclick=\"window.location.href='/jsp/section/EditSection.jsp?node=" + i + "&status=" + h.status + "&language=" + language + "&section=0';\" onmouseover=s_color(CBNewSection); onmouseout=l_hid(CBNewSection);>　　" + r.getString(language,"CBNewSection") + "</label> ");


                //创建列举
                // d_create.append("<label id=CBNewListing class=dline onclick=\"window.location.href='/jsp/listing/EditListing.jsp?node=" + i + "&status=" + h.status + "&language=" + language + "&listing=0'; onmouseover=s_color(CBNewListing);\" onmouseout=l_hid(CBNewListing);>　　" + r.getString(language,"CBNewListing") + "</label> ");

                //模版
                ArrayList ee = Example.find("",0,20);
                if(ee.size() > 0)
                {
                    d_create.append("<a id=\"Template\" class=\"thcorn\" href='/jsp/site/Examples.jsp?node=" + i + "&amp;status=" + h.status + "&amp;language=" + language + "' onmouseover='edn.show2(this)' onmouseout='edn.hide2(this)'>" + r.getString(language,"Template") + "</a>");
                    d_create.append("<div id=\"tem\" class=\"submenu\" style='display:none;' onmouseover='edn.show2(this)' onmouseout='edn.hide2(this)'>");
                    for(int j = 0;j < ee.size();j++)
                    {
                        Example e = (Example) ee.get(j);
                        int id = e.getExample();
                        String picture = e.getPicture();
                        if(picture != null)
                            d_create.append("<img src=\"" + picture + "\" id='img" + id + "' style='background:#FFFFFF;visibility:hidden;position:absolute;filter:revealtrans(duration=0.5);' />");
                        d_create.append("<a id=\"tems\" onmouseover='edn.snap(event,img" + id + ")' onmouseout='edn.snap(event,img" + id + ")' href='/servlet/EditExample?node=" + i + "&amp;act=use&amp;example=" + id + "'>" + e.getSubject() + "</a>");
                    }
                    d_create.append("</div>");
                }
            }

            //所有段落
            if(obj_am.getSection() != null && obj_am.getSection().indexOf("/0/") != -1 || obj_am.getSection().indexOf("/1/") != -1 || obj_am.getSection().indexOf("/2/") != -1)
            {
                d_edit.append("<a id=\"CBSections\" href='/jsp/section/Sections.jsp?node=" + i + "&amp;status=" + h.status + "&amp;language=" + language + "'>" + r.getString(language,"CBSections") + "</a>");
            }
            //所有列举
            if(obj_am.getListing() != null && obj_am.getListing().indexOf("/0/") != -1 || obj_am.getListing().indexOf("/1/") != -1 || obj_am.getListing().indexOf("/2/") != -1 || obj_am.getListing().indexOf("/3/") != -1)
            {
                d_edit.append("<a id=\"CBListings\" href='/jsp/listing/Listings.jsp?node=" + i + "&amp;status=" + h.status + "&amp;language=" + language + "'>" + r.getString(language,"CBListings") + "</a>");
            }
            //所有的CSS/js
            if(obj_am.getCssjs() != null && obj_am.getCssjs().indexOf("/0/") != -1 || obj_am.getCssjs().indexOf("/1/") != -1 || obj_am.getCssjs().indexOf("/2/") != -1)
            {
                d_edit.append("<a id=\"CBCSS\" href='/jsp/section/CssJs.jsp?node=" + i + "&amp;status=" + h.status + "&amp;language=" + language + "'>" + r.getString(language,"CBCSS/JS") + "</a>");
            }
            if(flag1 || access_create)
            {
                d_edit.append("<a id=\"CBListeds\" href='/servlet/Listeds?node=" + i + "&amp;status=" + h.status + "&amp;language=" + language + "'>" + r.getString(language,"CBListeds") + "</a>");
            }
            if(flag1 || access_del)
            {
                if(rv != null && rv.isAdManager()) /* 征召广告 */
                {
                    d_create.append("<a id='adings' href='/jsp/ading/Adings.jsp?node=" + i + "&amp;status=" + h.status + "&amp;language=" + language + "'>" + r.getString(language,"CBAdings") + "</a>");
                }
            }
            if(access_edit)
            {
                d_edit.append("<a id='CBStatus' href=\"javascript:setCookie('status','" + (h.status != 0 ? 0 : 1) + "');location.reload();\">" + r.getString(language,h.status != 0 ? "普通版" : "手机版") + "</a>");
            }
        }
        // 结构DIV层

        // nb.append("<label id=\"edn_sstructure\" class=\"menu\" onclick=\"window.open(");
        // if(ov)
        // {
        // nb.append("'" + request.getRequestURI() + "?");
        // if(request.getQueryString().contains("tf="))
        // {
        // nb.append(request.getQueryString().replaceAll("tf=1","tf=0"));
        // } else
        // {
        // nb.append(request.getQueryString() + "&tf=0");
        // }
        // nb.append("','_self')\" onmouseover=\"show(edn_sstructure,edn_dstructure);\" onmouseout=\"sh(edn_sstructure,edn_dstructure);\">" + r.getString(language,"Structure") + "</label>");
        // } else
        // {
        // nb.append("'" + request.getRequestURI() + "?");
        // if(request.getQueryString().contains("tf="))
        // {
        // nb.append(request.getQueryString().replaceAll("tf=0","tf=1"));
        // } else
        // {
        // nb.append(request.getQueryString() + "&tf=1");
        // }
        // nb.append("','_self')\" onmouseover=\"edn_sstructure.className='show';\" onmouseout=\"edn_sstructure.className='';\">" + r.getString(language,"Structure") + "</label>");
        // }
        // if(d_structure != null && d_structure.length() > 0)
        // {
        // nb.append("<div id=\"edn_dstructure\" class=\"submenu\" style=\"display:none\" onmouseover=\"show(edn_sstructure,edn_dstructure);\" onmouseout=\"s_hid('edn_sstructure',edn_dstructure);\">");
        // nb.append(d_structure.toString());
        // nb.append("</div>");
        // }
        // 创建DIV层
        if(d_create.toString().length() > 0)
        {
            nb.append("<label id=\"edn_screate\" class=\"menu\" onmouseover='edn.show1(this)' onmouseout='edn.hide1(this)'>" + r.getString(language,"Create") + "</label>");
            nb.append("<div id=\"edn_dcreate\" class=\"submenu\" style='display:none' onmouseover='edn.show1(this)' onmouseout='edn.hide1(this)'>");
            nb.append(d_create.toString());
            nb.append("</div>");
        }
        // 编辑DIV层
        if(d_edit.toString().length() > 0)
        {
            nb.append("<label id=\"edn_sedit\" class=\"menu\" onmouseover='edn.show1(this)' onmouseout='edn.hide1(this)'>" + r.getString(language,"Edit") + "</label>");
            nb.append("<div id=\"edn_dedit\" class=\"submenu\" style='display:none;' onmouseover='edn.show1(this)' onmouseout='edn.hide1(this)'>");
            nb.append(d_edit.toString());
            nb.append("<a id='Structure' href='###' onclick=\"window.open('/jsp/site/StructureUpload.jsp?community=" + s + "','','width=500,height=250');\">" + r.getString(language,"上传图片") + "</a>");
            nb.append("</div>");
        }
        // 帮助DIV层
        nb.append("<label id=\"edn_shelp\" class=\"menu\" onmouseover='edn.show1(this)' onmouseout='edn.hide1(this)'>" + r.getString(language,"Help") + "</label>");
        nb.append("<div id=\"edn_dhelp\" class=\"submenu\" style='display:none' onmouseover='edn.show1(this)' onmouseout='edn.hide1(this)'>");
        nb.append("<a id=\"help\" href='###' onclick=\"window.open('/jsp/version/info.jsp','anyname','left=300,top=200,height=300,width=400');\">" + r.getString(language,"aboutEDN") + "</a>");
        nb.append("</div>");
        nb.append("</td><td id='lj'>" + r.getString(language,"Pach") + "：<span id=\"pathdiv\" style=\"display='inline'\">" + node.getAncestor(language,h.status) + " </span></td></tr></table></div>");
//        nb.append("\n<script>var fm1=document.getElementById(\"fm1\");setInterval('fm1.style.top=document.body.scrollTop;',100);"
//                  + "var cm=null;var am=null;var bm=null;function getPos(el,sProp)  {  var iPos = 0 ;  　　while (el!=null)   　　 {    iPos+=el[\"offset\" + sProp];   　　　　el = el.offsetParent;  }   　　return iPos;}  "
//                  + "function show(el,m)  {  if (m)  {    m.style.display=''; el.className='show'; m.style.left=m.style.pixelLeft = getPos(el,\"Left\") ;　m.style.top=m.style.pixelTop = 63;  }    　　if ((m!=cm) && (cm))   {    cm.style.display='none';  }  if(m == null){m.style.display='none';} cm=m; }  "
//                  + "function show1(el,m){if (m){m.style.display='';el.className='nsubmenu1';m.style.left=m.style.pixelLeft = 138 ;  m.style.top=m.style.pixelTop = el['offsetTop']-1;}if ((m!=am) && (am)){am.style.display='none';}if(m == null){m.style.display='none';}am=m;}"
//                  + "function s_color(el){if(el.className == 'dline'){el.className='submenu2';}else{el.className='submenu1';}} function l_hid(sp){if(sp.className=='submenu2'){sp.className='dline';}else{sp.className='';}} function l_shid(sp){sp.className='';}" + "function tt_show(){edn_dcreate.style.display=''; tem.style.display='';Template.className='nsubmenu1';} function tt_hid(){tem.style.display='none';Template.className='thcorn';}"
//                  + "function tem_hid(a,b){Template.className='thcorn'; tem.style.display='none';} function s_hid(sp,m){  document.getElementById(sp).className='menu';  m.style.display='none';}"
//                  + "function showSnap1(event,obj){ var left=139; var top=obj['offsetTop']; obj.style.left=left;  obj.style.top=top;  obj.filters.revealTrans.Transition = Math.random() * 200;  obj.filters.revealTrans.apply();  obj.style.visibility = event.type.indexOf('over')!=-1 ? 'visible' : 'hidden';  obj.filters.revealTrans.play();}" + "function sh(sp,sp1){sp.className='menu';sp1.style.display='none';}"
//                  + "function c_jax(me){ sendx(\"/jsp/admin/flow/NodeMenu_jax.jsp?id=\"+me,function(js){ eval(js); });}" + "</script>");
        nb.append("<div class='edn_dtable'></div>");
        return nb.toString();
    }


    public Text getPage(Node node,int i,RV rv,int j,boolean flag) throws SQLException
    {
        Text text = new Text();
        if(node.isCreator(rv))
        {
            if((node.getOptions1() & 1) != 0)
            {
                Page page = Page.find(i);
                text.add(new Text(r.getString(j,"RedirectUrl") + ": " + page.getRedirectUrl(j)));
            }
            if(flag)
            {
                text.add(new Button(1,"CB","CBEditPage",r.getString(j,"CBEditPage"),"window.open('EditPage?node=" + i + "', '_self');"));
            }
        }
        return text;
    }

    public String getChat(Node node,int i,RV rv,int j,boolean flag) throws SQLException
    {
        StringBuffer text = new StringBuffer();
        if(flag && node.isCreator(rv))
        {
            text.append(new Button(1,"CB","CBEditChat",r.getString(j,"CBEditChat"),"window.open('EditChat?node=" + i + "', '_self');"));
        }
        text.append(new Text(RequestHelper.format(r.getString(j,"InfToEnterChatRoom"),(new Anchor("/servlet/ChatFrameSet?node=" + i,r.getString(j,"ClickHere"),"_blank")).toString())));
        return text.toString();
    }

    public Text getAuthor(Node node,int i,int j,RV rv,int k,boolean flag) throws SQLException
    {
        Text text = new Text();
        boolean flag1 = node.isCreator(rv);
        Text text1 = new Text();
        for(Enumeration enumeration = Author.findByNodeType(i,j);enumeration.hasMoreElements();)
        {
            int l = ((Integer) enumeration.nextElement()).intValue();
            Author author = Author.find(l);
            // text1.add(new Text(mapNode(author.getName(k), j, k)));
            if(flag && flag1)
            {
                text1.add(new Button(1,"CB","CBDelete" + Author.AUTHOR_TYPE[j],r.getString(k,"CBDelete" + Author.AUTHOR_TYPE[j]),"if(confirm('" + r.getString(k,"ConfirmDelete") + "')){window.open('Delete" + Author.AUTHOR_TYPE[j] + "?node=" + i + "&amp;Author=" + l + "', '_self');this.disabled=true;};"));
            }
        }
        text1.setId("Author");
        text.add(text1);
        if(flag && node.isCreator(rv))
        {
            text.add(new Button(1,"CB","CBNew" + Author.AUTHOR_TYPE[j],r.getString(k,"CBNew" + Author.AUTHOR_TYPE[j]),"window.open('New" + Author.AUTHOR_TYPE[j] + "?node=" + i + "', '_self');"));
        }
        return text;
    }

    public String getCategory(Node node,int i,RV rv,int j,boolean flag) throws SQLException
    {
        StringBuffer text = new StringBuffer();
        Category category = Category.find(i);
        if(category.getCategory() == 4)
        {
            int k = Node.countSons(i,rv);
            if(k != 0)
            {
                tea.html.Table table = new tea.html.Table();
                table.setCellPadding(2);
                table.setTitle(r.getString(j,"Commodity") + "\n" + r.getString(j,"BuyPList") + "\n" + r.getString(j,"BuyPPrice") + "\n" + r.getString(j,"Saving") + "\n" + r.getString(j,"Quantity") + "\n");
                for(Enumeration enumeration = Node.findSons(i,rv,0,25);enumeration.hasMoreElements();)
                {
                    int l = ((Integer) enumeration.nextElement()).intValue();
                    Node node1 = Node.find(l);
                    if(((node1.getOptions() & 0x100) == 0 || AccessMember.find(l,rv._strV).getPurview() > -1) && node1.getType() == 4)
                    {
                        Commodity commodity = Commodity.find(l);
                        boolean flag1 = true;
                        Form form;
                        for(Enumeration enumeration1 = BuyPrice.find(l);enumeration1.hasMoreElements();table.add(form))
                        {
                            int i1 = ((Integer) enumeration1.nextElement()).intValue();
                            BuyPrice buyprice = BuyPrice.find(l,i1);
                            BigDecimal bigdecimal = buyprice.getList();
                            BigDecimal bigdecimal1 = buyprice.getPrice();
                            form = new Form("foOffer" + i1 + "." + l,"GET","/servlet/OfferBuy");
                            form.setOnSubmit("return(submitInteger(this.Quantity,'" + r.getString(j,"InvalidQuantity") + "')" + "&&submitFloat(this.Price,'" + r.getString(j,"InvalidPrice") + "')" + ");");
                            form.add(new HiddenField("Node",l));
                            form.add(new HiddenField("Currency",i1));
                            form.add(new HiddenField("Price",bigdecimal1));
                            Row row = new Row();
                            if(flag1)
                            {
                                row.add(new Cell(node1.getAnchor(j)));
                                flag1 = false;
                            } else
                            {
                                row.add(new Cell());
                            }
                            row.add(new Cell("<font>" + r.getString(j,Common.CURRENCY[i1]) + bigdecimal + "</font>"));
                            row.add(new Cell("<font>" + r.getString(j,Common.CURRENCY[i1]) + bigdecimal1 + "</font>"));
                            if(bigdecimal.compareTo(new BigDecimal(0.0D)) != 0)
                            {
                                Text text1 = new Text(bigdecimal.subtract(bigdecimal1).divide(bigdecimal,4).multiply(new BigDecimal(100D)) + "%");
                                text1.setId("BuySavePercentage");
                                row.add(new Cell(text1));
                            } else
                            {
                                row.add(new Cell());
                            }
                            row.add(new Cell(new TextField("Quantity",commodity.getDefaultQuantity(),4)));
                            row.add(new Cell(new Button(0,"CB","CBAddToShoppingCart",r.getString(j,"CBAddToShoppingCart"),"")));
                            BigDecimal bigdecimal2 = buyprice.getPoint();
                            int j1 = buyprice.getConvertCurrency();
                            if(bigdecimal2.compareTo(new BigDecimal(0.0D)) != 0)
                            {
                                Text text2 = new Text();
                                Text text3 = new Text();
                                Cell cell = new Cell();
                                cell.add(new Text("(" + r.getString(j,"ConvertCurrencyPoint") + "<font>" + r.getString(j,Common.CURRENCY[j1]) + "</font>" + r.getString(j,"Points") + ":"));
                                int k1 = buyprice.getOptions();
                                if(k1 == 0)
                                {
                                    text2.add(new Text(" " + buyprice.getPrice().multiply(bigdecimal2).setScale(2)));
                                }
                                if(k1 == 1)
                                {
                                    text2.add(new Text(" " + bigdecimal2));
                                }
                                text2.setId("BuyOurPrice");
                                text3.add(new Text(")"));
                                cell.add(text2);
                                cell.add(text3);
                                row.add(cell);
                            } else
                            {
                                row.add(new Cell(new Text("  ")));
                            }
                            form.add(row);
                        }
                    }
                }
                text.append(table);
            }
        }
        if(flag && node.isCreator(rv))
        {
            text.append(new Button(1,"CB","CBEditCategory",r.getString(j,"CBEditCategory"),"window.open('/servlet/EditCategory?node=" + i + "', '_self');"));
        }
        return text.toString();
    }

    public String getWeather(Node node,int i,RV rv,int j,boolean flag) throws SQLException
    {
        StringBuffer text = new StringBuffer();
        Weather aweather[] = new Weather[5];
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(new Date(System.currentTimeMillis()));
        calendar.set(11,0);
        calendar.set(12,0);
        calendar.set(13,0);
        calendar.set(14,0);
        tea.html.Table table = new tea.html.Table();
        table.setCellSpacing(5);
        Row row = new Row();
        row.setAlign(2);
        Row row1 = new Row();
        row1.setAlign(2);
        int k = 0;
        do
        {
            aweather[k] = Weather.find(i,calendar.getTime());
            int l = aweather[k].getType();
            int i1 = aweather[k].getLow();
            int j1 = aweather[k].getHigh();
            row.add(new Cell(new Text(r.getString(j,Weather.DAY_OF_WEEK[calendar.get(7)])),k != 0 ? "#FFCC99" : "#FF9900"));
            Cell cell = new Cell();
            String s = r.getString(j,Weather.WEATHER_TYPE[l]);
            cell.add(new Image("/tea/image/weather/" + l + ".gif",s));
            cell.add(new Break());
            cell.add(new Text(s));
            cell.add(new Break());
            cell.add(new Text(r.getString(j,"HighTemp") + " " + j1));
            cell.add(new Break());
            cell.add(new Text(r.getString(j,"LowTemp") + " " + i1));
            row1.add(cell);
            calendar.add(5,1);
        } while(++k < 5);
        table.add(row);
        table.add(row1);
        text.append(table);
        if(flag && node.isCreator(rv))
        {
            text.append(new Button(1,"CB","CBEditWeather",r.getString(j,"CBEditWeather"),"window.open('EditWeather?node=" + i + "', '_self');"));
        }
        return text.toString();
    }

    public String getQuiz(Node node,int i,RV rv,int j,boolean flag) throws SQLException
    {
        StringBuffer text = new StringBuffer();
        Form form = new Form("foAnswer","POST","/servlet/AnswerQuiz");
        form.add(new HiddenField("Node",i));
        tea.html.Table table = new tea.html.Table();
        for(Enumeration enumeration = QuizQ.findByNode(i);enumeration.hasMoreElements();)
        {
            int k = ((Integer) enumeration.nextElement()).intValue();
            QuizQ quizq = QuizQ.find(k);
            form.add(new HiddenField("QuizQ",k));
            Text text1 = new Text();
            if(quizq.getPictureFlag())
            {
                text1.add(new Image("QuizQPicture?node=" + i + "&amp;QuizQ=" + k,quizq.getAlt(j),quizq.getAlign(j)));
            }
            text1.add(new Text(quizq.getText(j)));
            if(quizq.getVoiceFlag())
            {
                text1.add(new Button(1,"CB","CBPlay",r.getString(j,"CBPlay"),"window.open('/servlet/QuizQVoice?node=" + i + "&amp;QuizQ=" + k + "', '_self');"));
            }
            if(quizq.getFileFlag())
            {
                text1.add(new Button(1,"CB","CBDownload",r.getString(j,"CBDownload"),"window.open('/servlet/QuizQFile?node=" + i + "&amp;QuizQ=" + k + "', '_self');"));
            }
            table.add(new Row(new Cell(text1)));
            Cell cell;
            for(Enumeration enumeration1 = QuizA.findByQuizQ(k);enumeration1.hasMoreElements();table.add(new Row(cell)))
            {
                int l = ((Integer) enumeration1.nextElement()).intValue();
                QuizA quiza = QuizA.find(l);
                Text text2 = new Text();
                text2.add(new Image("QuizAPicture?node=" + i + "&amp;QuizA=" + l,quiza.getAlt(j),quiza.getAlign(j)));
                text2.add(new Text(quiza.getText(j)));
                if(quiza.getVoiceFlag())
                {
                    text2.add(new Button(1,"CB","CBPlay",r.getString(j,"CBPlay"),"window.open('/servlet/QuizAVoice?node=" + i + "&amp;QuizA=" + l + "', '_self');"));
                }
                if(quiza.getFileFlag())
                {
                    text2.add(new Button(1,"CB","CBDownload",r.getString(j,"CBDownload"),"window.open('/servlet/QuizAFile?node=" + i + "&amp;QuizA=" + l + "', '_self');"));
                }
                cell = new Cell(new Radio(Integer.toString(k),quiza.getScore(),false));
                cell.add(text2);
            }
        }
        form.add(table);
        form.add(new Button(r.getString(j,"AnswerQuiz")));
        text.append(form);
        if(flag && node.isCreator(rv))
        {
            text.append(new Button(1,"CB","CBEditQuiz",r.getString(j,"CBEditQuiz"),"window.open('EditQuiz?node=" + i + "', '_self');"));
        }
        return text.toString();
    }

    // /333 edn 入口方法
    //DNSPod-monitor(http://www.dnspod.cn)
    public static long HITS = 0,STIME = System.currentTimeMillis();
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        long cur = System.currentTimeMillis();
        ServletContext application = getServletContext();
        String sn = request.getServerName();
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        String ua = request.getHeader("user-agent");
        String ip = request.getRemoteAddr();
        String url = request.getRequestURI();

        //stat
        Stat s = new Stat();
        s.url = sn + url;
        s.referer = "http://" + ip + "/?" + sn;
        s.userAgent = ua;
        s.add();

        Http h = new Http(request,response);
        if(h.debug)
            Filex.logs("NodeServlet.txt","url:" + url + "　　ua:" + ua);
        OutputStream out = response.getOutputStream();
        try
        {
            if(System.currentTimeMillis() - STIME < 10000L && HITS++ > 5)
            {
                out.write("<meta http-equiv='refresh' content='10' />网页加载中，请稍等。。。".getBytes("utf-8"));
                return;
            }
            int pos = 1;
            String[] urls = url.split("/");
            if(urls.length > 3)
            {
                h.status = url.charAt(1) == 'x' ? 1 : 0;
                String tmp = urls[urls.length - 1];
                String[] par = (tmp.substring(0,tmp.length() - 4) + "-1").split("-");
                h.node = Integer.parseInt(par[0]);
                pos = Integer.parseInt(par[1]);
            }
            pos = h.getInt("pos",pos);

            //机器人
            if(ua == null || ua.toLowerCase().indexOf("spider") != -1 || ua.indexOf("bot") != -1)
            {
                String htm = Html.getPath(urls[2]) + h.node / 10000 + "/" + h.node + "-" + h.status + h.language + ".htm";
                if(new File(htm).exists())
                {
                    //if("www.mzb.com.cn".equals(sn))
                    {
                        Node n = Node.find(h.node);
                        n.click();
                        NodeAccess.Access(n,request,request.getSession(true));
                    }
                    response.setHeader("Content-Encoding","gzip");
                    out.write(Filex.read(htm));
                    return;
                }
            }
            if(h.debug)
                Filex.logs("NodeServlet.txt","　1700");
            Node node = Node.find(h.node);

            //判断电子报节点权限
            try
            {
                h.community = node.getCommunity();
                /* 用到的时候放开
                 if(Community.find(h.community).getIscheck() != null && Community.find(h.community).getIscheck().indexOf("/2/") != -1)
                 {
                 Report.isCompetence(h.node,h.language,ip,teasession._rv,request,response);
                 }

                 //判断新闻节点是否要扣分
                 if(Community.find(h.community).getIscheck() != null && Community.find(h.community).getIscheck().indexOf("/3/") != -1 && Node.find(h.node).getType() == 39 && Report.getIntegral(teasession) != null && Report.getIntegral(teasession).length() > 0)
                 {
                 out.print(Report.getIntegral(teasession));
                 if(!"y".equals(teasession.getParameter("type")))
                 {
                  out.close();
                  return;
                 }
                 }
                 */
            } catch(SQLException e1)
            {
                // TODO Auto-generated catch block
                e1.printStackTrace();
            }
            String qs = request.getQueryString();
            if(qs != null && qs.replaceFirst("node=\\d+&language=\\d&pos=\\d+","").length() < 1) // && qs.startsWith("sukey=") 删除微信添加的参数 118位
                qs = null;
            HttpSession session = request.getSession(true);
            //String acc = request.getHeader("accept");
            //if(h.status == 1 && acc != null && acc.indexOf("application/xhtml+xml") != -1)
            //    response.setContentType("application/xhtml+xml; charset=UTF-8");

            DNS dns = DNS.find(sn);
            //自动纠正域名
            String ref = request.getHeader("Referer");
            if(h.community != null && ref != null && (ref.indexOf(".baidu.com/s?") != -1 || ref.indexOf(".google.cn/search?") != -1))
            {
                if(!h.community.equals(dns.getCommunity()))
                {
                    Enumeration e = DNS.findByCommunity(h.community,0);
                    if(e.hasMoreElements())
                    {
                        response.sendRedirect("http://" + (String) e.nextElement() + url + "?" + qs);
                        return;
                    }
                }
            }
            if(h.debug)
                Filex.logs("NodeServlet.txt","　1752");
            if(node.getCreator() == null || node.getFinished() == 2 || !DNS.isDN(sn,h.community))
            {
                response.sendError(404);
                return;
            }
            //自动纠正语言
            if((h.language != 1 && (License.getInstance().getWebLanguages() & 1 << h.language) == 0) || h.language > 10)
            {
                response.sendRedirect("/html/" + h.community + "/node/" + h.node + "-1.htm");
                return;
            }
            if(!dns.isExists())
                dns = DNS.find("%");
            if(node._nNode == dns.getNode() && h.member == 0 && h.status == 0 && h.language == 1 && !request.getAttributeNames().hasMoreElements())
            {
                response.setStatus(301);
                response.addHeader("Location","/");
                return;
            }
            if(h.debug)
                Filex.logs("NodeServlet.txt","　1774");
            Community community = Community.find(h.community);
            //生成HTML网页
            //如果是分页，不记录访问统计
            boolean p = h.getBool("pos");
            boolean isMake = ua != null && ua.endsWith(" MT)");
            if(isMake)
                qs = null;
            else if(!p)
            {
                node.click();
                if(h.debug)
                    Filex.logs("NodeServlet.txt","　1786");
                if(community.getIscheck().indexOf("/5/") != -1) //如果社区放开了，可以访问统计
                {
                    NodeAccess.Access(node,request,session);
                }
            }

            //获取域名
            //Enumeration e = DNS.findByCommunity(h.community,h.status);
            //if(sn.charAt(0) != '1' && e.hasMoreElements())
            //    sn = (String) e.nextElement();
            if(h.debug)
                Filex.logs("NodeServlet.txt","　1792");
            session.setAttribute("tea.Node",new Integer(h.node));
            //h.setCook("community",h.community,Integer.MAX_VALUE);
            h.setCook("language",String.valueOf(h.language), -1);
            h.setCook("n" + node._nNode + "_hits",String.valueOf(node.getClick()), -1);
            Cookie co = new Cookie("status",String.valueOf(h.status));
            co.setPath("/");
            response.addCookie(co);

            int type = node.getType();
            long k = node.getOptions();
            int l = node.getOptions1();
            boolean flag = false;
            if(h.member != 0)
            {
                response.setHeader("Cache-Control","no-cache");
                response.setHeader("Pragma","no-cache");
                flag = node.isCreator(h.member);
            }

            Community cobj = Community.find(h.community);
            int login = cobj.getLogin();
            int bglogin = cobj.getBgLogin();
            if(h.node != login && h.node != bglogin && ((k & 0x1000) != 0 || (k & 0x20) != 0)) //需要先登录 || 需要先审核
            {
                if(h.member == 0)
                {
                    //  response.sendRedirect("/servlet/StartLogin?node=" + h.node);

                    Category category = Category.find(h.node);
                    String u = "/servlet/StartLogin?node=" + h.node;
                    if(node.getType() == 1 && category.getClewtype() != 0)
                    {
                        //是类别
                        out.write(("<script>alert('" + category.getClewcontent() + "');window.location.href='" + u + "'</script>").getBytes("utf-8"));
                    } else if(node.getType() > 1)
                    {
                        category = Category.find(node.getFather());
                        if(category.getClewtype() != 0)
                        {
                            out.write(("<script>alert('" + category.getClewcontent() + "');window.location.href='" + u + "'</script>").getBytes("utf-8"));
                        } else
                        {
                            response.sendRedirect("/servlet/StartLogin?node=" + h.node);
                        }
                    } else
                    {
                        response.sendRedirect("/servlet/StartLogin?node=" + h.node);
                    }
                    return;
                } else
                {
                    //System.out.println(AccessMember.find(h.node,teasession._rv._strV).getPurview() );
                    if((k & 0x20) != 0 && !flag && !new RV(h.username).isOrganizer(h.community) && !new RV(h.username).isSubscriber(h.community)) // 需要先审核?????
                    {
                        response.sendRedirect("/jsp/info/Alert.jsp?node=" + h.node + "&info=" + java.net.URLEncoder.encode(r.getString(h.language,"1185352956671"),"UTF-8"));
                        return;
                    } else if((k & 0x100) != 0 && AccessMember.find(h.node,h.username).getPurview() < 0) // ?????????? && ??????? && ????create??
                    {
                        if(node.getAccessmembersnode() != null && node.getAccessmembersnode().length() > 0)
                        {
                            response.sendRedirect("/servlet/Node?node=" + node.getAccessmembersnode());
                            return;
                        } else
                        {
                            response.sendRedirect("/jsp/info/Alert.jsp?node=" + h.node + "&info=" + java.net.URLEncoder.encode(r.getString(h.language,"请设置跳转节点"),"UTF-8"));
                            return;
                        }
                    }
                }
            }

            // 不可访问
            int pr = AccessMember.getIntPurview(node,h.username);
            if(pr == 1 && h.node != login && h.node != bglogin)
            {
                //去登录
                response.sendRedirect("/servlet/StartLogin?node=" + h.node + "&nexturl=" + request.getRequestURI() + "?" + request.getQueryString());
                return;
            } else if(pr == 0)
            {
                response.sendRedirect("/jsp/info/Alert.jsp?node=" + h.node + "&amp;info=" + java.net.URLEncoder.encode("对不起,您未登录或当前用户组不可访问","UTF-8"));
                return;
            }
            //浏览  新闻资讯 加扣用户积分
            if(h.member != 0 && node.getType() == 39 && !sn.equals("www.mzb.com.cn"))
            {
                NodePoints np = NodePoints.get(h.node);
                Profile dp = Profile.find(h.member);
                Profile up = Profile.find(node.getCreator()._strV);
                // 扣下载者积分
                dp.addIntegral( -np.getLlwz(),dp.getProfile());
                IntegralRecord.create(h.community,dp.getMember(), -np.getLlwz(),8,h.node,up.getMember());
                // 上传者加积分
                up.addIntegral(np.getWzbll(),up.getProfile());
                IntegralRecord.create(h.community,up.getMember(),np.getWzbll(),6,h.node,dp.getMember());
            }
            if(h.member != 0 && node.getType() == 39)
            {
                if(!sn.equals("www.mzb.com.cn"))
                {
                    Logs.create(h.community,new RV(h.username),100,h.node,"read");
                }
            }
            if(community.getType() == 0 && community.getLogin() != h.node && (h.username == null || (!new RV(h.username).isOrganizer(h.community) && !new RV(h.username).isSubscriber(h.community))))
            {
                response.sendRedirect("/servlet/JoinCommunity?node=" + h.node);
                return;
            }
            if(!flag)
            {
                String ru = node.getClickUrl(h.language);
                if(ru != null && ru.length() > 0)
                {
                    response.sendRedirect(ru);
                    return;
                } else
                {
                    switch(type)
                    {
                    case 2:
                        if((l & 1) != 0) //重定向
                        {
                            Page page = Page.find(h.node);
                            String str = page.getRedirectUrl(h.language);
                            if(str != null && str.length() > 0)
                            {
                                response.sendRedirect(str);
                                return;
                            }
                        }
                        break;
                    case 57:
                        if(h.member == 0) //论坛
                        {
                            String regview = Forum.find(h.community).getRegview();
                            if(regview != null && regview.indexOf("/" + node.getFather() + "/") != -1)
                            {
                                response.sendRedirect("/servlet/StartLogin?node=" + h.node);
                                return;
                            }
                        }

                        //判断积分 是否 可以阅读贴子
                        if(!flag)
                        {
                            BBSForum bf = BBSForum.find(node.getFather());
                            if(bf.lview != 0)
                            {
                                if(h.member == 0)
                                {
                                    response.sendRedirect("/servlet/StartLogin?node=" + h.node);
                                    return;
                                }
                                if(!bf.isAuth(h.community,h.username,bf.lview,bf.rview))
                                {
                                    out.write("<script>alert('您的积分不足，不能查看此贴！');history.back();</script>".getBytes("utf-8"));
                                    return;
                                }
                            }
                        }
                        break;
                    case 86:
                        String nu = Tender.check(h);
                        if(nu != null)
                        {
                            response.sendRedirect(nu);
                            return;
                        }
                        break;
                    }
                }
            }
            if(Http.REAL_PATH.contains("webapps_cien"))
            {
                response.setHeader("Cache-Control","private");
                Calendar cd = Calendar.getInstance();
                cd.add(Calendar.MINUTE,30);
                //SimpleDateFormat sdf3 = new SimpleDateFormat("EE MM dd HH:mm:ss 'CST' yyyy", Locale.US);
                SimpleDateFormat sdf3 = new SimpleDateFormat("EE',' dd MMM yyyy HH:mm:ss 'GMT'",Locale.US);

                response.setHeader("Expires",sdf3.format(cd.getTime()));

                response.setHeader("Last-Modified",sdf3.format(Node.find(h.node).getUpdatetime()));
            }
            StringBuilder htm = new StringBuilder();
            //
            if(h.debug)
                Filex.logs("NodeServlet.txt","　1966");
            String pageFile = Http.REAL_PATH + "/" + (h.status == 0 ? "html" : "xhtml") + h.language + "/" + (qs == null ? (node.getType() >= 1024 ? "node" : Node.NODE_TYPE[node.getType()].toLowerCase()) + "/" + h.node / 10000 + "/" + h.node % 10000 + "-" + pos : "param/" + h.node / 10000 + "/" + h.node % 10000 + "-" + pos + qs.replaceAll("/","%2F")) + ".htm";
            File f1 = new File(pageFile);
            if(!isMake && h.member == 0 && f1.exists())
            {
                if(h.debug)
                    Filex.logs("NodeServlet.txt","　1972/read html");
                output(h,Filex.read(pageFile,"utf-8"));
                return;
            }
            if(!isMake && h.member == 0)
            {
                File f = new File("D:/edn/temp/-636447229/Home/" + h.node / 10000 + "/" + h.node + "-01.htm.gz");
                if(f.exists())
                {
                    response.setHeader("Content-Encoding","gzip");
                    out.write(Filex.read(f.getPath()));
                    return;
                }
            }
            Frame frame = Frame.find(h.community);
            boolean editmode = h.member > 0 && "true".equals(h.getCook("editmode",null));
            if(h.debug)
                Filex.logs("NodeServlet.txt","　1996");
            // head//////////
            Community c = Community.find(node.getCommunity());
            String title = node.getSubject(h.language).replaceAll("\r\n|<[^>]+>","") + " - " + (node.getType() > 1 && Http.REAL_PATH.contains("webapps_cien") ? Node.find(node.getFather()).getSubject(h.language) + " - 中国产经新闻网" : c.getName(h.language));
            StringBuilder head = new StringBuilder();
            if(h.status == 1)
            {
                head.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
                head.append("\r\n<!DOCTYPE html PUBLIC \"-//WAPFORUM//DTD XHTML Mobile 1.0//EN\" \"http://www.wapforum.org/DTD/xhtml-mobile10.dtd\">");
                head.append("\r\n<html xmlns=\"http://www.w3.org/1999/xhtml\">");
                head.append("\r\n<head>");
                head.append("\r\n<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no\"/>"); //不加此句：微信中显示放大/缩小铵钮
                head.append("\r\n<meta content=\"yes\" name=\"apple-mobile-web-app-capable\" />");
                head.append("\r\n<meta content=\"black\" name=\"apple-mobile-web-app-status-bar-style\" />");
                head.append("\r\n<meta content=\"telephone=no\" name=\"format-detection\" />");
            } else
            {
                head.append(ConnectionPool.isHtml5 ? "<!DOCTYPE html>" : "<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
                head.append("<html>");
                head.append("\r\n<head>");
            }
            head.append("\r\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\"/>");
            head.append("\r\n<title>" + title + "</title>");
            String pic = null;
            if(node.getType() == 0 || node.getType() == 1)
            {
                head.append("<meta name='filetype' content='0' />\r\n");
                head.append("<meta name='publishedtype' content='1' />\r\n");
                head.append("<meta name='pagetype' content='2' />\r\n");
                head.append("<meta name='catalogs' content='" + node._nNode + "' />\r\n");
            } else
            {
                head.append("<meta name='filetype' content='0' />\r\n");
                head.append("<meta name='publishedtype' content='1' />\r\n");
                head.append("<meta name='pagetype' content='1' />\r\n");
                head.append("<meta name='catalogs' content='" + node.getFather() + "' />\r\n");
                head.append("<meta name='contentid' content='" + node._nNode + "'/>\r\n");
                head.append("<meta name='publishdate' content='" + MT.f(node.getTime()) + "'/>\r\n");
                head.append("<meta name='author' content='" + MT.f(node.getCreator()._strR) + "'/>\r\n");
                if(node.getType() == 39)
                {
                    Report obj = Report.find(node._nNode);
                    Media mobj = Media.find(obj.getMedia());
                    pic = obj.getPicture(h.language);
                    head.append("<meta name='source' content='" + MT.f(mobj.getName(h.language)) + "'>\r\n");
                }
            }
            if(pic == null || pic.length() < 1)
                pic = node.getPicture(h.language);
            head.append("\r\n<meta name='picture' content='" + MT.f(pic,c.getSmallMap(h.language)) + "'/>");
            head.append("\r\n<meta name=\"keywords\" content=\"" + node.getKeywords(h.language) + " " + title + " " + c.getKeywords(h.language) + "\"/>");
            StringBuilder desc = new StringBuilder();
            desc.append(node.getDescription(h.language));
            head.append("\r\n<meta name=\"description\" content=\"" + desc.toString().replaceAll("\r\n|<[^>]+>|\"","") + "\"/>");
            if("www.clssn.com".equals(sn))
                head.append("\r\n<base href=\"http://" + sn + ":" + request.getServerPort() + "/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/node/" + h.node + "-" + h.language + ".htm\"/>");
            head.append("\r\n<link rel=\"Shortcut Icon\" href=\"/res/" + h.community + "/favicon.ico\"/>");
            head.append("<script language=\"javascript\" src=\"/tea/load.js\"></script>");
            head.append("<script language=\"javascript\" src=\"/tea/tea.js\"></script>");
            head.append("<script language=\"javascript\" src=\"/tea/ym/ymPrompt.js\"></script>");
            head.append("<script language=\"javascript\" src=\"/tea/mt.js?t=0917\"></script>");
            if(editmode)
            {
                head.append("<link href=\"/tea/tea.css\" rel=\"stylesheet\" type=\"text/css\"/>");
            }
            head.append("<script>var lang=" + h.language + ",node={id:" + node._nNode + ",father:" + node.getFather() + ",community:'" + node.getCommunity() + "',type:" + type + ",hidden:" + node.isHidden() + "},member={id:0};");
            if(h.member != 0)
            {
                Profile m = Profile.find(h.member);
                head.append("member={id:" + m.getProfile() + ",username:'" + m.getMember() + "',type:" + m.getType() + ",verifgtime:'" + MT.f(m.getVerifgtime(),1) + "'};");
            }
            head.append("cook.set('community',node.community);");
            if(ConnectionPool.isStatic)
                head.append("mt.post('/Nodes.do?act=click&node=" + node._nNode + "');");
            head.append("</script>");
            head.append(getCssJs(h,node,editmode) + "</head>\r\n");
            if((node.getOptions() & 0x80000000L) == 0)
            {
                head.append("<body>");
            }
            htm.append(output(h,head.toString()));
            //
            if(h.debug)
                Filex.logs("NodeServlet.txt","　2076");
            if(h.member > 0 && AdminUsrRole.find(h.community,h.username).getRole().length() > 1)
            {
                AccessMember am = AccessMember.find(node._nNode,h.username);
                if(am.getPicshow() == 0 || "webmaster".equals(h.username)) //前台的编辑小图片
                {
                    StringBuilder menu = new StringBuilder();
                    if(editmode)
                    {
                        menu.append(getButton(node,h,am,request));
                    }
                    menu.append("<input type='image' style='z-index:100;right:1px;position:fixed;top:14px;' id='editmode' onclick=\"setCookie('editmode','" + !editmode + "');location.reload();\" src='/tea/image/public/icon_edit.gif' accesskey='w'/><script>if(mt.isIE){var editmode=document.getElementById('editmode').style;editmode.position='absolute';setInterval('editmode.top=document.body.scrollTop+14;',100);}</script>");
                    htm.append(output(h,menu.toString()));
                }
            }

            boolean isFrame = (k & 0x80000000L) == 0;
            //header
            //是否显示段落
            // System.out.print(k+"--"+((k & 0x40000000) != 0));
            if((k & 0x40000000) != 0) // ��ʾ����// || (k & 0x10000000) != 0
            {
                if(isFrame)
                {
                    htm.append(output(h,frame.getBeforeheader()));
                }
                htm.append(getContent(h,node,0,5,pos,editmode));
                if(isFrame)
                {
                    htm.append(output(h,frame.getAfterheader()));
                }
            }
            //
            if((k & 0x1000000) != 0) // ·??
            {
                htm.append(output(h,"<div id=\"Path\">" + node.getAncestor(h.language,"",true) + "</div>"));
            }
            //content_1
            if((k & 0x8000000) != 0)
            {
                if(isFrame)
                {
                    htm.append(output(h,frame.getBeforebody1()));
                }
                htm.append(getContent(h,node,5,0,pos,editmode));
                if(isFrame)
                {
                    htm.append(output(h,frame.getAfterbody1()));
                }
            }
            //content_3
            if((k & 0x4000000) != 0)
            {
                if(isFrame)
                {
                    htm.append(output(h,frame.getBeforebody3()));

                }
                htm.append(getContent(h,node,7,2,pos,editmode));
                if(isFrame)
                {
                    htm.append(output(h,frame.getAfterbody3()));
                }
            }
            //content_2
            if(isFrame)
            {
                htm.append(output(h,frame.getBeforebody2()));
            }
            StringBuilder hsc = new StringBuilder();
            if((k & 0x400000) != 0 && node.getRealSubject(h.language) != null)
            {
                hsc.append("<span id=\"FolderSubject\">" + node.getRealSubject(h.language) + "</span>");
            }
            if((k & 0x200000) != 0) // ?????????NodeOShowCreator
            {
                hsc.append("<span id=\"FolderCreator\">" + getRvDetail(node.getCreator(),h.language) + "</span><span id=\"FolderTime\">" + new SimpleDateFormat("MM.dd HH:mm").format(node.getTime()) + "</span>");
            }

            htm.append(output(h,hsc.toString()));

            htm.append(getCenter(request,response,h,node,pos,editmode));

            if(isFrame)
            {
                htm.append(output(h,frame.getAfterbody3()));

            }
            //footer
            if((k & 0x2000000) != 0)
            {
                if(isFrame)
                {
                    htm.append(output(h,frame.getBeforefooter()));
                }
                htm.append(getContent(h,node,8,6,pos,editmode)); // 4:Header2
                if(isFrame)
                {
                    htm.append(output(h,frame.getAfterfooter()));
                }
            }
            htm.append("<!--" + System.getenv("COMPUTERNAME") + "," + System.currentTimeMillis() + "-->");
            if(isFrame)
            {
                htm.append(output(h,"</body>"));
            }
            htm.append(output(h,"</html>"));
            if(h.debug)
                Filex.logs("NodeServlet.txt","　2184");
            //Save Html
            if(h.member == 0 && (qs == null || qs.length() < 50))
            {
                Filex.write(pageFile,htm.toString());
            }
        } catch(IOException ex)
        {} catch(Throwable ex)
        {
            System.out.println("错误：" + sn + url);
            System.out.println("来源：" + request.getHeader("referer"));
            ex.printStackTrace();
            response.sendError(500,ex.toString());
        } finally
        {
            if(h.debug)
                Filex.logs("NodeServlet.txt","　OK");
            //out.write(("时间:" + (System.currentTimeMillis() - cur) / 1000F + "s").getBytes("utf-8"));
            out.close();
        }
    }

    private static final Pattern INC = Pattern.compile("<include src=\"([^>]+)\"/>");
    public String output(Http h,String html) throws IOException
    {
        OutputStream out = h.response.getOutputStream();
        int index = 0;
        if(!ConnectionPool.isStatic)
        {
            Matcher m = INC.matcher(html);
            while(m.find())
            {
                h.flag = true;
                out.write(html.substring(index,m.start()).getBytes("utf-8"));
                String url = m.group(1);
                try
                {
                    out.write(h.read(url).getBytes("utf-8"));
                    //request.getRequestDispatcher(url).include(request,response);
                } catch(ServletException ex)
                {
                    System.out.println(h.request.getServerName() + h.request.getRequestURI() + "?" + h.request.getQueryString());
                    ex.printStackTrace();
                }
                index = m.end();
            }
        }
        out.write(html.substring(index).getBytes("utf-8"));
        return html;
    }

    public Text getCareer(Node node,int i,RV rv,int j,boolean flag) throws SQLException
    {
        Text text = new Text();
        Career career = Career.find(i);
        String s = career.getSalary(j);
        if(s != null)
        {
            tea.html.Table table = new tea.html.Table();
            Row row = new Row(new Cell(new Text(r.getString(j,"TimeType") + ":"),true));
            row.add(new Cell(r.getString(j,Career.CAREER_TIMETYPE[career.getTimeType()])));
            table.add(row);
            if(s.length() != 0)
            {
                Row row1 = new Row(new Cell(new Text(r.getString(j,"Salary") + ":"),true));
                row1.add(new Cell(s));
                table.add(row1);
            }
            String s1 = career.getLocation(j);
            if(s1.length() != 0)
            {
                Row row2 = new Row(new Cell(new Text(r.getString(j,"Location") + ":"),true));
                row2.add(new Cell(s1));
                table.add(row2);
            }
            String s2 = career.getSkill(j);
            if(s2.length() != 0)
            {
                Row row3 = new Row(new Cell(new Text(r.getString(j,"Skill") + ":"),true));
                row3.add(new Cell(s2));
                table.add(row3);
            }
            String s3 = career.getTarget(j);
            if(s3 != null)
            {
                Row row4 = new Row(new Cell(new Text(r.getString(j,"Target") + ":"),true));
                row4.add(new Cell(s3));
                table.add(row4);
            }
            text.add(table);
        }
        if(flag && node.isCreator(rv))
        {
            text.add(new Button(1,"CB","CBEditCareer",r.getString(j,"CBEditCareer"),"window.open('servlet/EditCareer?node=" + i + "', '_self');"));
        }
        return text;
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        r.add("tea/ui/node/general/NodeServlet"); // 设置语言
    }

    public String getNews(Node node,int i,RV rv,int j,boolean flag) throws SQLException
    {
        StringBuffer text = new StringBuffer();
        News news = News.find(i);
        Date date = news.getIssueTime();
        if(date != null)
        {
            String s = news.getReporter(j);
            // if (s.length() != 0)
            // {
            // Text text1 = new Text(mapNode(s, 27, j).toString() + " ");
            // text1.setId("NewsReporter");
            // text.add(text1);
            // }
            // String s1 = news.getPress(j);
            // if (s1.length() != 0)
            // {
            // Text text2 = new Text(mapNode(s1, 22, j).toString() + " ");
            // text2.setId("NewsPress");
            // text.add(text2);
            // }
            // String s2 = news.getLocation(j);
            // if (s2.length() != 0)
            // {
            // Text text3 = new Text(mapNode(s2, 16, j).toString() + " ");
            // text3.setId("NewsLocation");
            // text.add(text3);
            // }
            Text text4 = new Text("<font>" + (new SimpleDateFormat("yyyy.MM.dd HH:mm aaa")).format(date) + "</font>");
            text4.setId("NewsIssueTime");
            text.append(text4);
        }
        if(flag && node.isCreator(rv))
        {
            text.append(new Button(1,"CB","CBEditNews",r.getString(j,"CBEditNews"),"window.open('/servlet/EditNews?node=" + i + "', '_self');"));
        }
        text.append(new Break());
        return text.toString();
    }

    public String getNightShop(Node node,int i,Http h,boolean flag) throws SQLException
    {
        StringBuffer text = new StringBuffer();
        int j = h.language;
        NightShop nightshop = NightShop.find(i,j);
        Span span = null;
        if(nightshop.getNightShopCode() > 0)
        {
            span = new Span("" + nightshop.getNightShopCode());
            span.setId("NightShopCode");
            text.append(span);
            text.append(new Break());

            span = new Span(node.getSubject(j));
            span.setId("Name");
            text.append(span);
            text.append(new Break());

            if(nightshop.getLogo().length() > 0)
            {
                span = new Span(new Image(nightshop.getLogo()));
                span.setId("Logo");
                text.append(span);
                text.append(new Break());
            }
            if(nightshop.getType().length() > 0)
            {
                span = new Span(nightshop.getType());
                span.setId("Type");
                text.append(span);
                text.append(new Break());
            }
            if(nightshop.getArea().length() > 0)
            {
                span = new Span(nightshop.getArea());
                span.setId("Area");
                text.append(span);
                text.append(new Break());
            }
            if(nightshop.getMusicType().length() > 0)
            {
                span = new Span(nightshop.getMusicType());
                span.setId("MusicType");
                text.append(span);
                text.append(new Break());
            }
            if(nightshop.getDeilStyle().length() > 0)
            {
                span = new Span(nightshop.getDeilStyle());
                span.setId("DeilStyle");
                text.append(span);
                text.append(new Break());
            }
            if(nightshop.getCircumstance().length() > 0)
            {
                span = new Span(nightshop.getCircumstance());
                span.setId("Circumstance");
                text.append(span);
                text.append(new Break());
            }
            if(nightshop.getStartBusinessHours().length() > 0 && nightshop.getStopBusinessHours().length() > 0)
            {
                span = new Span(nightshop.getStartBusinessHours() + "---" + nightshop.getStopBusinessHours());
                span.setId("BusinessHours");
                text.append(span);
                text.append(new Break());
            }
            if(nightshop.getOptions() > 0)
            {
                span = new Span((nightshop.getOptions() & 1) == 0 ? "\u65E0" : "\u6709");
                span.setId("Depot");
                text.append(span);
                span = new Span((nightshop.getOptions() & 4) == 0 ? "\u65E0" : "\u6709");
                span.setId("DayOpenBusiness");
                text.append(span);
            }
            span = new Span((nightshop.getOptions() & 8) == 0 ? "\u65E0" : "\u6709");
            span.setId("ElectroTicket");
            text.append(span);
            text.append(new Break());
            if(nightshop.getAddress().length() > 0)
            {
                span = new Span(nightshop.getAddress());
                span.setId("Address");
                text.append(span);
                text.append(new Break());
            }
            if(nightshop.getTrait().length() > 0)
            {
                span = new Span(nightshop.getTrait());
                span.setId("Trait");
                text.append(span);
                text.append(new Break());
            }
            if(nightshop.getPrincipal().length() > 0)
            {
                span = new Span(nightshop.getPrincipal());
                span.setId("Principal");
                text.append(span);
                text.append(new Break());
            }
            if(nightshop.getPhone().length() > 0)
            {
                span = new Span(nightshop.getPhone());
                span.setId("Phone");
                text.append(span);
                text.append(new Break());
            }
            if(nightshop.getFax().length() > 0)
            {
                span = new Span(nightshop.getFax());
                span.setId("Fax");
                text.append(span);
                text.append(new Break());
            }
            if(nightshop.getPostalcode().length() > 0)
            {
                span = new Span(nightshop.getPostalcode());
                span.setId("Postalcode");
                text.append(span);
                text.append(new Break());
            }
            if(nightshop.getCooperate().length() > 0)
            {
                span = new Span(nightshop.getCooperate());
                span.setId("Cooperate");
                text.append(span);
                text.append(new Break());
            }
            if(nightshop.getSponsor().length() > 0)
            {
                span = new Span(nightshop.getSponsor());
                span.setId("Sponsor");
                text.append(span);
                text.append(new Break());
            }
            if(nightshop.getTicket().length() > 0)
            {
                span = new Span(nightshop.getTicket());
                span.setId("Ticket");
                text.append(span);
                text.append(new Break());
            }
            int loop = 0;
            java.util.Enumeration enumera = TypePicture.findByNode(node._nNode);
            for(;enumera.hasMoreElements();loop++)
            {
                int id = ((Integer) enumera.nextElement()).intValue();
                TypePicture tp = TypePicture.findByPrimaryKey(id);
                span = new Span(new Image(tp.getPicture()));
                span.setId("NightShopPicture" + loop);
                text.append(span);
            }
            if(loop > 0)
            {
                text.append(new Break());
            }
        }
        text.append(new Break());
        return text.toString();
    }

    public String getHostel(Node node,int i,RV rv,int j,boolean flag) throws SQLException
    {
        StringBuffer text = new StringBuffer();
        Hostel hostel = Hostel.find(node._nNode);
        //text.setId("Hostel");
        Span span = null;
        if(hostel.getHostelID() > 0 && !hostel.getName().equals(""))
        {
            span = new Span(String.valueOf(hostel.getHostelID()));
            span.setId("HostelID");
            text.append(span);
            text.append(new Break());
            span = new Span(hostel.getName());
            span.setId("HostelName");
            text.append(span);
            text.append(new Break());
            // if (!hostel.getCity().equals(""))
            // {
            // span = new Span(hostel.getCity());
            // span.setId("HostelCity");
            // text.append(span);
            // text.append(new Break());
            // }
            if(!hostel.getAddress().equals(""))
            {
                span = new Span(hostel.getAddress());
                span.setId("HostelAddress");
                text.append(span);
                text.append(new Break());
            }
            if(!hostel.getPhone().equals(""))
            {
                span = new Span(hostel.getPhone());
                span.setId("HostelPhone");
                text.append(span);
                text.append(new Break());
            }
            if(!hostel.getFax().equals(""))
            {
                span = new Span(hostel.getFax());
                span.setId("HostelFax");
                text.append(span);
                text.append(new Break());
            }
            if(!hostel.getPostalcode().equals(""))
            {
                span = new Span(hostel.getPostalcode());
                span.setId("HostelPostalcode");
                text.append(span);
                text.append(new Break());
            }
            if(!hostel.getIntro().equals(""))
            {
                span = new Span(hostel.getIntro());
                span.setId("HostelIntro");
                text.append(span);
                text.append(new Break());
            }
            // if (hostel.getStarClass()...)
            {
                span = new Span(String.valueOf(hostel.getStarClass()));
                span.setId("HostelStarClass");
                text.append(span);
                text.append(new Break());
            }
        }
        return text.toString();
    }

    public String getFinancing(Node node,Http h) throws SQLException
    {
        r.add("/tea/resource/Financing");
        Financing financing = Financing.find(h.node,h.language);
        StringBuffer text = new StringBuffer();
        Span span = null;
        if(financing.getName().length() > 0)
        {
            span = new Span(r.getString(h.language,"Name") + ":" + financing.getName());
            span.setId("FinancingName");
            text.append(span);
            text.append(new Break());
        }
        if(financing.getReside().length() > 0)
        {
            span = new Span(r.getString(h.language,"Reside") + ":" + financing.getReside());
            span.setId("FinancingReside");
            text.append(span);
            text.append(new Break());
        }
        if(financing.getArea().length() > 0)
        {
            span = new Span(r.getString(h.language,"Area") + ":" + financing.getArea());
            span.setId("FinancingArea");
            text.append(span);
            text.append(new Break());
        }
        if(financing.getSynopsis().length() > 0)
        {
            span = new Span(r.getString(h.language,"Synopsis") + ":" + financing.getSynopsis());
            span.setId("FinancingSynopsis");
            text.append(span);
            text.append(new Break());
        }
        if(financing.getEvolve().length() > 0)
        {
            span = new Span(r.getString(h.language,"Evolve") + ":" + financing.getEvolve());
            span.setId("FinancingEvolve");
            text.append(span);
            text.append(new Break());
        }
        if(financing.getFuture().length() > 0)
        {
            span = new Span(r.getString(h.language,"Future") + ":" + financing.getFuture());
            span.setId("FinancingFuture");
            text.append(span);
            text.append(new Break());
        }
        if(financing.getAllmoney().length() > 0)
        {
            span = new Span(r.getString(h.language,"AllMoney") + ":" + financing.getAllmoney());
            span.setId("FinancingAllMoney");
            text.append(span);
            text.append(new Break());
        }
        if(financing.getFinancingmoney().length() > 0)
        {
            span = new Span(r.getString(h.language,"FinancingMoney") + ":" + financing.getFinancingmoney());
            span.setId("FinancingFinancingMoney");
            text.append(span);
            text.append(new Break());
        }
        if(financing.getInvestcallback().length() > 0)
        {
            span = new Span(r.getString(h.language,"InvestCallback") + ":" + financing.getInvestcallback());
            span.setId("FinancingInvestCallback");
            text.append(span);
            text.append(new Break());
        }
        if(financing.getRedound().length() > 0)
        {
            span = new Span(r.getString(h.language,"Redound") + ":" + financing.getRedound());
            span.setId("FinancingRedound");
            text.append(span);
            text.append(new Break());
        }
        if(financing.getYearrestrict().length() > 0)
        {
            span = new Span(r.getString(h.language,"YearRestrict") + ":" + financing.getYearrestrict());
            span.setId("FinancingYearRestrict");
            text.append(span);
            text.append(new Break());
        }
        if(financing.getFashion().length() > 0)
        {
            span = new Span(r.getString(h.language,"Fashion") + ":" + financing.getFashion());
            span.setId("FinancingFashion");
            text.append(span);
            text.append(new Break());
        }
        if(financing.getUnitname().length() > 0)
        {
            span = new Span(r.getString(h.language,"UnitName") + ":" + financing.getUnitname());
            span.setId("FinancingUnitName");
            text.append(span);
            text.append(new Break());
        }
        if(financing.getIdcard().length() > 0)
        {
            span = new Span(r.getString(h.language,"IDCard") + ":" + financing.getIdcard());
            span.setId("FinancingIDCard");
            text.append(span);
            text.append(new Break());
        }
        if(financing.getHomeplace().length() > 0)
        {
            span = new Span(r.getString(h.language,"Homeplace") + ":" + financing.getHomeplace());
            span.setId("FinancingHomeplace");
            text.append(span);
            text.append(new Break());
        }
        if(financing.getUnitessence().length() > 0)
        {
            span = new Span(r.getString(h.language,"UnitEssence") + ":" + financing.getUnitessence());
            span.setId("FinancingUnitEssence");
            text.append(span);
            text.append(new Break());
        }
        if(financing.getUnitsynopsis().length() > 0)
        {
            span = new Span(r.getString(h.language,"UnitSynopsis") + ":" + financing.getUnitsynopsis());
            span.setId("FinancingUnitSynopsis");
            text.append(span);
            text.append(new Break());
        }
        if(financing.getWebsite().length() > 0)
        {
            span = new Span(r.getString(h.language,"Website") + ":" + financing.getWebsite());
            span.setId("FinancingWebsite");
            text.append(span);
            text.append(new Break());
        }
        if(financing.getLinkman().length() > 0)
        {
            span = new Span(r.getString(h.language,"Linkman") + ":" + financing.getLinkman());
            span.setId("FinancingLinkman");
            text.append(span);
            text.append(new Break());
        }
        if(financing.getPhone().length() > 0)
        {
            span = new Span(r.getString(h.language,"Phone") + ":" + financing.getPhone());
            span.setId("FinancingPhone");
            text.append(span);
            text.append(new Break());
        }
        if(financing.getFax().length() > 0)
        {
            span = new Span(r.getString(h.language,"Fax") + ":" + financing.getFax());
            span.setId("FinancingFax");
            text.append(span);
            text.append(new Break());
        }
        if(financing.getEmail().length() > 0)
        {
            span = new Span(r.getString(h.language,"E-mail") + ":" + financing.getEmail());
            span.setId("FinancingE-mail");
            text.append(span);
            text.append(new Break());
        }
        if(financing.getPostalcode().length() > 0)
        {
            span = new Span(r.getString(h.language,"Postalcode") + ":" + financing.getPostalcode());
            span.setId("FinancingPostalcode");
            text.append(span);
            text.append(new Break());
        }
        if(financing.getAddress().length() > 0)
        {
            span = new Span(r.getString(h.language,"Address") + ":" + financing.getAddress());
            span.setId("FinancingAddress");
            text.append(span);
            text.append(new Break());
        }
        if(financing.getIssuedate() != null)
        {
            span = new Span(r.getString(h.language,"IssueTime") + ":" + new java.text.SimpleDateFormat("yyyy-MM-dd").format(financing.getIssuedate()));
            span.setId("FinancingIssueTime");
            text.append(span);
            text.append(new Break());
        }
        return text.toString();
    }

    public String getInvestor(Node node,Http h) throws SQLException
    {
        r.add("/tea/resource/Investor");
        Investor investor = Investor.find(h.node,h.language);
        StringBuffer text = new StringBuffer();
        Span span = null;
        if(investor.getFundname().length() > 0)
        {
            span = new Span(r.getString(h.language,"Fundname") + ":" + investor.getFundname());
            span.setId("InvestorFundname");
            text.append(span);
            text.append(new Break());
        }
        if(investor.getFundinfo().length() > 0)
        {
            span = new Span(r.getString(h.language,"Fundinfo") + ":" + investor.getFundinfo());
            span.setId("InvestorFundinfo");
            text.append(span);
            text.append(new Break());
        }
        if(investor.getFundsum().length() > 0)
        {
            span = new Span(r.getString(h.language,"Fundsum") + ":" + investor.getFundsum());
            span.setId("InvestorFundsum");
            text.append(span);
            text.append(new Break());
        }
        if(investor.getFundarea().length() > 0)
        {
            span = new Span(r.getString(h.language,"Fundarea") + ":" + investor.getFundarea());
            span.setId("InvestorFundarea");
            text.append(span);
            text.append(new Break());
        }
        if(investor.getFundtrade().length() > 0)
        {
            span = new Span(r.getString(h.language,"Fundtrade") + ":" + investor.getFundtrade());
            span.setId("InvestorFundtrade");
            text.append(span);
            text.append(new Break());
        }
        if(investor.getFundsymbiosis().length() > 0)
        {
            span = new Span(r.getString(h.language,"Fundsymbiosis") + ":" + investor.getFundsymbiosis());
            span.setId("InvestorFundsymbiosis");
            text.append(span);
            text.append(new Break());
        }
        if(investor.getFundwill().length() > 0)
        {
            span = new Span(r.getString(h.language,"Fundwill") + ":" + investor.getFundwill());
            span.setId("InvestorFundwill");
            text.append(span);
            text.append(new Break());
        }
        if(investor.getFundwebsite().length() > 0)
        {
            span = new Span(r.getString(h.language,"Fundwebsite") + ":" + investor.getFundwebsite());
            span.setId("InvestorFundwebsite");
            text.append(span);
            text.append(new Break());
        }
        // if (investor.getFundperiod().length() > 0)
        {
            span = new Span(r.getString(h.language,"Fundperiod") + ":" + investor.getFundperiod() + "????");
            span.setId("InvestorFundperiod");
            text.append(span);
            text.append(new Break());
        }
        if(investor.getFundlocal().length() > 0)
        {
            span = new Span(r.getString(h.language,"Fundlocal") + ":" + investor.getFundlocal());
            span.setId("InvestorFundlocal");
            text.append(span);
            text.append(new Break());
        }
        if(investor.getFundidcard().length() > 0)
        {
            span = new Span(r.getString(h.language,"Fundidcard") + ":" + investor.getFundidcard());
            span.setId("InvestorFundidcard");
            text.append(span);
            text.append(new Break());
        }
        if(investor.getFundlinkman().length() > 0)
        {
            span = new Span(r.getString(h.language,"Fundlinkman") + ":" + investor.getFundlinkman());
            span.setId("InvestorFundlinkman");
            text.append(span);
            text.append(new Break());
        }
        if(investor.getFundtel().length() > 0)
        {
            span = new Span(r.getString(h.language,"Fundtel") + ":" + investor.getFundtel());
            span.setId("InvestorFundtel");
            text.append(span);
            text.append(new Break());
        }
        if(investor.getFundfax().length() > 0)
        {
            span = new Span(r.getString(h.language,"Fundfax") + ":" + investor.getFundfax());
            span.setId("InvestorFundfax");
            text.append(span);
            text.append(new Break());
        }
        if(investor.getFundmail().length() > 0)
        {
            span = new Span(r.getString(h.language,"Fundmail") + ":" + investor.getFundmail());
            span.setId("InvestorFundmail");
            text.append(span);
            text.append(new Break());
        }
        if(investor.getFundpostcode().length() > 0)
        {
            span = new Span(r.getString(h.language,"Fundpostcode") + ":" + investor.getFundpostcode());
            span.setId("InvestorFundpostcode");
            text.append(span);
            text.append(new Break());
        }
        if(investor.getFundaddress().length() > 0)
        {
            span = new Span(r.getString(h.language,"Fundaddress") + ":" + investor.getFundaddress());
            span.setId("InvestorFundaddress");
            text.append(span);
            text.append(new Break());
        }
        return text.toString();
    }

    public String getEvent(Node node,Http h,boolean flag) throws SQLException
    {

        StringBuffer text = new StringBuffer();
        int j = h.language;
        Event event = Event.find(node._nNode,j);
        Span span = null;
        if(!event.getName().equals(""))
        {
            span = new Span(event.getName());
            span.setId("EventName");
            text.append(span);
            text.append(new Break());
            // SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
            // if (sdf.format(event.getTimeStart()).equals("00:00") && sdf.format(event.getTimeStart()).equals("00:00"))
            if(event.getTimeStart() != null)
            {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                span = new Span(sdf.format(event.getTimeStart()));
                // if (event.getTimeStop() != null)
                // span.add(new Text(" -- " + sdf.format(event.getTimeStop())));
                // } else
                // {
                // sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                // span = new Span(sdf.format(event.getTimeStart()));
                // if (event.getTimeStop() != null)
                // span.add(new Text(" -- " + sdf.format(event.getTimeStop())));
                // }
                span.setId("EventTime");
                text.append(span);
                text.append(new Break());
            }
            if(!event.getRequest().equals(""))
            {
                span = new Span(event.getRequest());
                span.setId("EventRequest");
                text.append(span);
                text.append(new Break());
            }
            if(!event.getPrescribe().equals(""))
            {
                span = new Span(event.getPrescribe());
                span.setId("EventPrescribe");
                text.append(span);
                text.append(new Break());
            }
            if(!event.getSynopsis().equals(""))
            {
                span = new Span(event.getSynopsis());
                span.setId("EventSynopsis");
                text.append(span);
                text.append(new Break());
            }
            if(!event.getOrganise().equals(""))
            {
                span = new Span(event.getOrganise());
                span.setId("EventOrganise");
                text.append(span);
                text.append(new Break());
            }
            if(!event.getLinkman().equals(""))
            {
                span = new Span(event.getLinkman());
                span.setId("EventLinkman");
                text.append(span);
                text.append(new Break());
            }
            if(!event.getCorp().equals(""))
            {
                span = new Span(event.getCorp());
                span.setId("EventCorp");
                text.append(span);
                text.append(new Break());
            }
            if(event.getCarfare().length() > 0)
            {
                span = new Span((event.getCarfare()));
                span.setId("EventCarfare");
                text.append(span);
                text.append(new Break());
            }
            if(!event.getFeature().equals(""))
            {
                span = new Span(event.getFeature());
                span.setId("EventFeature");
                text.append(span);
                text.append(new Break());
            }
            if(!event.getIntroPicture().equals(""))
            {
                span = new Span(new Image(event.getIntroPicture()));
                span.setId("EventIntroPicture");
                text.append(span);
                text.append(new Break());
            }
            if(!event.getFlyerData().equals(""))
            {
                span = new Span(event.getFeature());
                span.setId("EventFeature");
                text.append(span);
                text.append(new Break());
            }
        }
        text.append(new Break());
        return text.toString();
    }


    public String getContent(Http h,Node node,int _nPositionSection,int _nPostinonListing,int pos,boolean editmode) throws SQLException,IOException
    {
        RV rv = h.username == null ? null : new RV(h.username);
        int language = h.language;
        ArrayList[] vector =
                {
                Section.find(node,h.status,_nPositionSection,true),
                Listing.find(node,h.status,_nPostinonListing,true),
                Ading.find(node,h.status,_nPositionSection,true)
        };
        int arr[][] = new int[vector[0].size() + vector[1].size() + vector[2].size()][3];
        int arr_index = 0;
        for(int v = 0;v < vector.length;v++)
        {
            for(int index = 0;index < vector[v].size();index++,arr_index++)
            {
                int id = 0;
                arr[arr_index][2] = v;
                switch(v)
                {
                case 0: // 段落
                    Section sect = (Section) vector[v].get(index);
                    id = sect.section;
                    arr[arr_index][0] = sect.sequence;
                    break;
                case 1: // 列举
                    id = ((Integer) vector[v].get(index)).intValue();
                    Listing list = Listing.find(id);
                    arr[arr_index][0] = list.getSequence();
                    break;
                case 2: // 广告
                    Ading ad = (Ading) vector[v].get(index);
                    id = ad.ading;
                    arr[arr_index][0] = ad.getSequence();
                    break;
                }
                arr[arr_index][1] = id;
            }
        }
        int off = 0; // ����
        int len = arr.length;
        for(int i = off;i < len + off;i++)
        {
            for(int j = i;j > off && arr[j - 1][0] > arr[j][0];j--)
            {
                for(int index = 0;index < 3;index++)
                {
                    int t = arr[j][index];
                    arr[j][index] = arr[j - 1][index];
                    arr[j - 1][index] = t;
                }
            }
        }
        StringBuilder htm = new StringBuilder();
        for(int index = 0;index < arr.length;index++)
        {
            StringBuilder text = new StringBuilder();
            switch(arr[index][2])
            {
            case 0:
                Section section = Section.find(arr[index][1]);
                int i1 = section.getNode();
                int j1 = section.getVisible();
                if(j1 == 0 || j1 == 1 && rv == null || j1 == 2 && rv != null || j1 == 3 && rv != null && AccessMember.find(h.node,rv._strV).getPurview() < 0 || j1 == 4 && rv != null && AccessMember.find(h.node,rv._strV).getPurview() != -1 || j1 == 5 && rv != null && Node.find(i1).isCreator(rv) || j1 == 6 && rv != null && Node.find(h.node).isCreator(rv))
                {
                    String picture = section.getPicture(language);
                    if(picture != null && picture.length() > 0)
                    {
                        Image image = new Image(picture,section.getAlt(language),section.getAlign(language));
                        String s = section.getClickUrl(language);
                        if(s != null && s.length() != 0)
                        {
                            text.append(new Anchor(s,image));
                        } else
                        {
                            text.append(image);
                        }
                    }
                    switch(section.getOptions())
                    {
                    case 0: // Text
                        text.append(new Text(Text.toHTML(section.getText(language))));
                        break;
                    case 1: // HTML
                        text.append(new Text(section.getText(language)));
                        break;
                    }
                    String voice = section.getVoice(language);
                    if(voice != null && voice.length() > 0) // 声音
                    {
                        text.append(new Button(1,"CB","CBPlay",r.getString(language,"CBPlay"),"window.open('" + voice + "','_self');"));
                    }
                    String file = section.getFileData(language);
                    if(file != null && file.length() > 0) // 文件
                    {
                        text.append(new Button(1,"CB","CBDownload",r.getString(language,"CBDownload"),"window.open('" + file + "', '_self');"));
                    }
                    if(editmode)
                    {
                        String ids = AccessMember.find(i1,rv).getSection();
                        if(ids == null)
                            ids = "/";
                        //Node node = Node.find(i1);
                        //int purview = node.isCreator(rv) ? 3 : AccessMember.find(i1,rv).getPurview();
                        if(ids.length() > 1)
                        {
                            text.append("<div style='position:relative;top:-20;'><div style='position:absolute;'>");
                            Section sobj = Section.find(arr[index][1]);
                            if(ids.indexOf("/1/") != -1) //段落编辑
                            {
                                text.append(new Button(1,"CB","CBEditSection",r.getString(language,"CBEditSection"),"node：" + String.valueOf(arr[index][1]) + "\r主题：" + Entity.getNULL(sobj.getThemename(language)),"window.open('/jsp/section/EditSection.jsp?node=" + i1 + "&section=" + arr[index][1] + "', '_self');"));
                            }
                            if(ids.indexOf("/2/") != -1) //段落删除
                            {
                                text.append(new Button(1,"CB","CBDeleteSection",r.getString(language,"CBDeleteSection"),"node：" + String.valueOf(arr[index][1]) + "\r主题：" + Entity.getNULL(sobj.getThemename(language)),"if(confirm('" + r.getString(language,"ConfirmDelete") + "')){window.open('/servlet/DeleteSection?node=" + i1 + "&section=" + arr[index][1] + "', '_self');this.disabled=true;}"));
                            }
                            // if(section.isLayerExisted(language) && purview > 2)
                            //{
                            //     divson.add(new Button(1,"CB","CBDeleteSection",r.getString(language,"CBDeleteSection"),"node："+String.valueOf(arr[index][1])+"\r主题："+Entity.getNULL(sobj.getThemename(language)),"if(confirm('" + r.getString(language,"ConfirmDelete") + "')){window.open('/servlet/DeleteSection?node=" + i1 + "&section=" + arr[index][1] + "', '_self');this.disabled=true;}"));
                            // }
                            text.append("</div></div>");
                        }
                    }
                }
                break;
            case 1:
                Listing listing = Listing.find(arr[index][1]);
                int j1_list = listing.getNode();
                int k1 = listing.getVisible(); // 入口: 0:无限�?1:登录之前 2:登录之后 3:准许访问之前

                // 4:准许访问之后 5:段落/列举创建�?6:节点创建�?
                if(k1 == 0 || k1 == 1 && rv == null || k1 == 2 && rv != null || k1 == 3 && rv != null && AccessMember.find(h.node,rv._strV).getPurview() < 0 || k1 == 4 && rv != null && AccessMember.find(h.node,rv._strV).getPurview() != -1 || k1 == 5 && rv != null && Node.find(j1_list).isCreator(rv) || k1 == 6 && rv != null && Node.find(h.node).isCreator(rv))
                {
                    int l1 = listing.getUpdateGap();
                    int i2 = (listing.getOptions() & 0x10) != 0 ? h.node : 0; // 0x10->ListingOCurrentNode

                    text.append(getListingText(h,listing,pos,editmode));
                }
                break;
            case 2:
                Aded aded = null;
                int j1_ad = 0;
                int k1_ad = 0;
                AdedCounter adedcounter = null;
                int l1 = Aded.findByAding(arr[index][1],h.language);
                if(l1 != 0)
                {
                    aded = Aded.find(l1);
                    j1_ad = aded.getExpectedImpression(); //
                    Date date = aded.getStartTime();
                    Date date1 = aded.getStopTime();
                    adedcounter = AdedCounter.find(l1);
                    k1_ad = adedcounter.getImpression(); //
                    long l2 = System.currentTimeMillis();
                    if(date != null && date1 != null && j1_ad != 0 && (long) k1_ad * (date1.getTime() - l2) > (long) (j1_ad - k1_ad) * (l2 - date.getTime()))
                    {
                        l1 = 0;
                    }
                }
                Ading ading = Ading.find(arr[index][1]);

                //使用副本
                if(ading.getEctypal() > 0)
                {
                    ading = Ading.find(ading.getEctypal());
                }
                if(l1 != 0)
                {
                    if(j1_ad != 0 && j1_ad <= k1_ad)
                    {
                        aded.finish();
                    }
                    adedcounter.impress();
                    text.append(new Text(ading.getBeforeItem(h.language) + aded.getAnchor(h.language) + ading.getAfterItem(h.language)));
                } else
                {
                    text.append(new Text(ading.getBeforeItem(h.language) + new tea.html.Image(ading.getPicture(h.language)) + ading.getAfterItem(h.language)));
                }
                if(editmode)
                {
                    node = Node.find(ading.getNode());
                    int purview = node.isCreator(rv) ? 3 : AccessMember.find(node._nNode,rv._strV).getPurview();
                    if(purview > 1)
                    {
                        tea.html.Div div = new tea.html.Div();
                        div.setStyle("position:relative;top:-20;");
                        tea.html.Div divson = new tea.html.Div();
                        divson.setStyle("position:absolute;");
                        divson.add(new Button(1,"CB","CBEditAding",r.getString(language,"CBEdit"),String.valueOf(arr[index][1]),"window.open('/jsp/ading/EditAding.jsp?node=" + ading.getNode() + "&amp;ading=" + arr[index][1] + "', '_self');"));
                        if(ading.isLayerExisted(language) && purview > 2)
                        {
                            divson.add(new Button(1,"CB","CBDeleteAding",r.getString(language,"CBDelete"),"if(confirm('" + r.getString(language,"ConfirmDelete") + "')){window.open('/servlet/DeleteAding?node=" + ading.getNode() + "&amp;ading=" + arr[index][1] + "', '_self');this.disabled=true;}"));
                        }
                        div.add(divson);
                        text.append(div);
                    }
                }
            }
            htm.append(output(h,text.toString()));
        }
        return htm.toString();
    }
}
