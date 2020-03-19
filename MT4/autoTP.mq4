//+------------------------------------------------------------------+
//|                                                       autoTP.mq4 |
//|                                    Copyright 2020, Daniel Albino |
//|                                  https://github.com/DanielAlbino |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, Daniel Albino"
#property link      "https://github.com/DanielAlbino"
#property version   "1.00"
#property strict


input int slippage = 1;
int NBUY, NSELL;
double pclose = 0;
double distancebuy = 0;
double distancesell = 0;
double price = 0;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {

   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {

  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
      NBUY = ORDERBUY();
      NSELL = ORDERSELL();
      if(NBUY > 0 || NSELL > 0){
         TPchecker(Symbol(), slippage);
      }
  }
//+------------------------------------------------------------------+


/* 
   Check if the order have Stoploss, if yes than create all the TakeProfit
*/

void TPchecker(string symbol, int slip){
   double order;
   if(OrderSymbol() == symbol){
      if(OrderType() == OP_BUY){
         if(OrderLots() >= 0.04){ 
            price = OrderOpenPrice();  
            if(OrderTakeProfit() <= 0){
              distancebuy = fabs(OrderStopLoss() - OrderOpenPrice());  
              order = OrderModify(OrderTicket(),OrderOpenPrice(),OrderStopLoss(),price+distancebuy,0,clrRed);
            }       
            if(Bid >= price+distancebuy){
              order = OrderModify(OrderTicket(),OrderOpenPrice(),(OrderOpenPrice()+10*Point),price+(distancebuy*2),0,clrRed);
              pclose = OrderClose(OrderTicket(),(OrderLots()/4),Bid,slip,clrGreen);
            }
            if(Bid >= price+(distancebuy*2)){
              order = OrderModify(OrderTicket(),OrderOpenPrice(),price+(distancebuy*2),price+(distancebuy*3),0,clrRed);
              pclose = OrderClose(OrderTicket(),(OrderLots()/3),Bid,slip,clrGreen);
            }
            if(Bid >= price+(distancebuy*3)){
              order = OrderModify(OrderTicket(),OrderOpenPrice(),price+(distancebuy*3),price+(distancebuy*4),0,clrRed);
              pclose = OrderClose(OrderTicket(),(OrderLots()/2),Bid,slip,clrGreen);
            }
            if(Bid >= price+(distancebuy*4)){
              pclose = OrderClose(OrderTicket(),OrderLots(),Bid,slip,clrGreen);
            }
         }
          if(OrderLots() == 0.03 ){ 
            price = OrderOpenPrice();  
            if(OrderTakeProfit() <= 0){
              distancebuy = fabs(OrderStopLoss() - OrderOpenPrice());  
              order = OrderModify(OrderTicket(),OrderOpenPrice(),OrderStopLoss(),price+distancebuy,0,clrRed);
            }       
            if(Bid >= price+distancebuy){
              order = OrderModify(OrderTicket(),OrderOpenPrice(),(OrderOpenPrice()+10*Point),price+(distancebuy*2),0,clrRed);
              pclose = OrderClose(OrderTicket(),(OrderLots()/3),Bid,slip,clrGreen);
            }
            if(Bid >= price+(distancebuy*2)){
              order = OrderModify(OrderTicket(),OrderOpenPrice(),price+(distancebuy*2),price+(distancebuy*3),0,clrRed);
              pclose = OrderClose(OrderTicket(),(OrderLots()/2),Bid,slip,clrGreen);
            }
            if(Bid >= price+(distancebuy*3)){
              pclose = OrderClose(OrderTicket(),OrderLots(),Bid,slip,clrGreen);
            }
         }
         if(OrderLots() == 0.02 ){ 
            price = OrderOpenPrice();  
            if(OrderTakeProfit() <= 0){
              distancebuy = fabs(OrderStopLoss() - OrderOpenPrice());  
              order = OrderModify(OrderTicket(),OrderOpenPrice(),OrderStopLoss(),price+distancebuy,0,clrRed);
            }       
            if(Bid >= price+distancebuy){
              order = OrderModify(OrderTicket(),OrderOpenPrice(),(OrderOpenPrice()+10*Point),price+(distancebuy*2),0,clrRed);
              pclose = OrderClose(OrderTicket(),(OrderLots()/2),Bid,slip,clrGreen);
            }
            if(Bid >= price+(distancebuy*2)){
              pclose = OrderClose(OrderTicket(),OrderLots(),Bid,slip,clrGreen);
            }
         }
          if(OrderLots() == 0.02 ){ 
            price = OrderOpenPrice();  
            if(OrderTakeProfit() <= 0){
              distancebuy = fabs(OrderStopLoss() - OrderOpenPrice());  
              order = OrderModify(OrderTicket(),OrderOpenPrice(),OrderStopLoss(),price+distancebuy,0,clrRed);
            }       
            if(Bid >= price+distancebuy){
              order = OrderModify(OrderTicket(),OrderOpenPrice(),(OrderOpenPrice()+10*Point),price+(distancebuy*2),0,clrRed);
              pclose = OrderClose(OrderTicket(),(OrderLots()/2),Bid,slip,clrGreen);
            }
            if(Bid >= price+(distancebuy*2)){
              pclose = OrderClose(OrderTicket(),OrderLots(),Bid,slip,clrGreen);
            }
         }
          if(OrderLots() == 0.01 ){ 
            price = OrderOpenPrice();  
            if(OrderTakeProfit() <= 0){
              distancebuy = fabs(OrderStopLoss() - OrderOpenPrice());  
              order = OrderModify(OrderTicket(),OrderOpenPrice(),OrderStopLoss(),price+distancebuy,0,clrRed);
            }       
            if(Bid >= price+distancebuy){
              pclose = OrderClose(OrderTicket(),OrderLots(),Bid,slip,clrGreen);
            }
         }
      }
      if(OrderType() == OP_SELL){
         if( OrderLots() >= 0.04){  
            distancesell = fabs(OrderStopLoss() - OrderOpenPrice());  
            price = OrderOpenPrice();  
            if(OrderTakeProfit() <= 0){
              order = OrderModify(OrderTicket(),OrderOpenPrice(),OrderStopLoss(),price-distancesell,0,clrRed);
            }       
            if(Ask <= price-distancesell){
              order = OrderModify(OrderTicket(),OrderOpenPrice(),(OrderOpenPrice()-10*Point),price-(distancesell*2),0,clrRed);
              pclose = OrderClose(OrderTicket(),(OrderLots()/4),Ask,slip,clrGreen);
            }
            if(Ask <= price-(distancesell*2)){
              order = OrderModify(OrderTicket(),OrderOpenPrice(),price-(distancesell*2),price-(distancesell*3),0,clrRed);
              pclose = OrderClose(OrderTicket(),(OrderLots()/3),Ask,slip,clrGreen);
            }
            if(Ask <= price-(distancesell*3)){
              order = OrderModify(OrderTicket(),OrderOpenPrice(),price-(distancesell*3),price-(distancesell*4),0,clrRed);
              pclose = OrderClose(OrderTicket(),(OrderLots()/2),Ask,slip,clrGreen);
            }
            if(Ask <= price-(distancesell*4)){
              pclose = OrderClose(OrderTicket(),OrderLots(),Ask,slip,clrGreen);
            }
         }
         if( OrderLots() == 0.03){  
            distancesell = fabs(OrderStopLoss() - OrderOpenPrice());  
            price = OrderOpenPrice();  
            if(OrderTakeProfit() <= 0){
              order = OrderModify(OrderTicket(),OrderOpenPrice(),OrderStopLoss(),price-distancesell,0,clrRed);
            }       
            if(Ask <= price-distancesell){
              order = OrderModify(OrderTicket(),OrderOpenPrice(),(OrderOpenPrice()-10*Point),price-(distancesell*2),0,clrRed);
              pclose = OrderClose(OrderTicket(),(OrderLots()/3),Ask,slip,clrGreen);
            }
            if(Ask <= price-(distancesell*2)){
              order = OrderModify(OrderTicket(),OrderOpenPrice(),price-(distancesell*2),price-(distancesell*3),0,clrRed);
              pclose = OrderClose(OrderTicket(),(OrderLots()/2),Ask,slip,clrGreen);
            }
            if(Ask <= price-(distancesell*3)){
              pclose = OrderClose(OrderTicket(),OrderLots(),Ask,slip,clrGreen);
            }
         }
          if( OrderLots() == 0.02){  
            distancesell = fabs(OrderStopLoss() - OrderOpenPrice());  
            price = OrderOpenPrice();  
            if(OrderTakeProfit() <= 0){
              order = OrderModify(OrderTicket(),OrderOpenPrice(),OrderStopLoss(),price-distancesell,0,clrRed);
            }       
            if(Ask <= price-distancesell){
              order = OrderModify(OrderTicket(),OrderOpenPrice(),(OrderOpenPrice()-10*Point),price-(distancesell*2),0,clrRed);
              pclose = OrderClose(OrderTicket(),(OrderLots()/2),Ask,slip,clrGreen);
            }
            if(Ask <= price-(distancesell*2)){
              pclose = OrderClose(OrderTicket(),OrderLots(),Ask,slip,clrGreen);
            }
         }
                   if( OrderLots() == 0.02){  
            distancesell = fabs(OrderStopLoss() - OrderOpenPrice());  
            price = OrderOpenPrice();  
            if(OrderTakeProfit() <= 0){
              order = OrderModify(OrderTicket(),OrderOpenPrice(),OrderStopLoss(),price-distancesell,0,clrRed);
            }       
            if(Ask <= price-distancesell){
              pclose = OrderClose(OrderTicket(),OrderLots(),Ask,slip,clrGreen);
            }
         }

      }
   }
}

/*
   CHECK IF WE HAVE SOME BUY OR SELL ORDER
*/

int ORDERBUY(){
    int buys = 0;
    double order;
    for( int i = 0 ; i < OrdersTotal() ; i++ ) {
       order = OrderSelect( i, SELECT_BY_POS, MODE_TRADES );
      if( OrderSymbol() == Symbol()){
          if(OrderType() == OP_BUY){
              buys++;
          }
      }
   }

   return buys;
}

// Get the total of sell orders opened
int  ORDERSELL(){
    int sells = 0;
    double order; 
     for( int i = 0 ; i < OrdersTotal() ; i++ ) {
      order = OrderSelect( i, SELECT_BY_POS, MODE_TRADES );
      if( OrderSymbol() == Symbol()){
          if(OrderType() == OP_SELL){
            sells++;
          }
      }
   }
   return sells;
}