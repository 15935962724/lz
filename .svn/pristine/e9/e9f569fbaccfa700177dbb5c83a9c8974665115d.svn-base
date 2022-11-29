package tea.entity.node;

import java.beans.*;

import java.awt.*;


public class DestineBeanInfo extends SimpleBeanInfo
{
    Class beanClass = getClass();
    String iconColor16x16Filename;
    String iconColor32x32Filename;
    String iconMono16x16Filename;
    String iconMono32x32Filename;

    public DestineBeanInfo()
    {
    }

    public PropertyDescriptor[] getPropertyDescriptors()
    {
        try
        {
            PropertyDescriptor _destineCode = new PropertyDescriptor(
                "destineCode", beanClass, "getDestineCode", null);

            PropertyDescriptor _destineDate = new PropertyDescriptor(
                "destineDate", beanClass, "getDestineDate", null);
            _destineDate.setDisplayName("DestineDate");
            _destineDate.setShortDescription("DestineDate");

            PropertyDescriptor _earlyArrive = new PropertyDescriptor(
                "earlyArrive", beanClass, "getEarlyArrive", "setEarlyArrive");

            PropertyDescriptor _eveningArrive = new PropertyDescriptor(
                "eveningArrive", beanClass, "getEveningArrive", "setEveningArrive");

            PropertyDescriptor _guestType = new PropertyDescriptor(
                "guestType", beanClass, "getGuestType", "setGuestType");

            PropertyDescriptor _handset = new PropertyDescriptor(
                "handset", beanClass, "getHandset", "setHandset");

            PropertyDescriptor _humanCount = new PropertyDescriptor(
                "humanCount", beanClass, "getHumanCount", "setHumanCount");

            PropertyDescriptor _humanName = new PropertyDescriptor(
                "humanName", beanClass, "getHumanName", "setHumanName");

            PropertyDescriptor _id = new PropertyDescriptor(
                "id", beanClass, "getId", null);
            _id.setDisplayName("id");
            _id.setShortDescription("id");

            PropertyDescriptor _kipDate = new PropertyDescriptor(
                "kipDate", beanClass, "getKipDate", "setKipDate");

            PropertyDescriptor _language = new PropertyDescriptor(
                "language", beanClass, "getLanguage", "setLanguage");

            PropertyDescriptor _leaveDate = new PropertyDescriptor(
                "leaveDate", beanClass, "getLeaveDate", "setLeaveDate");

            PropertyDescriptor _linkmanAffirm = new PropertyDescriptor(
                "linkmanAffirm", beanClass, "getLinkmanAffirm", "setLinkmanAffirm");

            PropertyDescriptor _linkmanEnd = new PropertyDescriptor(
                "linkmanEnd", beanClass, "getLinkmanEnd", null);

            PropertyDescriptor _linkmanFax = new PropertyDescriptor(
                "linkmanFax", beanClass, "getLinkmanFax", "setLinkmanFax");

            PropertyDescriptor _linkmanHandset = new PropertyDescriptor(
                "linkmanHandset", beanClass, "getLinkmanHandset", "setLinkmanHandset");

            PropertyDescriptor _linkmanMail = new PropertyDescriptor(
                "linkmanMail", beanClass, "getLinkmanMail", "setLinkmanMail");

            PropertyDescriptor _linkmanName = new PropertyDescriptor(
                "linkmanName", beanClass, "getLinkmanName", "setLinkmanName");

            PropertyDescriptor _linkmanPhone = new PropertyDescriptor(
                "linkmanPhone", beanClass, "getLinkmanPhone", "setLinkmanPhone");

            PropertyDescriptor _linkmanPhoneStart = new PropertyDescriptor(
                "linkmanPhoneStart", beanClass, "getLinkmanPhoneStart", null);

            PropertyDescriptor _linkmanSex = new PropertyDescriptor(
                "linkmanSex", beanClass, "isLinkmanSex", "setLinkmanSex");

            PropertyDescriptor _node = new PropertyDescriptor(
                "node", beanClass, "getNode", "setNode");

            PropertyDescriptor _otherAddBed = new PropertyDescriptor(
                "otherAddBed", beanClass, "getOtherAddBed", "setOtherAddBed");

            PropertyDescriptor _otherAddress = new PropertyDescriptor(
                "otherAddress", beanClass, "getOtherAddress", "setOtherAddress");

            PropertyDescriptor _otherPostalcode = new PropertyDescriptor(
                "otherPostalcode", beanClass, "getOtherPostalcode", "setOtherPostalcode");

            PropertyDescriptor _otherRequest = new PropertyDescriptor(
                "otherRequest", beanClass, "getOtherRequest", "setOtherRequest");

            PropertyDescriptor _otherSend = new PropertyDescriptor(
                "otherSend", beanClass, "isOtherSend", "setOtherSend");

            PropertyDescriptor _paymentType = new PropertyDescriptor(
                "paymentType", beanClass, "getPaymentType", "setPaymentType");

            PropertyDescriptor _phone = new PropertyDescriptor(
                "phone", beanClass, "getPhone", "setPhone");

            PropertyDescriptor _roomCount = new PropertyDescriptor(
                "roomCount", beanClass, "getRoomCount", "setRoomCount");

            PropertyDescriptor _roomType = new PropertyDescriptor(
                "roomType", beanClass, "getRoomType", "setRoomType");

            PropertyDescriptor[] pds = new PropertyDescriptor[]
                {
                _destineCode,
                _destineDate,
                _earlyArrive,
                _eveningArrive,
                _guestType,
                _handset,
                _humanCount,
                _humanName,
                _id,
                _kipDate,
                _language,
                _leaveDate,
                _linkmanAffirm,
                _linkmanEnd,
                _linkmanFax,
                _linkmanHandset,
                _linkmanMail,
                _linkmanName,
                _linkmanPhone,
                _linkmanPhoneStart,
                _linkmanSex,
                _node,
                _otherAddBed,
                _otherAddress,
                _otherPostalcode,
                _otherRequest,
                _otherSend,
                _paymentType,
                _phone,
                _roomCount,
                _roomType
            };
            return pds;
        } catch (Exception exception)
        {
            exception.printStackTrace();
            return null;
        }
    }

    public Image getIcon(int iconKind)
    {
        switch (iconKind)
        {
        case BeanInfo.ICON_COLOR_16x16:
            return ( (iconColor16x16Filename != null)
                    ? loadImage(iconColor16x16Filename) : null);

        case BeanInfo.ICON_COLOR_32x32:
            return ( (iconColor32x32Filename != null)
                    ? loadImage(iconColor32x32Filename) : null);

        case BeanInfo.ICON_MONO_16x16:
            return ( (iconMono16x16Filename != null)
                    ? loadImage(iconMono16x16Filename) : null);

        case BeanInfo.ICON_MONO_32x32:
            return ( (iconMono32x32Filename != null)
                    ? loadImage(iconMono32x32Filename) : null);
        }

        return null;
    }}
