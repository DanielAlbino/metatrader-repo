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
#property description "Control Panels and Dialogs."
#include <Controls\Dialog.mqh>
#include <Controls\Button.mqh>
#include <Controls\ComboBox.mqh>
//+------------------------------------------------------------------+
//| defines                                                          |
//+------------------------------------------------------------------+
//--- indents and gaps
#define INDENT_LEFT                         (11)      // indent from left (with allowance for border width)
#define INDENT_TOP                          (11)      // indent from top (with allowance for border width)
#define CONTROLS_GAP_X                      (5)       // gap by X coordinate

//--- for buttons
#define BUTTON_WIDTH                        (100)     // size by X coordinate
#define BUTTON_HEIGHT                       (20)      // size by Y coordinate

//--- for buttons
#define COMBO_WIDTH                        (100)     // size by X coordinate
#define COMBO_HEIGHT                       (20)      // size by Y coordinate
//---
//+------------------------------------------------------------------+
//| Class CAppWindowTwoButtons                                       |
//| Usage: main dialog of the Controls application                   |
//+------------------------------------------------------------------+
class CControlsDialog : public CAppDialog
  {
private:
   CButton           m_button1;                       // the button object
   CButton           m_button2;                       // the button object
   
   CComboBox         m_combo_box1;                       // the combo box object
   CComboBox         m_combo_box2;                       // the combo box object

public:
                     CControlsDialog(void);
                    ~CControlsDialog(void);
                     
   //--- create
   virtual bool      Create(const long chart,const string name,const int subwin,const int x1,const int y1,const int x2,const int y2);
   virtual bool      OnEvent(const int id, const long &lparam, const double &dparam, const string &sparam);

protected:
   //--- create dependent controls
   bool              CreateButton1(int x1, int x2, int width, int height);
   bool              CreateButton2(int x1, int x2, int width, int height);
   
   bool              CreateComboBox1(int x1, int x2, int width, int height);
   bool              CreateComboBox2(int x1, int x2, int width, int height);

   //--- handlers of the dependent controls events
   void              OnChangeComboBox1(void);
   void              OnChangeComboBox2(void);


  };
//+------------------------------------------------------------------+
//| Event Handling                                                   |
//+------------------------------------------------------------------+  
 EVENT_MAP_BEGIN(CControlsDialog)
 ON_EVENT(ON_CHANGE, m_combo_box1, OnChangeComboBox1)
 ON_EVENT(ON_CHANGE,m_combo_box2, OnChangeComboBox2)
 EVENT_MAP_END(CAppDialog)
 
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CControlsDialog::CControlsDialog(void)
  {
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CControlsDialog::~CControlsDialog(void)
  {
  }
//+------------------------------------------------------------------+
//| Create                                                           |
//+------------------------------------------------------------------+
bool CControlsDialog::Create(const long chart,const string name,const int subwin,const int x1,const int y1,const int x2,const int y2)
  {
   if(!CAppDialog::Create(chart,name,subwin,x1,y1,x2,y2))
      return(false);
//--- create dependent controls
   if(!CreateButton1(30,0,50,20))
      return(false);
   if(!CreateButton2(30,10,50,20))
      return(false);
   
   if(!CreateComboBox1(10, 11, 100, 50))
      return(false);
   if(!CreateComboBox2(30, 100, 100, 50))
      return(false);
//--- succeed
   return(true);
  }
//+------------------------------------------------------------------+
//| Global Variable                                                  |
//+------------------------------------------------------------------+
CControlsDialog ExtDialog;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create application dialog
   if(!ExtDialog.Create(0,"AppWindowClass with Two Buttons",0,0,40,380,344))
      return(INIT_FAILED);
//--- run application
   ExtDialog.Run();
//--- succeed
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   Comment("");
//--- destroy dialog
   ExtDialog.Destroy(reason);
  }
  
void start(){}

//+------------------------------------------------------------------+
//| Create the "Button1" button                                      |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateButton1(int x1, int y1, int x2, int y2)
  {

//--- create
   if(!m_button1.Create(0,"Button1",0,x1,y1,x2,y2))
      return(false);
   if(!m_button1.Text("Button1"))
      return(false);
   if(!Add(m_button1))
      return(false);
//--- succeed
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the "Button2"                                             |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateButton2(int x1, int y1, int x2, int y2)
  {

//--- create
   if(!m_button2.Create(0,"Button2",0,x1,y1,x2,y2))
      return(false);
   if(!m_button2.Text("Button2"))
      return(false);
   if(!Add(m_button2))
      return(false);
//--- succeed
   return(true);
  }

//+------------------------------------------------------------------+
//| Create the "ComboBox" element                                    |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateComboBox1(int x1, int y1, int x2, int y2)
  {
//--- coordinates

//--- create
   if(!m_combo_box1.Create(0,"ComboBox1",0,x1,y1,x2,y2))
      return(false);
   if(!Add(m_combo_box1))
      return(false);
//--- fill out with strings
   for(int i=0;i<20;i++)
      if(!m_combo_box1.ItemAdd("Item "+IntegerToString(i)))
         return(false);
//--- succeed
   return(true);
  }

//+------------------------------------------------------------------+
//| Create the "ComboBox" element                                    |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateComboBox2(int x1, int y1, int x2, int y2)
  {
//--- coordinates

//--- create
   if(!m_combo_box2.Create(0,"ComboBox2",0,x1,y1,x2,y2))
      return(false);
   if(!Add(m_combo_box2))
      return(false);
//--- fill out with strings
   for(int i=0;i<20;i++)
      if(!m_combo_box2.ItemAdd("Item "+IntegerToString(i)))
         return(false);
//--- succeed
   return(true);
  }

//+------------------------------------------------------------------+
//| Event handler                                                    |
//+------------------------------------------------------------------+
void CControlsDialog::OnChangeComboBox1(void)
  {
   Comment(__FUNCTION__+" \""+m_combo_box1.Select()+"\"");
  }
  
//+------------------------------------------------------------------+
//| Event handler                                                    |
//+------------------------------------------------------------------+
void CControlsDialog::OnChangeComboBox2(void)
  {
   Comment(__FUNCTION__+" \""+m_combo_box2.Select()+"\"");
  }


//+------------------------------------------------------------------+
//| Expert chart event function                                      |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,         // event ID  
                  const long& lparam,   // event parameter of the long type
                  const double& dparam, // event parameter of the double type
                  const string& sparam) // event parameter of the string type
  {
   ExtDialog.ChartEvent(id,lparam,dparam,sparam);
  }