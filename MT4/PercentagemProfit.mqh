//+------------------------------------------------------------------+
//|                                            PercentagemProfit.mqh |
//|                                    Copyright 2019, Daniel Albino |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019, Daniel Albino"
#property link      ""
#property strict

#include "includes.mqh"

double  BuyPercentage, SellPercentage;
double  AcountMoney = AccountBalance();
double  sellprofit, buyprofit;

//Show the buy Profit in percentage by calculating the profit with the capital
void BUYTRADESPROFITLOSS(){
    buyprofit = BUYGAINPERCENTAGE(MAGICNUMBER);
    BuyPercentage = (buyprofit*100)/AcountMoney;

    PrintText2("buy", "% BUY: ", BuyPercentage,200,10,clrGreen);
}

//Show the sell Profit in percentage by calculating the profit with the capital
void SELLTRADESPROFITLOSS(){
    sellprofit = SELLGAINPERCENTAGE(MAGICNUMBER);
    SellPercentage = (sellprofit*100)/AcountMoney;
    
     PrintText2("sell", "% SELL: ", SellPercentage,300,10,clrRed);
}

// check the profit from Sell order
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

// Check the profit from a Buy order
double BUYGAINPERCENTAGE(int magic)
{
    int sellspercent = 0;
     for( int i = 0 ; i < OrdersTotal() ; i++ ) {
      OrderSelect( i, SELECT_BY_POS, MODE_TRADES );
      if( OrderMagicNumber() == magic ){
          if(OrderType == OP_BUY){
            sellspercent = OrderProfit();
          }
      }
   }
   return sellspercent;
}

