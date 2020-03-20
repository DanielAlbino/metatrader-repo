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
double BuytpCounter = 0;
double SelltpCounter = 0;
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
      if(NBUY > 0 || NSELL > 0 ){
         TPchecker(Symbol(), slippage);
      }
      if(BuytpCounter == 4){BuytpCounter = 0;}
      if(SelltpCounter == 4){SelltpCounter = 0;}
  }
//+------------------------------------------------------------------+


/* 
   Check if the order have Stoploss, if yes than create all the TakeProfit
*/

void TPchecker(string symbol, int slip){
   if(OrderSymbol() == symbol){
      if(OrderType() == OP_BUY && OrderStopLoss() > 0){
            switch(OrderLots()){
                case 0.01:
                    distancebuy = Buy_Close_Lot_by_Distance(BuytpCounter, distancebuy);
                    break;
                case 0.02:
                    distancebuy = Buy_Close_Lot_by_Distance(BuytpCounter, distancebuy);
                    break;
                case 0.03:
                    distancebuy = Buy_Close_Lot_by_Distance(BuytpCounter, distancebuy);
                    break;
                default:
                    distancebuy = Buy_Close_Lot_by_Distance(BuytpCounter, distancebuy);
                    break;
            } 
            BuytpCounter++;
        }
        if(OrderType() == OP_SELL && OrderStopLoss() > 0){
            switch(OrderLots()){
              case 0.01:
                    distancesell = Sell_Close_Lot_by_Distance(SelltpCounter, distancesell);
                    break;
                case 0.02:
                    distancesell = Sell_Close_Lot_by_Distance(SelltpCounter, distancesell);
                    break;
                case 0.03:
                    distancesell = Sell_Close_Lot_by_Distance(SelltpCounter, distancesell);
                    break;
                default:
                    distancesell = Sell_Close_Lot_by_Distance(SelltpCounter, distancesell);
                    break;
            }  
            SelltpCounter++;
        }    
      }
}

double Buy_Close_Lot_by_Distance(int count_tp, double distanceTP){
    int convertLot = 0;
      if(OrderTakeProfit() <= 0){
        distanceTP = fabs(OrderStopLoss() - OrderOpenPrice());  
        order = OrderModify(OrderTicket(),OrderOpenPrice(),OrderStopLoss(),price+distanceTP,0,clrRed);
    } else {
        if(Bid >= price+(distanceTP*count_tp) && OrderStopLoss() > 0.04 ){
            pclose = OrderClose(OrderTicket(),(OrderLots()/count_tp*4),Bid,slip,clrGreen);
            if(OrderStopLoss() >= 0.01){
                order = OrderModify(OrderTicket(),OrderOpenPrice(),price+(distanceTP*(count_tp-1)),price+(distanceTP*(count_tp+1)),0,clrRed);
            }
            distanceTP = distanceTP*(count_tp+1);
        } else if(Bid >= price+(distanceTP*count_tp) && OrderStopLoss() < 0.04){
            convertLot = MathRound(OrderStopLoss()*100);
            pclose = OrderClose(OrderTicket(),(OrderLots()/convertLot),Bid,slip,clrGreen);
            if(OrderStopLoss() >= 0.01){
                order = OrderModify(OrderTicket(),OrderOpenPrice(),price+(distanceTP*(count_tp-1)),price+(distanceTP*(count_tp+1)),0,clrRed);
            }
            distanceTP = distanceTP*(count_tp+1);
        }
    }
    return distanceTP;
}

double Sell_Close_Lot_by_Distance(int count_tp, double distanceTP){
     int convertLot = 0;
    if(OrderTakeProfit() <= 0){
        distanceTP = fabs(OrderStopLoss() - OrderOpenPrice());  
        order = OrderModify(OrderTicket(),OrderOpenPrice(),OrderStopLoss(),price-distanceTP,0,clrRed);
    } else {
        if(Ask <= price-(distanceTP*count_tp) && OrderStopLoss() > 0.04 ){
            pclose = OrderClose(OrderTicket(),(OrderLots()/count_tp*4),Ask,slip,clrGreen);
            if(OrderStopLoss() >= 0.01){
                order = OrderModify(OrderTicket(),OrderOpenPrice(),price-(distanceTP*(count_tp-1)),price-(distanceTP*(count_tp+1)),0,clrRed);
            }
            distanceTP = distanceTP*(count_tp+1);
        } else if(Ask <= price-(distanceTP*count_tp) && OrderStopLoss() < 0.04){
            convertLot = MathRound(OrderStopLoss()*100);
            pclose = OrderClose(OrderTicket(),(OrderLots()/convertLot),Ask,slip,clrGreen);
            if(OrderStopLoss() >= 0.01){
                order = OrderModify(OrderTicket(),OrderOpenPrice(),price-(distanceTP*(count_tp-1)),price-(distanceTP*(count_tp+1)),0,clrRed);
            }
            distanceTP = distanceTP*(count_tp+1);
        }
    }
    return distanceTP;
}


// Get the total of buy orders opened
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