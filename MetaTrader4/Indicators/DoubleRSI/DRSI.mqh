//+------------------------------------------------------------------+
//|                                                         DRSI.mq4 |
//|                                    Copyright 2020, Daniel Albino |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, Daniel Albino"
#property link      ""
#property version   "1.00"
#property strict
#property indicator_buffers 2
#property indicator_color1 Blue
#property indicator_color2 Red

enum TPchoice {
    "TP by RATIO" = 0,
    "TP by RSI overbought/oversold" = 1
}
enum TimeFrame{
    M1  = PEDIOD_M1,
    M5  = PERIOD_M5,
    M15 = PERIOD_M15,
    M30 = PERIOD_M30,
    H1  = PEDIOD_H1,
    H4  = PEDIOD_H4,
    D1  = PEDIOD_D1,
}
/*------------------------------------------------------------------*/
/* INPUTS --------------------------------------------------------- */
/*------------------------------------------------------------------*/

/* TIMEFRAME */
input TimeFrame tf = M1; // Time frame

/* RSI PERIODS */
input int FAST_RSI = 14; // Fast RSI period
input int SLOW_RSI = 21; // Slow RSI period
input int MaxRSILevel = 70 // Max RSI level
input int MinRSILevel = 30 // Min RSI level
/* TP/SL RATIO */
input double SLRATIO = 1.0; // SL RATIO ex: 1.0, 1.2, 5.0
input TPchoice choice = "TP by RATIO";
input double TPRATIO = 2.0 // TP RATIO ex: 2.0, 2.4, 10.0

/* BUFFERS */
double Buffer1[], Buffer2[];

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

int init(){
    SetIndexStyle(0,DRAW_ARROW);
    SetIndexBuffer(0,Buffer1);
    SetIndexStyle(1,DRAW_ARROW);
    SetIndexBuffer(1,Buffer2);

   return(INIT_SUCCEEDED);
}

void deinit(const int reason){

}

void start() {
    //if the signal 1 is active than we going to see if we can get the frist signal for buy/sell
    if(rsi1OnOff){
        signal1 =  Signal_1(Rsi(FAST_RSI),MaxRSILevel, MinRSILevel);
        if(signal1){ rsi1OnOff = false};
    }

    //if the signal 2 is active than we going to see if we can get the second signal for buy/sell
    if(rsi2OnOff){
        signal2 =  Signal_2(Rsi(SLOW_RSI),MaxRSILevel, MinRSILevel);
        if(signal2){ rsi2OnOff = false};
    }

    // here we going to know if the RSI fast is lower/high then RSI low
    signal3 =  Signal_3(Rsi(FAST_RSI),Rsi(SLOW_RSI),MaxRSILevel, MinRSILevel);

    // If all the parameters are Ok then we gonna show an arrow to buy
    if(signal1 && signal2 && signal3 && Rsi(FAST_RSI) < MinRSILevel && Rsi(SLOW_RSI) < MinRSILevel){
        BuyOrder();
        rsi1OnOff = true;
        rsi2OnOff = true;
    }

    // If all the parameters are Ok then we gonna show an arrow to sell
    if(signal1 && signal2 && signal3 && Rsi(FAST_RSI) > MaxRSILevel && Rsi(SLOW_RSI) > MaxRSILevel){
        SellOrder();
        rsi1OnOff = true;
        rsi2OnOff = true;
    }

    // check if the variable lowerhigh is lower/high then the previous candle.
    if(LowerHigh = 0.0){
        LowerHigh = Candle(FAST_RSI, MaxRSILevel, MinRSILevel);
    } else {
        if(Rsi(FAST_RSI) < MinRSILevel){
            if(LowerHigh < Candle(FAST_RSI, MaxRSILevel, MinRSILevel)){
                LowerHigh = Candle(FAST_RSI, MaxRSILevel, MinRSILevel);
                if(Open[1] > Close[1]){ShadowSize = Close[1] - Low[1]}
                if(Open[1] < Close[1]){ShadowSize = Open[1] - Low[1]}
            }
        }
        if(Rsi(FAST_RSI) > MaxRSILevel){
            if(LowerHigh > Candle(FAST_RSI, MaxRSILevel, MinRSILevel)){
                LowerHigh = Candle(FAST_RSI, MaxRSILevel, MinRSILevel);
                if(Open[1] > Close[1]){ShadowSize = fabs(Open[1] - High[1])}
                if(Open[1] < Close[1]){ShadowSize = fabs(close[1] - High[1])}
            }
        }
    }
}

/*------------------------------------------------------------------*/
/* SIGNALS ---------------------------------------------------------*/
/*------------------------------------------------------------------*/

bool Signal_1(double rsiFast, int max, int min) {
    if(!signal1){
        if(rsiFast > max || rsiFast < min){
            return true
        }
    }  
}

bool Signal_2(double rsiLow, int max, int min) {
     if(!signal2){
        if(rsiLow > max || rsiLow < min){
            return true
        }
    } 
}

bool Signal_3(double rsifast, double rsilow, int min, int max) {
    if(!signal3){
        if((rsifast > min && rsifast > rsilow) || (rsifast < max && rsifast < rsilow)){
            return true;
        }
    } 
}


/*------------------------------------------------------------------*/
/* RSI -------------------------------------------------------------*/
/*------------------------------------------------------------------*/

double Rsi (int period){
    double rsiVal = 0.0;
    rsiVal = iRSI(Symbol(),tf,period,PRICE_CLOSE,1);
    return rsiVal
}

/*------------------------------------------------------------------*/
/* CANDLE LL/HH ----------------------------------------------------*/
/*------------------------------------------------------------------*/

double Candle(int period, int max, int min){
    double candle = 0.0;
    if(Rsi(period) < min){ 
        candle = Low[1];
    }
    if(Rsi(period) > max){ 
        candle = High[1];
    }
    return candle;
}

/*------------------------------------------------------------------*/
/* ENTRY ORDER -----------------------------------------------------*/
/*------------------------------------------------------------------*/

void BuyOrder(){
    Buffer1[0] = (LowerHigh - ShadowSize) - 10*Points;
}

void SellOrder(){
    Buffer2[0] = (LowerHigh + ShadowSize) + 10*Points;
}
