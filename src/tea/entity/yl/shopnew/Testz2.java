package tea.entity.yl.shopnew;

import java.awt.Font;
import java.awt.GridLayout;
import java.text.SimpleDateFormat;

import javax.swing.JFrame;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartPanel;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.axis.DateAxis;
import org.jfree.chart.axis.ValueAxis;
import org.jfree.chart.plot.XYPlot;
import org.jfree.data.time.Month;
import org.jfree.data.time.TimeSeries;
import org.jfree.data.time.TimeSeriesCollection;
import org.jfree.data.xy.XYDataset;

public class Testz2 {
	
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		 JFrame frame=new JFrame("Java数据统计图");  
		 frame.setLayout(new GridLayout(2,2,10,10));  
		 frame.add(new Testz().getChartPanel());    //添加折线图  
		    frame.setBounds(50, 50, 800, 600);  
		    frame.setVisible(true);  
	}

}
