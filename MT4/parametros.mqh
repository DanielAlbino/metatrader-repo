//+------------------------------------------------------------------+
//|                                                   Parametros.mqh |
//|                                    Copyright 2019, Daniel Albino |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019, Daniel Albino"
#property link      ""
#property strict

input string    txt         = "-- MAGIC NUMBER--";    
input int       MAGICNUMBER = 1001;     // magic number

input string    txt2        = "-- Moving Average--";
input int       timeframe   = 15;       // time frame
input int       period      = 100;      // period

input string    txt3        = "-- TrailingStop --";
input int       Trail       = 100;      // TrailingStop size

input string    txt4        = "-- Money Management --";
input double    minlote     = 0.01;     // minimum lot
input double    lotsize     = 1;        // lot size
input int       lotdigist   = 3;        // lot digits
input double    risk        = 2.0;      // risk percentage
input int       stoploss    = 300;      // stoploss 
input double    winpercent  = 1;        // win percentage per trade

input string    txt5        = "-- Partial close --";
input int       valor_fecho = 2;        // partial close






