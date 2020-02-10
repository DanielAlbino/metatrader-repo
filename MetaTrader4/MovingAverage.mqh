#property copyright "Copyright 2020, Daniel Albino"
#property link      ""
#property strict

// Simple Moving Average
double SMA(int tmp, int prd)
{
   double MM = 0;
   MM = iMA(Symbol(),tmp,prd,0,MODE_SMA,PRICE_CLOSE,0);
   
   return MM;
}

// Exponetial Moving Average
double EMA(int tmp, int prd)
{
   double MM = 0;
   MM = iMA(Symbol(),tmp,prd,0,MODE_EMA,PRICE_CLOSE,0);
   
   return MM;
}

//Smo0thed Moving Average
double SMMA(int tmp, int prd)
{
   double MM = 0;
   MM = iMA(Symbol(),tmp,prd,0,MODE_SMMA,PRICE_CLOSE,0);
   
   return MM;
}

//Linearly Wieghted Moving Average
double LWMA(int tmp, int prd)
{
   double MM = 0;
   MM = iMA(Symbol(),tmp,prd,0,MODE_LWMA,PRICE_CLOSE,0);
   
   return MM;
}