import java.util.Scanner;

/** First project to draw some maritime signal flags.
*   @author <STUDENT TO DO: HENNA PARMAR, hparmar3!>
*/
public class Project1 {

   /** Main method.
   * @param args not used
   */
   public static void main(String[] args) {
   
            
      // fixed constants for the problem
      final int WINDOWPIXELS = 800;  // pixels
      final int TENTH2MILLIS = 100; // tenth of second to millisecond
   
      StdDraw.setCanvasSize(WINDOWPIXELS, WINDOWPIXELS);
      StdDraw.setXscale(0, WINDOWPIXELS);
      StdDraw.setYscale(0, WINDOWPIXELS);
      StdDraw.clear(StdDraw.LIGHT_GRAY);
   
   
      Scanner keyboard = new Scanner(System.in); 
                                
      //collecting the user inputs        
      System.out.print("enter pixel size of first flag (100-400): ");
      int sizeAlpha = keyboard.nextInt();
      
      System.out.print("enter pixel size of second flag (100-400): ");
      int sizeIndia = keyboard.nextInt();
      
      System.out.print("enter pixel size of third flag (100-400): ");
      int sizeVictor = keyboard.nextInt();
      
      System.out.print("enter first delay in tenths of a second: ");
      double delay1 = keyboard.nextDouble();
      
      System.out.print("enter second delay in tenths of a second: ");
      double delay2 = keyboard.nextDouble();
      
      keyboard.close();
      
      double flagWidth = sizeAlpha + sizeIndia + sizeVictor;
      
      //draws the flags
      drawMaritimeFlags(sizeAlpha, 
         sizeIndia, 
         sizeVictor, 
         delay1, 
         delay2, 
         WINDOWPIXELS,
         TENTH2MILLIS); 
   }
       
   /** 
   * Draws the flags.
   *
   *@param sizeAlpha user input for size of the Alpha flag
   *@param sizeIndia user input for size of the India flag
   *@param sizeVictor user input for size of the Victor flag
   *@param delay1 user input for the delay between Alpha flag and India flag
   *@param delay2 user input for the delay between India flag and Victor flag
   *@param windowPixels = 800
   *@param tenth2Millis = 100  
   */         
   public static void drawMaritimeFlags(int sizeAlpha, 
      int sizeIndia, 
      int sizeVictor, 
      double delay1, 
      double delay2, 
      int windowPixels,
      int tenth2Millis) {
      
      int alphaX = 0;
      int alphaY = windowPixels - sizeAlpha;
      drawAlphaFlag(alphaX, alphaY, sizeAlpha, windowPixels);
      
      StdDraw.pause((int) (delay1 * tenth2Millis));
      
      int indiaX = 800 - sizeIndia / 2;
      int indiaY = sizeIndia / 2;
      drawIndiaFlag(indiaX, indiaY, sizeIndia, windowPixels);
      
      StdDraw.pause((int) (delay2 * tenth2Millis));
      
      int victorX = sizeVictor;
      int victorY = sizeVictor;
      drawVictorFlag(victorX, victorY, sizeVictor, windowPixels);
   }
        
   //information for the Alpha flag               
   private static void drawAlphaFlag(int alphaX, 
      int alphaY, 
      int sizeAlpha, 
      int windowPixels) {
   
      //x and y coordinates for the Alpha flag
      alphaX = 0;
      alphaY = windowPixels - sizeAlpha;
     
      //information for drawing the cutout triangle
      double halfSize = sizeAlpha / 2.0;
      double triangleWidth = 0.25 * sizeAlpha;
      double triangleHeight = halfSize;
     
      //setting the color white for the left part of the flag
      StdDraw.setPenColor(StdDraw.WHITE);
     
     //draws the right sides of the Alpha flag
      StdDraw.filledRectangle(alphaX + halfSize / 2.0, 
         alphaY + halfSize, 
         halfSize / 2.0, 
         halfSize);
     
     //setting the color blue for the right part of the flag
      StdDraw.setPenColor(StdDraw.BLUE);
     
     //drawing a blue square for the right side of the flag
      StdDraw.filledRectangle(alphaX + halfSize + halfSize / 2.0, 
         alphaY + halfSize, 
         halfSize / 2.0, 
         halfSize);
     
     //taking out the triangle for the right side of the flag
      StdDraw.setPenColor(StdDraw.LIGHT_GRAY);
     
     //Top Right Corner
      double x1 = alphaX + sizeAlpha;
      double y1 = alphaY + sizeAlpha;
     
     //Bottom Right Corner
      double x2 = alphaX + sizeAlpha;
      double y2 = alphaY;
     
     //Apex
      double x3 = x1 - 0.25 * sizeAlpha;
      double y3 = (y1 + y2) / 2.0;
     
      double[] xTriangle = {x1, x2, x3};
      double[] yTriangle = {y1, y2, y3};
   
      //removes the trianlge section from the flag
      StdDraw.filledPolygon(xTriangle, yTriangle);
   }  
        
   //information for the India flag       
   private static void drawIndiaFlag(double indiaX, 
      double indiaY, 
      double sizeIndia, 
      int windowPixels) {
      
      //x and y coordinates for the India flag
      double centerX = windowPixels - sizeIndia / 2.0;
      double centerY = 0 + sizeIndia / 2.0;
   
      //information for the circle in the flag
      double halfSquareSize = sizeIndia / 2.0;
      double circleRadius = sizeIndia / 4.0;
   
      //setting the color yellow for the base of the flag
      StdDraw.setPenColor(StdDraw.YELLOW);
   
      //draws the square base of the flag
      StdDraw.filledRectangle(centerX, centerY, halfSquareSize, halfSquareSize);
   
      //setting the color black for the circle in the flag
      StdDraw.setPenColor(StdDraw.BLACK);
   
      //draws the circle in the center of the flag
      StdDraw.filledCircle(centerX, centerY, circleRadius);
   } 
        
   //information for the Victor flag              
   private static void drawVictorFlag(double victorX, 
      double victorY, 
      double sizeVictor, 
      int windowPixels) {
      
      //x and y coordinates for the Victor flag
      victorX = windowPixels / 2.0;
      victorY = windowPixels / 2.0;
   
      //variables for drawing the red X
      double halfSize = sizeVictor / 2.0;
      double lineWidth = 0.2 * halfSize;
      
      //sets the background color of the flag
      StdDraw.setPenColor(StdDraw.WHITE);
      
      //draws the background square of the flag
      StdDraw.filledRectangle(victorX, 
         victorY, 
         halfSize, 
         halfSize);
      
      //sets the color for the red X
      StdDraw.setPenColor(StdDraw.RED);
      
      //coordinates for the X:
      //Bottom Right Corner
      double x1 = victorX + sizeVictor - halfSize;
      double y1 = victorY - halfSize;
      
      double x2 = x1 - lineWidth;
      double y2 = y1;
      
      double x3 = x1;
      double y3 = y1 + lineWidth;
      
      StdDraw.filledTriangle(x1, y1, x2, y2, x3, y3);
       
      //Top Right Corner
      double x4 = victorX + sizeVictor - halfSize;
      double y4 = victorY + sizeVictor - halfSize;
      
      double x5 = x4 - lineWidth;
      double y5 = y4;
      
      double x6 = x4;
      double y6 = y4 - lineWidth;
      
      StdDraw.filledTriangle(x4, y4, x5, y5, x6, y6);
      
      //Bottom Left Corner
      double x7 = victorX - halfSize;
      double y7 = victorY - halfSize;
      
      double x8 = x7 + lineWidth;
      double y8 = y7;
      
      double x9 = x7;
      double y9 = y7 + lineWidth;
      
      StdDraw.filledTriangle(x7, y7, x8, y8, x9, y9);
      
      //Top Left Corner
      double x10 = victorX - halfSize;
      double y10 = victorY + sizeVictor - halfSize;
      
      double x11 = x10 + lineWidth;
      double y11 = y10;
      
      double x12 = x10;
      double y12 = y10 - lineWidth;
      
      StdDraw.filledTriangle(x10, y10, x11, y11, x12, y12);
      
      //Polygon One
      double[] xPolygon1 = {x2, x3, x11, x12};
      double[] yPolygon1 = {y2, y3, y11, y12};
      
      StdDraw.filledPolygon(xPolygon1, yPolygon1);
      
      //Polygon Two
      double[] xPolygon2 = {x5, x6, x8, x9};
      double[] yPolygon2 = {y5, y6, y8, y9};
      
      StdDraw.filledPolygon(xPolygon2, yPolygon2);               
   }
}
