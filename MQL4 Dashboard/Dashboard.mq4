//+------------------------------------------------------------------+
//|                                                    Dashboard.mq4 |
//|                                    Copyright 2020, Daniel Albino |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, Daniel Albino"
#property link      ""
#property version   "1.00"
#property indicator_chart_window
#property strict

#include <Controls\ComboBox.mqh>
class CComboBox : public CWndContainer
/* 
    criar um dashboard que tenha um input para o user colocar que box deseja
    ter um print a informar qual é a melhor box para fazer trade
 */
int OnInit(){
    
   return(INIT_SUCCEEDED);
}


void start() {

}

// Background Rectangle
void PRINTDASH(int chart_ID, string name, int x, int y, int width, int height, color clr, bool back){
    ObjectCreate(chart_ID,name,OBJ_RECTANGLE_LABEL,x,y)
    //--- set label coordinates
    ObjectSetInteger(chart_ID,name,OBJPROP_XDISTANCE,x);
    ObjectSetInteger(chart_ID,name,OBJPROP_YDISTANCE,y);
    //--- set label size
    ObjectSetInteger(chart_ID,name,OBJPROP_XSIZE,width);
    ObjectSetInteger(chart_ID,name,OBJPROP_YSIZE,height);
    //--- set background color
    ObjectSetInteger(chart_ID,name,OBJPROP_BGCOLOR,clr);
    //--- display in the foreground (false) or background (true)
    ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
}


// Print any necessary text
void PRINTTEXT(string name, string text, int distX, int distY, color clr){
    ObjectCreate(name, OBJ_LABEL, 0, 0, 0);
    ObjectSetText(name,text,7, "Verdana", clr);
    ObjectSet(name, OBJPROP_CORNER, 0);
    ObjectSet(name, OBJPROP_XDISTANCE, distX);
    ObjectSet(name, OBJPROP_YDISTANCE, distY);
}


// Print the input box
void PRINTINPUT(int chart_ID,string name, string text, int x, int y, int width, int height,  color clr){
    ObjectCreate(chart_ID,name, OBJ_EDIT, 0, 0, 0);
    ObjectSet(chart_ID,name, OBJPROP_CORNER, 0);
    ObjectSet(chart_ID,name, OBJPROP_XDISTANCE, distX);
    ObjectSet(chart_ID,name, OBJPROP_YDISTANCE, distY);
    //--- set label size
    ObjectSetInteger(chart_ID,name,OBJPROP_XSIZE,width);
    ObjectSetInteger(chart_ID,name,OBJPROP_YSIZE,height);
    //--- set the text
    ObjectSetString(chart_ID,name,OBJPROP_TEXT,text);
    //--- set text color
    ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
}

// Print the combobox
void PRINTCOMBOBOX(int chart_ID,string name, string text,int boxes, int x, int y, int width, int height,  color clr){
    m_combo_box.Create(chart_ID,name,m_subwin,x,y,x2,y2)
    for(int i=0;i<boxes;i++){
        m_combo_box.ItemAdd("Item "+IntegerToString(i));
    }

}