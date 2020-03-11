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
input TimeFrame tf = M1; // Time frame

/* MONEY MANAGEMENT */
input double lots = 0.01; // Lot size
input int slippage = 1; // slippage size

/* TP/SL RATIO */
input double SLRATIO = 1.0; // SL RATIO ex: 1.0, 1.2, 5.0
input TPchoice choice = 1;
input double TPRATIO = 2.0; // TP RATIO ex: 2.0, 2.4, 10.0

/* RSI PERIODS */
input int FAST_RSI = 14; // Fast RSI period
input int SLOW_RSI = 21; // Slow RSI period
input int MaxRSILevel = 70; // Max RSI level
input int MinRSILevel = 30; // Min RSI level


/*------------------------------------------------------------------*/
/* VARIABLES -------------------------------------------------------*/
/*------------------------------------------------------------------*/

/* BOOLEANS */
bool signal1    = false;
bool signal2    = false;
bool signal3    = false;
bool rsicross   = false;

/* Activates and Deactivates the RSI's */
bool rsi1OnOff = true;
bool rsi2OnOff = true;


/* LLOW/HHIGH candle for SL */
double LowerHigh = 0.0;
double ShadowSize = 0.0;

int OnInit(){
   return(INIT_SUCCEEDED);
}

void OnDeinit(const int reason){
}

void OnTick() {
     //if the signal 1 is active than we going to see if we can get the frist signal for buy/sell
    if(rsi1OnOff){
        signal1 =  Signal_1(Rsi(FAST_RSI,1),MaxRSILevel, MinRSILevel);
        if(signal1){ rsi1OnOff = false;}
    }

    //if the signal 2 is active than we going to see if we can get the second signal for buy/sell
    if(rsi2OnOff){
        signal2 =  Signal_2(Rsi(SLOW_RSI,1),MaxRSILevel, MinRSILevel);
        if(signal2){ rsi2OnOff = false;}
    }

    // here we going to know if the RSI fast is lower/high then RSI low
    signal3 =  Signal_3(Rsi(FAST_RSI,1),Rsi(SLOW_RSI,1),MaxRSILevel, MinRSILevel);

    // If all the parameters are Ok then we gonna show an arrow to buy
    if(signal1 && signal2 && signal3 && Rsi(FAST_RSI,1) < MinRSILevel && Rsi(SLOW_RSI,1) < MinRSILevel && Rsi(SLOW_RSI,0) >= MinRSILevel && ORDERBUY(magicnumber) < 1){
        BUY(lots,slip,"BUY - "+Symbol(),1,clrGreen);

    }

    // If all the parameters are Ok then we gonna show an arrow to sell
    if(signal1 && signal2 && signal3 && Rsi(FAST_RSI,1) > MaxRSILevel && Rsi(SLOW_RSI,1) > MaxRSILevel && Rsi(SLOW_RSI,0) <= MaxRSILevel && ORDERSELL(magicnumber) < 1){
        SELL(lots,slip,"SELL - "+Symbol(),2,clrRed);
    }


    // check if the variable lowerhigh is lower/high then the previous candle.
    if(rsi1OnOff) {
        if(LowerHigh == 0.0){
            LowerHigh = Candle(FAST_RSI, MaxRSILevel, MinRSILevel);
        } else {
            if(Rsi(FAST_RSI,1) < MinRSILevel){
                if(LowerHigh < Candle(FAST_RSI, MaxRSILevel, MinRSILevel)){
                    LowerHigh = Candle(FAST_RSI, MaxRSILevel, MinRSILevel);
                    if(Open[1] > Close[1]){ShadowSize = Close[1] - Low[1];}
                    if(Open[1] < Close[1]){ShadowSize = Open[1] - Low[1];}
                }
            }
            if(Rsi(FAST_RSI,1) > MaxRSILevel){
                if(LowerHigh > Candle(FAST_RSI, MaxRSILevel, MinRSILevel)){
                    LowerHigh = Candle(FAST_RSI, MaxRSILevel, MinRSILevel);
                    if(Open[1] > Close[1]){ShadowSize = fabs(Open[1] - High[1]);}
                    if(Open[1] < Close[1]){ShadowSize = fabs(Close[1] - High[1]);}
                }
            }
        }
    }
}
/*------------------------------------------------------------------*/
/* SIGNALS ---------------------------------------------------------*/
/*------------------------------------------------------------------*/

// check if Fast rsi is overbought/oversold
bool Signal_1(double rsiFast, int max, int min) {
   bool sign = false;
    if(!signal1){
        if(rsiFast > max || rsiFast < min){
            sign = true;
        }
    }
    return sign;  
}

// check if Slow rsi is overbought/oversold
bool Signal_2(double rsiLow, int max, int min) {
     bool sign = false;
     if(!signal2){
        if(rsiLow > max || rsiLow < min){
            sign =  true;
        }
    } 
    return sign;
}

// Check if Fast rsi is higher/low then Slow rsi on overbough/oversold
bool Signal_3(double rsifast, double rsilow, int min, int max) {
    bool sign = false;
    if(!signal3){
        if((rsifast > min && rsifast > rsilow) || (rsifast < max && rsifast < rsilow)){
            sign = true;
        }
    } 
   return sign;
}
/*------------------------------------------------------------------*/
/* CANDLE LL/HH ----------------------------------------------------*/
/*------------------------------------------------------------------*/

double Candle(int period, int max, int min){
    double candle = 0.0;
    if(Rsi(period,1) < min){ 
        candle = Low[1];
    }
    if(Rsi(period,1) > max){ 
        candle = High[1];
    }
    return candle;
}
/*------------------------------------------------------------------*/
/* RSI -------------------------------------------------------------*/
/*------------------------------------------------------------------*/

double Rsi (int period, int candle){
    double rsiVal = 0.0;
    rsiVal = iRSI(Symbol(),tf,period,PRICE_CLOSE,candle);
    return rsiVal;
}

/*-------------------------------------------- OTHER FUNCTIONS -----------------------------------------------*/

bool BUY(double lot, int slippage, string comment, int magicnumber, color scolor){
    double order;
    order = OrderSend(Symbol(), OP_BUY,lot,Ask,slippage,Bid - (ShadowSize*SLRATIO), Bid + (ShadowSize*TPRATIO),comment, magicnumber,0,scolor);
    
  return true;
}

bool SELL(double lot, int slippage, string comment, int magicnumber, color scolor){
    double order;
    order = OrderSend(Symbol(), OP_SELL,lot,Bid,slippage,Ask + (ShadowSize*SLRATIO),Ask - (ShadowSize*TPRATIO),comment, magicnumber,0,scolor);
    
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