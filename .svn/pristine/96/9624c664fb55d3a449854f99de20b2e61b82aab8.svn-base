package tea.entity.node;

import tea.db.DbAdapter;
import tea.entity.*;
import tea.html.*;
import tea.ui.TeaSession;
import java.sql.SQLException;
import java.util.*;

//3
public class Poll extends Entity
{
    private int _nNode;
    private boolean _blLoaded;
    private static Cache _cache = new Cache(100);
    private String picture;
    private int language;
    private String question;
    private int tops;
    private int point;
    private int id;
    private int type; // 0:单选 1:多选 2文本框 3文本域

    public static String TYPE_TEXT[] =
            {"Radio","Checkbox","InputText","Textarea"};
    private int correct; //是否正确答案
    private int sequence;
    private int nodeid;
    private boolean need;
    private String correct_ch; //多选的正确答案


    public void set(int _nNode,int language,String question,int type,boolean need,int sequence,String picture,int tops,int point,int nodeid) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int j = db.executeUpdate("UPDATE PollLayer SET nodeid =" + nodeid + " ,  question=" + DbAdapter.cite(question) + ",type=" + type + ",need=" + DbAdapter.cite(need) + ",sequence=" + sequence + ",picture=" + DbAdapter.cite(picture) + ",tops=" + tops + ",point=" + point + " WHERE id=" + id);
            if(j < 1)
            {
                db.executeUpdate("INSERT INTO PollLayer(node, language, question,type,need,sequence,picture,tops,point,nodeid)VALUES (" + _nNode + ", " + language + ", " + DbAdapter.cite(question) + "," + type + "," + DbAdapter.cite(need) + "," + sequence + "," + DbAdapter.cite(picture) + "," + tops + "," + point + "," + nodeid + ")");
            }
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(id));
        this._nNode = _nNode;
        this.language = language;
        this.question = question;
        this.type = type;
        this.need = need;
        this.sequence = sequence;
        this.picture = picture;
        this.tops = tops;
        this.point = point;
        this.nodeid = nodeid;
    }

    public static int create(int node,int language,String question,int type,boolean need,int sequence,String picture,int tops,int point,int correct,int nodeid) throws SQLException
    {
        int id = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO PollLayer(node,language,question,type,need,sequence,picture,tops,point,correct,nodeid)VALUES(" + node + ", " + language + ", " + DbAdapter.cite(question) + "," + type + "," + DbAdapter.cite(need) + "," + sequence + "," + DbAdapter.cite(picture) + "," + tops + "," + point + "," + correct + "," + nodeid + ")");
            id = db.getInt("SELECT MAX(id) FROM PollLayer");
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(id));
        return id;
    }

    private Poll(int id) throws SQLException
    {
        _blLoaded = false;
        this.id = id;
        loadBasic();
    }

    public String getQuestion() throws SQLException
    {
        if(this.question == null)
        {
            return "";
        } else
        {
            return question; // new String(question.getBytes("ISO-8859-1"),"UTF-8");
        }
    }

    private void loadBasic() throws SQLException
    {
        if(!_blLoaded)
        {
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT node,language,question,type,need,sequence,picture,tops,point,correct,nodeid,correct_ch FROM PollLayer WHERE id=" + this.id);
                if(db.next())
                {
                    _nNode = db.getInt(1);
                    language = db.getInt(2);
                    question = db.getText(language,language,3);
                    type = db.getInt(4);
                    need = db.getInt(5) != 0;
                    sequence = db.getInt(6);
                    picture = db.getString(7);
                    tops = db.getInt(8);
                    point = db.getInt(9);
                    correct = db.getInt(10);
                    nodeid = db.getInt(11);
                    correct_ch = db.getString(12);
                }
            } finally
            {
                db.close();
            }
            _blLoaded = true;
        }
    }


    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM PollLayer  WHERE id=" + id);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(id));
    }

    public static Poll find(int id) throws SQLException
    {
        Poll poll = (Poll) _cache.get(new Integer(id));
        if(poll == null)
        {
            poll = new Poll(id);
            _cache.put(new Integer(id),poll);
        }
        return poll;
    }

    public static Enumeration findByNode(int _nNode,int _nLanguage,int pos,int size)
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id FROM PollLayer WHERE node= " + _nNode + " AND language=" + _nLanguage + " ORDER BY sequence",pos,size);
            while(db.next())
            {
                vector.addElement(new Integer(db.getInt(1)));
            }
        } catch(Exception exception)
        {
            exception.printStackTrace();
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id FROM PollLayer WHERE 1=1 " + sql + " ORDER BY sequence",pos,size);
            while(db.next())
            {
                al.add(db.getInt(1));
            }
        } finally
        {
            db.close();
        }
        return al;
    }

    public static Enumeration findByNode(String sql,int _nNode,int _nLanguage,int pos,int size)
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id FROM PollLayer WHERE node= " + _nNode + " AND language=" + _nLanguage + sql + " ORDER BY sequence",pos,size);
            while(db.next())
            {
                vector.addElement(new Integer(db.getInt(1)));
            }
        } catch(Exception exception)
        {
            exception.printStackTrace();
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    //显示记录数
    public static int count(int _nNode,int _nLanguage) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT count(node) FROM PollLayer WHERE node= " + _nNode + " AND language=" + _nLanguage);
            if(db.next())
            {
                count = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return count;
    }


    public static Enumeration find(String sql)
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id FROM PollLayer WHERE 1=1 " + sql + " ORDER BY sequence");
            while(db.next())
            {
                vector.addElement(new Integer(db.getInt(1)));
            }
        } catch(Exception exception)
        {
            exception.printStackTrace();
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public String getPicture()
    {
        if(picture == null)
        {
            return "";
        }
        return picture;
    }

    public void setCorrect(int correct)
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE PollLayer SET correct=" + correct + " WHERE id=" + id);
        } catch(Exception exception)
        {
            exception.printStackTrace();
        } finally
        {
            db.close();
        }
        this.correct = correct;
    }

    public void setCorrect_ck(String correct_ch)
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE PollLayer SET correct_ch=" + db.cite(correct_ch) + " WHERE id=" + id);
        } catch(Exception exception)
        {
            exception.printStackTrace();
        } finally
        {
            db.close();
        }
        this.correct_ch = correct_ch;
    }

    public int getLanguage()
    {
        return language;
    }

    public int getTop()
    {
        return tops;
    }

    public int getType()
    {
        return type;
    }

    public int getPoint()
    {
        return point;
    }

    public int getCorrect()
    {
        return correct;
    }

    public int getSequence()
    {
        return sequence;
    }

    public boolean isNeed()
    {
        return need;
    }

    public int getNode()
    {
        return _nNode;
    }

    public int getID()
    {
        return id;
    }

    public int getNodeid()
    {
        return nodeid;
    }

    public String getCorrect_ch()
    {
        return correct_ch;
    }


//	public String getDetail(Node node,int language,int listing,String target) throws SQLException
    public static String getDetail(Node node,Http h,int listing,String target,tea.resource.Resource r) throws SQLException // (Node node, int i, int j, String s, String s1) throws SQLException
    {
        int language = h.language;
        int bool_poll = 0;
        int _nNode = node._nNode;
        int pollpos = h.getInt("pollpos");
        int PollChoicePos = h.getInt("PollChoicePos");
        int PollChoiceSize = Integer.MAX_VALUE;
        String tmp;
        //对投票列举选项名称的搜索
        String SearchName = h.get("SearchName","");

        StringBuilder text = new StringBuilder();
        if(ListingDetail.isLoad(listing,3,language,"pollButton") || ListingDetail.isLoad(listing,3,language,"singlepollButton")) //投票按钮
        {
            text.append("<script>");
            text.append("function f_singlepollButton(igd){");
            text.append("foVote.textsinglepollButton.value=igd;");
            text.append("foVote.submit();");
            text.append("}");
            text.append("</script>");
            text.append("<form name='foVote' method='POST' action='/PollVotes.do' target='_ajax'>");
            text.append("<input type='hidden' name='node' value=" + _nNode + ">");
            text.append("<input type='hidden' name='act' value='add'>");
            text.append("<input type='hidden' name='pollpos' value=" + pollpos + ">");
            text.append("<input type='hidden' name='nexturl' value='" + h.request.getRequestURI() + "?" + h.request.getQueryString() + "'>");
            text.append("<input type='hidden' name='textsinglepollButton' >");
        }

        String subject = node.getSubject(language);
        Span span = null;
        String dateFormat[] =
                {"yyyy-MM-dd","MM-dd-yyyy","dd-MM-yyyy","yyyy.MM.dd","MM.dd.yyyy","dd.MM.yyyy"};

        ListingDetail detail_2 = ListingDetail.find(listing,3,language);
        int size = Integer.MAX_VALUE;
        StringBuffer value = new StringBuffer();

        java.util.Iterator e2 = detail_2.keys();
        while(e2.hasNext())
        {
            String name2 = (String) e2.next();
            int istype2 = detail_2.getIstype(name2);
            if(istype2 == 0)
            {
                continue;
            }

            if("pollpage".equals(name2))
            {
                size = detail_2.getSequence(name2);
            } else

            if("getSubject".equals(name2)) //投票主题
            {
                value.append(detail_2.getBeforeItem(name2));

                value.append(detail_2.getOptionsToHtml2(name2,subject,"<a href=/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/category/" + _nNode + "-" + language + ".htm>")); //限制字数

                value.append(detail_2.getAfterItem(name2));
            } else

            if("picture".equals(name2)) //投票简介 图片
            {
                value.append(detail_2.getBeforeItem(name2));
                value.append("<img id=pictureid src=" + node.getPicture(language) + " >");
                value.append(detail_2.getAfterItem(name2));
            } else
            if("filename".equals(name2)) //显示月份 图片
            {
                value.append(detail_2.getBeforeItem("filename"));
                String str = node.getFileName(language);
                if(str != null && str.length() > 0)
                    value.append("<img id=filenameid src=" + str + " >");
                value.append(detail_2.getAfterItem("filename"));
            } else
            if("repic".equals(name2)) //相关 图片
            {
                value.append(detail_2.getBeforeItem("repic"));
                value.append("<img id=repicid src=" + node.getRepic(language) + " >");
                value.append(detail_2.getAfterItem("repic"));
            } else
            if("stoptime".equals(name2)) //截止日期
            {
                value.append(detail_2.getBeforeItem("stoptime"));
                Date stop = node.getStopTime();
                if((node.getOptions1() & 0x40000000) != 0 && stop != null)
                {
                    value.append("<span id='PollIDstoptime_" + node._nNode + "' title='" + MT.f(stop) + "'><script>mt.clock('PollIDstoptime_" + node._nNode + "')</script></span>");
                }
                value.append(detail_2.getAfterItem("stoptime"));
            } else
            if("subcontent".equals(name2)) //投票主题简介
            {
                value.append(detail_2.getBeforeItem("subcontent"));
                value.append(node.getText(language));
                value.append(detail_2.getAfterItem("subcontent"));
            }

        }

        String question = h.get("question"); //对问题的搜索
        String sql_question = "";
        if(question != null && question.length() > 0)
        {
            sql_question = " and question like " + DbAdapter.cite("%" + question + "%") + " ";
        }

        Enumeration enumer_poll = Poll.findByNode(sql_question,node._nNode,language,pollpos,size);
        int count = Poll.count(node._nNode,h.language);
        int pccount = 0;
        while(enumer_poll.hasMoreElements()) //问题的循环
        {
            int poll_id = ((Integer) enumer_poll.nextElement()).intValue();
            Poll poll_obj = Poll.find(poll_id);
            text.append("<input type='hidden' name='poll' value=" + poll_id + ">");

            if(ListingDetail.isLoad(listing,3,language,"question")) //投票问题
            {
                value.append(detail_2.getBeforeItem("question"));
                value.append(detail_2.getOptionsToHtml2("question",poll_obj.getQuestion(),"<a href=/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/node/" + poll_obj.getNodeid() + "-" + language + ".htm target=_blank>"));
                value.append(detail_2.getAfterItem("question"));
            }
            if(ListingDetail.isLoad(listing,3,language,"pollButton")) //输入框
            {
                switch(poll_obj.getType())
                {
                case 2:
                    value.append("<input name='answer" + poll_id + "' size='50' />");
                    break;
                case 3:
                    value.append("<span id='PollIDanswer'><textarea name='answer" + poll_id + "' cols='50' rows='5'></textarea></span>");
                    break;
                }
            }
//            if(ListingDetail.isLoad(listing,3,language,"date")) //日期总
//            {
//                value.append(detail_2.getBeforeItem("date"));
//                Date date1 = tea.entity.node.PollResult.getStartTime(poll_id,language);
//                if(date1 != null)
//                {
//                    value.append(new java.text.SimpleDateFormat(dateFormat[detail_2.getAnchor("date")]).format(date1) + "-" + new java.text.SimpleDateFormat(dateFormat[detail_2.getAnchor("date")]).format(new Date()));
//                }
//                value.append(detail_2.getAfterItem("date"));
//            }
//            if(ListingDetail.isLoad(listing,3,language,"dateMonth")) //日期月
//            {
//                value.append(detail_2.getBeforeItem("dateMonth"));
//                Date date1 = tea.entity.node.PollResult.getStartTime(poll_id,language);
//                if(date1 != null)
//                {
//                    value.append(new java.text.SimpleDateFormat(dateFormat[detail_2.getAnchor("dateMonth")]).format(new Date(System.currentTimeMillis() - (30L * 24L * 60L * 60L * 1000L))) + "-" + new java.text.SimpleDateFormat(dateFormat[detail_2.getAnchor("dateMonth")]).format(new Date()));
//                }
//                value.append(detail_2.getAfterItem("dateMonth"));
//
//            }
//            if(ListingDetail.isLoad(listing,3,language,"dateWeek")) //日期周
//            {
//                value.append(detail_2.getBeforeItem("dateWeek"));
//                Date date1 = tea.entity.node.PollResult.getStartTime(poll_id,language);
//                if(date1 != null)
//                {
//                    value.append(new java.text.SimpleDateFormat(dateFormat[detail_2.getAnchor("dateWeek")]).format(new Date(System.currentTimeMillis() - (7 * 24 * 60 * 60 * 1000))) + "-" + new java.text.SimpleDateFormat(dateFormat[detail_2.getAnchor("dateWeek")]).format(new Date()));
//                }
//                value.append(detail_2.getAfterItem("dateWeek"));
//            }

            //循环选项的
            //选项投票个数排序

            String sql = "";
            if(ListingDetail.isLoad(listing,3,language,"sorting"))
            {
                //"  order by sequence asc "; //投票顺序
                if(detail_2.getAnchor("sorting") == 1)
                {
                    sql = "  order by sequence asc "; //投票顺序
                } else if(detail_2.getAnchor("sorting") == 2) //结果
                {
                    sql = " order by sorting desc ";
                } else
                {
                    sql = " order by id desc ";
                }
            }
            String sql_2 = "";
            if(SearchName.length() > 0)
            {
                sql = "   and title like " + DbAdapter.cite("%" + SearchName + "%") + sql;
                sql_2 = " and title like " + DbAdapter.cite("%" + SearchName + "%");
            }

            if(ListingDetail.isLoad(listing,3,language,"PollChoiceSize"))
            {
                PollChoiceSize = detail_2.getSequence("PollChoiceSize");
            }

            //Enumeration enumer_poll_choice = PollChoice.find(poll_id,poll_obj.getTop(),1,sql,PollChoicePos,PollChoiceSize);
            Enumeration enumer_poll_choice = PollChoice.find(" AND poll=" + poll_id + sql,PollChoicePos,PollChoiceSize);
            pccount = PollChoice.countByPoll(poll_id,sql_2);
            for(int ir = 0;enumer_poll_choice.hasMoreElements();ir++)
            {
                int poll_choice_id = ((Integer) enumer_poll_choice.nextElement()).intValue();
                PollChoice poll_choice_obj = PollChoice.find(poll_choice_id);
                //System.out.println(ir);
                ListingDetail detail = ListingDetail.find(listing,3,language);

                java.util.Iterator e = detail.keys();
                while(e.hasNext())
                {
                    String name = (String) e.next();

                    int istype = detail.getIstype(name);
                    if(istype == 0)
                    {
                        continue;
                    }

                    if(name.equals("choice")) //选项编号
                    {
                        value.append(detail.getBeforeItem(name));
                        value.append(poll_choice_obj.getChoice());
                        value.append(detail.getAfterItem(name));
                    } else if(name.equals("titles")) //选项名称
                    {
                        value.append(detail.getBeforeItem(name));
                        value.append(detail.getOptionsToHtml2("titles",poll_choice_obj.getTitle(),"<a href=/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/node/" + poll_obj.getNodeid() + "-" + language + ".htm?Poll=" + poll_choice_id + " target=_blank>"));
                        value.append(detail.getAfterItem(name));
                    } else if(name.equals("firstname")) //作者
                    {
                        value.append(detail.getBeforeItem(name));
                        value.append(poll_choice_obj.getFirstname());
                        value.append(detail.getAfterItem(name));
                    } else if(name.equals("memberinfo")) //选项导语
                    {
                        value.append(detail.getBeforeItem(name));

                        value.append(detail.getOptionsToHtml2("memberinfo",poll_choice_obj.getMemberinfo(),"<a href=/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/node/" + poll_obj.getNodeid() + "-" + language + ".htm?Poll=" + poll_choice_id + " target=_blank>"));

                        value.append(detail.getAfterItem(name));
                    } else if(name.equals("linkman")) //联系方式
                    {
                        value.append(detail.getBeforeItem(name));
                        value.append(poll_choice_obj.getLinkman());
                        value.append(detail.getAfterItem(name));
                    } else if(name.equals("bigPicture")) //大图
                    {
                        value.append(detail.getBeforeItem(name));
                        value.append("<SPAN ID='PollbigPicture'>");
                        if(detail.getAnchor(name) == 1)
                        {
                            value.append("<a href =" + poll_choice_obj.getBigPicture() + " target=_blank>");
                        } else if(detail.getAnchor(name) == 2)
                        {
                            value.append("<a href=/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/node/" + poll_obj.getNodeid() + "-" + language + ".htm?Poll=" + poll_choice_id + " target=_blank>");
                        }
                        value.append("<img src=" + poll_choice_obj.getBigPicture() + ">");
                        if(detail.getAnchor(name) != 0)
                        {
                            value.append("</a>");
                        }
                        value.append("</SPAN>");
                        value.append(detail.getAfterItem(name));

                    } else if(name.equals("smallPicture")) //小图
                    {
                        value.append(detail.getBeforeItem(name));

                        value.append("<SPAN ID='PollsmallPicture'>");
                        if(detail.getAnchor(name) == 1)
                        {
                            value.append("<a href =" + poll_choice_obj.getSmallPicture() + ">");
                        } else if(detail.getAnchor(name) == 2)
                        {
                            value.append("<a href=/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/node/" + poll_obj.getNodeid() + "-" + language + ".htm?Poll=" + poll_choice_id + " target=_blank>");
                        }
                        value.append("<img src=" + poll_choice_obj.getSmallPicture() + ">");
                        if(detail.getAnchor(name) != 0)
                        {
                            value.append("</a>");
                        }
                        value.append("</SPAN>");

                        value.append(detail.getAfterItem(name));
                    } else if(name.equals("content")) //简介
                    {
                        value.append(detail.getBeforeItem(name));
                        value.append(detail.getOptionsToHtml2("content",poll_choice_obj.getPollinfo(),"<a href=/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/node/" + poll_obj.getNodeid() + "-" + language + ".htm?Poll=" + poll_choice_id + " target=_blank>"));
                        value.append(detail.getAfterItem(name));

                    } else if(name.equals("pollButton")) //选项按钮
                    {
                        switch(poll_obj.getType())
                        {
                        case 0:
                            value.append("<input type='radio' name='answer" + poll_id + "' value=" + poll_choice_id + " ");
                            if(ir == 0)
                            {
                                value.append(" checked='true'");
                            }
                            value.append(">");
                            break;
                        case 1:
                            value.append(new CheckBox("answer" + poll_id,false,String.valueOf(poll_choice_id)));
                            break;
                        }
                    } else if(name.equals("singlepollButton")) //单个投票按钮
                    {
                        value.append(detail.getBeforeItem(name));
                        value.append("<input type= button value=投票 ");
                        value.append(" onclick =f_singlepollButton('" + poll_choice_id + "'); ");
                        value.append(">");
                        value.append(detail.getAfterItem(name));
                        bool_poll = 1;
                    }
                    /*
                         else if(name.equals("result")) //结果总
                         {
                          value.append(detail.getBeforeItem(name));
                          String sb = PollChoice.getResults_ZJG(poll_id,poll_choice_id,1,language);
                          if(sb.length() > 0)
                          {
                           value.append(sb);
                          }
                          value.append(detail.getAfterItem(name));
                         }
                     */
                    //else if(name.equals("resultMonth")) //结果月
//                    {
//                        value.append(detail.getBeforeItem(name));
//
//                        String sb = PollChoice.getResults(poll_id,poll_choice_id,2,language);
//                        if(sb.length() > 0)
//                        {
//                            value.append(sb);
//                        }
//                        value.append(detail.getAfterItem(name));
//                    } else if(name.equals("resultWeek")) //结果周
//                    {
//                        value.append(detail.getBeforeItem(name));
//
//                        String sb = PollChoice.getResults(poll_id,poll_choice_id,3,language);
//                        if(sb.length() > 0)
//                        {
//                            value.append(sb);
//                        }
//                        value.append(detail.getAfterItem(name));
//                    }
                }

            }

        }

        if(ListingDetail.isLoad(listing,3,language,"pollButton")) //投票按钮
        {
            value.append(detail_2.getBeforeItem("pollButton"));
            value.append("<INPUT TYPE='SUBMIT' ID='PollIDVote' VALUE='" + r.getString(language,"Poll") + "'>");
            value.append(detail_2.getAfterItem("pollButton"));
            bool_poll = 1;
        }
        if(ListingDetail.isLoad(listing,3,language,"resultview")) //查看结果 - 按钮
        {
            value.append(detail_2.getBeforeItem("resultview"));
            if((node.getOptions1() & 0x4000000) != 0)
                value.append("<input type='button' value='查看结果' onclick=window.open('/jsp/type/poll/PollResultView.jsp?node=" + _nNode + "','','width=500,height=600,scrollbars=1') />");
            value.append(detail_2.getAfterItem("resultview"));
        }
        String sid = "";
        if(h.get("id") != null && h.get("id").length() > 0)
        {
            sid = "&id=" + h.get("id");
        }
        //问题分页
        if(ListingDetail.isLoad(listing,3,language,"pollpage") && count > size)
        {
            // value.append("<span id =pollpage>").append(new tea.htmlx.FPNL(h.language,"?node=" + h.node + "&listing=0&pollpos=",pollpos,count,size)).append("</span>");
            value.append(detail_2.getBeforeItem("pollpage"));

            value.append(new tea.htmlx.FPNL(h.language,"?node=" + h.node + sid + "&listing=0&SearchName=" + SearchName + "&pollpos=",pollpos,count,size));
            value.append(detail_2.getAfterItem("pollpage"));
        }
        //选项分页
        if(ListingDetail.isLoad(listing,3,language,"PollChoiceSize") && pccount > PollChoiceSize)
        {
            // value.append("<span id =pollpage>").append(new tea.htmlx.FPNL(h.language,"?node=" + h.node + "&listing=0&pollpos=",pollpos,count,size)).append("</span>");
            value.append(detail_2.getBeforeItem("PollChoiceSize"));
            value.append(new tea.htmlx.FPNL(h.language,"?node=" + h.node + sid + "&listing=0&SearchName=" + SearchName + "&PollChoicePos=",PollChoicePos,pccount,PollChoiceSize));
            value.append(detail_2.getAfterItem("PollChoiceSize"));
        }

        text.append("<span id='PollIDtext'>" + value.toString() + "</span>");
        if(bool_poll == 1)
        {
            text.append("</form>");
        }
        return text.toString();
    }

    public static void clone(int node,int newid) throws SQLException,CloneNotSupportedException
    {
        Iterator it = Poll.find(" AND node=" + node,0,Integer.MAX_VALUE).iterator();
        while(it.hasNext())
        {
            int id = ((Integer) it.next()).intValue();
            Poll p = Poll.find(id);
            int correct = p.getCorrect();
            int poll = Poll.create(newid,p.getLanguage(),p.getQuestion(),p.getType(),p.isNeed(),p.getSequence(),p.getPicture(),p.getTop(),p.getPoint(),correct,p.getNodeid());
            //
            Enumeration e = PollChoice.findByPoll(id);
            while(e.hasMoreElements())
            {
                int pcid = ((Integer) e.nextElement()).intValue();
                PollChoice pc = PollChoice.find(pcid).clone();
                pc.poll = poll;
                pc.set();
                if(correct == pcid) //替换最佳加答
                {
                    Poll.find(poll).setCorrect(pc.id);
                }
            }
        }
    }
}
