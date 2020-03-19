//+------------------------------------------------------------------+
//|                                                  OrdersTotal.mqh |
//|                                    Copyright 2019, Daniel Albino |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019, Daniel Albino"
#property link      ""
#property strict

// Count all the buy orders

int ORDERBUY(int magic){
    int buys = 0
     for( int i = 0 ; i < OrdersTotal() ; i++ ) {
      OrderSelect( i, SELECT_BY_POS, MODE_TRADES );
      if( OrderMagicNumber() == magic ){
          if(OrderType() == OP_BUY){
              buys++;
          }
      }
   }

   return buys;
}

// count all the sell orders
int  ORDERSELL(int magic){
    int sells = 0;
     for( int i = 0 ; i < OrdersTotal() ; i++ ) {
      OrderSelect( i, SELECT_BY_POS, MODE_TRADES );
      if( OrderMagicNumber() == magic){
          if(OrderType() == OP_SELL){
            sells++;
          }
      }
   }
   return sells;
}

