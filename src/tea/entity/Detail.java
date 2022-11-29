package tea.entity;

import java.util.*;

/**
 * <p>Title: 企业发展网络系统平台</p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2004</p>
 * @author EC37
 * @version 2004
 */
public class Detail
{
    private String itemName;
    private String before;
    private String after;
    private int anchor;
    private String itemValue;
    private int quantity;
    private Date time;

    public Detail()
    {

    }

    public void setItemName(String itemName)
    {

        this.itemName = itemName;
    }

    public void setBefore(String before)
    {
        this.before = before;
    }

    public void setAfter(String after)
    {
        this.after = after;
    }

    public void setAnchor(int anchor)
    {
        this.anchor = anchor;
    }

    public void setItemValue(String itemValue)
    {
        this.itemValue = itemValue;
    }

    public void setQuantity(int quantity)
    {
        this.quantity = quantity;
    }

    public void setTime(Date time)
    {
        this.time = time;
    }

    public void setItemValue(int itemValue)
    {
        this.itemValue = String.valueOf(itemValue);
    }


    public String getItemName()
    {

        return itemName;
    }

    public String getBefore()
    {
        return before;
    }

    public String getAfter()
    {
        return after;
    }

    public int getAnchor()
    {
        return anchor;
    }

    public String getItemValue()
    {
        if (itemValue == null)
        {
            return null;
        }
        //correlation 新闻资讯中的相关性
        if (quantity <= 0 || (itemValue.length()) <= quantity ||itemName.toLowerCase().startsWith("correlation")) // / 2
        {
            return itemValue;
        } else
        {
            return itemValue.substring(0, quantity) + "...";
        }
    }

    public int getQuantity()
    {
        return quantity;
    }

    public Date getTime()
    {
        return time;
    }
}
