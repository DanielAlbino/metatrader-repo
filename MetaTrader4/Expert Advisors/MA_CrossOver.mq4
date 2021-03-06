//+------------------------------------------------------------------+
//|                                                 MA_CrossOver.mq4 |
//|                                    Copyright 2020, Daniel Albino |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, Daniel Albino"
#property link      ""
#property version   "1.00"
#property strict

input int period1 = 20; //1st SMA
input int period2 = 50; //2nd SMA
input string functions = "OTHER OPTIONS"; // Order Options

input double lots = 0.01; //LOT's
input int slip = 1; //SLIPPAGE

bool buying = false, selling = false;

double MA1, MA2;
int NBUYS, NSELLS;
int OnInit(){
   return(INIT_SUCCEEDED);
}

void OnDeinit(const int reason){
}

void OnTick() {

   MA1 = SMA(period1);
   MA2 = SMA(period2);
   checkMA();
   OrdersOff();
   NBUYS = ORDERBUY(1);
   NSELLS = ORDERSELL(2);
}

/*--------------------------------------------  OPEN ORDERS  -----------------------------------------------*/

void checkMA(){

   if(MA1 > MA2){
     if(buying == false && NBUYS == 0){
      buying =  BUY(lots,slip,"BUY - "+Symbol(),1,clrGreen);
     }
   }
   
   if(MA1 < MA2){
     if(selling == false && NSELLS == 0){
      selling =  SELL(lots,slip,"SELL - "+Symbol(),2,clrRed);
     }
   }
}
/*-------------------------------------------- CLOSE ORDERS  -----------------------------------------------*/

void OrdersOff(){
   int tickets = 0;

   if(MA1 < MA2 && buying == true){
     tickets = CloseOrders(1);
     buying = false;
     Alert("Close Buy Ticket: "+ IntegerToString(tickets));
   }
   
   if(MA1 > MA2 && selling == true){
     tickets =  CloseOrders(2);
     selling =  false;
     Alert("Close Sell Ticket: "+ IntegerToString(tickets));
   }
   
}


/*-------------------------------------------- OTHER FUNCTIONS -----------------------------------------------*/

double SMA(int period){
   double sma = iMA(Symbol(),PERIOD_CURRENT,period,0,MODE_SMA,PRICE_CLOSE,1);
   
   return sma;
}

bool BUY(double lot, int slippage, string comment, int magicnumber, color scolor){
    double order;
    order = OrderSend(Symbol(), OP_BUY,lot,Ask,slippage,NULL,NULL,comment, magicnumber,0,scolor);
    
  return true;
}

bool SELL(double lot, int slippage, string comment, int magicnumber, color scolor){
    double order;
    order = OrderSend(Symbol(), OP_SELL,lot,Bid,slippage,NULL,NULL,comment, magicnumber,0,scolor);
    
  return true;
}

int CloseOrders(int magicnumber)
{
   double order;
   datetime temp = 0;
   int lastTicketNumber = 0;
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
         if(OrderType() == OP_SELL) {
            order = OrderClose(lastTicketNumber,(OrderLots()),Ask,1,clrRed);
         } else {
            order = OrderClose(lastTicketNumber,(OrderLots()),Bid,1,clrGreen);
         }
      } 
   return(lastTicketNumber);
}

// Get the total of buy orders opened
int ORDERBUY(int magic){
    int buys = 0;
    double order;
    for( int i = 0 ; i < OrdersTotal() ; i++ ) {
       order = OrderSelect( i, SELECT_BY_POS, MODE_TRADES );
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
    double order; 
     for( int i = 0 ; i < OrdersTotal() ; i++ ) {
      order = OrderSelect( i, SELECT_BY_POS, MODE_TRADES );
      if( OrderMagicNumber() == magic){
          if(OrderType() == OP_SELL){
            sells++;
          }
      }
   }
   return sells;
}