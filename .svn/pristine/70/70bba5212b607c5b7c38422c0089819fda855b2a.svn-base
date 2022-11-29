// Decompiled by DJ v2.9.9.60 Copyright 2000 Atanas Neshkov  Date: 2006-10-12 15:02:47
// Home Page : http://members.fortunecity.com/neshkov/dj.html  - Check often for new version!
// Decompiler options: packimports(3)
// Source File Name:   Service.java


package tea.service.oasms;

import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.*;
import java.net.URL;
import java.sql.*;
import javax.swing.*;
import tea.service.oasms.SmsServices;

public class service extends JFrame
    implements Runnable, ActionListener
{

    public service()
    {
      //  msg1_old = null;
      //  msg_temp = "";
        jButton1 = new JButton();
        jButton2 = new JButton();
        jScrollPane1 = new JScrollPane();
        jTextArea1 = new JTextArea();
        init();

    }



    public void run()
    {
        do
            try
            {
                tea.service.oasms.SmsServices ss=new tea.service.oasms.SmsServices();
		ss.getAutoReverse();
                Thread.sleep(10000L);
            }
            catch(Exception exception)
            {
             exception.printStackTrace();    System.out.println("\u7EBF\u7A0B\u6267\u884C\u5931\u8D25\uFF01\uFF01\uFF01");
            }
        while(true);
    }

    private void init()
    {
        jButton1.setFont(new Font("DialogInput", 1, 18));
        jButton1.setForeground(new Color(114, 6, 221));
        jButton1.setSelected(false);
        jButton1.setText("\u5F00\u59CB");
        jButton1.addActionListener(this);

        jButton2.setFont(new Font("DialogInput", 1, 18));
        jButton2.setForeground(new Color(114, 6, 221));
        jButton2.setText("\u9000\u51FA");
        jButton2.addActionListener(this);
        jScrollPane1.setForeground(Color.black);
        jScrollPane1.setAlignmentX(0.5F);
        jScrollPane1.setAutoscrolls(true);
        jScrollPane1.setBorder(BorderFactory.createLoweredBevelBorder());
        jScrollPane1.setDebugGraphicsOptions(0);
        jScrollPane1.setToolTipText("");
        jScrollPane1.setVerifyInputWhenFocusTarget(true);
        jTextArea1.setForeground(new Color(85, 120, 223));
        jTextArea1.setEditable(false);
        jTextArea1.setLineWrap(false);
        jTextArea1.setTabSize(8);
        jTextArea1.append("\u51C6\u5907\u5C31\u7EEA\uFF01\uFF01\uFF01\n");
        jButton1.setBounds(70, 310, 84, 35);
        jButton2.setBounds(250, 310, 84, 35);

        jScrollPane1.setBounds(10, 10, 388, 288);
        jScrollPane1.getViewport().add(jTextArea1, null);
        getContentPane().setLayout(null);
        getContentPane().add(jButton1);

        getContentPane().add(jButton2);

        getContentPane().add(jScrollPane1);
    }

    public void actionPerformed(ActionEvent actionevent)
    {
        if(actionevent.getSource() == jButton2)
            System.exit(0);
       // if(actionevent.getSource() == jButton3)
         //   SendService();
        if(actionevent.getSource() == jButton1 && t == null)
        {
            t = new Thread(this);
            t.start();
        }
    }

    /*public static void main(String args[])
    {
        service service1 = new service();
        service1.setTitle("\u77ED\u4FE1\u670D\u52A1\u81EA\u52A8\u626B\u63CF");
        service1.setResizable(false);
        service1.setSize(413, 375);
        service1.setVisible(true);
    }*/


    private Thread t;
    private JButton jButton1;
    private JButton jButton2;

    private JScrollPane jScrollPane1;
    private JTextArea jTextArea1;
}
