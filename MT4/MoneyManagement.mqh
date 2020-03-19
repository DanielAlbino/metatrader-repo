//+------------------------------------------------------------------+
//|                                              MoneyManagement.mqh |
//|                                    Copyright 2019, Daniel Albino |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019, Daniel Albino"
#property link      ""
#property strict

double lotsoptimized(double risk, int stoploss,double lotsize, double minlot, int lotdigits )
{
   double lot;
   if(stoploss > 0)
   {
      lot=AccountBalance()*(risk/100)/(stoploss*Point/MarketInfo(Symbol(),MODE_TICKSIZE)*MarketInfo(Symbol(),MODE_TICKVALUE));
   }
   else{
      lot=NormalizeDouble((AccountBalance()/lotsize)*minlot*risk,lotdigits);
   } 
   return(lot);
}