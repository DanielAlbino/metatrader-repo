//+------------------------------------------------------------------+
//|                                                         DRSI.mq4 |
//|                                    Copyright 2020, Daniel Albino |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, Daniel Albino"
#property link      ""
#property version   "1.00"
#property indicator_chart_window
#property strict
/* 
    create two indicators with same logic but different visualizations

    the logic is 
    identify if the last bar has the highest or lowest amplitude compared to the latest X bars
    amplitude can be ( open and close / high and low )
    X is a input value, is the numbers of bars to compare (10 = ten bars back; 50 = fifty bars back)

    visualization 1
    if bar is the highest amplitude and is an up bar, then indicator is (1)
    if bar is the highest amplitude and is a down bar, then indicator is (-1)

    visualization 2
    plot the indicator value
 */


int OnInit(){


   return(INIT_SUCCEEDED);
}


void start() {

}

