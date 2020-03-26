//+------------------------------------------------------------------+
//|                                                         DRSI.mq4 |
//|                                    Copyright 2020, Daniel Albino |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, Daniel Albino"
#property link      ""
#property version   "1.00"
#property strict
#property indicator_buffers 2
#property indicator_color1 clrBlue
#property indicator_color2 clrRed
#property indicator_chart_window


/*------------------------------------------------------------------*/
/* INPUTS --------------------------------------------------------- */
/*------------------------------------------------------------------*/


/* BUFFERS */
double Buffer1[];
double Buffer2[];

/*------------------------------------------------------------------*/
/* VARIABLES -------------------------------------------------------*/
/*------------------------------------------------------------------*/

double pip_value = 0;
int OnInit(){
   return(INIT_SUCCEEDED);
}

void start() {
    pip_value = MarketInfo(Symbol(), MODE_TICKVALUE);
}

void PRINTDOUBLE(string name, double pipVal, int distX, int distY, color clr){
   ObjectCreate(name, OBJ_LABEL, 0, 0, 0);
   ObjectSetText(name,DoubleToStr(pipVal, Digits),7, "Verdana", clr);
   ObjectSet(name, OBJPROP_CORNER, 0);
   ObjectSet(name, OBJPROP_XDISTANCE, distX);
   ObjectSet(name, OBJPROP_YDISTANCE, distY);
}
