package tea.ui;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import tea.db.*;
import tea.entity.*;
import tea.entity.admin.Supply;
import tea.entity.eon.EonNode;
import tea.entity.eon.EonTeleset;
import tea.entity.member.Profile;
import tea.entity.node.*;
import tea.entity.node.Page;
import tea.entity.notices.Notices;
import tea.entity.photography.Photography;
import tea.entity.site.Cluster;
import tea.entity.site.TypeAlias;
import tea.html.Anchor;
import tea.html.Break;
import tea.html.Button;
import tea.html.Cell;
import tea.html.Div;
import tea.html.Form;
import tea.html.HiddenField;
import tea.html.Image;
import tea.html.Radio;
import tea.html.Row;
import tea.html.Span;
import tea.html.Text;
import tea.htmlx.*;
import tea.http.RequestHelper;
import tea.resource.Common;
import tea.resource.Resource;
import tea.translator.Translator;
import tea.ui.ckhref.Ckhref;
import tea.entity.site.Html;
import tea.entity.admin.AdminUsrRole;
import tea.entity.custom.jjh.Volunteer;
import tea.entity.site.License;
import tea.entity.trust.TrustCompany;
import tea.entity.trust.TrustProduct;

public class TeaServlet extends HttpServlet implements Common
{
	public static Resource r;

	public Anchor hrefNewMessage(String s,String s1,String contextPath)
	{
		try
		{
			s = java.net.URLEncoder.encode(s,"UTF-8");
		} catch(Exception ex)
		{
		}
		return new Anchor(contextPath + "/servlet/NewMessage?Receiver=" + s,s1,"_blank");
	}

	public Anchor hrefNewMessage(String s,String s1)
	{
		return hrefNewMessage(s,s1,"");
	}

	public Anchor hrefNewMessage(String s)
	{
		return hrefNewMessage(s,s);
	}

	public static Text getRvDetail(String s,String cmember,int i) throws SQLException
	{
		return getRvDetail(new RV(s,s),i);
	}

	public static Text getRvDetail(RV rv,int i) throws SQLException
	{
		Text text = new Text(" ");
		Profile profile = Profile.find(rv._strR);
		text.add(new Text(profile.getAnchor() + " "));
		String s = profile.getEmail();
		String en = null;
		try
		{
			en = java.net.URLEncoder.encode(rv._strR,"UTF-8");
		} catch(UnsupportedEncodingException ex)
		{
		}
		text.add(new Text(new Anchor("/servlet/NewMessage?Receiver=" + en,RequestHelper.makeName(i,profile.getFirstName(i),profile.getLastName(i)),"_blank") + " "));
		text.add(new Text(new Anchor("/servlet/NewMessage?Receiver=" + s,s,"_blank") + " "));
		if(!rv.isReal())
		{
			text.add(new Text("/"));
			Profile profile1 = Profile.find(rv._strV);
			text.add(profile1.getAnchor());
			String s1 = profile1.getEmail();
			try
			{
				en = java.net.URLEncoder.encode(rv._strV,"UTF-8");
			} catch(UnsupportedEncodingException ex)
			{
			}
			text.add(new Text(new Anchor("/servlet/NewMessage?Receiver=" + en,RequestHelper.makeName(i,profile1.getFirstName(i),profile1.getLastName(i)),"_blank") + " "));
			text.add(new Text(new Anchor("/servlet/NewMessage?Receiver=" + s1,s1,"_blank") + " "));
		}
		return text;
	}

	public Anchor hrefCall(RV rv)
	{
		String en = null;
		try
		{
			en = java.net.URLEncoder.encode(rv.toString(),"UTF-8");
		} catch(UnsupportedEncodingException ex)
		{
		}
		return new Anchor("/servlet/Call?Receiver=" + en,rv.toString(),"_blank");
	}

	public String getSections(Node node,int status,RV rv,int j,int k,boolean flag) throws SQLException
	{
		return getSections(node,status,rv,j,k,flag,false);
	}


	public String getSections(Node node,int status,RV rv,int _nLanguage,int _nPosition,boolean flag,boolean isEditMode) throws SQLException
	{
		StringBuilder h = new StringBuilder();
		ArrayList al = Section.find(node,status,_nPosition,true);
		for(int i = 0;i < al.size();i++)
		{
			//int l = ((Integer) enumeration.nextElement()).intValue();
			Section section = (Section) al.get(i);
			int i1 = section.getNode();
			int j1 = section.getVisible();
			if(j1 == 0 || j1 == 1 && rv == null || j1 == 2 && rv != null || j1 == 3 && rv != null && AccessMember.find(node._nNode,rv._strV).getPurview() < 0 || j1 == 4 && rv != null && AccessMember.find(node._nNode,rv._strV).getPurview() != -1 || j1 == 5 && rv != null && Node.find(i1).isCreator(rv) || j1 == 6 && rv != null && node.isCreator(rv))
			{
				String picture = section.getPicture(_nLanguage);
				if(picture != null && picture.length() > 0)
				{
					Image image = new Image(picture,section.getAlt(_nLanguage),section.getAlign(_nLanguage));
					String s = section.getClickUrl(_nLanguage);
					if(s != null && s.length() != 0)
					{
						h.append(new Anchor(s,image));
					} else
					{
						h.append(image);
					}
				}
				/*
				 * if ( (section.getOptions() & 1) != 0) //?榡�O�奻 \u8FD8?OHTML text.add(new Text(section.getText(j))); else text.add(new Text(Text.toHTML(section.getText(j))));
				 */
				switch(section.getOptions())
				{
				case 0: // Text
					h.append(Text.toHTML(section.getText(_nLanguage)));
					break;
				case 1: // HTML
					h.append(section.getText(_nLanguage));
					break;
				}
				String voice = section.getVoice(_nLanguage);
				if(voice != null && voice.length() > 0) // \u58F0??
				{
					h.append(new Button(1,"CB","CBPlay",r.getString(_nLanguage,"CBPlay"),"window.open('" + voice + "','_self');"));
				}
				String file = section.getFileData(_nLanguage);
				if(file != null && file.length() > 0) // ���?
				{
					h.append(new Button(1,"CB","CBDownload",r.getString(_nLanguage,"CBDownload"),"window.open('" + file + "', '_self');"));
				}
				if(rv != null && isEditMode)
				{
					Node snode = Node.find(i1);
					if(snode.isCreator(rv) || AccessMember.find(i1,rv._strV).getPurview() > 1)
					{
						tea.html.Div div = new tea.html.Div();
						div.setStyle("position:relative;top:-20;");
						tea.html.Div divson = new tea.html.Div();
						divson.setStyle("position:absolute;");
						divson.add(new Button(1,"CB","CBEditSection",r.getString(_nLanguage,"CBEditSection"),String.valueOf(section.section),"window.open('/jsp/section/EditSection.jsp?node=" + i1 + "&section=" + section.section + "', '_self');"));
						if(section.isLayerExisted(_nLanguage))
						{
							divson.add(new Button(1,"CB","CBDeleteSection",r.getString(_nLanguage,"CBDeleteSection"),"if(confirm('" + r.getString(_nLanguage,"ConfirmDelete") + "')){window.open('DeleteSection?node=" + i1 + "&section=" + section.section + "', '_self');this.disabled=true;}"));
						}
						div.add(divson);
						h.append(div);
					}
				}
			}
		}
		return h.toString();
	}

	public String getCssJs(Http h,Node node,boolean editmode) throws SQLException,IOException
	{
		RV rv = h.username == null ? null : new RV(h.username);
		StringBuilder sb = new StringBuilder();
		ArrayList al = CssJs.find(node,h.status,true);
		for(int left = 0;left < al.size();left++)
		{
			CssJs t = (CssJs) al.get(left);
			sb.append("<link href=\"").append(t.getCssPath(h.language)).append("\" rel=\"stylesheet\" type=\"text/css\"/><script language=\"javascript\" src=\"").append(t.getJsPath(h.language)).append("\"></script>\r\n");
			if(editmode)
			{
				int nodeid = t.getNode();
				int purview = Node.find(nodeid).isCreator(rv) ? 3 : AccessMember.find(nodeid,rv).getPurview();
				if(purview > 1)
				{
					sb.append("<div style=\"position:relative;left:").append(left * 100).append("\"><div style=\"position:absolute;\">");
					sb.append(new Button(1,"CB","CBEdit",r.getString(h.language,"CBEdit"),String.valueOf(t.cssjs),"window.open('/jsp/section/EditCssJs.jsp?node=" + h.node + "&cssjs=" + t.cssjs + "');").toString());
					if(t.isLayerExisted(h.language) && purview > 2)
					{
						sb.append(new Button(1,"CB","CBDelete",r.getString(h.language,"CBDelete"),String.valueOf(t.cssjs),"if(confirm('" + r.getString(h.language,"ConfirmDelete") + "')){window.open('/servlet/EditCssJs?node=" + h.node + "&cssjs=" + t.cssjs + "&delete=ON', '_self');this.disabled=true;}"));
					}
					sb.append("</div></div>");
				}
			}
		}
		return sb.toString();
	}

	public static String getWeatherDetail(Node node,int i,int j,String s,String s1) throws SQLException
	{
		StringBuilder stringbuffer = new StringBuilder();
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(new Date(System.currentTimeMillis()));
		calendar.set(11,0);
		calendar.set(12,0);
		calendar.set(13,0);
		calendar.set(14,0);
		Weather weather = Weather.find(i,calendar.getTime());
		stringbuffer.append(r.getString(j,Weather.WEATHER_TYPE[weather.getType()]) + s1 + weather.getLow() + "/" + weather.getHigh());

		return stringbuffer.toString();
	}

	public static String getListingText(Http h,Listing listing,int pos,boolean editmode) throws SQLException
	{
		int nodeid = h.node;
		Node n = Node.find(nodeid);
		int listingid = listing.getListing();
		int lang = h.language;
		RV rv = h.username == null ? null : new RV(h.username);
		StringBuilder text = new StringBuilder();
		int listingtype = listing.getType();
		int k1 = listing.getQuantity();
		int l1 = listing.getSonQuantity();
		int i2 = listing.getColumns();
		int j2 = listing.getOptions();
		int k2 = listing.getDetailOptions();
		String target = listing.getTarget();
		String s = listing.getBeforeItem(lang);
		String s1 = listing.getAfterItem(lang);
		String s3 = listing.getSeparatorDetail(lang);
		String s15 = listing.getBeforeListing(lang);
		String s16 = listing.getAfterListing(lang);
		int sorttype = listing.getSortType();
		int sort = listing.getSortDir();
		String beforeitempicture = listing.getBeforeItemPicture(lang);
		boolean flag1 = beforeitempicture != null && beforeitempicture.length() > 0;
		String s10 = "Listing" + listingid;
		String s12 = s10 + "Detail";
		//
		try
		{
			HttpSession session = h.request.getSession();
			// if (h.get("Picture") != null)
			// {
			// l2 = listing.countPictureItems(rv, teasession, nodeid);
			// vector = listing.findPictureItems(rv, teasession, nodeid, l2);
			// } else
			// if (h.get("File") != null)
			// {
			// l2 = listing.countFileItems(rv, teasession, nodeid);
			// vector = listing.findFileItems(rv, teasession, nodeid, l2);
			// } else
			// if (h.get("News") != null) // 报纸文章
			// {
			// l2 = listing.countNewsItems(rv, teasession, nodeid);
			// vector = listing.findNewsItems(rv, teasession, nodeid, l2);
			// } else
			Object[] arr = listing.findItems(rv,h,nodeid,(pos - 1) * k1,k1);
			int l2 = ((Integer) arr[0]).intValue();
			ArrayList e = (ArrayList) arr[1];

			// /
			String s_result = null;
			int searchscope = 0;
			boolean searchListing = false;
			if((h.get("stockinput") == null && h.get("stocksearch") == null && h.get("stock") == null && h.get("AppSearch") == null)) // &&
			// h.get("Pos")
			// ==
			// null)
			// //&&
			// para_listing
			// !=
			// null)
			{
				String list[] = h.getValues("listing");
				if(list != null)
				{
					for(int loop = 0;loop < list.length;loop++)
					{
						if(Integer.parseInt(list[loop]) == listingid)
						{
							searchListing = true;
							break;
						}
					}
				}
				// if (h.language != 0)
				{
					if(searchListing)
					{
						if(h.get("keyword") != null) // ||h.get("Having")
						// !=
						// null||h.get("text")
						// !=
						// null||h.get("subject")
						// !=
						// null||h.get("name")
						// !=
						// null||h.get("Name")
						// != null)
						{
							s_result = h.get("keyword");
							if(h.get("radiobutton") != null)
							{
								try
								{
									searchscope = Integer.parseInt(h.get("radiobutton")); // ��ȫ��"����"(ֵ=2),����"����"(ֵ=1)����
								} catch(NumberFormatException ex)
								{
								}
							}
							session.setAttribute("tea.searchscope" + nodeid + ":" + listingid,new Integer(searchscope));
						} else if(h.get("Having") != null)
						{
							s_result = h.get("Having");
							searchscope = 2; // ȫ������(ֵ=2),��������(ֵ=1),��������(ֵ=4)
							session.setAttribute("tea.searchscope" + nodeid + ":" + listingid,new Integer(searchscope));
						} else if(h.get("text") != null)
						{
							s_result = h.get("text");
							searchscope = 4; // ȫ������(ֵ=2),��������(ֵ=1),��������(ֵ=4)
							session.setAttribute("tea.searchscope" + nodeid + ":" + listingid,new Integer(searchscope));
						} else if(h.get("subject") != null)
						{
							s_result = h.get("subject");
							searchscope = 1; // ȫ������(ֵ=2),��������(ֵ=1),��������(ֵ=4)
							session.setAttribute("tea.searchscope" + nodeid + ":" + listingid,new Integer(searchscope));
						} else if(h.get("name") != null)
						{
							s_result = h.get("name");
						} else if(h.get("Name") != null)
						{
							s_result = h.get("Name");
						}
						if(s_result != null)
						{
							s_result = Translator.getInstance().translate(s_result,1,h.language);
							session.setAttribute("tea.keyword" + nodeid + ":" + listingid,s_result);
						}
					}
					if(s_result == null)
					{
						s_result = (String) session.getAttribute("tea.keyword" + nodeid + ":" + listingid);
						Integer integer = (Integer) session.getAttribute("tea.searchscope" + nodeid + ":" + listingid);
						if(integer != null)
						{
							searchscope = integer.intValue();
						}
					}
					if(s_result != null)
					{
						Object result[] =
								{String.valueOf(l2),s_result};

						Div divsearch = new Div(java.text.MessageFormat.format(r.getString(lang,"ListingSearchResult"),result));
						/*
						 * Span span = new Span("������&nbsp;"); span.setId("result0" + i); Div divsearch = new Div(span); span = new Span(String.valueOf(l2)); span.setId("sum_rlt" + i); divsearch.add(span); if (s_result == null || s_result.length() <= 0) { span = new Span("&nbsp;��"); span.setId("result1" + i); divsearch.add(span); } else { span = new Span("&nbsp;�����?nbsp;"); span.setId("result1" + i); divsearch.add(span);
						 *
						 * Span span2 = new Span(s_result); span2.setId("key_rlt" + i); divsearch.add(span2);
						 *
						 * span = new Span("&nbsp;�Ľ��?); span.setId("result2" + i); divsearch.add(span); }
						 */
						divsearch.setId("resultin" + listingid);
						divsearch = new Div(divsearch);
						divsearch.setId("resultout" + listingid);
						// text.add(divsearch);
						s15 = s15 + divsearch.toString();
					}
				}
				/*
				 * else { Text text_r = new Text(); Span span = new Span("all"); text_r.add(span); Integer l2_I = (l2); Span span1 = new Span(l2_I.toString()); span1.setId("sum_rlt" + i); text_r.add(span1); text_r.add(new Span(" result")); if (h.get("keyword") != null) { byte abyte_key[] = h.get("keyword").getBytes("ISO-8859-1"); s_result = Translator.getInstance().translate(abyte_key, 1, h.language); session.setAttribute("tea.keyword", s_result);
				 * searchscope = h.get("radiobutton"); session.setAttribute("tea.searchscope", searchscope); } else { s_result = (String) session.getAttribute("tea.keyword"); searchscope = (String) session.getAttribute("tea.searchscope"); } // ("searchscope:"+searchscope); // String s_result=h.get("keyword"); Span span2 = new Span(s_result); span2.setId("key_rlt" + i); text_r.add(new Span("about ")); text_r.add(span2); text_r.setId("result" +
				 * i); text.add(text_r); }
				 */
			}
			boolean contextSearch = h.get("context") == null;
			if(contextSearch && session.getAttribute("tea.Context" + listingid) != null)
			{
				contextSearch = ((Boolean) (session.getAttribute("tea.Context" + listingid))).booleanValue();
			}
			/*
			 * if (h.get("listing") != null) { if (Integer.parseInt(h.get("listing")) == i) i3 = j1; else if (session.getAttribute("tea.VPos" + i) != null) i3 = ( (Integer) (session.getAttribute("tea.VPos" + i))).intValue(); }
			 */
			//session.setAttribute("tea.VPos" + listingid,new Integer(pos));
			//session.setAttribute("tea.Context" + listingid,new Boolean(contextSearch));

			boolean flag3 = (j2 & 1) != 0; // 总是显示
			boolean flag8 = (j2 & 0x100) != 0; // ListingHidenNode
			boolean flag10 = (j2 & 0x80000) != 0; // ListingOSonDetail
			boolean flag11 = (j2 & 0x40000) != 0; // ListingOSonCreator
			if(flag3 || e.size() > 0) // flag3=�Ƿ�"������ʾ"
			{
				text.append(s15); // s15=
				if(listingtype == 4) // ����о�������?����"��
				{
					Search search = Search.find(listingid);
					if(search.exists())
					{
						// contextSearch = search.isContext();
						Form form = new Form("foEdit","POST","/servlet/Node?node=" + search.getSearchNode());
						if(search.getType() == 50)
						{
							form.setMethod("get");
						}
						java.util.Enumeration enumeration = search.getSearchListing();
						while(enumeration.hasMoreElements())
						{
							form.add(new tea.html.HiddenField("listing",((Integer) enumeration.nextElement()).intValue()));
						}
						form.add(new HiddenField("id",listingid));
						form.add(new Text(search.getTerm(lang)));
						if(!search.isContext())
						{
							form.add(new HiddenField("context","ON"));
							contextSearch = false;
						}
						text.append(form);
					}
				}
				ListingDetail detail = ListingDetail.find(listingid, -1,lang);
				int ff = 0;

				for(int i4 = 0;i4 < e.size();i4++)
				{
					Node node = (Node) e.get(i4);
					int j4 = node._nNode;
					int k4 = node.getType();
//                    long i5 = node.getOptions();
//                    if((i5 & 0x40000) != 0 && k4 == 4) // 0x40000-->Node Show Father (显示父亲节点的内容) (j1 & 0x40000000L) != 0
//                    {
//                        int j5 = Node.find(node.getFather()).getFather();
//                        node = Node.find(j5);
//                    }
					StringBuilder li = new StringBuilder();
					if(flag1 || (s != null && s.length() != 0))
					{
						if(flag1)
						{
							li.append(new Image(beforeitempicture));
						}
						if(s.length() != 0)
						{
							li.append(s);
						}
					}

					Anchor anchor1 = null;
					Anchor anchor2 = null;
					ListingDetail listingONodeBriefing = ListingDetail.find(listingid, -1,lang);
//                    if(listingONodeBriefing.getIstype("ListingONodeBriefing") != 0 || flag8) // flag8) ///�ڵ���
//                    {
//                        boolean flag12 = false;
//                        boolean flag13 = false;
//                        boolean flag14 = false;
//                        boolean flag15 = false;
//                        String s26 = r.getString(lang,"FileExtensionVoices");
//                        String s28 = node.getSrcUrlx(lang);
//                        String s31 = node.getSrcUrl(lang);
//                        String voice = node.getVoice(lang);
//                        if(voice != null && voice.length() > 0)
//                        {
//                            anchor1 = new Anchor(voice,r.getCommandImg(lang,"Play"));
//                        } else
//                        {
//                            if(s28 != null && s28.length() != 0 && s28.lastIndexOf(".") >= 1 && s28.lastIndexOf("/") < s28.lastIndexOf("."))
//                            {
//                                for(StringTokenizer stringtokenizer = new StringTokenizer(s26," ,");stringtokenizer.hasMoreTokens();)
//                                {
//                                    String s33 = stringtokenizer.nextToken();
//                                    if(s33.equalsIgnoreCase(s28.substring(s28.lastIndexOf(".") + 1)))
//                                    {
//                                        flag14 = true;
//                                        break;
//                                    }
//                                }
//                                if(flag14)
//                                {
//                                    anchor1 = new Anchor(s28,r.getCommandImg(lang,"Play"));
//                                }
//                            }
//                            if(!flag14 && s31 != null && s31.lastIndexOf(".") >= 1 && s31.lastIndexOf("/") < s31.lastIndexOf("."))
//                            {
//                                for(StringTokenizer stringtokenizer1 = new StringTokenizer(s26," ,");stringtokenizer1.hasMoreTokens();)
//                                {
//                                    String s34 = stringtokenizer1.nextToken();
//                                    if(s34.equalsIgnoreCase(s31.substring(s31.lastIndexOf(".") + 1)))
//                                    {
//                                        flag15 = true;
//                                        break;
//                                    }
//                                }
//                                if(flag15)
//                                {
//                                    anchor1 = new Anchor(s31,r.getCommandImg(lang,"Play"));
//                                }
//                            }
//                        }
//                        String file = node.getFile(lang);
//                        if(file != null && file.length() > 0)
//                        {
//                            anchor2 = new Anchor(file,node.getFileName(lang));
//                        } else
//                        {
//                            if(s28 != null && !flag12 && !flag14 && s28.lastIndexOf(".") >= 1 && s28.lastIndexOf("/") < s28.lastIndexOf("."))
//                            {
//                                anchor2 = new Anchor(s28,s28.substring(s28.lastIndexOf("/") + 1));
//                            }
//                            if(s28 != null && s31.length() != 0 && !flag13 && !flag15 && s31.lastIndexOf(".") >= 1 && s31.lastIndexOf("/") < s31.lastIndexOf("."))
//                            {
//                                anchor2 = new Anchor(s31,s31.substring(s31.lastIndexOf("/") + 1));
//                            }
//                        }
//                        if(anchor1 != null)
//                        {
//                            anchor1.setTarget(target);
//                        }
//                        if(anchor1 != null)
//                        {
//                            li.append(anchor1);
//                        }
//                        if(anchor2 != null)
//                        {
//                            anchor2.setTarget(target);
//                        }
//                        if(anchor2 != null)
//                        {
//                            li.append(anchor2);
//                        }
//                    }
					if(listingtype == 2) // ����о�������?���İ�"��
					{
						String s22 = node.getSubject(lang);
						Anchor anchor4 = new Anchor("###",s22);
						anchor4.setOnClick("window.open('/sms/smsself/Nodesend.jsp?node=" + j4 + "','help','scrollbars=no,resizable=no ,width=400,height=300') \" class=\"2");
						anchor4.setId("smsnode");
						li.append(anchor4);
					}
					int type = node.getType();

					if(type >= 65535)
					{
						type = TypeAlias.find(type).getType();
					}
					if(type >= 1024) // 动态类
					{
						li.append(DynamicValue.getDetail(node,h,listingid,target,r));
					} else
					{
						switch(type)
						{
						case 45: // 夜店
							li.append(NightShop.getDetail(node,h,listingid,target,r));
							break;
						case 48: // 旅店
							li.append(Hostel.getDetail(node,h,listingid,target,r));
							break;
						case 49: // 机票
							li.append(Flight.getDetail(node,h,listing,target,r));
							break;
						case 50: // 职位
							li.append(Job.getDetail(node,h,listingid,target));
							break;
						case 51: // 投资
							li.append(Investor.getDetail(node,h,listingid,target));
							break;
						case 52: // 简�历
							li.append(Resume.getDetail(node,h,listingid,target));
							break;
						case 53: // 自由融资
							li.append(LFinancing.getDetail(node,h,listingid,target));
							break;
						case 54: // 自由投资
							li.append(LInvestor.getDetail(node,h,listingid,target));
							break;
						case 55: // 演出类
							Perform pfobj = Perform.find(node._nNode,lang);
							int psid = 0; //演出类的场次显示
							if(h.get("psid") != null && h.get("psid").length() > 0)
							{
								psid = Integer.parseInt(h.get("psid"));
							}
							li.append(pfobj.getDetail(node,h,listingid,target,psid));
							break;
						case 56: // ����
							li.append(Sound.getDetail(node,h,listingid,target));
							break;
						case 57: // BBS
							li.append(BBS.getDetail(node,h,h.language,listingid,target,r));
							break;
						case 58: // ����
							li.append(Register.getDetail(node,h,listingid,target));
							break;
						case 62: // Court
							li.append(Golf.getDetail(node,h,listing,target,r));
							break;
						case 63: // 下载
							li.append(Download.getDetail(node,h,listingid,target,r));
							break;
						case 64: // ���?
							li.append(Score.getDetail(node,h,listingid,target));
							break;
						case 65: // ����
							li.append(Service.getDetail(node,h,listingid,target));
							break;
						case 66: // ���񶩵�
							li.append(SOrder.getDetail(node,h,listingid,target));
							break;
						case 71: // ���񶩵�
							li.append(Indict.getDetail(node,h,listingid,target,r));
							break;
						case 72: // ����(����Ȧ)
							li.append(Sale.getDetail(node,h,listingid,target,r));
							break;
						case 73: // ���԰�
							li.append(MessageBoard.getDetail(node,h,listingid,target,r));
							break;
						case 74: // ������Ϣ
							li.append(Contribute.getDetail(node,h,listingid,target,r));
							break;
						case 75: // �л�������
							li.append(Environmental.getDetail(node,h,listingid,target,r));
							break;
						case 76: // ��ɫ��Ʒ��
							li.append(GreenManufacture.getDetail(node,h,listingid,target,r));
							break;
						case 77: // ������ʿ
							li.append(EarthKavass.getDetail(node,h,listingid,target,r));
							break;
						case 78: // 友情链接
							li.append(Link.getDetail(node,h,listingid,target,r));
							break;
						case 79: // 线路
							li.append(Travel.getDetail(node,h,listingid,target,r));
							break;
						case 80: // 文学
							li.append(Literature.getDetail(node,nodeid,h,listing,target,r));
							break;
						case 81: // 景点
							li.append(Landscape.getDetail(node,h,listingid,target,r));
							break;
						case 82: // 博客
							li.append(Weblog.getDetail(node,h,listingid,target,r));
							break;
						case 83: // 社区
							li.append(District.getDetail(node,h,listingid,target));
							break;
						case 84: //问答中心
							li.append(Interlocution.getDetail(node,h,listingid,target,r));
							break;
						case 88: // 菜品
							Dish d88 = Dish.find(node._nNode);
							li.append(d88.getDetail(node,h,listingid,target));
							break;
						case 89: // 电影
							Movie m77 = Movie.find(node._nNode);
							li.append(m77.getDetail(node,h,listingid,target));
							break;
						case 90: // 汽车
							Car car11 = Car.find(node._nNode);
							li.append(car11.getDetail(node,h,listingid,target));
							break;
						case 91: // 房产
							House house11 = House.find(node._nNode);
							li.append(house11.getDetail(node,h,listingid,target));
							break;
						case 92: // 场馆
							Venues vobj = Venues.find(node._nNode);
							li.append(vobj.getDetail(node,h,listingid,target));
							break;
						case 93: // 商标
							Logo lobj = Logo.find(node._nNode);
							li.append(lobj.getDetail(node,h,listingid,target));
							break;
						case 94: // 摄影
							Photography pobj = Photography.find(node._nNode);
							li.append(pobj.getDetail(node,h,listingid,target));
							break;
						case 95: //组图
							li.append(Album.getDetail(node,h,listingid,target));
							break;
						case 96: //志愿者
							li.append(Volunteer.getDetail(node,h,listingid,target));
							break;
						case 97: //历史事件
							Historical h97 = Historical.find(node._nNode,lang);
							li.append(h97.getDetail(node,h,listingid,target));
							break;
						case 98: //人物
							People t98 = People.find(node._nNode,lang);
							li.append(t98.getDetail(node,h,listingid,target));
							break;
						case 99: //标讯
							li.append(Notices.getDetail(node,h,listingid,target));
							break;
						case 100: //校外机构
							Outside t100 = Outside.find(node._nNode,lang);
							li.append(t100.getDetail(node,h,listingid,target));
							break;
						case 101: //课件
							li.append(Course.getDetail(node,h,listingid,target));
							break;
						case 102: //保护区
							li.append(Reserve.getDetail(node,h,listingid,target));
							break;
						case 103: //动物
							li.append(Animal.getDetail(node,h,listingid,target));
							break;
						case 104: //植物
							li.append(Plant.getDetail(node,h,listingid,target));
							break;
						case 105: //标本
							li.append(Specimen.getDetail(node,h,listingid,target));
							break;
						case 106: //本草
							li.append(Materia.getDetail(node,h,listingid,target));
							break;
						case 107: //红外相机
							li.append(Infrared.getDetail(node,h,listingid,target));
							break;
						case 108: //标本图片
							li.append(SPicture.getDetail(node,h,listingid,target));
							break;
						case 109: //课题
							li.append(Subject.getDetail(node,listingid,target,h));
							break;
						case 110: //信託产品
							li.append(TrustProduct.getDetail(node,h,listingid,target));
							break;
						case 111: //信託公司
							li.append(TrustCompany.getDetail(node,h,listingid,target));
							break;
						case 112: //服务

							//li.append(Services.getDetail(node,h,listingid,target));
							break;
						case 113: //视频
							li.append(Video.find(node._nNode,h.language).getDetail(node,h,listingid,target));
							break;
						case 0: // 文件夹
							String subject_0 = node.getSubject(lang);
							ListingDetail ld0 = ListingDetail.find(listingid,0,lang);
							java.util.Iterator listingDetailEnumeration_0 = ld0.keys();
							while(listingDetailEnumeration_0.hasNext())
							{
								String name = (String) listingDetailEnumeration_0.next(),value = null;
								int istype = detail.getIstype(name);
								if(istype == 0)
								{
									continue;
								}
								if(name.equals("getSubject"))
								{
									value = (subject_0);
								} else if(name.equals("countSons"))
								{
									value = String.valueOf(Node.countSons(node._nNode,null));
								} else if(name.equals("countByPath"))
								{
									value = String.valueOf(Node.countByPath(node.getPath()));
								}
								if(ld0.getAnchor(name) != 0)
								{
									value = "<a href=" + node.getAnchor(lang,h.status) + " target=" + target + ">" + value + "</a>";
								}
								li.append(ld0.getBeforeItem(name)).append("<span id=FolderID" + name + ">" + value + "</span>").append(ld0.getAfterItem(name));
							}
							break;
						case 1: // 类别
							int todry = -1;
							String subject = node.getSubject(lang);
							ListingDetail ld1 = ListingDetail.find(listingid,1,lang);
							java.util.Iterator listingDetailEnumeration = ld1.keys();
							while(listingDetailEnumeration.hasNext())
							{
								String name = (String) listingDetailEnumeration.next(),value = null;
								int istype = ld1.getIstype(name);
								if(istype == 0)
								{
									continue;
								}
								String spanid = name;
								if(name.equals("getSubject"))
								{
									value = (subject);
								} else if(name.equals("countSons"))
								{
									value = String.valueOf(Node.countSons(node._nNode,null));
								} else if(name.equals("news") || name.equals("todry"))
								{
									if(todry == -1)
									{
										todry = Node.count(" AND father=" + node._nNode + " AND time>" + DbAdapter.cite(new Date(),true));
									}
									if(name.equals("news"))
									{
										spanid = todry <= 0 ? "nonews" : "isnew";
										value = "";
									} else
									{
										value = String.valueOf(todry);
									}
								} else if(name.equals("post"))
								{
									int[] ac = BBS.count(node._nNode);
									value = String.valueOf(ac[0] + ac[1]);
								} else if(name.equals("hits"))
								{
									value = String.valueOf(node.getClick());
								} else if(name.equals("bbshost"))
								{
									StringBuilder sb = new StringBuilder();
									Enumeration enumer = AdminUsrRole.findByBbshost(node._nNode);
									while(enumer.hasMoreElements())
									{
										String str = (String) enumer.nextElement();
										sb.append("<a href='/jsp/type/bbs/ViewBBSProfile.jsp?community=" + node.getCommunity() + "&member=" + Http.enc(str) + "'>").append(str).append("</a> ");
									}
									value = sb.toString();
								}
								if(ld1.getAnchor(name) != 0)
								{
									value = "<a href=" + node.getAnchor(lang,h.status) + " target=" + target + ">" + value + "</a>";
								}
								li.append(ld1.getBeforeItem(name)).append("<span id=CategoryID" + spanid + ">" + value + "</span>").append(ld1.getAfterItem(name));
							}
							break;
						case 2: // 页面
							li.append(Page.getDetail(node,h,listingid,target,r));
							break;
						case 3: // 投票
							li.append(Poll.getDetail(node,h,listingid,target,r));
							break;
						case 11: //邮票
							li.append(Stamp.find(node._nNode,h.language).getDetail(node,h,listingid,target));
							break;
						case 13: // 新闻
							li.append(News.getDetail(node,h,listingid,target,r));
							break;
						case 14: // 天气
							li.append("<script src='/servlet/Ajax?act=weather&node=").append(j4).append("&language=").append(h.language).append("&listing=").append(listingid).append("'></script>");
							break;
						case 15: // 股票
							li.append(Stock.getDetail(node,h,listingid,target));
							break;
						case 21: // 公司
							li.append(Company.getDetail(node,h,listingid,target,r));
							break;
						case 28: // ר��
							li.append(Expert.getDetail(node,h,listingid,target));
							break;
						case 29: // ��ְ
							li.append(Career.getDetail(node,h,listingid,target,r));
							break;
						case 30: // ������Ϣ
							li.append(Financing.getDetail(node,h,listingid,target));
							break;
						case 31: // ����
							li.append(Friend.getDetail(node,h,listingid,target,r));
							break;
						case 32: // 供求信息
							li.append(Supply.getDetail(node,h,listingid,target));
							break;
						case 34: // 物品
							li.append(Goods.getDetail(node,h,listingid,target,r));
							break;
						case 37: // �
							li.append(Event.getDetail(node,h,listing,target)); // Node

							// node,
							// int
							// iLanguage,
							// int
							// iListing,
							// boolean
							// bShowNewest
							break;
						case 114: // �
							li.append(Meeting.getDetail(node,h,listing,target)); // Node
							break;
						case 39: // 新闻资讯
						//优化
						//Report rep = Report.find(node._nNode);
						//if(listing.getTermdate() != 0 && !listing.isDate(Entity.sdf.format(rep.getIssueTime()),listing.getTermdate()))
						{
							//break;
						} // else
						{
							li.append(Report.getDetail(node,h,listingid,pos,target));
						}
						break;
						case 40: // 图片
							Picture pic = Picture.find(node._nNode);
							li.append(pic.getDetail(node,h,listingid,target));
							break;
						case 41: // 文件
							li.append(Files.getDetail(node,listingid,h,target));
							break;
						case 42: // 招聘
							li.append(Application.getDetail(node,h,listingid,target));
							break;
						case 44: // 报纸文章
							li.append(NewsPaper.getDetail(node,h,listingid,target,s_result));

							/*
							 * if (searchscope == 3) { li.add(getNewsDetail(j4, s_result)); } else { li.add(getNewsDetail(j4)); }
							 */
							break;
						default:
							li.append(getDetailText(node,lang,listingid,s12," " + s3,target));
						}
					}

					boolean talkback_bool = false;
					Iterator eld = detail.keys();
					while(eld.hasNext())
					{
						String itemname = (String) eld.next();
						int link = detail.getAnchor(itemname);
						String value = null,sid = null;
						int istype = detail.getIstype(itemname);
						if(istype == 0)
						{
							continue;
						}
						int dq = detail.getQuantity(itemname);
						if(itemname.equals("ListingONodeFather")) //节点的父亲主题
						{
							Node nobj = Node.find(node.getFather());
							value = nobj.getSubject(lang);
						} else if(itemname.equals("NodeOPoll")) //准许	投票
						{
							value = "<include src=\"/jsp/type/poll/EditPollNode.jsp?node=" + h.node + "\"/>";
						} else if(itemname.equals("NodeComment")) //节点评论
						{
							value = "<iframe src=\"/jsp/type/photography/NodeComment.jsp?"+h.request.getQueryString()+"&node=" + h.node+"\" scrolling=\"no\"></iframe>";
							//value = "<include src=\"/jsp/type/photography/NodeComment.jsp?node=" + h.node + "\"/>";
						} else if(itemname.equals("NewNodeComment")) //新的节点评论
						{
							value = "<iframe src=\"/jsp/type/photography/newNodeComment.jsp?node=" + h.node + "\" scrolling=\"no\"></iframe>";
							//value = "<include src=\"/jsp/type/photography/newNodeComment.jsp?node=" + h.node + "\"/>";
						} else if(itemname.equals("ListingONodeSubject")) // 节点主题
						{
							value = node.getSubject(lang);

							if(searchscope == 1 || searchscope == 2)
							{
								value = value.replaceAll(s_result,"<font color='red'>" + s_result + "</font>");
							}
							if(j4 == nodeid) //
							{
								sid = "CurrentlyNode";
								link = 0;
							} else if(n.getPath().indexOf("/" + j4 + "/") != -1)
							{
								sid = "CurrentlyPathNode";
							} else
							{
								sid = "NodeTitle";
							}
						} else if(itemname.equals("Description")) // 节点内容
                        {
                            value = node.getDescription(lang);
                            sid = "Description";
                            if((listing.options & 0x10) != 0) //当前节点
                            {
                                if(j4 == nodeid)
                                {
                                    sid = "CDescription";
                                    link = 0;
                                } else if(n.getPath().indexOf("/" + j4 + "/") != -1)
                                    sid = "PDescription";
                            }
                        } else if(itemname.equals("ListingONodeBriefing")) // 节点内容
						{
							// if(!flag8)
							{
								value = node.getText2(lang);
								int ckhref = detail.getCkhref(itemname);
								if(ckhref > 0)
								{
									value = Ckhref.ckhtmlhref(value);
								}
								if((node.getOptions() & 0x20) == 0) //
								{
									if((s_result != null) && s_result.length() > 0 && searchscope == 2 || searchscope == 4) // ����ǡ�ȫ�ġ�����?
									{
										value = value.replaceAll(s_result,"<font color='red'>" + s_result + "</font>");
									}
								}
								if(j4 == nodeid) //
								{
									sid = "CurrentlyText";
									link = 0;
								} else if(n.getPath().indexOf("/" + j4 + "/") != -1)
								{
									sid = "CurrentlyPathText";
								} else
								{
									sid = "NodeText";
								}
							}
						} else if(itemname.equals("Listing0NodeCreator")) //
						{
							if(node.getCreator() != null && node.getCreator().toString().length() == 32) //说明是不登陆投稿过来的创建者
							{
								value = "无";
							} else
							{
								value = node.getCreator().toString(); // hrefGlance(node.getCreator())
							}
						} else if(itemname.equals("ListingOSonCount")) //
						{
							value = String.valueOf(Node.countSons(node._nNode,null));
						} else if(itemname.equals("Listing0AllCount")) //
						{
							value = String.valueOf(Node.count(" AND path LIKE " + DbAdapter.cite(node.getPath() + "%") + " AND type>1"));
						} else if(itemname.equals("ListingOShowSons"))
						{
							int i7 = Node.countSons(j4,null);
							if(i7 > 0)
							{
								// li.append("<span id='SonList'>");
								StringBuilder ss = new StringBuilder();
								for(Enumeration enumeration = Node.findSons(j4,null,0,l1,sorttype,sort);enumeration.hasMoreElements();)
								{
									int j7 = ((Integer) enumeration.nextElement()).intValue();
									Node node2 = Node.find(j7);
									java.util.Iterator e2 = detail.keys();
									while(e2.hasNext())
									{
										String name2 = (String) e2.next();
										int istype2 = detail.getIstype(name2);
										if(istype2 == 0)
										{
											continue;
										}
										if(name2.equals("ListingOSonSubject") || name2.equals("ListingOSonCreator") || name2.equals("ListingOSonTime") || name2.equals("ListingOSonDetail"))
										{
											String value2 = null;
											if(name2.equals("ListingOSonSubject"))
											{
												value2 = node2.getSubject(lang);

											} else if(name2.equals("ListingOSonCreator"))
											{
												value2 = node2.getCreator().toString();
											} else if(name2.equals("ListingOSonTime"))
											{
												value2 = node2.getTimeToString();
											} else if(name2.equals("ListingOSonDetail"))
											{
												value2 = node2.getText2(lang);
											}
											if(istype2 == 2 && (value2 == null || value2.length() < 1))
											{
												continue;
											}
											switch(detail.getAnchor(name2))
											{
											case 1:
												value2 = "<a href='" + (node2.getType() == 78 ? node.getClickUrl(lang) : "/" + (h.status == 1 ? "xhtml" : "html") + "/" + node.getCommunity() + "/node/" + j7 + "-" + lang + ".htm") + "' target='" + target + "'>" + value2 + "</a>";
												break;
											}
											ss.append(detail.getBeforeItem(name2));
											ss.append("<span id='").append(node.getType()==0?name2:name2+"_").append("'>").append(value2).append("</span>");
											ss.append(detail.getAfterItem(name2));
										}
									}
								}
								if(i7 > l1)
								{
									if(detail.getIstype("ListingOSonMore") != 0)
									{
										ss.append(detail.getBeforeItem("ListingOSonMore"));
										ss.append("<span id='ListingOSonMore'><a href='/servlet/Node?node=").append(node._nNode).append("&amp;language=").append(lang).append("' target='").append(target).append("'></a></span>");
										ss.append(detail.getAfterItem("ListingOSonMore"));
									}
								}
								value = ss.toString();

								// li.append("</span>");
							}
						} else if(itemname.equals("IssueTime"))
						{
							value = node.getTimeToString();
						} else if(itemname.equals("UpdateTime"))
						{
							value = node.getUpdatetimeToString();
						} else if(itemname.equals("Talkbacks"))
						{
							value = new Button(Button.BUTTON,"Talkbacks",r.getString(h.language,"Talkbacks"),"window.open('/jsp/talkback/Talkbacks.jsp?node=" + j4 + "&Language=" + h.language + "','" + target + "')").toString();
						} else if(itemname.equals("EditTalkback"))
						{
							value = new Button(Button.BUTTON,"EditTalkback",r.getString(h.language,"EditTalkback"),"window.open('/jsp/talkback/EditTalkback.jsp?node=" + j4 + "','" + target + "')").toString();
						} else if(itemname.equals("ChatRoom")) //聊天室
						{
							value = new Button(Button.BUTTON,"CBChatRoom",r.getString(h.language,"CBChatRoom"),"window.open('/jsp/type/chat/ChatFrameSet.jsp?node=" + j4 + "','" + target + "')").toString();
						} else if(itemname.equals("ForwardNode")) //发给朋友
						{
							StringBuffer sp = new StringBuffer();
							if(ff == 0)
							{
								sp.append("<script>");
								sp.append("function  f_ForwardNode(igd){");
								sp.append("var y ='edge:raised;scroll:0;status:no;help:0;resizable:0;dialogWidth:730px;dialogHeight:510px;';");
								sp.append("	 var url = '/jsp/message/UserMessage_Simple.jsp?act=rct='+new Date().getTime()+'&node='+igd;");
								sp.append(" var rs = window.showModalDialog(url,self,y);");
								//sp.append("if(rs==1)");
								//sp.append("{");
								//sp.append(" window.location.reload();");
								//sp.append("");
								//sp.append("");
								//	sp.append("}");
								sp.append("}");

								sp.append("</script>");
							}

							// value = new Button(Button.BUTTON,"ForwardNode",r.getString(h.language,"ForwardNode"),"window.open('/jsp/message/UserMessage_Simple.jsp?act=rc&node=" + j4 + "','" + target + "')").toString();
							value = new Button(Button.BUTTON,"ForwardNode",r.getString(h.language,"发给朋友"),"f_ForwardNode('" + j4 + "');").toString();

							value = sp.toString() + value;
							ff++;

						} else if(itemname.equals("ReplyNode")) //回复作者
						{
							value = new Button(Button.BUTTON,"ReplyNode",r.getString(h.language,"CBReplyToCreator"),"window.open('/jsp/message/UserMessage.jsp?act=re&node=" + j4 + "','" + target + "')").toString();
						} else if(itemname.equals("EditNode"))
						{
							File file = new File(Common.REAL_PATH + "/jsp/type/" + Node.NODE_TYPE[node.getType()].toLowerCase() + "/Edit" + Node.NODE_TYPE[node.getType()] + ".jsp");
							if(node.getType() == 0 || node.getType() == 1 || !file.exists())
							{
								value = new Button("CBEdit",r.getString(h.language,"CBEdit"),"window.open('/servlet/EditNode?EditNode=ON&Node=" + j4 + "', '_self');").toString();
							} else
							{
								value = new Button("CBEdit",r.getString(h.language,"CBEdit"),"window.open('/jsp/type/" + Node.NODE_TYPE[node.getType()].toLowerCase() + "/Edit" + Node.NODE_TYPE[node.getType()] + ".jsp?node=" + j4 + "', '_self');").toString();
							}
						} else if(itemname.equals("DeleteNode"))
						{
							value = new Button(Button.BUTTON,"DeleteNode",r.getString(h.language,"CBDeleteNode"),"if(confirm('" + r.getString(h.language,"ConfirmDeleteTree") + "')){window.open('/servlet/DeleteNode?node=" + j4 + "', '_self');this.disabled=true;}").toString();
						} else if(itemname.equals("CBRefresh")) //把节点的创建时间改为现在
						{
							value = new Button(Button.BUTTON,"CBRefresh",r.getString(h.language,"CBRefresh"),"window.open('/servlet/RefreshNode?node=" + j4 + "&nexturl=" + h.request.getRequestURI() + "%3F" + h.request.getQueryString() + "', '_self');").toString();
						} else if(itemname.equals("CBArchive"))
						{
							tea.html.Form form = new tea.html.Form("CBArchive");
							form.setMethod("POST");
							form.add(new tea.html.HiddenField("NewFather",listing.getArchive()));
							form.add(new tea.html.HiddenField("nexturl",h.request.getRequestURI() + "?" + h.request.getQueryString()));
							form.setAction("/servlet/MoveNode?node=" + j4);
							form.add(new tea.html.Button(r.getString(h.language,"CBArchive")));
							value = form.toString();
						} else if(itemname.equals("SetVisible"))
						{
							tea.html.Form form = new Form();
							form.add(new Text("<input name=\"NodeOHidden\" type=\"checkbox\" " + (node.isHidden() ? "checked=\"true\"" : "") + " onclick=\"submit()\" >"));
							form.add(new HiddenField("nexturl",h.request.getRequestURI() + "?" + h.request.getQueryString()));
							form.add(new HiddenField("node",node._nNode));
							form.setAction("/servlet/SetVisible");
							form.setMethod("POST");
							value = form.toString();
						} else if(itemname.equals("Path")) // path
						{
							value = node.getAncestor(h.language,h.status);
						} else if(itemname.equals("Click")) //网页的pv
						{
							value = "<script>document.write(cookie.get('n" + node._nNode + "_hits')||" + node.getClick() + ");</script>";
							sid = "NodeIDClick\" label=\"" + node._nNode;
						} else if(itemname.equals("ListingOEonCall")) // 服务联系
						{
							EonNode en = EonNode.find(node._nNode);
							if(en.isExists())
							{
								StringBuilder eon = new StringBuilder();
								String ms[] = en.getMember().split("/");
								for(int i = 1;i < ms.length;i++)
								{
									EonTeleset et = EonTeleset.find(node.getCommunity(),ms[i]);
									if(en.isSide() || et.getBalance().floatValue() > 0) // 如果是用户付费||管理员余�?0
									{
										Profile p = Profile.find(ms[i]);
										eon.append("<span id='EonCallPhoto'><img src='" + p.getPhotopath(lang) + "' /></span>");
										eon.append("<span id='EonCallIntr'>" + p.getIntroduce(lang) + "></span>");
										eon.append("<script>function f_eon(n,v){");
										if(en.isSide())
										{
											if(h.member == 0)
											{
												eon.append("window.open('/servlet/StartLogin?node='+n,'_self'); return;");
											} else
											{
												EonTeleset et2 = EonTeleset.find(node.getCommunity(),h.username);
												if(et2.getBalance().floatValue() <= 0)
												{
													eon.append("alert('您的余额不足.'); return;");
												}
											}
										}
										eon.append("window.open('/jsp/eon/EonCall1.jsp?node='+n+'&member=" + java.net.URLEncoder.encode(ms[i],"UTF-8") + "&processnum='+v,'','width=360,height=328,scrollbars=1');   }</script>");
										eon.append("<a id='EonCallTel' href=javascript:f_eon(" + node._nNode + ",0); title=\"点击呼叫 " + node.getSubject(lang) + "\"></a>");
										if(et.isAutoMessage())
										{
											eon.append("<a id='EonCallAuto' href=javascript:f_eon(" + node._nNode + ",1); title=\"自动语音服务 " + node.getSubject(lang) + "\"></a>");
										}
										eon.append("<a id='EonCallMsg' href=javascript:f_eon(" + node._nNode + ",2); title=\"用户留言 " + node.getSubject(lang) + "\"></a>");
									}
								}
								eon.append("<span id='EonCallPrice'>");
								if(!en.isSide() || en.getPrice().floatValue() == 0F)
								{
									eon.append("注:该服务免通话费");
								} else
								{
									eon.append("注:该服务通信资费为");
									eon.append(en.getPriceToString()).append("元/分钟");
								}
								eon.append("</span>");
								value = eon.toString();
							}
						} else if(itemname.equals("NodeOPrevNext")) // 上一连接，下一连接
						{
							ArrayList prev = Node.find1(" AND n.father=" + node.getFather() + " AND n.hidden=0 AND n.node<" + node._nNode + " ORDER BY n.node DESC",h.language,0,1);
							ArrayList next = Node.find1(" AND n.father=" + node.getFather() + " AND n.hidden=0 AND n.node>" + node._nNode + " ORDER BY n.node  ASC",h.language,0,1);
							if(prev.size() > 0 || next.size() > 0)
							{
								StringBuilder sb = new StringBuilder();
								sb.append("<ul id='PN_Link'>");
								if(prev.size() > 0)
								{
									Node pnode = (Node) prev.get(0);
									sb.append("<li id='PreviousLink'>" + r.getString(lang,"Previous") + ": <a href='" + pnode.getAnchor(h.language,h.status) + "'>" + pnode.getSubject(h.language) + "</a></li>");
								}
								if(next.size() > 0)
								{
									Node pnode = (Node) next.get(0);
									sb.append("<li id='NextLink'>" + r.getString(lang,"Next") + ": <a href='" + pnode.getAnchor(h.language,h.status) + "'>" + pnode.getSubject(h.language) + "</a></li>");
								}
								value = sb.append("</ul>").toString();
							}
						} else if(itemname.equals("Correlation")) // 相关的新闻
						{
							StringBuilder sb = new StringBuilder();
							if(dq == 0)
							{
								dq = Integer.MAX_VALUE;
							}
							ArrayList al = node.getCorrelation(lang,39,dq,detail.getTime(itemname));
							for(int j = 0;j < al.size();j++)
							{
								Node nc = (Node) al.get(j);
								sb.append("<span id='ListingIDCorrelation0'>");
								sb.append("<a id='ListingIDCorrelation1' href='" + nc.getAnchor(h.language,h.status) + "' title='" + nc.getSubject(lang) + "'>" + nc.getSubject(lang) + "</a>");
								Report r = Report.find(nc._nNode);
								if(r.getMedia() != 0)
								{
									Media m = Media.find(r.getMedia());
									if(m.type > 0)
									{
										sb.append("<span id='ListingIDCorrelationMedia'>" + m.getName(lang) + "</span>");
									}
								}
								sb.append("<span id='ListingIDCorrelation2'>" + MT.f(nc.getStartTime()) + "</span>");
								sb.append("</span>");
							}
							dq = 0; // 防止限止字数
							value = sb.toString();
						} else if(itemname.equals("File")) // 文件
						{
							String file = node.getFile(lang); //node.getFileName(lang);
							if(file != null && file.length() > 1) // 是否有文文件
							{
								StringBuilder sb = new StringBuilder();
								String[] farr = file.split("[|]");
								try
								{
									for(int z = 1;z < farr.length;z++)
									{
										sb.append("<span>" + Attch.f(Integer.parseInt(farr[z])) + "</span>");
									}
								} catch(Throwable ex)
								{
									System.out.println(node._nNode + "：" + file);
									ex.printStackTrace();
								}
								value = sb.toString();
							} else
							{
								//String kzString = file.substring(file.lastIndexOf("."),file.length());
								//if(".pdf".equals(kzString)||".PDF".equals(kzString))
								//{
								//  value = "<a href=### onclick=alert('暂没有pdf文件');><img src=/tea/image/netdisk/pdf.gif></a>";
								//}else if(".doc".equals(kzString)||".DOC".equals(kzString))
								//{
								//	value="<a href="+file+" target=_blank><img src=/tea/image/netdisk/doc.gif></a>";
								//}else if(".gif".equals(kzString)||".GIF".equals(kzString)||".png".equals(kzString)||".PNG".equals(kzString)||".jpg".equals(kzString)||".JPG".equals(kzString))
								///{
								//	value="<a href="+file+" target=_blank><img src=/tea/image/netdisk/png.gif></a>";
								//	}else {
								//	value="<a href="+file+" target=_blank><img src=/tea/image/netdisk/unknown.gif></a>";
								//}
							}
							// System.out.println(file);
						} else if(itemname.equals("Voice")) // 声音
						{
							String voice = node.getVoice(lang);
							if(voice != null && voice.length() > 1) // 是否有声音
							{
								value = new Button(1,"CB","CBPlay",r.getString(lang,"CBPlay"),"window.open('" + voice + "', '_self');").toString();
							}
						} else if(itemname.equals("Picture")) // 图像
						{
							String picture = node.getPicture(lang);
							if(picture != null && picture.length() > 1)
							{
								value = "<img src='" + picture + "' alt='" + node.getSubject(lang) + "' />";
							}
						} else if(itemname.equals("MMS")) // 流媒�?
						{
							String mms = node.getMms(lang);
							if(mms != null && mms.length() > 16)
							{
								value = "<embed src='mms://" + h.request.getServerName() + "/" + mms.substring(16) + "'></embed>";
							}
						} else // 发表舆论
						if(!talkback_bool && (itemname.equals("TSubject") || itemname.equals("TTime") || itemname.equals("TContent") || itemname.equals("TCreator") || itemname.equals("TReplyCount")))
						{
							talkback_bool = true;
							int size = 15;
							pos = h.getInt("pos");
							StringBuffer sql = new StringBuffer();
							sql.append(" AND node=" + j4).append(" AND hidden=1");
							int count = Talkback.count(sql.toString());
							if(count > 0)
							{
								sql.append(" ORDER BY talkback DESC");
								java.util.Enumeration enumeration3 = Talkback.find(sql.toString(),pos,size);
								for(int i = 1;enumeration3.hasMoreElements();i++)
								{
									int talkback_id = ((Integer) enumeration3.nextElement()).intValue();
									//  Talkback obj = Talkback.find(tbid);
									//  RV rv = obj.getCreator();
									//  String creator=obj.getIp();



									//   boolean _bCreator = node.isCreator(rv);
									//   for(Enumeration enumeration3 = Talkback.find(j4,postb,2);enumeration3.hasMoreElements();)
									//   {
									//  int talkback_id = ((Integer) enumeration3.nextElement()).intValue();
									Talkback talkback = Talkback.find(talkback_id);
									RV rv1 = talkback.getCreator();
									//  boolean bool = rv != null && (_bCreator || rv.equals(rv1));
									//  if(!bool && talkback.getHidden() == 0)
									//  {
									//     continue;
									// }
									java.util.Iterator listingDetailEnumeration_talkback = detail.keys();
									while(listingDetailEnumeration_talkback.hasNext())
									{
										itemname = (String) listingDetailEnumeration_talkback.next();
										if(itemname.equals("TSubject")) // 发表舆论——主题
										{
											value = "<img src='/tea/image/hint/" + talkback.getHint() + ".gif' />" + talkback.getAnchor(nodeid);
										} else if(itemname.equals("TTime")) // 发表舆论——时间
										{
											value = talkback.getTimeToString();
										} else if(itemname.equals("TContent")) // 发表舆论——内容
										{
											String content = talkback.getContent(nodeid);
											String picture = talkback.getPicture(nodeid);
											if(picture != null && picture.length() > 0)
											{
												content += (new Image(picture));
											}
											String voice = talkback.getVoice(nodeid);
											if(voice != null && voice.length() > 0)
											{
												content += "<input type=button class=edit_input onClick=\"window.open('" + voice + "','_self');\" value=" + r.getString(h.language,"CBPlay") + ">";
											}
											String file = talkback.getFile(nodeid);
											if(file != null && file.length() > 0)
											{
												content += talkback.getFileName(h.language) + "<input type=button class=edit_input onClick=\"window.open('" + file + "','_self');\" value=" + r.getString(h.language,"Download") + " >";
											}
											value = (content);
										} else if(itemname.equals("TCreator")) // 发表舆论——创建
										{

											if(rv1 != null && rv1.toString().indexOf("<ANONYMITY>") == -1)
											{
												value = rv1.toString();
												if(value.length() == 32)
												{
													value = "匿名";
												}
											} else
											{
												value = "匿名";
											}

										} else if(itemname.equals("TReplyCount")) // 发表舆论——回复数
										{
											value = String.valueOf(TalkbackReply.countByTalkback(talkback_id));
										} else
										{
											continue;
										}
										Span span = new Span(value);

										span.setId("TalkbackID" + itemname);
										li.append(detail.getBeforeItem(itemname)).append(span).append(detail.getAfterItem(itemname));
									}
								}

								if(count > size)
								{
									Span pagination = new Span(new FPNL(h.language,"/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/node/" + nodeid + "-" + h.language + ".htm?pos=",pos,count,size));
									pagination.setId("TalkbackIDPage");
									li.append(pagination);
								}
							}
							continue;
						} else
						// if(itemname.equals("NodeCount") || itemname.equals("Divide")) //节点数量,分页,
						{
							continue;
						}
						if(istype == 2 && (value == null || value.length() < 1))
						{
							continue;
						}

						String title = value;
						if(dq > 0 && value != null && value.length() > dq)
						{
							value = value.substring(0,dq) + "…";
						}
						switch(link)
						{
						case 1:
							if(value == null)
								value = "";
							value = "<a href='" + node.getAnchor(h.language,h.status) + "' target='" + target + "' title=\"" + Report.getHtml2(title) + "\">" + value + "</a>";
							break;
						case 2:
							value = new Anchor("###",null,new Text(value),"","javascript:window.open('about:blank','','height=300,width=400,top=200,left=300,toolbar=no,menubar=no,scrollbars=no, location=no, status=no').document.write('<img src=" + value + " onload=window.resizeTo(this.width+30,this.height+50) >');").toString();
							break;
						}
						Span span = new Span(value);
						span.setId(sid);
						li.append(detail.getBeforeItem(itemname)).append(span).append(detail.getAfterItem(itemname));

					}
					// li.add(new Text(s4));

					if(flag8 || listingONodeBriefing.getIstype("ListingONodeBriefing") != 0) // �ڵ���
					{
						/*
						 * String picturefile1 = getServletContext().getRealPath("/tea/image/node/" + j4 + ".jpg"); File file1 = new File(picturefile1); if (file1.exists()) { Image image1 = new Image("/tea/image/node/" + j4 + ".jpg"); image1.setId("pic_node"); li.add(image1); } String s23 = node.getText(lang); if ((node.getOptions() & 0x20) == 0) //ѡ�����TEXT=0,������HMTL=1,JSP=2 { if ((node.getOptions() & 0x40) == 0) { s23 = Text.toHTML(s23); }
						 */
						/*
						 * String value = new String(h.get("Text").getBytes("ISO-8859-1")); if (value != null && value.length() > 0) { String newS23 = s23.replaceAll(value, "<font color='red'>" + value + "</font>"); if (newS23.length() != s23.length()) { li.add(new Text(s23)); } } else li.add(new Text(s23));
						 */
						/*
						 * if ((s_result != null) && s_result.length() > 0 && searchscope == 2 || searchscope == 4) //����ǡ�ȫ�ġ�����?{ s23 = s23.replaceAll(s_result, "<font color='red'>" + s_result + "</font>"); } li.add(new Text(s23)); } else //JSP { li.add(new Text(Text.toHTML(s23, "N" + j4 + "L" + k))); }
						 */
					} else
					{
						try
						{ // �����ʾ�ڵ��飬������?&& ��ʾ������ �������?
							if((searchscope == 2 || searchscope == 4) && contextSearch) // (s_result
							// !=
							// null)
							// &&
							// searchscope.equals("2"))
							{ // (node.getType()==44)&&
								String s23 = node.getText2(lang); // Text.toHTML(node.getText(lang));
								s23 = s23.replaceAll("&nbsp;","");
								int index = Text.indexOf(s23,s_result); // s23.indexOf(s_result);
								int fromindex = 0;
								if(index > 40)
								{
									fromindex = index - 30;
								}
								int jj = s23.lastIndexOf(">",index);
								if(jj > fromindex)
								{
									fromindex = jj + 1;
								}
								int toindex = fromindex + 100;
								if(toindex > s23.length())
								{
									toindex = s23.length();
								}
								jj = s23.indexOf("<",index);
								if((jj < toindex) && (jj != -1))
								{
									toindex = jj;
								}
								s23 = s23.substring(fromindex,toindex);
								// s23="<script>replace_string(\""+s23+"\",\""+s_result+"\");</script>";
								// if((node.getOptions() & 0x40) == 0)
								//
								// s23 = s23.replaceAll(s_result, "<font color='red'>" +
								// s_result + "</font>");
								s23 = Text.replaceAll(s23,s_result,"<font color='red'>" + s_result + "</font>");
								if(fromindex > 0)
								{
									s23 = "..." + s23;
								}
								li.append(s23);
							}
						} catch(Exception ex)
						{
							ex.printStackTrace();
						}
					}
					li.append(s1);
					/*
					 * if (flag4) //Listing Show Sons { boolean flag16 = false; int i7 = Node.countSons(j4, null); if (i7 > 0) { tea.html.List ulSons = new tea.html.List(); for (Enumeration enumeration = Node.findSons(j4, null, 0, l1, sort); enumeration.hasMoreElements(); ) { int j7 = ( (Integer) enumeration.nextElement()).intValue(); Node node1 = Node.find(j7); Anchor anchor13 = node1.getAnchor(k, s13); ListItem liSons = new ListItem(); if (flag5) anchor13.setTarget("_blank"); liSons.add(new
					 * Text(s5)); //s5=BeforeChild liSons.add(anchor13); liSons.add(new Text(" ")); if (flag11) //Listing Son Creator liSons.add(hrefGlance(node1.getCreator())); if (flag10) //Listing Son Detail { liSons.add(new Text(s7)); liSons.add(getDetailText(node1, j7, k, s14, " " + s8)); liSons.add(new Text(s9)); } liSons.add(new Text(s6)); ulSons.add(liSons); } if (flag16 && i7 > l1) { ListItem liOmit = new ListItem(); liOmit.add(new Text(" ...")); ulSons.add(liOmit); } li.add(ulSons); } }
					 */

					if((j2 & 0x40) != 0) // 移除格式
					{
						text.append(li);

					} else
					{
						text.append("<li>" + li + "</li>");
					}
					//列举分裂
					if((i4 + 1) % i2 == 0 && i4 != k1 && i4 + 1 < e.size()) //if((i4 + 1) % i2 == 0 && i4<k1) // && i4 + 1 < j3 -- if((i4 + 1) % i2 == 0)//2009-09-25修改
					{
						text.append(listing.getColumnAfter(lang));
					}

				}

				/*
				 * if ( (k2 & 32) != 0)//����С�� { text.add(smallstock(request)); }
				 */

				int listock1 = 0;
				if(h.get("listing") != null)
				{
					/*
					 * listock1 = (Integer.parseInt(h.get("Listing"))); if (h.get("stock") != null && listock1 == i) { text.add(getStock(teasession)); } else if (h.get("stocksearch") != null && listock1 == i) { text.add(getStockSearch(teasession, i)); } else if (h.get("stockinput") != null && listock1 == i) { text.add(inputStock(teasession, i)); } else
					 */
					if(h.get("AppSearch") != null)
					{
						text.append(Application.getAppSearch(h,listingid,r));
					}
				}
				int istype = detail.getIstype("NodeCount");
				if(istype != 0) // 节点数量
				{
					text.append(detail.getBeforeItem("NodeCount")).append(l2).append(detail.getAfterItem("NodeCount"));
				}
				istype = detail.getIstype("Divide");

				if(istype == 1 || (istype == 2 && l2 > k1)) // || (k2 & 0x10) != 0
				{
					text.append(detail.getBeforeItem("Divide")).append("<li id='PageNum'>");
					String qs = h.request.getQueryString();
					qs = "?" + (qs != null ? qs.replaceFirst("&l" + listingid + "=\\d+","") : "");
					if(detail.getAnchor("Divide") == 1) //英文分页
					{
						text.append(new FPNL(0,qs + "&l" + listingid + "=",pos,l2,k1));
					} else
					{
						text.append(new FPNL2(h.language,n.getAnchor(h.language,h.status),pos,l2,k1));
					}
					text.append("</li>").append(detail.getAfterItem("Divide"));
				}
				// if (!flag)//显示更多
				// {
				// String s17 = listing.getMore(lang);
				// if (s17.length() != 0)
				// {
				// Paragraph paragraph = new Paragraph();
				// paragraph.setAlign(3);
				// paragraph.add(new Anchor("/servlet/AllLists?node=" + nodeid + "&listing=" + listingid, s17));
				// text.append(paragraph);
				// }
				// }
				// 编辑/删除按钮
				int listingNode = listing.getNode();
				if(editmode)
				{
					String ids = AccessMember.find(listingNode,rv._strV).getListing();
					if(ids == null)
						ids = "/";
					//int purview = Node.find(listingNode).isCreator(rv) ? 3 : AccessMember.find(listingNode,rv._strV).getPurview();
					if(ids.length() > 1)
					{
						text.append("<div style=\"position:relative;top:-20;\"><div style=\"position:absolute;\">");
						if(ids.indexOf("/1/") != -1)
						{
							text.append(new Button(1,"CB","CBEditListing",r.getString(h.language,"CBEditListing"),listing.getName(h.language) + ":" + String.valueOf(listingid),"window.open('/jsp/listing/EditListing.jsp?node=" + listingNode + "&listing=" + listingid + "','_self');"));
						}
						// if(listing.isLayerExisted(h.language) && purview > 2)
						if(ids.indexOf("/2/") != -1)
						{
							text.append(new Button(1,"CB","CBDeleteListing",r.getString(h.language,"CBDeleteListing"),listing.getName(h.language) + ":" + String.valueOf(listingid),"if(confirm('" + r.getString(h.language,"ConfirmDelete") + "')){window.open('/servlet/DeleteListing?node=" + listingNode + "&listing=" + listingid + "', '_self');this.disabled=true;}"));
						}
						if(listing.getType() == 1 || listing.getPick() == 0) //手动列举的 列项
						{
							if(ids.indexOf("/3/") != -1)
							{
								text.append(new Button(1,"CB","CBBriefcaseItems",r.getString(h.language,"CBBriefcaseItems"),listing.getName(h.language) + ":" + String.valueOf(listingid),"window.open('/jsp/listing/BriefcaseItems.jsp?node=" + listingNode + "&listing=" + listingid + "','_self');"));
							}
						}
						text.append("</div></div>");
					}
				}
				text.append(s16);
			}
		} catch(Throwable ex)
		{
			ex.printStackTrace();
		}
		return text.toString();
	}

	// public Text getNear(TeaSession teasession) throws SQLException
	// {
	// Text text = new Text();
	// Vector vector = null;
	// Listing listing = new Listing();
	// vector = listing.findItems(teasession, 5);
	// Table table = new Table();
	// for (int j = 0; j < vector.size(); j++)
	// {
	// int k = ((Integer) vector.elementAt(j)).intValue();
	// Node node = new Node(k);
	// Anchor anchor = node.getAnchor(h.language, "NearReport");
	// Row row = new Row();
	// Cell cell = new Cell();
	// cell.add(new Text(anchor));
	// row.add(cell);
	// table.add(row);
	// }
	// text.add(table);
	// return text;
	// }



	/*
	 * public Text getAding(TeaSession teasession, int position) throws SQLException { Text ad = new Text(); Vector vector = Ading.findByNode(h.node); int l = vector.size(); if (l != 0) { int i1 = ((Integer) vector.elementAt((int) Math.round(Math.random() * (double) (l - 1)))).intValue(); Aded aded = null; int j1 = 0; int k1 = 0; AdedCounter adedcounter = null; int l1 = Aded.findByAding(i1, h.language); if (l1 != 0) { aded = Aded.find(l1); j1 = aded.getExpectedImpression();
	 * //������ Date date = aded.getStartTime(); Date date1 = aded.getStopTime(); adedcounter = AdedCounter.find(l1); k1 = adedcounter.getImpression(); //���? long l2 = System.currentTimeMillis(); if (date != null && date1 != null && j1 != 0 && (long) k1 * (date1.getTime() - l2) > (long) (j1 - k1) * (l2 - date.getTime())) { l1 = 0; } } if (l1 != 0) { if (j1 != 0 && j1 <= k1) { aded.finish(); } adedcounter.impress(); // sb.append("<div ID=\"Ad\">" + aded.getAnchor(j) + "</div>");
	 * ad.add(aded.getAnchor(h.language)); } else { // sb.append("<div ID=\"Ad\">" + getSections(i, rv, j, 2, false, teasession.isEditMode()) + "</div>"); ad.add(getSections(h.node, teasession._rv, h.language, position, false, teasession.isEditMode())); } } else { // sb.append("<div ID=\"Ad\">" + getSections(i, rv, j, 2, false, teasession.isEditMode()) + "</div>"); ad.add(getSections(h.node, teasession._rv, h.language, position, false,
	 * teasession.isEditMode())); } return ad; }
	 */
	public static void outLogin(HttpServletRequest request,HttpServletResponse response,Http h) throws IOException
	{
		if(h.member != 0)
		{
			response.sendError(403);
			return;
		}
		String s = request.getParameter("NextUrl");
		if(s == null)
		{
			s = request.getRequestURI();
			String s1 = request.getQueryString();
			if(s1 != null)
			{
				s = s + "?" + s1;
			}
		}
		response.sendRedirect("/servlet/StartLogin?node=" + h.node + "&nexturl=" + s);
	}

	/*
	 * public Text getBuyDetail(Node node, int i, int j, String s, String s1) throws SQLException { StringBuilder stringbuffer = new StringBuilder(); Commodity commodity = Commodity.find(i); if (commodity.getSKU() != null) { stringbuffer.append(hrefGlance(node.getCreator()) + s1 + r.getString(j, Commodity.QUALITY[commodity.getQuality()]) + s1); int k; BuyPrice buyprice; for (Enumeration enumeration = BuyPrice.find(i); enumeration.hasMoreElements(); stringbuffer.append(r.getString(j,
	 * Common.CURRENCY[k]) + buyprice.getPrice() + s1)) { k = ((Integer) enumeration.nextElement()).intValue(); buyprice = BuyPrice.find(i, k); } } Text text = new Text(stringbuffer.toString()); text.setId(s); return text; }
	 */
	public static String getQuizDetail(Node node,int i,int j,String s,String s1) throws SQLException
	{
		Form form = new Form("foAnswer","POST","AnswerQuiz");
		form.setTarget("_blank");
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
				text1.add(new Image("QuizQPicture?node=" + i + "&QuizQ=" + k,quizq.getAlt(j),quizq.getAlign(j)));
			}
			text1.add(new Text(quizq.getText(j)));
			if(quizq.getVoiceFlag())
			{
				text1.add(new Button(1,"CB","CBPlay",r.getString(j,"CBPlay"),"window.open('/servlet/QuizQVoice?node=" + i + "&QuizQ=" + k + "','_self');"));
			}
			if(quizq.getFileFlag())
			{
				text1.add(new Button(1,"CB","CBDownload",r.getString(j,"CBDownload"),"window.open('/servlet/QuizQFile?node=" + i + "&QuizQ=" + k + "','_self');"));
			}
			table.add(new Row(new Cell(text1)));
			Cell cell;
			for(Enumeration enumeration1 = QuizA.findByQuizQ(k);enumeration1.hasMoreElements();table.add(new Row(cell)))
			{
				int l = ((Integer) enumeration1.nextElement()).intValue();
				QuizA quiza = QuizA.find(l);
				Text text2 = new Text();
				text2.add(new Image("/servlet/QuizAPicture?node=" + i + "&QuizA=" + l,quiza.getAlt(j),quiza.getAlign(j)));
				text2.add(new Text(quiza.getText(j)));
				if(quiza.getVoiceFlag())
				{
					text2.add(new Button(1,"CB","CBPlay",r.getString(j,"CBPlay"),"window.open('/servlet/QuizAVoice?node=" + i + "&QuizA=" + l + "','_self');"));
				}
				if(quiza.getFileFlag())
				{
					text2.add(new Button(1,"CB","CBDownload",r.getString(j,"CBDownload"),"window.open('/servlet/QuizAFile?node=" + i + "&QuizA=" + l + "','_self');"));
				}
				cell = new Cell(new Radio(Integer.toString(k),quiza.getScore(),false));
				cell.add(text2);
			}
		}
		form.add(table);
		form.add(new Button(r.getString(j,"AnswerQuiz")));
		Text text = new Text(form);
		text.setId(s);
		return text.toString();
	}

	public static String getNewsDetail(Node node,int i,int j,String s,String s1) throws SQLException
	{
		StringBuilder stringbuffer = new StringBuilder();
		News news = News.find(i);
		Date date = news.getIssueTime();
		if(date != null)
		{
			Date date1 = new Date(System.currentTimeMillis());
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(date1);
			Calendar calendar1 = Calendar.getInstance();
			calendar1.setTime(date);
			if(calendar.get(1) == calendar1.get(1) && calendar.get(2) == calendar1.get(2) && calendar.get(5) == calendar1.get(5))
			{
				stringbuffer.append((new SimpleDateFormat("HH:mm")).format(date));
			} else
			{
				stringbuffer.append((new SimpleDateFormat("MM.dd")).format(date));
			}
		}
		String s2 = news.getPress(j);
		if(s2 != null)
		{
			try
			{
				Node n = Node.find(Integer.parseInt(s2));
				s2 = n.getAncestor(j);
			} catch(Exception ex)
			{
			}
			stringbuffer.append(" " + s2);
		}

		return stringbuffer.toString();
	}

	public static String getNewsDetail(int i,int language) throws SQLException
	{
		StringBuilder text = new StringBuilder();
		NewsPaper newspaper = NewsPaper.find(i,language);

		String ssubtitle = newspaper.getSubTitle();
		if(ssubtitle != null && ssubtitle.length() > 0)
		{
			Span spans = new Span(ssubtitle);
			spans.setId("Subtitle");
			text.append(spans);
			text.append(new Break());
		}
		Date date = newspaper.getPubdate();
		if(date != null)
		{
			StringBuilder stringbuffer = new StringBuilder();
			stringbuffer.append((new SimpleDateFormat("yyyy-MM-dd")).format(date));
			Span span2 = new Span(stringbuffer.toString());
			span2.setId("Pubdate");
			text.append(span2);
		}
		Span span1 = new Span("第 " + newspaper.getIssue() + " 期");
		span1.setId("Issue");
		text.append(span1);
		String s2 = newspaper.getAuthor();
		if(s2 != null && s2.length() > 0)
		{
			Span span = new Span("作者:" + s2);
			span.setId("AuhtorName");
			text.append(span);
		}
		Span span4 = new Span("第" + newspaper.getEdition() + "版");
		span4.setId("Edition");
		text.append(span4);
		String s5 = newspaper.getColumn();
		if(s5 != null && s5.length() > 0)
		{
			Span span5 = new Span("栏目:" + s5);
			span5.setId("ColumnName");
			text.append(span5);
		}
		return text.toString();
	}

	public void outText(TeaSession teasession,HttpServletResponse response,String content) throws IOException
	{
		StringBuilder sb = new StringBuilder();
		for(int index = 0;index < content.length();index++)
		{
			int value = (int) content.charAt(index);
			if(value > 128)
			{
				sb.append("%26%23" + value + "%3B");
			} else
			{
				sb.append((char) value);
			}
		}
		// java.net.URLEncoder.encode(content, "UTF-8")
		response.sendRedirect("/jsp/info/Alert.jsp?info=" + sb.toString());
	}

	public void outText(HttpServletResponse response,int _nLanguage,String s) throws IOException
	{
		response.setContentType("text/html;");
		response.setHeader("Content-Type","text/html; charset=UTF-8");
		response.setHeader("Expires","0");
		response.setHeader("Cache-Control","no-cache");
		response.setHeader("Pragma","no-cache");
		PrintWriter out = response.getWriter();
		out.print(s);
		out.close();
		/*
		 * ServletOutputStream servletoutputstream = response.getOutputStream(); byte abyte0[] = s.getBytes(); response.setContentLength(abyte0.length); servletoutputstream.write(abyte0); servletoutputstream.close();
		 */
	}

	public Text hrefGlance(String member,String community) throws SQLException
	{
		return hrefGlance(new RV(member,community));
	}

	public Text hrefGlance(String strR,String strV,String community) throws SQLException
	{
		return hrefGlance(new RV(strR,strV));
	}

	public static Text hrefGlance(RV rv) throws SQLException
	{
		Text text = new Text(" ");
		text.add(Profile.find(rv._strR).getAnchor());
		if(!rv.isReal())
		{
			text.add(new Text("/"));
			text.add(Profile.find(rv._strV).getAnchor());
		}
		return text;
	}

	public static Text hrefGlanceWithName(RV rv,int i) throws Exception
	{
		Text text = new Text(" ");
		Profile profile = Profile.find(rv._strR);
		String s = profile.getLastName(i);
		String s1 = profile.getFirstName(i);
		if(s == null && s1 == null)
		{
			Resource r = new Resource();
			text.add(new Text(r.getString(i,"NoName")));
		} else
		{
			if(i == 1 || i == 2)
			{
				text.add(new Anchor("/servlet/NewMessage?Receiver=" + rv._strR,(s + s1),"_blank"));
				text.add(Profile.find(rv._strR).getAnchor());
			} else
			{
				text.add(new Anchor("/servlet/NewMessage?Receiver=" + rv._strR,(s1 + s),"_blank"));
				text.add(Profile.find(rv._strR).getAnchor());
			}
			if(!rv.isReal())
			{
				Profile profile1 = Profile.find(rv._strV);
				String s2 = profile1.getLastName(i);
				String s3 = profile1.getFirstName(i);
				text.add(new Text("/"));
				if(i == 1 || i == 2)
				{
					text.add(new Anchor("/servlet/NewMessage?Receiver=" + rv._strV,(s2 + s3),"_blank"));
					text.add(Profile.find(rv._strV).getAnchor());
				} else
				{
					text.add(new Anchor("/servlet/NewMessage?Receiver=" + rv._strV,(s3 + s2),"_blank"));
					text.add(Profile.find(rv._strV).getAnchor());
				}
			}
		}
		return text;
	}

	public void init(ServletConfig servletconfig) throws ServletException
	{
		super.init(servletconfig);
		r = new Resource();
		r.add("tea/ui/node/general/NodeServlet").add("/tea/ui/node/listing/EditListing");
	}

	/*
	 * public Text getListings(int i, RV rv, int j, int k) throws SQLException { return getListings(i, rv, j, k, false); }
	 */
	public static String getDetailText(Node node,int language,int listing,String s,String s1,String target) throws SQLException
	{
		switch(node.getType())
		{
		case 0: // 文件�?
			return(node.getText(language));
		case 1: // 类别
			return(node.getText(language));
			// case 3: // '\003'
			// return getPollDetail(node, i, language, s, s1);
		case 4: // '\004'
			// return getBuyDetail(node, i, language, s, s1);
			// return Commodity.getDetail(node, listing, language, target, path);
		case 9: // '\t'
			return getQuizDetail(node,node._nNode,language,s,s1);
		case 12: // '\f'
			return Book.getDetail(node,language,listing,target);
		case 13: // '\r'
			return getNewsDetail(node,node._nNode,language,s,s1);
		case 14: // '\016'
			return getWeatherDetail(node,node._nNode,language,s,s1);
			//case 15: // '\017'
			//    return Stock.getDetail(node,language,listing,target);
			/*
			 * case 5: // '\005' case 6: // '\006' case 7: // '\007' case 8: // '\b' case 10: // '\n' case 11: // '\013' case 16: // '\020' case 17: // '\021' case 18: // '\022' case 19: // '\023' case 20: // '\024' case 21: // '\025' case 22: // '\026' case 23: // '\027' case 24: // '\030' case 25: // '\031' case 26: // '\032' case 27: // '\033' case 28: // '\034' case 29: // '\035' case 30: // '\036' case 31: // '\037' case 32: // ' ' case 33: // '!' case 34: // '"' case 35: // '#' case 36: //
			 * '$' case 37: // '%' case 38: // '&' case 39: // '\''
			 */
		case 44: // ��ֽ����
			return getNewsDetail(node._nNode,language);
		default:
			return "";
		}
	}

//    public String getListings___(Http h,int position,boolean editmode) throws SQLException
//    {
//        StringBuilder text = new StringBuilder();
//        RV rv = h.username == null ? null : new RV(h.username);
//        int i = h.node;
//        try
//        {
//            for(Enumeration enumeration = Listing.find(i,h.status,position,true);enumeration.hasMoreElements();)
//            {
//                int i1 = ((Integer) enumeration.nextElement()).intValue(); // �оٺ�
//                Listing listing = Listing.find(i1);
//                int j1 = listing.getNode();
//                int k1 = listing.getVisible(); // ����:0=������ 1=��¼֮ǰ 2=��¼֮��
//                // 3=׼�����֮�?4=׼�����֮��?5=����/�оٴ�����
//                // 6=�ڵ㴴����
//                if(k1 == 0 || k1 == 1 && rv == null || k1 == 2 && rv != null || k1 == 3 && rv != null && AccessMember.find(i,rv._strV).getPurview() < 0 || k1 == 4 && rv != null && AccessMember.find(i,rv._strV).getPurview() != -1 || k1 == 5 && rv != null && Node.find(j1).isCreator(rv) || k1 == 6 && rv != null && Node.find(i).isCreator(rv))
//                {
//                    int l1 = listing.getUpdateGap();
//                    {
//                        int i2 = (listing.getOptions() & 0x10) != 0 ? i : 0; // 0x10->ListingOCurrentNode
//                        text.append(getListingText(h,listing,editmode));
//                    }
//                }
//            }
//        } catch(Exception e)
//        {
//            e.printStackTrace();
//        }
//        return text.toString();
//    }

	public static void delete_html_community(final String community)
	{
		new Thread()
		{
			public void run()
			{
				//System.out.println("生产缓存页面");
				File bak = new File(Common.REAL_PATH + "/res/html/");
				bak.mkdirs();
				File fs[] = new File(Common.REAL_PATH + "/res/" + community + "/html/").listFiles();
				if(fs != null)
				{
					for(int i = 0;i < fs.length;i++)
					{
						String name = fs[i].getName();
						int j = name.indexOf("_");
						if(j != -1)
						{
							File f = new File(bak,name.substring(0,j) + ".html");
							f.delete();
							fs[i].renameTo(f);
						}
						fs[i].delete();
					}
				}
			}
		}.start();
	}


	public static void delete(Node n)
	{
		try
		{
			Html t = Html.find(n.getCommunity());
			final int langs = License.getInstance().getWebLanguages();
			if(t.minute > 0)
			{
				String[] arr = n.getPath().split("/");
				for(int i = 1;i < arr.length;i++)
				{
					n = Node.find(Integer.parseInt(arr[i]));
					for(int j = 0;j < Common.LANGUAGE.length;j++)
					{
						if((langs & 1 << j) == 0)
							continue;
						if(Http.REAL_PATH.contains("webapps_cien")){
							try{
								Http.open("http://www.cien.com.cn/_cc_" + n.getAnchor(j,0),null);
								System.out.println("cc成功：http://www.cien.com.cn/_cc_" + n.getAnchor(j,0));
							}catch(IOException e){
								System.out.println("cc失败：http://www.cien.com.cn/_cc_" + n.getAnchor(j,0));
							}
						}
						new File(Http.REAL_PATH + "/xhtml" + j + "/" + (n.getType() >= 1024 ? "node" : Node.NODE_TYPE[n.getType()].toLowerCase()) + "/" + n._nNode / 10000 + "/" + n._nNode % 10000 + "-" + 1 + ".htm").delete();
						for(int p = n.getType() > 1 ? 20 : 1;p > 0;p--)
						{
							new File(Http.REAL_PATH + "/html" + j + "/" + (n.getType() >= 1024 ? "node" : Node.NODE_TYPE[n.getType()].toLowerCase()) + "/" + n._nNode / 10000 + "/" + n._nNode % 10000 + "-" + p + ".htm").delete();
							//new File(Http.REAL_PATH + n.getAnchor(j,0).replaceFirst("-1","-" + p)).delete();
						}
					}
				}
				if(Http.REAL_PATH.contains("webapps_cien")){
					try{
						Http.open("http://www.cien.com.cn/_ccc_" ,null);
						System.out.println("cc成功：http://www.cien.com.cn/_ccc_" );
					}catch(IOException e){
						System.out.println("cc失败：http://www.cien.com.cn/_ccc_" );
					}
				}

				return;
			}
			new Thread()
			{
				public void run()
				{
					for(int j = 0;j < Common.LANGUAGE.length;j++)
					{
						if((langs & 1 << j) == 0)
							continue;
						Filex.delete(new File(Http.REAL_PATH + "/html" + j));
						Filex.delete(new File(Http.REAL_PATH + "/xhtml" + j));
					}
				}
			}.start();
		} catch(Exception ex)
		{
			ex.printStackTrace();
		}
	}

	public static String write(String community,byte by[],String ex) throws IOException,SQLException
	{
		return write(community,new SimpleDateFormat("yyMM").format(new Date()),by,ex);
	}

	public static String write(String community,String cpath,byte by[],String ex) throws IOException,SQLException
	{
		Cluster c = Cluster.getInstance();
		String path = "/" + c.getPath() + "/" + community + "/" + cpath + "/";
		if(ex.endsWith(".jsp"))
		{
			ex = ex + ".html";
		}
		File f;
		if(!ex.startsWith("."))
		{
			int i = by.length / 100 + ex.length();
			String tmp;
			do
			{
				tmp = path + (i++) + "/" + ex;
				f = new File(Common.REAL_PATH + tmp);
			} while(f.exists());
			f.getParentFile().mkdirs();
			path = tmp;
		} else
		{
			f = new File(Common.REAL_PATH + path);
			f.mkdirs();
			f = File.createTempFile(cpath.substring(cpath.lastIndexOf("/") + 1),ex,f);
			path = path + f.getName();
		}
		FileOutputStream fos = new FileOutputStream(f);
		fos.write(by);
		fos.close();
		c.add(path); // 保存文件列表
		return path;
	}

	public static String copy(String community,String content)
	{
		ArrayList al = new ArrayList();
		Matcher m = Pattern.compile("src=\"(http://[^\"]+)\"").matcher(content);
		while(m.find())
		{
			String url = m.group(1);
			if(al.indexOf(url) != -1)
				continue;
			try
			{
				//对中文路径转码
				char[] ch = url.toCharArray();
				StringBuilder sb = new StringBuilder(ch.length);
				for(int i = 0;i < ch.length;i++)
				{
					String tmp = String.valueOf(ch[i]);
					sb.append(ch[i] > 1024 ? URLEncoder.encode(tmp,"UTF-8") : tmp);
				}
				//
				HttpURLConnection conn = (HttpURLConnection)new URL(sb.toString()).openConnection();
				conn.setRequestProperty("referer",url);
				byte[] by = Entity.read(conn.getInputStream());
				String path = write(community,by,url.substring(url.lastIndexOf('/') + 1).replace('%','_'));
				content = content.replaceAll(url,path);
				al.add(url);
			} catch(Exception ex)
			{
				ex.printStackTrace();
			}
		}
		return content;
	}
}
