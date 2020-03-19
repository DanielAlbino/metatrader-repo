#property copyright "Copyright 2020, Daniel Albino"
#property link      ""
#property strict

#include "includes.mqh"

double  BuyPercentage, SellPercentage;
double  AcountMoney = AccountBalance();
double  sellprofit, buyprofit;

// Convert the Profit (€) in %
void BUYTRADESPROFITLOSS(){
    buyprofit = BUYGAINPERCENTAGE(MAGICNUMBER);
    BuyPercentage = (buyprofit*100)/AcountMoney;

    PrintText2("buy", "% BUY: ", BuyPercentage,200,10,clrGreen);
}

// Convert the Profit (€) in %
void SELLTRADESPROFITLOSS(){
    sellprofit = SELLGAINPERCENTAGE(MAGICNUMBER);
    SellPercentage = (sellprofit*100)/AcountMoney;
    
     PrintText2("sell", "% SELL: ", SellPercentage,300,10,clrRed);
}

// Get all the sells trades total profit
double SELLGAINPERCENTAGE(int magic)
{
    int sellspercent = 0;
     for( int i = 0 ; i < OrdersTotal() ; i++ ) {
      OrderSelect( i, SELECT_BY_POS, MODE_TRADES );
      if( OrderMagicNumber() == magic ){
          if(OrderType == OP_SELL){
            sellspercent = OrderProfit();
          }
      }
   }
   return sellspercent;
}

// Get all the buys trades total profit
double BUYGAINPERCENTAGE(int magic)
{
    int buyspercent = 0;
     for( int i = 0 ; i < OrdersTotal() ; i++ ) {
      OrderSelect( i, SELECT_BY_POS, MODE_TRADES );
      if( OrderMagicNumber() == magic ){
          if(OrderType == OP_BUY){
            buyspercent = OrderProfit();
          }
      }
   }
   return buyspercent;
}