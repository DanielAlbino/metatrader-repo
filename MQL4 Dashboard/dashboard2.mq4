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
//---
//+------------------------------------------------------------------+
//| Class CAppWindowTwoButtons                                       |
//| Usage: main dialog of the Controls application                   |
//+------------------------------------------------------------------+
class CAppWindowTwoButtons : public CAppDialog
  {
private:
   CButton           m_button1;                       // the button object
   CButton           m_button2;                       // the button object

public:
                     CAppWindowTwoButtons(void);
                    ~CAppWindowTwoButtons(void);
   //--- create
   virtual bool      Create(const long chart,const string name,const int subwin,const int x1,const int y1,const int x2,const int y2);

protected:
   //--- create dependent controls
   //bool              CreateButton1(void);
   //bool              CreateButton2(void);
   bool              CreateComboBox1(void);
   bool              CreateComboBox2(void);

   //--- handlers of the dependent controls events
   void              OnChangeComboBox1(void);
   void              OnChangeComboBox2(void);

  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CAppWindowTwoButtons::CAppWindowTwoButtons(void)
  {
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CAppWindowTwoButtons::~CAppWindowTwoButtons(void)
  {
  }
//+------------------------------------------------------------------+
//| Create                                                           |
//+------------------------------------------------------------------+
bool CAppWindowTwoButtons::Create(const long chart,const string name,const int subwin,const int x1,const int y1,const int x2,const int y2)
  {
   if(!CAppDialog::Create(chart,name,subwin,x1,y1,x2,y2))
      return(false);
//--- create dependent controls
   if(!CreateButton1())
      return(false);
   if(!CreateButton2())
      return(false);
//--- succeed
   return(true);
  }
//+------------------------------------------------------------------+
//| Global Variable                                                  |
//+------------------------------------------------------------------+
CAppWindowTwoButtons ExtDialog;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create application dialog
   if(!ExtDialog.Create(0,"AppWindowClass with Two Buttons",0,40,40,380,344))
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
//+------------------------------------------------------------------+
//| Create the "Button1" button                                      |
//+------------------------------------------------------------------+
bool CAppWindowTwoButtons::CreateButton1(void)
  {
//--- coordinates
   int x1=INDENT_LEFT;        // x1            = 11  pixels
   int y1=INDENT_TOP;         // y1            = 11  pixels
   int x2=x1+BUTTON_WIDTH;    // x2 = 11 + 100 = 111 pixels
   int y2=y1+BUTTON_HEIGHT;   // y2 = 11 + 20  = 32  pixels
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
bool CAppWindowTwoButtons::CreateButton2(void)
  {
//--- coordinates
   int x1=INDENT_LEFT+2*(BUTTON_WIDTH+CONTROLS_GAP_X);   // x1 = 11  + 2 * (100 + 5) = 221 pixels
   int y1=INDENT_TOP;                                    // y1                       = 11  pixels
   int x2=x1+BUTTON_WIDTH;                               // x2 = 221 + 100           = 321 pixels
   int y2=y1+BUTTON_HEIGHT;                              // y2 = 11  + 20            = 31  pixels
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
//+------------------------------------------------------------------+
//| Create the "ComboBox" element                                    |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateComboBox1(int x1, int y1, int x2, int y2)
  {
//--- coordinates

//--- create
   if(!m_combo_box.Create(m_chart_id,m_name+"ComboBox",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!Add(m_combo_box))
      return(false);
//--- fill out with strings
   for(int i=0;i<20;i++)
      if(!m_combo_box.ItemAdd("Item "+IntegerToString(i)))
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
   if(!m_combo_box.Create(m_chart_id,m_name+"ComboBox",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!Add(m_combo_box))
      return(false);
//--- fill out with strings
   for(int i=0;i<20;i++)
      if(!m_combo_box.ItemAdd("Item "+IntegerToString(i)))
         return(false);
//--- succeed
   return(true);
  }

//+------------------------------------------------------------------+
//| Event handler                                                    |
//+------------------------------------------------------------------+
void CControlsDialog::OnChangeComboBox1(void)
  {
   Comment(__FUNCTION__+" \""+m_combo_box.Select()+"\"");
  }
  
//+------------------------------------------------------------------+
//| Event handler                                                    |
//+------------------------------------------------------------------+
void CControlsDialog::OnChangeComboBox2(void)
  {
   Comment(__FUNCTION__+" \""+m_combo_box.Select()+"\"");
  }