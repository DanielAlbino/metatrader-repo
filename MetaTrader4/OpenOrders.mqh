#property copyrigth "Copyright 2020, Daniel Albino"
#property link ""
#property strict

void BUY(double lot, int slippage, int stoploss, string comment, int magicnumber, color scolor){
    double order;
    order = OrderSend(Symbol(), OP_BUY,lot,Ask,slippage,Ask-stoploss*Point,NULL,comment, magicnumber,0, scolor);
}

void SELL(double lot, int slippage, int stoploss, string comment, int magicnumber, color scolor){
    double order;
    order = OrderSend(Symbol(), OP_SELL,lot,Bid,slippage,Bid+stoploss*Point,NULL,comment, magicnumber,0, scolor);
}