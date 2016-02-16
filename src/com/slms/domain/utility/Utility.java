/**
 * 
 */
package  com.slms.domain.utility;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;


/**
 * @author Yogendra.gupta
 * @since 03-12-2015
 * @version 1.0
 * Common Utilities supports re-usability code pattern
 */
public class Utility {

 public static  Properties getProperties(String fileName){
	 Properties props = new Properties();
	
	 try
	 {
		 java.net.URL url = Thread.currentThread().getContextClassLoader().getResource(fileName);
		 props.load(url.openStream());
	 }
	 catch (FileNotFoundException e)
	 {
		 e.printStackTrace();
	 }
	 catch (IOException e)
	 {
		 e.printStackTrace();
	 }
	 return props;
	 } 

/**
* getting time window array
* @author Yogendra.gupta
* @since 04-02-2015
* @version 1.0
* @param departTime
* @param timeWindow
* @return
*/
 
public static String[] getTimeWindow(String departTime, String timeWindow){
		String[] timeWindowArray = new String[2];
		int intDepartTime = Integer.parseInt(departTime.substring(0, 2));
		int intTimeWindow = Integer.parseInt(timeWindow);
		int tempEndTm	  = 0;
		int tempStartTm	  = 0;
		String startTmWnd = "";
		String endTmWnd   = "";
		/**
		 * Start time Window
		 */
		if(intTimeWindow > intDepartTime){
			tempStartTm	= intDepartTime + intTimeWindow;
		}else{
			tempStartTm	= intDepartTime - intTimeWindow;
		}
		
		if(String.valueOf(tempStartTm).length()==1)
			startTmWnd = "0"+tempStartTm+"00";
		else
			startTmWnd = tempStartTm+"00";
		
		/**
		 * End time Window
		 */
		if(intDepartTime + intTimeWindow>24){
			tempEndTm	= intDepartTime + intTimeWindow-24;
		}else{
			tempEndTm	= intDepartTime + intTimeWindow;
		}
		if(String.valueOf(tempEndTm).length()==1)
			endTmWnd = "0"+tempEndTm+"00";
		else
			endTmWnd = tempEndTm+"00";
		
		timeWindowArray[0]=startTmWnd;
		timeWindowArray[1]=endTmWnd;
		
		return timeWindowArray;
	}

	public static boolean isValidDate(String inDate) {
	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	    dateFormat.setLenient(false);
	    try {
	      dateFormat.parse(inDate.trim());
	    } catch (Exception e) {
	      return false;
	    }
	    return true;
	  }
	
	
	 public static String getDisplayDate(String inStr) {
	        String outStr = inStr;
	        try {
	            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
	            Date fechaNueva = format.parse(inStr);
	            SimpleDateFormat format2 = new SimpleDateFormat("dd-MM-yyyy");
	            outStr = format2.format(fechaNueva);
	            System.out.println(outStr); // Prints 2013-10-10 10:49:29
	        } catch (Exception e) {
	            System.out.println("Exception # getDisplayDate - " +
	            		e.getMessage());
	        }
	        return outStr;
	    }
	 
	 
	 
	 
	 
	 
	 public static int timeDifference (String dateStart, String dateStop) {
		 
			dateStart = "01/14/2012 00:00:00";
			dateStop = "01/15/2012 00:00:00";
	 
			//HH converts hour in 24 hours format (0-23), day calculation
			SimpleDateFormat format = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss");
			int days=0;
			Date d1 = null;
			Date d2 = null;
	 
			try {
				d1 = format.parse(dateStart);
				d2 = format.parse(dateStop);
	 
				//in milliseconds
				long diff = d2.getTime() - d1.getTime();
	 
				long diffSeconds = diff / 1000 % 60;
				long diffMinutes = diff / (60 * 1000) % 60;
				long diffHours = diff / (60 * 60 * 1000) % 24;
				long diffDays =  (diff / (24 * 60 * 60 * 1000));
				days =(int) diffDays;
 				//System.out.print(diffDays + " days, ");
				//System.out.print(diffHours + " hours, ");
				//System.out.print(diffMinutes + " minutes, ");
				//System.out.print(diffSeconds + " seconds.");
	 
			} catch (Exception e) {
				e.printStackTrace();
			}
			return days;
	 
		}
}
