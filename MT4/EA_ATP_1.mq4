//+------------------------------------------------------------------+
//|                                                       autotp.mq4 |
//|                                               Copyright © 2020,  |
//|        https://www.facebook.com/groups/tradingrobotsdevelopment/ |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2020, Trading Robots Development Project."
#property link      "https://www.facebook.com/groups/tradingrobotsdevelopment/"
#property version   "17.3"


//Extern Variables
extern int  StepDistance            = 100;





//Intern Variables








int OnInit()
{





   return(INIT_SUCCEEDED);
}




void OnDeinit(const int reason)
{





}




void OnTick()
{
     // print(CheckNumberOpenOrders("SELL", 0) ); //verifica se funciona
}


//@////////////////////@//
//Functions for Expert  //
//@////////////////////@//

bool CheckOpenOrders()
{
   for( int i = 0 ; i < OrdersTotal() ; i++ ) 
   {
      if(OrderSelect( i, SELECT_BY_POS, MODE_TRADES ))
      
      if( OrderSymbol() == Symbol() ) 
      {
         return(true);
      }
   }
   
   return(false);
}

int CheckNumberOpenOrders(int op_buysell, int magicnumber) 
{

   int result=0;
   
   for(int i=0;i<OrdersTotal();i++)
   {
      if(OrderSelect(i,SELECT_BY_POS ,MODE_TRADES))
      if (OrderSymbol() == Symbol() && OrderType()==op_buysell && OrderMagicNumber()==magicnumber) 

      result++;
   }
   
   return (result);
}

int ReturnTicketStopLoss(int op_buysell, int magicnumber) 
{

   
   for(int i=0;i<OrdersTotal();i++)
   {
      if(OrderSelect(i,SELECT_BY_POS  ,MODE_TRADES))
      if (OrderSymbol() == Symbol() && OrderType()==op_buysell && OrderMagicNumber()==magicnumber && OrderStopLoss()>0) 
      
      return OrderTicket();
   }
   
   return 0;
   
}




//@////////////////////@//
//Functions for Graphics//
//@////////////////////@//


void PrintTextINT(string NOMEOBJECTO, string TEXTO,int valorinteiro, int x, int y, int tamanhodafonte, string font, color cor)
{
      ObjectCreate(NOMEOBJECTO, OBJ_LABEL, 0, 0, 0);
      ObjectSetText(NOMEOBJECTO, TEXTO + IntegerToString(valorinteiro), tamanhodafonte, font, cor);
      ObjectSet(NOMEOBJECTO, OBJPROP_CORNER, 0);
      ObjectSet(NOMEOBJECTO, OBJPROP_XDISTANCE, x);
      ObjectSet(NOMEOBJECTO, OBJPROP_YDISTANCE, y);
}

void PrintTextDOUBLE5Digits(string NOMEOBJECTO, string TEXTO,double valordouble, int x, int y,  int tamanhodafonte, string font, color cor)
{
      ObjectCreate(NOMEOBJECTO, OBJ_LABEL, 0, 0, 0);
      ObjectSetText(NOMEOBJECTO, TEXTO + NormalizeDouble(DoubleToString(valordouble),5), tamanhodafonte, font, cor);
      ObjectSet(NOMEOBJECTO, OBJPROP_CORNER, 0);
      ObjectSet(NOMEOBJECTO, OBJPROP_XDISTANCE, x);
      ObjectSet(NOMEOBJECTO, OBJPROP_YDISTANCE, y);
}

void PrintTextDOUBLE3Digits(string NOMEOBJECTO, string TEXTO,double valordouble, int x, int y,  int tamanhodafonte, string font, color cor)
{
      ObjectCreate(NOMEOBJECTO, OBJ_LABEL, 0, 0, 0);
      ObjectSetText(NOMEOBJECTO, TEXTO + NormalizeDouble(DoubleToString(valordouble),3), tamanhodafonte, font, cor);
      ObjectSet(NOMEOBJECTO, OBJPROP_CORNER, 0);
      ObjectSet(NOMEOBJECTO, OBJPROP_XDISTANCE, x);
      ObjectSet(NOMEOBJECTO, OBJPROP_YDISTANCE, y);
}

void PrintTextDOUBLE2Digits(string NOMEOBJECTO, string TEXTO,double valordouble, int x, int y,  int tamanhodafonte, string font, color cor)
{
      ObjectCreate(NOMEOBJECTO, OBJ_LABEL, 0, 0, 0);
      ObjectSetText(NOMEOBJECTO, TEXTO + NormalizeDouble(DoubleToString(valordouble),2), tamanhodafonte, font, cor);
      ObjectSet(NOMEOBJECTO, OBJPROP_CORNER, 0);
      ObjectSet(NOMEOBJECTO, OBJPROP_XDISTANCE, x);
      ObjectSet(NOMEOBJECTO, OBJPROP_YDISTANCE, y);
}

void PrintTextTEXT(string NOMEOBJECTO, string TEXTO, int x, int y, int tamanhodafonte, string font, color cor)
{
      ObjectCreate(NOMEOBJECTO, OBJ_LABEL, 0, 0, 0);
      ObjectSetText(NOMEOBJECTO, TEXTO, tamanhodafonte, font, cor);
      ObjectSet(NOMEOBJECTO, OBJPROP_CORNER, 0);
      ObjectSet(NOMEOBJECTO, OBJPROP_XDISTANCE, x);
      ObjectSet(NOMEOBJECTO, OBJPROP_YDISTANCE, y);
}

void PrintLABEL(string NOMEOBJECTO, int distX, int distY,int sizeX, int sizeY,color cor1, color cor2)
{
      ObjectCreate(ChartID(),NOMEOBJECTO,OBJ_RECTANGLE_LABEL,0,0,0) ;
      ObjectSetInteger(ChartID(),NOMEOBJECTO,OBJPROP_XDISTANCE,distX);
      ObjectSetInteger(ChartID(),NOMEOBJECTO,OBJPROP_YDISTANCE,distY);
      ObjectSetInteger(ChartID(),NOMEOBJECTO,OBJPROP_BACK,true);
      ObjectSetInteger(ChartID(),NOMEOBJECTO,OBJPROP_BORDER_TYPE,STYLE_SOLID);
      ObjectSetInteger(ChartID(),NOMEOBJECTO,OBJPROP_BORDER_COLOR, cor1);
      ObjectSetInteger(ChartID(),NOMEOBJECTO,OBJPROP_BGCOLOR,cor2);
      ObjectSetInteger(ChartID(),NOMEOBJECTO,OBJPROP_XSIZE,sizeX);
      ObjectSetInteger(ChartID(),NOMEOBJECTO,OBJPROP_YSIZE,sizeY);
}


void PrintHLINE(string object, double price, color cor)
{
      ObjectCreate(object, OBJ_HLINE , 0,Time[0], price);
      ObjectMove(object,0,Time[0],price);
      ObjectSet(object, OBJPROP_STYLE, STYLE_SOLID);
      ObjectSet(object, OBJPROP_COLOR, cor);
      ObjectSet(object, OBJPROP_WIDTH, 0);  
}

void PrintHLINEFIBO(string object, double price, color cor, int TIPO)
{
      ObjectCreate(object, OBJ_HLINE , 0,Time[0], price);
      ObjectMove(object,0,Time[0],price);
      ObjectSet(object, OBJPROP_STYLE, TIPO);
      ObjectSet(object, OBJPROP_COLOR, cor);
      ObjectSet(object, OBJPROP_WIDTH, 0);  
}

void PrintVLINE(string object, double price, color cor)
{
      ObjectCreate(object, OBJ_VLINE , 0,Time[0], price);
      ObjectMove(object,0,Time[0],price);
      ObjectSet(object, OBJPROP_STYLE, STYLE_SOLID);
      ObjectSet(object, OBJPROP_COLOR, cor);
      ObjectSet(object, OBJPROP_WIDTH, 0);  
}

void PrintTextObject(string object, string variavel, datetime time, double preco,int font, string tipofont, color cor)
{
      ObjectCreate(0,object,OBJ_TEXT,0,time,preco);
      ObjectMove(object,0,time,Bid);
      ObjectSetString(0,object,OBJPROP_TEXT,variavel); 
      ObjectSetString(0,object,OBJPROP_FONT,tipofont);
      ObjectSetInteger(0,object,OBJPROP_FONTSIZE,font);
      ObjectSet(object, OBJPROP_COLOR, cor);
}