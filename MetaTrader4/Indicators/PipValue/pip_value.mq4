<<<<<<< HEAD
//+------------------------------------------------------------------+
//|                                                         DRSI.mq4 |
//|                                    Copyright 2020, Daniel Albino |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, Daniel Albino"
#property link      ""
#property version   "1.00"
#property indicator_chart_window
#property strict


/*------------------------------------------------------------------*/
/* INPUTS --------------------------------------------------------- */
/*------------------------------------------------------------------*/



/*------------------------------------------------------------------*/
/* VARIABLES -------------------------------------------------------*/
/*------------------------------------------------------------------*/

double pip_value = 0;
int OnInit(){
   return(INIT_SUCCEEDED);
}

void start() {
    pip_value = MarketInfo(Symbol(), MODE_TICKVALUE);
    PRINTTEXT("Pips val","Pip value: "+DoubleToStr(pip_value, Digits), 10, 10, clrBlue);
}

void PRINTTEXT(string name, string text, int distX, int distY, color clr){
   ObjectCreate(name, OBJ_LABEL, 0, 0, 0);
   ObjectSetText(name,text,7, "Verdana", clr);
   ObjectSet(name, OBJPROP_CORNER, 0);
   ObjectSet(name, OBJPROP_XDISTANCE, distX);
   ObjectSet(name, OBJPROP_YDISTANCE, distY);
}
=======
//+------------------------------------------------------------------+
//|                                                         DRSI.mq4 |
//|                                    Copyright 2020, Daniel Albino |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, Daniel Albino"
#property link      ""
#property version   "1.00"
#property strict


/*------------------------------------------------------------------*/
/* INPUTS --------------------------------------------------------- */
/*------------------------------------------------------------------*/



/*------------------------------------------------------------------*/
/* VARIABLES -------------------------------------------------------*/
/*------------------------------------------------------------------*/

double pip_value = 0;
int OnInit(){
   return(INIT_SUCCEEDED);
}

void start() {
    pip_value = MarketInfo(Symbol(), MODE_TICKVALUE);
    PRINTTEXT("Pips val","Pip value: "+DoubleToStr(pip_value, Digits), 10, 10, clrBlue);
}

void PRINTTEXT(string name, string text, int distX, int distY, color clr){
   ObjectCreate(name, OBJ_LABEL, 0, 0, 0);
   ObjectSetText(name,text,7, "Verdana", clr);
   ObjectSet(name, OBJPROP_CORNER, 0);
   ObjectSet(name, OBJPROP_XDISTANCE, distX);
   ObjectSet(name, OBJPROP_YDISTANCE, distY);
}
>>>>>>> 30f0fb9ea08fac1ec50ac6e3b95494bfa2860efb
