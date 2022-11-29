package tea.service;

import java.awt.*;
import java.awt.event.WindowEvent;
import java.awt.event.WindowListener;
import java.util.Date;


public class Service extends Frame implements WindowListener
{

    public String timeStamp(String s)
    {
        return "\n" + new Date(System.currentTimeMillis()) + " : " + s;
    }

    public void clearLog()
    {
        _taLog.setText("");
    }

    public Service(int i, int j)
    {
        _lbStatus = new Label();
        _taLog = new TextArea(8, 80);
        GridBagLayout gridbaglayout = new GridBagLayout();
        GridBagConstraints gridbagconstraints = new GridBagConstraints();
        gridbagconstraints.fill = 1;
        gridbagconstraints.anchor = 18;
        setLayout(gridbaglayout);
        gridbagconstraints.gridy = 0;
        gridbagconstraints.gridx = 0;
        gridbagconstraints.gridwidth = 0;
        gridbaglayout.setConstraints(_lbStatus, gridbagconstraints);
        add(_lbStatus);
        gridbagconstraints.gridy = 1;
        gridbagconstraints.gridx = 0;
        gridbagconstraints.gridwidth = 0;
        gridbaglayout.setConstraints(_taLog, gridbagconstraints);
        add(_taLog);
        validate();
        pack();
        setLocation(i, j);
        setVisible(true);
        addWindowListener(this);
        _blStoped = false;
    }

    public Service()
    {
        _blStoped = false;
    }

    public void windowDeactivated(WindowEvent windowevent)
    {
    }

    public void windowClosing(WindowEvent windowevent)
    {
        Window window = windowevent.getWindow();
        window.setVisible(false);
        if (window == this)
        {
            dispose();
            _blStoped = true;
        }
    }

    public void windowOpened(WindowEvent windowevent)
    {
    }

    public void windowClosed(WindowEvent windowevent)
    {
    }

    public void windowDeiconified(WindowEvent windowevent)
    {
    }

    public void windowActivated(WindowEvent windowevent)
    {
    }

    public void setStatus(String s)
    {
        _lbStatus.setText(s);
    }

    public void addLog(String s)
    {
        _taLog.append(timeStamp(s));
    }

    public void windowIconified(WindowEvent windowevent)
    {
    }

    private Label _lbStatus;
    private TextArea _taLog;
    public boolean _blStoped;
}
