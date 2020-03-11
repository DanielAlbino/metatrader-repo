#property copyright "Copyright 2020, Daniel Albino"
#property link      ""
#property strict

// Get the total of buy orders opened
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

// Get the total of sell orders opened
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