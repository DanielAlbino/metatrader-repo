//+------------------------------------------------------------------+
//|                                                GT7_TrendLine.mqh |
//|                                        Copyright 2019, Gtraders7 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019, Daniel Albino"
#property link      ""
#property strict


// VERIFICAR COMO FAZER LINHA DE TENDÊNCIA
// LINHA É TRAÇADA EM 1 HIGHER HIGH e 2 HIGHER LOW
// MOSTRAR A LINHA NO ECRÃ

// ------------------------------------------------------------------------------------------------------
// nota: PODERÁ HAVER POSSIBILIDADE DE MOSTRAR O ANGULO DA TENDENCIA USANDO O OBJ_TRENDBYANGLE
// ------------------------------------------------------------------------------------------------------


// VARIAVEIS ---------------------------
int    NBARS = 24;
double HH = 0;
double HH2 = 0;

double LL = 9999999;
double LL2 = 9999999;

datetime htime1, htime2;
datetime ltime1, ltime2;

int NBARS = 24;

input string    = "--SMA--";
int   timeframe = 15;
int   period    = 200;

double sma = iMA(Symbol(),timeframe,period,0,MODE_SMA,PRICE_CLOSE,0);


void MEDIASMOVEIS(){
    sma = iMA(Symbol(),timeframe,period,0,MODE_SMA,PRICE_CLOSE,0);
}

void HIGHERHIGH(){

            if(High[iHighest(Symbol(),TIMEFRAME,MODE_HIGH,NBARS,1)] > HH){ HH = High[i]; htime1 = Time[i];}
            if((High[iHighest(Symbol(),TIMEFRAME,MODE_HIGH,NBARS,1)] > HH2) && (HH > HH2 && HH > High[iHighest(Symbol(),TIMEFRAME,MODE_HIGH,NBARS,1)]) && (LL < HH)){
                 HH2 = High[iHighest(Symbol(),TIMEFRAME,MODE_HIGH,NBARS,1)]; htime2 = Time[iHighest(Symbol(),TIMEFRAME,MODE_HIGH,NBARS,1)];
                 LL = 9999999;
                 LL2 = 9999999;
            } 
             if((High[iHighest(Symbol(),TIMEFRAME,MODE_HIGH,NBARS,1)] > HH)  && (LL == 9999999) && (HH > 0)){
                 HH = High[iHighest(Symbol(),TIMEFRAME,MODE_HIGH,NBARS,1)]; htime1 = Time[iHighest(Symbol(),TIMEFRAME,MODE_HIGH,NBARS,1)];
                 LL = 9999999;
                 LL2 = 9999999;
            }

        if(HH > 0 && HH2 > 0){
        TRENDLINE("hhTrend", htime1, HH, htime2, HH2, clrGreen); 

        }
}

void LOWERLOW(){

            if(Low[iLowest(Symbol(),TIMEFRAME,MODE_LOW,NBARS,1)] < LL){ LL = Low[iLowest(Symbol(),TIMEFRAME,MODE_LOW,NBARS,1)];} 
            if((Low[iLowest(Symbol(),TIMEFRAME,MODE_LOW,NBARS,1)] < LL2) && (LL < LL2)){ LL2 = Low[iLowest(Symbol(),TIMEFRAME,MODE_LOW,NBARS,1)];}  

    
}

// ObjectCreate(chart_ID,name,OBJ_TREND,sub_window,time1,price1,time2,price2)
void TRENDLINE(string object, datetime initTime, double initValue, datetime closeTime, double closeValue, color cor){
           ObjectCreate(object, OBJ_TREND , 0,initTime,initValue,closeTime,closeValue);
           ObjectMove(object,0,Time[0],closeValue);
           ObjectSet(object, OBJPROP_STYLE, STYLE_SOLID);
           ObjectSet(object, OBJPROP_COLOR, cor);
           ObjectSet(object, OBJPROP_WIDTH, 1); 
            HH = 0;
            HH2 = 0;

}


