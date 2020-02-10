#property copyright "Copyright 2020, Daniel Albino"
#property link      ""
#property strict

#include "includes.mqh"

// close part of a trade - i.e. you have a trade in profit with 1Lot, you can close 0.5lot of that trade
int PartialClose(int magicnumber)
{
   datetime temp = 0;
   int lastTicketNumber;
   for(int i=1; i<=OrdersTotal(); i++)
      {
         if ( OrderSelect(i-1,SELECT_BY_POS,MODE_TRADES) == true )
         {   
            if ( OrderOpenTime() > temp && magicnumber == OrderMagicNumber() )  
            {
               temp = OrderOpenTime();
               lastTicketNumber = OrderTicket();
            }
         }
      }
      OrderClose(lastTicketNumber,(OrderLots()/valor_fecho),Bid,0,Pink);
   return(lastTicketNumber);
}