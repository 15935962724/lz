package tea.service;
import tea.entity.member.*;
public class Robot
{
    public Robot()
    {
		// _sendEmail = null;
		// _getEmail = null;
		// _update = null;
		// _sendEmail = new Thread(new SendEmail(20, 100));
		// _getEmail = new Thread(new GetEmail(30, 250));
		// _update = new Thread(new Update(40, 400));
		// _sendEmail.start();
		// _getEmail.start();
		// _update.start();
		// _blStarted = true;
    }

    public Robot(int node)
    {
        Thread timesend = new Thread(new TimeSend(20, 100, node));
        timesend.start();
        _blStarted = true;
    }

   /* public static void main(String args[])
    {
        new Robot();
        try
        {
            new Robot(Integer.parseInt(args[0]));
        } catch (NumberFormatException ex)
        {
            ex.printStackTrace();
        }
    }*/

//    public static void activateRobot(int i) throws Exception
//    {
//        if (!_blStarted)
//        {
//            new Robot();
//        } // else
//        {
//            // SendEmailx sendemailx = new SendEmailx();
//            // sendemailx.sendEmail(i);
//            SendEmaily sendemaily = new SendEmaily();
//            sendemaily.sendEmail(i);
//        }
//    }

    public static void activateRoboty(int i) throws Exception
    {
        if (!_blStarted)
        {
            new Robot();
        }
        Message m=Message.find(i);
        SendEmaily sendemaily = new SendEmaily(m.community);
        sendemaily.sendEmail(i);
    }

    public static void activateRobot(String smtpServer, int i) throws Exception
    {
        if (!_blStarted)
        {
            new Robot();
        } else
        {
            // SendEmailx sendemailx = new SendEmailx(smtpServer);
            //sendemailx.sendEmail(i);
            SendEmaily sendemaily = new SendEmaily(smtpServer);
            sendemaily.sendEmail(i);

//            tea.service.SendEmaily se = new tea.service.SendEmaily(tes._strCommunity);
//                    se.sendEmail(p.getEmail(), "黄金假日酒店订单督促通知", destine_obj.getInform());
        }
    }

    public static void activateRoboty(String _strCommunity, int i) throws Exception
    {
        if (!_blStarted)
        {
            new Robot();
        }
        SendEmaily sendemaily = new SendEmaily(_strCommunity);
        sendemaily.sendEmail(i);
    }

    public static void activateRoboty(int node, int i) throws Exception
    {
        if (!_blStarted)
        {
            new Robot(node);
        }
        SendEmaily sendemaily = new SendEmaily(node);
        sendemaily.sendEmail(i);
    }

    Thread _sendEmail;
    Thread _getEmail;
    Thread _update;
    public static boolean _blStarted = false;
}
