//+------------------------------------------------------------------+
//|                                            TripleEmaRsiCross.mq4 |
//|                                    Copyright 2020, Daniel Albino |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, Daniel Albino"
#property strict
#property link      ""
#property version   "1.00"


/* VARIABLES */
enum TimeFrame{
    M1  = PERIOD_M1,
    M5  = PERIOD_M5,
    M15 = PERIOD_M15,
    M30 = PERIOD_M30,
    H1  = PERIOD_H4,
    H4  = PERIOD_H4,
    D1  = PERIOD_D1,
};

int FAST = 50;
int MID  = 200;
int SLOW = 400;

int RSI_FAST = 21;

bool signalUp = false;
bool signalDown = false;
bool signalNeutral = false;


double EMA_FAST = 0;
double EMA_MID  = 0;
double EMA_SLOW = 0;
double RSI      = 0; 

int OnInit(){
   return(INIT_SUCCEEDED);
}

void OnDeinit(const int reason){

}

void start() {
    double signCheck = 0;
    RSI = CustomRSI(60,RSI_FAST);
    EMA_FAST = CustomEma(60,FAST);
    EMA_MID = CustomEma(60,MID);
    EMA_SLOW = CustomEma(60,SLOW);

    signCheck = CheckSignal(RSI,EMA_FAST,EMA_MID,EMA_SLOW,Bid);

    if(signCheck == 1){signalUp = true;}else{signalUp = false;}
    if(signCheck == 0){signalDown = true;}else{signalDown = false;}
    if(signCheck == 2){signalNeutral = true;}else{signalNeutral = false;}

    if(signalUp){PrintText("sign", "UPTREND", 10, 10, clrGreen);}
    if(signalDown){PrintText("sign", "DOWNTREND", 10, 10, clrRed);}
    if(signalNeutral){PrintText("sign", "LATERALIZATION", 10, 10, clrYellow);}
}


/* CHECK SIGNALS */
int CheckSignal(double rsi, double fast, double mid, double slow, double price){
    int signal = 0;

    if(rsi > 50){
        if(price > fast){
            if(fast > slow && fast > mid){
                if(mid > slow){
                    signal = 1;
                }
            }
        }
    }
    if(rsi < 50){
        if(price < fast){
            if(fast < slow && fast < mid){
                if(mid < slow){
                    signal = 0;
                }
            }
        }
    }

     if(rsi <= 50 || rsi >= 50){
        if(price < fast){
            if(fast >= slow && fast <= mid){
                if(mid <= slow){
                    signal = 2;
                }
            }
        }
    }


    return signal;
}

/* INDICATORS */

double CustomRSI(int tf,int period ){
    double rsi = 0;
    rsi = iRSI(Symbol(),tf,period,PRICE_CLOSE,1);

    return rsi;
}

double CustomEma(int tf,int period){
    double ema = 0;
    ema = iMA(Symbol(),tf,period,0,MODE_EMA,PRICE_CLOSE,1);
    
    return ema;
}


/* PRINT ON SCREEN */
void PrintText(string NOMEOBJECTO, string TEXTO, int x, int y, color COR)
{
   ObjectCreate(NOMEOBJECTO, OBJ_LABEL, 0, 0, 0);
   ObjectSetText(NOMEOBJECTO, TEXTO , 10,"Arial", COR);
   ObjectSet(NOMEOBJECTO, OBJPROP_CORNER, 0);
   ObjectSet(NOMEOBJECTO, OBJPROP_XDISTANCE, x);
   ObjectSet(NOMEOBJECTO, OBJPROP_YDISTANCE, y);
}