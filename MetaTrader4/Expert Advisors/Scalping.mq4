//+------------------------------------------------------------------+
//|                                                 MA_CrossOver.mq4 |
//|                                    Copyright 2020, Daniel Albino |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, Daniel Albino"
#property link      ""
#property version   "1.00"
#property strict

enum TPchoice {
    TP_RATIO = 0,
    TP_RSI  = 1,
};
enum TimeFrame{
    M1  = PERIOD_M1,
    M5  = PERIOD_M5,
    M15 = PERIOD_M15,
    M30 = PERIOD_M30,
    H1  = PERIOD_H4,
    H4  = PERIOD_H4,
    D1  = PERIOD_D1,
};
/*------------------------------------------------------------------*/
/* INPUTS --------------------------------------------------------- */
/*------------------------------------------------------------------*/
/* MAGIC NUMBER */
input int magicnumber = 1000; // EA Magic Number
/* TIMEFRAME */
input TimeFrame tf = D1; // Time frame

/* MONEY MANAGEMENT */
input double lots = 0.01; // Lot size
input int slip = 1; // slippage size

/* TP/SL RATIO */
input double SLRATIO = 1.0; // SL RATIO ex: 1.0, 1.2, 5.0
input TPchoice choice = 1;
input double TPRATIO = 2.0; // TP RATIO ex: 2.0, 2.4, 10.0

/* RSI PERIODS */
input int FAST_RSI = 8; // Fast RSI period
input int MaxRSILevel = 80; // Max RSI level
input int SubMaxRSILevel = 70; // Sub Max RSI level
input int MinRSILevel = 20; // Min RSI level
input int SubMinRSILevel = 30; // Sub Min RSI level

/*------------------------------------------------------------------*/
/* VARIABLES -------------------------------------------------------*/
/*------------------------------------------------------------------*/

/* BOOLEANS */
bool signal1    = false;
bool signal2    = false;
bool signal3    = false;
bool rsicross   = false;

/* Activates and Deactivates the RSI's */
bool rsiOnOff = true;



/* LLOW/HHIGH candle for SL */
double LowerHigh = 0.0;
double ShadowSize = 0.0;

int OnInit(){
   return(INIT_SUCCEEDED);
}

void OnDeinit(const int reason){
}

void OnTick() {
    
}

/*------------------------------------------------------------------*/
/* SIGNALS ---------------------------------------------------------*/
/*------------------------------------------------------------------*/
bool sign1 (){
    double rsi = Rsi(FAST_RSI,1);
    if(rsi > SubMaxRSILevel && rsi <= MaxRSILevel){
        return true;
    } else {
        return false;
    }
}

bool sign2 (){
    double rsi = Rsi(FAST_RSI,1);
    if(rsi < SubMinRSILevel && rsi >= MinRSILevel){
        return true;
    } else {
        return false;
    }
}


/*------------------------------------------------------------------*/
/* CANDLE LL/HH ----------------------------------------------------*/
/*------------------------------------------------------------------*/


/*------------------------------------------------------------------*/
/* RSI -------------------------------------------------------------*/
/*------------------------------------------------------------------*/

double Rsi (int period, int candle){
    double rsiVal = 0.0;
    rsiVal = iRSI(Symbol(),tf,period,PRICE_CLOSE,candle);
    return rsiVal;
}



/*-------------------------------------------- BUY/SELL FUNCTIONS -----------------------------------------------*/

bool BUY(double lot, int slippage, string comment, int magic, color scolor){
    double order;
    order = OrderSend(Symbol(), OP_BUY,lot,Ask,slippage,LowerHigh-(ShadowSize*SLRATIO), Bid + (ShadowSize*TPRATIO),comment, magicnumber,0,scolor);
    
  return true;
}

bool SELL(double lot, int slippage, string comment, int magic, color scolor){
    double order;
    order = OrderSend(Symbol(), OP_SELL,lot,Bid,slippage,LowerHigh+(ShadowSize*SLRATIO),Ask - (ShadowSize*TPRATIO),comment, magicnumber,0,scolor);
    
  return true;
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