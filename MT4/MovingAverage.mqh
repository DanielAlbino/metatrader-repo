//+------------------------------------------------------------------+
//|                                                           MA.mqh |
//|                                    Copyright 2019, Daniel Albino |
//|                                                                  |
//+------------------------------------------------------------------+

#property copyright "Copyright 2019, Daniel Albino"
#property link      ""
#property strict

double SMA(int tmp, int prd)
{
   double MM = 0;
   MM = iMA(Symbol(),tmp,prd,0,MODE_SMA,PRICE_CLOSE,0);
   
   return MM;
}


double EMA(int tmp, int prd)
{
   double MM = 0;
   MM = iMA(Symbol(),tmp,prd,0,MODE_EMA,PRICE_CLOSE,0);
   
   return MM;
}

double SMMA(int tmp, int prd)
{
   double MM = 0;
   MM = iMA(Symbol(),tmp,prd,0,MODE_SMMA,PRICE_CLOSE,0);
   
   return MM;
}

double LWMA(int tmp, int prd)
{
   double MM = 0;
   MM = iMA(Symbol(),tmp,prd,0,MODE_LWMA,PRICE_CLOSE,0);
   
   return MM;
}